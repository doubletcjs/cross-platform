// pages/main/community/longArticleDetails/bottomInput/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    // 转发的类型 1 （转发文章） 2:转发评论
    transmitType:{
      type:Number,
      value:1
    },
    // 获焦点输入框显示
    visible:{
      type:Boolean,
      value:false
    }
  },
  
  /**
   * 组件的初始数据
   */
  data: {
    focus:false,
    visibleShare:false, // 分享弹框
  },
  /**
   * 组件的方法列表
   */
  methods: {
    openInput(){
      this.setData({visible:true})
    },
    closeInput(){
      this.setData({visible:false})
    },
    sendMsgSuccess(e){
      console.log(e.detail)
    },
    bindfocus(e){
      this.setData({focus:true})
    },
    bindblur(){
      this.setData({focus:false})
    },
    // 点赞
    give(){
      console.log('give')
    },
    // 去转发
    transmit(){
      let transmitType = this.data.transmitType;
      wx.navigateTo({
        url: '/pages/main/community/longArticleDetails/transmitArticle/index?transmitType='+transmitType,
        success: function(res) {
          
        }
      })
    },
    // 分享
    share(){
      this.setData({visibleShare:true})
    },
    closeShare(){
      this.setData({visibleShare:false})
    }
  }
})
