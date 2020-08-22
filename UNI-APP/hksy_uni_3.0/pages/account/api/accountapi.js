import networking from "../../../public/networking.js"

//用户基本信息
function getUserInfo(userId, completion) {
	networking.functionRequest("/getUserInfo", null, {
		"userId": userId
	}, null, (data, msg) => {
		if (completion != null) {
			completion(data, msg)
		}
	})
}

// 更新用户信息
function changeAvater(nickname, url, completion) {
	networking.functionRequest("/changeAvater", null, {
		"nickname": nickname,
		"url": url
	}, null, completion)
}

// 修改支付密码
function changePaymentCode(params, completion) {
	networking.functionRequest("/changePaymentCode", null, params, null, completion)
}

// 设置支付密码
function setPaymentCode(params, completion) {
	networking.functionRequest("/setPaymentCode", null, params, null, completion)
}

// 登录
function login(params, completion) {
	networking.functionRequest("/login", null, params, null, completion)
}

// 注册
function register(params, completion) {
	networking.functionRequest("/register", null, params, null, completion)
}

// 用户实名认证信息
function getPersonalInfo(userId, completion) {
	networking.functionRequest("/getPersonalInfo", null, {
		"userId": userId
	}, null, completion)
}

// 获取验证码
function sendMessage(phone, completion) {
	networking.functionRequest("/sendMessage", null, {
		"phone": phone
	}, null, completion)
}

// 实名认证
function authentication(params, completion) {
	networking.functionRequest("/authentication", null, params, null, completion)
}

//根据银行卡号获取银行名称
function getBankName(bankCard, completion) {
	networking.functionRequest("/getBankName", null, {
		"bankCard": bankCard
	}, null, (data, msg) => {
		if (completion != null) {
			completion(data, msg)
		}
	})
}

module.exports = {
	getUserInfo: getUserInfo,
	changeAvater: changeAvater,
	changePaymentCode: changePaymentCode,
	setPaymentCode: setPaymentCode,
	login: login,
	register: register,
	getPersonalInfo: getPersonalInfo,
	sendMessage: sendMessage,
	authentication: authentication,
	getBankName: getBankName
}