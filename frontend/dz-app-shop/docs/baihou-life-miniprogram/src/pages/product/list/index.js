const productService = require("../../../services/product");
const regionStore = require("../../../store/region");
const userStore = require("../../../store/user");

Page({
  data: {
    loading: true,
    errorMessage: "",
    products: [],
    categories: [],
    spaces: [],
    scenes: [],
    filters: {
      keyword: "",
      category_id: "",
      space: "",
      scene: ""
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

  async bootstrap() {
    this.setData({ loading: true });
    try {
      const [categoryResponse, productResponse] = await Promise.all([
        productService.getCategories(),
        productService.listProducts({
          region_id: regionStore.getState().current.region_id
        })
      ]);

      this.setData({
        loading: false,
        errorMessage: "",
        categories: categoryResponse.data.categories.reduce((result, item) => result.concat(item.children || []), []),
        spaces: categoryResponse.data.spaces,
        scenes: categoryResponse.data.scenes,
        products: productResponse.rows
      });
    } catch (error) {
      this.setData({
        loading: false,
        errorMessage: "当前区域产品加载失败，请稍后重试。"
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
      [`filters.${field}`]: nextValue,
      loading: true
    });

    const response = await productService.listProducts({
      region_id: this.data.currentRegion.region_id,
      ...this.data.filters,
      [field]: nextValue
    });

    this.setData({
      loading: false,
      products: response.rows
    });
  },

  async handleSearch() {
    this.setData({ loading: true });
    const response = await productService.listProducts({
      region_id: this.data.currentRegion.region_id,
      ...this.data.filters
    });
    this.setData({
      loading: false,
      products: response.rows
    });
  },

  openDetail(event) {
    wx.navigateTo({
      url: `/pages/product/detail/index?id=${event.detail.id}`
    });
  }
});
