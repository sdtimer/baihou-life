const configService = require("../../../services/config");
const productService = require("../../../services/product");
const regionStore = require("../../../store/region");
const userStore = require("../../../store/user");
const navigation = require("../../../utils/navigation");

const DEFAULT_FILTERS = {
  keyword: "",
  category_id: "",
  space: "",
  scene: "",
  sort_by: ""
};

const SORT_OPTIONS = [
  { label: "推荐", value: "" },
  { label: "价格升序", value: "price_asc" },
  { label: "价格降序", value: "price_desc" }
];

const SPACE_OPTIONS = [
  { label: "客厅", value: "living_room" },
  { label: "厨房", value: "kitchen" },
  { label: "卫浴", value: "bathroom" },
  { label: "卧室", value: "bedroom" }
];

const PRODUCT_LIST_PATH = "/pages/product/list/index";

function resolveCurrentTab(filters = {}) {
  if (filters.scene) {
    return "scene";
  }
  if (filters.space) {
    return "space";
  }
  return "category";
}

function resolveSubTabIndex(tab, filters, tabs = {}) {
  if (tab === "category") {
    return tabs.categoryTabs.findIndex((item) => String(item.value || "") === String(filters.category_id || ""));
  }
  if (tab === "space") {
    return tabs.spaceTabs.findIndex((item) => String(item.value || "") === String(filters.space || ""));
  }
  return tabs.sceneTabs.findIndex((item) => String(item.value || "") === String(filters.scene || ""));
}

Page({
  data: {
    currentTab: "category",
    currentSubTab: 0,
    regionLabel: regionStore.getState().current.region_name,
    regionOptions: regionStore.getState().regions || [],
    tempRegion: regionStore.getState().current.region_id,
    showAreaPicker: false,
    loading: true,
    loadingMore: false,
    errorMessage: "",
    products: [],
    categories: [],
    spaces: [],
    scenes: [],
    categoryTabs: [{ label: "全部", value: "" }],
    spaceTabs: [{ label: "全部", value: "" }],
    sceneTabs: [{ label: "全部", value: "" }],
    sortOptions: SORT_OPTIONS,
    filters: { ...DEFAULT_FILTERS },
    pagination: {
      pageNum: 1,
      pageSize: 10,
      total: 0,
      hasMore: true
    },
    currentRegion: regionStore.getState().current,
    isDesigner: userStore.isDesigner()
  },

  onShow() {
    this.pendingRedirectState = navigation.consumeTabRedirectState(PRODUCT_LIST_PATH) || null;
    this.setData({
      currentRegion: regionStore.getState().current,
      regionLabel: regionStore.getState().current.region_name,
      regionOptions: regionStore.getState().regions || [],
      tempRegion: regionStore.getState().current.region_id,
      isDesigner: userStore.isDesigner()
    });
    this.bootstrap();
  },

  onReachBottom() {
    if (!this.data.loading && !this.data.loadingMore && this.data.pagination.hasMore) {
      this.fetchProducts({ append: true });
    }
  },

  async bootstrap() {
    this.setData({
      loading: true,
      errorMessage: "",
      products: [],
      pagination: {
        pageNum: 1,
        pageSize: 10,
        total: 0,
        hasMore: true
      }
    });

    try {
      const regionResponse = await configService.getRegions();
      const regions = regionResponse.data ? regionResponse.data.regions : regionResponse.regions;
      regionStore.setRegions(regions);
      if (!this.data.currentRegion.region_id && regions.length) {
        regionStore.setCurrent(regions[0]);
      }
      const currentRegion = regionStore.getState().current;
      const categoryResponse = await productService.getCategories();
      const categories = (categoryResponse.categories || []).reduce((result, item) => result.concat(item.children || []), []);
      const spaces = SPACE_OPTIONS;
      const scenes = categoryResponse.scenes || [];
      const categoryTabs = [{ label: "全部", value: "" }].concat(
        categories.map((item) => ({ label: item.category_name, value: item.category_id }))
      );
      const spaceTabs = [{ label: "全部", value: "" }].concat(
        spaces.map((item) => ({ label: item.label, value: item.value }))
      );
      const sceneTabs = [{ label: "全部", value: "" }].concat(
        scenes.map((item) => ({ label: item.label, value: item.value }))
      );
      const nextFilters = {
        ...DEFAULT_FILTERS,
        ...(this.pendingRedirectState || {})
      };
      const currentTab = resolveCurrentTab(nextFilters);
      const currentSubTab = Math.max(0, resolveSubTabIndex(currentTab, nextFilters, {
        categoryTabs,
        spaceTabs,
        sceneTabs
      }));
      this.setData({
        currentRegion,
        regionLabel: currentRegion.region_name,
        categories,
        spaces,
        scenes,
        regionOptions: regions || [],
        categoryTabs,
        spaceTabs,
        sceneTabs,
        currentTab,
        currentSubTab,
        filters: nextFilters
      });
      this.pendingRedirectState = null;
      await this.fetchProducts({ reset: true });
    } catch (error) {
      this.setData({
        loading: false,
        errorMessage: error.message || "当前区域产品加载失败，请稍后重试。"
      });
    }
  },

  async fetchProducts({ reset = false, append = false } = {}) {
    const currentPage = reset ? 1 : this.data.pagination.pageNum + (append ? 1 : 0);
    this.setData({
      loading: !append,
      loadingMore: append
    });

    try {
      const response = await productService.listProducts({
        region_id: this.data.currentRegion.region_id,
        ...this.data.filters,
        pageNum: currentPage,
        pageSize: this.data.pagination.pageSize
      });

      this.setData({
        loading: false,
        loadingMore: false,
        errorMessage: "",
        products: append ? this.data.products.concat(response.rows) : response.rows,
        pagination: {
          pageNum: response.pageNum,
          pageSize: response.pageSize,
          total: response.total,
          hasMore: response.hasMore
        }
      });
    } catch (error) {
      this.setData({
        loading: false,
        loadingMore: false,
        errorMessage: error.message || "筛选结果加载失败，请稍后重试。"
      });
    }
  },

  bindKeyword(event) {
    this.setData({
      "filters.keyword": event.detail.value
    });
  },

  async activateFilter(event) {
    const { field, value } = event.currentTarget.dataset;
    const nextValue = this.data.filters[field] === value ? "" : value;
    this.setData({
      [`filters.${field}`]: nextValue
    });
    await this.fetchProducts({ reset: true });
  },

  async handleSearch() {
    await this.fetchProducts({ reset: true });
  },

  onTabChange(event) {
    const { tab } = event.currentTarget.dataset;
    this.setData({
      currentTab: tab,
      currentSubTab: 0
    });
    const nextFilters = { ...this.data.filters };
    if (tab !== "category") {
      nextFilters.category_id = "";
    }
    if (tab !== "space") {
      nextFilters.space = "";
    }
    if (tab !== "scene") {
      nextFilters.scene = "";
    }
    this.setData({ filters: nextFilters });
    this.fetchProducts({ reset: true });
  },

  onSubTabChange(event) {
    const { index } = event.currentTarget.dataset;
    const nextFilters = { ...this.data.filters };
    if (this.data.currentTab === "category") {
      nextFilters.category_id = this.data.categoryTabs[index] ? this.data.categoryTabs[index].value : "";
    }
    if (this.data.currentTab === "space") {
      nextFilters.space = this.data.spaceTabs[index] ? this.data.spaceTabs[index].value : "";
    }
    if (this.data.currentTab === "scene") {
      nextFilters.scene = this.data.sceneTabs[index] ? this.data.sceneTabs[index].value : "";
    }
    this.setData({
      currentSubTab: index,
      filters: nextFilters
    });
    this.fetchProducts({ reset: true });
  },

  showAreaPicker() {
    this.setData({
      showAreaPicker: true,
      tempRegion: this.data.currentRegion.region_id
    });
  },

  hideAreaPicker() {
    this.setData({ showAreaPicker: false });
  },

  selectArea(event) {
    this.setData({
      tempRegion: event.currentTarget.dataset.value
    });
  },

  confirmArea() {
    const nextRegion = (this.data.regionOptions || []).find((item) => item.region_id === this.data.tempRegion);
    if (!nextRegion) {
      this.setData({ showAreaPicker: false });
      return;
    }
    regionStore.setCurrent(nextRegion);
    this.setData({
      currentRegion: nextRegion,
      regionLabel: nextRegion.region_name,
      showAreaPicker: false
    });
    this.fetchProducts({ reset: true });
  },

  preventMove() {},

  resetFilters() {
    this.setData({
      filters: { ...DEFAULT_FILTERS },
      currentSubTab: 0
    });
    this.fetchProducts({ reset: true });
  },

  openDetail(event) {
    const id = event.currentTarget.dataset.id || event.detail.id;
    navigation.navigate(`/pages/product/detail/index?id=${id}`);
  }
});
