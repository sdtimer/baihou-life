const productService = require("../../../services/product");
const orderService = require("../../../services/order");
const auth = require("../../../utils/auth");
const regionStore = require("../../../store/region");

Page({
  data: {
    loading: true,
    submitting: false,
    product: null
  },

  async onLoad(options) {
    this.productId = options.id;
    if (!auth.requireLogin({ redirect: `/pages/order/confirm/index?id=${this.productId}` })) {
      return;
    }
    await this.loadProduct();
  },

  async loadProduct() {
    try {
      const product = await productService.getProductDetail(this.productId, regionStore.getState().current.region_id);
      this.setData({
        loading: false,
        product
      });
    } catch (error) {
      this.setData({
        loading: false,
        product: null
      });
      wx.showToast({
        title: error.message || "商品加载失败",
        icon: "none"
      });
    }
  },

  async submitOrder() {
    const { product } = this.data;
    if (!product || this.data.submitting) {
      return;
    }

    this.setData({ submitting: true });
    let createdOrder = null;
    try {
      createdOrder = await orderService.createOrder({
        product_id: product.id,
        region_id: regionStore.getState().current.region_id
      });
      const prepay = await orderService.prepayOrder(createdOrder.order_id);
      await orderService.requestPayment(prepay.payment);
      await orderService.markOrderPaid(createdOrder.order_id);
      wx.showToast({ title: "支付成功", icon: "success" });
      setTimeout(() => {
        wx.redirectTo({ url: `/pages/order/detail/index?id=${createdOrder.order_id}` });
      }, 400);
    } catch (error) {
      const message = error.code === "PAY_CANCELLED"
        ? "已取消支付，订单保留待支付状态"
        : (error.code === "PAY_FAILED" ? "支付失败，请稍后重试" : (error.message || "下单失败，请稍后重试"));
      wx.showToast({
        title: message,
        icon: "none"
      });
      if (createdOrder && createdOrder.order_id && (error.code === "PAY_CANCELLED" || error.code === "PAY_FAILED")) {
        setTimeout(() => {
          wx.redirectTo({ url: `/pages/order/detail/index?id=${createdOrder.order_id}` });
        }, 500);
      }
    } finally {
      this.setData({ submitting: false });
    }
  }
});
