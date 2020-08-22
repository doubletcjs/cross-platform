<template>
	<view v-if="hotProducts != null">
		<view class="home-item-title">
			产品推荐
		</view>
		<view class="home-recommend-wapper">
			<view class="product-cell-wapper" v-for="(product, index) in hotProducts" :key="index" :data-index="index" @tap="productSelect">
				<view class="product-cell-image-wapper" style="background-image: url(./static/images/main_product_thumbnail@3x.png);">
					<view class="product-cell-image-content-wapper">
						<view class="product-cell-image-content-title">
							HK iCloud-{{product.productType}}T
						</view>
						<view class="product-cell-image-content-tip">
							- 为IPFS量身定制
						</view>
					</view>
				</view> 
				<view class="product-cell-name">
					{{product.productName}}
				</view>
				<view class="product-cell-price">
					{{parseFloat(product.productPreferentialPrice).toFixed(2)}}/个
				</view>
			</view>
		</view>
	</view>
	<view v-else style="width: 100%; height: 60rpx;">
		
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		methods: {
			productSelect(res) {
				var index = res.currentTarget.dataset.index
				var productId = this.hotProducts[index].guid  
				
				uni.navigateTo({
					url: "../store/productdetail?productId="+productId
				})
			}
		},
		props: {
			hotProducts: null
		}
	}
</script>

<style>
	@import url("../homepage.css");
	@import url("homerecommend.css");
	@import url("../../store/storepage.css");
</style>
