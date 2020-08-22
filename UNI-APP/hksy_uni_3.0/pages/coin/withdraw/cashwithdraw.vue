<template>
	<view class="main-body">
		<view class="main-body-sub" v-if="bankName.length > 0">
			<view class="cash-withdraw-tip-wapper">
				<view class="cash-withdraw-tip">
					金币资产
				</view>
				<view class="cash-withdraw-tip">
					{{_formatNumber(coin)}}个
				</view>
			</view>
			<view class="mine-page-cell-section-wapper" style="margin-top: 70rpx;">
				<view class="cash-withdraw-item-tip">
					提现数量
				</view>
				<view class="cash-withdraw-input-wapper" style="border-bottom: solid 1.6rpx rgba(21, 25, 54, 1);">
					<input type="digit" :value="inputCoin" @input="textFieldOnchanged" :placeholder="placeholder" placeholder-class="cash-withdraw-input-placeholder"
					 class="cash-withdraw-input" style="width: 80%;" />
					<view class="cash-withdraw-rollout" @tap="rolloutAll">
						全部转出 
					</view>
				</view>
				<view class="cash-withdraw-content-wapper">
					<view class="cash-withdraw-content">
						提现到银行卡
					</view>
					<view class="cash-withdraw-content" style="font-size: 26rpx;">
						{{bankName}}
					</view>
				</view>
			</view>
			<view class="cash-withdraw-confirm" :style="{top:clientHight}" @tap="confirmAction">
				确认提现
			</view>
		</view>

		<uni-popup type="bottom" ref="paycodepopup">
			<paycodeinput :colseAction="closePaycodepopup" :completeAction="completePaycode"></paycodeinput>
		</uni-popup>
	</view>
</template>

<script>
	import paycodeinput from "../../account/paycodefunction/paycodeinput.vue"
	import uniPopup from "../../../components/uni-popup/uni-popup.vue"
	import accountapi from "../../account/api/accountapi.js"
	import coinapi from "../api/coinapi.js"

	export default {
		data() {
			return {
				coin: "",
				placeholder: "",
				inputCoin: "",
				bankName: "",
				clientHight: ""
			}
		},
		components: {
			uniPopup,
			paycodeinput 
		},
		onReady() { // 监听页面初次渲染完成。注意如果渲染速度快，会在页面进入动画完成前触发
			this.clientHight = this.util.getClientHeight();
		},
		methods: { 
			allWithdraw() {
				this.inputCoin = parseFloat(this.util.userInfo().coin).toFixed(2)
			},
			textFieldOnchanged(res) {
				var text = res.target.value
				this.inputCoin = text
			},
			confirmAction() {
				if (this.util.emptyObject(this.inputCoin) == true || parseFloat(this.inputCoin).toFixed() <= 0.0) {
					uni.showToast({
						title: "请输入转出金额",
						icon: "none"
					})
					return
				}

				uni.hideKeyboard()
				if (this.util.emptyObject(this.util.userInfo().paymentCode) == true) {
					uni.navigateTo({
						url: "../../account/paycodefunction/paycodefunction"
					})
				} else {
					this.$refs.paycodepopup.open()
				}
			},
			closePaycodepopup() {
				this.$refs.paycodepopup.close()
			},
			completePaycode(val) {
				setTimeout(() => {
					uni.showLoading({

					}) 
					var me = this
					coinapi.withdrawCash(this.util.userID(), this.inputCoin, val, (data, msg) => {
						if (data) {
							uni.$emit(me.kcoinRefresh, null)

							setTimeout(() => {
								me.coin = me.util.userInfo().coin
								me.placeholder = me.coin + "个"
								me.inputCoin = ""
								uni.hideLoading()

								// 提现成功
								uni.redirectTo({
									url: "../recharge/rechargecomplete?currentIndex=2"
								})
							}, 600)
						} else {
							uni.hideLoading()
							uni.showToast({
								title: msg,
								icon: "none"
							})
						}
					})
				}, 400)
			},
			requestCertificationInfo() {
				uni.showLoading({

				})

				var me = this
				accountapi.getPersonalInfo(this.util.userID(), (data, msg) => {
					uni.hideLoading()
					if (data) {
						me.bankName = data.bankName
					} else {
						uni.showToast({
							title: msg,
							icon: "none"
						})
					}
				})
			},
			_formatNumber(num) {
				return this.util.formatNumber(num)
			},
			rolloutAll() {
				this.inputCoin = this.coin
			}
		},
		onShow() {
			this.coin = this.util.userInfo().coin
			this.placeholder = this.coin + "个"
		},
		created() {
			this.requestCertificationInfo()
		}
	}
</script>

<style>
	@import url("cashwithdraw.css");
	@import url("../../mine/minepage.css");
</style>
