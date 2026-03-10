import request from "@/utils/request"

export function listDesigners() {
  return request({
    url: "/admin/designers",
    method: "get"
  })
}

export function addDesigner(data) {
  return request({
    url: "/admin/designers",
    method: "post",
    data
  })
}

export function updateDesigner(id, data) {
  return request({
    url: `/admin/designers/${id}`,
    method: "put",
    data
  })
}

export function toggleDesignerStatus(id) {
  return request({
    url: `/admin/designers/${id}/toggle`,
    method: "patch"
  })
}
