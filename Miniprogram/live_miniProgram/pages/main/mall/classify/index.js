//Page Object
Page({
  data: {
    classifyList: [
      "推荐",
      "热门",
      "居家",
      "玩具",
      "一级分类",
    ],
    classifyIndex: 0,
    classifies: [],
    baseClassifies: [{
        icon: "/icons/product_placeholder@3x.png",
        name: "手机"
      },
      {
        icon: "/icons/product_placeholder@3x.png",
        name: "音箱"
      },
      {
        icon: "/icons/product_placeholder@3x.png",
        name: "居家必备"
      },
      {
        icon: "/icons/product_placeholder@3x.png",
        name: "学习工具"
      },
      {
        icon: "/icons/product_placeholder@3x.png",
        name: "日常生活"
      },
    ]
  },
  //options(Object)
  onLoad: function (options) {
    this.setData({
      classifies: this.data.baseClassifies
    })
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
  //搜索中心
  goSearch: function () {
    wx.navigateTo({
      url: '/pages/main/mall/searchcenter/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //选择分类
  classifyTap: function (res) {
    var index = res.currentTarget.dataset.index
    this.setData({
      classifyIndex: index,
      classifies: this.data.baseClassifies.slice(0, this.data.baseClassifies.length - index)
    })
  }
});