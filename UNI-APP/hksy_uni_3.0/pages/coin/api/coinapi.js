import networking from "../../../public/networking.js"

// 获取当前用户的账户明细(分页)
function queryBalance(userId, page, limit, completion) {
	networking.functionRequest("/queryBalance", null, {
		"userId": userId,
		"current": page,
		"size": limit
	}, null, completion)
}

// 金币划转
function transfer(params, completion) {
	networking.functionRequest("/transfer", null, params, null, completion)
}

// 线下充值申请
function offlineRecharge(userId, voucherPath, balance, completion) {
	networking.functionRequest("/offlineRecharge", null, {
		"userId": userId,
		"voucherPath": voucherPath,
		"balance": balance
	}, null, completion)
}

// 充值明细(分页)
function queryOfflinePayDetail(userId, page, limit, completion) {
	networking.functionRequest("/queryOfflinePayDetail", null, {
		"userId": userId,
		"current": page,
		"size": limit
	}, null, completion)
}




// 提交usdt提现申请
function submitUSDTWithdraw(userId, coin_number, arrival_amount, usdt_fee, out_address, completion) {
	networking.functionRequest("/submitUSDTWithdraw", null, {
		"userId": userId,
		"coin_number": coin_number,
		"arrival_amount": arrival_amount,
		"usdt_fee": usdt_fee,
		"out_address": out_address
	}, null, completion)
}

// 提现申请
function withdrawCash(userId, cashNumber, paymentCode, completion) {
	networking.functionRequest("/withdrawCash", null, {
		"userId": userId,
		"cashNumber": cashNumber,
		"paymentCode": paymentCode
	}, null, completion)
}

// 金币划转
function giftCoinTransfer(userId, balance, completion) {
	networking.functionRequest("/giftCoinTransfer", null, {
		"userId": userId,
		"balance": balance
	}, null, completion)
}

// 超级存储——金币划转
function vipgiftCoinTransfer(userId, balance, completion) {
	networking.functionRequest("/vipgiftCoinTransfer", null, {
		"userId": userId,
		"balance": balance
	}, null, completion)
}

module.exports = {
	queryBalance: queryBalance,
	transfer: transfer,
	offlineRecharge: offlineRecharge,
	queryOfflinePayDetail: queryOfflinePayDetail,
	submitUSDTWithdraw: submitUSDTWithdraw,
	withdrawCash: withdrawCash,
	giftCoinTransfer: giftCoinTransfer,
	vipgiftCoinTransfer: vipgiftCoinTransfer
}
