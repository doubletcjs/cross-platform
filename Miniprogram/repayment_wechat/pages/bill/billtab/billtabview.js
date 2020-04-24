//Component Object
Component({
    properties: {
        tabs: {
            type: Array,
            value: [""],
            observer: function () {},
        },
        currentIndex: {
            type: Number,
            value: 0,
        },
    },
    data: {},
    methods: {
        tabSelectAction: function (res) {
            let index = res.currentTarget.dataset.index;
            this.setData({
                currentIndex: index,
            });

            this.triggerEvent("tabselectevent", {
                index: index
            }, null);
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
            console.log("tabs:" + this.data.tabs);
        },
        hide: function () {},
        resize: function () {},
    },
});