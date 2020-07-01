//Page Object
Page({
  data: {
    addressList: [{
        name: "蒋国宇",
        phone: "15217623847",
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际909不知道还有多长",
        label: "家",
        default: true
      },
      {
        name: "蒋国宇",
        phone: "15217623847",
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际7",
        label: "",
        default: false
      },
      {
        name: "蒋国宇",
        phone: "15217623847",
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际8",
        label: "",
        default: false
      }
    ],
    alertvisible: false,
    defaultalertvisible: false,
    selectindex: -1,
    edittingAddress: null
  },
  //options(Object)
  onLoad: function (options) {

  },
  onReady: function () {

  },
  onShow: function () {
    if (this.data.edittingAddress != null) {
      var edittingAddress = this.data.edittingAddress
      var list = this.data.addressList
      if (this.data.selectindex >= 0 && this.data.selectindex < this.data.addressList.length) {
        if (edittingAddress.default == true) {
          this.resetDefaultAddress();
        }

        list[this.data.selectindex] = edittingAddress
      } else {
        if (edittingAddress.default == true) {
          this.resetDefaultAddress();
        }

        list.push(edittingAddress)
      }

      this.setData({
        addressList: list,
        selectindex: -1,
        edittingAddress: null
      })

      this.exchangeDefaultAddress()
    }
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
  //前置默认地址
  exchangeDefaultAddress() {
    var index = this.data.selectindex
    var list = this.data.addressList
    var defaultAddress = null
    for (let i = 0; i < list.length; i++) {
      const element = list[i];
      if (element.default == true) {
        defaultAddress = element
        list.splice(i, 1)
        break
      }
    }

    list.splice(0, 0, defaultAddress)
    this.setData({
      addressList: list
    })
  },
  //重置默认地址
  resetDefaultAddress() {
    var index = this.data.selectindex
    var list = this.data.addressList
    for (let i = 0; i < list.length; i++) {
      const element = list[i];
      element.default = false
      list[i] = element
    }

    this.setData({
      addressList: list
    })
  },
  //设置默认地址
  defaultAddress: function (res) {
    var index = res.currentTarget.dataset.index
    var list = this.data.addressList
    if (list[index].default == true) {
      var address = list[index]
      address.default = false
      list[index] = address

      this.setData({
        addressList: list
      })
    } else {
      this.setData({
        defaultalertvisible: true,
        selectindex: index
      })
    }
  },
  confirmDefaultAddress() {
    var index = this.data.selectindex
    var list = this.data.addressList
    for (let i = 0; i < list.length; i++) {
      const element = list[i];
      if (i == index) {
        element.default = true
      } else {
        element.default = false
      }

      list[i] = element
    }

    this.setData({
      addressList: list
    })

    this.exchangeDefaultAddress()
  },
  //删除地址
  deleteAddressAlert(res) {
    var index = res.currentTarget.dataset.index
    this.setData({
      alertvisible: true,
      selectindex: index
    })
  },
  closeAddressAlert() {
    this.setData({
      alertvisible: false,
      defaultalertvisible: false
    })
  },
  confirmDeleteAddress() {
    var list = this.data.addressList
    if (this.data.selectindex >= 0 && this.data.selectindex < list.length) {
      list.splice(this.data.selectindex, 1)

      this.setData({
        addressList: list,
        selectindex: -1
      })
    }
  },
  //修改地址
  editAddress(res) {
    var index = res.currentTarget.dataset.index
    var address = this.data.addressList[index]

    wx.navigateTo({
      url: './editting/index?address=' + JSON.stringify(address),
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });

    this.setData({
      selectindex: index,
      edittingAddress: null
    })
  },
  //添加地址
  addAddress() {
    this.setData({
      edittingAddress: null
    })

    wx.navigateTo({
      url: './editting/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  },
});