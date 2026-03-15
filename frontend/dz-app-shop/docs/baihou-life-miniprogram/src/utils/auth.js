const userStore = require("../store/user");

function getToken() {
  return userStore.getState().token;
}

function getRole() {
  return userStore.getState().profile.role || 0;
}

function requireLogin(options = {}) {
  if (userStore.isLoggedIn()) {
    return true;
  }
  wx.navigateTo({
    url: `/pages/auth/index?redirect=${encodeURIComponent(options.redirect || "")}`
  });
  return false;
}

module.exports = {
  getToken,
  getRole,
  requireLogin
};
