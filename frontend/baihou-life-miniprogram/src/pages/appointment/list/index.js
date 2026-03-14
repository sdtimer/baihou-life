const appointmentService = require("../../../services/appointment");
const auth = require("../../../utils/auth");

const statusText = {
  pending: "待确认",
  confirmed: "已确认",
  in_progress: "服务中",
  completed: "已完成",
  cancelled: "已取消"
};

Page({
  data: {
    rows: [],
    loading: true
  },

  async onShow() {
    if (!auth.requireLogin({ redirect: "/pages/appointment/list/index" })) {
      return;
    }
    this.setData({ loading: true });
    try {
      const rows = await appointmentService.listAppointments();
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
        title: error.msg || "预约记录加载失败",
        icon: "none"
      });
    }
  },

  goCreate() {
    wx.navigateTo({ url: "/pages/appointment/create/index" });
  },

  openDetail(event) {
    wx.navigateTo({ url: `/pages/appointment/detail/index?id=${event.currentTarget.dataset.id}` });
  }
});
