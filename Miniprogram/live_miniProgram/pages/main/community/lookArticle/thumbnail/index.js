// pages/main/community/lookArticle/thumbnail/index.js
Page({
  /**
   * 页面的初始数据
   */
  data: {
    inputVisible: false,
    articleID: "",
    showType: 0,
    articleContent: {
      author: "蒋国宇",
      type: "0",
      time: "5月22 14:00",
      authorImg: "",
      imgs: [
        "/icons/19.png",
        "/icons/19.png",
        "/icons/19.png",
        "/icons/19.png",
      ],
      attention: false,
      transmit: "@华科闪云",
      transmitNum: 44,
      giveNum: 23,
      commentNum: 64,
      articleContents: "4月20日，国家发改委召开例行在线新闻发布会，正式 明确区块国家发改委召开例行在线新闻发布会，正式 明确区块链作为新链作为新技术基础设施被纳入“新基建”范围…",
      articleTiltle: "2020年IPFS将是最稳投资！助力新基建投 资超389亿",
      readNum: "12万",
      commentContent: "评论内容评论内容",
      commentType: "评论类型"
    },
    currentTab: 0, // 当前选中 tab 下标
    tabLists: ["评论 200", "转发 300", "赞 399"],
    commentList: [ //  评论列表
      {
        headIcon: "/icons/person.png",
        name: "用户姓名",
        commentContent: "评论内容内容内容",
        userReplyUser: "王小明等人",
        userReplyNum: 3,
        date: "5月20日 14:03",
        shareNum: 199999999,
        commentNum: 2,
        praise: 3,
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名",
        commentContent: "评论内容内容内容",
        date: "5月20日 14:03",
        shareNum: 1,
        commentNum: 29999,
        praise: 3,
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名",
        commentContent: "评论内容内容内容",
        userReplyUser: "王小明等人",
        userReplyNum: 3,
        date: "5月20日 14:03",
        shareNum: 1,
        commentNum: 2,
        praise: 377777,
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名",
        commentContent: "评论内容内容内容",
        userReplyUser: "王小明等人",
        userReplyNum: 3,
        date: "5月20日 14:03",
        shareNum: 1,
        commentNum: 2,
        praise: 3888,
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名",
        commentContent: "评论内容内容内容",
        userReplyUser: "王小明等人",
        userReplyNum: 3,
        date: "5月20日 14:03",
        shareNum: 1,
        commentNum: 2,
        praise: 3,
      },
    ],
    forwardList: [ //  转发列表
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名1",
        commentContent: "评论内容内容内容",
        date: "5月20日 14:03",
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名2",
        commentContent: "评论内容内容内容",
        date: "5月20日 14:03",
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名3",
        commentContent: "评论内容内容内容",
        date: "5月20日 14:03",
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名4",
        commentContent: "评论内容内容内容",
        date: "5月20日 14:03",
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名5",
        commentContent: "评论内容内容内容",
        date: "5月20日 14:03",
      },
    ],
    praiseList: [{
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名1",
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名2",
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名3",
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名4",
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名5",
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名6",
      }

    ]
  },

  // 跳到文章详细
  toArticleDesc(e) {
    wx.navigateTo({
      url: "/pages/main/community/longArticleDetails/index",
    });
  },

  // 关注
  contentAttention(e) {
   
    let articleContent =  e.detail.articleContent
    console.log("contentAttention1111111111111" + articleContent);
    this.setData({
      articleContent: articleContent, //TODO 一定要这样设置值吗
    });
  },

  // 评论成功回调，重新渲染
  itemComment(e) {
    let index = e.detail.index;
    let commentList = this.data.commentList;
    commentList[index].commentContent = "commentContent " + index;
    this.setData({
      commentList: commentList
    })
  },

  // 点赞成功回调，重新渲染
  itemPraise(e) {
    // console.log("长文缩略" + JSON.stringify(e))
    let index = e.detail.index;
    let giveNum = e.detail.giveNum;
    let commentList = this.data.commentList;
    commentList[index].praise = giveNum;
    this.setData({
      commentList: commentList
    })
  },

  // tab切换
  changeTabHandle(e) {
    let index = e.detail;
    this.setData({
      currentTab: index
    });
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    // console.log("look article thumbnail onLoad id = " + this.data.articleID);

    this.setData({
      articleID: options.id,
      showType: options.showType
    });

    // console.log("look article thumbnail onLoad id = " + this.data.articleID);
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {},

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {},

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {},

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {},

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {},

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {},

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {},
});