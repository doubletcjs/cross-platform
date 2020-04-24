// pages/bill/billcreation/billkeyboard/billkeyboard.js
//Component Object
Component({
    properties: {
        inputData: {
            type: String,
            value: ""
        }
    },
    data: {
        numberList: ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "*"],
        maxLenght: 10,
    },
    methods: {
        saveAndCreationBill: function () {
            this.triggerEvent("keyboardevent", {
                "data": this.data.inputData,
                "type": "saveAndCreation",
            }); 
        },
        saveBill: function () {
            this.triggerEvent("keyboardevent", {
                "type": "save",
            });
        },
        dataAction: function (res) {
            var index = res.currentTarget.dataset.index;
            var number = this.data.numberList[index];
            if (number == "*") {
                this.setData({
                    inputData: this.data.inputData.substring(0, this.data.inputData.length - 1),
                    maxLenght: 10,
                });
            } else {
                if (this.data.inputData.indexOf(".") >= 0) {
                    if (number == ".") {
                        number = "";
                    }

                    if (this.data.maxLenght == 10) {
                        this.setData({
                            maxLenght: this.data.inputData.length + 2 > 10 ? 10 : this.data.inputData.length + 2,
                        });
                    }
                }

                if (this.data.inputData.length < this.data.maxLenght) {
                    this.setData({
                        inputData: this.data.inputData + number,
                    });
                }
            }

            // if (this.data.inputData.lastIndexOf(".") >= 0) {
            //     this.setData({
            //         inputData: this.data.inputData + "00",
            //     });
            // }

            this.triggerEvent("keyboardevent", {
                "data": this.data.inputData,
                "type": "number",
            });
        }
    },
    created: function () {},
    attached: function () {},
    ready: function () {},
    moved: function () {},
    detached: function () {},
});