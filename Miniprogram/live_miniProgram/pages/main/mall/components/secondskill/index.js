//Component Object
Component({
  properties: {

  },
  data: {
    products: [{
      name: "手机黄金搭档,PD快充折叠支架无线充...",
      price: 139,
      originalprice: 189,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "mini复古唱片机，随身便携智能蓝牙音箱",
      price: 149,
      originalprice: 189,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "驱蚊器+小夜灯2合1驱蚊高手居家必备",
      price: 38,
      originalprice: 58,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "驱蚊器+小夜灯2合1驱蚊高手居家必备",
      price: 78,
      originalprice: 108,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "驱蚊器+小夜灯2合1驱蚊高手居家必备",
      price: 78,
      originalprice: 108,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }],
    subtitle: "• 12点场",
    countdownlist: [
      "hour",
      ":",
      "minute",
      ":",
      "second",
    ],
    hour: "01",
    minute: "10",
    second: "10",
  },
  methods: {

  },
  created: function () {

  },
  attached: function () {

  },
  ready: function () {
    var inthour = parseInt(this.data.hour)
    var intminute = parseInt(this.data.minute)
    var intsecond = parseInt(this.data.second)
    var interval = setInterval(() => {
      if (inthour == 0 && intminute == 0 && intsecond <= 1) {
        clearInterval(interval)

        this.setData({
          hour: "00",
          minute: "00",
          second: "00",
          countdownlist: []
        })
        return
      }

      var changeMinute = false
      if (intminute == 0 && intsecond <= 1 && inthour > 0) {
        intminute = 59
        inthour -= 1
        changeMinute = true
      }

      if (intsecond <= 1) {
        intsecond = 60
        if (changeMinute == false) {
          intminute -= 1
        }
      }

      intsecond -= 1

      var tempHour = inthour.toString()
      if (inthour < 10) {
        tempHour = "0" + tempHour
      }

      var tempMinute = intminute.toString()
      if (intminute < 10) {
        tempMinute = "0" + tempMinute
      }

      var tempSecond = intsecond.toString()
      if (intsecond < 10) {
        tempSecond = "0" + tempSecond
      }

      this.setData({
        hour: tempHour,
        minute: tempMinute,
        second: tempSecond
      })
    }, 1000);
  },
  moved: function () {

  },
  detached: function () {

  },
});