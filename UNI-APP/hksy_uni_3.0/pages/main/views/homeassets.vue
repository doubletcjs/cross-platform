<template>
	<view v-if="performance != null">
		<view class="home-item-title">
			我的资产
		</view>
		<view class="home-asset-wapper">
			<view class="home-asset-title">
				总业绩
			</view>
			<view class="home-asset-value-wapper">
				<view class="home-asset-value">
					{{performance.expericence}}
				</view>
				<view class="home-asset-value-util">
					T
				</view>
			</view>
			<view class="home-asset-content-waper" style="justify-content: space-between;">
				<view class="home-asset-content-item-waper">
					<view class="home-asset-content">
						昨日业绩
					</view>
					<view class="home-asset-content" style="margin-left: 20rpx; max-width: 150rpx;">
						{{performance.yesterday_performance}}
					</view>
					<view class="home-asset-content">
						T
					</view>
				</view>
				<view class="home-asset-content-item-waper">
					<view class="home-asset-content">
						个人存储
					</view>
					<view class="home-asset-content" style="margin-left: 20rpx; max-width: 90rpx;">
						{{performance.storage}}
					</view>
					<view class="home-asset-content">
						T
					</view>
					<view class="home-asset-hkc-content">
						<text space="nbsp"> + {{performance.hkcstorage}}</text>T
					</view>
				</view>
				<!-- <view class="home-asset-content-waper" style="margin-top: 0rpx; margin-bottom: 0rpx;">
					<view class="home-asset-content">
						昨日业绩
					</view>
					<view class="home-asset-content" style="margin-left: 20rpx; max-width: 120rpx;">
						{{performance.yesterday_performance}}
					</view>
					<view class="home-asset-content">
						T
					</view>
				</view>
				<view class="home-asset-content-waper" style="margin-top: 0rpx; margin-bottom: 0rpx;">
					<view class="home-asset-content">
						个人存储
					</view>
					<view class="home-asset-content" style="margin-left: 20rpx; max-width: 120rpx;">
						{{performance.storage}}
					</view>
					<view class="home-asset-content">
						T
					</view>
				</view> -->
			</view>
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
			performance: null
		}
	}
</script>

<style>
	@import url("../homepage.css");
	@import url("homeassets.css");
</style>
