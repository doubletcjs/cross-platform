// pages/main/community/longArticleDetails/transmitArticle/index.js
Page({


  /**
   * 页面的初始数据
   */
  data: {
    transmintType: false, // 转发类型 false 文章转发  true 评论列表转发
    articleDetail: '', // 文章
    commentDetail: '', // 评论
    hint: "说说分享心得",
    textareaValue: ''
  },

  transmintHandle() {
    console.log("转发成功!");
    wx.showToast({
      title: '转发成功',
      icon: 'none',
      duration: 2000
    })
    
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

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