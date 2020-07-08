//Component Object
Component({
  properties: {

  },
  data: {
    specList: [{
        name: "产品名称",
        value: "网易智造激光导航扫地机器人（别名：网易智造扫拖两用机器人）"
      },
      {
        name: "产品类型",
        value: "扫拖一体（水箱可添加水性消毒液辅助地面消毒）"
      },
      {
        name: "导航方式",
        value: "LDS激光导航"
      },
      {
        name: "111111",
        value: "111111111111111111111111111111111111"
      },
      {
        name: "22222",
        value: "22222222222222222222"
      },
      {
        name: "333333",
        value: "333333333333333333333333333333333333"
      }
    ],
    dataList: []
  },
  methods: {
    showMore() {
      this.setData({
        dataList: this.data.specList
      })
    }
  },
  created: function () {

  },
  attached: function () {

  },
  ready: function () {
    this.setData({
      dataList: this.data.specList.length >= 3 ? this.data.specList.slice(0, 3) : this.data.specList
    })
  },
  moved: function () {

  },
  detached: function () {

  },
});