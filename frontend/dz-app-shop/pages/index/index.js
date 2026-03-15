Page({
  data: {
    regionOptions: [
      { label: "全部", value: "all" },
      { label: "成都", value: "hangzhou" },
      { label: "佛山", value: "shanghai" },
    ],
    currentRegion: "all",
    regionLabel: "全部",
    pickerVisible: false,
    tempPickerValue: "",
    currentTab: "category",
    categoryProducts: [
      {
        id: 1,
        name: "TOTO 浴室柜",
        desc: "暖木色与石材结合",
        price: "1,088",
        originalPrice: "1,280",
        image:
          "https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=400&h=300&fit=crop",
      },
      {
        id: 2,
        name: "岩板岛台组合",
        desc: "储物与社交一体",
        price: "14,280",
        originalPrice: "16,800",
        image:
          "https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400&h=300&fit=crop",
      },
      {
        id: 3,
        name: "定制衣柜系列",
        desc: "多层实木板材",
        price: "8,999",
        originalPrice: "12,999",
        image:
          "https://images.unsplash.com/photo-1558997519-83ea9252edf8?w=400&h=300&fit=crop",
      },
    ],
    spaceProducts: [
      {
        id: 4,
        name: "客厅沙发组合",
        desc: "现代简约风格",
        price: "12,800",
        originalPrice: "15,800",
        image: "https://picsum.photos/400/300?random=4",
      },
      {
        id: 5,
        name: "主卧床品套装",
        desc: "舒适睡眠体验",
        price: "3,280",
        originalPrice: "4,580",
        image: "https://picsum.photos/400/300?random=5",
      },
      {
        id: 6,
        name: "餐厅餐桌椅",
        desc: "北欧简约设计",
        price: "6,880",
        originalPrice: "8,880",
        image: "https://picsum.photos/400/300?random=6",
      },
    ],
    sceneProducts: [
      {
        id: 7,
        name: "极简客厅方案",
        desc: "less is more",
        price: "28,800",
        originalPrice: "35,800",
        image: "https://picsum.photos/400/300?random=7",
      },
      {
        id: 8,
        name: "治愈系卧室",
        desc: "温暖舒适空间",
        price: "18,800",
        originalPrice: "24,800",
        image: "https://picsum.photos/400/300?random=8",
      },
      {
        id: 9,
        name: "日式茶室",
        desc: "禅意生活美学",
        price: "22,800",
        originalPrice: "28,800",
        image: "https://picsum.photos/400/300?random=9",
      },
    ],
    products: [],
  },

  onLoad() {
    this.setData({ products: this.data.categoryProducts });
  },

  onRegionChange(e) {
    this.setData({
      currentRegion: e.detail.value,
    });
  },

  showRegionPicker() {
    this.setData({
      pickerVisible: true,
      tempPickerValue: this.data.currentRegion
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
    const { tempPickerValue, regionOptions } = this.data;
    const selected = regionOptions.find(item => item.value === tempPickerValue);
    this.setData({
      currentRegion: tempPickerValue,
      regionLabel: selected ? selected.label : "全部",
      pickerVisible: false
    });
  },

  preventMove() {},

  onTabChange(e) {
    const { tab } = e.currentTarget.dataset;
    const productsKey = `${tab}Products`;
    this.setData({
      currentTab: tab,
      products: this.data[productsKey],
    });
  },

  goGoods(e) {
    const { id } = e.currentTarget.dataset;
    wx.navigateTo({
      url: `/pages/goods/goods?id=${id}`,
    });
  },

  goAppointment() {
    wx.switchTab({
      url: "/pages/appointment/appointment",
    });
  },
});
