const appointmentService = require("../../../services/appointment");

const statusText = {
  pending: "待确认",
  confirmed: "已确认",
  in_progress: "服务中",
  completed: "已完成",
  cancelled: "已取消"
};

Page({
  data: {
    rows: []
  },

  async onShow() {
    const response = await appointmentService.listAppointments();
    this.setData({ rows: response.rows.map((item) => ({ ...item, status_text: statusText[item.status] || item.status })) });
  },

  goCreate() {
    wx.navigateTo({ url: "/pages/appointment/create/index" });
  }
});
