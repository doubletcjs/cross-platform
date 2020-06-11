
var app = getApp();
var rm = wx.getRecorderManager();

 //录音停止时调用
 rm.onStop(function(e) {
  var a = this;
  wx.showLoading({
    title: "正在识别..."
  });

  //上传逻辑
  var n = {
    url: app.globalData.url + "upload",
    filePath: e.tempFilePath,
    name: "music",
    header: {
      "Content-Type": "application/json"
    },
    success: function (res) {
      
    }
  };

  wx.uploadFile(n);
}),



Page({

  /**
   * 页面的初始数据
   */
  data: {
    longhandle:false, // 打开语音
    winHeight:0, // 设备高度
    inputHeight:55, // 输入框高度
    top:0,
    visible:false, // 输入框组件
    inputVal:'', // 输入值
    // 自己的信息type = 0 (文本) 1(语音) 2 (图片) 3 (视频)
    says:[
      {
        time:'2020-06-01 09:23',
        type:0,
        me:true,
        contentType:'string',
        portraitSrc:'/icons/person.png',
        content:'已经关注了，期待期待，求带 飞~'
      },
      {
        time:'2020-06-01 09:23',
        type:0,
        me:true,
        contentType:'string',
        portraitSrc:'/icons/person.png',
        content:'已经关注了，期待期待，求带 飞~'
      },
      {
        time:'2020-06-01 09:23',
        type:1,
        me:false,
        contentType:'string',
        portraitSrc:'/icons/person.png',
        content:'关注黑科技，未来值得期待 哟~'
      },
      {
        time:'2020-06-01 09:23',
        type:0,
        me:true,
        contentType:'string',
        portraitSrc:'/icons/person.png',
        content:'已经关注了，期待期待，求带 飞~'
      },
      {
        time:'2020-06-01 09:23',
        type:0,
        contentType:'string',
        me:false,
        portraitSrc:'/icons/person.png',
        content:'关注黑科技，未来值得期待 哟~'
      }
    ],
   

  },
  // 点击语音
  voiceClick(){
    let longhandle = !this.data.longhandle;
    this.setData({longhandle:longhandle})
    console.log(longhandle)
  },
  // 长按说话
  bindlongpress(){
    console.log(454545)
    this.openRecording()
  },
  // 打开输入框
  openInput(){
    this.setData({visible:true,inputVal:''})
  },
  inputChange(e){
    // console.log(e)
    this.setData({inputVal:e.detail.value})
  },
  // 关闭输入框
  closeInput(){
    this.setData({visible:false})
  },
  bindblur(){
    this.closeInput()
  },
  // 发送信息
  sendMsg(e){
    let sendMsg = this.data.inputVal;
    console.log(e,sendMsg)
  },
  bindfocus(e){
    let h = e.detail.height;
    let that = this;
    
    wx.createSelectorQuery().select('#inputComponent').boundingClientRect(function (rect) {
      console.log('rect',rect,that.data.top)
      let inputHeight = rect?rect.height:55;
      that.setData({inputHeight:inputHeight})
      that.setData({top:that.data.winHeight - h - that.data.inputHeight})
      console.log('inputHeight==',that.data.inputHeight,that.data.top)
    }).exec()

    console.log(e,h)
  },
  // 空函数阻止事件冒泡
  empty(){},
  // 关闭输入框
  colseInput(){
    this.setData({visible:false})
  },
  // 发送图片视频文件
  sendImg(){
    let that = this;
    console.log('sendImg')
    wx.chooseMessageFile({
      count: 10,
      type: 'all',
      success (res) {
        // tempFilePath可以作为img标签的src属性显示图片
        const tempFilePaths = res.tempFiles;
        console.log(tempFilePaths)
        /**
         * {
          time:'2020-06-01 09:23',
          type:0,
          contentType:'string',
          me:false,
          portraitSrc:'/icons/person.png',
          content:'关注黑科技，未来值得期待 哟~'
        }
         */
        let says = that.data.says;
        for(let i=0;i<tempFilePaths.length;i++){
          console.log(tempFilePaths[i])
          let obj = {
            time:'2020-06-01 09:23',
            type:1,
            contentType:'img',
            me:false,
            portraitSrc:'/icons/person.png',
            content:tempFilePaths[i].path
          }
          says.push(obj);
          that.setData({says:says})
        }

        

      }
    })
  },
  // 预览图片
  previewImage(e){
    console.log(e)
    let says = this.data.says;
    let urls = [];
    for(let item of says){
      if(item.contentType == 'img'){
        urls.push(item.content)
      }
    }
    wx.previewImage({
      current: e.currentTarget.dataset.src, // 当前显示图片的http链接
      urls: urls // 需要预览的图片http链接列表
    })
  },
  // 开始录音
  openRecording(){
    let that = this;


    wx.getSetting({
      success: function (t) {
        console.log(t.authSetting), t.authSetting["scope.record"] ? console.log("已授权录音") : (console.log("未授权录音"),
          wx.openSetting({
            success: function (t) {
              console.log(t.authSetting);
            }
          }));
      }
    });


    

  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var a = this;
      wx.authorize({
        scope: "scope.record",
        success: function() {
          console.log("录音授权成功");
        },
        fail: function() {
          console.log("录音授权失败");
        }
      }), a.onShow()
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    let that = this;
    wx.getSystemInfo({ 
      success: function (res) {
        // 设备的高度
        let winHeight = res.windowHeight;
        that.setData({
          winHeight:winHeight
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

  }
})