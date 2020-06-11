// pages/main/community/writeArticle/goBack/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    // title 标题
    text:{
      type:String,
      value:'写文章'
    },
    // 是否可跳转
    isGo:{
      type:Boolean,
      value:true
    }
  },

  /**
   * 组件的初始数据
   */
  data: {
    
  },

  /**
   * 组件的方法列表
   */
  methods: {
    // 返回上一页
    goBack(){
      if(this.data.isGo){
        wx.navigateBack({
          delta: 1
        })
      }
    }
  }
})
