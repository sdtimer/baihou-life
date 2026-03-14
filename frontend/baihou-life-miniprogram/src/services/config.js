const env = require("../config/env");
const request = require("../utils/request");
const mock = require("../utils/mock");

function normalizeRegion(region = {}) {
  return {
    region_id: region.region_id || region.regionId || "",
    region_name: region.region_name || region.regionName || "",
    province: region.province || "",
    center_lat: region.center_lat || region.centerLat || null,
    center_lng: region.center_lng || region.centerLng || null
  };
}

async function getRegions() {
  if (env.useMock) {
    return mock.delay({
      code: 200,
      data: mock.regions.map(normalizeRegion)
    });
  }
  const response = await request({
    url: "/v1/config/regions"
  });
  const rows = Array.isArray(response.data)
    ? response.data
    : Array.isArray(response.data?.regions)
      ? response.data.regions
      : Array.isArray(response.regions)
        ? response.regions
        : [];
  return {
    ...response,
    data: rows.map(normalizeRegion)
  };
}

module.exports = {
  getRegions
};
