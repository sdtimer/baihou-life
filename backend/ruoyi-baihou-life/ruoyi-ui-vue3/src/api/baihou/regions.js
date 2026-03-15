import request from "@/utils/request"

export function listRegions() {
  return request({
    url: "/admin/regions/list",
    method: "get"
  })
}

export function getRegion(regionId) {
  return request({
    url: `/admin/regions/${regionId}`,
    method: "get"
  })
}

export function addRegion(data) {
  return request({
    url: "/admin/regions",
    method: "post",
    data
  })
}

export function updateRegion(data) {
  return request({
    url: "/admin/regions",
    method: "put",
    data
  })
}

export function changeRegionStatus(regionId, isActive) {
  return request({
    url: `/admin/regions/${regionId}/status/${isActive}`,
    method: "put"
  })
}

export function getRegionOptions() {
  return request({
    url: "/admin/regions/options",
    method: "get"
  })
}
