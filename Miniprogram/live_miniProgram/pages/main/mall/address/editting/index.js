//Page Object
Page({
  data: {
    address: {
      name: "",
      phone: "",
      province: "",
      city: "",
      area: "",
      address: "",
      label: "",
      default: false
    },
    labelList: [
      "家",
      "公司",
      "学校",
      "其他",
    ]
  },
  //options(Object)
  onLoad: function (options) {
    if (options["address"] != null) {
      var editAddress = JSON.parse(options["address"])
      this.setData({
        address: editAddress
      })
      wx.setNavigationBarTitle({
        title: '编辑收货地址',
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
    }
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
  //地区选择
  regionChanged(res) {
    var value = res.detail.value
    var address = this.data.address
    address.province = value[0]
    address.city = value[1]
    address.area = value[2]
    this.setData({
      address: address
    })
  },
  //地址输入
  addressInput(res) {
    var value = res.detail.value
    var address = this.data.address
    address.address = value
    this.setData({
      address: address
    })
  },
  //标签选择
  labelSelect(res) {
    var index = res.currentTarget.dataset.index
    var address = this.data.address
    address.label = this.data.labelList[index]
    this.setData({
      address: address
    })
  },
  //电话输入
  phoneInput(res) {
    var value = res.detail.value
    var address = this.data.address
    address.phone = value
    this.setData({
      address: address
    })
  },
  //输入姓名
  nameInput(res) {
    var value = res.detail.value
    var address = this.data.address
    address.name = value
    this.setData({
      address: address
    })
  },
  //默认地址
  defaultAddressSwitch() {
    var address = this.data.address
    address.default = !address.default
    this.setData({
      address: address
    })
  },
  //保存
  onConfirm() {
    var address = this.data.address
    var msg = ""
    if (address.name.length < 1) {
      msg = "请输入收货人姓名！"
    } else if (address.phone.length < 11) {
      msg = "请输入收货人手机号！"
    } else if (address.province.length < 1 || address.city.length < 1 || address.area.length < 1) {
      msg = "请输入收货地区！"
    } else if (address.name.length < 1) {
      msg = "请输入收货详细地址！"
    }

    if (msg.length > 0) {
      wx.showToast({
        title: msg,
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
    } else {
      let pages = getCurrentPages();
      let currentPage = pages[pages.length - 2];
      currentPage.setData({
        edittingAddress: this.data.address
      })

      wx.navigateBack({
        delta: 1
      });
    }
  }
});