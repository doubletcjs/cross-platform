<template>
	<view class="main-body mian_wrap">
		<uni-view class="box">{{ msg }}</uni-view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				msg:'HKC按照存储器算力进行配比'
			}
		},
		methods: {
			
		}
	}
</script>

<style scoped>
	.box{
		text-align: center;
		color: #FFFFFF;
		font-size: 30rpx;
		padding: 20rpx 0;
		letter-spacing: 1rpx;
	}
</style>
