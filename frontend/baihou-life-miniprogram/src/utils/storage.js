const PREFIX = "baihou_life_";

function getKey(key) {
  return `${PREFIX}${key}`;
}

function set(key, value) {
  wx.setStorageSync(getKey(key), value);
}

function get(key, fallback = null) {
  const value = wx.getStorageSync(getKey(key));
  return value === "" || value === undefined ? fallback : value;
}

function remove(key) {
  wx.removeStorageSync(getKey(key));
}

function clearAll() {
  ["token", "user", "region", "region_list", "region_initialized"].forEach(remove);
}

module.exports = {
  set,
  get,
  remove,
  clearAll
};
