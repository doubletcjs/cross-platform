<template>
	<view style="background-color: rgba(247, 246, 245, 1);">
		<view class="store-ower-content">
			<!-- 店铺 -->
			<view class="store-base-row" style="width: 78%;">
				<!-- 头像 -->
				<image src="" mode="" class="store-ower-avatar"></image>
				<view class="store-base-row" style="width: 80%;">
					<!-- 名称 -->
					<view class="store-name">
						每日一食记的小铺
					</view>
					<image src="/static/images/detail_arrow@3x.png" mode="" class="store-name-arrow"></image>
				</view>
			</view>
			<!-- 客服 -->
			<view class="store-base-row">
				<image src="/static/images/store_service@3x.png" mode="aspectFit" class="store-service-icon"></image>
				<view class="store-service">
					客服
				</view>
			</view>
		</view>
		<!-- tab -->
		<view class="store-tab">
			<view v-for="(item, index) in tabs" :key="index" class="store-tab-item" :data-index="index" @click="tabSelectAction"
			 :style="tabIndex == index ? 'background-color: rgba(247, 246, 245, 1); color: rgba(50, 50, 50, 1);' : 'color: rgba(153, 153, 153, 1); background-color: rgba(255, 255, 255, 1);'">
				{{item}}
			</view>
			<!-- 分类 -->
			<view class="store-base-row" style="position: absolute; right: 32rpx;">
				<image src="/static/images/store_classify@3x.png" mode="aspectFit" class="store-classify-icon"></image>
				<view class="store-classify">
					分类
				</view>
			</view>
		</view>
		<!-- 优惠券 -->
		<scroll-view scroll-x="true" class="store-coupon-swiper">
			<view v-for="(item, index) in coupons" :key="index" class="store-coupon-item">
			</view>
		</scroll-view>
		<!-- 商品列表 -->
		<view class="store-item-content">
			<!-- 左侧 -->
			<view class="store-item-list">
				<view v-for="(item, index) in leftProducts" :key="index" class="store-item-cell">
					<!-- 图片 -->
					<image src="" mode="" class="store-item-cell-image"></image>
					<view class="store-item-cell-content">
						<!-- 商品名称 -->
						<view class="store-item-cell-name">
							{{item['name']}}
						</view>
						<!-- 商品价格 -->
						<view class="store-item-cell-row" style="margin-top: 8rpx;">
							<view class="store-item-cell-unit">
								¥
							</view>
							<view class="store-item-cell-price">
								{{item['price']}}
							</view>
						</view>
					</view>
				</view>
			</view>
			<!-- 右侧 -->
			<view class="store-item-list">
				<view v-for="(item, index) in rightProducts" :key="index" class="store-item-cell">
					<!-- 图片 -->
					<image src="" mode="" class="store-item-cell-image"></image>
					<view class="store-item-cell-content">
						<!-- 商品名称 -->
						<view class="store-item-cell-name">
							{{item['name']}}
						</view>
						<!-- 商品价格 -->
						<view class="store-item-cell-row" style="margin-top: 8rpx;">
							<view class="store-item-cell-unit">
								¥
							</view>
							<view class="store-item-cell-price">
								{{item['price']}}
							</view>
						</view>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				tabs: [
					"推荐",
					"销量",
					"价格",
				],
				tabIndex: 0,
				coupons: [
					"",
					"",
					"",
					"",
					"",
				],
				products: [{
						name: "活性釉沙拉碗，西榆木黑白色",
						price: 69.00
					},
					{
						name: "小碗上釉的粗陶器",
						price: 38.00
					},
					{
						name: "大理石圆形托盘，带小边框",
						price: 99.00
					},
					{
						name: "大理石小碗",
						price: 88.00
					},
					{
						name: "彩色陶器三件套",
						price: 138.00
					},
					{
						name: "仪式茶蜡烛  每种茶香气都舒缓和舒适",
						price: 79.00
					},
				],
				leftProducts: [],
				rightProducts: [],
			}
		},
		methods: {
			//tab
			tabSelectAction(res) {
				var index = res.currentTarget.dataset.index
				this.tabIndex = index
			},
			//瀑布流数组
			fetchWaterfall() {
				this.leftProducts = []
				this.rightProducts = []
				for (var i = 0; i < this.products.length; i++) {
					if (i % 2 == 0) {
						this.leftProducts.push(this.products[i])
					} else if (i % 2 == 1) {
						this.rightProducts.push(this.products[i])
					}
				} 
			}
		},
		created() {
			this.fetchWaterfall()
		}
	}
</script>

<style>
	@import url("home_page_store.css");
</style>
