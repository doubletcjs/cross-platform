<template>
	<view class="main-body">
		<view class="store-classify-list">
			<view class="store-classify-cell" v-for="(item, index) in classifyList" :data-index="index" @click="classifySelection"
			 :style="classifyIndex == index ? 'color: rgba(235, 102, 91, 1); background-color: rgba(247, 246, 245, 1);' : ''">
				{{item}}
				<view class="store-classify-cell-line" :style="classifyIndex == index ? 'background-color: rgba(235, 102, 91, 1);' : ''">

				</view>
			</view>
		</view> 
		<view class="store-classify-content-mask">
			<view class="store-classify-content-cell" :data-index="index" @click="classifySearch" v-for="(item, index) in classifyContentList" :key="index" :style="index%2 == 1 ? 'margin-left: 16rpx;' :''">
				<image src="http://api.cocoachina.com/uploads/200811/9cc30a1ea3c6bae198a88fd42d50c209.png" mode="scaleToFill" class="store-classify-content-cover"></image>
				<view class="store-classify-content-name">
					{{item}}
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				classifyList: [
					"推荐1",
					"热门",
					"陶器",
					"大理石",
					"其他", 
				],
				classifyContentList: [
					"托盘",
					"沙拉碗",
					"仪式蜡烛",
					"小碗",  
				],
				classifyIndex: 0
			}
		},
		methods: {
			//切换分类
			classifySelection(res) {
				var index = res.currentTarget.dataset.index
				this.classifyIndex = index
			},
			//搜索分类
			classifySearch(res) {
				var index = res.currentTarget.dataset.index  
				uni.navigateTo({
					url: "./home_page_store_search?keywork="+this.classifyContentList[index]
				})
			}
		}
	}
</script>

<style>
	@import url("home_page_store_classify.css");
</style>
