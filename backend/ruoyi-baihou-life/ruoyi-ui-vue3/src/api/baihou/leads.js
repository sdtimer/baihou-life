import request from "@/utils/request"

export function listLeads(params) {
  return request({
    url: "/admin/leads",
    method: "get",
    params
  })
}

export function updateLead(id, data) {
  return request({
    url: `/admin/leads/${id}`,
    method: "patch",
    data
  })
}

export function exportLeads(params) {
  return request({
    url: "/admin/leads/export",
    method: "get",
    params
  })
}
