import request from "@/utils/request"

export function listCategories() {
  return request({
    url: "/admin/categories/list",
    method: "get"
  })
}

export function getCategory(categoryId) {
  return request({
    url: `/admin/categories/${categoryId}`,
    method: "get"
  })
}

export function addCategory(data) {
  return request({
    url: "/admin/categories",
    method: "post",
    data
  })
}

export function updateCategory(data) {
  return request({
    url: "/admin/categories",
    method: "put",
    data
  })
}

export function changeCategoryStatus(categoryId, isActive) {
  return request({
    url: `/admin/categories/${categoryId}/status/${isActive}`,
    method: "put"
  })
}
