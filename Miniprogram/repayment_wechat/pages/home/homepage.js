//Page Object
Page({
    data: {
        dataList: [],
    },
    //options(Object)
    onLoad: function (options) {
        let array = this.data.dataList;
        if (array.length == 0) {
            for (let index = 0; index < 30; index++) {
                array.push({
                    "list": [],
                    "repayment": index == 0 ? true : false,
                });
            }

            this.setData({
                dataList: array,
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
    billCreation: function () {
        wx.navigateTo({
            url: '../bill/creation/billcreationpage',
            success: (result) => {

            },
            fail: () => {},
            complete: () => {}
        });
    }
});