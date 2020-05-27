Page({
  /**
   * 页面的初始数据
   */
  data: {
    isLive: false, // 是否直播中
    isFollow: false, // true 
    isSub: -1, // 是否订阅 -1 初始状态; 0 未订阅；1 订阅成功,
    shareIsShow: false,
    // 轮播图数组
    swiperList: [{ id: 0, url: "/icons/person.png" }, { id: 1, url: "/icons/icon_chat_shopping@3x.png" }, { id: 1, url: "/icons/icon_gift_heart@3x.png" }],
    // 往期视频
    historyLiveList: [{ id: 0, url: "/icons/person.png" }, { id: 1, url: "/icons/icon_chat_shopping@3x.png" }, { id: 2, url: "/icons/icon_gift_heart@3x.png" }, { id: 3, url: "/icons/icon_chat_shopping@3x.png" }, { id: 0, url: "/icons/icon_gift_heart@3x.png" }, { id: 4, url: "/icons/icon_chat_shopping@3x.png" }],
  },


  // 方法
  // 跳去活动
  toActivity(e) {
    const id = e.currentTarget.dataset.id 
    const name = e.currentTarget.dataset.name
    const url = "/pages/activity/index?id=" + id + "&name=" + name
     
    console.log("id = " +id);
    
    wx.navigateTo({
      url: url, 
    })
  },

  subHandle() {
    
    console.log("subHandle ----");
    
    let show = this.data.isSub
    if(show == -1) {
      this.setData({
        isSub: 1,
        isFollow: true
      })
    } else if(show == 0) {
      this.setData({
        isSub: 1,
        isFollow: true
      })
    } else if(show == 1) {
      this.setData({
        isSub: 0,
        isFollow: false
      })
    }

  },

  // 订阅成功分享
  toShare() {
    
    console.log("toShare " + this.data.isSub);
    this.setData({
      isSub: -1,
      isFollow: true,
      shareIsShow: true
    })
    
  },

   // 订阅成功确定
  toSubOK() {
    this.setData({
      isSub: -1,
      isFollow: false
    })

  },

  // 取消分享取消操作
  subCancel_N() {
    this.setData({
      isSub: -1,
      isFollow: false
    })
  },

  // 确定取消分享
  subCancel_Y() {
    this.setData({
      isSub: -1,
      isFollow: false
    })
  },

  
  share() {
    console.log("share " + this.data.shareIsShow);
    this.setData({
      shareIsShow: !this.data.shareIsShow
    })
  },

  closeClick() {
    console.log("closeClick " + this.data.shareIsShow);
    this.setData({
      shareIsShow: !this.data.shareIsShow
    })
  },
 
})


