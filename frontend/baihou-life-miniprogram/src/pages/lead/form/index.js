const leadService = require("../../../services/lead");
const auth = require("../../../utils/auth");
const regionStore = require("../../../store/region");
const userStore = require("../../../store/user");

Page({
  data: {
    submitting: false,
    form: {
      name: "",
      phone: "",
      intention: "",
      product_id: "",
      product_name: ""
    }
  },

  onLoad(options) {
    if (!auth.requireLogin({
      redirect: `/pages/lead/form/index?product_id=${options.product_id || ""}&name=${encodeURIComponent(options.name ? decodeURIComponent(options.name) : "")}`
    })) {
      return;
    }
    const profile = userStore.getState().profile;
    this.setData({
      "form.name": profile.nickname || "",
      "form.phone": profile.phone || "",
      "form.product_id": options.product_id || "",
      "form.product_name": options.name ? decodeURIComponent(options.name) : ""
    });
  },

  bindField(event) {
    const { field } = event.currentTarget.dataset;
    this.setData({
      [`form.${field}`]: event.detail.value
    });
  },

  async submit() {
    const { form } = this.data;
    if (!form.name) {
      wx.showToast({ title: "请输入称呼", icon: "none" });
      return;
    }
    if (!/^1\d{10}$/.test(form.phone)) {
      wx.showToast({ title: "请输入正确手机号", icon: "none" });
      return;
    }
    this.setData({ submitting: true });
    try {
      await leadService.submitLead({
        ...form,
        region_id: regionStore.getState().current.region_id
      });
      wx.showToast({ title: "提交成功", icon: "success" });
      setTimeout(() => wx.navigateBack(), 500);
    } catch (error) {
      wx.showToast({
        title: error.msg || "提交失败，请稍后重试",
        icon: "none"
      });
    } finally {
      this.setData({ submitting: false });
    }
  }
});
