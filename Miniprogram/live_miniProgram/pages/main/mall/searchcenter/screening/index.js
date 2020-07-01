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
    brandList: [{
        name: "品牌1",
        select: false,
      },
      {
        name: "这个品牌很长",
        select: false,
      },
      {
        name: "品牌3",
        select: false,
      },
      {
        name: "品牌4",
        select: false,
      },
      {
        name: "品牌5",
        select: false,
      }
    ],
    lowPrice: "",
    heigthPrice: ""
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
    //品牌选择
    brandSelect(res) {
      var index = res.currentTarget.dataset.index
      var list = this.data.brandList
      var band = list[index]
      band.select = !band.select
      list[index] = band

      this.setData({
        brandList: list
      })
    },
    //重置
    resetAction() {
      var list = this.data.brandList
      for (let index = 0; index < list.length; index++) {
        const element = list[index]
        element.select = false
        list[index] = element
      }

      this.setData({
        lowPrice: "",
        heigthPrice: "",
        brandList: list
      })
    },
    //输入价格
    priceInput(res) {
      var id = res.target.id
      var value = res.detail.value

      if (id == "lowprice") {
        this.setData({
          lowPrice: value
        })
      }

      if (id == "heightprice") {
        this.setData({
          heigthPrice: value
        })
      }
    },
    //确认
    onConfirm() {
      this.closePopup()
      var brands = []
      this.data.brandList.forEach(element => {
        if (element.select) {
          brands.push(element.name)
        }
      });

      this.triggerEvent("confirm", {
        lowPrice: this.data.lowPrice,
        heigthPrice: this.data.heigthPrice,
        brands: brands
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