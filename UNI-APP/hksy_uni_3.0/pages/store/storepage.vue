<template>
	<view class="product-list-wapper">
		<view class="product-cell-wapper" v-for="(product, index) in productList" :key="index" :data-index="index" @tap="productSelect"
		 style="margin-bottom: 40rpx;">
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

		<view style="width: 100%; background-color: rgba(21, 25, 54, 1);" v-if="productList.length > 0">
			<uni-load-more iconType="auto" :status="moreStatus" :contentText="this.util.moreContentText" @clickLoadMore="loadMoreProduct"></uni-load-more>
		</view>

		<!-- #ifndef H5 -->
		<uni-popup ref="versionpopalert" type="center" :maskClick="false" v-if="vsersion">
			<versionalert :versionInfo="vsersion" :closeHandle="closeVersionAlert"></versionalert>
		</uni-popup>
		<!-- #endif -->
	</view>
</template>

<script>
	import uniLoadMore from "../../components/uni-load-more/uni-load-more.vue"
	import storeapi from "./api/storeapi.js"
	import uniPopup from "../../components/uni-popup/uni-popup.vue"
	import versionalert from "../main/views/versionpopalert.vue"

	export default {
		data() {
			return {
				moreStatus: "more",
				page: 1,
				limit: 20,
				productList: [],
				vsersion: null
			}
		},
		methods: {
			requestProduct() {
				var me = this
				storeapi.getProductList(this.page, this.limit, (data) => {
					if (data != null) {
						var dataList = []
						dataList = dataList.concat(data.records)
						if (me.page == 1) {
							me.productList = dataList
						} else {
							me.productList = me.productList.concat(dataList)
						}

						if (dataList.length == 0 && me.page > 1) {
							me.page -= 1
						}

						if (me.page == data.pages || data.pages == 0) {
							me.moreStatus = "noMore"
						} else {
							me.moreStatus = "more"
						}
					} else {
						if (me.page > 1) {
							me.page -= 1
							me.moreStatus = "more"
						}
					}

					uni.stopPullDownRefresh()
				})
			},
			refreshProduct() {
				this.page = 1
				this.requestProduct()
			},
			loadMoreProduct() {
				this.moreStatus = "loading"
				this.page += 1
				this.requestProduct()
			},
			productSelect(res) {
				var productIndex = res.currentTarget.dataset.index
				var productId = this.productList[productIndex].id

				uni.navigateTo({
					url: "./productdetail?productId=" + productId
				})
			},
			closeVersionAlert() { // 更新dialog关闭回调
				console.log("关闭更新dialog");
				this.$refs.versionpopalert.close()
			}
		},
		components: {
			uniLoadMore,
			uniPopup,
			versionalert
		},
		onPullDownRefresh() {
			this.refreshProduct()
		},
		created() {
			uni.startPullDownRefresh({

			})

			// #ifndef H5
			if (this.util.appVersionInfo() != null) {
				this.vsersion = this.util.appVersionInfo()
				setTimeout(() => {
					this.$refs.versionpopalert.open()
				}, 100)
			}
			// #endif
		}
	}
</script>

<style>
	@import url("storepage.css");
</style>
