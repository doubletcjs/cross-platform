// pages/tabList.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
   scrollHeight:{ // scroll-view 的高度
     type:Number,
     value:0
   }
  },

  /**
   * 组件的初始数据
   */
  data: {
    scrollTop:0,
    anchorLists:[
      {
        type:'F0',
        nicname:'Sam'
      },
      {
        type:'F1',
        nicname:'Michelle'
      },
      {
        type:'F2',
        nicname:'Susie'
      },
      {
        type:'F3',
        nicname:'Sam'
      },
      {
        type:'S1',
        nicname:'Sam'
      },
      {
        type:'S2',
        nicname:'Sam'
      },
      {
        type:'S3',
        nicname:'Sam'
      },
      {
        type:'F0',
        nicname:'Sam'
      },
      {
        type:'F0',
        nicname:'Sam'
      },
      {
        type:'F0',
        nicname:'Sam'
      },
      {
        type:'S2',
        nicname:'Sam'
      },
      {
        type:'S3',
        nicname:'Sam'
      },
      {
        type:'F0',
        nicname:'Sam'
      },
      {
        type:'F0',
        nicname:'Sam'
      },
      {
        type:'F0',
        nicname:'Sam'
      }
    ]
  },
  // 组件的生命周期
  attached(){ // 在组件实例进入页面节点树时执行
   
  },
  /**
   * 组件的方法列表
   */
  methods: {
   //滚动事件
    scroll(e){
      console.log(e.detail.scrollTop,this.properties.scrollHeight)
      // 判断是否滚动到底
      if(e.detail.scrollTop - this.properties.scrollHeight > 0){
        this.getData()
      }
    },
    scrollToTop() {
      this.setAction({
        scrollTop: 0
      })
    },
    getData(){
      console.log('加载更多获取数据')
    }
  }
})
