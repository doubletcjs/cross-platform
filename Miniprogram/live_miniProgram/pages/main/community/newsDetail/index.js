// pages/main/community/newsDetail/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    visible:false,
    lists:[
      {
        src:'/icons/person.png',
        nicname:'Sam',
        sayConetnt:'期待很久了',
        time:'5月20日 14:03',
        giveNum:12,
        says:[
          {
            name:'嘻嘻睡吧'
          },
          {
            name:'嘻嘻睡吧'
          },
          {
            name:'嘻嘻睡吧'
          }
        ],
      },
      {
        src:'/icons/person.png',
        nicname:'Sam',
        sayConetnt:'期待很久了',
        time:'5月20日 14:03',
        giveNum:49,
        says:[
          
        ],
      }
    ]
  },
  // 发送评论
  sendMsgSuccess(e){
    console.log('评论内容==',e)
  },
  // 评论这条评论
  say(){
    console.log(999)
    this.setData({visible:true})
  },
  // 去评论页面
  gosay(){
    let id = 1;
   wx.navigateTo({
     url: '/pages/main/community/commentDetail/index?id=' + id,
     success: (result)=>{
       
     },
     fail: ()=>{},
     complete: ()=>{}
   });
  },
  // 点赞
  give(){
    console.log('give')
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