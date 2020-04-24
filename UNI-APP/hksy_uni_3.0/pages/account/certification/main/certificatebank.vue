<template>
	<view class="certificate-info-wapper main-body" style="height: auto;">
		<view class="main-body-sub" style="margin-top: 0rpx;">
			<view class="sub-box">
				<view class="write">填写银行卡信息</view>
				<view class="certificate-info-input-wapper" v-for="(item, index) in bankItems" :key="index">
					<view class="certificate-info-input-item">
						{{item}}
					</view>
					<input type="number" id="banknumber" :value="bankNumber" maxlength="19" @input="textFieldOnChanged" @blur="getBankName" class="certificate-info-input"
					 :placeholder="bankPlaceholders[index]" placeholder-class="certificate-info-input-placeholder" v-if="index == 0"
					 style="width: 72%;" />
					<input type="text" id="bankname" :value="bankName" @input="textFieldOnChanged" disabled="true" class="certificate-info-input"
					 :placeholder="bankPlaceholders[index]" placeholder-class="certificate-info-input-placeholder" v-if="index == 1"
					 style="width: 52%;" />
					<input type="text" id="bankaddress" :value="bankAddress" @input="textFieldOnChanged" class="certificate-info-input"
					 :placeholder="bankPlaceholders[index]" placeholder-class="certificate-info-input-placeholder" v-if="index == 2"
					 style="width: 72%;" />
				</view>
			</view>
			
			<view class="certificate-info-next-sapper" @tap="confirmBank">
				<view class="certificate-info-next">
					确认提交
				</view>
			</view>
		</view>
		
		<!-- <keyboard-package :disableDot="true" :type="1" @input="inputIdcardValue" ref="keyboard"></keyboard-package> -->
	</view>
</template>

<script>
	import accountapi from "../../api/accountapi.js"
	import keyboardPackage from "../../../../components/keyboard-package/keyboard-package.vue"

	export default {
		data() {
			return {
				bankItems: ["银行卡号", "持卡银行", "开户支行"],
				bankPlaceholders: ["请输入银行卡号", "获取持卡银行", "请输入开户行地址"],
				bankNumber: "",
				bankName: "",
				bankAddress: ""
			}
		},
		components: {
			keyboardPackage
		},
		methods: {
			// inputIdcardValue(val) {
			// 	if (val == "") {
			// 		this.bankNumber = this.bankNumber.substr(0, this.bankNumber.length - 1)
			// 	} else {
			// 		val = val.toString()
			// 		this.bankNumber = this.bankNumber + val
			// 	}
			// },
			textFieldOnChanged(res) {
				var id = res.target.id
				var value = res.target.value

				if (id == "banknumber") {
					this.bankNumber = value
					// uni.hideKeyboard()
					// this.$refs.keyboard.open()
				} else if (id = "bankaddress") {
					this.bankAddress = value
				}
			},
			confirmBank() {
				if (this.util.emptyObject(this.bankNumber) == true) {
					uni.showToast({
						title: "请输入银行卡号",
						icon: "none"
					})

					return
				}

				if (this.util.emptyObject(this.bankAddress) == true) {
					uni.showToast({
						title: "请输入开户行地址",
						icon: "none"
					})

					return
				}

				var bank = {
					"bankCard": this.bankNumber,
					"bankName": this.bankName,
					"bankOfDeposit": this.bankAddress
				}
				this.getBankModel(bank)
			},
			getBankName() {
				if (this.util.emptyObject(this.bankNumber) == true || this.bankNumber.length < 8) {
					return
				}

				uni.showLoading({

				})
				var me = this
				accountapi.getBankName(this.bankNumber, (data, msg) => {
					uni.hideLoading()
					if (data != null) {
						me.bankName = data
					} else {
						uni.showToast({
							title: msg,
							icon: "none"
						})
					}
				})
			}
		},
		props: {
			getBankModel: {}
		}
	}
</script>

<style scoped>
	.sub-box {
		border-radius: 15rpx;
		background-color: #1C233F;
		width: 702rpx;
		margin: 0 auto;
		overflow: hidden;
		margin-bottom: 200rpx;
		margin-top: 20rpx;
	}

	.certificate-info-input-wapper {
		font-size: 30rpx;
		color: white;
		padding: 40rpx;
		box-sizing: border-box;
		display: flex;
		justify-content: space-between;
	}

	.certificate-info-input-wapper .certificate-info-input {
		text-align: right;
		height: 44rpx;
	}

	.certificate-info-input-placeholder {
		color: rgba(145, 152, 173, 1);
		font-size: 26rpx;
	}

	.write {
		font-size: 36rpx;
		font-weight: 600;
		color: white;
		background-color: #1C233F;
		padding-left: 40rpx;
		box-sizing: border-box;
		padding: 45rpx 0 54rpx 40rpx;
		letter-spacing: 2rpx;
	}

	.certificate-info-next-sapper {
		width: 702rpx;
		height: 98rpx;
		text-align: center;
		line-height: 98rpx;
		background-color: #1760FF;
		color: white;
		border-radius: 15rpx;
		font-size: 32rpx;
		letter-spacing: 1rpx;
		margin-left: 24rpx;
	}
</style>
