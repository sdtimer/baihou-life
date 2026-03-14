import request from "@/utils/request"

export function listOrders(params) {
  return request({
    url: "/admin/orders",
    method: "get",
    params
  })
}

export function getOrder(id) {
  return request({
    url: `/admin/orders/${id}`,
    method: "get"
  })
}

export function updateOrder(id, data) {
  return request({
    url: `/admin/orders/${id}`,
    method: "patch",
    data
  })
}
