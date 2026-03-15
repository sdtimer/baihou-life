Page({
  data: {
    statusBarHeight: 20,
    navBarHeight: 64,
    orderId: '',
    order: null
  },

  onLoad(options) {
    const { statusBarHeight } = wx.getSystemInfoSync();
    const navBarHeight = (statusBarHeight || 20) + 44;
    this.setData({
      statusBarHeight: statusBarHeight || 20,
      navBarHeight: navBarHeight,
      orderId: options.id || ''
    });
    this.loadOrderDetail();
  },

  loadOrderDetail() {
    const orderMap = {
      1: {
        id: 1,
        orderNo: 'BH2026031300001',
        status: 'pending',
        statusText: '待付款',
        statusDesc: '请在30分钟内完成付款',
        createTime: '2026-03-13 10:30:00',
        payTime: '',
        shipTime: '',
        completeTime: '',
        address: {
          name: '张三',
          phone: '138****8888',
          detail: '浙江省杭州市西湖区文三路 478 号华星科技大厦 12 楼'
        },
        goods: [
          { id: 101, name: '现代简约沙发', spec: '米白色 / 三人座', price: '2,999', quantity: 1, image: 'https://picsum.photos/400/400?random=101' }
        ],
        goodsAmount: '2,999.00',
        freight: '0.00',
        discount: '0.00',
        totalAmount: '2,999.00'
      },
      2: {
        id: 2,
        orderNo: 'BH2026031200002',
        status: 'paid',
        statusText: '待发货',
        statusDesc: '商家正在准备发货',
        createTime: '2026-03-12 14:20:00',
        payTime: '2026-03-12 14:22:35',
        shipTime: '',
        completeTime: '',
        address: {
          name: '李四',
          phone: '139****9999',
          detail: '浙江省杭州市余杭区文一西路 969 号'
        },
        goods: [
          { id: 102, name: '北欧风餐桌椅套装', spec: '胡桃木色 / 一桌四椅', price: '4,599', quantity: 1, image: 'https://picsum.photos/400/400?random=102' }
        ],
        goodsAmount: '4,599.00',
        freight: '0.00',
        discount: '100.00',
        totalAmount: '4,499.00'
      },
      3: {
        id: 3,
        orderNo: 'BH2026031100003',
        status: 'shipped',
        statusText: '待收货',
        statusDesc: '商品正在配送中',
        createTime: '2026-03-11 09:15:00',
        payTime: '2026-03-11 09:16:20',
        shipTime: '2026-03-12 10:00:00',
        completeTime: '',
        address: {
          name: '王五',
          phone: '137****7777',
          detail: '浙江省杭州市滨江区江南大道 588 号'
        },
        goods: [
          { id: 103, name: '智能马桶', spec: '全自动冲洗', price: '3,880', quantity: 1, image: 'https://picsum.photos/400/400?random=103' }
        ],
        goodsAmount: '3,880.00',
        freight: '0.00',
        discount: '0.00',
        totalAmount: '3,880.00'
      },
      4: {
        id: 4,
        orderNo: 'BH2026031000004',
        status: 'completed',
        statusText: '已完成',
        statusDesc: '感谢您的购买',
        createTime: '2026-03-10 16:45:00',
        payTime: '2026-03-10 16:46:12',
        shipTime: '2026-03-11 08:30:00',
        completeTime: '2026-03-13 14:00:00',
        address: {
          name: '赵六',
          phone: '136****6666',
          detail: '浙江省杭州市拱墅区登云路 50 号'
        },
        goods: [
          { id: 104, name: '定制衣柜', spec: 'E0级环保板材', price: '12,800', quantity: 1, image: 'https://picsum.photos/400/400?random=104' },
          { id: 105, name: '实木床头柜', spec: '橡木原木', price: '880', quantity: 2, image: 'https://picsum.photos/400/400?random=105' }
        ],
        goodsAmount: '14,560.00',
        freight: '200.00',
        discount: '200.00',
        totalAmount: '14,560.00'
      },
      5: {
        id: 5,
        orderNo: 'BH2026030900005',
        status: 'completed',
        statusText: '已完成',
        statusDesc: '感谢您的购买',
        createTime: '2026-03-09 11:20:00',
        payTime: '2026-03-09 11:21:05',
        shipTime: '2026-03-10 09:00:00',
        completeTime: '2026-03-12 16:30:00',
        address: {
          name: '孙七',
          phone: '135****5555',
          detail: '浙江省杭州市西湖区学院路 77 号'
        },
        goods: [
          { id: 106, name: '全屋灯具套装', spec: '北欧简约风', price: '6,800', quantity: 1, image: 'https://picsum.photos/400/400?random=106' }
        ],
        goodsAmount: '6,800.00',
        freight: '0.00',
        discount: '0.00',
        totalAmount: '6,800.00'
      }
    };

    const order = orderMap[this.data.orderId] || orderMap[1];
    this.setData({ order });
  },

  goBack() {
    wx.navigateBack();
  },

  copyOrderNo() {
    wx.setClipboardData({
      data: this.data.order.orderNo,
      success: () => {
        wx.showToast({ title: '已复制', icon: 'success' });
      }
    });
  },

  cancelOrder() {
    wx.showModal({
      title: '提示',
      content: '确定取消该订单吗？',
      success: (res) => {
        if (res.confirm) {
          wx.showToast({ title: '订单已取消', icon: 'success' });
          setTimeout(() => {
            wx.navigateBack();
          }, 1500);
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
    wx.showToast({ title: '跳转评价页面', icon: 'none' });
  },

  contactService() {
    wx.makePhoneCall({
      phoneNumber: '400-888-8888'
    });
  }
});