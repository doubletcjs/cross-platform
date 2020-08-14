<template>
	<view>
		<!-- 顶部按钮栏 -->
		<view class="create-title-bar">
			<!-- 返回 -->
			<view class="create-title-back-row" @click="backAction">
				<image src="/static/images/base_back@3x.png" mode="" class="create-title-arrow" style="margin-right: 16rpx;"></image>
				<view class="create-title-back">
					返回
				</view>
			</view>
		</view>
		<view class="create-complete-content">
			<!-- logo -->
			<image src="" mode="" class="create-complete-logo"></image>
			<!-- 提醒 -->
			<view class="create-complete-tip">
				创建成功！等待审核，届时会有专人联系，请留意接听电话!
			</view>
			<!-- 返回 -->
			<view class="create-complete-back" @click="backHomeAction">
				返回首页
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {};
		},
		methods: {
			// 返回
			backAction() {
				uni.navigateBack({
					delta: 1,
				});
			},
			// 返回首页
			backHomeAction() {
				uni.switchTab({
					url: "../../tabs/home/home_tab",
				});
			},
		},
	};
</script>

<style>
	@import url("create_complete.css");
	@import url("create_title_bar.css");
</style>
