const orderService = require("../../../services/order");
const auth = require("../../../utils/auth");

const statusText = {
  pending_pay: "待支付",
  paid: "已支付",
  processing: "处理中",
  shipped: "已发货",
  completed: "已完成",
  closed: "已关闭"
};

Page({
  data: {
    rows: [],
    filteredRows: [],
    loading: true,
    currentTab: "all",
    tabList: [
      { label: "全部", value: "all" },
      { label: "待付款", value: "pending_pay" },
      { label: "处理中", value: "paid" },
      { label: "待收货", value: "shipped" },
      { label: "已完成", value: "completed" }
    ]
  },

  onLoad(options) {
    this.setData({
      currentTab: options.status || "all"
    });
  },

  async onShow() {
    if (!auth.requireLogin({ redirect: "/pages/order/list/index" })) {
      return;
    }
    this.setData({ loading: true });
    try {
      const rows = await orderService.listOrders();
      const normalizedRows = rows.map((item) => ({ ...item, status_text: statusText[item.status] || item.status }));
      this.setData({
        loading: false,
        rows: normalizedRows,
        filteredRows: this.filterRowsByTab(normalizedRows, this.data.currentTab)
      });
    } catch (error) {
      this.setData({
        loading: false,
        rows: [],
        filteredRows: []
      });
      wx.showToast({
        title: error.msg || "订单加载失败",
        icon: "none"
      });
    }
  },

  openDetail(event) {
    wx.navigateTo({ url: `/pages/order/detail/index?id=${event.currentTarget.dataset.id}` });
  },

  onTabChange(event) {
    const currentTab = event.currentTarget.dataset.value;
    this.setData({
      currentTab,
      filteredRows: this.filterRowsByTab(this.data.rows, currentTab)
    });
  },

  filterRowsByTab(rows = [], currentTab = "all") {
    if (currentTab === "all") {
      return rows;
    }
    if (currentTab === "paid") {
      return rows.filter((item) => item.status === "paid" || item.status === "processing");
    }
    return rows.filter((item) => item.status === currentTab);
  }
});
