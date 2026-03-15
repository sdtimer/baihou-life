const appointmentService = require("../../../services/appointment");
const regionStore = require("../../../store/region");

 function buildPreferredDateText(form) {
  return form.preferred_date || "选择预约日期";
 }

Page({
  data: {
    minDate: "",
    serviceTypes: [
      { label: "量尺", value: "measure" },
      { label: "配送", value: "delivery" },
      { label: "安装", value: "install" }
    ],
    form: {
      customer_name: "",
      customer_phone: "",
      service_type: "measure",
      preferred_date: "",
      remark: ""
    },
    preferredDateText: "选择预约日期"
  },

  onLoad() {
    this.setData({
      minDate: new Date().toISOString().slice(0, 10)
    });
  },

  bindField(event) {
    const { field } = event.currentTarget.dataset;
    const nextForm = {
      ...this.data.form,
      [field]: event.detail.value
    };
    this.setData({
      [`form.${field}`]: event.detail.value,
      preferredDateText: buildPreferredDateText(nextForm)
    });
  },

  pickService(event) {
    this.setData({
      "form.service_type": event.currentTarget.dataset.value
    });
  },

  async submit() {
    const { form } = this.data;
    if (!form.preferred_date) {
      wx.showToast({ title: "请选择预约日期", icon: "none" });
      return;
    }
    await appointmentService.createAppointment({
      ...form,
      region_id: regionStore.getState().current.region_id
    });
    wx.showToast({ title: "预约已提交", icon: "success" });
    setTimeout(() => wx.navigateBack(), 500);
  }
});
