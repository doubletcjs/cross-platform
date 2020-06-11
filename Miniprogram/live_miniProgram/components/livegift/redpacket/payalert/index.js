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
    },
    //标题
    title: {
      type: String,
      value: "发红包"
    },
    //金币数
    content: {
      type: String,
      value: ""
    },
    //账户余额
    subcontent: {
      type: String,
      value: ""
    },
    //背景颜色
    backgroundColor: {
      type: String,
      value: "rgba(255, 255, 255, 1)"
    },
    //取消（左侧）按钮文字
    cancelString: {
      type: String,
      value: "取消"
    },
    //确定（右侧）按钮文字
    confirmString: {
      type: String,
      value: "确认支付"
    },
    //取消（左侧）按钮文字颜色
    cancelTextColor: {
      type: String,
      value: "rgba(136, 136, 136, 1)"
    },
    //确定（右侧）按钮文字颜色
    confirmTextColor: {
      type: String,
      value: "rgba(23, 96, 255, 1)"
    },
    //logo
    logo: {
      type: String,
      value: ""
    },
    //标题字体颜色
    titleTextColor: {
      type: String,
      value: "rgba(53, 53, 53, 1)"
    },
    //标题字体大小
    titleFontSize: {
      type: Number,
      value: 36
    },
    //账户余额字体颜色
    subcontentTextColor: {
      type: String,
      value: "rgba(0, 0, 0, 0.3)"
    },
    //账户余额字体大小
    subcontentFontSize: {
      type: Number,
      value: 28
    },
    //可输入金额
    inputValue: {
      type: Boolean,
      value: false
    }
  },
  data: {
    inputPlaceholder: "0",
    inputNumber: ""
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

        if (this.data.inputValue == true) {
          this.setData({
            inputNumber: ""
          })
        }
      }, 400)
    },
    //确定（右侧）按钮动作
    confirmAction() {
      this.closePopup();
      if (this.data.inputValue == true) {
        setTimeout(() => {
          this.triggerEvent("confirm", {
            number: this.data.inputNumber
          })

          this.setData({
            inputNumber: ""
          })
        }, 400)
      } else {
        setTimeout(() => {
          this.triggerEvent("confirm")
        }, 400)
      }
    },
    //居中弹框屏蔽外部遮罩层关闭动作
    emptyAction() {},
    //输入框获取焦点
    bindFocus() {
      this.setData({
        inputPlaceholder: ""
      })
    },
    //输入框失去焦点
    bindBlur() {
      this.setData({
        inputPlaceholder: "0"
      })
    },
    //输入框内容变化
    bindInput(res) {
      this.setData({
        inputNumber: res.detail.value
      })
    },
    //增加
    addAction() {
      var number = parseInt(this.data.inputNumber.length == 0 ? "0" : this.data.inputNumber)
      if (number < 9999) {
        number += 1
      }

      this.setData({
        inputNumber: number.toString()
      })
    },
    //减少
    subtractionAction() {
      var number = parseInt(this.data.inputNumber.length == 0 ? "0" : this.data.inputNumber)
      if (number > 0) {
        number -= 1
      }

      this.setData({
        inputNumber: number.toString()
      })
    }
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