const configService = require("../../services/config");
const productService = require("../../services/product");
const userStore = require("../../store/user");
const regionStore = require("../../store/region");
const location = require("../../utils/location");
const navigation = require("../../utils/navigation");
const auth = require("../../utils/auth");

const FEED_PAGE_SIZE = 8;

function splitFeedRows(rows = []) {
  return rows.reduce((result, item, index) => {
    if (index % 2 === 0) {
      result.left.push(item);
    } else {
      result.right.push(item);
    }
    return result;
  }, {
    left: [],
    right: []
  });
}

Page({
  data: {
    currentRegion: regionStore.getState().current,
    regionOptions: [],
    regionLabel: regionStore.getState().current.region_name,
    pickerVisible: false,
    tempPickerValue: "",
    feedLeft: [],
    feedRight: [],
    searchKeyword: "",
    errorMessage: "",
    loading: true,
    isDesigner: userStore.isDesigner(),
    isLoggedIn: userStore.isLoggedIn()
  },

  onShow() {
    this.setData({
      currentRegion: regionStore.getState().current,
      regionLabel: regionStore.getState().current.region_name,
      isDesigner: userStore.isDesigner(),
      isLoggedIn: userStore.isLoggedIn()
    });
    this.bootstrap();
  },

  async bootstrap() {
    try {
      const { current, regions } = await this.ensureRegions();
      const prefetched = getApp().globalData.homePrefetch;
      if (!regions.length) {
        throw new Error("EMPTY_REGIONS");
      }
      this.setData({
        currentRegion: current,
        regionOptions: regions,
        regionLabel: current.region_name,
        tempPickerValue: current.region_id
      });

      if (prefetched && prefetched.region_id === current.region_id && Array.isArray(prefetched.rows) && prefetched.rows.length) {
        this.applyFeed(prefetched.rows);
      }

      await this.loadFeed({ silent: Boolean(prefetched && prefetched.region_id === current.region_id) });
    } catch (error) {
      this.setData({
        feedLeft: [],
        feedRight: [],
        loading: false,
        errorMessage: "首页内容加载失败，请稍后重试。"
      });
    }
  },

  async ensureRegions() {
    const regionResponse = await configService.getRegions();
    const regions = Array.isArray(regionResponse.data)
      ? regionResponse.data
      : Array.isArray(regionResponse.data?.regions)
        ? regionResponse.data.regions
        : Array.isArray(regionResponse.regions)
          ? regionResponse.regions
          : [];
    regionStore.setRegions(regions);
    if (!regionStore.isInitialized()) {
      const detected = await location.detectRegion(regions);
      location.applyRegion(detected || regions[0]);
    } else if (!regionStore.getState().current.region_id && regions.length) {
      regionStore.setCurrent(regions[0]);
    }
    return {
      current: regionStore.getState().current,
      regions
    };
  },

  applyFeed(rows = []) {
    const columns = splitFeedRows(rows);
    this.setData({
      feedLeft: columns.left,
      feedRight: columns.right,
      loading: false,
      errorMessage: ""
    });
  },

  async loadFeed({ silent = false } = {}) {
    if (!silent) {
      this.setData({ loading: true });
    }
    const response = await productService.getFeed({
      region_id: this.data.currentRegion.region_id,
      pageNum: 1,
      pageSize: FEED_PAGE_SIZE
    });
    const rows = response.rows || [];
    getApp().globalData.homePrefetch = {
      region_id: this.data.currentRegion.region_id,
      rows,
      ts: Date.now()
    };
    this.applyFeed(rows);
  },

  showRegionPicker() {
    this.setData({
      pickerVisible: true,
      tempPickerValue: this.data.currentRegion.region_id
    });
  },

  closePicker() {
    this.setData({ pickerVisible: false });
  },

  selectPickerOption(event) {
    this.setData({
      tempPickerValue: event.currentTarget.dataset.value
    });
  },

  async confirmPicker() {
    const nextRegion = this.data.regionOptions.find((item) => item.region_id === this.data.tempPickerValue);
    if (!nextRegion) {
      this.setData({ pickerVisible: false });
      return;
    }
    regionStore.setCurrent(nextRegion);
    this.setData({
      currentRegion: nextRegion,
      regionLabel: nextRegion.region_name,
      pickerVisible: false
    });
    await this.loadFeed();
  },

  preventMove() {},

  bindSearchKeyword(event) {
    this.setData({
      searchKeyword: event.detail.value
    });
  },

  goProductList() {
    const params = this.data.searchKeyword ? { keyword: this.data.searchKeyword } : {};
    navigation.navigate("/pages/product/list/index", { params });
  },

  goAppointment() {
    navigation.navigate("/pages/appointment/list/index");
  },

  openDesignerEntry() {
    if (!auth.requireRole(2, {
      redirect: "/pages/home/index",
      message: "设计师账号可查看高清素材与专属能力"
    })) {
      return;
    }
    navigation.navigate("/pages/designer/assets/index");
  },

  openDetail(event) {
    const id = event.currentTarget.dataset.id || event.detail.id;
    navigation.navigate(`/pages/product/detail/index?id=${id}`);
  },

  goAuth() {
    navigation.navigate("/pages/auth/index");
  },

  openSearch() {
    this.goProductList();
  },

  retry() {
    this.bootstrap();
  }
});
