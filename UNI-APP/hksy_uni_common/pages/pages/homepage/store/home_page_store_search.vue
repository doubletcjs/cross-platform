<template>
	<view style="background-color: rgba(247, 246, 245, 1);">
		<!-- 顶部按钮栏 -->
		<view class="create-title-bar">
			<!-- 返回 -->
			<view class="create-title-back-row" @click="backAction">
				<image src="/static/images/base_back@3x.png" mode="" class="create-title-arrow" style="margin-right: 16rpx;"></image> 
			</view> 
			<!-- 搜索 -->
			<view class="search-input-content">
				<image src="/static/images/home_tab_search_icon@3x.png" mode="" class="search-input-icon"></image>
				<input type="text" v-model="keywork" class="search-input" placeholder-class="search-input-placeholder" placeholder="输入分类名称" />
			</view>
		</view> 
		<!-- tab -->
		<view class="search-tab">
			<view v-for="(item, index) in tabs" :key="index" class="search-tab-item" :data-index="index" @click="tabSelectAction"
			 :style="tabIndex == index ? 'background-color: rgba(247, 246, 245, 1); color: rgba(50, 50, 50, 1);' : 'color: rgba(153, 153, 153, 1); background-color: rgba(255, 255, 255, 1);'">
				{{item}}
			</view>
		</view>
		<!-- 商品列表 -->
		<view class="store-item-content" style="position: absolute; top: calc(var(--status-bar-height) + 176rpx); left: 0; right: 0; background-color: rgba(247, 246, 245, 1);">
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
				keywork: "",
				tabIndex: 0,
				tabs: [
					"推荐",
					"销量",
					"价格",
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
			// 返回
			backAction() {
				uni.navigateBack({
					delta: 1
				})
			},
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
		onLoad(res) {
			if (res && res["keywork"]) {
				this.keywork = res["keywork"]
			}
		},
		created() {
			this.fetchWaterfall()
		}
	}
</script>

<style>
	@import url("../../create/create_title_bar.css");
	@import url("home_page_store_search.css");
	@import url("home_page_store.css");
</style>
