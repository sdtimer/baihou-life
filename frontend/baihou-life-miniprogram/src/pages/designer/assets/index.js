const productService = require("../../../services/product");
const designerService = require("../../../services/designer");
const auth = require("../../../utils/auth");
const userStore = require("../../../store/user");
const regionStore = require("../../../store/region");

Page({
  data: {
    loading: true,
    product: null,
    errorMessage: "",
    isDesigner: userStore.isDesigner()
  },

  async onLoad(options) {
    this.productId = options.id;
    if (!auth.requireRole(2, {
      redirect: `/pages/designer/assets/index?id=${this.productId}`,
      message: "仅设计师可下载素材"
    })) {
      this.setData({ loading: false });
      return;
    }
    await this.loadProduct();
  },

  onShow() {
    this.setData({
      isDesigner: userStore.isDesigner()
    });
  },

  async loadProduct() {
    const region = regionStore.getState().current;
    try {
      const product = await productService.getProductDetail(this.productId, region.region_id);
      this.setData({
        loading: false,
        product,
        errorMessage: product && product.source_files.length ? "" : "当前商品暂无可下载素材"
      });
    } catch (error) {
      this.setData({
        loading: false,
        errorMessage: error.message || "素材加载失败，请稍后重试"
      });
    }
  },

  async downloadAsset(event) {
    if (!auth.requireRole(2, {
      redirect: `/pages/designer/assets/index?id=${this.productId}`,
      message: "仅设计师可下载"
    })) {
      return;
    }

    const { mediaId } = event.currentTarget.dataset;
    try {
      const response = await designerService.getAssetToken(this.data.product.id, mediaId);
      const assetUrl = response.data.url;

      wx.showLoading({ title: "准备下载中" });
      wx.downloadFile({
        url: assetUrl,
        success: ({ statusCode, tempFilePath }) => {
          wx.hideLoading();
          if (statusCode >= 200 && statusCode < 300 && tempFilePath) {
            wx.openDocument({
              filePath: tempFilePath,
              showMenu: true,
              fail: () => {
                wx.showToast({ title: "已下载，暂不支持直接预览", icon: "none" });
              }
            });
            return;
          }
          this.copyAssetLink(assetUrl);
        },
        fail: () => {
          wx.hideLoading();
          this.copyAssetLink(assetUrl);
        }
      });
    } catch (error) {
      wx.hideLoading();
      wx.showToast({
        title: error.message || "素材链接已失效，请重新获取",
        icon: "none"
      });
    }
  },

  copyAssetLink(url) {
    wx.setClipboardData({
      data: url,
      success: () => wx.showToast({ title: "下载失败，链接已复制", icon: "none" })
    });
  }
});
