Component({
  properties: {
    current: {
      type: String,
      value: "home"
    }
  },
  data: {
    items: [
      { key: "home", label: "首页", url: "/pages/home/index" },
      { key: "product", label: "选品", url: "/pages/product/list/index" },
      { key: "appointment", label: "预约", url: "/pages/appointment/list/index" },
      { key: "order", label: "订单", url: "/pages/order/list/index" },
      { key: "profile", label: "我的", url: "/pages/profile/index" }
    ]
  },
  methods: {
    navigate(event) {
      const { key, url } = event.currentTarget.dataset;
      if (key === this.properties.current) {
        return;
      }
      wx.reLaunch({ url });
    }
  }
});
