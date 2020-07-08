//Component Object
Component({
  properties: {
    status: {
      type: Number, //0 待支付 1 待发货 2 待收货 3 交易成功 4 待支付 超时关闭 5 待发货 退款中 6 待发货 退款成功 订单关闭
      value: 0,
    },
  },
  data: {
    remainTime: 76400000,
    remain: "00小时00分00秒"
  },
  methods: {
    /**
     * 格式化时间
     */
    getFormat: function (mss) {
      var days = parseInt(mss / (1000 * 60 * 60 * 24));
      var hours = parseInt((mss % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      var minutes = parseInt((mss % (1000 * 60 * 60)) / (1000 * 60));
      var seconds = (mss % (1000 * 60)) / 1000;
      return days > 0 ? (days + "天" + hours + "小时" + minutes + "分钟" + seconds + "秒") : (hours + "小时" + minutes + "分钟" + seconds + "秒");
    },
    /**
     * 倒计时
     */
    setCountDown: function (weakSelf) {
      if (this.data.remainTime > 0) {
        let time = 1000
        var remainTime = this.data.remainTime
        let formatTime = this.getFormat(remainTime)
        remainTime -= time

        weakSelf.setData({
          remainTime: remainTime,
          remain: this.data.status == 5 ? ("等待平台处理 剩余" + formatTime) : ("剩" + formatTime + "自动关闭")
        })

        setTimeout(() => {
          weakSelf.setCountDown(weakSelf)
        }, time);
      } else {
        weakSelf.setData({
          remainTime: 0,
          remain: "",
          status: 4
        })
      }
    },
  },
  created: function () {

  },
  attached: function () {

  },
  ready: function () {
    if (this.data.status == 0 || this.data.status == 5) {
      this.setCountDown(this)
    }
  },
  moved: function () {

  },
  detached: function () {

  },
});