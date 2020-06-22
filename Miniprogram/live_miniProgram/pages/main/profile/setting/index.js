//Page Object
Page({
  data: {

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
  //账户信息
  accountInfo: function () {
    wx.navigateTo({
      url: '/pages/main/profile/info/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //实名认证
  certification: function () {
    wx.navigateTo({
      url: '/pages/main/profile/certification/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
});