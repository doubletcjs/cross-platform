// pages/liveRoom/playback/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    height:0, // 评论区view 高度
    isVideLook:true, // 是否是查看回放
    visible:false, // 输入框显示
    grveNum:1255, // 点赞数量
    lookNum:10566, // 播放数量
    inputBoxHeight:50, // 输入组件view 的高度
    keyboardHeight:0, // 键盘高度
    giveOff:true,
    grveNumAnimation:false, // 点赞动画控制
    sayLists:[
      {
        type:0,
        nicname:'我是个游客',
        sayContent:'直播的内容很专业',
        answer:null
      },
      {
        type:'F0',
        nicname:'9点',
        sayContent:'直播的内容很专业',
        answer:{
          content:'谢谢你的喜欢，我们会再接再厉'
        }
      },
      {
        type:'F1',
        nicname:'空中漫步者',
        sayContent:'我爱华科闪云~~',
        answer:{
          content:'谢谢你的喜欢，我们会再接再厉'
        }
      },
      {
        type:'F2',
        nicname:'空中漫步者3',
        sayContent:'我爱华科闪云~~',
        answer:{
          content:'谢谢你的喜欢，我们会再接再厉'
        }
      },
      {
        type:'F3',
        nicname:'空中漫步者3',
        sayContent:'我爱华科闪云~~',
        answer:{
          content:'谢谢你的喜欢，我们会再接再厉'
        }
      },
      {
        type:'S1',
        nicname:'空中漫步者3',
        sayContent:'说的太好了，再来看一次说的太好了，再来看一次说的太好了，再来看一次说的太好了，再来看一次说的太好了，再来看一次说的太好了，再来看一次',
        answer:{
          content:'谢谢你的喜欢，我们会再接再厉'
        }
      },
      {
        type:'S2',
        nicname:'空中漫步者3',
        sayContent:'直播的内容很专业',
        answer:{
          content:'值得拥有哦'
        }
      },
      {
        type:'S3',
        nicname:'空中漫步者3',
        sayContent:'我爱华科闪云~~',
        answer:{
          content:'谢谢你的喜欢，我们会再接再厉'
        }
      }
    ]
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    // 获取视频的id
    console.log(options.id)

  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    let that = this;
    wx.getSystemInfo({ 
      success:function(res){
        console.log(res)
        let winHeight = res.windowHeight;
        that.setData({
          winHeight:winHeight
        })
        const query = wx.createSelectorQuery()
        query.selectAll('#inputBox,#player').boundingClientRect()
        query.selectViewport().scrollOffset()
        query.exec(function(result){
         console.log(result)

          var heights = 0;
          result[0].forEach(element => {
            heights+=element.height;
          });

          that.setData({
            height:that.data.winHeight - heights - 90
          })
          that.setData({
            inputBoxHeight:result[0][1].height
          })

        })


      }
    })
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

  // 页面的其他方法
  sendMsgSuccess(){
    console.log('发送信息')
  },
  // 点赞
  // 点赞
  give(){
    console.log('点赞')
    if(this.data.giveOff){
      this.setData({grveNum:this.data.grveNum + 1,grveNumAnimation:true,giveOff:false})
      setTimeout(()=>{
        this.setData({grveNumAnimation:false,giveOff:true})
      },1600)
    }

  },
  keyboardHeight(data){
    // console.log(data)
    let keyboardHeight = data.detail;
    this.setData({keyboardHeight:keyboardHeight})
  },
  // 打开输入框
  openInput(){
    console.log(11)
    this.setData({visible:true})
  },
  closeInput(){
    this.setData({visible:false})
  },
   // 发送评论成功处理
  sendMsgSuccess(e){
    console.log('评论成功',e)
  },

})