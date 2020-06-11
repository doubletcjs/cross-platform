// components/articleLists/index.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    // 文章列表数据
    articleLists: {
      type: Array,
      value: []
    },
    // 是否显示关注按A钮 ( 个人主页   )
    isAttention:{
      type:Boolean,
      value:true
    },
    // 是否显示阅读量按钮  (在个人主页 （自己的）显示，其他人的个人主页不需要显示)
    isShowAttention:{
      type:Boolean,
      value:false
    }
  },

  /**
   * 组件的初始数据
   */
  data: {
    visible: false, // 分享弹框控制
    showAnimate:[] // 点赞动画控制列表
  },
  // attached
  attached(){
    let arr = this.data.articleLists;
    let animateArr = [];
    for(let i=0;i<arr.length;i++){
      animateArr.push(false)
    }
    this.setData({showAnimate:animateArr});
    // console.log('showAnimate=',this.data.showAnimate)
  },
  /**
   * 组件的方法列表
   */
  methods: {
    // 跳到文章缩略界面
    toThumbArticle(e) {
      const id = e.currentTarget.dataset.id
      let showType = 2 // (type ==0 文章 type==1 话题  type==2 评论)
      wx.navigateTo({
        url: '/pages/main/community/lookArticle/thumbnail/index?id=' + "&showType=" + showType
      })
    },

    // 跳转到转发
    transmit() {
      console.log('transmit')
      wx.navigateTo({
        url:'/pages/main/community/longArticleDetails/transmitArticle/index'
      })
    },
    // 跳转评论
    comment() {
      console.log('comment')
      wx.navigateTo({
        url:'/pages/main/community/lookArticle/thumbnail/index'
      })
    },
    // 点赞
    give(e) {
      let index = e.currentTarget.dataset.index;
      let giveNum = this.data.articleLists[index].giveNum + 1;
      let state = {
        index: index,
        giveNum: giveNum
      }
      this.triggerEvent('giveNumChange', state)

      // 设置动画
      let showAnimate = this.data.showAnimate;
      showAnimate[index] = !this.data.showAnimate[index];
      this.setData({showAnimate:showAnimate})

      setTimeout(()=>{
        showAnimate[index] = false;
        this.setData({showAnimate:showAnimate})
      },1000)

      // console.log('give',e,index,giveNum)
    },
    // 分享
    share() {
      console.log('share')
      this.setData({
        visible: true
      })
    },
    shareclose() {
      this.setData({
        visible: false
      })
    },
    // 关注
    attention(e) {
      let index = e.target.dataset.index;
      let attention = !this.data.articleLists[index].attention;
      let state = {
        index: index,
        attention: attention
      }
      this.triggerEvent('attentionChange', state)

      // console.log(e,index,state)
    }
  }
})