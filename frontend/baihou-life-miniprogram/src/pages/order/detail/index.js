const orderService = require("../../../services/order");
const auth = require("../../../utils/auth");

const statusText = {
  pending_pay: "待支付",
  paid: "已支付",
  processing: "处理中",
  shipped: "已发货",
  completed: "已完成",
  closed: "已关闭"
};

Page({
  data: {
    loading: true,
    paying: false,
    detail: null,
    statusBarHeight: 20
  },

  async onLoad(options) {
    this.orderId = options.id;
    const { statusBarHeight } = wx.getSystemInfoSync();
    this.setData({
      statusBarHeight: statusBarHeight || 20
    });
    if (!auth.requireLogin({ redirect: `/pages/order/detail/index?id=${this.orderId}` })) {
      return;
    }
    await this.loadDetail();
  },

  async loadDetail() {
    try {
      const detail = await orderService.getOrderDetail(this.orderId);
      this.setData({
        loading: false,
        detail: detail ? { ...detail, status_text: statusText[detail.status] || detail.status } : null
      });
    } catch (error) {
      this.setData({
        loading: false,
        detail: null
      });
      wx.showToast({
        title: error.msg || "订单详情加载失败",
        icon: "none"
      });
    }
  },

  async payNow() {
    if (!this.data.detail || this.data.paying) {
      return;
    }
    this.setData({ paying: true });
    try {
      const prepay = await orderService.prepayOrder(this.orderId);
      await orderService.requestPayment(prepay.payment);
      await orderService.markOrderPaid(this.orderId);
      wx.showToast({ title: "支付成功", icon: "success" });
      await this.loadDetail();
    } catch (error) {
      wx.showToast({
        title: error.code === "PAY_CANCELLED"
          ? "已取消支付，订单仍待支付"
          : (error.code === "PAY_FAILED" ? "支付失败，请稍后重试" : (error.msg || "支付失败")),
        icon: "none"
      });
    } finally {
      this.setData({ paying: false });
    }
  },

  goBack() {
    wx.navigateBack({
      fail: () => {
        wx.reLaunch({ url: "/pages/order/list/index" });
      }
    });
  }
});
