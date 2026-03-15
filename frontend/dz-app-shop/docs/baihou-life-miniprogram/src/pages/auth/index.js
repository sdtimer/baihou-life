const authService = require("../../services/auth");
const userStore = require("../../store/user");
const regionStore = require("../../store/region");

Page({
  data: {
    loading: false,
    benefits: [
      "客户可查看指导价并提交留资、预约与订单",
      "设计师可查看折扣价并下载素材原文件",
      "登录后自动保留当前区域与浏览链路"
    ]
  },

  async login() {
    this.setData({ loading: true });
    try {
      const response = await authService.login();
      userStore.setAuth(response.data);
      if (response.data.user.region_id && !regionStore.getState().current.region_id) {
        regionStore.setCurrent({
          region_id: response.data.user.region_id,
          region_name: "佛山",
          province: "广东"
        });
      }
      wx.showToast({ title: "登录成功", icon: "success" });
      setTimeout(() => wx.navigateBack(), 400);
    } finally {
      this.setData({ loading: false });
    }
  }
});
