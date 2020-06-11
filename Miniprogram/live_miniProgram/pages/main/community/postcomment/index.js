//Page Object
Page({
  data: {
    selectImages: [
      "/icons/ico_add@3x.png"
    ],
    fuctionItems: [
      "/icons/ico_release_voice@3x.png",
      "/icons/ico_release_photo@3x.png",
      "/icons/ico_release_expression@3x.png"
    ],
    maxImageCount: 9,
    inputContent: "",
    submitDisable: true,
    actionvisible: false,
    draftItems: ["保存草稿", "不保存"],
    topics: []
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
  //处理图片点击
  handleImages: function (index) {
    if (this.data.selectImages[index] == "/icons/ico_add@3x.png") {
      wx.chooseImage({
        count: this.data.maxImageCount - (this.data.selectImages.length - 1),
        sizeType: ['original', 'compressed'],
        sourceType: ['album', 'camera'],
        success: (result) => {
          var tempFilePaths = result.tempFilePaths
          this.data.selectImages.pop()
          this.setData({
            selectImages: this.data.selectImages.concat(tempFilePaths)
          });
          console.log("selectImages:" + JSON.stringify(this.data.selectImages))

          if (this.data.selectImages.length < this.data.maxImageCount) {
            var tempSelectImages = this.data.selectImages
            tempSelectImages.push("/icons/ico_add@3x.png")
            this.setData({
              selectImages: tempSelectImages
            });
          }

          this.checkInputStatus()
        },
        fail: (res) => {

        },
        complete: () => {}
      });
    } else {
      wx.showActionSheet({
        itemList: ["删除"],
        itemColor: "#FF0000",
        success: (result) => {
          var tempSelectImages = this.data.selectImages
          tempSelectImages.splice(index, 1)

          this.setData({
            selectImages: tempSelectImages
          });

          this.checkInputStatus()
        },
        fail: () => {},
        complete: () => {}
      });
    }
  },
  //图片删除
  selectImageAction: function (res) {
    var index = res.currentTarget.dataset.index
    this.handleImages(index)
  },
  //图片、添加图片按钮点击
  functionItemAction: function (res) {
    var index = res.currentTarget.dataset.index
    if (index == 1) {
      var imageIndex = this.data.selectImages.length - 1
      if (this.data.selectImages[imageIndex] == "/icons/ico_add@3x.png") {
        this.handleImages(imageIndex)
      } else {
        wx.showToast({
          title: '无法选择更多图片',
          icon: 'none',
          image: '',
          duration: 1500,
          mask: false,
          success: (result) => {

          },
          fail: () => {},
          complete: () => {}
        });
      }
    } else if (index == 3) {
      wx.navigateTo({
        url: '/pages/main/community/topicmanage/index',
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
    }
  },
  //输入内容变化
  contentInputChagne: function (res) {
    this.setData({
      inputContent: res.detail.value
    })

    this.checkInputStatus()
  },
  //输入状态，是否可发布
  checkInputStatus: function () {
    if (this.data.inputContent.length > 0 && this.data.selectImages.length > 1) {
      this.setData({
        submitDisable: false
      })
    } else {
      this.setData({
        submitDisable: true
      })
    }
  },
  //弹框
  actionsheet: function () {
    if (this.data.inputContent.length > 0 && this.data.selectImages.length > 1) {
      this.setData({
        actionvisible: !this.data.actionvisible
      })
    }
  },
  closeClick: function () {
    this.setData({
      actionvisible: false
    })
  },
  //草稿
  itemSelect: function (res) {
    var index = res.detail.index
    console.log('object :>> ', index)
  },
  draftAction: function () {
    this.setData({
      actionvisible: true
    })
  }
});