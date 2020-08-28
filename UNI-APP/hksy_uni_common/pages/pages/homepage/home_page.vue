<template>
	<view>
		<top :moreAction="detailAction" :searchAction="searchAction"></top>
		<view class="list-content">
			<!-- 基本信息 -->
			<info></info>
			<!-- 直播 -->
			<live></live>
			<!-- banner -->
			<banner></banner>
			<!-- tab -->
			<view :class="tabSticky == true ? 'tab-bar-mask tab-bar-mask-sticky' : 'tab-bar-mask'">
				<view class="top-actions" style="position: relative; overflow: hidden; height: calc(var(--status-bar-height) + 88rpx);"
				 v-if="tabSticky == true">
					<image src="/static/images/homepages_default_bg.png" mode="widthFix" style="position: absolute; top: -200rpx; left: 0; width: 100%; z-index: 0;"></image>
					<view class="top-mask" style="width: 100%; left: 0; z-index: 0;"></view>
					<!-- 返回 -->
					<view class="top-action-row" @click="backAction" style="background-color: green; width: 70%; margin-top: calc(var(--status-bar-height));">
						<image src="/static/images/base_back_white@3x.png" mode="" class="top-action-back" style="padding-top: 10rpx; padding-bottom: 10rpx;"></image>
						<view class="top-info-title" style="margin-left: 54rpx; position: absolute;">
							每日一食记
						</view>
					</view>
					<!-- 更多、搜索 -->
					<view class="top-action-row" style="margin-top: calc(var(--status-bar-height));">
						<image src="/static/images/homepage_search@3x.png" mode="" class="top-action-image" @click="searchAction"></image>
						<image src="/static/images/homepage_menu@3x.png" mode="" class="top-action-image" style="margin-left: 32rpx;"
						 @click="detailAction"></image>
					</view>
				</view>
				<!-- tabbar -->
				<view class="tab-bar">
					<view v-for="(item, index) in tabs" :key="index" :class="tabIndex == index ? 'tab-bar-title tab-bar-title-select' : 'tab-bar-title'"
					 :data-index="index" @click="tabSelectAction">
						{{item}}
						<!-- indicator -->
						<view class="tab-bar-indicator-mask">
							<view class="tab-bar-indicator" :style="tabIndex == index ? 'background-color: rgba(235, 102, 91, 1);' : ''"></view>
						</view>
					</view>
				</view>
			</view>
			<!-- 列表内容，根据标题tab index 显示不用页面 -->
			<dynamic :scrollTop="scrollTop" v-if="tabIndex == 0"></dynamic>
			<store :scrollTop="scrollTop" v-else-if="tabIndex == 1"></store>
			<discuss :scrollTop="scrollTop" v-else-if="tabIndex == 2"></discuss>
		</view> 
		<!-- 举报 -->
		<report :visible="reportvisible" :closeAction="reportAction"></report>
	</view>
</template>

<script>
	import top from "./home_page_top.vue"
	import info from "./home_page_info.vue"
	import live from "./home_page_live.vue"
	import banner from "./home_page_banner.vue"
	import dynamic from "./dynamic/home_page_dynamic.vue"
	import store from "./store/home_page_store.vue"
	import discuss from "./discuss/home_page_discuss.vue" 
	import report from "../detail/components/detail_report.vue"

	export default {
		data() {
			return {
				tabSticky: false,
				tabTop: 0,
				tabIndex: 0,
				tabs: [
					"动态",
					"商店",
					"讨论区",
				],
				scrollTop: 0, 
				reportvisible: false, //举报 
			}
		},
		methods: {
			//返回
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
			//详情
			detailAction() {  
				uni.navigateTo({
					url: "/pages/pages/detail/detail_page",
				})
			}, 
			// 举报
			reportAction() {
				this.reportvisible = !this.reportvisible
			},
			//搜索
			searchAction() {
				uni.navigateTo({
					url: "./store/home_page_store_search"
				})
			}
		},
		components: {
			top,
			info,
			live,
			banner,
			dynamic,
			store,
			discuss, 
			report
		},
		onPageScroll(res) { 
			this.scrollTop = res.scrollTop
			if (this.tabTop - res.scrollTop <= 40 + uni.getSystemInfoSync().statusBarHeight) {
				this.tabSticky = true
			} else {
				this.tabSticky = false
			}
		},
		onReady() {
			var me = this
			let selector = uni.createSelectorQuery().select('.tab-bar');
			selector.boundingClientRect(function(data) {
				me.tabTop = data.top
				if (me.tabTop < 0) {
					me.tabTop = -(me.tabTop)
				}
			}).exec(function() {

			})
		},
		onLoad() {

		}
	}
</script>

<style>
	@import url("home_page.css");
	@import url("home_page_top.css");
</style>
