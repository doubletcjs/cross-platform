<template>
	<view style="position: relative;">
		<view class="detail-header">
			<view class="detail-header-tip">
				我的金币
			</view>
			<view class="detail-header-row">
				<image src="/static/images/icon_money@2x.png" mode="" class="detail-header-icon"></image>
				<view class="detail-header-amount-row">
					<view class="detail-header-amount">
						56800
					</view>
					<view class="detail-header-unit">
						金
					</view>
				</view>
			</view>
		</view>
		<!-- tab bar -->
		<view class="tab-bar">
			<view v-for="(item, index) in tabs" :key="index" :data-index="index" :class="tabIndex == index ? 'tab-bar-title tab-bar-title-select' : 'tab-bar-title'" @click="tabSelectAction">
				{{item}}
				<!-- indicator -->
				<view class="tab-bar-indicator-mask">
					<view class="tab-bar-indicator" :style="tabIndex == index ? 'background-color: rgba(235, 102, 91, 1);' : ''"></view>
				</view>
			</view>
		</view>
		<!-- 列表 -->
		<view class="wallet-list" v-if="dataList.length > 0" style="top: 416rpx;">
			<view class="wallet-list-cell" v-for="(item, index) in dataList" :key="index">
				<view class="wallet-list-cell-column">
					<!-- 金额 -->
					<view class="wallet-list-cell-amount">
						-10000
					</view>
					<!-- 日期 -->
					<view class="wallet-list-cell-date">
						2020.07.15 12:00
					</view>
				</view>
				<view class="wallet-list-cell-status">
					<!-- color: rgba(50, 50, 50, 1); -->
					充值
				</view>
				<!-- 分割线 -->
				<view class="wallet-list-cell-line"></view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				dataList: [
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
				],
				tabs: [
					"全部",
					"充值",
					"提现",
				],
				tabIndex: 0,
			}
		},
		methods: {
			//tab
			tabSelectAction(res) {
				var index = res.currentTarget.dataset.index
				this.tabIndex = index 
			},
		}
	}
</script>

<style>
	@import url("wallet_recharge_detail.css");
	@import url("wallet_page.css");
</style>
