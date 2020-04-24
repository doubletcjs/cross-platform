<template>
	<view class="main-body mian_wrap">
		<view class="img-box">
			<image class="img" src="../../../static/images/buyFinish.png" mode="aspectFit" ></image>
		</view>
		<view class="text">购买成功</view>
		<view class="btn-box">
			<view class="btn" @tap="goIndex">首页</view>
			<view class="btn btn-color" @tap="goBack">继续购买</view>
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
			goIndex(){
				uni.reLaunch({
					url:'../../main/homepage'
				})
			},
			goBack(){
				uni.navigateBack({
					delta:1
				})
			}
		}
	}
</script>

<style>
	@import url("buycomplete.css");
</style>
