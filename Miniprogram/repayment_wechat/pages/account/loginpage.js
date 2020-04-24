//Page Object
const app = getApp();

Page({
    data: {},
    //options(Object)
    onLoad: function (options) {
        if (this.data.canIUse) {
            // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回
            // 所以此处加入 callback 以防止这种情况
            app.userInfoReadyCallback = (res) => {
                app.globalData.userInfo = res.userInfo;
            };
        } else {
            // 在没有 open-type=getUserInfo 版本的兼容处理
            wx.getUserInfo({
                success: (res) => {
                    app.globalData.userInfo = res.userInfo;
                },
            });
        }
    },
    onReady: function () {},
    onShow: function () {},
    onHide: function () {},
    onUnload: function () {},
    onPullDownRefresh: function () {},
    onReachBottom: function () {},
    onShareAppMessage: function () {},
    onPageScroll: function () {},
    //item(index,pagePath,text)
    onTabItemTap: function (item) {},
    loginAction: function (e) {
        app.globalData.userInfo = e.detail.userInfo;
        wx.navigateBack({
            delta: 1,
        });
        console.log("userInfo:" + JSON.stringify(userInfo));
    },
});