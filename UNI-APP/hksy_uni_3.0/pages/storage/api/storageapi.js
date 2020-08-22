import networking from "../../../public/networking.js"

// 我的存储
function getPerformanceDatas(userId, completion) {
	networking.functionRequest("/getPerformanceDatas", null, {
		"userId": userId
	}, null, completion)
}

// 个人业绩(分页)
function getPerformanceDatasList(userId, page, limit, completion) {
	networking.functionRequest("/getPerformanceDatasList", null, {
		"userId": userId,
		"current": page,
		"size": limit
	}, null, completion)
}

// 超级存储基本信息(分页)
function vipminerInfo(userId, page, limit, completion) {
	networking.functionRequest("/vipminerInfo", null, {
		"userId": userId,
		"current": page,
		"size": limit
	}, null, completion)
}

module.exports = {
	getPerformanceDatas: getPerformanceDatas,
	getPerformanceDatasList: getPerformanceDatasList,
	vipminerInfo: vipminerInfo
}