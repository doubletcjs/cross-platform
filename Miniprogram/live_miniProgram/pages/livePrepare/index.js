// pages/livePrepare/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    ancherIntro: "请输入主播的简介信息",
    isChecked: false,
    anchorImg: '/icons/person.png',
    isAuth: false
  },

  isRecord() {
    this.setData({
      isChecked: !this.data.isChecked
    })
  },

  // 点击选择图片
  handleChooseImg() {
    // 2 调用小程序内置的选择图片api
    wx.chooseImage({
      // 同时选中的图片的数量
      count: 1,
      // 图片的格式  原图  压缩
      sizeType: ['original', 'compressed'],
      // 图片的来源  相册  照相机
      sourceType: ['album', 'camera'],
      success: (result) => {

        this.setData({
          // 图片数组 进行拼接 
          anchorImg: result.tempFilePaths
        })
      },
      fail: {

      }
    });

  },

  /** 开始视频直播 */
  toLive: function () {
    this.setData({
      isAuth: !this.data.isAuth
    })
    console.log("toLive " + this.data.isAuth);
  },

  /**身份认证 */
  toAuth: function () {
    console.log("toAuth");
    
  },

   /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    console.log("livePrepare onLoad");
  
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    console.log("livePrepare onReady");
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  
    console.log("livePrepare onShow");

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {
    console.log("livePrepare onHide");
  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {
    console.log("livePrepare onUnload");
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    console.log("livePrepare onPullDownRefresh");
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    console.log("livePrepare onReachBottom");
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
    console.log("livePrepare onShareAppMessage");
  }

})