// pages/main/mall/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    products: [{
      name: "学霸学习，国AA级护眼认证，智能护目灯",
      price: 149,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 59,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 59,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 59,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 59,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 59,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }]
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

  },
  //消息中心
  showMessageCenter: function () {
    wx.navigateTo({
      url: '/pages/main/community/messagecenter/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //搜索中心
  goSearch: function () {
    wx.navigateTo({
      url: '/pages/main/mall/searchcenter/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //分类
  goClassify: function () {
    wx.navigateTo({
      url: '/pages/main/mall/classify/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
})