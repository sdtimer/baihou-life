Page({
  data: {
    statusBarHeight: 20,
    navBarHeight: 64,
    regionOptions: [
      { label: '杭州', value: 'hangzhou' },
      { label: '上海', value: 'shanghai' },
      { label: '北京', value: 'beijing' },
      { label: '深圳', value: 'shenzhen' },
      { label: '广州', value: 'guangzhou' }
    ],
    stageOptions: [
      { label: '毛坯房', value: 'rough' },
      { label: '精装房', value: 'hardcover' },
      { label: '二手房改造', value: 'renovation' }
    ],
    styleOptions: [
      { label: '现代简约', value: 'modern' },
      { label: '北欧风', value: 'nordic' },
      { label: '日式', value: 'japanese' },
      { label: '新中式', value: 'chinese' },
      { label: '轻奢', value: 'luxury' },
      { label: '工业风', value: 'industrial' }
    ],
    form: {
      name: '',
      phone: '',
      region: '',
      area: '',
      stage: '',
      style: 'modern',
      remark: ''
    },
    agreed: false,
    regionLabel: '',
    stageLabel: '',
    pickerVisible: false,
    pickerTitle: '',
    pickerOptions: [],
    tempPickerValue: '',
    currentPickerField: ''
  },

  onLoad() {
    const { statusBarHeight } = wx.getSystemInfoSync();
    const navBarHeight = (statusBarHeight || 20) + 44;
    this.setData({
      statusBarHeight: statusBarHeight || 20,
      navBarHeight: navBarHeight
    });
  },

  onInput(e) {
    const { field } = e.currentTarget.dataset;
    this.setData({
      [`form.${field}`]: e.detail.value
    });
  },

  openRegionPicker() {
    const selected = this.data.regionOptions.find(item => item.value === this.data.form.region);
    this.setData({
      pickerVisible: true,
      pickerTitle: '所在区域',
      pickerOptions: this.data.regionOptions,
      tempPickerValue: this.data.form.region,
      currentPickerField: 'region'
    });
  },

  openStagePicker() {
    this.setData({
      pickerVisible: true,
      pickerTitle: '装修阶段',
      pickerOptions: this.data.stageOptions,
      tempPickerValue: this.data.form.stage,
      currentPickerField: 'stage'
    });
  },

  closePicker() {
    this.setData({ pickerVisible: false });
  },

  selectPickerOption(e) {
    const { value } = e.currentTarget.dataset;
    this.setData({ tempPickerValue: value });
  },

  confirmPicker() {
    const { tempPickerValue, currentPickerField, pickerOptions } = this.data;
    const selected = pickerOptions.find(item => item.value === tempPickerValue);
    const label = selected ? selected.label : '';
    
    this.setData({
      [`form.${currentPickerField}`]: tempPickerValue,
      [`${currentPickerField}Label`]: label,
      pickerVisible: false
    });
  },

  preventMove() {},

  onStyleSelect(e) {
    const { value } = e.currentTarget.dataset;
    this.setData({
      'form.style': value
    });
  },

  onAgree() {
    this.setData({
      agreed: !this.data.agreed
    });
  },

  onSubmit() {
    const { form, agreed } = this.data;
    
    if (!form.name) {
      wx.showToast({ title: '请输入姓名', icon: 'none' });
      return;
    }
    if (!form.phone) {
      wx.showToast({ title: '请输入手机号', icon: 'none' });
      return;
    }
    if (!form.region) {
      wx.showToast({ title: '请选择区域', icon: 'none' });
      return;
    }
    if (!agreed) {
      wx.showToast({ title: '请同意服务协议', icon: 'none' });
      return;
    }

    wx.showToast({ title: '提交成功', icon: 'success' });
  }
});