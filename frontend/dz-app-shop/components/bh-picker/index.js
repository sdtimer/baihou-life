Component({
  options: {
    styleIsolation: 'shared'
  },
  
  properties: {
    label: {
      type: String,
      value: ''
    },
    placeholder: {
      type: String,
      value: '请选择'
    },
    title: {
      type: String,
      value: ''
    },
    options: {
      type: Array,
      value: []
    },
    value: {
      type: null,
      value: ''
    },
    disabled: {
      type: Boolean,
      value: false
    }
  },

  data: {
    displayValue: ''
  },

  observers: {
    'value, options': function(value, options) {
      const selected = options.find(item => item.value === value);
      this.setData({
        displayValue: selected ? selected.label : ''
      });
    }
  },

  methods: {
    handleTap() {
      if (this.properties.disabled) return;
      this.triggerEvent('open', {
        title: this.properties.title || this.properties.label || '请选择',
        options: this.properties.options,
        value: this.properties.value
      });
    }
  }
});