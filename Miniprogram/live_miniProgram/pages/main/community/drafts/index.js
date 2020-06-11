// pages/main/community/drafts/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    isSelect:true, // 控制选择删除
    radioshow:false,
    visible:false,
    onlyToast:false, // 控制显示提示框按钮个数
    checkstatus:[], // 选择的数据下标数组
    contentString:'是否删除该帖子',
    datalist:[ // type 1 文章  2 评论 3 话题
      {
        id:10,
        type:1,
        time:'5月20日 14:03',
        title:'2020年IPFS将是最稳投资！助力新基建投资 超389亿',
        content:'4月20日，国家发改委召开例行在线新闻发正式明确 区块链作为新技术基础设施…'
      },
      {
        id:21,
        type:2,
        time:'5月20日 14:43',
        content:'这是一条讨论内容'
      },
      {
        id:22,
        type:3,
        time:'5月20日 14:43',
        content:'这是一条话题'
      }
    ]
  },
  // 选择
  select(){
    this.setData({isSelect:false,radioshow:true})
  },
  // 删除
  delect(){
    console.log('删除')

    // this.setData({isSelect:true,radioshow:false,visible:true})
    // 判断是否勾选帖子
    if(this.data.checkstatus.length == 0){
      this.setData({visible:true,contentString:'请选择删除的帖子',onlyToast:true})
      return false;
    }else{
      this.setData({visible:true,contentString:'是否删除该帖子',onlyToast:false})
      
    }

  },
  closeClick(e){
    this.setData({visible:false})
  },
  // 确定 删除操作
  confirm(){
    this.closeClick()
    this.setData({radioshow:false,isSelect:true})
    console.log(this.data.checkstatus)
    setTimeout(() => {
      wx.showToast({
        title: '删除成功',
        icon: 'none',
        image: '',
        duration: 1500,
        mask: false,
        success: (result)=>{
          
        },
        fail: ()=>{},
        complete: ()=>{}
      });
    }, 100);
  },
  // 取消
  cancel(){
    this.closeClick()
    this.setData({radioshow:false,isSelect:true})
  },
  // checkbox 状态改变的时候
  checkboxChange(e){
    let checkstatus = e.detail.value;
    this.setData({checkstatus:checkstatus})
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})