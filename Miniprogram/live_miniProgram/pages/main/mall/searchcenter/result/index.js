//Component Object
Component({
  properties: {

  },
  data: {
    tabList: ["推荐", "销量", "价格"], //基础条件
    tabIndex: 0, //当前基础条件
    priceStatus: 0, //0 价格高到低 1 价格低到高 
    screeningvisible: false, //筛选条件
    products: [{
      name: "学霸学习，国AA级护眼认证，智能护目灯",
      price: 149,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 159,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 49,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 59,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 89,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 359,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }, {
      name: "告别桌面沙发尘屑毛发mini桌面吸尘器",
      price: 39,
      image: "/icons/icon-profile-product-placeholder@3x.png"
    }] //商品列表
  },
  methods: {
    //切换基础条件
    switchBaseTab: function (res) {
      var index = res.currentTarget.dataset.index
      if (this.data.tabIndex == 2 && this.data.tabIndex == index) {
        if (this.data.priceStatus == 0) {
          this.setData({
            priceStatus: 1
          })
        } else {
          this.setData({
            priceStatus: 0
          })
        }
      }

      this.setData({
        tabIndex: index
      })

      if (index == 2) {
        if (this.data.priceStatus == 0) {
          this.setData({
            products: this.data.products.sort(function (a, b) {
              var priceA = a["price"];
              var priceB = b["price"];
              if (priceA < priceB) {
                return -1;
              }

              if (priceA > priceB) {
                return 1;
              }
              return 0;
            })
          })
        } else {
          this.setData({
            products: this.data.products.sort(function (a, b) {
              var priceA = a.price;
              var priceB = b.price;
              if (priceA < priceB) {
                return 1;
              }

              if (priceA > priceB) {
                return -1;
              }
              return 0;
            })
          })
        }
      }
    },
    //筛选条件
    showScreening: function () {
      this.setData({
        screeningvisible: true
      })
    },
    screeningClose: function () {
      this.setData({
        screeningvisible: false
      })
    },
    screeningConfirm: function (res) {
      console.log(JSON.stringify(res))
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