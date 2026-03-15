const userStore = require("../../store/user");
const regionStore = require("../../store/region");

 function buildViewData() {
  const user = userStore.getState().profile;
  const region = regionStore.getState().current;
  const isLoggedIn = userStore.isLoggedIn();
  const nickname = user.nickname || "";
  return {
    user,
    region,
    isLoggedIn,
    avatarText: isLoggedIn ? (nickname ? nickname.slice(0, 1) : "客") : "B",
    displayName: isLoggedIn ? nickname : "欢迎来到柏厚生活",
    roleText: user.role === 2 ? "设计师" : (isLoggedIn ? "客户" : "游客"),
    authButtonText: isLoggedIn ? "切换身份" : "立即登录",
    isDesigner: user.role === 2
  };
 }

Page({
  data: {
    ...buildViewData()
  },

  onShow() {
    this.setData(buildViewData());
  },

  goAuth() {
    wx.navigateTo({ url: "/pages/auth/index" });
  },

  openAppointments() {
    wx.navigateTo({ url: "/pages/appointment/list/index" });
  },

  openOrders() {
    wx.navigateTo({ url: "/pages/order/list/index" });
  },

  openAssets() {
    wx.navigateTo({ url: "/pages/designer/assets/index?id=10001" });
  }
});
