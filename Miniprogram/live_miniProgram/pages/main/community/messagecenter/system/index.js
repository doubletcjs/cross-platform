//Page Object
Page({
  data: {
    dataList: [{
      "title": "系统消息",
      "content": "用户资料审核通过",
      "date": "2020-05-26",
      "time": "16:30",
      "readed": false
    }, {
      "title": "举报反馈",
      "content": "已收到你提交的对用户【我是大帅哥】的举报，我们将尽快核实，感谢你的监督。",
      "date": "2020-05-26",
      "time": "16:30",
      "readed": true
    }, {
      "title": "安全中心提醒",
      "content": "在全国各地众志成城抗击新型冠状病毒之时，也衍生出部分非法牟利的骗局和制造恐慌情绪的谣言，请大家留心注意。",
      "date": "2020-05-26",
      "time": "16:30",
      "readed": true
    }, {
      "title": "安全中心提醒",
      "content": "在全国各地众志成城抗击新型冠状病毒之时，也衍生出部分非法牟利的骗局和制造恐慌情绪的谣言，请大家留心注意。",
      "date": "2020-05-26",
      "time": "16:30",
      "readed": true
    }, ]
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
  messageCellTap: function (res) {
    var index = res.currentTarget.dataset.index
    var list = this.data.dataList
    var message = list[index]
    if (message["readed"] == false) {
      message["readed"] = true
      list[index] = message
      this.setData({
        dataList: list
      })
    }
  }
});