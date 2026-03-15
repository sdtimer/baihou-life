const productService = require("../../../services/product");
const userStore = require("../../../store/user");
const regionStore = require("../../../store/region");

Page({
  data: {
    product: null,
    isDesigner: userStore.isDesigner(),
    currentRegion: regionStore.getState().current
  },

  async onLoad(options) {
    const region = regionStore.getState().current;
    const response = await productService.getProductDetail(options.id, region.region_id);
    if (!response.data) {
      wx.showToast({ title: "当前区域不可售", icon: "none" });
      return;
    }
    this.setData({
      product: response.data,
      isDesigner: userStore.isDesigner(),
      currentRegion: region
    });
  },

  goLead() {
    const { product } = this.data;
    wx.navigateTo({ url: `/pages/lead/form/index?product_id=${product.id}&name=${encodeURIComponent(product.name)}` });
  },

  goOrder() {
    const { product } = this.data;
    wx.navigateTo({ url: `/pages/order/confirm/index?id=${product.id}` });
  },

  goAssets() {
    const { product } = this.data;
    wx.navigateTo({ url: `/pages/designer/assets/index?id=${product.id}` });
  }
});
