//Component Object
var _heartBeatAnimation;

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
    //是否横屏
    landscape: {
      type: Boolean,
      value: false
    },
  },
  data: {
    functionItems: [{
        "name": "小心心",
        "icon": "/icons/icon_gift_heart@3x.png",
        "price": "免费"
      },
      {
        "name": "玫瑰花",
        "icon": "/icons/icon_gift_rose@3x.png",
        "price": "0.1金币"
      },
      {
        "name": "非常赞",
        "icon": "/icons/icon_gift_like@3x.png",
        "price": "0.2金币"
      },
      {
        "name": "红酒",
        "icon": "/icons/icon_gift_redwine@3x.png",
        "price": "0.5金币"
      },
      {
        "name": "红包",
        "icon": "/icons/icon_gift_redpacket@3x.png",
        "price": "发红包"
      },
      {
        "name": "FIL币",
        "icon": "/icons/icon_gift_fil@3x.png",
        "price": "2金币"
      },
      {
        "name": "存储器",
        "icon": "/icons/icon_gift_storage@3x.png",
        "price": "88金币"
      },
      {
        "name": "带我飞",
        "icon": "/icons/icon_gift_plane@3x.png",
        "price": "299金币"
      },
    ],
    pages: [],
    giftIndex: -1,
    actionvisible: false,
    menuvisible: false,
    redpacketvisible: false,
    selectCount: 1,
    alertvisible: false, // alert 弹框显示
    totalStorage: 21.3, // 总资金
    contentString: "您的金币不足,请充值！",
    heartBeatAnimation: "",
    defaultAnimation: "",
    interval: null
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
    // closeClick 关闭  弹框
    closeClick() {
      this.setData({
        alertvisible: false,
        menuvisible: false,
        actionvisible: false,
        redpacketvisible: false
      })
    },

    //充值
    rechargeAction() {
      this.setData({
        actionvisible: !this.data.actionvisible,
      })
    },
    //选择数量
    selectCountAction() {
      this.setData({
        menuvisible: !this.data.menuvisible,
      })
    },
    //赠送
    giveAction() {
      // 判断是否勾选礼物
      if (this.data.giftIndex < 0) {
        this.setData({
          alertvisible: true,
          contentString: '请选择礼物！'
        })
        return false;
      }
      let selectObj = this.data.functionItems[this.data.giftIndex];
      let step = this.data.selectCount;
      let allPrice = step * parseFloat(selectObj.price);

      // 判断金币是否够用
      if (allPrice - this.data.totalStorage > 0) {
        this.setData({
          alertvisible: true
        })
      } else {
        // 发送礼物
        let sendgiftobj = {
          num: step,
          type: 0,
          authorname: '蒋国宇',
          animation: Math.random(),
          selectObj: selectObj
        }
        this.triggerEvent('sendgiftobj', sendgiftobj)
      }
    },
    //点击选择内容
    itemTapAction(res) {
      var index = res.currentTarget.dataset.index
      this.setData({
        giftIndex: index
      })

      this.startAnimation();
      if (this.data.functionItems[this.data.giftIndex]["name"] == "红包") {
        this.setData({
          redpacketvisible: !this.data.redpacketvisible,
        })
      }
    },
    //充值菜单选择
    itemSelect: function (res) {
      wx.navigateTo({
        url: '/pages/recharge/index?type=' + res.detail.index,
        success: (result) => {

        },
        fail: (error) => {
          console.log("error:" + JSON.stringify(error))
        },
        complete: () => {}
      });
    },
    //礼物数选择菜单
    menuSelect: function (res) {
      this.setData({
        selectCount: parseInt(res.detail.count)
      })
    },
    //红包选择
    redpacketAction: function (res) {
      var selectObj = res.detail;
      console.log(JSON.stringify(selectObj));
      let sendgiftobj = {
        num: 0,
        type: 1,
        authorname: '蒋国宇',
        animation: Math.random(),
        selectObj: selectObj
      }
      this.triggerEvent('sendgiftobj', sendgiftobj)
    },
    //关闭心跳动画
    stopAnimation: function () {
      if (this.data.interval != null) {
        clearInterval(this.data.interval);
        _heartBeatAnimation.scale(1.0).step();
        this.setData({
          interval: null,
        });
      }
    },
    //点击心跳动画
    startAnimation: function () {
      this.stopAnimation();
      _heartBeatAnimation = wx.createAnimation({
        duration: 600,
        timingFunction: "linear",
        delay: 0,
        transformOrigin: "50% 50% 0"
      });

      var circleCount = 0;
      var timer = setInterval(function () {
        if (circleCount % 2 == 0) {
          _heartBeatAnimation.scale(1.0).step();
        } else {
          _heartBeatAnimation.scale(0.9).step();
        }

        this.setData({
          heartBeatAnimation: _heartBeatAnimation.export(),
        });

        circleCount++;
        if (circleCount == 600) {
          circleCount = 0;
        }
      }.bind(this), 600);

      this.setData({
        interval: timer,
      });
    }
  },
  created: function () {

  },
  attached: function () {

  },
  ready: function () {
    var maxRowInPage = 8
    if (this.data.landscape) {
      maxRowInPage = 7
    }

    var maxPage = this.data.functionItems.length % maxRowInPage > 0 ? parseInt(this.data.functionItems.length / maxRowInPage) + 1 : parseInt(this.data.functionItems.length / maxRowInPage)
    var _pages = []
    for (let index = 0; index < maxPage; index++) {
      var array = this.data.functionItems.slice(index * maxRowInPage, (index + 1) * maxRowInPage)
      _pages.push(array)
    }

    this.setData({
      pages: _pages
    })

    let _animation = wx.createAnimation({
      duration: 600,
      timingFunction: 'linear',
      delay: 0,
      transformOrigin: '50% 50% 0'
    });
    _animation.scale(1.0).step();
    this.setData({
      defaultAnimation: _animation.export()
    });
  },
  moved: function () {

  },
  detached: function () {

  },
});