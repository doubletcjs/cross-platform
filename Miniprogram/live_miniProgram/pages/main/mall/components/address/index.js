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
    addressList: [{
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际909不知道还有多长",
        selected: true,
        default: true
      },
      {
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际",
        selected: false,
        default: false
      },
      {
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际1",
        selected: false,
        default: false
      },
      {
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际2",
        selected: false,
        default: false
      },
      {
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际3",
        selected: false,
        default: false
      },
      {
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际4",
        selected: false,
        default: false
      },
      {
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际5",
        selected: false,
        default: false
      },
      {
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际6",
        selected: false,
        default: false
      },
      {
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际7",
        selected: false,
        default: false
      },
      {
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际8",
        selected: false,
        default: false
      },
      {
        province: "广东省",
        city: "广州市",
        area: "白云区",
        address: "人和芳华路星航国际9",
        selected: false,
        default: false
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
    //选择其他地址
    addressPageAction() {
      wx.navigateTo({
        url: '/pages/main/mall/address/index',
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
    },
    //选择地址
    addressItemSelect(res) {
      var index = res.currentTarget.dataset.index
      var list = this.data.addressList
      for (let i = 0; i < list.length; i++) {
        const element = list[i]
        if (i == index) {
          element.selected = true
        } else {
          element.selected = false
        }

        list[i] = element
      }

      this.setData({
        addressList: list
      })

      var dict = {
        address: this.data.addressList[index]
      }
      console.log(JSON.stringify(dict))

      setTimeout(() => {
        this.closePopup()
        this.triggerEvent("selectconfirm", {
          address: this.data.addressList[index]
        })
      }, 200);
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