const userStore = require("./store/user");
const regionStore = require("./store/region");

App({
  globalData: {
    brand: {
      zh: "柏厚生活",
      en: "Baihou Life"
    },
    stores: {
      user: userStore,
      region: regionStore
    }
  },

  onLaunch() {
    userStore.bootstrap();
    regionStore.bootstrap();
  }
});
