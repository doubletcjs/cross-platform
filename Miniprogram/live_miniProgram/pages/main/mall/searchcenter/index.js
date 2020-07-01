//Page Object
Page({
  data: {
    inputValue: "",
    history: [
      "蓝牙耳机",
      "小音箱",
      "充电宝",
      "鼠标",
      "无人机"
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
  //清空搜索记录
  emptySearchHistroy: function () {
    this.setData({
      history: []
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
  // 搜索
  search(e) {
    let search = e.detail
    this.setData({
      inputValue: search
    })
    console.log('search', search)
  }
});