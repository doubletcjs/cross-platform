//Page Object
Page({
  data: {
    evaluateItems: [
      "待评价",
      "已评价",
    ],
    evaluateDataList: [{
        cover: "",
        name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
        price: 59,
        specification: "淡粉色",
        count: 1
      },
      {
        cover: "",
        name: "驱蚊器+小夜灯2合1驱蚊高手居家必备",
        price: 38,
        specification: "白色",
        count: 1
      },
    ],
    scoreList: [
      0,
      1,
      2,
      3,
      4,
    ],
    currentIndex: 0
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
  //切换订单类型
  evaluateItemTap: function (res) {
    var index = res.currentTarget.dataset.index
    this.setData({
      currentIndex: index,
      evaluateDataList: index == 0 ? [{
          cover: "",
          name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
          price: 59,
          specification: "淡粉色",
          count: 1
        },
        {
          cover: "",
          name: "驱蚊器+小夜灯2合1驱蚊高手居家必备",
          price: 38,
          specification: "白色",
          count: 1
        },
      ] : [{
          cover: "",
          name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
          price: 59,
          specification: "淡粉色",
          count: 1,
          date: "2020-06-08",
          comment: "很好，很不错~",
          score: 1,
          author: {
            name: "用户123",
            head: ""
          }
        },
        {
          cover: "",
          name: "驱蚊器+小夜灯2合1驱蚊高手居家必备",
          price: 38,
          specification: "白色",
          count: 1,
          date: "2020-06-08",
          comment: "很好，很不错~",
          score: 5,
          author: {
            name: "用户123",
            head: ""
          }
        },
      ]
    })
  }
});