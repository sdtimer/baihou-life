const orderService = require("../../../services/order");

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
    rows: []
  },

  async onShow() {
    const response = await orderService.listOrders();
    this.setData({
      rows: response.rows.map((item) => ({ ...item, status_text: statusText[item.status] || item.status }))
    });
  },

  openDetail(event) {
    wx.navigateTo({ url: `/pages/order/detail/index?id=${event.currentTarget.dataset.id}` });
  }
});
