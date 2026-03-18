const env = require("../config/env");
const request = require("../utils/request");
const mock = require("../utils/mock");
const userStore = require("../store/user");

const DEFAULT_PAGE_SIZE = 10;
const DEFAULT_FEED_PAGE_SIZE = 8;

function toAbsoluteUrl(url) {
  if (!url) {
    return "";
  }
  if (/^https?:\/\//i.test(url)) {
    return url;
  }
  if (url.startsWith("/")) {
    return `${env.baseURL}${url}`;
  }
  return `${env.baseURL}/${url}`;
}

function parseArray(value) {
  if (Array.isArray(value)) {
    return value;
  }
  if (!value) {
    return [];
  }
  if (typeof value === "string") {
    try {
      const parsed = JSON.parse(value);
      return Array.isArray(parsed) ? parsed : [];
    } catch (error) {
      return value.split(",").map((item) => item.trim()).filter(Boolean);
    }
  }
  return [];
}

function parseSpecs(product) {
  if (Array.isArray(product.specs)) {
    return product.specs;
  }
  if (!product.spec_params) {
    return [];
  }
  try {
    const parsed = JSON.parse(product.spec_params);
    if (Array.isArray(parsed)) {
      return parsed;
    }
    return Object.keys(parsed).map((key) => ({
      label: key,
      value: parsed[key]
    }));
  } catch (error) {
    return [];
  }
}

function normalizeMediaList(list = []) {
  return (list || []).map((item) => ({
    media_id: item.media_id || item.mediaId,
    name: item.name || item.file_name || item.fileName || "素材文件",
    access_level: item.access_level || item.accessLevel || "designer",
    asset_role: item.asset_role || item.assetRole || "display",
    is_cover: item.is_cover ?? item.isCover ?? 0,
    url: toAbsoluteUrl(item.url || ""),
    thumbnail_url: toAbsoluteUrl(item.thumbnail_url || item.thumbnailUrl || item.url || ""),
    original_url: toAbsoluteUrl(item.original_url || item.originalUrl || item.url || ""),
    file_format: item.file_format || item.fileFormat || "",
    file_size: item.file_size || item.fileSize || 0,
    width: item.width || 0,
    height: item.height || 0
  }));
}

function normalizeProduct(product = {}) {
  const sceneImages = normalizeMediaList(product.scene_images || product.gallery || []);
  const specImages = normalizeMediaList(product.spec_images || []);
  const elementImages = normalizeMediaList(product.element_images || []);
  const sourceFiles = normalizeMediaList(product.source_files || []);
  const downloadImages = normalizeMediaList(product.download_images || []);
  const coverMedia = sceneImages.find((item) => Number(item.is_cover) === 1) || sceneImages[0];
  const coverImage = toAbsoluteUrl(
    product.cover_image
      || product.coverImage
      || (coverMedia ? (coverMedia.thumbnail_url || coverMedia.url) : "")
      || (elementImages[0] ? (elementImages[0].thumbnail_url || elementImages[0].url) : "")
      || (specImages[0] ? (specImages[0].thumbnail_url || specImages[0].url) : "")
  );
  const gallery = Array.isArray(product.gallery) && product.gallery.length
    ? product.gallery.map((item) => toAbsoluteUrl(item))
    : sceneImages.map((item) => item.url).filter(Boolean);

  return {
    id: product.id,
    name: product.name || "",
    brand: product.brand || "",
    model: product.model || "",
    sku_code: product.sku_code || product.skuCode || "",
    category_id: product.category_id || product.categoryId || "",
    category_name: product.category_name || product.categoryName || "精选产品",
    guide_price: product.guide_price,
    designer_price: product.designer_price,
    designer_discount: product.designer_discount,
    price_unit: product.price_unit || "",
    cover_image: coverImage,
    gallery,
    description: product.description || "",
    space_tags: parseArray(product.space_tags),
    scene_tags: parseArray(product.scene_tags),
    specs: parseSpecs(product),
    regions: parseArray(product.regions),
    scene_images: sceneImages,
    element_images: elementImages,
    spec_images: specImages,
    source_files: sourceFiles,
    download_images: downloadImages
  };
}

function buildFeedPrice(product = {}) {
  const role = userStore.getRole();
  if (!role) {
    return {
      visible: false,
      label: "登录后查看",
      amount: null,
      unit: product.price_unit || ""
    };
  }
  return {
    visible: true,
    label: role === 2 ? "设计师价" : "指导价",
    amount: role === 2 && product.designer_price ? product.designer_price : product.guide_price,
    unit: product.price_unit || ""
  };
}

function normalizeFeedItem(item = {}) {
  if (item.type) {
    return {
      type: item.type,
      id: item.id,
      title: item.title || "",
      cover_image: toAbsoluteUrl(item.cover_image || item.coverImage || ""),
      subtitle: item.subtitle || "",
      tags: parseArray(item.tags).slice(0, 3),
      price: item.price || { visible: false, label: "登录后查看", amount: null, unit: "" },
      action: item.action || ""
    };
  }

  const product = normalizeProduct(item);
  const tags = []
    .concat(product.scene_tags || [])
    .concat(product.space_tags || [])
    .filter(Boolean)
    .slice(0, 3);
  return {
    type: "product",
    id: product.id,
    title: product.name,
    cover_image: product.cover_image,
    subtitle: product.brand || product.category_name || "柏厚生活",
    tags,
    price: buildFeedPrice(product),
    action: `/pages/product/detail/index?id=${product.id}`
  };
}

function applyMockFilters(items, params = {}) {
  return items.filter((item) => {
    if (params.keyword && !`${item.name}${item.brand}`.includes(params.keyword)) {
      return false;
    }
    if (params.category_id && Number(item.category_id) !== Number(params.category_id)) {
      return false;
    }
    if (params.space && !item.space_tags.includes(params.space)) {
      return false;
    }
    if (params.scene && !item.scene_tags.includes(params.scene)) {
      return false;
    }
    if (params.region_id && !(item.regions.includes("ALL") || item.regions.includes(params.region_id))) {
      return false;
    }
    return true;
  });
}

function applyMockSort(items, sortBy) {
  const rows = [...items];
  if (sortBy === "price_desc") {
    rows.sort((a, b) => Number(b.guide_price || 0) - Number(a.guide_price || 0));
  } else if (sortBy === "price_asc") {
    rows.sort((a, b) => Number(a.guide_price || 0) - Number(b.guide_price || 0));
  } else {
    rows.sort((a, b) => Number(a.id) - Number(b.id));
  }
  return rows;
}

function buildPagedResult(items, pageNum, pageSize) {
  const safePageNum = Number(pageNum || 1);
  const safePageSize = Number(pageSize || DEFAULT_PAGE_SIZE);
  const start = (safePageNum - 1) * safePageSize;
  const rows = items.slice(start, start + safePageSize).map(normalizeProduct);
  return {
    rows,
    total: items.length,
    pageNum: safePageNum,
    pageSize: safePageSize,
    hasMore: start + rows.length < items.length
  };
}

async function listProducts(params = {}) {
  if (env.useMock) {
    const filtered = applyMockSort(applyMockFilters(mock.products, params), params.sort_by);
    return mock.delay(buildPagedResult(filtered, params.pageNum, params.pageSize));
  }
  const response = await request({
    url: "/v2/product/list",
    data: {
      pageNum: params.pageNum || 1,
      pageSize: params.pageSize || DEFAULT_PAGE_SIZE,
      ...params
    }
  });
  const rows = (response.rows || response.data || []).map(normalizeProduct);
  const total = Number(response.total || rows.length);
  const pageNum = Number(params.pageNum || 1);
  const pageSize = Number(params.pageSize || DEFAULT_PAGE_SIZE);
  return {
    rows,
    total,
    pageNum,
    pageSize,
    hasMore: pageNum * pageSize < total
  };
}

async function getFeed(params = {}) {
  if (env.useMock) {
    const filtered = applyMockSort(applyMockFilters(mock.products, {
      region_id: params.region_id
    }), "default");
    const safePageNum = Number(params.pageNum || 1);
    const safePageSize = Number(params.pageSize || DEFAULT_FEED_PAGE_SIZE);
    const start = (safePageNum - 1) * safePageSize;
    const rows = filtered
      .slice(start, start + safePageSize)
      .map(normalizeFeedItem)
      .filter((item) => item.cover_image);
    return mock.delay({
      rows,
      total: filtered.length,
      pageNum: safePageNum,
      pageSize: safePageSize,
      hasMore: start + rows.length < filtered.length
    });
  }

  const response = await request({
    url: "/v1/feed/list",
    data: {
      pageNum: params.pageNum || 1,
      pageSize: params.pageSize || DEFAULT_FEED_PAGE_SIZE,
      ...params
    }
  });
  const rows = (response.rows || []).map(normalizeFeedItem);
  const total = Number(response.total || rows.length);
  const pageNum = Number(params.pageNum || 1);
  const pageSize = Number(params.pageSize || DEFAULT_FEED_PAGE_SIZE);
  return {
    rows,
    total,
    pageNum,
    pageSize,
    hasMore: pageNum * pageSize < total
  };
}

async function getProductDetail(id, region_id) {
  if (env.useMock) {
    const product = mock.products.find((item) => item.id === Number(id) && (item.regions.includes("ALL") || item.regions.includes(region_id)));
    return mock.delay(product ? normalizeProduct(product) : null);
  }
  const response = await request({
    url: `/v2/product/${id}`,
    data: { region_id }
  });
  return response.data ? normalizeProduct(response.data) : null;
}

async function getCategories() {
  if (env.useMock) {
    return mock.delay({
      categories: mock.categories,
      spaces: mock.spaces,
      scenes: mock.scenes
    });
  }
  const response = await request({
    url: "/v1/product/categories"
  });
  return response.data || { categories: [], spaces: [], scenes: [] };
}

module.exports = {
  getFeed,
  listProducts,
  getProductDetail,
  getCategories
};
