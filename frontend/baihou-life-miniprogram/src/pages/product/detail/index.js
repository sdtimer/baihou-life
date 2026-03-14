const productService = require("../../../services/product");
const auth = require("../../../utils/auth");
const userStore = require("../../../store/user");
const regionStore = require("../../../store/region");

function buildViewData() {
  const role = userStore.getRole();
  return {
    isLoggedIn: userStore.isLoggedIn(),
    isDesigner: role === 2,
    showGuidePrice: role === 1 || role === 2,
    showDesignerPrice: role === 2,
    currentRegion: regionStore.getState().current
  };
}

Page({
  data: {
    loading: true,
    errorMessage: "",
    unavailable: false,
    product: null,
    ...buildViewData()
  },

  async onLoad(options) {
    this.productId = options.id;
    this.lastRegionId = regionStore.getState().current.region_id;
    await this.loadProduct();
  },

  onShow() {
    const currentRegionId = regionStore.getState().current.region_id;
    this.setData(buildViewData());
    if (this.productId && this.lastRegionId && currentRegionId !== this.lastRegionId) {
      this.lastRegionId = currentRegionId;
      this.loadProduct();
    }
  },

  async loadProduct() {
    const region = regionStore.getState().current;
    this.lastRegionId = region.region_id;
    this.setData({
      loading: true,
      errorMessage: "",
      unavailable: false
    });
    try {
      const product = await productService.getProductDetail(this.productId, region.region_id);
      this.setData({
        loading: false,
        product,
        currentRegion: region,
        unavailable: !product
      });
    } catch (error) {
      this.setData({
        loading: false,
        unavailable: true,
        errorMessage: error.msg || "该商品当前区域暂不可售"
      });
    }
  },

  goLead() {
    const { product } = this.data;
    if (!auth.requireLogin({ redirect: `/pages/product/detail/index?id=${product.id}` })) {
      return;
    }
    wx.navigateTo({ url: `/pages/lead/form/index?product_id=${product.id}&name=${encodeURIComponent(product.name)}` });
  },

  goOrder() {
    const { product } = this.data;
    if (!auth.requireLogin({ redirect: `/pages/product/detail/index?id=${product.id}` })) {
      return;
    }
    wx.navigateTo({ url: `/pages/order/confirm/index?id=${product.id}` });
  },

  goAssets() {
    const { product } = this.data;
    if (!auth.requireRole(2, {
      redirect: `/pages/product/detail/index?id=${product.id}`,
      message: "设计师账号可查看素材"
    })) {
      return;
    }
    wx.navigateTo({ url: `/pages/designer/assets/index?id=${product.id}` });
  }
});
