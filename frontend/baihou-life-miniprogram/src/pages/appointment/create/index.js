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
    navBarHeight: 64,
    regionOptions: [],
    stageOptions: [
      { label: "毛坯房", value: "rough" },
      { label: "精装房", value: "hardcover" },
      { label: "二手房改造", value: "renovation" }
    ],
    styleOptions: [
      { label: "现代简约", value: "modern" },
      { label: "北欧风", value: "nordic" },
      { label: "日式", value: "japanese" },
      { label: "新中式", value: "chinese" },
      { label: "轻奢", value: "luxury" }
    ],
    regionLabel: "",
    stageLabel: "",
    pickerVisible: false,
    pickerTitle: "",
    pickerOptions: [],
    tempPickerValue: "",
    currentPickerField: "",
    agreed: true,
    serviceTypes: [
      { label: "量尺", value: "measure" },
      { label: "配送", value: "delivery" },
      { label: "安装", value: "install" }
    ],
    form: {
      customer_name: "",
      customer_phone: "",
      region_id: "",
      area: "",
      stage: "",
      style: "modern",
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
    const region = regionStore.getState().current;
    const { statusBarHeight } = wx.getSystemInfoSync();
    this.setData({
      navBarHeight: (statusBarHeight || 20) + 44,
      minDate: new Date().toISOString().slice(0, 10),
      regionOptions: regionStore.getState().regions || [region],
      regionLabel: region.region_name,
      tempPickerValue: region.region_id,
      "form.customer_name": profile.nickname || "",
      "form.customer_phone": profile.phone || "",
      "form.region_id": region.region_id
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

  openRegionPicker() {
    this.setData({
      pickerVisible: true,
      pickerTitle: "所在区域",
      pickerOptions: this.data.regionOptions.map((item) => ({ label: item.region_name, value: item.region_id })),
      tempPickerValue: this.data.form.region_id,
      currentPickerField: "region_id"
    });
  },

  openStagePicker() {
    this.setData({
      pickerVisible: true,
      pickerTitle: "装修阶段",
      pickerOptions: this.data.stageOptions,
      tempPickerValue: this.data.form.stage,
      currentPickerField: "stage"
    });
  },

  closePicker() {
    this.setData({ pickerVisible: false });
  },

  selectPickerOption(event) {
    this.setData({
      tempPickerValue: event.currentTarget.dataset.value
    });
  },

  confirmPicker() {
    const { tempPickerValue, currentPickerField, pickerOptions } = this.data;
    const selected = pickerOptions.find((item) => item.value === tempPickerValue);
    this.setData({
      [`form.${currentPickerField}`]: tempPickerValue,
      regionLabel: currentPickerField === "region_id" ? (selected ? selected.label : this.data.regionLabel) : this.data.regionLabel,
      stageLabel: currentPickerField === "stage" ? (selected ? selected.label : this.data.stageLabel) : this.data.stageLabel,
      pickerVisible: false
    });
  },

  preventMove() {},

  onStyleSelect(event) {
    this.setData({
      "form.style": event.currentTarget.dataset.value
    });
  },

  onAgree() {
    this.setData({
      agreed: !this.data.agreed
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
    if (!form.region_id) {
      wx.showToast({ title: "请选择所在区域", icon: "none" });
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
    if (!this.data.agreed) {
      wx.showToast({ title: "请先同意服务协议", icon: "none" });
      return;
    }
    this.setData({ submitting: true });
    try {
      await appointmentService.createAppointment({
        ...form,
        region_id: form.region_id
      });
      wx.showToast({ title: "预约已提交", icon: "success" });
      setTimeout(() => wx.navigateBack(), 500);
    } catch (error) {
      wx.showToast({
        title: error.message || "预约提交失败",
        icon: "none"
      });
    } finally {
      this.setData({ submitting: false });
    }
  }
});
