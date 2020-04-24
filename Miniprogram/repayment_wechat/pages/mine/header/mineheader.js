//Component Object
const app = getApp();

Component({
    properties: {},
    data: {
        userInfo: null,
    },
    methods: {
        goLogin: function () {
            if (this.data.userInfo == null) {
                wx.navigateTo({
                    url: "../account/loginpage",
                    success: (result) => {},
                    fail: () => {},
                    complete: () => {},
                });
            }
        },
    },
    created: function () {},
    attached: function () {},
    ready: function () {},
    moved: function () {},
    detached: function () {},
    pageLifetimes: {
        // 组件所在页面的生命周期函数
        show: function () {
            if (app.globalData.userInfo) {
                this.setData({
                    userInfo: app.globalData.userInfo,
                });
            }
        },
        hide: function () {},
        resize: function () {},
    },
});