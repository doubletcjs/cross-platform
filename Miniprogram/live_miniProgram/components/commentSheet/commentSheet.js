 // components/commentSheet/commentSheet.js
 Component({
   /**
    * 组件的属性列表
    */
   properties: {

     // popwin操作类型
     operationType: {
        type: Number, // 0 别人的评论操作  1 自己的评论操作
        value: 0
     } ,

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
     //取消按钮
     cancelString: {
       type: String,
       value: '取消'
     },
     //按钮列表
     items: {
       type: Array,
       value: []
     },

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
     //列表按钮动作
     listItemAction(res) {
       this.closePopup();
       setTimeout(() => {
         this.triggerEvent("itemselect", {
           index: res.target.dataset.index,
           operationType: this.data.operationType
         })
       }, 400)
     },
     //居中弹框屏蔽外部遮罩层关闭动作
     emptyAction() {},
   }
 })