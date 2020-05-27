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
    // 屏蔽礼物开关
    sendGiftOff:{ 
      type:Boolean,
      value:false
    },
    // 关闭弹幕开关
    sendContentOff:{ 
      type:Boolean,
      value:false
    }
  },
  data: {
    functionItems: [{
        "name": "屏蔽礼物",
        "icon": "/icons/icon_more_nogift@3x.png"
      },
      {
        "name": "关闭弹幕",
        "icon": "/icons/icon_more_nocomment@3x.png"
      },
    ],
    pages: []
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
    //点击选择内容
    itemTapAction(res) {
      var name = res.currentTarget.dataset.row.name;
      var off = null;
      if(name == "屏蔽礼物"){
        off = !this.data.sendGiftOff
      }else{
        off = !this.data.sendContentOff
      }
      this.setData()
      this.closePopup();
      setTimeout(() => {
        this.triggerEvent("itemselect", {
          name: name,
          off:off
        })
      }, 400)
    },
  },
  created: function () {

  },
  attached: function () {

  },
  ready: function () {
    var maxRowInPage = 12
    var maxPage = this.data.functionItems.length % maxRowInPage > 0 ? parseInt(this.data.functionItems.length / maxRowInPage) + 1 : parseInt(this.data.functionItems.length / maxRowInPage)
    var _pages = []
    for (let index = 0; index < maxPage; index++) {
      var array = this.data.functionItems.slice(index * maxRowInPage, (index + 1) * maxRowInPage)
      _pages.push(array)
    }

    this.setData({
      pages: _pages
    })
  },
  moved: function () {

  },
  detached: function () {
    
  },
});