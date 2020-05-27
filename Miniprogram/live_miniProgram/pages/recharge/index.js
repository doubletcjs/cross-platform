//Page Object
Page({
  data: {
    type: 0,
    priceList: [100, 200, 300, 400, 500],
    priceIndex: 0,
    inputamount: 0.0,
    rechargeamount: 0.0,
    paywayList: ["微信充值", "支付宝充值"],
    paywayIconList: ["/icons/wechat@3x.png", "/icons/Alipay@3x.png"],
    paywayIndex: 0
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
  selectPrice: function (res) {
    var index = res.target.dataset.index
    this.setData({
      priceIndex: index,
      rechargeamount: this.data.priceList[index],
      inputamount: ""
    })
  },
  inputChange: function (res) {
    var value = res.detail.value
    var newValue = value
    if (value.indexOf(".") != -1) {
      newValue = parseFloat(value).toFixed(2)
    }

    this.setData({
      inputamount: newValue,
      priceIndex: -1,
      rechargeamount: newValue
    })

    // var _priceIndex = this.data.priceList.indexOf(parseInt(newValue)); 
    // if (_priceIndex >= 0) {
    //   this.setData({
    //     priceIndex: _priceIndex
    //   })
    // }
  },
  selectPayway: function (res) {
    var index = res.target.dataset.index
    this.setData({
      paywayIndex: index
    })
  },
  handleRecharge: function () {
    this.rechargeComplete()
  },
  rechargeComplete: function () {
    wx.navigateTo({
      url: './complete/index?type=' + this.data.type,
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  }
});