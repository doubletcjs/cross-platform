//Page Object
Page({
  data: {
    dataList: [{
        author: "未来值得期待",
        authorImage: "/icons/person.png",
        date: "05-20  14:46",
        content: "我不说，你可能不知道这是个评论文案",
        article: {
          author: "华科闪云",
          title: "2020年IPFS将是最稳投资！助力新基建投资超389亿和有实力的公司合作有前景的项目，心里踏实！~",
          content: "4月20日，国家发改委召开例行在线新闻发正式明确区块链作为新技术基础设施… ",
          cover: "/icons/19.png"
        },
        readed: false
      },
      {
        author: "未来值得期待",
        authorImage: "/icons/person.png",
        date: "05-20  14:46",
        content: "支持，未来可期~和有实力的公司合作有前景的项目，心里踏实！~",
        comment: {
          author: "华科闪云",
          content: "和有实力的公司合作有前景的项目，心里踏实！~"
        },
        readed: true
      }
    ],
    replyType: 0
  },
  //options(Object)
  onLoad: function (options) {
    var type = options["type"]
    var list = this.data.dataList
    if (type == 1) {
      list[1] = {
        author: "未来值得期待",
        authorImage: "/icons/person.png",
        date: "05-20  14:46",
        content: "我就不说",
        replycontent: "转发评论这么玩？",
        comment: {
          author: "华科闪云",
          content: "和有实力的公司合作有前景的项目，心里踏实！~",
        },
        readed: true
      }
    }
    this.setData({
      replyType: type,
      dataList: list
    })



    wx.setNavigationBarTitle({
      title: type == 0 ? '评论' : type == 1 ? '转发' : '赞',
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