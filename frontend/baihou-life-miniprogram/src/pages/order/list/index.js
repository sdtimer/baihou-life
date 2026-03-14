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
    rows: [],
    loading: true
  },

  async onShow() {
    if (!auth.requireLogin({ redirect: "/pages/order/list/index" })) {
      return;
    }
    this.setData({ loading: true });
    try {
      const rows = await orderService.listOrders();
      this.setData({
        loading: false,
        rows: rows.map((item) => ({ ...item, status_text: statusText[item.status] || item.status }))
      });
    } catch (error) {
      this.setData({
        loading: false,
        rows: []
      });
      wx.showToast({
        title: error.msg || "订单加载失败",
        icon: "none"
      });
    }
  },

  openDetail(event) {
    wx.navigateTo({ url: `/pages/order/detail/index?id=${event.currentTarget.dataset.id}` });
  }
});
