<template>
	<view>
		<!-- 顶部栏 -->
		<view class="home-title-bar">
			<view class="home-title-bar-row">
				<!-- logo、名称 -->
				<view class="home-title-bar-logo">街角</view>
				<!-- 搜索 -->
				<view class="home-title-bar-search">
					<image src="/static/images/home_tab_search_icon@3x.png" mode="" class="home-title-bar-search-icon"></image>
					<input class="home-title-bar-search-input" type="text" value="" placeholder-class="home-title-bar-search-input-placeholder"
					 placeholder="搜索用户、角落或是内容" />
				</view>
			</view>
			<!-- 添加按钮 -->
			<image src="/static/images/home_tab_add@3x.png" mode="" class="home-title-bar-add" @click="createAction"></image>
		</view>
		<!-- 内容列表 -->
		<view class="home-list-content">
			<!-- 顶部banner -->
			<swiper display-multiple-items="2" class="home-banner-recommend" v-if="bannerRecommendList.length > 0">
				<swiper-item v-for="(item, index) in bannerRecommendList" :key="index">
					<view class="home-top-recommend-item" style="margin-left: 8rpx; margin-right: 8rpx;">
						<!-- 封面 -->
						<image src="" mode="" class="home-top-recommend-image"></image>
						<!-- 标题 -->
						<view class="home-top-recommend-title">{{ item['title'] }}</view>
						<!-- 博主 -->
						<view class="home-top-recommend-blogger">落主：{{ item['name'] }}</view>
						<!-- 预览 -->
						<view class="home-top-recommend-preview">{{ item['preview'] }}</view>
					</view>
				</swiper-item>
			</swiper>
			<!-- 无推荐 -->
			<view class="home-no-recommend" v-else>
				<view class="home-no-recommend-title">你还未加入角落，赶快去加入吧~</view>
				<view class="home-no-recommend-discover" @click="findAction">去发现角落</view>
			</view>
			<!-- 精选推荐 -->
			<view class="home-select-recommend">精选推荐</view>
			<view class="home-recommend-cell" v-for="(item, index) in recommendList" :key="index" :data-index="index" @click="detailAction">
				<!-- 封面 -->
				<image src="" mode="" class="home-recommend-cell-cover"></image>
				<view class="home-recommend-cell-colum">
					<!-- 标题 -->
					<view class="home-recommend-cell-title">{{ item }}</view>
					<!-- 预览 -->
					<view class="home-recommend-cell-preview">所谓人生， 不过是一杯咖啡所萦绕的不过是一杯咖啡所萦绕的不过是一杯咖啡所萦绕的</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				bannerRecommendList: [
					// {
					// 	title: "每日一食记",
					// 	blogger: "红鱼",
					// 	preview: "每一个制造和享用美食的人无不经历江湖夜雨，期待..."
					// },
					// {
					// 	title: "探寻",
					// 	blogger: "羡闲",
					// 	preview: "开始一段艰苦的冒险经历"
					// }
				],
				recommendList: [
					"手机摄影",
					"月野兔好物",
					"尚得厨房",
					"你De世界",
					"a",
					"b",
					"c",
					"d"
				]
			}
		},
		methods: {
			//创建
			createAction() {
				uni.navigateTo({
					url: "/pages/pages/create/create_base"
				})
			},
			// 发现角落
			findAction() {
				
			},
			//详情
			detailAction(res) {
				uni.navigateTo({
					url: "/pages/pages/homepage/home_page",
				})
			}
		}
	}
</script>

<style>
	@import url('home_tab.css');
	@import url('home_title_bar.css');
	@import url('home_top_recommend.css');
	@import url('home_recommend_cell.css');
</style>
