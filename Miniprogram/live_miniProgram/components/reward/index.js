//Component Object
Component({
  properties: {
    //余额
    balance: {
      type: Number,
      value: 0
    },
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
    actionvisible:false,
    itemSelect:[],
    dataList: [
      "1",
      "6",
      "10",
      "100",
      "200",
      "其他金额",
    ],
    rewardIndex: -1
  },
  methods: {
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
    closeClick(){
      this.setData({actionvisible:false})
    },
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
    //金额选择
    rewardTap(res) {
      var index = res.currentTarget.dataset.index
      var item = this.data.dataList[index]
      if (item == "其他金额") {
        this.setData({
          rewardIndex: -1
        })

        this.rewardAction(-1)
      } else {
        this.setData({
          rewardIndex: index
        })
      }
    },
    //打赏
    rewardConfrimAction() {
     
      if (this.data.rewardIndex >= 0) {
        var number = this.data.dataList[this.data.rewardIndex]
        this.rewardAction(number)
      }
    },
    //打赏金额回调
    rewardAction(number) {
      this.closePopup();
      if(this.data.balance - number <0){
        this.setData({actionvisible:true})
        return false;
      }
      
      setTimeout(() => {
        this.triggerEvent("confirm", {
          number: number
        })

        // console.log(number);
      }, 400)
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