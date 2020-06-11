// components/searchInput/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    width:{ // 输入框的宽度
      type:Number,
      value:596
    },
    placeholder:{ // placeholder信息
      type:String,
      value:'搜索标题作者'
    },
    inputValue:{ // 输入值
      type:String,
      value:''
    },
    focus:{
      type:Boolean,
      value:false
    }
  },

  /**
   * 组件的初始数据
   */
  data: {
    focus:false
  },

  /**
   * 组件的方法列表
   */
  methods: {
    bindfocus(e){
      this.setData({focus:true})
    },
    bindblur(){
      this.setData({focus:false})
    },
    bindinput(e){
      // console.log(e)
      this.setData({inputValue:e.detail.value})
    },
    // 搜索
    search(){
      this.triggerEvent('search',this.data.inputValue)
    }
  }
})
