const productService = require("../../../services/product");
const orderService = require("../../../services/order");
const regionStore = require("../../../store/region");

Page({
  data: {
    product: null
  },

  async onLoad(options) {
    const response = await productService.getProductDetail(options.id, regionStore.getState().current.region_id);
    this.setData({ product: response.data });
  },

  async submitOrder() {
    const { product } = this.data;
    if (!product) {
      return;
    }
    const response = await orderService.createOrder({
      product_id: product.id,
      region_id: regionStore.getState().current.region_id
    });
    wx.showToast({ title: "订单已创建", icon: "success" });
    setTimeout(() => {
      wx.navigateTo({ url: `/pages/order/detail/index?id=${response.data.order_id}` });
    }, 500);
  }
});
