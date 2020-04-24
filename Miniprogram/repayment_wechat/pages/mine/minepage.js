//Page Object
const app = getApp();

Page({
    data: {
        mineBillList: ["还款提醒", "账单目录"],
        mineSettingList: ["意见反馈", "设置"],
        noticeAlert: false,
        userInfo: null,
    },
    //options(Object)
    onLoad: function (options) {
        this.refreshAccount();
    },
    onReady: function () {
        this.refreshAccount();
    },
    onShow: function () {
        this.refreshAccount();
    },
    onHide: function () {},
    onUnload: function () {},
    onPullDownRefresh: function () {},
    onReachBottom: function () {},
    onShareAppMessage: function () {},
    onPageScroll: function () {},
    //item(index,pagePath,text)
    onTabItemTap: function (item) {},
    noticeAlertAction: function () {
        if (this.data.userInfo != null) {
            this.setData({
                noticeAlert: this.data.noticeAlert == true ? false : true,
            });

            wx.setStorageSync("kNoticeAlertStatus", this.data.noticeAlert);
        }
    },
    cellTapAction: function (res) {
        let index = res.currentTarget.dataset.index;
        switch (index) {
            case 1:
                if (this.data.userInfo == null) {
                    wx.navigateTo({
                        url: "../account/loginpage",
                        success: (result) => {},
                        fail: () => {},
                        complete: () => {},
                    });
                } else {
                    wx.navigateTo({
                        url: "../bill/catalog/billcatalogpage",
                        success: (result) => {},
                        fail: () => {},
                        complete: () => {},
                    });
                }

                break;
            case 2:
                wx.navigateTo({
                    url: "../mine/feedback/feedbackpage",
                    success: (result) => {},
                    fail: () => {},
                    complete: () => {},
                });
                break;
            case 3:
                wx.navigateTo({
                    url: "../mine/setting/settingpage",
                    success: (result) => {},
                    fail: () => {},
                    complete: () => {},
                });
                break;

            default:
                break;
        }
    },
    refreshAccount: function () {
        if (app.globalData.userInfo) {
            this.setData({
                userInfo: app.globalData.userInfo,
            });

            if (wx.getStorageSync("kNoticeAlertStatus").length == 0) {
                this.setData({
                    noticeAlert: true,
                });
                wx.setStorageSync("kNoticeAlertStatus", this.data.noticeAlert);
            } else {
                this.setData({
                    noticeAlert: wx.getStorageSync("kNoticeAlertStatus"),
                });
            }
        }
    },
});