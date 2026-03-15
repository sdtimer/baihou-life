const productService = require("../../../services/product");
const designerService = require("../../../services/designer");
const userStore = require("../../../store/user");
const regionStore = require("../../../store/region");

Page({
  data: {
    product: null,
    isDesigner: userStore.isDesigner()
  },

  async onLoad(options) {
    const region = regionStore.getState().current;
    const response = await productService.getProductDetail(options.id, region.region_id);
    this.setData({
      product: response.data,
      isDesigner: userStore.isDesigner()
    });
  },

  async downloadAsset(event) {
    if (!this.data.isDesigner) {
      wx.showToast({ title: "仅设计师可下载", icon: "none" });
      return;
    }
    const { mediaId } = event.currentTarget.dataset;
    const response = await designerService.getAssetToken(this.data.product.id, mediaId);
    wx.setClipboardData({
      data: response.data.url,
      success: () => wx.showToast({ title: "链接已复制", icon: "success" })
    });
  }
});
