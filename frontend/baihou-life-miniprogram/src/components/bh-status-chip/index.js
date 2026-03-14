const palette = {
  pending: "warning",
  pending_pay: "warning",
  confirmed: "info",
  in_progress: "info",
  paid: "info",
  processing: "info",
  shipped: "success",
  completed: "success",
  closed: "error",
  cancelled: "error"
};

Component({
  properties: {
    status: String,
    text: String
  },
  observers: {
    status(value) {
      this.setData({ tone: palette[value] || "info" });
    }
  },
  data: {
    tone: "info"
  }
});
