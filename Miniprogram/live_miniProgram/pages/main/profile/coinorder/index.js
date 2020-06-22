//Page Object
Page({
  data: {
    orderItems: [
      "全部",
      "直播",
      "咨讯",
    ],
    orderDateList: [{
        type: 0, // 0 直播 1 咨讯
        name: "蒋国宇",
        date: "2020.06.09 14:00:00",
        coin: "+10",
      },
      {
        type: 1, // 0 直播 1 咨讯
        name: "Lisa",
        date: "2020.06.09 14:00:00",
        coin: "-10",
      },
      {
        type: 1, // 0 直播 1 咨讯
        name: "华科闪云",
        date: "2020.06.09 14:00:00",
        coin: "-30",
      },
      {
        type: 0, // 0 直播 1 咨讯
        name: "Matt",
        date: "2020.06.09 14:00:00",
        coin: "+5",
      },
    ],
    currentIndex: 0,
    daterangevisible: false, //日期范围弹框
    startDate: "2020.06.01",
    endDate: "2020.06.01"
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
  //日期选择
  dateClose: function () {
    this.setData({
      daterangevisible: false
    })
  },
  dateConfirm: function (res) {
    var start = res.detail.start.replace(/-/g, ".")
    var end = res.detail.end.replace(/-/g, ".")

    this.setData({
      startDate: start,
      endDate: end
    })
  },
  openDatePop: function () {
    this.setData({
      daterangevisible: true
    })
  },
  //切换订单类型
  switchOrderType: function (res) {
    var index = res.currentTarget.dataset.index
    this.setData({
      currentIndex: index,
      orderDateList: index == 0 ? [{
          type: 0, // 0 直播 1 咨讯
          name: "蒋国宇",
          date: "2020.06.09 14:00:00",
          coin: "+10",
        },
        {
          type: 1, // 0 直播 1 咨讯
          name: "Lisa",
          date: "2020.06.09 14:00:00",
          coin: "-10",
        },
        {
          type: 1, // 0 直播 1 咨讯
          name: "华科闪云",
          date: "2020.06.09 14:00:00",
          coin: "-30",
        },
        {
          type: 0, // 0 直播 1 咨讯
          name: "Matt",
          date: "2020.06.09 14:00:00",
          coin: "+5",
        },
      ] : index == 1 ? [{
          type: 0, // 0 直播 1 咨讯
          name: "蒋国宇",
          date: "2020.06.09 14:00:00",
          coin: "+10",
        },
        {
          type: 0, // 0 直播 1 咨讯
          name: "Matt",
          date: "2020.06.09 14:00:00",
          coin: "+5",
        },
      ] : [{
          type: 1, // 0 直播 1 咨讯
          name: "Lisa",
          date: "2020.06.09 14:00:00",
          coin: "-10",
        },
        {
          type: 1, // 0 直播 1 咨讯
          name: "华科闪云",
          date: "2020.06.09 14:00:00",
          coin: "-30",
        }
      ]
    })
  }
});