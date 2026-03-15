const env = require("../config/env");
const request = require("../utils/request");
const mock = require("../utils/mock");

function listProducts(params = {}) {
  if (env.useMock) {
    const rows = mock.products.filter((item) => {
      if (params.keyword && !`${item.name}${item.brand}`.includes(params.keyword)) {
        return false;
      }
      if (params.category_id && item.category_id !== Number(params.category_id)) {
        return false;
      }
      if (params.space && !item.space_tags.includes(params.space)) {
        return false;
      }
      if (params.scene && !item.scene_tags.includes(params.scene)) {
        return false;
      }
      return true;
    });
    return mock.delay({ code: 200, rows, total: rows.length });
  }
  return request({
    url: "/v2/product/list",
    data: params
  });
}

function getProductDetail(id, region_id) {
  if (env.useMock) {
    return mock.delay({
      code: 200,
      data: mock.products.find((item) => item.id === Number(id) && (item.regions.includes("ALL") || item.regions.includes(region_id)))
    });
  }
  return request({
    url: `/v2/product/${id}`,
    data: { region_id }
  });
}

function getCategories() {
  if (env.useMock) {
    return mock.delay({
      code: 200,
      data: {
        categories: mock.categories,
        spaces: mock.spaces,
        scenes: mock.scenes
      }
    });
  }
  return request({
    url: "/v1/product/categories"
  });
}

module.exports = {
  listProducts,
  getProductDetail,
  getCategories
};
