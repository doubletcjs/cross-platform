//app.js
import util from "/utils/util";

App({
    onLaunch: function () {
        // 检查登录状态
        wx.checkSession({
            success: (result) => {
                //session_key 未过期，并且在本生命周期一直有效
                console.log("session_key 未过期");
                util.authorizeFunction();
            },
            fail: () => {
                // session_key 已经失效，需要重新执行登录流程
                console.log("session_key 已经失效");
                // 登录
                wx.login({
                    success: (res) => {
                        // 发送 res.code 到后台换取 openId, sessionKey, unionId
                        console.log("login:" + JSON.stringify(res));
                        util.authorizeFunction();
                    },
                });
            },
            complete: () => {},
        });
    },
    globalData: {
        userInfo: null,
    },
});