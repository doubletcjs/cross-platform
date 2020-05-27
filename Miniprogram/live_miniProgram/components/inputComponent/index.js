// components/inputComponent/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
     //是否弹出显示
     visible: {
      type: Boolean,
      value: false
    },
    //点击外部的遮罩层是否允许关闭
    outClickCanClose: {
        type: Boolean,
        value: true
    },
    // 是否横屏
    landscape:{
      type:Boolean,
      value:false
    }
  },

  /**
   * 组件的初始数据
   */
  data: {
    inputVal:'',
    top:0,
    winHeight:0,
    inputHeight:0
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
        console.log('winHeight',winHeight)
        if(that.data.landscape){ //横屏
          const query = wx.createSelectorQuery()
          query.selectAll('#inputBox').boundingClientRect()
          query.selectViewport().scrollOffset()
          query.exec(function(result){
           console.log('result',result)
           try{
            if(result[0][0]){
              let height = result[0][0].height;
              that.setData({inputHeight:height})
             }
           }catch(e){
              throw new Error(e)
           }
           
            console.log(result)
            
          })
        }else{
          const query = wx.createSelectorQuery()
          query.selectAll('#inputBox').boundingClientRect()
          query.selectViewport().scrollOffset()
          query.exec(function(result){
           console.log('result',result)
            let height = result[0][0].height;
            console.log(height)
            that.setData({inputHeight:height})
          })
        }

      }
    })
  
  },
  /**
   * 组件的方法列表
   */
  methods: {
    //关闭alert
    closePopup() {
      console.log(this.data.visible,9999)
      this.triggerEvent("close", {
          visible: !this.data.visible
      })
    },
     //点击外部的遮罩层关闭动作
    outClick() {
      if (this.data.outClickCanClose == true) {
          this.closePopup()
      }
    },
    emptyAction(){},
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
          this.setData({top:this.data.winHeight - this.data.inputHeight - top + 3.5})
        }
        

      },0)
    },
    inputChange(e){
      // return e.detail.value;
      console.log(e,888)
      this.setData({
        inputVal:e.detail.value
      })
    },
    bindblur(){
      this.closePopup()
    },
    bindkeyboardheightchange(e){
      console.log('bindkeyboardheightchange')
    },
    // 发送信息
    sendMsg(){
      let val = this.data.inputVal;
      // 发送数据 完成通知 评论组件更新评论内容
      console.log(val)
      this.setData({
        inputVal:''
      })
      this.triggerEvent('sendMsgSuccess',val)
    }
  }
})
