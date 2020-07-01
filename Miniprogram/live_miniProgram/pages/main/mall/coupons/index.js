//Page Object
Page({
  data: {
    couponsList: [{
        name: "全场商品买499可用",
        price: 200,
        fullPrice: 499,
        startDate: "2020.05.20",
        endDate: "2020.06.20",
        status: 0 // 0 未领取 1 已失效
      },
      {
        name: "全场商品买199可用",
        price: 100,
        fullPrice: 199,
        startDate: "2020.05.22",
        endDate: "2020.06.25",
        status: 0 // 0 未领取 1 已失效
      },
      {
        name: "全场商品买199可用",
        price: 100,
        fullPrice: 199,
        startDate: "2020.05.22",
        endDate: "2020.06.25",
        status: 1 // 0 未领取 1 已失效
      }
    ],
    visible: false
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
  //兑换码弹框
  openAlert: function () {
    this.setData({
      visible: true,
    })
  },
  closeAlert: function () {
    this.setData({
      visible: false,
    })
  },
  alertConfirm: function (res) {
    var conversion = res.detail.conversion
    console.log('conversion :>> ', conversion);
  },
});