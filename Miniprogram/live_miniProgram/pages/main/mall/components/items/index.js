//Component Object
Component({
  properties: {
    dataList: {
      type: Array,
      value: [{
          name: "购物车",
          number: 0,
          icon: "/icons/ico-g1@3x.png",
        },
        {
          name: "我的拼团",
          number: 8,
          icon: "/icons/ico-p1@3x.png",
        },
        {
          name: "我的订单",
          number: 0,
          icon: "/icons/ico-d1@3x.png",
        },
        {
          name: "优惠券",
          number: 0,
          icon: "/icons/ico-y1@3x.png",
        },
        {
          name: "直播",
          number: 0,
          icon: "/icons/ico-z1@3x.png",
        },
        {
          name: "我的收藏",
          icon: "/icons/ico-s1@3x.png",
        },
        {
          name: "地址管理",
          number: 0,
          icon: "/icons/ico-dz1@3x.png",
        },
        {
          name: "联系客服",
          number: 0,
          icon: "/icons/ico-l1@3x.png",
        },
      ]
    }
  },
  data: {

  },
  methods: {
    //选择
    itemSelect(res) {
      var index = res.currentTarget.dataset.index
      if (index == 3) {
        wx.navigateTo({
          url: '/pages/main/mall/coupons/index',
          success: (result) => {

          },
          fail: () => {},
          complete: () => {}
        });
      } else if (index == 6) {
        wx.navigateTo({
          url: '/pages/main/mall/address/index',
          success: (result) => {

          },
          fail: () => {},
          complete: () => {}
        });
      } else if (index == 4) {
        wx.switchTab({
          url: '/pages/main/live/index',
          success: (result) => {

          },
          fail: () => {},
          complete: () => {}
        });
      } else if (index == 2) {
        wx.navigateTo({
          url: '/pages/main/mall/order/index',
          success: (result) => {

          },
          fail: () => {},
          complete: () => {}
        });
      } else if (index == 5) {
        wx.navigateTo({
          url: '/pages/main/mall/collection/index',
          success: (result) => {

          },
          fail: () => {},
          complete: () => {}
        });
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
  detached: function () {

  },
});