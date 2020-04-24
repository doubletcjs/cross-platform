import networking from "../../../public/networking.js"

// 获取商品信息
function getProductDetail(productId, completion) {
	networking.functionRequest("/getProductDetail", null, {
		"productId": productId
	}, null, completion)
}

// 商品列表(分页) 
function getProductList(page, limit, completion) {
	networking.functionRequest("/getProductList", null, {
		"page": page,
		"limit": limit
	}, null, completion)
}

// 购买产品
function buyProduct(userId, productId, paymentCode, completion) {
	networking.functionRequest("/buyProduct", null, {
		"userId": userId,
		"productId": productId,
		"paymentCode": paymentCode
	}, null, completion)
} 

module.exports = {
	getProductDetail: getProductDetail,
	getProductList: getProductList,  
	buyProduct: buyProduct
}
