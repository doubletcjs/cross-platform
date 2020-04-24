<template>
	<view class="main-body" >
		<view class="main-body-sub">
			<view class="recharge-complete-wapper">
				<image src="/static/images/buyFinish.png" class="recharge-complete-logo-image"></image>
				<view class="recharge-complete-tip">
					申请已提交
				</view>
			</view>
			<view class="recharge-complete-buttons-wapper">
				<view class="recharge-complete-back-button" @tap="backCoinMain">
					返回
				</view>
				<view class="recharge-complete-detail-button" @tap="rechargeDetail">
					查看订单详细
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				currentIndex:0
			}
		},
		onLoad(options) {
			this.currentIndex = options.currentIndex;
		},
		methods: {
			backCoinMain() { // 
				uni.navigateBack({
					delta: 1
				})
			},
			rechargeDetail() { // 查看订单详细
				uni.redirectTo({
					url: "./rechargedetail?currentIndex="+this.currentIndex
				})
			}
		}
	}
</script>

<style>
	@import url("rechargecomplete.css");
</style>
