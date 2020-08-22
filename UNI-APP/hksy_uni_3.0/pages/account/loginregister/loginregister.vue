<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="box-height">
				<view class="welcome-text">
					<view v-if="isRegister == true">
						欢迎注册华科闪云
					</view>
					<view v-else>
						欢迎使用华科闪云
					</view>
				</view>
				<view class="welcome-tip">
					<view v-if="isRegister == true">
						只需要手机号即可一键注册
					</view>
					<view v-else>
						只需要手机号即可一键登录
					</view>
				</view>
				<view class="welcome-base-tip" style="margin-top: 120rpx;">
					手机号（+86）
				</view>
				<view class="account-textfield-wapper">
					<input type="number" id="account" :value="phone" maxlength="11" placeholder-class="textfield-placeholder"
					 placeholder="请输入手机号" class="account-textfield" @input="textFieldOnchanged" />
				</view>
				<view class="welcome-base-tip" style="margin-top: 62rpx;">
					验证码
				</view>
				<view class="account-verifycode-textfield-wapper">
					<input type="number" id="verifycode" :value="verifyCode" maxlength="4" placeholder-class="textfield-placeholder"
					 placeholder="请输入验证码" class="account-textfield" @input="textFieldOnchanged" />
				
					<view class="account-verifycode-button" @tap="getVerifyCode">
						{{verifycodePlaceholder}}
					</view>
				</view>
				<view v-if="isRegister">
					<view class="welcome-base-tip" style="margin-top: 61rpx;">
						邀请码
					</view>
					<view class="account-textfield-wapper" style="margin-top: 1rpx;">
						<input type="text" id="invitecode" :value="inviteCode" placeholder-class="textfield-placeholder" placeholder="请输入邀请码(必填)"
						 class="account-textfield" @input="textFieldOnchanged" />
					</view>
				</view>
				<view class="account-agreement-wapper">
					<image src="/static/images/ico_rectangle_selected@3x.png" class="account-agreement-select" @tap="agreementSelectAction"
					 v-if="agreementSelect == true"></image>
					<image src="/static/images/ico_rectangle@3x.png" class="account-agreement-select" @tap="agreementSelectAction"
					 v-else></image>
				
					<view class="account-agreement-tip">
						已阅读并同意
					</view>
					<view class="account-agreement-button" @tap="showAgreement">
						《用户服务协议》
					</view>
				</view>
			</view>
			
		
			<view class="btn-box">
				<button type="primary" class="account-action-wapper" id="ListConS" @tap="loginRegisterAction">{{isRegister==false ? "登录": "确认注册"}}</button>
			
				<view class="account-switch-wapper">
					<view class="account-agreement-tip" style="color: rgba(153, 153, 153, 1);">
						{{isRegister==true ? "已有账号？": "未拥有华科闪云账号？"}}
					</view>
					<view class="account-agreement-button" @tap="switchAction">
						{{isRegister==true ? "去登录": "去注册"}}
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import accountapi from "../api/accountapi.js"

	export default {
		data() {
			return {
				isRegister: false,
				countDownSecond: 0,
				phone: "",
				verifyCode: "",
				inviteCode: "",
				sessionId: "",
				verifycodePlaceholder: "获取验证码",
				agreementSelect: true,
				countingDown: false
			}
		},
		methods: {
			agreementSelectAction() {
				this.agreementSelect = !this.agreementSelect
			},
			textFieldOnchanged(res) {
				var textfieldId = res.target.id
				var textfieldText = res.target.value
				if (textfieldId == "account") {
					this.phone = textfieldText
				} else if (textfieldId == "verifycode") {
					this.verifyCode = textfieldText
				} else if (textfieldId == "invitecode") {
					this.inviteCode = textfieldText
				}
			},
			getVerifyCode() {
				if (this.countingDown == false) {
					if (this.util.validateMobile(this.phone) == false) {
						uni.showToast({
							title: "请输入正确的手机号",
							icon: "none"
						})

						return
					}

					uni.hideKeyboard()
					var me = this
					accountapi.sendMessage(this.phone, (data, msg) => {
						if (data) {  
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
						} else {
							uni.showToast({
								title: "获取验证码失败!",
								icon: "none"
							})
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
			switchAction() {
				uni.hideKeyboard()
				if (this.isRegister == true) {
					uni.redirectTo({
						url: "../loginregister/loginregister"
					})
				} else {
					uni.reLaunch({
						url: "../loginregister/loginregister?register=1"
					})
				}
			},
			showAgreement() {
				uni.hideKeyboard()
				uni.navigateTo({
					url: "../agreement/agreement"
				})
			},
			loginRegisterAction() { 
				if (this.util.validateMobile(this.phone) == false) {
					uni.showToast({
						title: "请输入正确的手机号",
						icon: "none"
					})

					return
				}

				if (this.util.emptyObject(this.verifyCode) == true) {
					uni.showToast({
						title: "请输入验证码",
						icon: "none"
					})

					return
				}

				if (this.isRegister == true) {
					if (this.util.emptyObject(this.inviteCode) == true) {
						uni.showToast({
							title: "请输入邀请码",
							icon: "none"
						})

						return
					}
				}

				if (this.agreementSelect == false) {
					uni.showToast({
						title: "请先同意用户服务协议",
						icon: "none"
					})

					return
				}

				uni.hideKeyboard()
				var params = {
					"phone": this.phone,
					"code": this.verifyCode,
					"sessionId": this.sessionId
				}

				uni.showLoading({
					title: null
				})
				var me = this
				if (this.isRegister == true) {
					if (this.util.emptyObject(this.inviteCode) == true) {
						uni.showToast({
							title: "请输入邀请码",
							icon: "none"
						})

						return
					}

					params["invitationCode"] = this.inviteCode
					accountapi.register(params, (data, msg) => {
						if (data) {
							uni.showToast({
								title: "注册成功!",
								duration: 1800,
								icon: "none"
							})

							setTimeout(() => {
								me.switchAction()
							}, 1000)
						} else {
							uni.showToast({
								title: msg,
								icon: "none"
							})
						}
					})
				} else {
					accountapi.login(params, (data, msg) => {
						uni.hideLoading()
						if (data) {
							me.util.recordUserInfo(data)
							me.util.recordLoginTime()
							uni.showToast({
								title: "登录成功!",
								duration: 1800,
								icon: "none"
							})

							setTimeout(() => {
								uni.reLaunch({
									url: "../../main/homepage"
								})
							}, 1000)
						} else {
							uni.showToast({
								title: msg,
								icon: "none"
							})
						}
					})
				}
			}
		},
		onLoad(params) {
			if (params != null && params["register"] != null) {
				this.isRegister = true
			}
			
		}
	}
</script>

<style>
	@import url("loginregister.css");
</style>
