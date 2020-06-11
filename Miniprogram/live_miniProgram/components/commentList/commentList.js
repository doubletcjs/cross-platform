// components/commentList/commentList.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    showType: {
      type: Number, // 0 评论列表使用  1 评论详情界面使用
      value: 0
    },
    // 评论列表
    commentList: {
      type: Array,
      value: []
    }
  },

  /**
   * 组件的初始数据
   */
  data: {
    visible: false, // 分享弹框控制
  },

  /**
   * 组件的方法列表
   */
  methods: {

    // 分享
    share() {
      console.log('share')
      this.setData({
        visible: true
      })
    },
    // 分享对话框关闭
    shareClose() {
      this.setData({
        visible: false
      })
    },

    // item点到事件 
    toCommentDetail(e) {

      console.log("评论类型 " + this.data.showType);
      
      if (this.data.showType === 0) { // 跳到评论详情

        const id = e.currentTarget.dataset.id
        const url = "/pages/main/community/commentDetail/index?id=" + id

        console.log("id = " + id);

        wx.navigateTo({
          url: url,
        })
      } else { // 评论详情评论列表整个item点击操作

        let index = e.currentTarget.dataset.index
        let state = {
          index: index,
          showType: this.data.showType,
          copyContent: this.data.commentList[index].commentContent
        }
        console.log("评论详情评论列表整个item点击操作 " + index + " " + JSON.stringify(state))
        this.triggerEvent('commentListItemHandle', state)
        
      }

    },

    // 跳转到转发
    transmit(e) {
      console.log('长文缩略 transmit')

      this.setData({
        visible: true
      })
    },



    // 评论
    comment(e) {
      console.log('长文缩略 comment')
      let index = e.currentTarget.dataset.index;
      let state = {
        index: index
      }
      this.triggerEvent('itemComment', state)
    },

    // 点赞
    give(e) {
      let index = e.currentTarget.dataset.index;
      let giveNum = this.data.commentList[index].praise + 1;
      let state = {
        index: index,
        giveNum: giveNum
      }
      this.triggerEvent('itemPraise', state)
      // console.log('give',e,index,giveNum)
    },
  }
})