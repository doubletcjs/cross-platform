// pages/main/mall/components/orderList/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    list: {
      type: Array,
      value: []
    }
  },

  /**
   * 组件的初始数据
   */
  data: {

  },
  /**
   * 组件的方法列表
   */
  methods: {
    cancelHandle(e) {
      console.log(e)
      let orderType = e.currentTarget.dataset.index;

      // console.log(orderType)
      wx.showModal({
        title: '',
        content: '操作',
        showCancel: true,
        cancelText: '取消',
        cancelColor: '#000000',
        confirmText: '确定',
        confirmColor: '#3CC51F',
        success: (result) => {
          if (result.confirm) {

          }
        },
        fail: () => {},
        complete: () => {}
      })
    },
    confirmHandle(res) {
      let index = res.currentTarget.dataset.index;
      let item = this.data.list[index]
      if (item.status >= 5) {
        this.godetail(item.id)
      } else {
        wx.showModal({
          title: '',
          content: '操作',
          showCancel: true,
          cancelText: '取消',
          cancelColor: '#000000',
          confirmText: '确定',
          confirmColor: '#3CC51F',
          success: (result) => {
            if (result.confirm) {

            }
          },
          fail: () => {},
          complete: () => {}
        })
      }
    },
    godetail(orderId) {
      // 获取订单id  
      wx.navigateTo({
        url: '../order/detail/index',
        success: (result) => {

        },
        fail: () => {},
        complete: () => {}
      });
    }
  }
})