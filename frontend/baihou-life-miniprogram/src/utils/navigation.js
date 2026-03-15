const appConfig = require("../app.json");
const storage = require("./storage");

const TAB_REDIRECT_STATE_KEY = "tab_redirect_state";
const tabBarPages = new Set(
  ((appConfig.tabBar && appConfig.tabBar.list) || []).map((item) => normalizePath(item.pagePath))
);

function normalizePath(path = "") {
  if (!path) {
    return "";
  }
  const [pathname] = path.split("?");
  return pathname.startsWith("/") ? pathname : `/${pathname}`;
}

function parseQueryString(query = "") {
  if (!query) {
    return {};
  }
  return query.split("&").reduce((result, pair) => {
    if (!pair) {
      return result;
    }
    const [rawKey, rawValue = ""] = pair.split("=");
    result[decodeURIComponent(rawKey)] = decodeURIComponent(rawValue);
    return result;
  }, {});
}

function isTabBarPage(path = "") {
  return tabBarPages.has(normalizePath(path));
}

function setTabRedirectState(path, params = {}) {
  storage.set(TAB_REDIRECT_STATE_KEY, {
    path: normalizePath(path),
    params: params || {}
  });
}

function consumeTabRedirectState(path) {
  const state = storage.get(TAB_REDIRECT_STATE_KEY);
  if (!state || normalizePath(state.path) !== normalizePath(path)) {
    return null;
  }
  storage.remove(TAB_REDIRECT_STATE_KEY);
  return state.params || {};
}

function buildQuery(params = {}) {
  return Object.keys(params)
    .filter((key) => params[key] !== undefined && params[key] !== null && params[key] !== "")
    .map((key) => `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`)
    .join("&");
}

function navigate(path, options = {}) {
  const normalizedPath = normalizePath(path);
  const [, rawQuery = ""] = (path || "").split("?");
  const params = {
    ...parseQueryString(rawQuery),
    ...(options.params || {})
  };
  if (isTabBarPage(normalizedPath)) {
    if (Object.keys(params).length > 0) {
      setTabRedirectState(normalizedPath, params);
    }
    return wx.switchTab({ url: normalizedPath });
  }

  const query = buildQuery(params);
  const url = query ? `${normalizedPath}?${query}` : normalizedPath;
  const mode = options.mode === "replace" ? "redirectTo" : "navigateTo";
  return wx[mode]({ url });
}

module.exports = {
  consumeTabRedirectState,
  isTabBarPage,
  navigate,
  normalizePath,
  setTabRedirectState
};
