Page({
  data: {
    statusBarHeight: 20,
    navBarHeight: 64,
    contentTop: 0,
    currentTab: 'all',
    tabList: [
      { label: '全部', value: 'all' },
      { label: '待付款', value: 'pending' },
      { label: '待发货', value: 'paid' },
      { label: '待收货', value: 'shipped' },
      { label: '已完成', value: 'completed' }
    ],
    orders: [],
    loading: false,
    hasMore: true,
    page: 1
  },

  allOrders: null,

  onLoad() {
    this.allOrders = [
      {
        id: 1,
        orderNo: 'BH2026031300001',
        status: 'pending',
        statusText: '待付款',
        goods: [
          { id: 101, name: '现代简约沙发', spec: '米白色 / 三人座', price: '2,999', quantity: 1, image: 'https://picsum.photos/400/400?random=101' }
        ],
        totalQuantity: 1,
        totalPrice: '2,999.00'
      },
      {
        id: 2,
        orderNo: 'BH2026031200002',
        status: 'paid',
        statusText: '待发货',
        goods: [
          { id: 102, name: '北欧风餐桌椅套装', spec: '胡桃木色 / 一桌四椅', price: '4,599', quantity: 1, image: 'https://picsum.photos/400/400?random=102' }
        ],
        totalQuantity: 1,
        totalPrice: '4,599.00'
      },
      {
        id: 3,
        orderNo: 'BH2026031100003',
        status: 'shipped',
        statusText: '待收货',
        goods: [
          { id: 103, name: '智能马桶', spec: '全自动冲洗', price: '3,880', quantity: 1, image: 'https://picsum.photos/400/400?random=103' }
        ],
        totalQuantity: 1,
        totalPrice: '3,880.00'
      },
      {
        id: 4,
        orderNo: 'BH2026031000004',
        status: 'completed',
        statusText: '已完成',
        goods: [
          { id: 104, name: '定制衣柜', spec: 'E0级环保板材', price: '12,800', quantity: 1, image: 'https://picsum.photos/400/400?random=104' },
          { id: 105, name: '实木床头柜', spec: '橡木原木', price: '880', quantity: 2, image: 'https://picsum.photos/400/400?random=105' }
        ],
        totalQuantity: 3,
        totalPrice: '14,560.00'
      },
      {
        id: 5,
        orderNo: 'BH2026030900005',
        status: 'completed',
        statusText: '已完成',
        goods: [
          { id: 106, name: '全屋灯具套装', spec: '北欧简约风', price: '6,800', quantity: 1, image: 'https://picsum.photos/400/400?random=106' }
        ],
        totalQuantity: 1,
        totalPrice: '6,800.00'
      }
    ];

    const { statusBarHeight, windowWidth } = wx.getSystemInfoSync();
    const rpxToPx = windowWidth / 750;
    const navBarHeight = (statusBarHeight || 20) + 44;
    const tabsHeight = Math.ceil(88 * rpxToPx);
    this.setData({
      statusBarHeight: statusBarHeight || 20,
      navBarHeight: navBarHeight,
      contentTop: navBarHeight + tabsHeight
    });
    this.loadOrders(true);
  },

  loadOrders(reset) {
    if (this.data.loading) return;
    if (!reset && !this.data.hasMore) return;

    const currentTab = this.data.currentTab;
    const page = reset ? 1 : this.data.page;
    const allOrders = this.allOrders || [];
    
    const filtered = currentTab === 'all' 
      ? allOrders 
      : allOrders.filter(item => item.status === currentTab);

    const pageSize = 3;
    const start = reset ? 0 : (page - 1) * pageSize;
    const end = start + pageSize;
    const newOrders = filtered.slice(start, end);

    this.setData({ loading: true });

    setTimeout(() => {
      this.setData({
        orders: reset ? newOrders : this.data.orders.concat(newOrders),
        page: reset ? 2 : page + 1,
        hasMore: end < filtered.length,
        loading: false
      });
    }, 300);
  },

  onTabChange(e) {
    const { value } = e.currentTarget.dataset;
    if (value === this.data.currentTab) return;
    this.setData({ currentTab: value, orders: [], hasMore: true, page: 1 });
    this.loadOrders(true);
  },

  onLoadMore() {
    this.loadOrders(false);
  },

  goDetail(e) {
    const { id } = e.currentTarget.dataset;
    wx.navigateTo({ url: `/pages/order-detail/order-detail?id=${id}` });
  },

  cancelOrder(e) {
    wx.showModal({
      title: '提示',
      content: '确定取消该订单吗？',
      success: (res) => {
        if (res.confirm) {
          wx.showToast({ title: '已取消', icon: 'success' });
        }
      }
    });
  },

  payOrder() {
    wx.showToast({ title: '跳转支付', icon: 'none' });
  },

  confirmReceive() {
    wx.showModal({
      title: '提示',
      content: '确认已收到商品吗？',
      success: (res) => {
        if (res.confirm) {
          wx.showToast({ title: '已确认收货', icon: 'success' });
        }
      }
    });
  },

  reorder() {
    wx.showToast({ title: '已加入购物车', icon: 'success' });
  },

  goReview() {
    wx.navigateTo({ url: '/pages/review/review' });
  },

  goShopping() {
    wx.switchTab({ url: '/pages/index/index' });
  }
});