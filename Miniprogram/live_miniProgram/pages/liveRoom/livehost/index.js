//Page Object
Page({
  data: {
    dataList: [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
    ]
  },
  //options(Object)
  onLoad: function (options) {
    wx.setNavigationBarTitle({
      title: '往期视频',
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


  // 事件方法
  lookPlaye(e){
    console.log(e)
    // 本视频的id 
    wx.navigateTo({
      url: '/pages/liveRoom/playback/index?id=13',
      success: function(res) {
        // 通过eventChannel向被打开页面传送数据
        // res.eventChannel.emit('acceptDataFromOpenerPage', { data: 'test' })
      }
    })
  }

});