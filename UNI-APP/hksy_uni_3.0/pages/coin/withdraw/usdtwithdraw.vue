<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="usdt-withdraw-tip-wapper">
				<view class="usdt-withdraw-tip">
					金币资产
				</view>
				<view class="usdt-withdraw-tip">
					{{_formatNumber(coin)}}个
				</view>
			</view>
			<view class="mine-page-cell-section-wapper" style="margin-top: 70rpx;">
				<view class="usdt-withdraw-item-tip">
					USDT提现地址
				</view>
				<view class="usdt-withdraw-input-wapper" style="border-bottom: solid 1.6rpx rgba(21, 25, 54, 1);">
					<input type="text" id="usdtaddress" :value="inputUsdtAddress" @input="textFieldOnchanged" placeholder="请输入或长按粘贴地址"
					 placeholder-class="usdt-withdraw-input-placeholder" class="usdt-withdraw-input" style="width: 100%;" />
				</view>
			</view>
			<view class="mine-page-cell-section-wapper" style="margin-top: 70rpx;">
				<view class="usdt-withdraw-item-tip">
					提现数量
				</view>
				<view class="usdt-withdraw-input-wapper" style="border-bottom: solid 1.6rpx rgba(21, 25, 54, 1);">
					<input type="digit" id="usdtcount" :value="inputCoin" @input="textFieldOnchanged" :placeholder="usdtPlaceholder"
					 placeholder-class="usdt-withdraw-input-placeholder" class="usdt-withdraw-input" style="width: 80%;" />
					<view class="usdt-withdraw-rollout" @tap="rolloutAll">
						全部转出
					</view>
				</view>
				<view class="usdt-withdraw-content-wapper">
					<view class="usdt-withdraw-content">
						手续费
					</view>
					<view class="usdt-withdraw-content">
						{{parseFloat(poundage).toFixed(2)}} USDT
					</view>
				</view>
			</view>
			<view class="usdt-withdraw-info-tip-wapper">
				<view class="usdt-withdraw-info-tip" v-for="(tip, tipindex) in usdtTips" :key="tipindex">
					{{tip}}
				</view>
			</view>
			<view class="usdt-withdraw-confirm-wapper" :style="{top:clientHight}">
				<view class="usdt-withdraw-function-wapper">
					<view class="usdt-withdraw-function-value-tip">
						到账信息
					</view>
					<view class="usdt-withdraw-function-coin" v-if="this.util.emptyObject(inputCoin) == true">
						约为0.00金币
					</view>
					<view class="usdt-withdraw-function-coin" v-else>
						约为{{inputCoin}}金币
					</view>
				</view>
				<view class="usdt-withdraw-confirm" @tap="confirmAction">
					确认提现
				</view>

				<view class="usdt-withdraw-float-usdt">
					<view class="usdt-withdraw-usdt-text" v-if="this.util.emptyObject(usdtCount) == true">
						0.00
					</view>
					<view class="usdt-withdraw-usdt-text" v-else>
						{{parseFloat(usdtCount).toFixed(2)}}
					</view>
					<view class="usdt-withdraw-usdt-util">
						USDT
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import coinapi from "../api/coinapi.js"

	export default {
		data() {
			return {
				usdtTips: [],
				poundage: "0.0",
				inputUsdtAddress: "",
				inputCoin: "",
				usdtCount: "",
				coin: "",
				minCoin: 0.0,
				usdtPlaceholder: "",
				clientHight: ""
			}
		},
		onReady() { // 监听页面初次渲染完成。注意如果渲染速度快，会在页面进入动画完成前触发
			this.clientHight = this.util.getClientHeight4USDT();
		},
		methods: {
			textFieldOnchanged(res) {
				var id = res.target.id
				var value = res.target.value
				if (id == "usdtaddress") {
					this.inputUsdtAddress = value
				} else if (id == "usdtcount") {
					this.inputCoin = value
					this.poundage = (this.inputCoin * 0.05) / 6.72
					this.usdtCount = (this.inputCoin - this.inputCoin * 0.05) / 6.72
				}
			},
			confirmAction() {
				if (this.util.emptyObject(this.inputUsdtAddress) == true) {
					uni.showToast({
						title: "请输入提币地址",
						icon: "none"
					})

					return
				}

				if (this.util.emptyObject(this.usdtCount) == true || this.minCoin > parseFloat(this.usdtCount).toFixed(2)) {
					uni.showToast({
						title: "最小提币数量为" + this.minCoin + "枚USDT",
						icon: "none"
					})

					return
				}

				uni.showLoading({

				})

				var me = this
				coinapi.submitUSDTWithdraw(this.util.userID(), this.inputCoin, this.usdtCount, this.poundage, this.inputUsdtAddress,
					this.coinValue, (data, msg) => {
						uni.hideLoading()
						if (data != null) {
							// 提现成功
							uni.redirectTo({
								url: "../recharge/rechargecomplete"
							})

							uni.$emit(this.kAccountRefresh, null)
							me.emptyWithdrawInfo()
						} else {
							uni.showToast({
								title: msg,
								icon: "none"
							})
						}
					})
			},
			emptyWithdrawInfo() {
				uni.hideKeyboard()
				this.inputCoin = ""
				this.inputUsdtAddress = ""
				this.poundage = "0.0"
			},
			_formatNumber(num) {
				return this.util.formatNumber(num)
			},
			rolloutAll() {
				this.inputCoin = this.coin
				this.poundage = (this.inputCoin * 0.05) / 6.72
				this.usdtCount = (this.inputCoin - this.inputCoin * 0.05) / 6.72 
			}
		},
		onShow() {
			this.coin = this.util.userInfo().coin
			this.minCoin = parseFloat(this.util.userInfo().usdt_min_amount).toFixed(2)
			this.usdtPlaceholder = "可提现" + this.coin + "个"
			var tempMinCoin = parseFloat(this.util.userInfo().usdt_min_amount).toFixed(0)
			this.usdtTips = ["注意：", "*最小提币数量为" + tempMinCoin + "枚USDT", "*1USDT≈6.72金币", "*转出至钱包的资金，平台将收取5%的提现手续费，请对资金进行合理安排",
				"*请在转出USDT之前，仔细核对收款钱包地址准确无误"
			]
		}
	}
</script>

<style>
	@import url("usdtwithdraw.css");
	@import url("../../mine/minepage.css");
</style>
