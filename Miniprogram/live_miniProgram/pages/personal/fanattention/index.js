//Page Object
Page({
  data: {
    // 0 粉丝 1 关注
    type: 0,
    dataList: []
  },
  //options(Object)
  onLoad: function (options) {
    var type = options["type"]
    var title = "我的粉丝"
    var list = [{
        name: "Lisa",
        header: "",
        introduction: "这是关于我的简介，了解了吧"
      },
      {
        name: "蒋国宇",
        header: "",
        introduction: "这是关于我的简介，了解了吧"
      },
      {
        name: "Matt",
        header: "",
        introduction: "这是关于我的简介，了解了吧"
      },
      {
        name: "黑科技",
        header: "",
        introduction: "这是关于我的简介，了解了吧"
      },
    ]

    if (type == 1) {
      title = "我的关注"
      list = [{
          name: "Lisa",
          header: "",
          introduction: "这是关于我的简介，了解了吧"
        },
        {
          name: "蒋国宇",
          header: "",
          introduction: "这是关于我的简介，了解了吧"
        },
        {
          name: "黑科技",
          header: "",
          introduction: "这是关于我的简介，了解了吧"
        },
      ]
    }

    this.setData({
      type: type,
      dataList: list
    })

    wx.setNavigationBarTitle({
      title: title,
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

  }
});