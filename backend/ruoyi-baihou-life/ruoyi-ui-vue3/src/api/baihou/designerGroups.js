import request from "@/utils/request"

export function listDesignerGroups() {
  return request({
    url: "/admin/designer-groups",
    method: "get"
  })
}

export function addDesignerGroup(data) {
  return request({
    url: "/admin/designer-groups",
    method: "post",
    data
  })
}

export function updateDesignerGroup(id, data) {
  return request({
    url: `/admin/designer-groups/${id}`,
    method: "put",
    data
  })
}
