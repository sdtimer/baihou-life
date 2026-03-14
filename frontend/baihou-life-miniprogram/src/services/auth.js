const request = require("../utils/request");
const mock = require("../utils/mock");

function wxLogin() {
  return new Promise((resolve, reject) => {
    wx.login({
      success: (res) => {
        if (res.code) {
          resolve(res.code);
          return;
        }
        reject(new Error("LOGIN_CODE_MISSING"));
      },
      fail: reject
    });
  });
}

async function login() {
  if (require("../config/env").useMock) {
    return mock.delay({
      code: 200,
      data: {
        token: "mock-baihou-token",
        expires_in: 604800,
        user: {
          uid: 100001,
          role: 2,
          nickname: "设计师伙伴",
          avatar_url: "https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=80",
          phone: "138****1234",
          region_id: "foshan"
        }
      }
    });
  }
  const code = await wxLogin();
  return request({
    url: "/v1/auth/wechat-login",
    method: "POST",
    data: { code }
  });
}

module.exports = {
  login
};
