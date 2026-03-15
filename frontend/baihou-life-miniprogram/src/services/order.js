const env = require("../config/env");
const request = require("../utils/request");
const mock = require("../utils/mock");

const REGION_NAMES = {
  foshan: "佛山",
  chengdu: "成都",
  wuhan: "武汉"
};

function formatDateText(value) {
  if (!value) {
    return "";
  }
  if (typeof value === "string") {
    return value.replace("T", " ").slice(0, 19);
  }
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) {
    return "";
  }
  return date.toISOString().replace("T", " ").slice(0, 19);
}

function normalizeOrder(item = {}) {
  return {
    order_id: item.order_id || item.orderId,
    order_no: item.order_no || item.orderNo || "",
    product_id: item.product_id || item.productId || null,
    product_name: item.product_name || item.productName || "精选产品",
    unit_price: item.unit_price || item.unitPrice || 0,
    region_id: item.region_id || item.regionId || "",
    region_name: item.region_name || item.regionName || REGION_NAMES[item.region_id || item.regionId] || "",
    total_amount: item.total_amount || item.totalAmount || 0,
    pay_amount: item.pay_amount || item.payAmount || 0,
    status: item.status || "",
    expires_at: formatDateText(item.expires_at || item.expiresAt),
    created_at: formatDateText(item.created_at || item.create_time || item.createTime)
  };
}

async function listOrders() {
  if (env.useMock) {
    return mock.delay(mock.orders.map(normalizeOrder));
  }
  const response = await request({
    url: "/v1/order/list"
  });
  return (response.data || response.rows || []).map(normalizeOrder);
}

async function getOrderDetail(orderId) {
  if (env.useMock) {
    const target = mock.orders.find((item) => item.order_id === Number(orderId));
    return mock.delay(target ? normalizeOrder(target) : null);
  }
  const response = await request({
    url: `/v1/order/${orderId}`
  });
  return response.data ? normalizeOrder(response.data) : null;
}

async function createOrder(payload) {
  if (env.useMock) {
    return mock.delay({
      order_id: Date.now(),
      order_no: `ORD${Date.now()}`,
      product_id: payload.product_id,
      product_name: "精选产品",
      unit_price: 1280
    });
  }
  const response = await request({
    url: "/v1/order/create",
    method: "POST",
    data: payload
  });
  return response.data || {};
}

async function prepayOrder(orderId) {
  if (env.useMock) {
    return mock.delay({
      order_id: orderId,
      order_no: `ORD${orderId}`,
      payment: {
        timeStamp: `${Date.now()}`,
        nonceStr: "mock",
        package: "prepay_id=mock",
        signType: "RSA",
        paySign: "mock",
        mode: "mock"
      }
    });
  }
  const response = await request({
    url: "/v1/payment/wechat/prepay",
    method: "POST",
    data: { order_id: orderId }
  });
  return response.data || {};
}

async function markOrderPaid(orderId) {
  if (env.useMock) {
    return mock.delay({ success: true });
  }
  return request({
    url: "/v1/payment/wechat/pay-success",
    method: "POST",
    data: { order_id: orderId }
  });
}

function requestPayment(payment = {}) {
  if (payment.mode === "mock") {
    return new Promise((resolve, reject) => {
      wx.showActionSheet({
        itemList: ["模拟支付成功", "模拟支付取消", "模拟支付失败"],
        success: ({ tapIndex }) => {
          if (tapIndex === 0) {
            resolve({ errMsg: "requestPayment:ok" });
            return;
          }
          if (tapIndex === 1) {
            const error = new Error("PAY_CANCELLED");
            error.code = "PAY_CANCELLED";
            reject(error);
            return;
          }
          const error = new Error("PAY_FAILED");
          error.code = "PAY_FAILED";
          reject(error);
        },
        fail: () => {
          const error = new Error("PAY_CANCELLED");
          error.code = "PAY_CANCELLED";
          reject(error);
        }
      });
    });
  }

  return new Promise((resolve, reject) => {
    wx.requestPayment({
      ...payment,
      success: resolve,
      fail: reject
    });
  });
}

module.exports = {
  listOrders,
  getOrderDetail,
  createOrder,
  prepayOrder,
  markOrderPaid,
  requestPayment
};
