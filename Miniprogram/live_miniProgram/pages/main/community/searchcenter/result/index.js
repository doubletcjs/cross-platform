//Page Object
Page({
  data: {
    currentTab: 0, // tab 下标
    tablists: ["综合", "用户"],
    articleLists: [ // 文章列表
      {
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
      },
    ],
    accountList: [{
        author: "未来值得期待",
        authorImage: "/icons/person.png",
        attention: false,
        introduction: "岛田洋七说：「如果不知道自己想要我去容却怕热怕他",
        fans: 15023
      },
      {
        author: "未来值得期待~",
        authorImage: "/icons/person.png",
        attention: true,
        introduction: "未来值得期待~",
        fans: 89
      }
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
  // tab切换
  changeTabhandle(e) {
    let index = e.detail;
    this.setData({
      currentTab: index
    })
  },
  // 关注某篇文章
  attentionChange(e) {
    // 更新文章状态
    let articleLists = this.data.articleLists;
    let index = e.detail.index;
    let attention = e.detail.attention;
    articleLists[index].attention = attention;
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
  },
  // 关注好友
  accountAttentionChange(e) {
    // 更新好友状态
    let accountList = this.data.accountList;
    let index = e.detail.index;
    let attention = e.detail.attention;
    accountList[index].attention = attention;
    this.setData({
      accountList: accountList
    })
    // console.log(e)
  },
});