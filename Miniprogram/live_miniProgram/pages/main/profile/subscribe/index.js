//Page Object
Page({
  data: {
    subscribeType: 0, // 0 关注主播 1 订阅主播
    dataList: [],
    alertcontent: "", //弹框内容
    actionvisible: false, //弹框状态
    currentIndex: 0, //当前选择index
    emptyList: false //是否清空
  },
  //options(Object)
  onLoad: function (options) {
    var subscribe = parseInt(options["subscribe"])
    this.setData({
      subscribeType: subscribe,
      dataList: subscribe == 0 ? [{
          name: "蒋国宇",
          head: "",
          introduction: "主播大神简介在此， IPFS与Filecoin此主播很懒哦",
          status: 0, // 0 未关注 1 已关注
        },
        {
          name: "Lisa",
          head: "",
          introduction: "此主播很懒哦，什么都没写~",
          status: 1, // 0 未关注 1 已关注
        }, {
          name: "精致的皮皮虾",
          head: "",
          introduction: "此主播很懒哦，什么都没写~",
          status: 1, // 0 未关注 1 已关注
        }, {
          name: "Marry",
          head: "",
          introduction: "此主播很懒哦，什么都没写~",
          status: 1, // 0 未关注 1 已关注
        },
      ] : [{
          name: "蒋国宇",
          head: "",
          label: "HK市场总监",
          date: "4月26号 10：30",
          title: "和Filecoin一起构建世界一流的工具！",
          status: 1, // 0 未订阅 1 已订阅
        },
        {
          name: "Lisa",
          head: "",
          label: "UK市场总监",
          date: "4月26号 10：30",
          title: "和Filecoin一起构建世界一流的~",
          status: 0, // 0 未订阅 1 已订阅
        },
      ],
      alertcontent: subscribe == 0 ? "确定取消关注该主播？" : "取消订阅，则不再收到该场直播的开播通知，是否继续？"
    })

    wx.setNavigationBarTitle({
      title: subscribe == 0 ? "关注主播" : "开播订阅",
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
  //关闭弹框
  closeClick: function () {
    this.setData({
      actionvisible: false
    })

    setTimeout(() => {
      this.setData({
        alertcontent: this.data.subscribeType == 0 ? "确定取消关注该主播？" : "取消订阅，则不再收到该场直播的开播通知，是否继续？",
        emptyList: false
      })
    }, 600);
  },
  //弹框确认
  alertConfirm: function () {
    if (this.data.emptyList == true) {
      this.setData({
        dataList: [],
        actionvisible: false
      })

      setTimeout(() => {
        this.setData({
          alertcontent: this.data.subscribeType == 0 ? "确定取消关注该主播？" : "取消订阅，则不再收到该场直播的开播通知，是否继续？",
          emptyList: false
        })
      }, 600);
    } else {
      var list = this.data.dataList
      list[this.data.currentIndex]["status"] = 0

      this.setData({
        actionvisible: false,
        dataList: list
      })
    }
  },
  //订阅、取消订阅
  subscribeAction: function (res) {
    var index = res.currentTarget.dataset.index
    var list = this.data.dataList
    if (list[index]["status"] == 0) {
      list[index]["status"] = 1

      this.setData({
        dataList: list
      })
    } else if (list[index]["status"] == 1) {
      this.setData({
        currentIndex: index,
        actionvisible: true
      })
    }
  },
  //清空订阅列表
  emptySubscribeList: function () {
    this.setData({
      alertcontent: "确定清空订阅记录？"
    })

    setTimeout(() => {
      this.setData({
        emptyList: true,
        actionvisible: true
      })
    }, 400);
  }
});