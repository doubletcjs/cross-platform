//Page Object
Page({
    data: {
        amount: "",
        itemList: ["账单名称", "首次还款日", "还款期限", "还款周期", "备忘"],
        borderBottomMax: "border-bottom: solid 20rpx rgba(249, 249, 249, 1);",
        borderBottom: "border-bottom: solid 2rpx rgba(249, 249, 249, 1);",
        itemValueList: ["", "", "", "", ""],
        limitRange: [],
        multiIndex: [0, 0],
        multiArray: [
            [],
            ["月", "天"],
        ],
    },
    //options(Object)
    onLoad: function (options) {
        let array = this.data.limitRange;
        for (let index = 0; index < 500; index++) {
            let limit = (index + 1) + "期"
            array.push(limit);
        }

        let cycleList = this.data.multiArray[0];
        for (let index = 0; index < 100; index++) {
            let cycle = "每" + (index + 1)
            cycleList.push(cycle);
        }

        let tempArray = this.data.multiArray;
        tempArray[0] = cycleList

        this.setData({
            limitRange: array,
            multiArray: tempArray,
        });
    },
    onReady: function () {},
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
    emptyCreation: function () {
        this.setData({
            itemValueList: ["", "", "", "", ""],
            multiIndex: [0, 0],
            amount: "",
        })
    },
    keyboardListener: function (res) {
        var type = res.detail.type;
        if (type == "number") {
            var amount = res.detail.data;
            this.setData({
                amount: amount,
            });
        } else {
            var msg = "";
            for (let index = 0; index < this.data.itemValueList.length - 1; index++) {
                let item = this.data.itemValueList[index];
                console.log("item:" + item);
                if (item == null || item.length == 0 || item == "") {
                    msg = "请选择" + this.data.itemList[index];
                    break;
                } else {
                    if (item.indexOf(" ") >= 0) {
                        msg = item + "内容不能带空格";
                        break;
                    }
                }
            }

            if (msg.length == 0) {
                if (this.data.amount == null || this.data.amount.length == 0 || this.data.amount == "" || parseFloat(this.data.amount).toFixed(2) == 0.0) {
                    msg = "请输入还款金额";
                }
            }

            if (msg.length > 0) {
                wx.showToast({
                    title: msg,
                    icon: 'none',
                    image: '',
                    duration: 1500,
                    mask: false,
                    success: (result) => {

                    },
                    fail: () => {},
                    complete: () => {}
                });
                return;
            }

            console.log("amount:" + parseFloat(this.data.amount).toFixed(2));
            console.log("model:" + JSON.stringify(this.data.itemValueList));
            if (type == "saveAndCreation") {
                this.emptyCreation();
            } else {
                wx.navigateBack({
                    delta: 1,
                });
            }
        }
    },
    billBank: function (res) {
        // wx.navigateTo({
        //     url: './bank/billbankselection',
        //     success: (result) => {

        //     },
        //     fail: () => {},
        //     complete: () => {}
        // });
        let array = this.data.itemValueList;
        array[0] = "中国银行"
        this.setData({
            itemValueList: array,
        });
    },
    billDateChange: function (res) {
        let date = res.detail.value;
        let array = this.data.itemValueList;
        array[1] = date
        this.setData({
            itemValueList: array,
        });
    },
    billLimitChange: function (res) {
        let limit = res.detail.value;
        let array = this.data.itemValueList;
        array[2] = (parseInt(limit) + 1).toString() + "期";

        this.setData({
            itemValueList: array,
        });
    },
    billCycleChange: function (res) {
        let array = this.data.itemValueList;
        array[3] = "每" + (res.detail.value[0] + 1) + this.data.multiArray[1][res.detail.value[1]] + "一期"
        this.setData({
            itemValueList: array,
            multiIndex: [res.detail.value[0], res.detail.value[1]],
        });
    },
    memoInput: function (res) {
        let memo = res.detail.value;
        let array = this.data.itemValueList;
        array[4] = memo
        this.setData({
            itemValueList: array,
        });
    }
});