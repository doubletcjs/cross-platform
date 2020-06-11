//Page Object
Page({
  data: {
    //是否当前登录用户
    currentUser: false,
    // 0 未关注 1 已关注 2 已拉黑
    userStatus: 0,
    // 简介
    introduction: "",
    isShowAttention: true,
    alertvisible: false,
    articleLists: [ // 文章列表 (type ==0 文章 type==1 话题  type==2 评论)
      {
        author: '蒋国宇',
        type: '2',
        isTransmit: false,
        time: '5月22 14:00',
        authorImg: '',
        imgs: ['/icons/19.png'],
        attention: false,
        transmitNum: 44,
        giveNum: 23,
        commentNum: 64,
        topic: '',
        transmit: '',
        comment: "",
        articleContents: '',
        articleTiltle: 'Filecoin官方：二阶段测试网开始时间：5月11日 左右,主网启动时间：7月20日-8月21日'
      },
      {
        author: '蒋国宇',
        type: '2',
        isTransmit: false,
        time: '5月22 14:00',
        authorImg: '',
        imgs: ['/icons/19.png', '/icons/19.png'],
        attention: false,
        transmitNum: 44,
        giveNum: 23,
        commentNum: 64,
        topic: '',
        transmit: '',
        comment: "",
        articleContents: '',
        articleTiltle: 'Filecoin官方：二阶段测试网开始时间：5月11日 左右,主网启动时间：7月20日-8月21日'
      },
    ],
    currentTab: 0,
    tablists: ['讨论', '长文', '话题'],
    alertContent: "",
    sharevisible: false,
    shareItems: [{
      "name": "分享给微信好友",
      "icon": "/icons/ico_share_wx@3x.png"
    }, {
      "name": "加入名单",
      "icon": "/icons/icon_blacklist@3x.png"
    }, {
      "name": "投诉",
      "icon": "/icons/ico_community_share_complaint@3x.png"
    }, ]
  },
  // changeTabhandle
  changeTabhandle(e) {
    // console.log(e)
    let currentTab = e.detail;
    this.setData({
      currentTab: currentTab
    })
    if (currentTab == 0) {
      let articleLists = [{
          author: '蒋国宇',
          type: '2',
          isTransmit: false,
          time: '5月22 14:00',
          authorImg: '',
          imgs: ['/icons/19.png'],
          attention: false,
          transmitNum: 44,
          giveNum: 23,
          commentNum: 64,
          topic: '',
          transmit: '',
          comment: "",
          articleContents: '',
          articleTiltle: 'Filecoin官方：二阶段测试网开始时间：5月11日 左右,主网启动时间：7月20日-8月21日'
        },
        {
          author: '蒋国宇',
          type: '2',
          isTransmit: false,
          time: '5月22 14:00',
          authorImg: '',
          imgs: ['/icons/19.png', '/icons/19.png'],
          attention: false,
          transmitNum: 44,
          giveNum: 23,
          commentNum: 64,
          topic: '',
          transmit: '',
          comment: "",
          articleContents: '',
          articleTiltle: 'Filecoin官方：二阶段测试网开始时间：5月11日 左右,主网启动时间：7月20日-8月21日'
        }
      ]
      this.setData({
        articleLists: articleLists
      })
    } else if (currentTab == 1) {
      let articleLists = [{
          author: '华科闪云',
          type: '0', // 文章
          isTransmit: false, // 是否是转发的
          time: '5月22 14:00',
          authorImg: '',
          imgs: ['/icons/19.png', '/icons/19.png', '/icons/19.png', '/icons/19.png'],
          attention: false,
          transmit: '@华科闪云',
          comment: '', // 无评论内容
          transmitNum: 44,
          giveNum: 23,
          commentNum: 64,
          articleContents: '4月20日，国家发改委召开例行在线新闻发布会，正式 明确区块国家发改委召开例行在线新闻发布会，正式 明确区块链作为新链作为新技术基础设施被纳入“新基建”范围…',
          articleTiltle: '2020年IPFS将是最稳投资！助力新基建投 资超389亿'
        },
        {
          author: '蒋国宇',
          type: '0',
          isTransmit: true,
          time: '5月22 14:00',
          authorImg: '',
          transmitNum: 44,
          giveNum: 23,
          commentNum: 64,
          imgs: ['/icons/19.png'],
          attention: true,
          transmit: '@华科闪云',
          comment: '太精彩了!!!',
          articleContents: '4月20日，国家发改委召开例行在线新闻发布会，正式 明确区块国家发改委召开例行在线新闻发布会，正式 明确区块链作为新链作为新技术基础设施被纳入“新基建”范围…',
          articleTiltle: '2020年IPFS将是最稳投资！助力新基建投 资超389亿'
        }
      ]
      this.setData({
        articleLists: articleLists
      })
    } else {
      let articleLists = [{
          author: '蒋国宇',
          type: '1',
          time: '5月22 14:00',
          authorImg: '',
          imgs: [],
          attention: false,
          transmitNum: 44,
          giveNum: 23,
          commentNum: 64,
          topic: '#filecoin#',
          transmit: '@Matt',
          comment: '太精彩了!!!',
          articleContents: '',
          articleTiltle: '2020年IPFS将是最稳投资！助力新基建投 资超389亿'
        },
        {
          author: '蒋国宇',
          type: '1',
          isTransmit: true,
          time: '5月22 14:00',
          authorImg: '',
          imgs: [],
          attention: false,
          transmitNum: 44,
          giveNum: 23,
          commentNum: 64,
          topic: '#filecoin#', // 话题
          transmit: '@蒋国宇', // 转发的谁
          comment: '我也是 // @蒋国宇: 我页知道',
          articleContents: '让我们讨论一下filecoin主网什么时��上线...?', // 内容
          articleTiltle: '' // 标题
        },
      ]
      this.setData({
        articleLists: articleLists
      })
    }
  },
  // 跳转搜索页
  search() {
    wx.navigateTo({
      url: '/pages/main/community/searchcenter/index',
      success: function (res) {

      }
    })
  },
  //options(Object)
  onLoad: function (options) {
    this.setData({
      introduction: "这是关于我的简介了，了解了吧了解了吧，哈哈哈哈哈"
    })
  },
  // 点赞
  giveNumChange(e) {
    console.log('点赞=', e)
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
  //分享弹框
  shareAction: function () {
    this.setData({
      sharevisible: true
    })
  },
  shareCloseClick: function () {
    this.setData({
      sharevisible: false
    })
  },
  //分享弹框确认点击
  shareConfirmClick: function (res) {
    var name = res.detail.name
    var shareItems = this.data.shareItems
    var item = shareItems[1]

    if (name == "加入名单") {
      item.name = "移出名单"
      shareItems[1] = item

      this.setData({
        userStatus: 2
      })
    } else if (name == "移出名单") {
      item.name = "加入名单"
      shareItems[1] = item

      this.setData({
        userStatus: 0
      })
    }

    this.setData({
      shareItems: shareItems
    })
  },
  //关闭弹框
  alertCloseClick: function () {
    this.setData({
      alertvisible: false
    })
  },
  //弹框确认点击
  alertConfirmClick: function () {
    // 0 未关注 1 已关注 2 已拉黑
    if (this.data.userStatus == 1) {
      this.setData({
        userStatus: 0
      })
    } else if (this.data.userStatus == 2) {
      this.setData({
        userStatus: 0
      })
    }
  },
  //我的关注
  showMyAttention: function () {
    wx.navigateTo({
      url: '/pages/personal/fanattention/index?type=1',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //我的粉丝
  showMyFan: function () {
    wx.navigateTo({
      url: '/pages/personal/fanattention/index?type=0',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //私信
  messageAction: function () {
    wx.navigateTo({
      url: '/pages/main/community/messagecenter/privateChat/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //关注
  attentionAction: function () {
    var userStatus = this.data.userStatus
    // 0 未关注 1 已关注 2 已拉黑
    if (userStatus == 2) {
      this.setData({
        alertContent: "移除出黑名单？",
        alertvisible: true
      })
    } else if (userStatus == 1) {
      this.setData({
        alertContent: "确定不再关注此人",
        alertvisible: true
      })
    } else {
      this.setData({
        userStatus: 1
      })
    }
  }
});