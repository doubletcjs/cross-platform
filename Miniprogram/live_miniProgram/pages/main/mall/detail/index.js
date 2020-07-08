//Page Object
Page({
  data: {
    specvisible: false, //加入购物车
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
  //加入购物车
  addShoppingCartAction() {
    this.setData({
      specvisible: true
    })
  },
  shoppingCartClose() {
    this.setData({
      specvisible: false
    })
  },
  //首页
  backHome() {
    wx.switchTab({
      url: '/pages/main/mall/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //购物车
  shoppingCartAction() {
    wx.navigateTo({
      url: '../shoppingcart/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //创建订单
  createOrder() {

  }
});