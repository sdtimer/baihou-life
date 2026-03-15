const env = require("../config/env");
const auth = require("./auth");
const regionStore = require("../store/region");

function request({ url, method = "GET", data = {}, header = {} }) {
  if (env.useMock) {
    return Promise.reject(new Error("MOCK_MODE"));
  }

  const region = regionStore.getState().current;
  return new Promise((resolve, reject) => {
    wx.request({
      url: `${env.baseURL}${url}`,
      method,
      data,
      timeout: env.requestTimeout,
      header: {
        "Content-Type": "application/json",
        Authorization: auth.getToken() ? `Bearer ${auth.getToken()}` : "",
        "X-Region-Id": region?.region_id || "",
        ...header
      },
      success: ({ statusCode, data: response }) => {
        // 401：自动静默重新登录后重放原请求
        if (statusCode === 401) {
          const authService = require('../services/auth');
          authService.silentLogin()
            .then(() => {
              // token 已更新，重放原始请求
              request({ url, method, data, header }).then(resolve).catch(reject);
            })
            .catch(() => {
              // 重新登录失败，跳转登录页
              const userStore = require('../store/user');
              userStore.logout();
              wx.navigateTo({ url: '/pages/auth/index' });
              const authError = new Error('登录已过期，请重新登录');
              authError.code = 401;
              reject(authError);
            });
          return;
        }
        if (statusCode >= 200 && statusCode < 300) {
          if (response && typeof response === "object" && Object.prototype.hasOwnProperty.call(response, "code")) {
            if (response.code === 200) {
              resolve(response);
              return;
            }
            const bizError = new Error(response.msg || '操作失败');
            bizError.code = response.code;
            bizError.data = response.data;
            reject(bizError);
            return;
          }
          resolve(response);
          return;
        }
        const httpError = new Error((response && response.msg) || `请求失败（${statusCode}）`);
        httpError.code = statusCode;
        reject(httpError);
      },
      fail: (err) => {
        const netError = new Error(err.errMsg || '网络错误');
        netError.code = 'NETWORK_ERROR';
        reject(netError);
      }
    });
  });
}

module.exports = request;
