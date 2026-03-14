const configService = require("../../services/config");
const productService = require("../../services/product");
const userStore = require("../../store/user");
const regionStore = require("../../store/region");
const location = require("../../utils/location");

Page({
  data: {
    currentRegion: regionStore.getState().current,
    heroProducts: [],
    errorMessage: "",
    sceneTabs: [
      { label: "极简", value: "minimalist" },
      { label: "治愈", value: "healing" },
      { label: "侘寂", value: "wabi_sabi" }
    ],
    activeScene: "minimalist",
    isDesigner: userStore.isDesigner()
  },

  onShow() {
    this.setData({
      currentRegion: regionStore.getState().current,
      isDesigner: userStore.isDesigner()
    });
    this.bootstrap();
  },

  async bootstrap() {
    try {
      const regionResponse = await configService.getRegions();
      const regions = regionResponse.data ? regionResponse.data.regions : regionResponse.regions;
      regionStore.setRegions(regions);
      if (!regionStore.isInitialized()) {
        const detected = await location.detectRegion(regions);
        location.applyRegion(detected || regions[0]);
      }

      const current = regionStore.getState().current;
      const productResponse = await productService.listProducts({
        region_id: current.region_id,
        scene: this.data.activeScene,
        pageNum: 1,
        pageSize: 2
      });

      this.setData({
        currentRegion: current,
        heroProducts: productResponse.rows,
        errorMessage: ""
      });
    } catch (error) {
      this.setData({
        errorMessage: "首页内容加载失败，请稍后重试。"
      });
    }
  },

  async changeScene(event) {
    const { scene } = event.currentTarget.dataset;
    const response = await productService.listProducts({
      region_id: this.data.currentRegion.region_id,
      scene,
      pageNum: 1,
      pageSize: 2
    });
    this.setData({
      activeScene: scene,
      heroProducts: response.rows
    });
  },

  handleRegionTap() {
    const regions = regionStore.getState().regions || [];
    wx.showActionSheet({
      itemList: regions.map((item) => item.region_name),
      success: ({ tapIndex }) => {
        const nextRegion = regions[tapIndex];
        regionStore.setCurrent(nextRegion);
        this.setData({ currentRegion: nextRegion });
        this.bootstrap();
      }
    });
  },

  goProductList() {
    wx.navigateTo({ url: "/pages/product/list/index" });
  },

  openDetail(event) {
    const { id } = event.detail;
    wx.navigateTo({ url: `/pages/product/detail/index?id=${id}` });
  },

  goAuth() {
    wx.navigateTo({ url: "/pages/auth/index" });
  },

  retry() {
    this.bootstrap();
  }
});
