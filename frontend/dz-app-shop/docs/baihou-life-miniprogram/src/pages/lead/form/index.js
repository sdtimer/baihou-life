const leadService = require("../../../services/lead");
const regionStore = require("../../../store/region");

Page({
  data: {
    form: {
      name: "",
      phone: "",
      intention: "",
      product_id: "",
      product_name: ""
    }
  },

  onLoad(options) {
    this.setData({
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
    if (!/^1\d{10}$/.test(form.phone)) {
      wx.showToast({ title: "请输入正确手机号", icon: "none" });
      return;
    }
    await leadService.submitLead({
      ...form,
      region_id: regionStore.getState().current.region_id
    });
    wx.showToast({ title: "提交成功", icon: "success" });
    setTimeout(() => wx.navigateBack(), 500);
  }
});
