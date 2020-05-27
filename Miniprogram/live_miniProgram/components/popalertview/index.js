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
        //展示的标题
        titleString: {
            type: String,
            value: ''
        },
        //展示的内容
        contentString: {
            type: String,
            value: ''
        },
        //展示的标题颜色
        titleStringColor: {
            type: String,
            value: "rgba(53, 53, 53, 0.9)"
        },
        //展示的内容颜色
        contentStringColor: {
            type: String,
            value: "#B2B2B2"
        },
        //取消（左侧）按钮文字
        cancelString: {
            type: String,
            value: "取消"
        },
        //确定（右侧）按钮文字
        confirmString: {
            type: String,
            value: "确定"
        },
        //取消（左侧）按钮文字颜色
        cancelTextColor: {
            type: String,
            value: "rgba(23, 96, 255, 1)"
        },
        //确定（右侧）按钮文字颜色
        confirmTextColor: {
            type: String,
            value: "rgba(53, 53, 53, 1)"
        },
        //只显示，取消（左侧）按钮 100%
        onlyToast: {
            type: Boolean,
            value: false
        },
        //背景颜色
        backgroundColor: {
            type: String,
            value: "rgba(255, 255, 255, 1)"
        }
    },
    data: {

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
        //取消（左侧）按钮动作
        cancelAction() {
            this.closePopup()
            setTimeout(() => {
                this.triggerEvent("cancel")
            }, 400)
        },
        //确定（右侧）按钮动作
        confirmAction() {
            this.closePopup();
            setTimeout(() => {
                this.triggerEvent("confirm")
            }, 400)
        },
        //居中弹框屏蔽外部遮罩层关闭动作
        emptyAction() {},
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