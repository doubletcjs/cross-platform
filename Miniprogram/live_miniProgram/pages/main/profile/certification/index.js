//Page Object
Page({
  data: {
    stepList: [
      "身份认证",
      "绑定手机",
      "人脸识别"
    ],
    currentIndex: 0,
    uploadMap: {} //上传内容
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
  //下一步点击
  confirm: function (res) {
    var detail = res.detail
    this.setData({
      currentIndex: this.data.currentIndex + 1
    })

    this.setData({
      uploadMap: Object.assign(this.data.uploadMap, detail)
    })

    if (this.data.currentIndex == 3) {
      // this.setData({
      //   currentIndex: 2
      // })

      console.log("完成人脸识别")
      console.log('上传参数 :>> ', JSON.stringify(this.data.uploadMap));

      wx.navigateBack({
        delta: 1
      });
    }
  }
});