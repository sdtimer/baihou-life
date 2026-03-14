import request from "@/utils/request"

export function listProducts(params) {
  return request({
    url: "/admin/products",
    method: "get",
    params
  })
}

export function getProduct(id) {
  return request({
    url: `/admin/products/${id}`,
    method: "get"
  })
}

export function addProduct(data) {
  return request({
    url: "/admin/products",
    method: "post",
    data
  })
}

export function updateProduct(id, data) {
  return request({
    url: `/admin/products/${id}`,
    method: "put",
    data
  })
}

export function changeProductStatus(id, status) {
  return request({
    url: `/admin/products/${id}/status/${status}`,
    method: "put"
  })
}

export function batchProductAction(data) {
  return request({
    url: "/admin/products/batch",
    method: "post",
    data
  })
}

export function removeProduct(id) {
  return request({
    url: `/admin/products/${id}`,
    method: "delete"
  })
}
