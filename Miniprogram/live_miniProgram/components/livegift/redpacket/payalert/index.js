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
    }
  },
  data: {

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
        this.triggerEvent("confirm")
      }, 400)
    },
    //居中弹框屏蔽外部遮罩层关闭动作
    emptyAction() {},
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