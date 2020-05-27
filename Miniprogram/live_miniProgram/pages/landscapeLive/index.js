var that = undefined;
var doommList = [];
var i = 0;
var ids=0;
var cycle=null  //计时器

// 弹幕参数
class Doomm {
  constructor(say,nicname,type, top, time, color) {  //内容，顶部距离，运行时间，颜色（参数可自定义增加）
    this.say = say;
    this.type = type;
    this.nicname = nicname;
    this.top = top;
    this.time = time;
    this.color = color;
    this.display = true;
    this.id = i++;
  }
}
// 弹幕字体颜色
function getRandomColor() {
  let rgb = []
  for (let i = 0; i < 3; ++i) {
    let color = Math.floor(Math.random() * 256).toString(16)
    color = color.length == 1 ? '0' + color : color
    rgb.push(color)
  }
  return '#' + rgb.join('')
}

Page({

  /**
   * 页面的初始数据
   */
  data: {
    playUrl:'http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4',
    giveOff:true, // 点赞开关
    grveNumAnimation:false, // 动画开关
    giftvisible:false, // 送礼物弹框开关
    allgiftArr:[],  // 礼物数组
    grveNum:512,  // 点赞数量
    attention:false, // 关注
    alertvisible:false, // 提示框
    sharevisible:false, // 分享框
    contentString:'', // 提示alert
    visible:false, // 输入框显示
    inputFpcus:false, // 輸入框獲取焦點狀態
    doommData: [ // 彈幕對象列表
      
    ], 
    arr: [ // 评论的内容
      {
        type:'F0',
        nicname:'布道者',
        say:'选择华科闪云，值得！！!'
      },
      {
        type:'F0',
        nicname:'布道者2',
        say:'选择华科闪云，值得！！!'
      }
    ],
    toggleShow:false, // 点击页面切换显示
    sendGiftOff:false, // 屏蔽礼物显示
    danmuOff:false,  // 屏蔽弹幕
    hideAnimation:false, //礼物隐藏动画 
    sendGifts:[ // 赠送的礼物列表
     
    ]
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    that = this;
    //弹幕动画
    cycle= setInterval(function () { 
       let arr=that.data.arr;
        /**
         * {
            type:'F0',
            id:0,
            nicname:'布道者',
            say:'选择华科闪云，值得！！!'
          },
          
         */
        if(arr[ids]==undefined){
          ids = 0
          // 1.循环一次，清除计时器
          // doommList = []
          // clearInterval(cycle)

          // 2.无限循环弹幕
          
          doommList.push(new Doomm(arr[ids].say,arr[ids].nicname,arr[ids].type, Math.ceil(Math.random() * 100), 8, getRandomColor()));
          if(doommList.length>5){   //删除运行过后的dom
              doommList.splice(0, 1)
          }
          that.setData({
            doommData: doommList
          })
          ids++
        }else{
          console.log(arr[ids].say)
          doommList.push(new Doomm(arr[ids].say,arr[ids].nicname,arr[ids].type, Math.ceil(Math.random() * 100), 8, getRandomColor()));
          if(doommList.length>5){  
              doommList.splice(0, 1)
          }
          that.setData({
            doommData: doommList
          })
          ids++
        }
    }, 2000)
    
    // 送礼物显示
    // 定时删除1个礼物 定时监听礼物动画

     setInterval(()=>{
       let arr = that.data.sendGifts;
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
         that.setData({sendGifts:arr,hideAnimation:false})
       },4000)
     },6000)
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
    clearInterval(cycle)
    ids=0;
    doommList=[]
  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {
    clearInterval(cycle)
    ids = 0;
    doommList = []
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

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
  onFullScreenChange(){
    
  },
  // 点击页面切换显示
  toggleShow(){
    let toggleShow = !this.data.toggleShow;
    this.setData({toggleShow:toggleShow})
   
    console.log(this.data.toggleShow)
  },
  // 切换关闭礼物动画
  togglesendGiftOff(){
    let sendGiftOff = !this.data.sendGiftOff;
    this.setData({sendGiftOff:sendGiftOff})
  },
  // 切换屏蔽弹幕
  toggleStopcontent(){
    let danmuOff = !this.data.danmuOff;
    this.setData({danmuOff:danmuOff})
  },
  emtyhanle(){},
  // 添加一個彈幕
  bindbt:function(data){
    doommList.push(new Doomm(data,Math.ceil(Math.random()*100),Math.ceil(Math.random()*10),getRandomColor()));
    this.setData({
      doommData : doommList
    })
  },
  // 關注主播
  attentionAnchor(){
    this.setData({attention:!this.data.attention})
    if(this.data.attention){
      this.setData({alertvisible:true,contentString:'关注成功，系统会在开播前10分钟推送相关信息，请留意。'})
    }else{
      this.setData({alertvisible:true,contentString:'已取消关注，将不会收到活动相关信息，如有需要，请重新关注，谢谢！'})
    }
    // this.setData({alertvisible:true,contentString:'关注成功，系统会在开播前10分钟推送相关信息，请留意。', attention:e.detail})
    console.log('attentionAnchor')
  },
  // 关闭alert 弹框
  alertcloseClick(){
    // console.log(888)
    this.setData({alertvisible:false})
  },
  // goShooping
  goShooping(){
     // 跳转到商城
     console.log(787878)
     wx.switchTab({
      url: '/pages/main/mall/index'
    })
  },
  // 點贊
  give(){
    console.log('点赞') 
    if(this.data.giveOff){
      this.setData({grveNum:this.data.grveNum + 1,grveNumAnimation:true,giveOff:false})
      setTimeout(()=>{
        this.setData({grveNumAnimation:false,giveOff:true})
      },1600)
    }
  },
  // 关闭送礼物弹框
  closeClick(){
    this.setData({giftvisible:false})
  },
  // 打开送礼物弹框
  openSendGift(){
    console.log('打开送礼物弹框')
    this.setData({giftvisible:true})
  },
  // 送礼物成功回调
  sendgiftobjSuccess(e){
    let giftobj = e.detail;
    let sendGifts = this.data.sendGifts;
    sendGifts.unshift(giftobj);
    console.log(sendGifts)
    this.setData({sendGifts:sendGifts,giftvisible:false})
  },
  // 打开输入框
  openInput(){
    this.setData({visible:true})
  },
  //关闭
  closeInput(){
    console.log('guanbi')
    this.setData({visible:false})
  },
  // 评论弹幕成功
  sendMsgSuccess(e){
    console.log('评论弹幕成功',e)
    this.bindbt(e.detail)
  },
  // 打开分享
  shareOpen(){
    console.log('打开分享')
    this.setData({sharevisible:true})
  },
  sharecloseClick(){
    this.setData({sharevisible:false})
  }
})