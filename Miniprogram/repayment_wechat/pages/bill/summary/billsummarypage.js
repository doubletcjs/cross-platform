//Page Object

Page({
    data: {
        dataList: [],
        isUnfold: true,
    },
    //options(Object)
    onLoad: function (options) {
        let array = this.data.dataList;
        if (array.length == 0) {
            for (let index = 0; index < 30; index++) {
                array.push("");
            }

            this.setData({
                dataList: array,
            });
        }
    },
    onReady: function () {

    },
    onShow: function () {

    },
    onHide: function () {

    },
    onUnload: function () {

    },
    onPullDownRefresh: function () {

    },
    onReachBottom: function () {

    },
    onShareAppMessage: function () {

    },
    onPageScroll: function () {

    },
    //item(index,pagePath,text)
    onTabItemTap: function (item) {

    },
    unfoldAction: function () {
        this.setData({
            isUnfold: !this.data.isUnfold
        })
    }
});