<template>
	<view>
		<view @click="toWithdraw">金币提现</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		methods: {
			toWithdraw() {
				uni.navigateTo({
					url: "../../pages/mine/wallet/withdraw"
				})
			}
		}
	}
</script>

<style>

</style>
