Page({
  data: {
    productId: '',
    product: null,
    statusBarHeight: 20
  },

  onLoad(options) {
    const { statusBarHeight } = wx.getSystemInfoSync();
    this.setData({
      productId: options.id || '',
      statusBarHeight: statusBarHeight || 20
    });
    this.loadProduct();
  },

  loadProduct() {
    const mockProduct = {
      id: this.data.productId || '1',
      name: 'TOTO 浴室柜 800mm',
      desc: '暖木色与石材结合的浴室空间主角，适用于现代全案场景',
      price: '1,088',
      originalPrice: '1,280',
      category: '洁具',
      isDesigner: true,
      images: [
        'https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=800&h=800&fit=crop',
        'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=800&h=800&fit=crop',
        'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800&h=800&fit=crop'
      ],
      specs: [
        { label: '品牌', value: 'TOTO' },
        { label: '材质', value: '岩板台面 + 实木柜体' },
        { label: '尺寸', value: '800 x 520 x 860 mm' },
        { label: '颜色', value: '暖木色' },
        { label: '交付周期', value: '15-20 天' },
        { label: '服务区域', value: '全国配送' }
      ],
      detail: '这款浴室柜采用进口岩板台面，搭配精选实木柜体，既有石材的质感又有木材的温度。设计简约大方，适合现代简约、北欧等多种风格。大容量储物空间，满足日常收纳需求。'
    };
    this.setData({ product: mockProduct });
  },

  goBack() {
    wx.navigateBack({
      fail: () => {
        wx.switchTab({ url: '/pages/index/index' });
      }
    });
  },

  onConsult() {
    const { productId, product } = this.data;
    wx.navigateTo({
      url: `/pages/lead/lead?id=${productId}&name=${encodeURIComponent(product?.name || '')}`
    });
  },

  onOrder() {
    const { productId } = this.data;
    wx.navigateTo({
      url: `/pages/order-create/order-create?id=${productId}`
    });
  }
});