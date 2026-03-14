const appointmentService = require("../../../services/appointment");
const auth = require("../../../utils/auth");
const regionStore = require("../../../store/region");
const userStore = require("../../../store/user");

 function buildPreferredDateText(form) {
  return form.preferred_date || "选择预约日期";
 }

Page({
  data: {
    submitting: false,
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
    if (!auth.requireLogin({ redirect: "/pages/appointment/create/index" })) {
      return;
    }
    const profile = userStore.getState().profile;
    this.setData({
      minDate: new Date().toISOString().slice(0, 10),
      "form.customer_name": profile.nickname || "",
      "form.customer_phone": profile.phone || ""
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
    if (!form.customer_name) {
      wx.showToast({ title: "请输入预约人姓名", icon: "none" });
      return;
    }
    if (!/^1\d{10}$/.test(form.customer_phone)) {
      wx.showToast({ title: "请输入正确手机号", icon: "none" });
      return;
    }
    if (!form.service_type) {
      wx.showToast({ title: "请选择服务类型", icon: "none" });
      return;
    }
    if (!form.preferred_date) {
      wx.showToast({ title: "请选择预约日期", icon: "none" });
      return;
    }
    this.setData({ submitting: true });
    try {
      await appointmentService.createAppointment({
        ...form,
        region_id: regionStore.getState().current.region_id
      });
      wx.showToast({ title: "预约已提交", icon: "success" });
      setTimeout(() => wx.navigateBack(), 500);
    } catch (error) {
      wx.showToast({
        title: error.msg || "预约提交失败",
        icon: "none"
      });
    } finally {
      this.setData({ submitting: false });
    }
  }
});
