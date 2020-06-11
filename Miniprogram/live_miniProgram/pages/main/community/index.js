//Page Object
Page({
  data: {
    inputValue:'', // 搜索输入值
    publishvisible:false, // 发布弹框显示控制
    news:6, // 消息
    lists:[ // 7 x24 小时的内容
      {
        time:'14:00',
        shareNumber:3,
        remarkNumber:1,
        content:'Filecoin官方：二阶段测试网开始时间：5月11日左 右,主网启动时间：7月20日-8月21日'
      },
      {
        time:'12:00',
        shareNumber:0,
        remarkNumber:1,
        content:'Filecoin官方：IPFS是依据内容从而来产生地址，它 提供了高吞吐量的内容寻址存储模型通过默克尔树数 据结构来构建版本文件系统'
      },
      {
        time:'10:00',
        shareNumber:0,
        remarkNumber:0,
        content:'Filecoin官方：IPFS是依据内容从而来产生地址，它 提供了高吞吐量的内容寻址存储模型通过默克尔树数 据结构来构建版本文件系统'
      },
      {
        time:'09:00',
        shareNumber:6,
        remarkNumber:0,
        content:'Filecoin官方：二阶段测试网开始时间：5月11日左 右,主网启动时间：7月20日-8月21日'
      }
    ],
    articleLists:[ // 文章列表 (type ==0 文章 type==1 话题  type==2 评论)
      {
        author:'华科闪云',
        type:'0', // 文章
        isTransmit:false, // 是否是转发的
        time:'5月22 14:00',
        authorImg:'',
        imgs:['/icons/19.png','/icons/19.png','/icons/19.png','/icons/19.png'],
        attention:false,
        transmit:'@华科闪云',
        comment:'', // 无评论内容
        transmitNum:44,
        giveNum:23,
        commentNum:64,
        articleContents:'4月20日，国家发改委召开例行在线新闻发布会，正式 明确区块国家发改委召开例行在线新闻发布会，正式 明确区块链作为新链作为新技术基础设施被纳入“新基建”范围…',
        articleTiltle:'2020年IPFS将是最稳投资！助力新基建投 资超389亿'
      },
      {
        author:'蒋国宇文章',
        type:'0',
        isTransmit:true, 
        time:'5月22 14:00',
        authorImg:'',
        transmitNum:44,
        giveNum:23,
        commentNum:64,
        imgs:['/icons/19.png'],
        attention:true,
        transmit:'@华科闪云',
        comment:'太精彩了!!!',
        articleContents:'4月20日，国家发改委召开例行在线新闻发布会，正式 明确区块国家发改委召开例行在线新闻发布会，正式 明确区块链作为新链作为新技术基础设施被纳入“新基建”范围…',
        articleTiltle:'2020年IPFS将是最稳投资！助力新基建投 资超389亿'
      },
      {
        author:'蒋国宇话题',
        type:'1',
        time:'5月22 14:00',
        authorImg:'',
        imgs:[],
        attention:false,
        transmitNum:44,
        giveNum:23,
        commentNum:64,
        topic:'#filecoin#',
        transmit:'@Matt',
        comment:'太精彩了!!!',
        articleContents:'',
        articleTiltle:'2020年IPFS将是最稳投资！助力新基建投 资超389亿'
      },
      {
        author:'蒋国宇话题',
        type:'1',
        isTransmit:true,
        time:'5月22 14:00',
        authorImg:'',
        imgs:[],
        attention:false,
        transmitNum:44,
        giveNum:23,
        commentNum:64,
        topic:'#filecoin#', // 话题
        transmit:'@蒋国宇', // 转发的谁
        comment:'我也是 // @蒋国宇: 我页知道',
        articleContents:'让我们讨论一下filecoin主网什么时��上线...?', // 内容
        articleTiltle:''  // 标题
      },
      {
        author:'蒋国宇评论',
        type:'2',
        isTransmit:true,
        time:'5月22 14:00',
        authorImg:'',
        imgs:['/icons/19.png'],
        attention:false,
        transmitNum:44,
        giveNum:23,
        commentNum:64,
        topic:'',
        transmit:'@蒋国宇',
        comment:'太精彩了!!!',
        articleContents:'2020年IPFS将是最稳投资！助力新基建投 资超389亿',
        articleTiltle:''
      },
      {
        author:'蒋国宇评论',
        type:'2',
        isTransmit:false,
        time:'5月22 14:00',
        authorImg:'',
        imgs:['/icons/19.png','/icons/19.png'],
        attention:false,
        transmitNum:44,
        giveNum:23,
        commentNum:64,
        topic:'',
        transmit:'',
        comment:"",
        articleContents:'2020年IPFS将是最稳投资！助力新基建投 资超389亿',
        articleTiltle:''
      },
    ],
    articleLists2:[ // 社区的数据 （除了长文章的所有数据）
      {
        author:'蒋国宇',
        type:'0',
        isTransmit:true, 
        time:'5月22 14:00',
        authorImg:'',
        transmitNum:44,
        giveNum:23,
        commentNum:64,
        imgs:['/icons/19.png'],
        attention:true,
        transmit:'@华科闪云',
        comment:'太精彩了!!!',
        articleContents:'4月20日，国家发改委召开例行在线新闻发布会，正式 明确区块国家发改委召开例行在线新闻发布会，正式 明确区块链作为新链作为新技术基础设施被纳入“新基建”范围…',
        articleTiltle:'2020年IPFS将是最稳投资！助力新基建投 资超389亿'
      },
      {
        author:'蒋国宇',
        type:'1',
        time:'5月22 14:00',
        authorImg:'',
        imgs:[],
        attention:false,
        transmitNum:44,
        giveNum:23,
        commentNum:64,
        topic:'#filecoin#',
        transmit:'@Matt',
        comment:'太精彩了!!!',
        articleContents:'',
        articleTiltle:'2020年IPFS将是最稳投资！助力新基建投 资超389亿'
      },
      {
        author:'蒋国宇',
        type:'1',
        isTransmit:true,
        time:'5月22 14:00',
        authorImg:'',
        imgs:[],
        attention:false,
        transmitNum:44,
        giveNum:23,
        commentNum:64,
        topic:'#filecoin#', // 话题
        transmit:'@蒋国宇', // 转发的谁
        comment:'我也是 // @蒋国宇: 我页知道',
        articleContents:'让我们讨论一下filecoin主网什么时��上线...?', // 内容
        articleTiltle:''  // 标题
      },
      {
        author:'蒋国宇',
        type:'2',
        isTransmit:true,
        time:'5月22 14:00',
        authorImg:'',
        imgs:['/icons/19.png'],
        attention:false,
        transmitNum:44,
        giveNum:23,
        commentNum:64,
        topic:'',
        transmit:'@蒋国宇',
        comment:'太精彩了!!!',
        articleContents:'2020年IPFS将是最稳投资！助力新基建投 资超389亿',
        articleTiltle:''
      },
      {
        author:'蒋国宇',
        type:'2',
        isTransmit:false,
        time:'5月22 14:00',
        authorImg:'',
        imgs:['/icons/19.png','/icons/19.png'],
        attention:false,
        transmitNum:44,
        giveNum:23,
        commentNum:64,
        topic:'',
        transmit:'',
        comment:"",
        articleContents:'2020年IPFS将是最稳投资！助力新基建投 资超389亿',
        articleTiltle:''
      }
    ],
    currentTab:0, // tab 下标
    tablists:['最新','热门','7X24小时','社区'],
    feed_style:{ // 定位的变量
      x:"",
      y:""
    },
    screen:{ // // 用于保存屏幕页面信息
      width:'',
      height:''
    },
    preX:'', //上次的x值
    preY:'' //上次的y值
  },
  // 去个人中心
  my(){
    wx.navigateTo({
      url: '/pages/personal/index',
      success: (result)=>{
        
      },
      fail: ()=>{},
      complete: ()=>{}
    });
  },
  // 发布
  add(){
    this.setData({publishvisible:true})
  },
  touchMoveChange(e){
    var tmpx = parseInt(e.touches[0].clientX);
    var tmpy = parseInt(e.touches[0].clientY);
    
    if (tmpx <= 0 || tmpy <= 0 || tmpx >= this.data.screen.width || tmpy >= this.data.screen.height ){

    }else{
      if(tmpx != this.data.preX || tmpy != this.data.preY ){
        console.log(e.touches[0].clientX, "-X-", e.touches[0].pageX)

        console.log(e.touches[0].clientY, "-Y-", e.touches[0].pageY)

        this.data.preX = tmpx;
        this.data.preY = tmpy;

        this.setData({
          feed_style: {
            x: tmpx - 50 + "px",
            y: tmpy - 50 + "px",
          }
        })
      }
    }

    console.log(tmpx,tmpy)
    
  },
  // 关闭发布弹框
  publishclose(){
    console.log(1111)
    this.setData({publishvisible:false})
  },

  // 去查看新消息
  lookMsg(){
    wx.navigateTo({
      url: '/pages/main/community/messagecenter/index',
    })
  },
  // 搜索
  search(e){
    let search = e.detail;
    console.log('search',search)
  },
  // 去搜索页
  goSearch(){
    wx.navigateTo({
      url: '/pages/main/community/searchcenter/index',
      success: function(res) {
        
      }
    })
  },
  // tab切换
  changeTabhandle(e){
    let index = e.detail;
    this.setData({currentTab:index})
  },
  
  // 关注某篇文章
  attentionChange(e){
    // 更新文章状态
    let articleLists = this.data.articleLists;
    let index = e.detail.index;
    let attention = e.detail.attention;
    articleLists[index].attention = attention;
    this.setData({articleLists:articleLists})
    // console.log(e)
  },
  // 点赞成功回调，重新渲染
  giveNumChange(e){
    console.log("资讯首页" + e)
    let index = e.detail.index;
    let giveNum = e.detail.giveNum;
    let articleLists = this.data.articleLists;
    articleLists[index].giveNum = giveNum;
    this.setData({articleLists:articleLists})
  },
  //options(Object)
  onLoad: function (options) {
    
  },
  onReady: function () {
    let that = this;
    wx.getSystemInfo({
      success:function(res){
        console.log(res)
        if(res.platform == "android"){
          res.windowHeight = res.screenHeight;
        }
        that.setData({
          screen:{
            width: res.windowWidth,
            height: res.windowHeight ,
            pixelRatio: res.pixelRatio,
            ratio: res.windowWidth * res.pixelRatio/750
          }
        })
      }
    })
  },
  onShow: function () {

  },
  onHide: function () {

  },
  onUnload: function () {

  },
  onPullDownRefresh: function () {

  },
  onReachBottom: function () {

  },
  onShareAppMessage: function () {

  },
  onPageScroll: function () {

  },
  //item(index,pagePath,text)
  onTabItemTap: function (item) {

  }
});