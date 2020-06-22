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
    }
  },
  data: {
    dateList: [
      "近一月",
      "近三月",
      "近半年",
      "近一年",
    ], //交易时间
    currentDefaultIndex: -1, //当前选择交易时间 
    defaultDateList: []
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
    //取消（左侧）按钮动作
    cancelAction() {
      this.closePopup()
    },
    dateToString: function (timestamp) {
      var date = new Date(timestamp)
      var year = date.getFullYear()
      var month = date.getMonth() + 1
      var day = date.getDate()

      if (month < 10) {
        month = "0" + month
      }

      if (day < 10) {
        day = "0" + day
      }

      return year + "-" + month + "-" + day
    },
    //确定（右侧）按钮动作
    confirmAction() {
      var detail = {}
      if (this.data.currentDefaultIndex == -1) {
        detail["start"] = this.data.defaultDateList[0]
        detail["end"] = this.data.defaultDateList[1]
      } else {
        var one_day_time = 60 * 60 * 24
        var start_date
        var end_date = new Date()
        var end_time = Date.parse(end_date)
        var diff_day = 1
        switch (this.data.currentDefaultIndex) {
          case 0:
            diff_day = 31 * 1
            break;
          case 1:
            diff_day = 31 * 3
            break;
          case 2:
            diff_day = 365 / 2
            break;
          case 3:
            diff_day = 365
            break;

          default:
            break;
        }

        var start_time = end_time - one_day_time * diff_day * 1000
        start_date = this.dateToString(start_time)
        end_date = this.dateToString(end_time)

        detail["start"] = start_date
        detail["end"] = end_date
      }

      this.closePopup();
      setTimeout(() => {
        this.triggerEvent("confirm", detail)
      }, 400)
    },
    //居中弹框屏蔽外部遮罩层关闭动作
    emptyAction() {},
    //选择预定交易日期
    selectTransactionDate: function (res) {
      var index = res.currentTarget.dataset.index
      this.setData({
        currentDefaultIndex: index
      })
    },
    //日期范围选择
    dateRangeChange: function (res) {
      var index = res.currentTarget.dataset.index
      var value = res.detail.value
      var list = this.data.defaultDateList
      list[index] = value

      var start_date = new Date(list[0])
      var end_date = new Date(list[1])

      if (start_date.getTime() > end_date.getTime()) {
        wx.showToast({
          title: '结束日期不能小于开始日期',
          icon: 'none',
          image: '',
          duration: 1500,
          mask: false,
          success: (result) => {

          },
          fail: () => {},
          complete: () => {}
        });
      } else {
        this.setData({
          defaultDateList: list,
          currentDefaultIndex: -1
        })
      }
    }
  },
  created: function () {

  },
  attached: function () {

  },
  ready: function () {
    var date = new Date()
    var year = date.getFullYear()
    var month = date.getMonth() + 1
    var nextMonth = month + 1
    var nextYear = year
    if (nextMonth > 12) {
      nextMonth = 1
      nextYear += 1
    }
    var day = date.getDate()

    if (month < 10) {
      month = "0" + month;
    }

    if (day < 10) {
      day = "0" + day;
    }

    if (nextMonth < 10) {
      nextMonth = "0" + nextMonth;
    }


    var list = [year + "-" + month + "-" + day, nextYear + "-" + nextMonth + "-" + day]
    this.setData({
      defaultDateList: list
    })
  },
  moved: function () {

  },
  detached: function () {

  },
});