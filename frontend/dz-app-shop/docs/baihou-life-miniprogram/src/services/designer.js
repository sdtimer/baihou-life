const env = require("../config/env");
const request = require("../utils/request");
const mock = require("../utils/mock");

function getAssetToken(product_id, media_id) {
  if (env.useMock) {
    return mock.delay({
      code: 200,
      data: {
        url: `https://example.com/mock-download/${product_id}/${media_id}`,
        expires_in: 300
      }
    });
  }
  return request({
    url: "/v1/designer/asset-token",
    data: { product_id, media_id }
  });
}

module.exports = {
  getAssetToken
};
