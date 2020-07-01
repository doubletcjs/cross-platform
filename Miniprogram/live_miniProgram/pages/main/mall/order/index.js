// pages/main/mall/order/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    tablists:['全部','待支付','待发货','待收货','待评价'],
    currentTab:0,
    list:[
      {
        id:77,
        type:1, // 拼团订单 
        totalnum:'1',
        totalprice:'266.00',
        status:1, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
        shopings:[
          {
            imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
            orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
            orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
            price:'266.00',
            num:1,
            shopingstatus:''
          }
        ]
      },
      {
        id:101,
        type:2, //非拼团订单
        totalnum:'1',
        totalprice:'2166.00',
        status:1, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
        shopings:[
          {
            imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
            orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
            orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
            price:'2166.00',
            num:1,
            shopingstatus:''
          }
        ]
      },
      {
        id:119,
        type:1, //非拼团订单
        totalnum:'1',
        totalprice:'2266.00',
        status:2, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
        shopings:[
          {
            imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
            orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
            orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
            price:'2266.00',
            num:1,
            shopingstatus:'退款中'
          }
        ]
      },
      {
        id:2,
        type:2, //非拼团订单
        totalnum:'1',
        totalprice:'2266.00',
        status:2, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
        shopings:[
          {
            imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
            orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
            orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
            price:'2266.00',
            num:1,
            shopingstatus:'已退款'
          }
        ]
      },
      {
        id:115,
        type:2, //非拼团订单
        totalnum:'1',
        totalprice:'72.00',
        status:3, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
        shopings:[
          {
            imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
            orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
            orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
            price:'36.00',
            num:2,
            shopingstatus:'退款中'
          }
        ]
      },
      {
        id:110,
        type:1, //非拼团订单
        totalnum:'1',
        totalprice:'148.00',
        status:4, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
        shopings:[
          {
            imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
            orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
            orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
            price:'148.00',
            num:1,
            shopingstatus:''
          }
        ]
      },
      {
        id:13,
        type:2, //非拼团订单
        totalnum:'1',
        totalprice:'148.00',
        status:4, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
        shopings:[
          {
            imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
            orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
            orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
            price:'148.00',
            num:1,
            shopingstatus:''
          }
        ]
      },
      {
        id:15,
        type:1, //非拼团订单
        totalnum:'1',
        totalprice:'149.00',
        status:5, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭  
        shopings:[
          {
            imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
            orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
            orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
            price:'149.00',
            num:1,
            shopingstatus:'交易超时'
          }
        ]
      },
      {
        id:14,
        type:2, //非拼团订单
        totalnum:'1',
        totalprice:'149.00',
        status:5, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭  
        shopings:[
          {
            imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
            orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
            orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
            price:'149.00',
            num:1,
            shopingstatus:'已退款'
          }
        ]
      },
      {
        id:11,
        type:2, //非拼团订单
        totalnum:'3',
        totalprice:'149.00',
        status:2, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭  
        shopings:[
          {
            imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
            orderTitle:'扫拖不用亲自动 扫拖不用亲',
            orderContent:' 盐湖白，购买扫',
            price:'149.00',
            num:1,
            shopingstatus:''
          },
          {
            imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
            orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
            orderContent:' 盐湖白，送蓝色收纳袋送蓝色收纳送蓝色收纳袋送蓝色收纳送蓝色收纳袋送蓝色收纳送蓝色收纳袋送蓝色收纳',
            price:'149.00',
            num:1,
            shopingstatus:''
          },
          {
            imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
            orderTitle:'扫拖不用亲自动 扫拖不用亲自动',
            orderContent:' 盐湖白，购买扫 购买扫地机',
            price:'149.00',
            num:1,
            shopingstatus:''
          }
        ]
      }
    ]
  },
  changeTabhandle(e){
    let currentTab = e.detail;
    this.setData({currentTab:currentTab});
    
    if(this.data.currentTab == 0){
      let list = [
        {
          id:77,
          type:1, // 拼团订单 
          totalnum:'1',
          totalprice:'266.00',
          status:1, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'266.00',
              num:1,
              shopingstatus:''
            }
          ]
        },
        {
          id:101,
          type:2, //非拼团订单
          totalnum:'1',
          totalprice:'2166.00',
          status:1, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'2166.00',
              num:1,
              shopingstatus:''
            }
          ]
        },
        {
          id:119,
          type:1, //非拼团订单
          totalnum:'1',
          totalprice:'2266.00',
          status:2, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'2266.00',
              num:1,
              shopingstatus:'退款中'
            }
          ]
        },
        {
          id:2,
          type:2, //非拼团订单
          totalnum:'1',
          totalprice:'2266.00',
          status:2, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'2266.00',
              num:1,
              shopingstatus:'已退款'
            }
          ]
        },
        {
          id:115,
          type:2, //非拼团订单
          totalnum:'1',
          totalprice:'72.00',
          status:3, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'36.00',
              num:2,
              shopingstatus:'退款中'
            }
          ]
        },
        {
          id:110,
          type:1, //非拼团订单
          totalnum:'1',
          totalprice:'148.00',
          status:4, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'148.00',
              num:1,
              shopingstatus:''
            }
          ]
        },
        {
          id:13,
          type:2, //非拼团订单
          totalnum:'1',
          totalprice:'148.00',
          status:4, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'148.00',
              num:1,
              shopingstatus:''
            }
          ]
        },
        {
          id:15,
          type:1, //非拼团订单
          totalnum:'1',
          totalprice:'149.00',
          status:5, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭  
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'149.00',
              num:1,
              shopingstatus:'交易超时'
            }
          ]
        },
        {
          id:14,
          type:2, //非拼团订单
          totalnum:'1',
          totalprice:'149.00',
          status:5, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭  
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'149.00',
              num:1,
              shopingstatus:'已退款'
            }
          ]
        },
        {
          id:11,
          type:2, //非拼团订单
          totalnum:'3',
          totalprice:'149.00',
          status:2, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭  
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲',
              orderContent:' 盐湖白，购买扫',
              price:'149.00',
              num:1,
              shopingstatus:''
            },
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，送蓝色收纳袋送蓝色收纳送蓝色收纳袋送蓝色收纳送蓝色收纳袋送蓝色收纳送蓝色收纳袋送蓝色收纳',
              price:'149.00',
              num:1,
              shopingstatus:''
            },
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动',
              orderContent:' 盐湖白，购买扫 购买扫地机',
              price:'149.00',
              num:1,
              shopingstatus:''
            }
          ]
        }
      ]
      this.setData({list:list})
    }else if(this.data.currentTab == 1){
      let list = [
        {
          id:77,
          type:1, // 拼团订单 
          totalnum:'1',
          totalprice:'266.00',
          status:1, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'266.00',
              num:1,
              shopingstatus:''
            }
          ]
        },
        {
          id:101,
          type:2, //非拼团订单
          totalnum:'1',
          totalprice:'2166.00',
          status:1, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'2166.00',
              num:1,
              shopingstatus:''
            }
          ]
        }
      ]
      this.setData({list:list})
    }else if(this.data.currentTab == 2){
      let list = [
        {
          id:119,
          type:1, //非拼团订单
          totalnum:'1',
          totalprice:'2266.00',
          status:2, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'2266.00',
              num:1,
              shopingstatus:'退款中'
            }
          ]
        }
      ]
      this.setData({list:list})
    }else if(this.data.currentTab == 3){
      let list = [
        {
          id:115,
          type:2, //非拼团订单
          totalnum:'1',
          totalprice:'72.00',
          status:3, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'36.00',
              num:2,
              shopingstatus:'退款中'
            }
          ]
        }
      ]
      this.setData({list:list})
    }else if(this.data.currentTab == 4){
      let list = [
        {
          id:110,
          type:1, //非拼团订单
          totalnum:'1',
          totalprice:'148.00',
          status:4, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'148.00',
              num:1,
              shopingstatus:''
            }
          ]
        },
        {
          id:13,
          type:2, //非拼团订单
          totalnum:'1',
          totalprice:'148.00',
          status:4, // 1 等待付款 2 等待卖家发货 3 卖家已发货 4 交易成功 5 交易关闭 6 
          shopings:[
            {
              imgsrc:'/icons/icon-profile-product-placeholder@3x.png',
              orderTitle:'扫拖不用亲自动 扫拖不用亲自动扫拖不用亲自动拖两用机器人...',
              orderContent:' 盐湖白，购买扫 购买扫地机器人 送蓝色收纳袋送蓝色收纳袋送',
              price:'148.00',
              num:1,
              shopingstatus:''
            }
          ]
        }
      ]
      this.setData({list:list})
    }
  },
  godetail(){
    wx.navigateTo({
      url: '',
      success: (result)=>{
        
      },
      fail: ()=>{},
      complete: ()=>{}
    });
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {

  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})