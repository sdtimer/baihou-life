const authService = require("../../services/auth");
const userStore = require("../../store/user");
const regionStore = require("../../store/region");

Page({
  data: {
    loading: false,
    redirect: "",
    benefits: [
      "客户可查看指导价并提交留资、预约与订单",
      "设计师可查看折扣价并下载素材原文件",
      "登录后自动保留当前区域与浏览链路"
    ]
  },

  onLoad(options) {
    this.setData({
      redirect: options.redirect ? decodeURIComponent(options.redirect) : ""
    });
  },

  async login() {
    this.setData({ loading: true });
    try {
      const response = await authService.login();
      userStore.setAuth(response.data);
      const userRegionId = response.data.user.region_id;
      if (userRegionId) {
        const regions = regionStore.getState().regions || [];
        const matchedRegion = regions.find((item) => item.region_id === userRegionId);
        regionStore.setCurrent({
          region_id: userRegionId,
          region_name: matchedRegion?.region_name || regionStore.getState().current.region_name || "佛山",
          province: matchedRegion?.province || regionStore.getState().current.province || "广东"
        });
      }
      wx.showToast({ title: "登录成功", icon: "success" });
      setTimeout(() => {
        if (this.data.redirect) {
          wx.redirectTo({ url: this.data.redirect });
          return;
        }
        const pages = getCurrentPages();
        if (pages.length > 1) {
          wx.navigateBack();
          return;
        }
        wx.reLaunch({ url: "/pages/profile/index" });
      }, 400);
    } catch (error) {
      wx.showToast({
        title: error.msg || "登录失败，请稍后重试",
        icon: "none"
      });
    } finally {
      this.setData({ loading: false });
    }
  }
});
