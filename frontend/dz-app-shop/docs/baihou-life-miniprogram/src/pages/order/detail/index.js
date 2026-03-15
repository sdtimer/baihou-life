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
    detail: null
  },

  async onLoad(options) {
    const response = await orderService.getOrderDetail(options.id);
    this.setData({
      detail: response.data ? { ...response.data, status_text: statusText[response.data.status] || response.data.status } : null
    });
  }
});
