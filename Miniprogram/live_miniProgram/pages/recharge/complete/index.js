//Page Object
Page({
  data: {
    type: 0
  },
  //options(Object)
  onLoad: function (options) {
    this.setData({
      type: options.type
    })
    wx.setNavigationBarTitle({
      title: this.data.type == 0 ? '在线充值' : 'usdt充值',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
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
  completeBack: function () {
    wx.navigateBack({
      delta: 2
    });
  }
});