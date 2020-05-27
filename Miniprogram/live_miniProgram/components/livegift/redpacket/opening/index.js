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
      value: false
    },
    //是否横屏
    landscape: {
      type: Boolean,
      value: false
    },
  },
  data: {
    open: false, //是否已开启红包，没有只出现”抢“字，点击默认打开（抢）。
    showList: false, //显示抢到红包的用户列表
    amount: 0.0,
    dataList: [{
        "name": "用户1",
        "amount": 5
      },
      {
        "name": "用户2",
        "amount": 5
      },
      {
        "name": "用户3",
        "amount": 5
      },
      {
        "name": "用户4",
        "amount": 5
      },
      {
        "name": "用户5",
        "amount": 5
      },
      {
        "name": "用户6",
        "amount": 5
      },
      {
        "name": "用户7",
        "amount": 5
      },
      {
        "name": "用户8",
        "amount": 5
      },
      {
        "name": "用户9",
        "amount": 5
      },
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
    //居中弹框屏蔽外部遮罩层关闭动作
    emptyAction() {},
    //打开红包
    openPacketAction() {
      if (this.data.open == false) {
        this.setData({
          open: true
        })
      }
    },
    //取消（左侧）按钮动作
    cancelAction() {
      this.closePopup()
      setTimeout(() => {
        this.triggerEvent("cancel")

        this.setData({
          showList: false
        })
      }, 400)
    },
    //手气列表
    showListAction: function () {
      this.setData({
        showList: true
      })
    }
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