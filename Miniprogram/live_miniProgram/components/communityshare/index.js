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
    //生成二维码分享页 7x24
    qrcodeSharePage: {
      type: Boolean,
      value: false
    },
    //qrcodeSharePage为true时。qrcodeInfo里面对应参数必须齐全。
    qrcodeInfo: {
      type: Object,
      value: {
        title: "华科闪云7X24小时快讯",
        date: "05-27 14:00",
        content: "Filecoin官方：二阶段测试网开始时间：5月11日左右,主网启动时间：7月20日-8月21日",
        shareurl: "" //用于生成二维码 
      }
    },
    //默认内容、图标，投诉在插件里面跳转。其它的根据name在对应的page里面回调处理
    shareItems: {
      type: Array,
      value: [{
        "name": "分享给微信好友",
        "icon": "/icons/ico_share_wx@3x.png"
      }, {
        "name": "收藏",
        "icon": "/icons/ico_community_share_collection@3x.png"
      }, {
        "name": "分享链接",
        "icon": "/icons/ico_community_share_link@3x.png"
      }, {
        "name": "浏览器打开",
        "icon": "/icons/ico_community_share_browser@3x.png"
      }, {
        "name": "投诉",
        "icon": "/icons/ico_community_share_complaint@3x.png"
      }, ]
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
    //取消按钮动作
    cancelAction() {
      this.closePopup()
    },
    //居中弹框屏蔽外部遮罩层关闭动作
    emptyAction() {},
    //点击选择内容
    itemTapAction(res) {
      var name = this.data.shareItems[res.currentTarget.dataset.index]["name"]
      console.log("name:" + name)
      this.closePopup();
      setTimeout(() => {
        this.triggerEvent("itemselect", {
          name: name
        })

        if (name == "投诉") {
          wx.navigateTo({
            url: '/pages/main/community/complaints/index',
            success: (result) => {

            },
            fail: () => {},
            complete: () => {}
          });
        }
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