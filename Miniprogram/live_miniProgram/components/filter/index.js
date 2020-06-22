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
    filterItems: [{
        name: "磨皮",
        value: 10.0
      },
      {
        name: "曝光",
        value: 30.0
      },
      {
        name: "美白",
        value: 3.0
      },
      {
        name: "饱和",
        value: 1.0
      }
    ],
    openFilter: true
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
    //slider拖动
    sliderBindchanging(res) {
      var index = res.currentTarget.dataset.index
      var value = res.detail.value
      var list = this.data.filterItems
      list[index]["value"] = value

      this.setData({
        filterItems: list
      })
    },
    //是否开启
    switchBindchange(res) {
      this.setData({
        openFilter: !this.data.openFilter
      })
    },
    //重置
    resetFilter(res) {
      if (this.data.openFilter == true) {
        var list = this.data.filterItems
        for (let index = 0; index < this.data.filterItems.length; index++) {
          const element = this.data.filterItems[index];
          element["value"] = 0.0
          list[index] = element
        }

        this.setData({
          filterItems: list
        })
      }
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