//Page Object
Page({
  data: {
    dataList: [{
        "icon": "/icons/icon_Tips_comment@3x.png",
        "name": "评论",
        "content": "未来值得期待回复了你的评论",
        "subcontent": "",
        "unreadcount": 1,
        "messagetype": 0
      },
      {
        "icon": "/icons/icon_Tips_share@3x.png",
        "name": "转发",
        "content": "甄尤乾转发了你的文章",
        "subcontent": "",
        "unreadcount": 0,
        "messagetype": 1
      },
      {
        "icon": "/icons/icon_Tips_forward@3x.png",
        "name": "赞",
        "content": "黑科技赞你的评论",
        "subcontent": "",
        "unreadcount": 0,
        "messagetype": 2
      },
      {
        "icon": "/icons/icon_Tips_system@3x.png",
        "name": "系统消息",
        "content": "用户资料审核通过",
        "subcontent": "·14:59",
        "unreadcount": 230,
        "messagetype": 3
      },
    ],
    isProfile: false,
    profileItems: [{
        "icon": "/icons/icon_massages_shoppingmall1@3x.png",
        "selecticon": "/icons/icon_massages_shoppingmall2@3x.png",
        "name": "商城",
      },
      {
        "icon": "/icons/icon_massages_news1@3x.png",
        "selecticon": "/icons/icon_massages_news2@3x.png",
        "name": "咨询",
      },
      {
        "icon": "/icons/icon_massages_video1@3x.png",
        "selecticon": "/icons/icon_massages_video2@3x.png",
        "name": "直播",
      }
    ],
    profileIndex: 0
  },
  //options(Object)
  onLoad: function (options) {
    var profile = options["profile"]
    if (profile == "true") {
      var list = [{
          "icon": "/icons/icon_Tips_system@3x.png",
          "name": "系统消息",
          "content": "用户资料审核通过",
          "subcontent": "·14:59",
          "unreadcount": 5,
          "messagetype": 3
        },
        {
          "icon": "/icons/icon_Tips_service@3x.png",
          "name": "客服001",
          "content": "请问有什么可以帮到你",
          "subcontent": "·14:59",
          "unreadcount": 0,
          "messagetype": 4
        }
      ]

      this.setData({
        isProfile: true,
        dataList: list
      })
    }
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
  //消息列表点击
  typeItemTap: function (res) {
    var index = res.currentTarget.dataset.index
    var list = []
    if (index == 0) {
      list = [{
          "icon": "/icons/icon_Tips_system@3x.png",
          "name": "系统消息",
          "content": "用户资料审核通过",
          "subcontent": "·14:59",
          "unreadcount": 5,
          "messagetype": 3
        },
        {
          "icon": "/icons/icon_Tips_service@3x.png",
          "name": "客服001",
          "content": "请问有什么可以帮到你",
          "subcontent": "·14:59",
          "unreadcount": 0,
          "messagetype": 4
        }
      ]
    } else if (index == 1) {
      list = [{
          "icon": "/icons/icon_Tips_comment@3x.png",
          "name": "评论",
          "content": "未来值得期待回复了你的评论",
          "subcontent": "",
          "unreadcount": 1,
          "messagetype": 0
        },
        {
          "icon": "/icons/icon_Tips_share@3x.png",
          "name": "转发",
          "content": "甄尤乾转发了你的文章",
          "subcontent": "",
          "unreadcount": 0,
          "messagetype": 1
        },
        {
          "icon": "/icons/icon_Tips_forward@3x.png",
          "name": "赞",
          "content": "黑科技赞你的评论",
          "subcontent": "",
          "unreadcount": 0,
          "messagetype": 2
        },
        {
          "icon": "/icons/icon_Tips_system@3x.png",
          "name": "系统消息",
          "content": "用户资料审核通过",
          "subcontent": "·14:59",
          "unreadcount": 230,
          "messagetype": 3
        },
      ]
    } else {
      list = [{
          "icon": "/icons/icon_Tips_comment@3x.png",
          "name": "评论",
          "content": "未来值得期待回复了你的评论",
          "subcontent": "",
          "unreadcount": 1,
          "messagetype": 0
        },
        {
          "icon": "/icons/icon_Tips_system@3x.png",
          "name": "系统消息",
          "content": "用户资料审核通过",
          "subcontent": "·14:59",
          "unreadcount": 0,
          "messagetype": 3
        },
      ]
    }

    this.setData({
      profileIndex: index,
      dataList: list
    })
  },
  //消息列表点击
  messageCellTap: function (res) {
    var index = res.currentTarget.dataset.index
    var message = this.data.dataList[index]
    if (message["messagetype"] == 3) {
      wx.navigateTo({
        url: './system/index',
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
    } else if (message["messagetype"] == 0 || message["messagetype"] == 1 || message["messagetype"] == 2) {
      wx.navigateTo({
        url: './reply/index?type=' + message["messagetype"],
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
    } else {
      wx.navigateTo({
        url: './privateChat/index',
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
    }
  }
});