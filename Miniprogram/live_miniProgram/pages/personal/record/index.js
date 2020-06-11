//Page Object
Page({
  data: {
    currentTab: 0,
    itemList: [
      "收藏",
      "点赞",
      "最近阅读",
      "打赏"
    ],
    articleLists: []
  },
  //options(Object)
  onLoad: function (options) {
    var tab = options["tab"]
    this.switchTab(tab)
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
  //切换tab
  switchTab: function (tab) {
    var list = [{
        author: '蒋国宇',
        type: '0',
        time: '5月22 14:00',
        authorImg: '',
        imgs: ['/icons/19.png', '/icons/19.png', '/icons/19.png', '/icons/19.png'],
        attention: false,
        transmit: '@华科闪云',
        comment: '太精彩了!!!',
        transmitNum: 44,
        giveNum: 23,
        commentNum: 64,
        articleContents: '4月20日，国家发改委召开例行在线新闻发布会，正式 明确区块国家发改委召开例行在线新闻发布会，正式 明确区块链作为新链作为新技术基础设施被纳入“新基建”范围…',
        articleTiltle: '2020年IPFS将是最稳投资！助力新基建投 资超389亿'
      },
      {
        author: '蒋国宇',
        type: '0',
        time: '5月22 14:00',
        authorImg: '',
        transmitNum: 44,
        giveNum: 23,
        commentNum: 64,
        imgs: ['/icons/19.png', '/icons/19.png'],
        attention: true,
        transmit: '@华科闪云',
        comment: '太精彩了!!!',
        articleContents: '4月20日，国家发改委召开例行在线新闻发布会，正式 明确区块国家发改委召开例行在线新闻发布会，正式 明确区块链作为新链作为新技术基础设施被纳入“新基建”范围…',
        articleTiltle: '2020年IPFS将是最稳投资！助力新基建投 资超389亿'
      },
      {
        author: '蒋国宇',
        type: '1',
        time: '5月22 14:00',
        authorImg: '',
        imgs: ['/icons/19.png'],
        attention: false,
        transmitNum: 44,
        giveNum: 23,
        commentNum: 64,
        topic: '#filecoin#',
        transmit: '@Matt',
        comment: '太精彩了!!!',
        articleContents: '4月20日，国家发改委召开例行在线新闻发布会，正式 明确区块国家发改委召开例行在线新闻发布会，正式 明确区块链作为新链作为新技术基础设施被纳入“新基建”范围…',
        articleTiltle: '2020年IPFS将是最稳投资！助力新基建投 资超389亿'
      },
      {
        author: '蒋国宇',
        type: '1',
        time: '5月22 14:00',
        authorImg: '',
        imgs: ['/icons/19.png', '/icons/19.png', '/icons/19.png'],
        attention: false,
        transmitNum: 44,
        giveNum: 23,
        commentNum: 64,
        topic: '#filecoin#',
        transmit: '@蒋国宇',
        comment: '太精彩了!!!',
        articleContents: '4月20日，国家发改委召开例行在线新闻发布会，正式 明确区块国家发改委召开例行在线新闻发布会，正式 明确区块链作为新链作为新技术基础设施被纳入“新基建”范围…',
        articleTiltle: '2020年IPFS将是最稳投资！助力新基建投 资超389亿'
      }
    ]

    list = list.slice(0, list.length - tab)

    this.setData({
      currentTab: tab,
      articleLists: list
    })
  },
  tabSelect: function (res) {
    let tab = res.currentTarget.dataset.index
    this.switchTab(tab)
  },
  // 关注某篇文章
  attentionChange(e) {
    // 更新文章状态
    let articleLists = this.data.articleLists
    let index = e.detail.index
    let attention = e.detail.attention
    articleLists[index].attention = attention
    this.setData({
      articleLists: articleLists
    })
    // console.log(e)
  },
  // 点赞成功回调，重新渲染
  giveNumChange(e) {
    console.log(e)
    let index = e.detail.index;
    let giveNum = e.detail.giveNum;
    let articleLists = this.data.articleLists;
    articleLists[index].giveNum = giveNum;
    this.setData({
      articleLists: articleLists
    })
  }
});