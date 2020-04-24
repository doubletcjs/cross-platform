<template>
	<view class="certificate-info-wapper main-body" style="height: auto;">
		<view class="main-body-sub">
			<view class="certificate-info-input-wapper">
				<view class="certificate-info-input-item">
					手机号（+86）
				</view>
				<view class="certificate-info-input-box">
					<input type="number" :value="inputPhone" @input="textFieldOnChanged" maxlength="11" class="certificate-info-input"
					 placeholder="请输入手机号码" placeholder-class="certificate-info-input-placeholder" style="width: 63%;" />
				</view>
			</view>
			<view class="certificate-info-next-sapper" @tap="confirmPhone" style="">
				<view class="certificate-info-next">
					下一步
				</view>
			</view>
		</view>

		<!-- <keyboard-package :disableDot="true" :type="1" @input="inputIdcardValue" ref="keyboard"></keyboard-package> -->
	</view>
</template>

<script>
	// import keyboardPackage from "../../../../components/keyboard-package/keyboard-package.vue"

	export default {
		data() {
			return {
				inputPhone: ""
			}
		},
		components: {
			// keyboardPackage
		},
		methods: {
			// inputIdcardValue(val) {
			// 	if (val == "") {
			// 		this.inputPhone = this.inputPhone.substr(0, this.inputPhone.length - 1)
			// 	} else {
			// 		if (this.inputPhone.length < 11) {
			// 			val = val.toString()
			// 			this.inputPhone = this.inputPhone + val
			// 		}
			// 	}
			// },
			textFieldOnChanged(res) {
				this.inputPhone = res.detail.value
				// uni.hideKeyboard()
				// this.$refs.keyboard.open()
			},
			confirmPhone() {
				if (this.util.emptyObject(this.inputPhone) == true) {
					uni.showToast({
						title: "请输入手机号码",
						icon: "none"
					})

					return
				}

				if (this.util.validateMobile(this.inputPhone) == false) {
					uni.showToast({
						title: "请输入正确的手机号",
						icon: "none"
					})

					return
				}

				var phone = {
					"phone": this.inputPhone
				}
				this.getPhoneModel(phone)
			}
		},
		props: {
			getPhoneModel: {}
		}
	}
</script>

<style scoped>
	.phone-box {}

	.certificate-info-input-box {
		width: 600rpx;
		box-sizing: border-box;
		border-bottom: 1rpx solid #9198AD;
		margin-left: 65rpx;
	}

	.certificate-info-input-wapper {
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		color: white;
		font-size: 36rpx;
	}

	.certificate-info-input-wapper .certificate-info-input-item {
		width: 100%;
		box-sizing: border-box;
		margin-top: 60rpx;
		padding-left: 65rpx;
		box-sizing: border-box;
	}

	.certificate-info-input-wapper .certificate-info-input {
		color: white;
		font-size: 28rpx;
		display: block;
		margin-top: 45rpx;
		width: 620rpx;
		height: 66rpx;
		padding-bottom: 10rpx;
		text-align: left;
	}

	.certificate-info-input-placeholder {
		color: rgba(145, 152, 173, 1);
		font-size: 28rpx;
	}

	.certificate-info-next-sapper {
		color: #FFFFFF;
		width: 702rpx;
		height: 98rpx;
		text-align: center;
		border-radius: 15rpx;
		background-color: #1760FF;
		line-height: 98rpx;
		margin-left: 24rpx;
		margin-top: 260rpx;
	}
</style>
