import networking from "../../../public/networking.js"

// 轮播广告
function getBanners(completion) {
	networking.functionRequest("/getBanners", null, null, null, completion)
}

// 通知消息
function getNotice(completion) {
	networking.functionRequest("/getNotice", null, null, null, completion)
}

// 首页商品展示列表
function getMyAssetsDetail(userId, completion) {
	networking.functionRequest("/getMyAssetsDetail", null, {
		"userId": userId
	}, null, completion)
}

// 首页公告
function pushMsgInterface(userId, completion) {
	networking.functionRequest("/pushMsgInterface", null, {
		"userId": userId
	}, null, completion)
}

// 版本更新
function getAppVersion(completion) {
	networking.functionRequest("/getAppVersion", null, null, null, completion)
}

module.exports = {
	getBanners: getBanners,
	getNotice: getNotice,
	getMyAssetsDetail: getMyAssetsDetail,
	pushMsgInterface: pushMsgInterface,
	getAppVersion: getAppVersion
}