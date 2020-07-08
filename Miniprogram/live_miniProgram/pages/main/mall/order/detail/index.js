//Page Object
Page({
  data: {
    order: {
      status: 0 //0 待支付 1 待发货 2 待收货 3 交易成功 4 待支付 超时关闭 5 待发货 退款中 6 待发货 退款成功 订单关闭
    },
    orderItems: [
      "订单编号",
      "下单时间",
      "配送方式",
      "实付款",
      "支付方式",
    ],
    orderValues: [],
    bottomFunctions: []
  },
  //options(Object)
  onLoad: function (options) {

  },
  onReady: function () {
    this.bottomButtons();
  },
  onShow: function () {
    this.bottomButtons();
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
  //底部按钮
  bottomButtons() {
    if (this.data.order.status == 0) {
      this.setData({
        bottomFunctions: ["取消订单", "付款"]
      })
    } else if (this.data.order.status == 1) {
      this.setData({
        bottomFunctions: ["申请付款", "再次购买"]
      })
    } else if (this.data.order.status == 2 || this.data.order.status == 3) {
      this.setData({
        bottomFunctions: ["申请售后", "查看物流", "确认收货"]
      })
    } else if (this.data.order.status == 4) {
      this.setData({
        bottomFunctions: ["删除订单"]
      })
    }

    if (this.data.order.status < 5) {
      this.setData({
        orderItems: [
          "订单编号",
          "下单时间",
          "配送方式",
          "实付款",
          "支付方式",
        ],
        orderValues: [
          "1552626266599",
          "2020.05.06  16:22:45",
          "普通配送  快递 免邮",
          "￥2299",
          "微信支付",
        ]
      })
    } else {
      this.setData({
        orderItems: [
          "订单编号",
          "下单时间",
          "实付款",
          "支付方式",
        ],
        orderValues: [
          "1552626266599",
          "2020.05.06  16:22:45",
          "￥2299",
          "微信支付",
        ]
      })
    }
  }
});