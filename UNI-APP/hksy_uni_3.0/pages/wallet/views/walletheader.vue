<template>
	<view class="wallet-header-header-wapper">
		<view class="wallet-header-header-title">
			FIL 币资产（个)
		</view>
		<view class="wallet-header-header-content-wapper">
			<view class="wallet-header-header-assets" v-if="earningsForUser == null">
				0
			</view>
			<view class="wallet-header-header-assets" v-else>
				{{parseFloat(earningsForUser.giftcoin).toFixed(2)}}
			</view>
			<view class="wallet-header-header-rollout-wapper" @tap="rollout">
				<view class="wallet-header-header-rollout">
					FIL币转出
				</view>
				<image src="../../static/images/right_write_arrow@3x.png" mode="aspectFit" class="wallet-header-header-rollout-arrow"></image>
			</view>
		</view>
		<view class="wallet-header-header-item-wapper">
			<view class="wallet-header-header-item-value-wapper" v-for="(item, index) in items" :key="index">
				<view class="wallet-header-header-item-value" v-if="earningsForUser == null">
					0
				</view>
				<view v-else>
					<view class="wallet-header-header-item-value" v-if="index==0">
						{{parseFloat(earningsForUser.limitcoin).toFixed(2)}}
					</view>
					<view class="wallet-header-header-item-value" v-else-if="index==1">
						{{parseFloat(earningsForUser.todayEarnings).toFixed(2)}}
					</view>
					<view class="wallet-header-header-item-value" v-else-if="index==2">
						{{parseFloat(earningsForUser.yesterdayEarnings).toFixed(2)}}
					</view>
				</view>
				<view class="wallet-header-header-item">
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
				items: ["昨日收益", "累计收益", "平台昨日总收益"]
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
	@import url("walletheader.css");
</style>
