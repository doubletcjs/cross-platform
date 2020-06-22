//Page Object
Page({
  data: {
    infoItemList: [{
        name: "头像",
        value: ""
      },
      {
        name: "用户名",
        value: "用户1234"
      },
      {
        name: "昵称",
        value: "用户1234"
      },
      {
        name: "简介",
        value: "这个人很懒，什么都没写"
      },
      {
        name: "性别",
        value: "女"
      },
      {
        name: "地区",
        value: "广东 广州"
      },
    ],
    genderactionvisible: false, //性别弹框
    genders: [
      "男",
      "女"
    ], //性别
    genderIndex: 0, // 当前性别
    inputUserName: "", // 接收输入用户名
    inputNickName: "", // 接收输入昵称
    inputIntroduction: "", // 接收输入简介
  },
  //options(Object)
  onLoad: function (options) {

  },
  onReady: function () {

  },
  onShow: function () {
    console.log("userName:" + this.data.inputUserName)
    console.log("nickName:" + this.data.inputNickName)
    console.log("introduction:" + this.data.inputIntroduction)
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
  //地区选择
  regionChange: function (res) {
    var value = res.detail.value
    console.log('value :>> ', value);
  },
  //列表点击
  cellItemSelect: function (res) {
    var index = res.currentTarget.dataset.index
    if (index == 4) {
      this.setData({
        genderactionvisible: true
      })
    } else if (index == 1 || index == 2 || index == 3) {
      wx.navigateTo({
        url: '/pages/main/profile/coinorder/index?type=' + (index - 1),
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
    }
  },
  //关闭弹框
  closeClick: function () {
    this.setData({
      genderactionvisible: false
    })
  },
  //性别选择
  genderItemSelect: function (res) {
    var gender = res.detail.index
    var list = this.data.infoItemList
    list[4]["value"] = this.data.genders[gender]

    this.setData({
      genderIndex: gender,
      infoItemList: list
    })
  },
});