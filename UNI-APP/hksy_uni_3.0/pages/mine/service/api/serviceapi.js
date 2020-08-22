import networking from "../../../../public/networking.js"

// 生成合同
function createContract(userId, completion) {
	networking.functionRequest("/createContract", null, {
		"userId": userId
	}, null, completion)
}

// 合同列表(分页)
function getContractDetail(userId, page, limit, completion) {
	networking.functionRequest("/getContractDetail", null, {
		"userId": userId,
		"current": page,
		"size": limit
	}, null, completion)
}

module.exports = {
	createContract: createContract,
	getContractDetail: getContractDetail
}
