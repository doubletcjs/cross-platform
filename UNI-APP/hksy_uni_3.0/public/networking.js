import util from "./public.js"

// 版本号，用于h5
const currentVersion = "2.8.3"

// 测试
const isTest = true; // true 测试环境 用于aboutus查看版本号和地址，只针对android app.hkicloud.com  39.100.54.18  
const kServerURL = "http://39.100.54.18:4008/tbr"  
const kQrcodeURL = "http://39.100.54.18:4008"
// 开发
// const kServerURL = "http://192.168.2.165:4008/tbr"
// const kQrcodeURL = "http://192.168.2.165:4008"


// 正式
// const isTest = false;
// const kServerURL = "http://app.hkicloud.com/tbr"   // 迁移后的地址
// const kQrcodeURL = "http://app.hkicloud.com"
// const kServerURL = "http://47.75.87.108/tbr" // 迁移前的地址
// const kQrcodeURL = "http://47.75.87.108" 

function _emptyObject(obj) {
	if (obj == undefined || obj == null || obj == "" || obj.length == 0) {
		return true
	} else {
		return false
	}
}

// isShow 是否显示showToast，默认是true  showTime showToast显示时间
function functionRequest(api = "", method = null, params = null, header = null, completion, isShow = true, showTime = 1500) {
	if (_emptyObject(api) == true) {
		if (completion != null) {
			completion(null, "接口名称不能为空")
		}

		return
	}
	// console.log(" isShow " + isShow);
	var reqHeader = {
		"charset": "utf-8",
		"Content-Type": "application/x-www-form-urlencoded"
	}

	if (_emptyObject(method) == true) {
		method = "POST"
	}

	if (_emptyObject(params) == true) {
		params = {}
	}

	if (_emptyObject(header)) {
		header = {}
	}

	for (var key in header) {
		var value = header[key]
		reqHeader[key] = value
	}

	if (_emptyObject(reqHeader["token"]) == true && _emptyObject(util.token()) == false) {
		reqHeader["token"] = util.token()
	}

	uni.request({
		url: kServerURL + api,
		method: method,
		header: reqHeader,
		data: params,
		success(res) { 
			var data = res.data
			var code = _emptyObject(data.state) == false ? data.state : ""
			if (_emptyObject(data.code) == false) {
				code = data.code
			}

			if (code == "200") {
				if (typeof data == "string") {
					if (completion != null) {
						completion(data, null)
					}
				} else {
					if (_emptyObject(data.token) == false) {
						var token = data.token
						util.recordToken(token)
					}

					if (_emptyObject(data.msg) == false && _emptyObject(data.data) == true) {
						data = data.msg
					} else {
						data = data.data
					}

					if (completion != null) {
						completion(data, null)
					}
				}
			} else {
				console.log("header:" + JSON.stringify(reqHeader))
				console.log("params:" + JSON.stringify(params))
				console.log("method:" + method)
				console.log("url:" + kServerURL + api)
				console.log("code:" + code)
				// console.log("原始数据:" + JSON.stringify(data))

				if (_emptyObject(code) == true) {
					if (completion != null) {
						completion(null, "未知状态码")
					}
					uni.showToast({
						title: "未知状态码"
					})
				} else if (code == "1") {
					//token过期，强制退出，重新登录
					util.logout()
				} else {
					var msg = data.msg
					if (_emptyObject(msg) == true) {
						msg = "未知错误"
					}

					if (completion != null) {
						completion(null, msg)
					}

					if(isShow) {
						uni.showToast({
							title: msg,
							icon: "none",
							duration: showTime
						})
					}
				}
			}
		},
		fail(error) {
			uni.showToast({
				title: error.errMsg,
				icon: "none"
			})

			if (completion != null) {
				completion(null, error.errMsg)
			}
		}
	})
}

function functionMultipleUpload(filePaths, completion) {
	if (_emptyObject(filePaths) == true || filePaths.length == 0) {
		if (completion != null) {
			completion(null, "文件路径不能为空！")
		}

		return
	}

	var current = 0
	var urlList = []

	function singleUpload() {
		if (current <= filePaths.length - 1) {
			console.log("第" + (current + 1) + "个文件上传中...")
		}

		functionUpload(filePaths[current], {}, (url, msg) => {
			if (url != null) {
				urlList.push(url)
				if (current == filePaths.length - 1) {
					completion(urlList, null)
				} else {
					current += 1
					singleUpload()
				}
			} else {
				if (completion != null) {
					completion(urlList, "上传失败，请稍后再试！")
				}
			}
		})
	}

	singleUpload()
}

function functionUpload(filePath, params, completion) {
	if (_emptyObject(filePath) == true) {
		if (completion != null) {
			completion(null, "文件路径不能为空！")
		}

		return
	}

	var reqHeader = {
		"charset": "utf-8",
	}

	if (_emptyObject(util.token()) == false) {
		reqHeader["token"] = util.token()
	}

	if (_emptyObject(params) == true) {
		params = {}
	}

	const uploadTask = uni.uploadFile({
		url: kServerURL + "/uploadImg",
		name: "file",
		filePath: filePath,
		formData: params,
		header: reqHeader,
		success: (res) => {
			var data = JSON.parse(res.data)
			var code = _emptyObject(data.state) == false ? data.state : ""
			if (_emptyObject(data.code) == false) {
				code = data.code
			}
			if (code == "200") { 
				var url = data.data
				if (_emptyObject(url) == false) {
					if (completion != null) {
						completion(url, null)
					}
				} else {
					if (completion != null) {
						completion(null, "上传失败！")
					}
				}
			} else {
				if (completion != null) {
					completion(null, "返回url为空！")
				}

				console.log("filePath:" + filePath)
				console.log("header:" + JSON.stringify(reqHeader))
				console.log("params:" + JSON.stringify(params))
				console.log("url:" + kServerURL + "/uploadImg")
				console.log("原始数据:" + JSON.stringify(data))
			}
		},
		fail: (error) => {
			uni.showToast({
				title: error.errMsg,
				icon: "none"
			})

			if (completion != null) {
				completion(null, error.errMsg)
			}
		}
	})

	uploadTask.onProgressUpdate((res) => {
		console.log('上传进度' + res.progress);
	});
}



function request_class(url, data, cb) {
	/* var time = new Date().getTime();
	data.time = time;
	var sign = getSign(data);
	data.sign = sign; */
	const token = uni.getStorageSync('token');
	// uni.showLoading({
	// 	title: '加载中',
	// })
	// console.log('token----:',token)
	uni.request({
		url: kServerURL + url,
		data: data,
		method: 'POST',
		header: {
			"content-type": "application/x-www-form-urlencoded",
			"token": token
		}, // 设置请求的 header
		success: function (res) {
			// uni.hideLoading();
			cb(res, null);
		},
		fail: function (error) {
			// uni.hideLoading();
			uni.showToast({
				title: '请求失败',
				duration: 2000,
				icon: "none"
			});
		}
	})

}

// 开放方法
module.exports = {
	currentVersion: currentVersion,
	isTest: isTest,
	functionRequest: functionRequest,
	kServerURL: kServerURL,
	kQrcodeURL: kQrcodeURL,
	functionUpload: functionUpload,
	functionMultipleUpload: functionMultipleUpload,
	request_class: request_class
}