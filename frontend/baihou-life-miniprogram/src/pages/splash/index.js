const configService = require("../../services/config");
const productService = require("../../services/product");
const userStore = require("../../store/user");
const regionStore = require("../../store/region");
const location = require("../../utils/location");

const MIN_SPLASH_STAY = 1200;

Page({
  data: {
    regionLabel: regionStore.getState().current.region_name || "正在识别城市",
    loadingText: "正在准备发现页..."
  },

  async onLoad() {
    const app = getApp();
    if (app.globalData.splashShown) {
      this.enterHome();
      return;
    }
    app.globalData.splashShown = true;
    const startedAt = Date.now();
    try {
      userStore.bootstrap();
      regionStore.bootstrap();
      const regionResponse = await configService.getRegions();
      const regions = Array.isArray(regionResponse.data) ? regionResponse.data : [];
      regionStore.setRegions(regions);
      if (!regionStore.isInitialized() && regions.length) {
        const detected = await location.detectRegion(regions);
        location.applyRegion(detected || regions[0]);
      } else if (!regionStore.getState().current.region_id && regions.length) {
        regionStore.setCurrent(regions[0]);
      }

      const currentRegion = regionStore.getState().current;
      this.setData({
        regionLabel: currentRegion.region_name || "佛山",
        loadingText: "正在加载首页精选..."
      });

      const feedResponse = await productService.getFeed({
        region_id: currentRegion.region_id,
        pageNum: 1,
        pageSize: 8
      });
      app.globalData.homePrefetch = {
        region_id: currentRegion.region_id,
        rows: feedResponse.rows || [],
        ts: Date.now()
      };
    } catch (error) {
      this.setData({
        loadingText: "正在进入首页..."
      });
    }

    const elapsed = Date.now() - startedAt;
    const remaining = Math.max(0, MIN_SPLASH_STAY - elapsed);
    setTimeout(() => this.enterHome(), remaining);
  },

  enterHome() {
    wx.switchTab({
      url: "/pages/home/index"
    });
  }
});
