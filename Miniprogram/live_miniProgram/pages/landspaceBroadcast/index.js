//Page Object
Page({
  data: {
    buttonItems: [
      "/icons/icon_LiveVideo_barage2@3x.png",
      "/icons/icon_LiveVideo_beautiful@3x.png",
      "/icons/icon_LiveVideo_camera@3x.png",
      "/icons/icon_LiveVideo_estoppel1@3x.png",
      "/icons/icon_LiveVideo_share@3x.png",
    ],
    functionItems: [
      "/icons/icon_LiveVideo_activity@3x.png",
      "/icons/icon_pause@2x.png",
      "/icons/icon_close@3x.png",
    ],
    closevisible: false, //关闭直播提示框
    mute: false, //是否静音
    barrage: true, //是否开启弹幕
    rankinglistvisible: false, //排行榜弹框
    sharevisible: false // 分享框
  },
  //options(Object)
  onLoad: function (options) {

  },
  onReady: function () {

  },
  onShow: function () {

  },
  onHide: function () {

  },
  onUnload: function () {

  },
  onPullDownRefresh: function () {

  },
  onReachBottom: function () {

  },
  onShareAppMessage: function () {

  },
  onPageScroll: function () {

  },
  //item(index,pagePath,text)
  onTabItemTap: function (item) {

  },
  //关闭弹框
  closeClick: function () {
    this.setData({
      closevisible: false,
      sharevisible: false,
      rankinglistvisible: false
    })
  },
  // 打开分享
  shareOpen() {
    this.setData({
      sharevisible: true
    })
  },
  //排行榜
  rankingList: function () {
    this.setData({
      rankinglistvisible: true
    })
  },
  //右侧按钮
  functionAction: function (res) {
    let index = res.currentTarget.dataset.index
    if (index == 2) {
      this.setData({
        closevisible: true
      })
    }
  },
  //左侧按钮
  buttonAction: function (res) {
    let index = res.currentTarget.dataset.index
    if (index == 0) {
      this.setData({
        barrage: !this.data.barrage
      })

      var list = this.data.buttonItems
      if (this.data.barrage == true) {
        list[index] = "/icons/icon_LiveVideo_barage2@3x.png"
      } else {
        list[index] = "/icons/icon_LiveVideo_barage1@3x.png"
      }

      this.setData({
        buttonItems: list
      })
    } else if (index == 3) {
      this.setData({
        mute: !this.data.mute
      })

      var list = this.data.buttonItems
      if (this.data.mute == true) {
        list[index] = "/icons/icon_LiveVideo_estoppel2@3x.png"
      } else {
        list[index] = "/icons/icon_LiveVideo_estoppel1@3x.png"
      }

      this.setData({
        buttonItems: list
      })
    } else if (index == 4) {
      this.shareOpen();
    }
  }
});