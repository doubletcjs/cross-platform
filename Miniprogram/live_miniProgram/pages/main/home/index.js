// pages/main/home/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    visible: false,
    actionvisible: false
  },


  alertview: function () {
    this.setData({
      visible: !this.data.visible
    })
  },

  actionsheet: function () {
    this.setData({
      actionvisible: !this.data.actionvisible
    })
  },

  closeClick: function () {
    this.setData({
      visible: false,
      actionvisible: false
    })
  },

  alertConfirm: function () {
    console.log("alertConfirm")
  },

  itemSelect: function (res) {
    // wx.navigateTo({
    //   url: '/pages/recharge/index?type=' + res.detail.index,
    //   success: (result) => {

    //   },
    //   fail: (error) => {
    //     console.log("error:" + JSON.stringify(error))
    //   },
    //   complete: () => {}
    // });
    wx.navigateTo({
      url: '/pages/liveRoom/livehost/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
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