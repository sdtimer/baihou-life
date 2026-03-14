const storage = require("../utils/storage");

const defaultRegion = {
  region_id: "foshan",
  region_name: "佛山",
  province: "广东"
};

let state = {
  current: { ...defaultRegion },
  regions: storage.get("region_list", []),
  initialized: storage.get("region_initialized", false)
};

function bootstrap() {
  state.current = storage.get("region", { ...defaultRegion });
  state.regions = storage.get("region_list", []);
  state.initialized = storage.get("region_initialized", false);
}

function setCurrent(region) {
  state.current = region;
  state.initialized = true;
  storage.set("region", region);
  storage.set("region_initialized", true);
}

function setRegions(regions) {
  state.regions = regions;
  storage.set("region_list", regions);
}

function getState() {
  return state;
}

function isInitialized() {
  return Boolean(state.initialized);
}

module.exports = {
  bootstrap,
  setCurrent,
  setRegions,
  getState,
  isInitialized
};
