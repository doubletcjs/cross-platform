<template>
	<view class="earnings-detail-header-wapper">
		<view class="earnings-detail-header-title">
			总资产（个）
		</view>
		<view class="earnings-detail-header-content-wapper">
			<view class="earnings-detail-header-assets" v-if="earningsForUser == null">
				0
			</view>
			<view class="earnings-detail-header-assets" v-else>
				{{parseFloat(earningsForUser.giftcoin).toFixed(2)}}
			</view>
			<view class="earnings-detail-header-rollout-wapper" @tap="rollout">
				<view class="earnings-detail-header-rollout">
					转出
				</view>
				<image src="../../static/images/right_write_arrow@3x.png" mode="aspectFit" class="earnings-detail-header-rollout-arrow"></image>
			</view>
		</view>
		<view class="earnings-detail-header-item-wapper">
			<view class="earnings-detail-header-item-value-wapper" v-for="(item, index) in items" :key="index">
				<view class="earnings-detail-header-item-value" v-if="earningsForUser == null">
					0
				</view>
				<view v-else>
					<view class="earnings-detail-header-item-value" v-if="index==0">
						{{parseFloat(earningsForUser.limitcoin).toFixed(2)}}
					</view>
					<view class="earnings-detail-header-item-value" v-else-if="index==1">
						{{parseFloat(earningsForUser.todayEarnings).toFixed(2)}}
					</view>
					<view class="earnings-detail-header-item-value" v-else-if="index==2">
						{{parseFloat(earningsForUser.yesterdayEarnings).toFixed(2)}}
					</view> 
				</view>
				<view class="earnings-detail-header-item">
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
				// items: ["昨日收益","今日收益", "剩余转出额度"],
				items: ["剩余转出额度", "今日收益", "昨日收益"]
			}
		},
		methods: { 
			
		},
		props: {
			earningsForUser: null,
			rollout: Function
		}
	}
</script>

<style>
	@import url("earningsdetailheader.css");
</style>
