// pages/tabList.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    anchor:{
      type:Object,
      value:{}
    },
    attention:{ // 关注状态
      type:Boolean,
      value:false
    }
  },
  /**
   * 组件的初始数据
   */
  data: {
    giftvisible:false,

  },
  
  /**
   * 组件的方法列表
   */
  methods: {
   // 关注主播
    attentionAnchor(){
      console.log('关注主播',!this.properties.attention)
      // this.triggerEvent('attention',!this.properties.attention)
      this.triggerEvent('attention',!this.properties.attention)
    },
    // sendgift 赠送礼物
    sendgift(){
      console.log('赠送礼物。。。。')
      this.setData({giftvisible:true})
    },
    // 送礼物成功回调e
    sendgiftobjSuccess(e){
      this.setData({giftvisible:false})
      // console.log(e.detail)
      this.triggerEvent("sendgiftobj",e.detail)
    },
    // 关闭礼物弹框
    closeClick(){
      this.setData({giftvisible:false})
    },
    // goLookVideo 查看往期视频
    goLookVideo:function(){
      // 传主播的 id
      // wx.navigateTo({
      //   url:'pages/liveRoom/livehost/index?id=12',  //跳转页面的路径，可带参数 ？隔开，不同参数用 & 分隔；相对路径，不需要.wxml后缀
      //   success:function(){},        //成功后的回调；
      //   fail：function(){},          //失败后的回调；
      //   complete：function(){}      //结束后的回调(成功，失败都会执行)
      // })
     let anchorId = 12;
      wx.navigateTo({
        url: '/pages/liveRoom/livehost/index?id='+anchorId,
        success: function(res) {
          // 通过eventChannel向被打开页面传送数据
          // res.eventChannel.emit('acceptDataFromOpenerPage', { data: 'test' })
        }
      })

    }
  }
})
