import request from "@/utils/request"

export function listBanners() {
  return request({
    url: "/admin/banners",
    method: "get"
  })
}

export function addBanner(data) {
  return request({
    url: "/admin/banners",
    method: "post",
    data
  })
}

export function updateBanner(id, data) {
  return request({
    url: `/admin/banners/${id}`,
    method: "put",
    data
  })
}

export function removeBanner(id) {
  return request({
    url: `/admin/banners/${id}`,
    method: "delete"
  })
}
