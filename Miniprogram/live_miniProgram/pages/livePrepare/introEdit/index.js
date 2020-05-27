// pages/liveEdit/introEdit/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    hint: "请输入主播的简介信息",
    ancherIntro: "",
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

    console.log("liveEdit onload ==== " + this.options.intro);
    
    if(this.data.hint == this.options.intro) {

    } else {
      this.setData({
        ancherIntro: options.intro
      })
    }
 
  },


  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    console.log("liveEdit onReady");
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  
    console.log("liveEdit onShow");

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {
    console.log("liveEdit onHide");
  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {
    console.log("liveEdit onUnload");
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    console.log("liveEdit onPullDownRefresh");
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    console.log("liveEdit onReachBottom");
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
    console.log("liveEdit onShareAppMessage");
  },

  // 文本域的输入的事件
  handleTextInput(e) {
  
    this.setData({
      ancherIntro: e.detail.value
    })
   
  },

  editOK() {
    console.log("live intro edit editOK ancherIntro = " + this.data.ancherIntro)
    var pages = getCurrentPages();   //当前页面
    var prevPage = pages[pages.length - 2];   //上个页面
    // 直接给上一个页面赋值
    prevPage.setData({
      ancherIntro: this.data.ancherIntro
    });
    
    wx.navigateBack({
      delta: 1
    })

  }


})