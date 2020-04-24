//Page Object
Page({
    data: {
        tabList: ["还款中", "已还清", "全部"],
        dataList: [],
        currentIndex: 0,
        styleDataList: [],
        startX: "",
        delBtnWidth: 160
    },
    //options(Object)
    onLoad: function (options) {
        let dataList = this.data.dataList;
        let styleList = this.data.styleDataList;
        for (let index = 0; index < 20; index++) {
            dataList.push("a");
            styleList.push("left:0rpx");
        }

        this.setData({
            dataList: dataList,
            styleDataList: styleList,
        });
    },
    onReady: function () {},
    onShow: function () {
        let array = this.data.styleDataList;
        for (let index = 0; index < array.length; index++) {
            let style = "left:0rpx";
            array[index] = style;
        }

        this.setData({
            styleDataList: array,
        });
    },
    onHide: function () {},
    onUnload: function () {},
    onPullDownRefresh: function () {},
    onReachBottom: function () {},
    onShareAppMessage: function () {},
    onPageScroll: function () {},
    //item(index,pagePath,text)
    onTabItemTap: function (item) {},
    tabEventListener: function (res) {
        let index = res.detail.index;
        this.setData({
            currentIndex: index,
        });

        if (index == 1) {
            this.setData({
                dataList: [],
            });
        } else {
            this.setData({
                dataList: [
                    "还款中",
                    "已还清",
                    "全部",
                ],
                styleDataList: [
                    "",
                    "",
                    "",
                ],
            });
        }
    },
    billDetail: function (res) {
        let array = this.data.styleDataList;
        for (let index = 0; index < array.length; index++) {
            let style = "left:0rpx";
            array[index] = style;
        }

        this.setData({
            styleDataList: array,
        });

        let index = res.currentTarget.dataset.index;
        wx.navigateTo({
            url: "../detail/billdetailpage",
            success: (result) => {},
            fail: () => {},
            complete: () => {},
        });
    },
    billDelete: function (res) {
        let index = res.currentTarget.dataset.index;
        wx.showModal({
            title: '提示',
            content: '确定要删除这个记录吗？',
            showCancel: true,
            cancelText: '取消',
            cancelColor: '#000000',
            confirmText: '确定',
            confirmColor: '#3CC51F',
            success: (result) => {
                if (result.confirm) {
                    let dataList = this.data.dataList;
                    let styleList = this.data.styleDataList;

                    dataList.splice(index, 1);
                    styleList.splice(index, 1);
                    this.setData({
                        dataList: dataList,
                        styleDataList: styleList,
                    })
                }
            },
            fail: () => {},
            complete: () => {}
        });
    },
    touchS: function (e) {
        if (e.touches.length == 1) {
            this.setData({
                //设置触摸起始点水平方向位置
                startX: e.touches[0].clientX
            });
        }
    },
    touchM: function (e) {
        if (e.touches.length == 1) {
            //手指移动时水平方向位置
            var moveX = e.touches[0].clientX;
            //手指起始点位置与移动期间的差值
            var disX = this.data.startX - moveX;
            var style = "";
            if (disX == 0 || disX < 0) { //如果移动距离小于等于0，说明向右滑动，文本层位置不变
                style = "left:0rpx";
            } else if (disX > 0) { //移动距离大于0，文本层left值等于手指移动距离
                style = "left:-" + disX + "rpx";
                if (disX >= this.data.delBtnWidth) {
                    //控制手指移动距离最大值为删除按钮的宽度
                    style = "left:-" + this.data.delBtnWidth + "rpx";
                }
            }
            //获取手指触摸的是哪一项
            var index = e.currentTarget.dataset.index;
            var list = this.data.styleDataList;
            list[index] = style;
            //更新列表的状态
            this.setData({
                styleDataList: list
            });
        }
    },
    touchE: function (e) {
        if (e.changedTouches.length == 1) {
            //手指移动结束后水平位置
            var endX = e.changedTouches[0].clientX;
            //触摸开始与结束，手指移动的距离
            var disX = this.data.startX - endX;
            //如果距离小于删除按钮的1/2，不显示删除按钮
            var style = disX > this.data.delBtnWidth / 2 ? "left:-" + this.data.delBtnWidth + "rpx" : "left:0rpx";
            //获取手指触摸的是哪一项
            var index = e.currentTarget.dataset.index;
            var list = this.data.styleDataList;
            list[index] = style;
            //更新列表的状态
            this.setData({
                styleDataList: list
            });
        }
    }
});