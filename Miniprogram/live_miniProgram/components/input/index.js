// pages/tabList.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    videLook:{ // 是否是查看视频回放
      type:Boolean,
      value:false
    },
    keyboardHeight:{ // 键盘高度
      type:Number,
      value:0
    }
  },

  /**
   * 组件的初始数据
   */
  data: {
    focus:false,
    adjust:false,
    inputVal:'',
    inputHeight:0, // input 高度
    winHeight:0  // 视口高度
  },
  ready: function() {
    
  },
  /**
   * 组件的方法列表
   */
  methods: {
    bindfocushandle:function(e){ // 输入框失去焦点
      let keyboardHeight = e.detail.height;
      this.triggerEvent('keyboardHeight',keyboardHeight)
      this.setData({
        focus:true
      })
      
    },
    bindblurhandle:function(e){ // 输入框获得焦点
      this.triggerEvent('keyboardHeight',0)
      this.setData({
        keyboardHeight:0
      })
      this.setData({
        focus:false
      })
    },
    inputChange(e){
      this.setData({
        inputVal:e.detail.value
      })
    },
    // 点击获取焦点
    focusClick(){
      console.log('open')
      this.triggerEvent('openInput')
    },
    // 发送评论
    sendMsg(){
      let val = this.data.inputVal;
      
      // 发送数据 完成通知 评论组件更新评论内容

      console.log(val)
      this.setData({
        inputVal:''
      })
      this.triggerEvent('sendMsgSuccess')
    },
    // 发送礼物
    sendgift:function(){
      this.triggerEvent('sendgift')
    },
    // 送金币
    sendmoney:function(){
      console.log(666)
      this.triggerEvent('sendmoney')
    },
    // moreOption 更多选项操作
    moreOption:function(){
      this.triggerEvent('moreOption')
    }
  }
})
