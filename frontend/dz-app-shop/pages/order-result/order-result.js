Page({
  data: {
    orderId: '',
    status: 'success',
    totalPrice: '0.00'
  },

  onLoad(options) {
    this.setData({
      orderId: options.orderId || '',
      status: options.status || 'success',
      totalPrice: options.totalPrice || '0.00'
    });
  },

  goHome() {
    wx.switchTab({
      url: '/pages/index/index'
    });
  },

  goOrder() {
    wx.switchTab({
      url: '/pages/order/order'
    });
  }
});