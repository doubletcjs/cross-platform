//Component Object
Component({
    properties: {
        myProperty: {
            type: String,
            value: "",
            observer: function () {},
        },
    },
    data: {
        itemList: ["账单金额", "还款期限", "还款周期"],
    },
    methods: {
        moreAction: function () {
            wx.showActionSheet({
                itemList: ['编辑', '删除'],
                success: function (res) {
                    if (res.tapIndex == 0) {
                        wx.navigateTo({
                            url: '../creation/billcreationpage',
                            success: (result) => {

                            },
                            fail: () => {},
                            complete: () => {}
                        });
                    } else if (res.tapIndex == 1) {

                    }
                },
                fail: function (res) {
                    console.log(res.errMsg);
                }
            });
        }
    },
    created: function () {},
    attached: function () {},
    ready: function () {},
    moved: function () {},
    detached: function () {},
});