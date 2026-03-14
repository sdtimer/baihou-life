import request from "@/utils/request"

export function listAppointments(params) {
  return request({
    url: "/admin/appointments",
    method: "get",
    params
  })
}

export function updateAppointment(id, data) {
  return request({
    url: `/admin/appointments/${id}`,
    method: "patch",
    data
  })
}
