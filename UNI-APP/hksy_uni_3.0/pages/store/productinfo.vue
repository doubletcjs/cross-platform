<template>
	<view class="main-body page">
		<view class="main-body-sub">
			<image lazy-load="true" src="../../static/images/product_thumbnail@3x.png" mode="widthFix" class="product-info-thumbnail"></image>
			<view class="product-info-wapper">
				<view class="product-info-name">
					{{detail.productName}}
				</view>
				<view class="product-info-price-wapper">
					<view class="product-info-price">
						{{parseFloat(detail.productPreferentialPrice).toFixed(2)}}个
					</view>
					<view class="product-info-original-price">
						{{parseFloat(detail.productUnitPrice).toFixed(2)}}个
					</view>
				</view>
				<view class="product-info-title-wapper">
					<view class="product-info-line">

					</view>
					<view class="product-info-title">
						基本信息
					</view>
					<view class="product-info-line">
					
					</view>
				</view>
			</view>
			<scroll-view scroll-y="true" >
				<!-- src="detail.productDetail" -->
				<view>
					<!-- <image lazy-load="true" :src="detail.productDetail" mode="widthFix" class="product-info-image"></image> -->
					<image lazy-load="true" src="../../static/images/1585120152035.jpg" mode="widthFix" class="product-info-image"></image>
				</view>
			</scroll-view>
			
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
	@import url("productdetail.css");
	@import url("productinfo.css");
</style>
