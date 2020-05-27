// pages/activity/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    id: '',
  },
  name: '',

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    console.log("activity onLoad id = " + this.id + " name = " + this.name);
    this.id = options.id
    this.name = options.name
    console.log("activity onLoad id = " + this.id + " name = " + this.name);
    
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
  
    console.log("activity onShow id = " + this.id + " name = " + this.name);
    let pages = getCurrentPages();
    let currentPage = pages[pages.length - 1];
    let options = currentPage.options;
    this.id = options.id
    this.name = options.name
    console.log("activity onShow id = " + this.id + " name = " + this.name);

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