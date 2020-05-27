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
    titleString: {
      type: String,
      value: ''
    },
    //标题颜色
    titleColorString: {
      type: String,
      value: 'rgba(255, 52, 101, 0.5)'
    },
    //取消按钮
    cancelString: {
      type: String,
      value: '取消'
    },
    //按钮列表
    items: {
      type: Array,
      value: ['在线充值', 'usdt充值']
    },
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
    //取消按钮动作
    cancelAction() {
      this.closePopup()
    },
    //列表按钮动作
    listItemAction(res) {
      this.closePopup();
      setTimeout(() => {
        this.triggerEvent("itemselect", {
          index: res.target.dataset.index
        })
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