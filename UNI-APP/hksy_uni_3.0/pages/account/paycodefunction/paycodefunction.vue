<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="paycode-section-wapper" v-if="isResest == true">
				<view class="paycode-cell-wapper" :style="bottomLine()">
					<view class="paycode-cell-text">
						绑定账号
					</view>
					<view class="paycode-cell-text">
						{{this.user.phone.substr(0, 3)}}****{{this.user.phone.substr(7)}}
					</view>
				</view>
				<view class="paycode-cell-wapper">
					<input type="number" id="verifycode" v-model="verifyCode" maxlength="4" placeholder-class="paycode-cell-input-placeholder"
					 placeholder="请输入验证码" class="paycode-cell-input" @input="textFieldOnchanged" />
					<view class="paycode-cell-verification" @tap="getVerifyCode">
						{{verifycodePlaceholder}}  
					</view>
				</view>
			</view>
			<view class="paycode-section-wapper">
				<view class="paycode-cell-wapper" :style="bottomLine()">
					<view class="paycode-cell-text" v-if="isResest == true">
						新的密码
					</view>
					<view class="paycode-cell-text" v-else>
						设置密码
					</view>
					<input type="number" id="password" v-model="password" password="true" maxlength="6" placeholder-class="paycode-cell-input-placeholder"
					 placeholder="请输入新的6位数支付密码" class="paycode-cell-input"  @input="textFieldOnchanged" style="text-align: right;" />
					<view class="password-view" @tap="open()"></view>
				</view>
				<view class="paycode-cell-wapper">
					<view class="paycode-cell-text">
						再次确认
					</view>
					<input type="number" id="verifypassword" v-model="verifyPassword"  password="true" maxlength="6" placeholder-class="paycode-cell-input-placeholder"
					 placeholder="再次输入新的6位数支付密码" class="paycode-cell-input" @input="textFieldOnchanged" style="text-align: right;" />
					<view class="password-view" @tap="open2()"></view>
				</view>
			</view>
			<view class="paycode-confirm" v-if="isResest == true" @tap="confirmAction">
				确认修改
			</view>
			<view class="paycode-confirm" v-else @tap="confirmAction">
				确认设置
			</view>
			<keyboard-package :disableDot="true" :type="keyboardType" @onDelete="onDelete" @onConfirm="onConfirm"  @input="inputVal" ref="keyboard"></keyboard-package>
		</view>
	</view>
</template>

<script>
	import accountapi from "../api/accountapi.js"
	import keyboardPackage from '../../../components/keyboard-package/keyboard-package.vue';
	
	
	export default {
		components:{
			keyboardPackage
		},
		data() {
			return {
				isResest: false,
				user: {},
				password: "",
				verifyPassword: "",
				verifycodePlaceholder: "获取验证码",
				verifyCode: "",
				sessionId: "",
				countDownSecond: 0,
				countingDown: false,
				keyboardType:1,
				focus:false,
				focus2:false,
				inputvalue:''
			}
		},
		methods: {
			inputVal(val){
				if(this.focus){
					if(this.password.length >= 6){
						return
					}
					this.password += val;
				}
				if(this.focus2){
					if(this.verifyPassword.length >= 6){
						return 
					}
					this.verifyPassword += val;
				}
				
			},
			open(){
				this.focus = true;
				this.focus2 = false;
				this.$refs.keyboard.open()
				// console.log(this.focus,this.focus2)
			},
			open2(){
				this.focus2 = true;
				this.focus = false;
				this.$refs.keyboard.open()
				// console.log(this.focus,this.focus2)
			},
			onConfirm(){
				if(this.password !='' && this.verifyPassword != ''){
					if(this.password != this.verifyPassword){
						uni.showToast({
							title:'两次输入密码不一致',
							icon:'none'
						})
						this.password = '';
						this.verifyPassword = '';
					}else{
						// console.log('一样的')
					}
				}
			},
			onDelete(val){
				if(this.focus){
					this.password = this.password.slice(0,this.password.length-1);
				}
				if(this.focus2){
					this.verifyPassword = this.verifyPassword.slice(0,this.verifyPassword.length-1);
				}
				console.log('val:--',this.password,this.verifyPassword)
			},
			textFieldOnchanged(res) {
				var textfieldId = res.target.id
				var textfieldText = res.target.value
				if (textfieldId == "verifycode") {
					this.verifyCode = textfieldText
				} else if (textfieldId == "verifypassword") {
					textfieldText = textfieldText.replace(/\s/g, "").replace(/[^0-9]/g, "").toUpperCase()
					this.verifyPassword = textfieldText
					setTimeout(() => {
						this.verifyPassword = textfieldText
					}, 0)
				} else if (textfieldId == "password") {
					textfieldText = textfieldText.replace(/\s/g, "").replace(/[^0-9]/g, "").toUpperCase()
					this.password = textfieldText
					setTimeout(() => {
						this.password = textfieldText
					}, 0)
				}
			},
			getVerifyCode() {
				if (this.countingDown == false) {
					if (this.util.validateMobile(this.user.phone) == false) {
						uni.showToast({
							title: "请输入正确的手机号",
							icon: "none"
						})
						
						return
					}
					
					uni.hideKeyboard()
					var me = this
					accountapi.sendMessage(this.user.phone, (data) => {
						if (data.sessionId == null || data.sessionId.length == 0) {
							uni.showToast({
								title: "获取验证码失败!",
								icon: "none"
							})
						} else {
							me.sessionId = data.sessionId
							me.util.recordAppDownload(data.appDownload)
							// 开始倒计时
							me.startCountDown()
							me.countingDown = true
						}
					})
				} 
			},
			startCountDown() {
				this.countDownSecond = 60
				this.verifycodePlaceholder = this.countDownSecond

				this.countingDownAction()
			},
			countingDownAction() {
				if (this.countDownSecond == 0) {
					this.verifycodePlaceholder = "获取验证码"
					this.countingDown = false
				} else {
					this.countDownSecond -= 1
					this.verifycodePlaceholder = this.countDownSecond + "s"

					var me = this
					setTimeout(() => {
						me.countingDownAction()
					}, 1000)
				}
			},
		
			
			isNumber(val){

			    var regNeg = /[^0-9]/g; 
			    if(regNeg.test(val)){
			        return true; // 
			    }else{
			        return false; // 纯数字
			    }
			
			},
			
			confirmAction() {  
				
				// console.log("this.password " + this.password + "  " +this.isNumber(this.password));
				// if(this.isNumber(this.password)) {
				// 	uni.showToast({
				// 		title: "新的密码中只能输入数字",
				// 		icon: "none"
				// 	})
				// 	return
				// }
				
				// console.log("this.verifyPassword " + this.verifyPassword + "  " +this.isNumber(this.verifyPassword));
				// if(this.isNumber(this.verifyPassword)) {
				// 	uni.showToast({
				// 		title: "确认密码中只能输入数字",
				// 		icon: "none"
				// 	})
				// 	return
				// }
				
				if (this.isResest == true) {
					if (this.util.emptyObject(this.verifyCode) == true) {
						uni.showToast({
							title: "请输入验证码",
							icon: "none"
						})

						return
					}
				}
			

				if (this.util.emptyObject(this.password) == true || this.password.length != 6) {
					uni.showToast({
						title: "请输入6位支付密码",
						icon: "none"
					})

					return
				}

				if (this.util.emptyObject(this.verifyPassword) == true) {
					uni.showToast({
						title: "请再次输入支付密码",
						icon: "none"
					})

					return
				}

				if (this.password != this.verifyPassword) {
					uni.showToast({
						title: "两次输入密码不一致,请重新输入",
						icon: "none"
					})

					return
				}

				uni.hideKeyboard()
				uni.showLoading({

				})

				var me = this
				var params = {}
				if (this.isResest == true) {
					params["phone"] = this.user.phone
					params["sessionId"] = this.sessionId
					params["code"] = this.verifyCode
					params["passWord"] = this.verifyPassword

					accountapi.changePaymentCode(params, (data, msg) => {
						if (data != null) {
							uni.$emit(me.kAccountRefresh, null)

							setTimeout(() => {
								uni.hideLoading()
								uni.navigateBack({

								})
							}, 800)
						} else {
							uni.hideLoading()
							uni.showToast({
								title: msg,
								icon: "none"
							})
						}
					})
				} else {
					params["userId"] = this.util.userID()
					params["paymentCode"] = this.verifyPassword

					accountapi.setPaymentCode(params, (data, msg) => {
						if (data != null) {
							me.$emit(me.kAccountRefresh, null)

							setTimeout(() => {
								uni.hideLoading()
								uni.navigateBack({

								})
							}, 800)
						} else {
							uni.hideLoading()
							uni.showToast({
								title: msg,
								icon: "none"
							})
						}
					})
				}
			},
			bottomLine() {
				return "border-bottom: solid 1.6rpx rgba(21, 25, 54, 1);"
			}
		},
		onShow() {
			this.user = this.util.userInfo()
		},
		onLoad(params) {
			if (params != null && params["isResest"] != null) {
				uni.setNavigationBarTitle({
					title: "密码重设"
				})

				this.isResest = true
			}
		}
	}
</script>

<style>
	@import url("paycodefunction.css");
	@import url("../loginregister/loginregister.css");
</style>
