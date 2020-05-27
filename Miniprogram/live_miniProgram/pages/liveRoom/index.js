// pages/liveRoom/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    isLive:true,

    playing: true, // true 播放中  false 暂停
    autoplay: false, // 是否自动播放，
    playUrl: 'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4',
    videoContext: {}, // live-player对象

    tablists:["聊天","主播","排行","观众"],
    currentTab:0, // tab 初始下标
    height:0, // 评论区高度
    videoHeight:0, // 视频播放组件高度 
    tabHeight:0, // tab 组件高度
    inputHeight:0, // 底部输入框组件高度
    winHeight:0, // 设备视口高度
    attention:false, // 是否关注
    grveNum:5214, // 点赞数量
    visible:false, // 输入框获取焦点显示
    grveNumAnimation:false, // 点赞动画控制
    giveOff:true, // 防止多次快速点击
    giftvisible:false, // 礼物赠送是否显示
    allgiftArr:[],
    actionvisible:false, // 充值方法显示
    livemorevisible:false,  // 操作更多弹框显示
    sendGiftOff:false, // 屏蔽礼物开关
    sendContentOff:false, // 关闭弹幕开关
    alertvisible:false,
    contentString:'关注成功，系统会在开播前10分钟推送相关信息，请留意。', // 关注成功，系统会在开播前10分钟推送相关信息，请留意。  已取消关注，将不会收到活动相关信息，如有需要，请重新关注，谢谢！
    sayList:[  // 聊天评论内容
      {
        type:'F0',
        author:'空中漫步者',
        say:'直播内容太好了hga'
      },
      {
        type:'F1',
        author:'空中漫步者',
        say:'直播内容太好了 直播内容太好了直播内容太好了！！！'
      },
      {
        type:'F2',
        author:'空中漫步者',
        say:'直播内容太好了 23233！！！'
      },
      {
        type:'F3',
        author:'空中漫步者',
        say:'直播内容太好了hdghasgdh ！！！'
      },
      {
        type:'S1',
        author:'空中漫步者',
        say:'直播内容太好了dsadada ！！！'
      },
      {
        type:'S2',
        author:'空中漫步者',
        say:'直播内容太好了ghhjj ！！！'
      },
      {
        type:'S3',
        author:'空中漫步者',
        say:'直播内容太好了6666 ！！！'
      }
    ],
    hideAnimation:false, // 控制隐藏动画
  },
  // 弹出输入框
  openInput(e){
    this.setData({visible:true})
    console.log(this.data.visible,e)
  },
  closeInput(){
    this.setData({visible:false})
    console.log('closeInput')
  },
  //播放事件
  onPlayEvent: function (e) {
    console.log("onPlayEvent===" +e.detail.code);
    if (e.detail.code == -2301) {
      this.stop();
      wx.showToast({
        title: '拉流多次失败',
      })
    }
    if (e.detail.code == 2004) {
      wx.hideLoading();
    }
  }, 

  onFullScreenChange() {

  },

  // 视频播放和暂停
  onPlayClick() {
    
    this.setData({
      playing: !this.data.playing,
    })
    if (this.data.playing) { // 开始播放
      this.data.videoContext.play();
      console.log("video play()");
    } else { // 停止播放
      this.data.videoContext.stop();
    }
  },

  createContext: function () {
    this.setData({
      videoContext: wx.createLivePlayerContext("video-livePlayer")
    })
  },

  // 关注操作
  attention:function(e){
    if(e.detail){
      this.setData({alertvisible:true,contentString:'关注成功，系统会在开播前10分钟推送相关信息，请留意。', attention:e.detail})
    }else{
      this.setData({alertvisible:true,contentString:'已取消关注，将不会收到活动相关信息，如有需要，请重新关注，谢谢！', attention:e.detail})
    }
  },
   // 关闭关注提示框
  alertcloseClick(){
    this.setData({alertvisible:false})
  },
  // // 设置tab 下标 tab 切换
  changeTabhandle:function(indexdata){ 
    this.setData({
      currentTab:indexdata.detail
    })
    // 切换不是聊天的tab 就设置高度 auto
    if(this.data.currentTab != 0){
      this.setData({
        height:this.data.winHeight - this.data.videoHeight - this.data.tabHeight
      })
    }else{
      this.setData({
        height:this.data.winHeight - this.data.videoHeight - this.data.tabHeight - this.data.inputHeight
      })
    }
  },
  // 发送评论成功处理
  sendMsgSuccess(e){
    console.log('评论成功',e)
  },
  // 发送礼物
  sendgift:function(){
    this.setData({giftvisible:true})
  },
  // 发送礼物成功的回调
  sendgiftobjSuccess(e){
    let giftobj = e.detail;
    let allgiftArr = this.data.allgiftArr;
    allgiftArr.unshift(giftobj);
    console.log(allgiftArr)
    this.setData({allgiftArr:allgiftArr,giftvisible:false})
  },
  // sendmoney 送金币
  sendmoney:function(){
    console.log('送金币')
    this.setData({actionvisible:true})
  },
  // 选择充值方式的回调
  itemSelect(e){
    let selectIndex = e.detail.index;
    console.log(selectIndex)
    wx.navigateTo({
      url: "/pages/recharge/index?type="+selectIndex
    })
    
  },
  // 显示更多操作弹框
  moreOption:function(){
    this.setData({livemorevisible:true})
  },
   // 关闭更多操作弹框
  livemorecloseClick(){
    this.setData({livemorevisible:false})
  },
  livemoreItemSelect(e){
    //  sendGiftOff:false, // 屏蔽礼物开关
    // sendcommentOff:false
    let name = e.detail.name;
    let off = e.detail.off;
    if(name == "屏蔽礼物"){
      this.setData({sendGiftOff:off})
      if(this.data.sendGiftOff === true){
        this.setData({allgiftArr:[]})
      }
    }else{ // 关闭弹幕
      this.setData({sendContentOff:off})
      if(this.data.sendContentOff === true){
        this.setData({contents:[]})
      }
    }
    console.log(name,e)
  },
  // 推荐商品
  shooping:function(){
    // 跳转到商城
    wx.switchTab({
      url: '/pages/main/mall/index'
    })
    
  },
  // closeClick 关闭商品推荐弹框
  closeClick(){
    this.setData({giftvisible:false})
  },
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
  // actionCloseClick
  actionCloseClick(){
    this.setData({actionvisible:false})
  },
 
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    // 定时删除1个礼物 定时监听礼物动画
    var that = this;

    setInterval(()=>{
      let arr = that.data.allgiftArr;
      if(arr.length == 0) {
        return false;
      }
      if(that.data.sendGiftOff === true){ // 屏蔽了礼物，不给出现动画礼物
        return false;
      }
     
      setTimeout(()=>{
        this.setData({hideAnimation:true})
      },3000)
      setTimeout(()=>{
        arr.pop()
        that.setData({allgiftArr:arr,hideAnimation:false})
      },4000)
    },6000)

  },
  gotolandscapeLive(){
    console.log('landscapeLive')
    wx.navigateTo({
      url: '/pages/landscapeLive/index'
    })
  },
  gotoIPFSFilecoinDetail(){
    console.log('IPFSFilecoinDetail')
    wx.navigateTo({
      url: '/pages/IPFSFilecoinDetail/index'
    })
  },
  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    let that = this;

    this.createContext();
    this.data.videoContext.play();

    wx.getSystemInfo({ 
      success: function (res) {
        // 设备的高度
        let winHeight = res.windowHeight;
        that.setData({
          winHeight:winHeight
        })
        const query = wx.createSelectorQuery()
        query.selectAll('#inputBox,#player,#tab').boundingClientRect()
        query.selectViewport().scrollOffset()
        query.exec(function(res){
        //  console.log(res)

         var heights = 0;
         res[0].forEach(element => {
          heights+=element.height;
         });

        //  videoHeight tabHeight inputHeight
         console.log(heights,winHeight-heights)
         that.setData({
          height:winHeight-heights
         })
        that.setData({
          videoHeight:res[0][0].height
         })
         that.setData({
          tabHeight:res[0][1].height
         })
         that.setData({
          inputHeight:res[0][2].height
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
    this.data.videoContext.stop();
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