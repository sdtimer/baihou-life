const env = require("../config/env");
const request = require("../utils/request");
const mock = require("../utils/mock");

function getRegions() {
  if (env.useMock) {
    return mock.delay({
      code: 200,
      data: {
        regions: mock.regions
      }
    });
  }
  return request({
    url: "/v1/config/regions"
  });
}

module.exports = {
  getRegions
};
