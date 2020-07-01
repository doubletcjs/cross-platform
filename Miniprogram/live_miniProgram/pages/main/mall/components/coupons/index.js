//Component Object
Component({
  properties: {
    //是否弹出显示
    visible: {
      type: Boolean,
      value: false
    },
    //点击外部的遮罩层是否允许关闭
    outClickCanClose: {
      type: Boolean,
      value: true
    },
  },
  data: {
    couponsList: [{
        name: "全场商品买499可用",
        price: 200,
        fullPrice: 499,
        startDate: "2020.05.20",
        endDate: "2020.06.20",
        status: 0 // 0 未领取 1 已领取
      },
      {
        name: "全场商品买199可用",
        price: 100,
        fullPrice: 199,
        startDate: "2020.05.22",
        endDate: "2020.06.25",
        status: 1 // 0 未领取 1 已领取
      }
    ]
  },
  methods: {
    //关闭alert
    closePopup() {
      this.triggerEvent("close", {
        visible: this.data.visible
      })
    },
    //点击外部的遮罩层关闭动作
    outClick() {
      if (this.data.outClickCanClose == true) {
        this.closePopup()
      }
    },
    //取消按钮动作
    cancelAction() {
      this.closePopup()
    },
    //居中弹框屏蔽外部遮罩层关闭动作
    emptyAction() {},
  },
  created: function () {

  },
  attached: function () {

  },
  ready: function () {

  },
  moved: function () {

  },
  detached: function () {

  },
});