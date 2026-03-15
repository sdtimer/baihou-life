Page({
  data: {
    statusBarHeight: 20,
    navBarHeight: 64,
    userInfo: {
      avatar: 'https://picsum.photos/200/200?random=user',
      name: '用户昵称',
      level: '普通会员'
    },
    orderStats: {
      pending: 1,
      paid: 1,
      shipped: 1,
      completed: 2,
      total: 5
    }
  },

  onLoad() {
    const { statusBarHeight } = wx.getSystemInfoSync();
    const navBarHeight = (statusBarHeight || 20) + 44;
    this.setData({
      statusBarHeight: statusBarHeight || 20,
      navBarHeight: navBarHeight
    });
  },

  onShow() {
    this.loadOrderStats();
  },

  loadOrderStats() {
    const stats = {
      pending: 1,
      paid: 1,
      shipped: 1,
      completed: 2,
      total: 5
    };
    this.setData({ orderStats: stats });
  },

  goProfile() {
    wx.showToast({ title: '个人资料', icon: 'none' });
  },

  goSetting() {
    wx.showToast({ title: '设置', icon: 'none' });
  },

  goOrder(e) {
    const { status } = e.currentTarget.dataset;
    wx.switchTab({ url: '/pages/order/order' });
  },

  goAppointment() {
    wx.navigateTo({ url: '/pages/appointment-list/appointment-list' });
  },

  goLead() {
    wx.navigateTo({ url: '/pages/lead/lead' });
  },

  goFavorite() {
    wx.showToast({ title: '我的收藏', icon: 'none' });
  },

  goAddress() {
    wx.showToast({ title: '收货地址', icon: 'none' });
  },

  contactService() {
    wx.makePhoneCall({
      phoneNumber: '400-888-8888'
    });
  },

  goDesigner() {
    wx.showToast({ title: '成为设计师', icon: 'none' });
  }
});