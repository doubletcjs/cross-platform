//Page Object
Page({
  data: {
    itemList: [{
      name: "收藏夹",
      number: 12,
    }, {
      name: "优惠券",
      number: 12,
    }, {
      name: "浏览记录",
      number: 345,
    }, {
      name: "关注主播",
      number: 20,
    }, {
      name: "开播订阅",
      number: 2,
    }, ],
    orderItemList: [{
      name: "待付款",
      count: 0,
      icon: "/icons/icon-profile-order-item0@3x.png"
    }, {
      name: "待发货",
      count: 0,
      icon: "/icons/icon-profile-order-item1@3x.png"
    }, {
      name: "待收货",
      count: 0,
      icon: "/icons/icon-profile-order-item2@3x.png"
    }, {
      name: "待评价",
      count: 1,
      icon: "/icons/icon-profile-order-item3@3x.png"
    }, {
      name: "退换售后",
      count: 0,
      icon: "/icons/icon-profile-order-item4@3x.png"
    }, ],
    products: [{
      name: "学霸学习，国AA级护眼认证，智能护目灯",
      price: 149,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 59,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 59,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 59,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 59,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 59,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }]
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
  //消息中心
  showMessageCenter: function () {
    wx.navigateTo({
      url: '/pages/main/community/messagecenter/index?profile=' + true,
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //账户设置
  accountSetting: function () {
    wx.navigateTo({
      url: '/pages/main/profile/setting/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //金币订单
  coinOrderList: function () {
    wx.navigateTo({
      url: '/pages/main/profile/coinorder/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //订单列表按钮
  orderItemListTap: function (res) {
    var index = res.currentTarget.dataset.index
    wx.navigateTo({
      url: '/pages/main/mall/order/index?tab=' + (index == 4 ? -1 : (index + 1)),
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
    // if (index == 3) {
    //   wx.navigateTo({
    //     url: '/pages/main/mall/evaluate/index',
    //     success: (result) => {

    //     },
    //     fail: () => {},
    //     complete: () => {}
    //   });
    // }
  },
  //全部订单
  myOrderList() {
    wx.navigateTo({
      url: '/pages/main/mall/order/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //列表按钮
  itemListTap: function (res) {
    var index = res.currentTarget.dataset.index
    if (index == 3 || index == 4) {
      wx.navigateTo({
        url: '/pages/main/profile/subscribe/index?subscribe=' + (index - 3),
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
    } else if (index == 2) {
      wx.navigateTo({
        url: '/pages/main/mall/history/index',
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
    } else if (index == 0) {
      wx.navigateTo({
        url: '/pages/main/mall/collection/index',
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
    } else if (index == 1) {
      wx.navigateTo({
        url: '/pages/main/mall/coupons/index',
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
    }
  },
});