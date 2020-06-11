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
  },
  data: {
    //按钮列表
    items: [{
      "people": "20",
      "coin": "20",
      "icon": "/icons/icon_gift_redpacket_20@3x.png"
    }, {
      "people": "50",
      "coin": "50",
      "icon": "/icons/icon_gift_redpacket_50@3x.png"
    }, {
      "people": "20",
      "coin": "200",
      "icon": "/icons/icon_gift_redpacket_200@3x.png"
    }, ],
    currentIndex: 0
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
    //红包选择
    listItemAction(res) {
      this.setData({
        currentIndex: res.currentTarget.dataset.index
      })
    },
    //发红包
    sendAction() {
      let selectObj = this.data.items[this.data.currentIndex];
      this.triggerEvent('sendredpacketobj', selectObj)
      this.closePopup()
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