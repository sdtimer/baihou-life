const env = require("../config/env");
const request = require("../utils/request");
const mock = require("../utils/mock");

function createAppointment(payload) {
  if (env.useMock) {
    return mock.delay({ code: 200, msg: "预约创建成功", data: { appointment_id: Date.now() } });
  }
  return request({
    url: "/v1/appointment/create",
    method: "POST",
    data: payload
  });
}

function listAppointments() {
  if (env.useMock) {
    return mock.delay({ code: 200, rows: mock.appointments, total: mock.appointments.length });
  }
  return request({
    url: "/v1/appointment/list"
  });
}

module.exports = {
  createAppointment,
  listAppointments
};
