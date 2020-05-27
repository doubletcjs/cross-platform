// pages/tabList.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    scrollHeight:{
      type:Number,
      value:0
    }
  },

  /**
   * 组件的初始数据
   */
  data: {
    tab:['日贡献榜','周贡献榜'],
    tabIndex:0,
    nowData:null,
    dateLists:[
      {
        type:'F0',
        nicname:'9点',
        contribution:123000
      },
      {
        type:'F1',
        nicname:'2点',
        contribution:3600
      },
      {
        type:'F2',
        nicname:'3点',
        contribution:8500
      },{
        type:'F3',
        nicname:'空中漫步者点',
        contribution:4500
      },{
        type:'S1',
        nicname:'空中漫步者点9点',
        contribution:2300000
      },{
        type:'S2',
        nicname:'空中漫步者点9点',
        contribution:640000
      },{
        type:'S3',
        nicname:'空中漫步者点9点',
        contribution:3500
      },{
        type:'F0',
        nicname:'9点',
        contribution:12300
      }
    ],
    weekLists:[
      {
        type:'F0',
        nicname:'空中漫步者点9点',
        contribution:1230000
      },
      {
        type:'F1',
        nicname:'9空中漫步者点点',
        contribution:36000
      },
      {
        type:'F2',
        nicname:'空中漫步者点9点',
        contribution:8500666
      },{
        type:'F3',
        nicname:'空中漫步者点9点',
        contribution:450000
      },{
        type:'S1',
        nicname:'9点',
        contribution:2300
      },{
        type:'S2',
        nicname:'空中漫步者点9点',
        contribution:640000
      },{
        type:'S3',
        nicname:'空中漫步者点9点',
        contribution:3500555
      },{
        type:'F0',
        nicname:'9点',
        contribution:12300
      }
    ]
  },
  // 生命周期
  attached: function() { // 在组件实例进入页面节点树时执行
    // 发送请求获取数据
    this.setData({
      nowData:this.data.dateLists
    })
  },
  /**
   * 组件的方法列表
   */
  methods: {
  //  点击切换tab 
    changeTab(e){
      let tabIndex = e.target.dataset.index;
      this.setData({
        tabIndex:tabIndex
      })
      if(this.data.tabIndex ==0){ // 日排行数据
        this.setData({
          nowData:this.data.dateLists
        })
        console.log(0)
      }else{ // 周排行数据
        this.setData({
          nowData:this.data.weekLists
        })
      }

    },
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
