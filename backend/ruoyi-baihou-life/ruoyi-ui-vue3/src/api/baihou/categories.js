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

export function listSpecDefs(categoryId) {
  return request({
    url: `/admin/categories/${categoryId}/spec-defs`,
    method: "get"
  })
}

export function addSpecDef(categoryId, data) {
  return request({
    url: `/admin/categories/${categoryId}/spec-defs`,
    method: "post",
    data
  })
}

export function updateSpecDef(categoryId, specDefId, data) {
  return request({
    url: `/admin/categories/${categoryId}/spec-defs/${specDefId}`,
    method: "put",
    data
  })
}

export function removeSpecDef(categoryId, specDefId) {
  return request({
    url: `/admin/categories/${categoryId}/spec-defs/${specDefId}`,
    method: "delete"
  })
}
