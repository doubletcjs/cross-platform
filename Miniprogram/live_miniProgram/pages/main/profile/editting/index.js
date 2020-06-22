//Page Object
Page({
  data: {
    edittingType: 0, // 0 编辑用户名 1 编辑昵称 2 编辑简介 
    maxInputLength: 12, //最大长度
    currentInputLength: 0,
    inputContent: ""
  },
  //options(Object)
  onLoad: function (options) {
    var type = parseInt(options["type"])
    this.setData({
      edittingType: type,
      maxInputLength: type == 2 ? 30 : 12
    })
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
  //文本输入
  textInputChange: function (res) {
    var value = res.detail.value
    this.setData({
      currentInputLength: value.length,
      inputContent: value
    })
  },
  //保存输入
  confirmInput: function () {
    if (this.data.currentInputLength == 0) {
      wx.showToast({
        title: '输入内容不能为空',
        icon: 'none',
        image: '',
        duration: 1500,
        mask: false,
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
      return
    }

    let pages = getCurrentPages() //获取当前页面栈的信息
    let prevPage = pages[pages.length - 2] //获取上一个页面

    if (this.data.edittingType == 0) {
      prevPage.setData({ //把需要回传的值保存到上一个页面
        inputUserName: this.data.inputContent
      });
    } else if (this.data.edittingType == 1) {
      prevPage.setData({ //把需要回传的值保存到上一个页面
        inputNickName: this.data.inputContent
      });
    } else if (this.data.edittingType == 2) {
      prevPage.setData({ //把需要回传的值保存到上一个页面
        inputIntroduction: this.data.inputContent
      });
    }

    wx.navigateBack({ //然后返回上一个页面
      delta: 1
    })
  },
  //取消返回
  cancalBack: function () {
    wx.navigateBack({
      delta: 1
    });
  }
});