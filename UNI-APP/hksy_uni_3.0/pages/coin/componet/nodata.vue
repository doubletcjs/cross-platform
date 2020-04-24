<template>
	<view class="nodata-box" style="">
		<view class="box">
			<image class="nodata-img" src="/static/images/nodata@3x.png" mode=""></image>
		</view>
		<view class="nodata-text">
			{{ msg }}
		</view>
		<view class="nodata-text2">{{msg2}}</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		props:{
			msg:String,
			msg2:String,
			objstyle:{
				
			}
		}
	}
</script>

<style scoped>
	.nodata-box{
		text-align: center;
		margin-top: 290rpx;
	}
	.nodata-img{
		width: 238rpx;
		height: 238rpx;
	}
	.nodata-text{
		color: #9198AD;
		text-align: center;
		font-size: 28rpx;
		margin-top: 20rpx;
	}
	.nodata-text2{
		text-align: center;
		color: #9198AD;
		font-size: 28rpx;
		line-height: 46rpx;
	}
	
</style>
