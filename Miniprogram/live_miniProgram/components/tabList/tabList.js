// pages/tabList.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
   tablists:{ // tab 列表数据
    type: Array,
    value: []
   },
   currentTab:{ // tab 下标
     type:Number,
     value:0
   },
   attention:{ // 关注
     type:Boolean,
     value:false
   },
  //  是否显示关注按钮
   attentionShow:{
    type:Boolean,
    value:true
   },
  //  设置背景
   color:{
     type:String,
     value:''
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
    changeTab(e){ // tab 点击切换
      // let tabindex = e.taget.dataset.index;
      // 获取点击的index
      let tabIndex = e.target.dataset.index;
      this.triggerEvent('changeTab',tabIndex)
      // console.log(e.target.dataset,tabIndex)
    },
    attentionChange:function(){
      // 关注
      this.triggerEvent('attention',!this.properties.attention)
    }
  }
})
