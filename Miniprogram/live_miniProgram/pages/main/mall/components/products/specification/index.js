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
    //商品
    product: {
      type: Object,
      value: {
        count: 1
      }
    }
  },
  data: {
    colorList: [{
        name: "盐湖白"
      },
      {
        name: "炫酷黑"
      }
    ],
    colorIndex: 0,
    specList: [{
        name: "购买扫地机器人送蓝色收纳篮"
      },
      {
        name: "购买扫地机器人+100送更换赃物碟片"
      }
    ],
    specIndex: 0
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
    //颜色选择
    colorSelect(res) {
      var index = res.currentTarget.dataset.index
      this.setData({
        colorIndex: index
      })
    },
    //规格选择
    specSelect(res) {
      var index = res.currentTarget.dataset.index
      this.setData({
        specIndex: index
      })
    },
    //数量加
    append() {
      var temp = this.data.product
      temp.count += 1

      this.setData({
        product: temp
      })
    },
    //数量减
    subtract() {
      var temp = this.data.product
      if (temp.count > 1) {
        temp.count -= 1

        this.setData({
          product: temp
        })
      }
    },
    //确认选择
    specificationConfirm() {

    },
  },
  created: function () {
    console.log("created");
  },
  attached: function () {
    console.log("attached");
  },
  ready: function () {
    console.log("ready");
  },
  moved: function () {
    console.log("moved");
  },
  detached: function () {

  },
});