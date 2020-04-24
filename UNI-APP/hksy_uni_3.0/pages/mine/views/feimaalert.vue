<template>
	<view class="feima-alert-body">
		<view class="feima-alert-title">
			温馨提示
		</view>
		<view class="feima-alert-content">
			由于飞码通支付通道华夏银行进行系统升级，请使用现金充值和现金提现
		</view>
		<view class="feima-alert-line">
			
		</view>
		<view class="feima-alert-confirm" @tap="closeHandle">
			我知道了
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {

			}
		},
		methods: {

		},
		props: {
			closeHandle: Function
		}
	}
</script>

<style>
	@import url("feimaalert.css");
</style>
