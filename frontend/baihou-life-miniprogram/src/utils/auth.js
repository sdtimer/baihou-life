const userStore = require("../store/user");
const navigation = require("./navigation");

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
  const redirect = buildRedirect(options);
  if (redirect && navigation.isTabBarPage(redirect) && options.redirectParams) {
    navigation.setTabRedirectState(redirect, options.redirectParams);
  }
  navigation.navigate("/pages/auth/index", {
    params: {
      redirect
    }
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
