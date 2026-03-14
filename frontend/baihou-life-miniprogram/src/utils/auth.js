const userStore = require("../store/user");

function getToken() {
  return userStore.getState().token;
}

function getRole() {
  return userStore.getState().profile.role || 0;
}

function buildRedirect(options = {}) {
  return options.redirect || "";
}

function requireLogin(options = {}) {
  if (userStore.isLoggedIn()) {
    return true;
  }
  wx.navigateTo({
    url: `/pages/auth/index?redirect=${encodeURIComponent(buildRedirect(options))}`
  });
  return false;
}

function requireRole(role, options = {}) {
  if (!requireLogin(options)) {
    return false;
  }
  if (getRole() !== role) {
    wx.showToast({
      title: options.message || "当前账号暂无权限",
      icon: "none"
    });
    return false;
  }
  return true;
}

module.exports = {
  getToken,
  getRole,
  requireLogin,
  requireRole
};
