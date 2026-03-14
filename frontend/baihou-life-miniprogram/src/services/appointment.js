const env = require("../config/env");
const request = require("../utils/request");
const mock = require("../utils/mock");

const REGION_NAMES = {
  foshan: "佛山",
  chengdu: "成都",
  wuhan: "武汉"
};

const SERVICE_TYPE_TEXT = {
  measure: "量尺",
  delivery: "配送",
  install: "安装"
};

function formatDateText(value) {
  if (!value) {
    return "";
  }
  if (typeof value === "string") {
    return value.slice(0, 10);
  }
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) {
    return "";
  }
  return date.toISOString().slice(0, 10);
}

function normalizeAppointment(item = {}) {
  return {
    appointment_id: item.appointment_id || item.appointmentId,
    appointment_no: item.appointment_no || item.appointmentNo || "",
    customer_name: item.customer_name || item.customerName || "",
    customer_phone: item.customer_phone || item.customerPhone || "",
    service_type: item.service_type || item.serviceType || "",
    service_type_text: SERVICE_TYPE_TEXT[item.service_type || item.serviceType] || item.service_type || item.serviceType || "",
    preferred_date: formatDateText(item.preferred_date || item.preferredDate),
    region_id: item.region_id || item.regionId || "",
    region_name: item.region_name || item.regionName || REGION_NAMES[item.region_id || item.regionId] || "",
    remark: item.remark || "",
    status: item.status || "",
    create_time: formatDateText(item.create_time || item.createTime)
  };
}

async function createAppointment(payload) {
  if (env.useMock) {
    return mock.delay({
      code: 200,
      data: normalizeAppointment({
        appointment_id: Date.now(),
        appointment_no: `APT${Date.now()}`,
        ...payload,
        status: "pending"
      })
    });
  }
  return request({
    url: "/v1/appointment/create",
    method: "POST",
    data: payload
  });
}

async function listAppointments() {
  if (env.useMock) {
    return mock.delay(mock.appointments.map(normalizeAppointment));
  }
  const response = await request({
    url: "/v1/appointment/list"
  });
  return (response.data || response.rows || []).map(normalizeAppointment);
}

async function getAppointmentDetail(appointmentId) {
  if (env.useMock) {
    const target = mock.appointments.find((item) => item.appointment_id === Number(appointmentId));
    return mock.delay(target ? normalizeAppointment(target) : null);
  }
  const response = await request({
    url: `/v1/appointment/${appointmentId}`
  });
  return response.data ? normalizeAppointment(response.data) : null;
}

module.exports = {
  createAppointment,
  listAppointments,
  getAppointmentDetail
};
