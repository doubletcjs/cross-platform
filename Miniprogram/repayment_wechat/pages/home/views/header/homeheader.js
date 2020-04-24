//Component Object
Component({
    properties: {
        myProperty: {
            type: String,
            value: '',
            observer: function () {}
        },

    },
    data: {

    },
    methods: {
        billCreation: function () {
            wx.navigateTo({
                url: '../bill/creation/billcreationpage',
                success: (result) => {

                },
                fail: () => {},
                complete: () => {}
            });
        },
        billSummary: function () {
            wx.navigateTo({
                url: '../bill/summary/billsummarypage',
                success: (result) => {

                },
                fail: () => {},
                complete: () => {}
            });
        },
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