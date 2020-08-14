<template>
	<view class="top">
		<image class="top-image" src="/static/images/homepages_default_bg.png" mode="aspectFill"></image>
		<view class="top-mask">
			<view class="top-actions" :style="topActionsStyle">
				<!-- 返回 -->
				<view class="top-action-row" @click="backAction">
					<image src="/static/images/base_back_white@3x.png" mode="" class="top-action-back" style="padding-top: 10rpx; padding-bottom: 10rpx; padding-right: 40rpx;"></image>
				</view>
				<!-- 更多、搜索 -->
				<view class="top-action-row">
					<image src="/static/images/homepage_search@3x.png" mode="" class="top-action-image" @click="searchAction"></image>
					<image src="/static/images/homepage_menu@3x.png" mode="" class="top-action-image" style="margin-left: 32rpx;" @click="moreAction"></image>
				</view>
			</view>
			<view class="top-action-row" style="margin-top: 56rpx; margin-left: 32rpx; margin-right: 32rpx;">
				<!-- 封面 -->
				<image src="" mode="" class="top-info-cover"></image>
				<!-- 标题 -->
				<view class="top-info-title">
					每日一食记
				</view>
			</view>
			<view class="top-action-row" style="margin-top: 27rpx; margin-left: 32rpx; margin-right: 32rpx;"> 
				<!-- 信息 -->
				<view class="top-info-content">
					23361人已加入·138篇内容
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				topActionsStyle: "margin-top: calc(var(--status-bar-height) + 40rpx);"
			}
		},
		methods: {
			backAction() {
				uni.navigateBack({
					delta: 1
				})
			}
		},
		created() {
			var info = uni.getSystemInfoSync()
			if (info.statusBarHeight > 0) {
				this.topActionsStyle = "margin-top: var(--status-bar-height);"
			} else {
				this.topActionsStyle = "margin-top: calc(var(--status-bar-height) + 40rpx);"
			}
		},
		props: {
			searchAction: Function,
			moreAction: Function
		}
	}
</script>

<style>
	@import url("home_page_top.css");
</style>
