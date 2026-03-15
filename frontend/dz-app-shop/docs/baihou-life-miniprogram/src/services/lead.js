const env = require("../config/env");
const request = require("../utils/request");
const mock = require("../utils/mock");

function submitLead(payload) {
  if (env.useMock) {
    return mock.delay({ code: 200, msg: "提交成功", data: { lead_id: Date.now() } });
  }
  return request({
    url: "/v1/leads/submit",
    method: "POST",
    data: payload
  });
}

module.exports = {
  submitLead
};
