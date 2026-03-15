const env = require("../config/env");
const request = require("../utils/request");
const mock = require("../utils/mock");

function listOrders() {
  if (env.useMock) {
    return mock.delay({ code: 200, rows: mock.orders, total: mock.orders.length });
  }
  return request({
    url: "/v1/order/list"
  });
}

function getOrderDetail(orderId) {
  if (env.useMock) {
    return mock.delay({ code: 200, data: mock.orders.find((item) => item.order_id === Number(orderId)) });
  }
  return request({
    url: `/v1/order/${orderId}`
  });
}

function createOrder(payload) {
  if (env.useMock) {
    return mock.delay({
      code: 200,
      data: {
        order_id: Date.now(),
        order_no: `ORD${Date.now()}`,
        payment: { timeStamp: `${Date.now()}`, nonceStr: "mock", package: "prepay_id=mock", signType: "RSA", paySign: "mock" }
      }
    });
  }
  return request({
    url: "/v1/order/create",
    method: "POST",
    data: payload
  });
}

module.exports = {
  listOrders,
  getOrderDetail,
  createOrder
};
