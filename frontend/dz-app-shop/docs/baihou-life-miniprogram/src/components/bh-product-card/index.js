Component({
  properties: {
    item: Object,
    showDesigner: Boolean
  },
  methods: {
    handleTap() {
      this.triggerEvent("tap", this.properties.item);
    }
  }
});
