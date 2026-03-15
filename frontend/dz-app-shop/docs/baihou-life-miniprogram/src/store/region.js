const storage = require("../utils/storage");

const defaultRegion = {
  region_id: "foshan",
  region_name: "佛山",
  province: "广东"
};

let state = {
  current: { ...defaultRegion },
  regions: storage.get("region_list", [])
};

function bootstrap() {
  state.current = storage.get("region", { ...defaultRegion });
  state.regions = storage.get("region_list", []);
}

function setCurrent(region) {
  state.current = region;
  storage.set("region", region);
}

function setRegions(regions) {
  state.regions = regions;
  storage.set("region_list", regions);
}

function getState() {
  return state;
}

module.exports = {
  bootstrap,
  setCurrent,
  setRegions,
  getState
};
