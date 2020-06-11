// pages/writeArticle/index.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    formats: {},
    bottom: 0,
    cur:false,
    actionvisible:false, // 底部弹框
    items:['保存草稿','不保存'],
    readOnly: false,
    titleText:'', // 标题
    placeholder: '请开始你的创作~',
    _focus: false,
  },
  closeClick(){
    this.setData({actionvisible:false})
  },
  itemSelect(e){
    console.log(e)
  },
  // 取消操作
  cancel(){
    this.setData({actionvisible:true})
  },
  // 发布
  submit(){
    if(this.data.cur){
      console.log('发布')
      this.editorCtx.getContents({
        success(res){
          console.log(res)
        },
        fail(res){
          console.log(res)
        },
        complete(res){
          // console.log(res)
        }
      })
    }
  },
  // 输入框value 值变化的回调
  bindinput(e){
    this.setData({titleText:e.detail.value})
    // console.log(this.data.titleText)
  },
  // editor 初始化
  onEditorReady() {
    const that = this
    wx.createSelectorQuery().select('#editor').context(function(res) {
      that.editorCtx = res.context
    }).exec()
  },
  // 取消
  undo() {
    this.editorCtx.undo()
  },
  // 重做
  redo() {
    this.editorCtx.redo()
  },
  // 输入内容变化的回调
  getFormats(e) {
    let detail = e.detail;
    if(detail.text.length==1){
      this.setData({cur:false})
      console.log('cur',this.data.cur)
    }else{
      this.setData({cur:true})
    }
    console.log(detail.text.length,this.data.cur)
  },
  // 样式排版变化的回调
  onStatusChange(e) {
    const formats = e.detail
    console.log('eeee',formats)
    this.setData({
      formats
    })
  },
  // 选择图片
  insertImage(){
    let that = this;
    wx.chooseImage({
      success: res => {
        wx.getFileSystemManager().readFile({
          filePath: res.tempFilePaths[0], //选择图片返回的相对路径
          encoding: 'base64', //编码格式
          success: res => { //成功的回调
            console.log('上传的图片内容data:image/png;base64==== ,' + res.data)
            const userImageBase64 = 'data:image/png;base64,' + res.data
            that.editorCtx.insertImage({
              src: userImageBase64,
              data: {
                id: 'abcd',
                role: 'god'
              },
              success: function () {
                console.log('insert image success')
              }
            })
          }
        })

        //以下两行注释的是同步方法，不过我不太喜欢用。
        //let base64 = wx.getFileSystemManager().readFileSync(res.tempFilePaths[0], 'base64') 
        //console.log(base64)
      }
    })
  },
  // format
  format(e) {
    let {
      name,
      value
    } = e.target.dataset
    if (!name) return
    // console.log('format', name, value)
    this.editorCtx.format(name, value)

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
    // this.setData({actionvisible:true})
    // return false;
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