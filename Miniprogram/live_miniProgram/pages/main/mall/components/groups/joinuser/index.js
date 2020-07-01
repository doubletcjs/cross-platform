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
    userList: []
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
    /**
     * 格式化时间
     */
    getFormat: function (msec) {
      let ss = parseInt(msec / 1000);
      let ms = parseInt(msec % 1000);
      let mm = 0;
      let hh = 0;
      if (ss > 60) {
        mm = parseInt(ss / 60);
        ss = parseInt(ss % 60);
        if (mm > 60) {
          hh = parseInt(mm / 60);
          mm = parseInt(mm % 60);
        }
      }
      ss = ss > 9 ? ss : `0${ss}`;
      mm = mm > 9 ? mm : `0${mm}`;
      hh = hh > 9 ? hh : `0${hh}`;
      return `${hh}:${mm}:${ss}`;
    },
    /**
     * 倒计时
     */
    setCountDown: function (weakSelf) {
      let time = 1000
      var list = this.data.userList
      for (let index = 0; index < list.length; index++) {
        const element = list[index]
        if (element.remainTime <= 0) {
          element.remainTime = 0
        }
        let formatTime = this.getFormat(element.remainTime)
        element.remainTime -= time
        element.remain = formatTime

        list[index] = element
      }

      weakSelf.setData({
        userList: list
      })

      setTimeout(() => {
        weakSelf.setCountDown(weakSelf)
      }, time);
    },
  },
  created: function () {

  },
  attached: function () {

  },
  ready: function () {
    if (this.data.userList.length == 0) {
      var list = [{
          remainTime: 86400000,
          remain: "",
          head: "/icons/person.png",
          name: "用户008"
        },
        {
          remainTime: 64937162,
          remain: "",
          head: "/icons/person.png",
          name: "用户009"
        },
        {
          remainTime: 3645678,
          remain: "",
          head: "/icons/person.png",
          name: "用户010"
        },
        {
          remainTime: 74231324,
          remain: "",
          head: "/icons/person.png",
          name: "用户011"
        }
      ]

      list.forEach(element => {
        element.remain = this.getFormat(element.remainTime)
      });

      this.setData({
        userList: list
      })

      this.setCountDown(this)
    }
  },
  moved: function () {

  },
  detached: function () {

  },
});