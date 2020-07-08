//Component Object
Component({
  properties: {
    //顶部间隙
    topSpace: {
      type: Number,
      value: 72.0
    },
    //标题
    title: {
      type: String,
      value: ""
    },
    //商品列表
    products: {
      type: Array,
      value: []
    }
  },
  data: {

  },
  methods: {
    //商品详情
    productDetail(res) {
      var index = res.currentTarget.dataset.index
      wx.navigateTo({
        url: '/pages/main/mall/detail/index',
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
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