//Page Object
Page({
  data: {
    inputValue: "",
    hotTopicList: [
      "#filecoin#",
      "#主网上线#",
      "#矿机#",
      "#主网#",
      "#IPFS#",
      "#存储#"
    ],
    history: [
      "filecoin",
      "随便啦",
      "吧啦吧啦吧",
      "阿斯顿了"
    ],
    hotList: [
      "2020年IPFS将是最稳投啊啊啥的功夫",
      "IPFS如何拯救互联网的阿斯顿福恶",
      "助力新基建投资超389亿馹容易撒发生的",
      "Filecoin收益方式",
      "两会热议区块链，结合人体抗过敏",
      "主网上线"
    ],
    focus: false,
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
  //取消搜索
  emptySearch: function () {
    this.setData({
      inputValue: ""
    })
  },
  //历史记录点击
  historySelect: function (res) {
    var index = res.currentTarget.dataset.index
    var history = this.data.history[index]

    this.setData({
      inputValue: history,
      focus: true
    })
  },
  //热点点击
  hotSelect: function (res) {
    var index = res.currentTarget.dataset.index
    var hot = this.data.hotList[index]

    this.setData({
      inputValue: history,
      focus: true
    })
  },
  //话题点击
  hotTopicSelect: function (res) {
    var index = res.currentTarget.dataset.index
    var topic = this.data.hotTopicList[index]

    this.setData({
      inputValue: topic,
      focus: true
    })
  },
  // 搜索
  search(e) {
    let search = e.detail
    this.setData({
      inputValue: search
    })
    console.log('search', search)
  }
});