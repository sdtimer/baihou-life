Component({
  properties: {
    title: {
      type: String,
      value: ""
    },
    subtitle: {
      type: String,
      value: ""
    },
    compact: {
      type: Boolean,
      value: false
    }
  },
  data: {
    topInset: 0
  },
  lifetimes: {
    attached() {
      const { statusBarHeight = 20 } = wx.getWindowInfo ? wx.getWindowInfo() : wx.getSystemInfoSync();
      this.setData({ topInset: statusBarHeight });
    }
  },
  methods: {
    handleBack() {
      const pages = getCurrentPages();
      if (pages.length > 1) {
        wx.navigateBack();
        return;
      }
      wx.reLaunch({ url: "/pages/home/index" });
    }
  }
});
