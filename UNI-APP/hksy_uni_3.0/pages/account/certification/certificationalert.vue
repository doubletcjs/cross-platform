<template>
	<view class="certification-alert-wapper">
		<view class="certification-alert-wapper">
			<text class="certification-alert-title" style="margin-top: 100rpx;">
				您还没有实名认证\n请实名认证后在进行操作
			</text>
		
			<view class="certification-alert-close-wapper">
				<image src="/static/images/guanbi@3x.png" class="certification-alert-close" @tap="closeHandle"></image>
			</view>
		</view>
		<!-- #ifdef H5 -->
			<view class="certification-alert-confirm" @tap="goCertificationHandle" style="margin-bottom: 144rpx;">
				去实名认证
			</view> 
		<!-- #endif -->
		<!-- #ifndef H5 -->
			<view class="certification-alert-confirm" @tap="goCertificationHandle">
				去实名认证
			</view> 
		<!-- #endif -->
	</view>
</template>

<script>
	export default {
		data() {
			return {}
		},
		methods: {

		},
		props: {
			closeHandle: Function,
			goCertificationHandle: Function
		}
	}
</script>

<style>
	@import url("certificationalert.css");
</style>
