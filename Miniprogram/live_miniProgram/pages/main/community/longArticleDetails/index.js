// pages/main/community/longArticleDetails/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    visible:false, // 输入框
    totalGold:23.3, // 剩余的金币总数
    goldNumber:0, // 打赏的金币数量
    isInput:false, // 是否可输入金币
    payalertvisible:false, // 显示打赏金币
    rewardvisible:false, // 打赏弹框
    list:'<h2>html 文章 内容</h2><p>html 文章 内容</p><p>html 文章 内容</p><p>html 文章 内容</p><p>html 文章 内容</p><p>html 文章 内容</p><p>html 文章 内容</p><p>html 文章 内容</p>'
  },
  // 查看打赏情况
  lookGiveAuthor(){
    wx.navigateTo({
      url: '/pages/main/community/lookGiveAuthor/index',
      success: function(res) {
        
      }
    })
  },
  // 打赏作者
  giveAuthor(){
    this.setData({rewardvisible:true})
    console.log('giveAuthor==',this.data.rewardvisible)
  },
  closeClick(){
    this.setData({rewardvisible:false,payalertvisible:false})
    console.log('giveAuthor==',this.data.rewardvisible)
  },
  // 打赏
  alertConfirm(e){
    if(e.detail.number == -1){ // 其他金币
      this.setData({goldNumber:e.detail.number,payalertvisible:true,isInput:true})
    }else{
      this.setData({goldNumber:e.detail.number,payalertvisible:true,isInput:false})
    }
    
    console.log('goldNumber=',this.data.goldNumber,e)
  },
  // 确定支付打赏
  payalertConfirm(e){
    // console.log('确认支付=',this.data.goldNumber,e)
    let goldNum = 0;
    if(this.data.isInput){ // 可输入金币的值
      goldNum = e.detail.number;
    }else{ // 不可变的金币值
      goldNum = this.data.goldNumber;
    }
    console.log('goldNum支付的金币 == ',goldNum)
    wx.showToast({
      title:'支付成功',
      icon:'none',
      duration:2000
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