const regionStore = require("../store/region");

function pickNearestRegion(regions, latitude) {
  if (!regions.length) {
    return null;
  }
  const southBias = latitude && latitude < 28;
  return regions.find((item) => southBias ? item.region_id === "foshan" : item.region_id === "chengdu") || regions[0];
}

function detectRegion(regions) {
  return new Promise((resolve) => {
    wx.getLocation({
      type: "gcj02",
      success: ({ latitude }) => {
        resolve(pickNearestRegion(regions, latitude));
      },
      fail: () => resolve(null)
    });
  });
}

function applyRegion(region) {
  if (region) {
    regionStore.setCurrent(region);
  }
}

module.exports = {
  detectRegion,
  applyRegion
};
