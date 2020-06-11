//Page Object
Page({
  data: {
    inputContent: "",
    hotTopicList: [
      "#filecoin#",
      "#主网上线#",
      "#矿机#"
    ]
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
  //输入内容变化
  contentInputChagne: function (res) {
    this.setData({
      inputContent: res.detail.value
    })
  },
  //确定输入话题
  confirmTopic: function () {
    this.handleTopics("#" + this.data.inputContent + "#")
  },
  //热门话题选择
  hotTopicSelect: function (res) {
    var index = res.currentTarget.dataset.index
    var topic = this.data.hotTopicList[index]
    this.handleTopics(topic)
  },
  //话题列表处理
  handleTopics: function (topic) {
    var pages = getCurrentPages()
    var prevPage = pages[pages.length - 2] //上一个页面
    var topics = prevPage.data.topics

    var isExist = false
    for (let index = 0; index < topics.length; index++) {
      var element = topics[index]
      if (element == topic) {
        isExist = true
        break
      }
    }

    if (isExist == false) {
      topics.push(topic)
    }

    var inputContent = prevPage.data.inputContent
    for (let index = 0; index < prevPage.data.topics.length; index++) {
      const element = prevPage.data.topics[index];
      inputContent = inputContent.replace(element, "")
    }

    var str = topics.join("")
    str = inputContent + "\n\n" + str
    prevPage.setData({
      topics: topics,
      inputContent: str
    })

    setTimeout(() => {
      wx.navigateBack({
        delta: 1,
      });
    }, 600);
  }
});