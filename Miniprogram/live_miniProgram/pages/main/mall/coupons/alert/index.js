//Component Object
Component({
  properties: {
    //是否弹出显示
    visible: {
      type: Boolean,
      value: false
    },
    //点击外部的遮罩层是否允许关闭
    outClickCanClose: {
      type: Boolean,
      value: true
    }
  },
  data: {
    inputValue: ""
  },
  methods: {
    //关闭alert
    closePopup() {
      this.triggerEvent("close", {
        visible: this.data.visible
      })
    },
    //点击外部的遮罩层关闭动作
    outClick() {
      if (this.data.outClickCanClose == true) {
        this.closePopup()
      }
    },
    //取消（左侧）按钮动作
    cancelAction() {
      this.closePopup()
      setTimeout(() => {
        this.triggerEvent("cancel")
      }, 400)
    },
    //确定（右侧）按钮动作
    confirmAction() {
      this.closePopup();
      setTimeout(() => {
        this.triggerEvent("confirm", {
          conversion: this.data.inputValue
        })
      }, 400)
    },
    //居中弹框屏蔽外部遮罩层关闭动作
    emptyAction() {},
    //兑换码输入
    conversionInput(res) {
      var value = res.detail.value
      this.setData({
        inputValue: value
      })
    },
  },
  created: function () {

  },
  attached: function () {

  },
  ready: function () {

  },
  moved: function () {

  },
  detached: function () {

  },
});