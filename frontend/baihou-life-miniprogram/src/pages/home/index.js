const configService = require("../../services/config");
const productService = require("../../services/product");
const userStore = require("../../store/user");
const regionStore = require("../../store/region");
const location = require("../../utils/location");

const TAB_CONFIG = {
  category: {
    title: "区域精选",
    subtitle: "Category"
  },
  space: {
    title: "空间推荐",
    subtitle: "Space"
  },
  scene: {
    title: "场景灵感",
    subtitle: "Scene"
  }
};

Page({
  data: {
    currentRegion: regionStore.getState().current,
    regionOptions: [],
    regionLabel: regionStore.getState().current.region_name,
    pickerVisible: false,
    tempPickerValue: "",
    heroProducts: [],
    errorMessage: "",
    categoryTabs: [],
    spaceTabs: [
      { label: "客厅", value: "living_room" },
      { label: "厨房", value: "kitchen" },
      { label: "卫浴", value: "bathroom" },
      { label: "卧室", value: "bedroom" }
    ],
    sceneTabs: [
      { label: "极简", value: "minimalist" },
      { label: "治愈", value: "healing" },
      { label: "侘寂", value: "wabi_sabi" }
    ],
    activeCategoryId: "",
    activeSpace: "living_room",
    activeScene: "minimalist",
    currentTab: "category",
    currentSectionTitle: TAB_CONFIG.category.title,
    currentSectionSubtitle: TAB_CONFIG.category.subtitle,
    isDesigner: userStore.isDesigner()
  },

  onShow() {
    this.setData({
      currentRegion: regionStore.getState().current,
      regionLabel: regionStore.getState().current.region_name,
      isDesigner: userStore.isDesigner()
    });
    this.bootstrap();
  },

  async bootstrap() {
    try {
      const regionResponse = await configService.getRegions();
      const regions = Array.isArray(regionResponse.data)
        ? regionResponse.data
        : Array.isArray(regionResponse.data?.regions)
          ? regionResponse.data.regions
          : Array.isArray(regionResponse.regions)
            ? regionResponse.regions
            : [];
      if (!regions.length) {
        throw new Error("EMPTY_REGIONS");
      }
      regionStore.setRegions(regions);
      if (!regionStore.isInitialized()) {
        const detected = await location.detectRegion(regions);
        location.applyRegion(detected || regions[0]);
      }
      const current = regionStore.getState().current;
      const categoryResponse = await productService.getCategories();
      const categories = (categoryResponse.categories || []).reduce((result, item) => result.concat(item.children || []), []);
      this.setData({
        currentRegion: current,
        regionOptions: regions,
        regionLabel: current.region_name,
        tempPickerValue: current.region_id,
        categoryTabs: categories
      });
      await this.loadHeroProducts();
    } catch (error) {
      this.setData({
        heroProducts: [],
        errorMessage: "首页内容加载失败，请稍后重试。"
      });
    }
  },

  async loadHeroProducts() {
    const query = {
      region_id: this.data.currentRegion.region_id,
      pageNum: 1,
      pageSize: 6
    };
    if (this.data.currentTab === "space") {
      query.space = this.data.activeSpace;
    }
    if (this.data.currentTab === "category" && this.data.activeCategoryId) {
      query.category_id = this.data.activeCategoryId;
    }
    if (this.data.currentTab === "scene") {
      query.scene = this.data.activeScene;
    }
    const productResponse = await productService.listProducts(query);
    const rows = await Promise.all((productResponse.rows || []).map(async (item) => {
      if (item.cover_image) {
        return item;
      }
      try {
        const detail = await productService.getProductDetail(item.id, this.data.currentRegion.region_id);
        return detail ? { ...item, cover_image: detail.cover_image || item.cover_image } : item;
      } catch (error) {
        return item;
      }
    }));
    this.setData({
      heroProducts: rows,
      errorMessage: ""
    });
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
    await this.loadHeroProducts();
  },

  preventMove() {},

  async onTabChange(event) {
    const { tab } = event.currentTarget.dataset;
    const nextMeta = TAB_CONFIG[tab] || TAB_CONFIG.category;
    this.setData({
      currentTab: tab,
      currentSectionTitle: nextMeta.title,
      currentSectionSubtitle: nextMeta.subtitle
    });
    await this.loadHeroProducts();
  },

  async changeScene(event) {
    const { scene } = event.currentTarget.dataset;
    this.setData({
      activeScene: scene
    });
    if (this.data.currentTab === "scene") {
      await this.loadHeroProducts();
    }
  },

  async changeSpace(event) {
    const { space } = event.currentTarget.dataset;
    this.setData({
      activeSpace: space
    });
    if (this.data.currentTab === "space") {
      await this.loadHeroProducts();
    }
  },

  async changeCategory(event) {
    const { categoryId } = event.currentTarget.dataset;
    this.setData({
      activeCategoryId: categoryId || ""
    });
    if (this.data.currentTab === "category") {
      await this.loadHeroProducts();
    }
  },

  goProductList() {
    wx.reLaunch({ url: "/pages/product/list/index" });
  },

  goAppointment() {
    wx.reLaunch({ url: "/pages/appointment/list/index" });
  },

  openDetail(event) {
    const id = event.currentTarget.dataset.id || event.detail.id;
    wx.navigateTo({ url: `/pages/product/detail/index?id=${id}` });
  },

  goAuth() {
    wx.navigateTo({ url: "/pages/auth/index" });
  },

  retry() {
    this.bootstrap();
  }
});
