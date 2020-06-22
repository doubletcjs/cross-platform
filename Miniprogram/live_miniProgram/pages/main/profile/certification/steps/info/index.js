//Component Object
Component({
  properties: {

  },
  data: {
    frontImage: "", //正面证件图片路径
    reverseImage: "", //反面证件图片路径
    name: "", //姓名
    idcard: "", //证件号码
  },
  methods: {
    //正面证件
    selectFrontImage() {
      wx.chooseImage({
        count: 1,
        sizeType: ['original', 'compressed'],
        sourceType: ['album', 'camera'],
        success: (result) => {
          var path = result.tempFilePaths[0]
          this.setData({
            frontImage: path
          })
        },
        fail: () => {},
        complete: () => {}
      });
    },
    //反面证件
    selectReverseImage() {
      wx.chooseImage({
        count: 1,
        sizeType: ['original', 'compressed'],
        sourceType: ['album', 'camera'],
        success: (result) => {
          var path = result.tempFilePaths[0]
          this.setData({
            reverseImage: path
          })
        },
        fail: () => {},
        complete: () => {}
      });
    },
    //下一步
    nextAction() {
      var msg = ""
      if (this.data.name.length == 0) {
        msg = "姓名不能为空！"
      } else if (this.data.idcard.length == 0) {
        msg = "证件号码不能为空！"
      } else if (this.data.frontImage.length == 0 || this.data.frontImage.length == 0) {
        msg = "请上传证件照！"
      }

      if (msg.length > 0) {
        wx.showToast({
          title: msg,
          icon: 'none',
          image: '',
          duration: 1500,
          mask: false,
          success: (result) => {

          },
          fail: () => {},
          complete: () => {}
        });
        return
      } else {
        var detail = {
          name: this.data.name,
          idcard: this.data.idcard,
          frontImage: this.data.frontImage,
          reverseImage: this.data.reverseImage
        }

        this.triggerEvent("confirm", detail)
      }
    },
    //文本输入
    inputChange(res) {
      var id = res.target.id
      var value = res.detail.value
      if (id == "name") {
        this.setData({
          name: value
        })
      } else {
        this.setData({
          idcard: value
        })
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