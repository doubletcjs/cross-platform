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
    buttonList: [
      "排行榜",
      "观众"
    ],
    currentIndex: 0,
    dataList: [{
      level: "/icons/f0@2x.png",
      header: "/icons/icon_chat_recharge@2x.png",
      name: "9点"
    }, {
      level: "/icons/f1@2x.png",
      header: "/icons/icon_chat_recharge@2x.png",
      name: "9点"
    }, {
      level: "/icons/f2@2x.png",
      header: "/icons/icon_chat_recharge@2x.png",
      name: "9点"
    }, {
      level: "/icons/f3@2x.png",
      header: "/icons/icon_chat_recharge@2x.png",
      name: "9点"
    }, {
      level: "/icons/s1@2x.png",
      header: "/icons/icon_chat_recharge@2x.png",
      name: "9点"
    }, {
      level: "/icons/s2@2x.png",
      header: "/icons/icon_chat_recharge@2x.png",
      name: "9点"
    }, {
      level: "/icons/s3@2x.png",
      header: "/icons/icon_chat_recharge@2x.png",
      name: "9点"
    }, {
      level: "/icons/f0@2x.png",
      header: "/icons/icon_chat_recharge@2x.png",
      name: "9点"
    }],
    contributionList: [{
        level: "/icons/f0@2x.png",
        header: "/icons/icon_chat_recharge@2x.png",
        name: "9点",
        contribution: 5000
      },
      {
        level: "/icons/s3@2x.png",
        header: "/icons/icon_chat_recharge@2x.png",
        name: "布道者",
        contribution: 5000
      }, {
        level: "/icons/f1@2x.png",
        header: "/icons/icon_chat_recharge@2x.png",
        name: "Sam",
        contribution: 5000
      }, {
        level: "/icons/f3@2x.png",
        header: "/icons/icon_chat_recharge@2x.png",
        name: "Marry",
        contribution: 5000
      }
    ]
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
    //按钮
    functionAction(res) {
      let index = res.currentTarget.dataset.index
      this.setData({
        currentIndex: index
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