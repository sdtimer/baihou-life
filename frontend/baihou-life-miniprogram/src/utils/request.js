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
        if (statusCode >= 200 && statusCode < 300) {
          if (response && typeof response === "object" && Object.prototype.hasOwnProperty.call(response, "code")) {
            if (response.code === 200) {
              resolve(response);
              return;
            }
            reject(response);
            return;
          }
          resolve(response);
          return;
        }
        reject(response || { code: statusCode, msg: "请求失败" });
      },
      fail: reject
    });
  });
}

module.exports = request;
