Page({
  data: {
    statusBarHeight: 20,
    navBarHeight: 64,
    productId: '',
    product: null,
    quantity: 1,
    address: null,
    remark: '',
    showRemark: false,
    freight: 0,
    discount: 0,
    totalPrice: '0.00'
  },

  onLoad(options) {
    const { statusBarHeight } = wx.getSystemInfoSync();
    this.setData({
      productId: options.id || '',
      statusBarHeight: statusBarHeight || 20,
      navBarHeight: (statusBarHeight || 20) + 56
    });
    this.loadProduct();
    this.loadAddress();
  },

  loadProduct() {
    const mockProduct = {
      id: this.data.productId || '1',
      name: 'TOTO 浴室柜 800mm',
      desc: '暖木色与石材结合',
      spec: '暖木色 / 800mm',
      price: '1,088.00',
      image: 'https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=400&h=300&fit=crop'
    };
    this.setData({ product: mockProduct }, this.calculateTotal);
  },

  loadAddress() {
    const mockAddress = {
      id: '1',
      name: '张先生',
      phone: '138****8888',
      province: '浙江省',
      city: '杭州市',
      district: '西湖区',
      detail: '文三路 123 号柏厚大厦 808 室',
      isDefault: true
    };
    this.setData({ address: mockAddress });
  },

  calculateTotal() {
    const { product, quantity, freight, discount } = this.data;
    if (!product) return;
    const price = parseFloat(product.price.replace(/,/g, '')) || 0;
    const total = price * quantity + freight - discount;
    this.setData({
      totalPrice: total.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',')
    });
  },

  goBack() {
    wx.navigateBack();
  },

  selectAddress() {
    wx.showToast({ title: '地址选择功能开发中', icon: 'none' });
  },

  showRemarkPopup() {
    this.setData({ showRemark: true });
  },

  hideRemarkPopup() {
    this.setData({ showRemark: false });
  },

  onRemarkInput(e) {
    this.setData({ remark: e.detail.value });
  },

  confirmRemark() {
    this.hideRemarkPopup();
  },

  submitOrder() {
    const { address, product, quantity, remark, totalPrice } = this.data;
    
    if (!address) {
      wx.showToast({ title: '请选择收货地址', icon: 'none' });
      return;
    }

    wx.showLoading({ title: '提交中...' });

    setTimeout(() => {
      wx.hideLoading();
      const orderId = 'BH' + Date.now();
      wx.redirectTo({
        url: `/pages/order-result/order-result?orderId=${orderId}&status=success&totalPrice=${totalPrice}`
      });
    }, 1500);
  }
});