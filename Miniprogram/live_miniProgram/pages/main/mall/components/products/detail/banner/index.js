//Component Object
Component({
  properties: {

  },
  data: {
    productImages: [
      "",
      "",
      "",
      "",
      "",
      "",
    ],
    currentBanner: 0
  },
  methods: {
    //banner滚动
    swiperScroll(res) {
      var index = res.detail.current
      this.setData({
        currentBanner: index
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