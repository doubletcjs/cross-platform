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
    //是否横屏
    landscape: {
      type: Boolean,
      value: false
    },
  },
  data: {
    functionItems: [{
        "name": "分享给微信好友",
        "icon": "/icons/ico_share_wx@3x.png"
      },
      // {
      //   "name": "分享到朋友圈",
      //   "icon": "/icons/ico_share_pyq@3x.png"
      // },
      // {
      //   "name": "分享给QQ好友",
      //   "icon": "/icons/ico_share_qq@3x.png"
      // },
      {
        "name": "保存到相册",
        "icon": "/icons/ico_share_xc@3x.png"
      },
      {
        "name": "复制链接",
        "icon": "/icons/ico_share_lj@3x.png"
      },
    ],
    pages: []
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
      var name = res.currentTarget.dataset.row.name
      console.log("name:" + name)
      this.closePopup();
      setTimeout(() => {
        // this.triggerEvent("itemselect", {
        //   name: name
        // })
        if (name == "复制链接") {
          var that = this;
          wx.setClipboardData({
            data: "复制内容",
            success: (result) => {
              wx.showToast({
                title: "链接复制成功",
              });
            },
            fail: () => {
              wx.showToast({
                title: "复制失败",
                icon: "none",
              });
            },
            complete: () => {}
          });
        } else if (name == "保存到相册") {
          wx.saveImageToPhotosAlbum({
            filePath: "不支持网络图片路径",
            success: (result) => {
              wx.showToast({
                title: "保存成功",
              });
            },
            fail: () => {
              wx.showToast({
                title: "保存失败",
                icon: "none",
              });
            },
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
    var maxRowInPage = 5
    if (this.data.landscape) {
      maxRowInPage = 8
    }
    var maxPage = this.data.functionItems.length % maxRowInPage > 0 ? parseInt(this.data.functionItems.length / maxRowInPage) + 1 : parseInt(this.data.functionItems.length / maxRowInPage)
    var _pages = []
    for (let index = 0; index < maxPage; index++) {
      var array = this.data.functionItems.slice(index * maxRowInPage, (index + 1) * maxRowInPage)
      _pages.push(array)
    }

    this.setData({
      pages: _pages
    })
  },
  moved: function () {

  },
  detached: function () {

  },
});