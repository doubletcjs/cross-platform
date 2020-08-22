const kLoginUserToken = "LoginUserToken"
const kLoginUserID = "LoginUserID"
const kLoginUserInfo = "LoginUserInfo"
const kAppDownload = "AppDownload"
const kLastAppVersion = "LastAppVersion"
const kCurrentAppVersion = "CurrentAppVersion"

const kAppVsersionInfo = "AppVsersionInfo"

const kLoginTime = "loginTime"

const moreContentText = {
	contentdown: "点击加载更多",
	contentrefresh: "正在加载...",
	contentnomore: "没有更多"
}

function appVersionInfo() {
	return uni.getStorageSync(kAppVsersionInfo)
}

function recordAppVersionInfo(info) {
	uni.setStorageSync(kAppVsersionInfo, info)
}

function currentAppVersion() {
	return uni.getStorageSync(kCurrentAppVersion)
}

function recordCurrentAppVersion(version) {
	uni.setStorageSync(kCurrentAppVersion, version)
}

function lastAppVersion() {
	return uni.getStorageSync(kLastAppVersion)
}

function recordLastAppVersion(version) {
	uni.setStorageSync(kLastAppVersion, version)
}

function token() {
	return uni.getStorageSync(kLoginUserToken)
	// return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1ODYwNzMwNjMsInVzZXJuYW1lIjoiMTUyMTcyMjQ5ODUifQ.SN5-ampR5Vh1aiE3GFY3hCL3AdnY0lvDZiCeUl14wzg"
}

function recordToken(token) {
	console.log("记录token")
	uni.setStorageSync(kLoginUserToken, token)
}

function userID() { 
	return uni.getStorageSync(kLoginUserID)
	// return "3805"
}

function recordUserID(userID) {
	uni.setStorageSync(kLoginUserID, userID)
}

function recordUserInfo(info) {
	if (info != null && emptyObject(userID()) == true) {
		recordUserID(info["guid"])
	}

	uni.setStorageSync(kLoginUserInfo, info)
}

// 保存用户登录时间
function recordLoginTime() {
	var time = new Date().getTime();
	uni.setStorageSync(kLoginTime, time)	
}

// 得到用户登录时间
function getLoginTime() {
	return uni.getStorageSync(kLoginTime)
}

function clearLoginTime() {
	uni.setStorageSync(kLoginTime, '')
}


function userInfo() {
	return uni.getStorageSync(kLoginUserInfo)
}

function appDownload() {
	return uni.getStorageSync(kAppDownload)
}

function recordAppDownload(url) {
	uni.setStorageSync(kAppDownload, url)
}

function validateMobile(phone) {
	var translatematrixREa = /^1[3-9]\d{9}$/
	var matrix = translatematrixREa.test(phone)
	//如果手机号码不能通过验证

	return matrix
}

function validateIDCardNumber(idcard) {
	var num = idcard.toUpperCase()
	//身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X。   
	if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(num))) {
		return false
	}
	//校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
	//下面分别分析出生日期和校验位 
	var len, re
	len = num.length
	if (len == 15) {
		re = new RegExp(/^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/)
		var arrSplit = num.match(re)

		//检查生日日期是否正确 
		var dtmBirth = new Date('19' + arrSplit[2] + '/' + arrSplit[3] + '/' + arrSplit[4])
		var bCorrectDay
		bCorrectDay = (dtmBirth.getYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) &&
			(
				dtmBirth.getDate() == Number(arrSplit[4]))
		if (!bCorrectDay) {
			return false
		} else {
			//将15位身份证转成18位 
			//校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
			var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2)
			var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2')
			var nTemp = 0,
				i
			num = num.substr(0, 6) + '19' + num.substr(6, num.length - 6)
			for (i = 0; i < 17; i++) {
				nTemp += num.substr(i, 1) * arrInt[i]
			}
			num += arrCh[nTemp % 11]
			return true
		}
	}

	if (len == 18) {
		re = new RegExp(/^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/)
		var arrSplit = num.match(re)

		//检查生日日期是否正确 
		var dtmBirth = new Date(arrSplit[2] + "/" + arrSplit[3] + "/" + arrSplit[4])
		var bCorrectDay
		bCorrectDay = (dtmBirth.getFullYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) &&
			(dtmBirth.getDate() == Number(arrSplit[4]))
		if (!bCorrectDay) {
			return false
		} else {
			//检验18位身份证的校验码是否正确。 
			//校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
			var valnum
			var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2)
			var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2')
			var nTemp = 0,
				i
			for (i = 0; i < 17; i++) {
				nTemp += num.substr(i, 1) * arrInt[i]
			}
			valnum = arrCh[nTemp % 11]

			if (valnum != num.substr(17, 1)) {
				return false
			}

			return true
		}
	}

	return false
}

function alidateTaiwanIdcard(idcard) {
	var translatematrixREa = /^[a-zA-Z][0-9]{9}$/
	var taiwan = translatematrixREa.test(idcard)
	if (taiwan == false) {
		// 台湾身份证
		return false
	}

	var area = {
		'A': 10,
		'B': 11,
		'C': 12,
		'D': 13,
		'E': 14,
		'F': 15,
		'G': 16,
		'H': 17,
		'J': 18,
		'K': 19,
		'L': 20,
		'M': 21,
		'N': 22,
		'P': 23,
		'Q': 24,
		'R': 25,
		'S': 26,
		'T': 27,
		'U': 28,
		'V': 29,
		'X': 30,
		'Y': 31,
		'W': 32,
		'Z': 33,
		'I': 34,
		'O': 35
	}

	var idcard_array = new Array()
	idcard_array = idcard.split("")

	var jym = parseInt(area[idcard_array[0]] / 10) + 9 * (area[idcard_array[0]] % 10) + 8 * idcard_array[1] + 7 *
		idcard_array[2] + 6 * idcard_array[3] + 5 * idcard_array[4] + 4 * idcard_array[5] + 3 * idcard_array[6] + 2 *
		idcard_array[7] + 1 * idcard_array[8]

	jym = (10 - jym % 10) % 10

	if (idcard_array[9] == jym) {
		return true
	} else {
		return false
	}
}

function logout() {
	recordToken(null)
	recordUserID(null)
	recordUserInfo(null)
	clearLoginTime()

	uni.reLaunch({
		url: "/pages/account/loginregister/loginregister"
	})
}

function emptyObject(obj) {
	if (typeof obj == "string") {
		if (obj == "" || obj.length == 0) {
			return true
		}
	}
	
	if (obj == undefined || obj == null) {
		return true
	} else {
		return false
	}
}

function formatNumber(obj) {
	if (parseFloat(obj) > 0.0) {
		var test1 = String(parseFloat(obj).toFixed(2))
		var format = test1.replace(/\B(?=(\d{3})+(?!\d))/g, ',')

		return format
	} else {
		return 0.0
	}
}

function getClientHeight() {
	let that = this;
	var height = 0.0
	uni.getSystemInfo({
		success(res) {
			console.log(res.screenHeight); //获取手机设备屏幕高度
			console.log(res.windowBottom, res); //获取手机设备屏幕高度 windowHeight
			height = ((res.windowHeight) - 98) + 'px';
		}
	})
	return height
}

function getClientHeight4USDT() {
	let that = this;
	var height = 0.0
	uni.getSystemInfo({
		success(res) {
			console.log(res.screenHeight); //获取手机设备屏幕高度
			console.log(res.windowHeight);
			console.log(res.windowBottom, res); //获取手机设备屏幕高度 windowHeight
			height = ((res.windowHeight) - 78) + 'px'; // 自己算出来的
		}
	})
	
	return height
}

// 版本号转换，比如2.5.0转为250
function getIntVersionName(string_version) {

	// let sb = ""
	// for (let i = 0; i < string_version.length; i++) {
	// 	let c = string_version.charAt(i)
	// 	if (i != 1 && i != 3) {
	// 		sb = sb.concat(c)
	// 	}
	// }
	// let versionName = parseInt(sb)
	
	// 连续替换掉.
	let versionName = string_version.replace('.','');
	versionName = versionName.replace('.','');
	
	return versionName

}

// true 要更新  false 不更新
function getIntVersionName2(serverAppVerson, localAppVerson) {

	// serverAppVerson = "99.99.100"
	// localAppVerson = "99.99.99"
	let serverArray = serverAppVerson.split(".")
	let localArray = localAppVerson.split(".")
	
	// console.log(serverArray[0] + " " + serverArray[1] + " " + serverArray[2])
	// console.log(localArray[0] + " " + localArray[1] + " " + localArray[2])
	
	if(parseInt(serverArray[0]) > parseInt(localArray[0])) {
		// console.log(parseInt(serverArray[0]) + " 111 " + parseInt(localArray[0]))
		// console.log(parseInt(serverArray[0]) > parseInt(localArray[0]));
		return true
	} 
	
	if(parseInt(serverArray[1]) > parseInt(localArray[1])) {
		// console.log(parseInt(serverArray[1]) + " 222 " + parseInt(localArray[1]));
		// console.log(parseInt(serverArray[1]) > parseInt(localArray[1]));
		return true
	} 
	
	if(parseInt(serverArray[2]) > parseInt(localArray[2])) {
		// console.log(parseInt(serverArray[2]) + " 333 " + parseInt(localArray[2]));
		// console.log(parseInt(serverArray[2]) > parseInt(localArray[2]));
		return true
	}
	
	return false

}

module.exports = {
	token: token,
	recordToken: recordToken,
	userID: userID,
	userInfo: userInfo,
	recordUserID: recordUserID,
	recordUserInfo: recordUserInfo,
	validateMobile: validateMobile,
	moreContentText: moreContentText,
	logout: logout,
	emptyObject: emptyObject,
	appDownload: appDownload,
	recordAppDownload: recordAppDownload,
	formatNumber: formatNumber,
	validateIDCardNumber: validateIDCardNumber,
	alidateTaiwanIdcard: alidateTaiwanIdcard,
	lastAppVersion: lastAppVersion,
	recordLastAppVersion: recordLastAppVersion,
	currentAppVersion: currentAppVersion,
	recordCurrentAppVersion: recordCurrentAppVersion,
	getClientHeight: getClientHeight,
	getClientHeight4USDT: getClientHeight4USDT,
	getIntVersionName: getIntVersionName,
	getIntVersionName2: getIntVersionName2,
	appVersionInfo: appVersionInfo,
	recordAppVersionInfo: recordAppVersionInfo,
	recordLoginTime: recordLoginTime,
	getLoginTime: getLoginTime
}
