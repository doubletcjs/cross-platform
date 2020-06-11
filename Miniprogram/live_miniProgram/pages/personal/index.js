//Page Object
Page({
  data: {
    itemList: [{
        name: "收藏",
        icon: "/icons/ico_profile_item_0@3x.png"
      },
      {
        name: "点赞",
        icon: "/icons/ico_profile_item_1@3x.png"
      },
      {
        name: "历史",
        icon: "/icons/ico_profile_item_2@3x.png"
      },
      {
        name: "打赏",
        icon: "/icons/ico_profile_item_3@3x.png"
      }
    ],
    cellList: [{
        name: "消息",
        number: 10
      },
      {
        name: "草稿箱",
        number: 0
      }
    ],
    alertvisible: false
  },
  //options(Object)
  onLoad: function (options) {

  },
  onReady: function () {

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

  },
  //个人主页
  showHomePage: function () {
    wx.navigateTo({
      url: '/pages/personal/homepage/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //显示编辑个人信息
  personalInfoAlert: function () {
    this.setData({
      alertvisible: true
    })
  },
  //关闭编辑个人信息弹框
  closeAlertClick: function () {
    this.setData({
      alertvisible: false
    })
  },
  //编辑个人信息
  alertConfirm: function () {
    console.log("编辑个人信息")
  },
  //列表选择
  cellItemTap: function (res) {
    let index = res.currentTarget.dataset.index;
    if (index == 0) {
      this.showMessageCenter()
    } else if (index == 1) {
      this.showDraftsCenter()
    }
  },
  //消息中心
  showMessageCenter: function () {
    wx.navigateTo({
      url: '/pages/main/community/messagecenter/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //草稿
  showDraftsCenter: function () {
    wx.navigateTo({
      url: '/pages/main/community/drafts/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //我的关注
  showMyAttention: function () {
    wx.navigateTo({
      url: '/pages/personal/fanattention/index?type=1',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //我的粉丝
  showMyFan: function () {
    wx.navigateTo({
      url: '/pages/personal/fanattention/index?type=0',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
  //记录
  showRecord: function (res) {
    let index = res.currentTarget.dataset.index;
    wx.navigateTo({
      url: '/pages/personal/record/index?tab=' + index,
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
});