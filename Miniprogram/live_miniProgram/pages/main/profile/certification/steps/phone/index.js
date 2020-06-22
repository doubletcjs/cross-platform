//Component Object
var kMaxCountDownSecond = 60;

Component({
  properties: {

  },
  data: {
    countDownSecond: kMaxCountDownSecond, //倒计时
    countDownString: "获取验证码", //倒计时 
    phone: "", //手机号
    verifycode: "", //验证码
  },
  methods: {
    // 获取验证码
    getVerifyCode: function () {
      if (this.data.countDownSecond == kMaxCountDownSecond) {
        wx.showLoading({
          title: "",
          mask: true,
          success: (result) => {

          },
          fail: () => {},
          complete: () => {}
        });

        setTimeout(() => {
          wx.hideLoading()
          this.countingDown()
        }, 1000);
      }
    },
    // 倒计时
    countingDown: function () {
      this.setData({
        countDownString: this.data.countDownSecond + "s"
      })

      // 60秒后重新获取验证码
      var inter = setInterval(function () {
        this.setData({
          countDownSecond: this.data.countDownSecond - 1
        })

        this.setData({
          countDownString: this.data.countDownSecond + "s"
        })

        if (this.data.countDownSecond < 1) {
          clearInterval(inter)
          this.setData({
            countDownSecond: kMaxCountDownSecond,
            countDownString: "获取验证码"
          })
        }
      }.bind(this), 1000);
    },
    //下一步
    nextAction() {
      var msg = ""
      if (this.data.phone.length == 0) {
        msg = "请输入合法手机号！"
      } else if (this.data.verifycode.length == 0) {
        msg = "验证码不能为空！"
      }

      if (msg.length > 0) {
        wx.showToast({
          title: msg,
          icon: 'none',
          image: '',
          duration: 1500,
          mask: false,
          success: (result) => {

          },
          fail: () => {},
          complete: () => {}
        });
        return
      } else {
        var detail = {
          phone: this.data.phone,
          verifycode: this.data.verifycode
        }

        this.triggerEvent("confirm", detail)
      }
    },
    //文本输入
    inputChange(res) {
      var id = res.target.id
      var value = res.detail.value
      if (id == "phone") {
        this.setData({
          phone: value
        })
      } else {
        this.setData({
          verifycode: value
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
  detached: function () {},
});