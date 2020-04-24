const formatTime = (date) => {
    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    const day = date.getDate();
    const hour = date.getHours();
    const minute = date.getMinutes();
    const second = date.getSeconds();

    return (
        [year, month, day].map(formatNumber).join("/") +
        " " + [hour, minute, second].map(formatNumber).join(":")
    );
};

const formatNumber = (n) => {
    n = n.toString();
    return n[1] ? n : "0" + n;
};

function authorizeFunction() {
    // 授权状态
    wx.getSetting({
        success: (res) => {
            if (res.authSetting["scope.userInfo"]) {
                // 已经授权，可以直接调用 getUserInfo 获取头像昵称，不会弹框
                this.getUserInfo();
            }
        },
    });
}

function getUserInfo() {
    const app = getApp();
    wx.getUserInfo({
        success: (res) => {
            // 可以将 res 发送给后台解码出 unionId
            app.globalData.userInfo = res.userInfo;

            // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回
            // 所以此处加入 callback 以防止这种情况
            if (app.userInfoReadyCallback) {
                app.userInfoReadyCallback(res);
            }

            console.log("userInfo:" + JSON.stringify(res.userInfo));
        },
    });
}

module.exports = {
    formatTime: formatTime,
    getUserInfo: getUserInfo,
    authorizeFunction: authorizeFunction,
};