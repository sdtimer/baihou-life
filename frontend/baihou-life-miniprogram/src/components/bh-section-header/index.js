Component({
  properties: {
    title: String,
    subtitle: String,
    actionText: String
  },
  methods: {
    handleAction() {
      this.triggerEvent("action");
    }
  }
});
