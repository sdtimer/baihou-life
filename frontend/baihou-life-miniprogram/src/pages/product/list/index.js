const productService = require("../../../services/product");
const regionStore = require("../../../store/region");
const userStore = require("../../../store/user");

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

Page({
  data: {
    loading: true,
    loadingMore: false,
    errorMessage: "",
    products: [],
    categories: [],
    spaces: [],
    scenes: [],
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
    this.setData({
      currentRegion: regionStore.getState().current,
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
      const categoryResponse = await productService.getCategories();
      this.setData({
        categories: (categoryResponse.categories || []).reduce((result, item) => result.concat(item.children || []), []),
        spaces: categoryResponse.spaces || [],
        scenes: categoryResponse.scenes || []
      });
      await this.fetchProducts({ reset: true });
    } catch (error) {
      this.setData({
        loading: false,
        errorMessage: error.msg || "当前区域产品加载失败，请稍后重试。"
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
        errorMessage: error.msg || "筛选结果加载失败，请稍后重试。"
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

  resetFilters() {
    this.setData({
      filters: { ...DEFAULT_FILTERS }
    });
    this.fetchProducts({ reset: true });
  },

  openDetail(event) {
    wx.navigateTo({
      url: `/pages/product/detail/index?id=${event.detail.id}`
    });
  }
});
