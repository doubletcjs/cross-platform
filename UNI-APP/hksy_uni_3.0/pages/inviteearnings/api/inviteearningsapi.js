import networking from "../../../public/networking.js"
 
//邀请收益
function getEarningsForUser(userId, completion) {
	networking.functionRequest("/getEarningsForUser", null, {
		"userId": userId
	}, null, (data, msg) => {
		if (completion != null) {
			completion(data, msg)
		}
	})
}

// 邀请收益明细(分页)
function getEarningsDetailForUser(userId, page, limit, completion) {
	networking.functionRequest("/getEarningsDetailForUser", null, {
		"userId": userId,
		"page": page,
		"limit": limit
	}, null, completion)
}

// 邀请收益明细我的好友(分页)
function getMyFriend(userId, page, limit, completion) {
	networking.functionRequest("/getMyFriend", null, {
		"userId": userId,
		"page": page,
		"limit": limit
	}, null, completion)
}

module.exports = {
	getEarningsForUser: getEarningsForUser,
	getEarningsDetailForUser: getEarningsDetailForUser,
	getMyFriend: getMyFriend
}