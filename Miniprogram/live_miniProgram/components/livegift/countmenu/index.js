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
    //按钮列表
    items: {
      type: Array,
      value: ["888", "66", "8", "1", "28", "41"]
    },
    bottomSpace: {
      type: Number,
      value: 66.0
    },
    rightSpace: {
      type: Number,
      value: 30.0
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
    //居中弹框屏蔽外部遮罩层关闭动作
    emptyAction() {},
    //列表按钮动作
    listItemAction(res) {
      this.closePopup();
      setTimeout(() => {
        this.triggerEvent("itemselect", {
          count: this.data.items[res.currentTarget.dataset.index]
        })
      }, 400)
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