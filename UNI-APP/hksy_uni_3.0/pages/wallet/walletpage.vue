<template>
	<view class="main-body">
		<view class="main-body-sub">
			<detailHeader :earningsForUser="earningsForUser" :rollout="rolloutAction"></detailHeader>
			<view class="wallet-main-content-wapper">
				<view class="wallet-main-detail-title">
					<text>交易明细</text>
					<view class="right_arrow_box" @tap="goDetail">
						<text style="font-size: 26rpx;color: rgba(145,152,173,1);">更多</text>
						<image class="right_arrow" src="/static/images/right_arrow@3x.png" mode=""></image>
					</view>
				</view>
				<view v-if="detailList.length > 0">
					<view class="wallet-main-cell-wapper" v-for="(detail, index) in detailList" :key="index" :style="bottomLine(index, detailList)">
						<view class="wallet-base-column" style="width: 100%;">
							<view class="wallet-base-row" style="justify-content: space-between;">
								<view class="wallet-status-text">收益</view>
								<view class="wallet-status-text">+1800</view>
							</view>
							<view class="wallet-base-row" style="margin-top: 19rpx;">
								<view class="wallet-date-text">2020-10-11</view>
								<view class="wallet-time-text">17：48</view>
							</view>
						</view>
					</view>
				</view>
				<view v-else class="wallet-main-no_record">暂无交易信息~</view>
			</view>
			<view style="width: 100%; background-color: rgba(21, 25, 54, 1);" v-if="detailList.length > 0">
				<uni-load-more iconType="auto" :status="moreStatus" :contentText="this.util.moreContentText" @clickLoadMore="loadMoreData"></uni-load-more>
			</view>
		</view>
	</view>
</template>

<script>
	import detailHeader from "./views/walletheader.vue"

	export default {
		data() {
			return {
				earningsForUser: null,
				moreStatus: 'more',
				page: 1,
				limit: 10,
				detailList: [
					"",
					"",
					"",
					"",
					"",
					"",
					"",
				]
			}
		},
		methods: {
			rolloutAction() {
				uni.navigateTo({
					url: './walletrollout'
				});
			},
			goDetail() {
				uni.navigateTo({
					url: '../coin/recharge/rechargedetail?currentIndex=0'
				});
			},
			bottomLine(index, list) {
				if (index == list.length - 1) {
					return '';
				} else {
					return 'border-bottom: solid 2rpx rgba(255, 255, 255, 0.2); ';
				}
			}
		},
		components: {
			detailHeader
		}
	}
</script>

<style>
	@import url("walletpage.css");
</style>
