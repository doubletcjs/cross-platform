//Page Object
Page({
  data: {
    products: [{
        title: "手机黄金搭档,PD快充折叠支架无线充电宝",
        price: 139,
        selected: false,
        count: 10234,
      },
      {
        title: "驱蚊器+小夜灯2合1驱蚊高手居家必备",
        price: 38,
        selected: false,
        count: 234,
      },
      {
        title: "手机黄金搭档,PD快充折叠支架无线充电宝",
        price: 149,
        selected: false,
        count: 11234,
      },
    ],
    actionvisible: false, //弹框状态
    edittingcollection: false, //编辑状态
    selectedAll: false, //是否全选
    alertcontent: "确定清空浏览记录？", //弹框内容 
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
  //编辑收藏
  editCollection: function () {
    if (this.data.products.length > 0) {
      this.setData({
        edittingcollection: !this.data.edittingcollection
      })

      this.checktSelectAll()
      if (this.data.edittingcollection == false) {
        setTimeout(() => {
          var list = this.data.products
          for (let index = 0; index < list.length; index++) {
            const element = list[index]
            element["selected"] = false
            list[index] = element
          }

          this.setData({
            products: list
          })

          console.log('object :>> ', "selected");
        }, 300);
      }
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
  },
  //删除所选记录
  deleteSelectCollection: function () {
    if (this.checktIsSelect()) {
      this.setData({
        actionvisible: true
      })
    }
  },
  //关闭弹框
  closeClick: function () {
    this.setData({
      actionvisible: false
    })
  },
  //弹框确认
  alertConfirm: function () {
    if (this.data.selectedAll) {
      this.setData({
        actionvisible: false,
        products: [],
        edittingcollection: false,
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
            edittingcollection: false,
          })
        }, 300);
      }
    }
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
});