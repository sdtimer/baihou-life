Page({
  data: {
    statusBarHeight: 20,
    navBarHeight: 64,
    contentTop: 0,
    currentTab: 'category',
    currentRegion: 'all',
    tempRegion: 'all',
    showAreaPicker: false,
    regionOptions: [
      { label: '全部', value: 'all' },
      { label: '成都', value: 'hangzhou' },
      { label: '佛山', value: 'shanghai' }
    ],
    regionLabel: '全部',
    categoryTabs: ['全部', '主材', '软装', '卫浴', '家电', '辅材', '五金', '瓷砖', '木地板', '洁具', '橱柜'],
    spaceTabs: ['全部', '玄关', '客餐', '卧室', '书房', '阳台', '厨卫', '衣帽间'],
    sceneTabs: ['全部', '亲子', '收纳', '极简', '治愈', '休闲', '办公', '养老'],
    currentSubTab: 0,
    categoryProducts: [
      { id: 1, name: 'TOTO 浴室柜', spec: '暖木色 / 800mm', price: '1,088', originalPrice: '1,280', image: 'https://picsum.photos/400/400?random=1', isDesigner: true },
      { id: 2, name: '岩板岛台组合', spec: '储物与社交一体', price: '14,280', originalPrice: '16,800', image: 'https://picsum.photos/400/400?random=2', isDesigner: true },
      { id: 3, name: '定制衣柜系列', spec: '多层实木板材', price: '8,999', originalPrice: '12,999', image: 'https://picsum.photos/400/400?random=3', isDesigner: false },
      { id: 4, name: '实木餐桌', spec: '胡桃木 / 1.6m', price: '6,880', originalPrice: '8,880', image: 'https://picsum.photos/400/400?random=4', isDesigner: true },
      { id: 13, name: '智能马桶', spec: '全自动冲洗', price: '4,580', originalPrice: '5,980', image: 'https://picsum.photos/400/400?random=13', isDesigner: true },
      { id: 14, name: '全屋定制柜', spec: 'E0级环保板材', price: '18,800', originalPrice: '25,800', image: 'https://picsum.photos/400/400?random=14', isDesigner: false },
      { id: 15, name: '进口瓷砖', spec: '意大利进口', price: '380', originalPrice: '480', image: 'https://picsum.photos/400/400?random=15', isDesigner: true },
      { id: 16, name: '实木地板', spec: '橡木原木', price: '568', originalPrice: '698', image: 'https://picsum.photos/400/400?random=16', isDesigner: false },
      { id: 17, name: '厨房水槽', spec: '304不锈钢', price: '1,280', originalPrice: '1,680', image: 'https://picsum.photos/400/400?random=17', isDesigner: true },
      { id: 18, name: '智能门锁', spec: '指纹+密码', price: '2,380', originalPrice: '2,980', image: 'https://picsum.photos/400/400?random=18', isDesigner: false },
      { id: 19, name: '中央空调', spec: '一拖多变频', price: '28,800', originalPrice: '35,800', image: 'https://picsum.photos/400/400?random=19', isDesigner: true },
      { id: 20, name: '全屋灯具', spec: '北欧简约风', price: '6,800', originalPrice: '8,800', image: 'https://picsum.photos/400/400?random=20', isDesigner: false }
    ],
    spaceProducts: [
      { id: 5, name: '客厅沙发组合', spec: '现代简约风格', price: '12,800', originalPrice: '15,800', image: 'https://picsum.photos/400/400?random=5', isDesigner: true },
      { id: 6, name: '主卧床品套装', spec: '舒适睡眠体验', price: '3,280', originalPrice: '4,580', image: 'https://picsum.photos/400/400?random=6', isDesigner: false },
      { id: 7, name: '餐厅餐桌椅', spec: '北欧简约设计', price: '6,880', originalPrice: '8,880', image: 'https://picsum.photos/400/400?random=7', isDesigner: true },
      { id: 8, name: '书房书桌组合', spec: '实木书桌+书柜', price: '5,680', originalPrice: '7,280', image: 'https://picsum.photos/400/400?random=8', isDesigner: false },
      { id: 21, name: '玄关鞋柜', spec: '多功能收纳', price: '2,880', originalPrice: '3,680', image: 'https://picsum.photos/400/400?random=21', isDesigner: true },
      { id: 22, name: '阳台花架', spec: '铁艺复古风', price: '680', originalPrice: '880', image: 'https://picsum.photos/400/400?random=22', isDesigner: false },
      { id: 23, name: '厨房吊柜', spec: '定制尺寸', price: '3,580', originalPrice: '4,580', image: 'https://picsum.photos/400/400?random=23', isDesigner: true },
      { id: 24, name: '衣帽间定制', spec: 'U型布局', price: '15,800', originalPrice: '22,800', image: 'https://picsum.photos/400/400?random=24', isDesigner: false },
      { id: 25, name: '浴室镜柜', spec: '智能除雾', price: '1,280', originalPrice: '1,680', image: 'https://picsum.photos/400/400?random=25', isDesigner: true },
      { id: 26, name: '客厅茶几', spec: '岩板台面', price: '1,880', originalPrice: '2,380', image: 'https://picsum.photos/400/400?random=26', isDesigner: false },
      { id: 27, name: '卧室床头柜', spec: '实木床头', price: '880', originalPrice: '1,180', image: 'https://picsum.photos/400/400?random=27', isDesigner: true },
      { id: 28, name: '书房书架', spec: '落地大书架', price: '2,380', originalPrice: '2,980', image: 'https://picsum.photos/400/400?random=28', isDesigner: false }
    ],
    sceneProducts: [
      { id: 9, name: '极简客厅方案', spec: 'less is more', price: '28,800', originalPrice: '35,800', image: 'https://picsum.photos/400/400?random=9', isDesigner: true },
      { id: 10, name: '治愈系卧室', spec: '温暖舒适空间', price: '18,800', originalPrice: '24,800', image: 'https://picsum.photos/400/400?random=10', isDesigner: true },
      { id: 11, name: '日式茶室', spec: '禅意生活美学', price: '22,800', originalPrice: '28,800', image: 'https://picsum.photos/400/400?random=11', isDesigner: false },
      { id: 12, name: '现代厨房方案', spec: '功能与美学兼备', price: '32,800', originalPrice: '42,800', image: 'https://picsum.photos/400/400?random=12', isDesigner: true },
      { id: 29, name: '亲子乐园', spec: '儿童友好设计', price: '15,800', originalPrice: '22,800', image: 'https://picsum.photos/400/400?random=29', isDesigner: true },
      { id: 30, name: '智能收纳', spec: '空间最大化', price: '12,800', originalPrice: '18,800', image: 'https://picsum.photos/400/400?random=30', isDesigner: false },
      { id: 31, name: '休闲阳台', spec: '惬意生活角落', price: '8,800', originalPrice: '12,800', image: 'https://picsum.photos/400/400?random=31', isDesigner: true },
      { id: 32, name: '家庭办公', spec: '高效工作空间', price: '9,800', originalPrice: '14,800', image: 'https://picsum.photos/400/400?random=32', isDesigner: false },
      { id: 33, name: '养老无忧', spec: '适老化设计', price: '18,800', originalPrice: '25,800', image: 'https://picsum.photos/400/400?random=33', isDesigner: true },
      { id: 34, name: '北欧风客厅', spec: '自然简约', price: '25,800', originalPrice: '32,800', image: 'https://picsum.photos/400/400?random=34', isDesigner: false },
      { id: 35, name: '新中式书房', spec: '东方雅韵', price: '16,800', originalPrice: '22,800', image: 'https://picsum.photos/400/400?random=35', isDesigner: true },
      { id: 36, name: '轻奢餐厅', spec: '精致用餐体验', price: '19,800', originalPrice: '26,800', image: 'https://picsum.photos/400/400?random=36', isDesigner: false }
    ],
    products: [],
    loading: false,
    hasMore: true,
    page: 1,
    pageSize: 4
  },

  onLoad() {
    const { statusBarHeight, windowWidth } = wx.getSystemInfoSync();
    const rpxToPx = windowWidth / 750;
    const navBarHeight = (statusBarHeight || 20) + 44;
    const subTabsHeight = Math.ceil(100 * rpxToPx);
    const gap = Math.ceil(20 * rpxToPx);
    this.setData({
      statusBarHeight: statusBarHeight || 20,
      navBarHeight: navBarHeight,
      contentTop: navBarHeight + subTabsHeight + gap
    });
    this.loadProducts(true);
  },

  loadProducts(reset = false) {
    if (this.data.loading) return;
    if (!reset && !this.data.hasMore) return;

    const productsKey = `${this.data.currentTab}Products`;
    const allProducts = this.data[productsKey];
    const { page, pageSize } = reset ? { page: 1, pageSize: this.data.pageSize } : this.data;

    if (reset) {
      this.setData({ products: [], page: 1, hasMore: true });
    }

    const start = (page - 1) * pageSize;
    const end = start + pageSize;
    const newProducts = allProducts.slice(start, end);

    this.setData({ loading: true });

    setTimeout(() => {
      this.setData({
        products: reset ? newProducts : this.data.products.concat(newProducts),
        page: page + 1,
        hasMore: end < allProducts.length,
        loading: false
      });
    }, 300);
  },

  onLoadMore() {
    this.loadProducts(false);
  },

onTabChange(e) {
    const { tab } = e.currentTarget.dataset;
    this.setData({
      currentTab: tab,
      currentSubTab: 0,
      subScrollLeft: 0
    });
    this.loadProducts(true);
  },

  onSubTabChange(e) {
    const { index } = e.currentTarget.dataset;
    this.setData({ currentSubTab: index });
  },

  showAreaPicker() {
    this.setData({ 
      showAreaPicker: true,
      tempRegion: this.data.currentRegion
    });
  },

  hideAreaPicker() {
    this.setData({ showAreaPicker: false });
  },

  selectArea(e) {
    this.setData({ tempRegion: e.currentTarget.dataset.value });
  },

  confirmArea() {
    const { tempRegion, regionOptions } = this.data;
    const selected = regionOptions.find(item => item.value === tempRegion);
    this.setData({
      currentRegion: tempRegion,
      regionLabel: selected ? selected.label : '全部',
      showAreaPicker: false
    });
  },

  preventMove() {},

  goGoods(e) {
    const { id } = e.currentTarget.dataset;
    wx.navigateTo({
      url: `/pages/goods/goods?id=${id}`
    });
  }
});