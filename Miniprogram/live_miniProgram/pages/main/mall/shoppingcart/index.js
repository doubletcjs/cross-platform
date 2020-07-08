//Page Object
Page({
  data: {
    products: [{
        title: "手机黄金搭档,PD快充折叠支架无线充电宝",
        price: 139,
        count: 1,
        selected: false,
        sepc: "松林绿"
      },
      {
        title: "扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...",
        price: 2299,
        count: 1,
        selected: false,
        sepc: "盐湖白，购买扫..."
      },
    ],
    editting: false,
    selectedAll: false, // 全选
    actionvisible: false, //弹框状态
    totalPrice: "0.00", //合计金额
    specvisible: false, //规格弹框状态
    selectProduct: {}
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
  //编辑购物车
  edittingAction() {
    this.setData({
      editting: !this.data.editting
    })
  },
  //选择规格
  selectSpec(res) {
    var index = res.currentTarget.dataset.index
    this.setData({
      selectProduct: this.data.products[index],
      specvisible: true
    })

    this.calculatePrice()
  },
  //加数量
  addCount(res) {
    var index = res.currentTarget.dataset.index
    var list = this.data.products
    var product = list[index]
    product.count += 1
    list[index] = product

    this.setData({
      products: list
    })

    this.calculatePrice()
  },
  //减数量
  minusCount(res) {
    var index = res.currentTarget.dataset.index
    var list = this.data.products
    var product = list[index]
    if (product.count > 1) {
      product.count -= 1
      if (product.count < 1) {
        product.count = 1
      }
      list[index] = product

      this.setData({
        products: list
      })

      this.calculatePrice()
    }
  },
  //单个点击
  singleSelectAction: function (res) {
    var index = res.currentTarget.dataset.index
    var list = this.data.products
    var product = list[index]
    product["selected"] = !product["selected"]
    list[index] = product

    this.setData({
      products: list
    })

    this.checktSelectAll()
    this.calculatePrice()
  },
  //检测是否选择
  checktIsSelect: function () {
    var isSelect = false
    var list = this.data.products
    for (let index = 0; index < list.length; index++) {
      const element = list[index]
      if (element["selected"] == true && isSelect == false) {
        isSelect = true
        break
      }
    }

    return isSelect
  },
  //检测是否全选
  checktSelectAll: function () {
    var isAll = true
    var list = this.data.products
    for (let index = 0; index < list.length; index++) {
      const element = list[index]
      if (element["selected"] == false && isAll == true) {
        isAll = false
        break
      }
    }

    this.setData({
      selectedAll: isAll
    })
  },
  //全选
  selectAllAction: function () {
    this.setData({
      selectedAll: !this.data.selectedAll
    })

    var list = this.data.products
    for (let index = 0; index < list.length; index++) {
      const element = list[index]
      element["selected"] = this.data.selectedAll
      list[index] = element
    }

    this.setData({
      products: list
    })

    this.calculatePrice()
  },
  //删除所选记录
  deleteSelect: function () {
    if (this.checktIsSelect()) {
      this.setData({
        actionvisible: true
      })
    }
  },
  //关闭弹框
  closeClick: function () {
    this.setData({
      actionvisible: false,
      specvisible: false
    })
  },
  //弹框确认
  alertConfirm: function () {
    if (this.data.selectedAll) {
      this.setData({
        actionvisible: false,
        products: [],
        editting: false,
        selectedAll: false
      })
    } else {
      var list = this.data.products
      for (let index = 0; index < list.length; index++) {
        const element = list[index]
        if (element["selected"] == true) {
          list.splice(index, 1)
        }
      }

      this.setData({
        products: list
      })

      if (this.data.products.length == 0) {
        setTimeout(() => {
          this.setData({
            actionvisible: false,
            products: [],
            editting: false,
            selectedAll: false
          })
        }, 300);
      }
    }
  },
  //计算价格
  calculatePrice() {
    var price = 0
    for (let index = 0; index < this.data.products.length; index++) {
      const element = this.data.products[index]
      if (element["selected"] == true) {
        price += element.price * element.count
      }
    }

    this.setData({
      totalPrice: price.toFixed(2)
    })
  },
  //结算
  settlement() {
    wx.navigateTo({
      url: '../order/detail/index',
      success: (result) => {

      },
      fail: () => {},
      complete: () => {}
    });
  }
});