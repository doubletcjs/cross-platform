import networking from "../../../public/networking.js"

function getNoChargerHkc(userId,completion) {
	networking.functionRequest("/getNoChargerHkc", null, {
		"userId": userId
	}, null, completion)
}
function getUserHkc(userId,completion) {
	networking.functionRequest("/getUserHkc", null, {
		"userId": userId
	}, null, completion)
}
function chargerHkc(param,completion) {
	networking.functionRequest("/chargerHkc", null, param, null, completion)
}

function exchangeTNumber(param,completion){
	networking.functionRequest("/exchangeTNumber", null, param, null, completion)
}
 
 module.exports = { 
	 getNoChargerHkc: getNoChargerHkc,
	 getUserHkc: getUserHkc,
	 chargerHkc: chargerHkc,
	 exchangeTNumber: exchangeTNumber
 }