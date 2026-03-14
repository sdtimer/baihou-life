const userStore = require("../../store/user");
const regionStore = require("../../store/region");
const auth = require("../../utils/auth");
const orderService = require("../../services/order");

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
    isDesigner: user.role === 2,
    orderStats: {
      pending: 0,
      paid: 0,
      shipped: 0,
      completed: 0,
      total: 0
    }
  };
 }

Page({
  data: {
    ...buildViewData()
  },

  async onShow() {
    this.setData(buildViewData());
    await this.loadOrderStats();
  },

  async loadOrderStats() {
    if (!userStore.isLoggedIn()) {
      return;
    }
    try {
      const rows = await orderService.listOrders();
      const orderStats = rows.reduce((result, item) => {
        result.total += 1;
        if (item.status === "pending_pay") {
          result.pending += 1;
        } else if (item.status === "paid" || item.status === "processing") {
          result.paid += 1;
        } else if (item.status === "shipped") {
          result.shipped += 1;
        } else if (item.status === "completed") {
          result.completed += 1;
        }
        return result;
      }, {
        pending: 0,
        paid: 0,
        shipped: 0,
        completed: 0,
        total: 0
      });
      this.setData({ orderStats });
    } catch (error) {
      this.setData({
        orderStats: {
          pending: 0,
          paid: 0,
          shipped: 0,
          completed: 0,
          total: 0
        }
      });
    }
  },

  goAuth() {
    wx.navigateTo({ url: "/pages/auth/index" });
  },

  openAppointments() {
    if (!auth.requireLogin({ redirect: "/pages/appointment/list/index" })) {
      return;
    }
    wx.navigateTo({ url: "/pages/appointment/list/index" });
  },

  openOrders() {
    if (!auth.requireLogin({ redirect: "/pages/order/list/index" })) {
      return;
    }
    wx.navigateTo({ url: "/pages/order/list/index" });
  },

  openOrdersByStatus(event) {
    if (!auth.requireLogin({ redirect: "/pages/order/list/index" })) {
      return;
    }
    const { status } = event.currentTarget.dataset;
    wx.navigateTo({ url: `/pages/order/list/index${status ? `?status=${status}` : ""}` });
  },

  openAssets() {
    if (!auth.requireRole(2, {
      redirect: "/pages/profile/index",
      message: "设计师账号可查看素材"
    })) {
      return;
    }
    wx.showToast({
      title: "请先进入具体商品查看素材",
      icon: "none"
    });
    wx.navigateTo({ url: "/pages/product/list/index" });
  }
});
