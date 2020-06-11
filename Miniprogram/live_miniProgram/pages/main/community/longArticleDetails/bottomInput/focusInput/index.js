// pages/main/community/longArticleDetails/bottomInput/focusInput/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    visible:{
      type:Boolean,
      value:false
    },
    placeholder:{
      type:String,
      value:'说点什么~'
    },
     // 是否横屏
    landscape:{
      type:Boolean,
      value:false
    },
    //点击外部的遮罩层是否允许关闭
    outClickCanClose: {
      type: Boolean,
      value: true
    },
  },

  /**
   * 组件的初始数据
   */
  data: {
    top:0,
    inputHeight:0,
    winHeight:0,
    inputVal:''
  },

  /**
   * 组件的方法列表
   */
  methods: {
    bindfocus(e){
      let top = e.detail.height;
      // this.setData({top:top})
      console.log('this.data.winHeight - top',this.data.winHeight - top,this.data.inputHeight,top,e)
      setTimeout(()=>{
        // console.log('this.data.winHeight - top',this.data.winHeight - top,top)
        if(this.data.landscape){
          if(this.data.inputHeight==0){
            this.setData({top:this.data.winHeight  - top})
          }else{
            this.setData({top:this.data.winHeight - this.data.inputHeight - top })
          }
          
        }else{
          this.setData({top:this.data.winHeight - this.data.inputHeight - top})
        }
        console.log('top====',this.data.top)
      },10)
    },
     //关闭alert
     closePopup() {
      console.log(this.data.visible,9999)
      this.triggerEvent("close", {
          visible: !this.data.visible
      })
    },
    empty(){},
     //点击外部的遮罩层关闭动作
    outClick() {
      if (this.data.outClickCanClose == true) {
        this.setData({inputVal:''})
        this.closePopup()
      }
    },
    bindinput(e){
      console.log(e)
      this.setData({inputVal:e.detail.value})
    },
    // 发送信息
    sendMsg(){
      let val = this.data.inputVal;
      // 发送数据 完成通知 
      console.log(val)
      this.setData({
        inputVal:''
      })
      this.triggerEvent('sendMsgSuccess',val)
      this.closePopup()
    }
  },
  ready(){
    let that = this;
    console.log(this.data.landscape,'landscape')
    wx.getSystemInfo({ 
      success: function (res) {
        // 设备的高度
        let winHeight = res.windowHeight;
        that.setData({
          winHeight:winHeight
        })
       setTimeout(()=>{
        console.log('winHeight',winHeight)
        wx.createSelectorQuery().select('#inputBox').boundingClientRect(function (rect) {
          console.log('rect',rect)//{id:...}
          let h = rect?rect.height:50;
          that.setData({inputHeight:h})
          console.log('inputHeight==',that.data.inputHeight)
        }).exec()
       },10)
      }
    })
  
  },
})
