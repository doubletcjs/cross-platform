//Page Object
Page({
  data: {
    dataList: [{
        date: "今天",
        products: [{
            title: "手机黄金搭档,PD快充折叠支架无线充电宝",
            price: 139,
            inventory: 100,
            selected: false,
          },
          {
            title: "mini复古唱片机，随身便携蓝牙音箱",
            price: 149,
            inventory: 100,
            selected: false,
          }
        ]
      },
      {
        date: "6月09日",
        products: [{
            title: "驱蚊器+小夜灯2合1驱蚊高手居家必备",
            price: 38,
            inventory: 0,
            selected: false,
          },
          {
            title: "mini复古唱片机，随身便携蓝牙音箱",
            price: 139,
            inventory: 100,
            selected: false,
          }
        ]
      },
      {
        date: "6月08日",
        products: [{
            title: "手机黄金搭档,PD快充折叠支架无线充电宝",
            price: 139,
            inventory: 100,
            selected: false,
          },
          {
            title: "mini复古唱片机，随身便携蓝牙音箱",
            price: 149,
            inventory: 100,
            selected: false,
          },
          {
            title: "mini复古唱片机，随身便携蓝牙音箱",
            price: 139,
            inventory: 100,
            selected: false,
          }
        ]
      },
      {
        date: "6月01日",
        products: [{
            title: "手机黄金搭档,PD快充折叠支架无线充电宝",
            price: 139,
            inventory: 100,
            selected: false,
          },
          {
            title: "mini复古唱片机，随身便携蓝牙音箱",
            price: 149,
            inventory: 100,
            selected: false,
          },
          {
            title: "mini复古唱片机，随身便携蓝牙音箱",
            price: 139,
            inventory: 100,
            selected: false,
          },
          {
            title: "驱蚊器+小夜灯2合1驱蚊高手居家必备",
            price: 38,
            inventory: 100,
            selected: false,
          },
        ]
      },
    ],
    actionvisible: false, //弹框状态
    edittinghistory: false, //编辑状态
    selectedAll: false, //是否全选
    alertcontent: "确定清空浏览记录？", //弹框内容
    selectedDelete: false, //选择删除
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
  //编辑记录
  editHistory: function () {
    if (this.data.dataList.length > 0) {
      this.setData({
        edittinghistory: !this.data.edittinghistory
      })

      this.checktSelectAll()

      if (this.data.edittinghistory == false) {
        setTimeout(() => {
          var list = this.data.dataList
          for (let index = 0; index < list.length; index++) {
            const element = list[index]
            var products = element["products"]
            products.forEach(product => {
              product["selected"] = false
            });
            element["products"] = products
            list[index] = element
          }

          this.setData({
            dataList: list
          })
        }, 300);
      }
    }
  },
  //删除所选记录
  deleteSelectHistory: function () {
    if (this.checktIsSelect()) {
      this.setData({
        alertcontent: "删除所选浏览记录？"
      })

      this.setData({
        actionvisible: true,
        selectedDelete: true
      })
    }
  },
  //清空记录
  emptyHistory: function () {
    if (this.data.dataList.length > 0) {
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

    setTimeout(() => {
      this.setData({
        alertcontent: "确定清空浏览记录？",
      })
    }, 600);
  },
  //弹框确认
  alertConfirm: function () {
    if (this.data.selectedDelete) {
      if (this.data.selectedAll) {
        this.setData({
          actionvisible: false,
          dataList: [],
          edittinghistory: false,
          selectedDelete: false
        })
      } else {
        var list = this.data.dataList
        for (let index = 0; index < list.length; index++) {
          const element = list[index]
          var products = element["products"]
          for (let i = 0; i < products.length; i++) {
            const product = products[i]
            if (product["selected"] == true) {
              products.splice(i, 1)
            }
          }
          element["products"] = products
          list[index] = element
        }

        this.setData({
          dataList: list
        })

        if (this.data.dataList.length == 0) {
          setTimeout(() => {
            this.setData({
              actionvisible: false,
              selectedDelete: false,
              edittinghistory: false
            })
          }, 300);
        }
      }
    } else {
      this.setData({
        actionvisible: false,
        dataList: [],
        edittinghistory: false
      })
    }
  },
  //全选
  selectAllAction: function () {
    this.setData({
      selectedAll: !this.data.selectedAll
    })

    var list = this.data.dataList
    for (let index = 0; index < list.length; index++) {
      const element = list[index]
      var products = element["products"]
      products.forEach(product => {
        product["selected"] = this.data.selectedAll
      });
      element["products"] = products
      list[index] = element
    }

    this.setData({
      dataList: list
    })
  },
  //检测是否选择
  checktIsSelect: function () {
    var isSelect = false
    var list = this.data.dataList
    for (let index = 0; index < list.length; index++) {
      const element = list[index]
      var products = element["products"]
      for (let i = 0; i < products.length; i++) {
        const product = products[i]
        if (product["selected"] == true && isSelect == false) {
          isSelect = true
          break
        }
      }
    }

    return isSelect
  },
  //检测是否全选
  checktSelectAll: function () {
    var isAll = true
    var list = this.data.dataList
    for (let index = 0; index < list.length; index++) {
      const element = list[index]
      var products = element["products"]
      for (let i = 0; i < products.length; i++) {
        const product = products[i]
        if (product["selected"] == false && isAll == true) {
          isAll = false
          break
        }
      }
    }

    this.setData({
      selectedAll: isAll
    })
  },
  //单个点击
  singleSelectAction: function (res) {
    var dataset = res.currentTarget.dataset
    var section = dataset.section
    var index = dataset.index
    var list = this.data.dataList
    var products = list[section]["products"]
    var product = products[index]
    product["selected"] = !product["selected"]
    products[index] = product
    list[section]["products"] = products

    this.setData({
      dataList: list
    })

    this.checktSelectAll()
  },
});