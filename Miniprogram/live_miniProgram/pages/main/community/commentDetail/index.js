// pages/main/community/commentDetail/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    id: '',
    inputVisible: false,
    otherVisible: false,
    other_items: ["回复", "转发", "复制", "投诉", "置顶"],
    myVisible: false,
    my_items: ["删除", "转发", "复制", "置顶"],
    commentList: [{
        headIcon: "/icons/person.png",
        name: "用户姓名",
        commentContent: "评论内容内容内容1",
        date: "5月20日 14:03",
        shareNum: 199999999,
        commentNum: 2,
        praise: 3,
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名",
        commentContent: "评论内容内容内容2",
        date: "5月20日 14:03",
        shareNum: 1,
        commentNum: 29999,
        praise: 3,
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名",
        commentContent: "评论内容内容内容3",
        date: "5月20日 14:03",
        shareNum: 1,
        commentNum: 2,
        praise: 377777,
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名",
        commentContent: "评论内容内容内容4",
        date: "5月20日 14:03",
        shareNum: 1,
        commentNum: 2,
        praise: 3888,
      },
      {
        headIcon: "/icons/rechargeComplete@3x.png",
        name: "用户姓名",
        commentContent: "评论内容内容内容5",
        date: "5月20日 14:03",
        shareNum: 1,
        commentNum: 2,
        praise: 3,
      },
    ],
    copyContent: '' // 复制内容
  },


  // 评论详细评论列表整个item点击的回调
  commentListItemHandle(e) {
    let selectIndex = e.detail.index
    let showType = e.detail.showType // 0 评论列表使用  1 评论详情界面使用
    console.log("评论详细评论列表整个item点击的回调 selectIndex=" + selectIndex + " showType=" + showType)

    if (showType === 1) {

      let copyContent = e.detail.copyContent
      this.setData({
        copyContent: copyContent
      })

      if (selectIndex % 2) {
        this.setData({ // 别人的评论
          otherVisible: true,
        })
      } else { // 自己的评论
        this.setData({
          myVisible: true,
        })
      }

    } else {

    }

  },

  // 关闭popwindow
  actionCloseClick() {
    this.setData({
      otherVisible: false,
      myVisible: false
    })
  },

  // 评论popwindow操作方式的回调
  itemSelect(e) {
    let selectIndex = e.detail.index
    let operationType = e.detail.operationType // 0 别人的评论操作  1 自己的评论操作
    console.log("评论popwindow操作方式的回调----selectIndex " + selectIndex + " ----operationType " + operationType)


    if (operationType === 0) { //  别人的评论操作

      switch (selectIndex) {
        case 0: // 回复
          this.setData({
            inputVisible: true
          })
          break;
        case 1: // 转发

          let transmitType = true //  转发类型 false 文章转发  true 评论列表转发
          wx.navigateTo({
            url: '/pages/main/community/longArticleDetails/transmitArticle/index?transmitType=' + transmitType,
            success: function (res) {

            }
          })
          break;
        case 2: // 复制
          wx.setClipboardData({
            data: this.data.copyContent,
            success(res) {
              wx.getClipboardData({
                success(res) {
                  console.log(res.data) // data
                }
              })
            }
          })
          console.log("copyContent = " + this.data.copyContent)
          break;
        case 3: // 投诉
          wx.navigateTo({
            url: '/pages/main/community/complaints/index'
          })
          break;
        case 4: // 置顶

          break;
        default:

      }

    } else { // 自己的评论操作

      switch (selectIndex) {
        case 0: // 删除

          break;
        case 1: // 转发

          break;
        case 2: // 复制

          break;
        case 3: // 置顶

          break;
        default:

      }

    }

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
    console.log("评论详情" + JSON.stringify(e))
    let index = e.detail.index;
    let giveNum = e.detail.giveNum;
    let commentList = this.data.commentList;
    commentList[index].praise = giveNum;
    this.setData({
      commentList: commentList
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

    console.log("---" + this.options.id);

    this.setData({
      id: options.id
    })

  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})