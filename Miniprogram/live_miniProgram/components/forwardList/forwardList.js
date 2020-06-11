// components/forwardList/forwardList.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    // 转发列表
    forwardList: {
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

    toForward(e) {
     
      let transmitType = true //  转发类型 false 文章转发  true 评论列表转发
      wx.navigateTo({
        url: '/pages/main/community/longArticleDetails/transmitArticle/index?transmitType=' + transmitType,
        success: function (res) {

        }
      })
    }
  }
})