//Component Object
Component({
  properties: {

  },
  data: {
    coupons: [
      "领券可减￥10",
      "满2000元减50元"
    ],
    setAlert: false, //提醒
    setCollect: false, //收藏
    specvisible: false, //规格
    addressvisible: false, //地址
  },
  methods: {
    //优惠券
    couponsAction() {
      this.setData({
        couponvisible: true
      })
    },
    couponsClose() {
      this.setData({
        couponvisible: false
      })
    },
    //选规格
    specificationAction() {
      this.setData({
        specvisible: true
      })
    },
    specificationClose() {
      this.setData({
        specvisible: false
      })
    },
    //选地址
    addressAction() {
      this.setData({
        addressvisible: true
      })
    },
    addressClose() {
      this.setData({
        addressvisible: false
      })
    },
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