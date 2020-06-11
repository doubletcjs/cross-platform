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
    itemList: [{
        "name": "发讨论",
        "icon": "/icons/ico_release_discuss@3x.png"
      },
      {
        "name": "发文章",
        "icon": "/icons/ico_release_article@3x.png"
      },
      {
        "name": "发视频",
        "icon": "/icons/ico_release_video@3x.png"
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
    //取消按钮动作
    cancelAction() {
      this.closePopup()
    },
    //选择
    itemSelectAction(res) {
      var index = res.currentTarget.dataset.index
      if (index == 0) {
        wx.navigateTo({
          url: '/pages/main/community/postcomment/index',
          success: (result) => {

          },
          fail: () => {},
          complete: () => {}
        });
      } else if (index == 1) {
        wx.navigateTo({
          url: '/pages/main/community/writeArticle/index',
          success: (result) => {

          },
          fail: () => {},
          complete: () => {}
        });
      }

      setTimeout(() => {
        this.closePopup()
      }, 600);
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