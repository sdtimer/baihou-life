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
    loading: true,
    detail: null
  },

  async onLoad(options) {
    this.appointmentId = options.id;
    if (!auth.requireLogin({ redirect: `/pages/appointment/detail/index?id=${this.appointmentId}` })) {
      return;
    }
    await this.loadDetail();
  },

  async loadDetail() {
    try {
      const detail = await appointmentService.getAppointmentDetail(this.appointmentId);
      this.setData({
        loading: false,
        detail: detail ? {
          ...detail,
          status_text: statusText[detail.status] || detail.status
        } : null
      });
    } catch (error) {
      this.setData({
        loading: false,
        detail: null
      });
      wx.showToast({
        title: error.message || "预约详情加载失败",
        icon: "none"
      });
    }
  }
});
