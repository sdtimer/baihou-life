Page({
  data: {
    productId: '',
    productName: '',
    statusBarHeight: 20,
    navBarHeight: 44,
    navBarTotalHeight: 64,
    regionOptions: [
      { label: '杭州', value: 'hangzhou' },
      { label: '上海', value: 'shanghai' },
      { label: '北京', value: 'beijing' },
      { label: '深圳', value: 'shenzhen' },
      { label: '广州', value: 'guangzhou' }
    ],
    form: {
      name: '',
      phone: '',
      region: '',
      content: ''
    }
  },

  onLoad(options) {
    const { statusBarHeight } = wx.getSystemInfoSync();
    const menuButton = wx.getMenuButtonBoundingClientRect();
    const navBarHeight = (menuButton.top - statusBarHeight) * 2 + menuButton.height;
    const navBarTotalHeight = statusBarHeight + navBarHeight;
    
    this.setData({
      productId: options.id || '',
      productName: options.name ? decodeURIComponent(options.name) : '',
      statusBarHeight: statusBarHeight || 20,
      navBarHeight: navBarHeight || 44,
      navBarTotalHeight: navBarTotalHeight || 64
    });
  },

  goBack() {
    wx.navigateBack();
  },

  onInput(e) {
    const { field } = e.currentTarget.dataset;
    this.setData({
      [`form.${field}`]: e.detail.value
    });
  },

  onRegionChange(e) {
    this.setData({
      'form.region': e.detail.value
    });
  },

  onSubmit() {
    const { form } = this.data;
    
    if (!form.name) {
      wx.showToast({ title: '请输入姓名', icon: 'none' });
      return;
    }
    if (!form.phone) {
      wx.showToast({ title: '请输入手机号', icon: 'none' });
      return;
    }
    if (!/^1[3-9]\d{9}$/.test(form.phone)) {
      wx.showToast({ title: '请输入正确的手机号', icon: 'none' });
      return;
    }

    wx.showToast({ title: '提交成功', icon: 'success' });
    setTimeout(() => {
      wx.navigateBack();
    }, 1500);
  }
});