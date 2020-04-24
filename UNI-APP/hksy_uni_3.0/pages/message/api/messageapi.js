import networking from "../../../public/networking.js"
 
// 热销榜
function getNoticeDetail(completion) {
	networking.functionRequest("/getNoticeDetail", null, null, null, completion)
}

module.exports = {
	getNoticeDetail: getNoticeDetail
}