// components/weekDetail/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    lists:{
      type:Array,
      value:[]
    }
  },

  /**
   * 组件的初始数据
   */
  data: {
    sharevisible:false,
  },

  /**
   * 组件的方法列表
   */
  methods: {
    // 去看详情评论 pages/main/community/newsDetail/index
    remark(){
      console.log('去评论')
      wx.navigateTo({
        url: '/pages/main/community/newsDetail/index',
        success: (result)=>{
          
        },
        fail: ()=>{},
        complete: ()=>{}
      });
    },
    // 分享
    share(){
      console.log('分享')
      this.setData({sharevisible:true})
    },
    shaoclose(){
      this.setData({sharevisible:false})
    }
  }
})
