<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="product-info-wapper" style="margin-top: 70rpx;">
				<view class="product-info-title-wapper" style="margin-top: 40rpx; margin-bottom: 40rpx;">
					<view class="product-info-line">
			
					</view>
					<view class="product-info-title">
						包装售后
					</view>
					<view class="product-info-line">
						
					</view>
				</view>
			</view>
			<!-- <image :src="detail.productPictures" mode="widthFix" class="product-info-image" style="margin-bottom: 78rpx;"></image> -->
			<image src="../../static/images/1585120161108.jpg" mode="widthFix" class="product-info-image" style="margin-bottom: 78rpx;"></image>
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
			detail: null
		}
	}
</script>

<style>
	@import url("./productdetail.css");
	@import url("./productinfo.css");
</style>
