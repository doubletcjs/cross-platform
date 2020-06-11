// components/articleThumbContent/atContent.js
Component({
  /**
   * 组件的属性列表
   */
  properties: {
    showType: {
      type: Number,
      value: 0, // (type ==0 文章 type==1 话题  type==2 评论)
    },
    articleContent: {
      // 文章内容
      type: Object,
      value: "",
    },
    toPicContent: {
      // 话题内容
      type: Object,
      value: "",
    },
    CommentContent: {
      // 评论内容
      type: Object,
      value: "",
    },
  },

  /**
   * 组件的初始数据
   */
  data: {},

  /**
   * 组件的方法列表
   */
  methods: {
    // 跳到文章详细
    toArticleDesc(e) {
      wx.navigateTo({
        url: "/pages/main/community/longArticleDetails/index",
      });
    },

    // 关注
    attention(e) {
      if (this.data.showType === 0) {
        let attention = !this.data.articleContent.attention;
        let articleContent = this.data.articleContent;
        articleContent.attention = attention;
        console.log("0000000000000" + attention);
        let state = {
          articleContent: articleContent,
        };
        this.triggerEvent("contentAttention", state);
      } else if(this.data.showType === 1) {

      } else if(this.data.showType === 2) {
        
      }
    },

    giveButtom(e) {
      console.log("打赏作者");
      
    }
  },


});
