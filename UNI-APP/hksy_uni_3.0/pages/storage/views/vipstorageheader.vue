<template>
	<view class="vip-storage-header-wapper">
		<view class="vip-storage-header-title">
			总资产（个）
		</view>
		<view class="vip-storage-header-content-wapper">
			<view class="vip-storage-header-assets" v-if="vipAssetsInfo == null">
				0.0
			</view>
			<view class="vip-storage-header-assets" v-else>
				{{this.util.formatNumber(vipAssetsInfo.totalCoin)}}
			</view>
			<view class="vip-storage-header-rollout-wapper" @tap="rollout">
				<view class="vip-storage-header-rollout">
					转出
				</view>
				<image src="../../static/images/right_arrow_gold@3x.png" mode="aspectFit" class="vip-storage-header-rollout-arrow"></image>
			</view>
		</view>
		<view class="vip-storage-header-item-wapper">
			<view class="vip-storage-header-item-value-wapper" v-for="(item, index) in items" :key="index">
				<view class="vip-storage-header-item-value" v-if="vipAssetsInfo == null">
					0
				</view>
				<view v-else>
					<view class="vip-storage-header-item-value" v-if="index==0">
						{{vipAssetsInfo.limitCoin}}
					</view>
					<view class="vip-storage-header-item-value" v-else-if="index==1">
						{{vipAssetsInfo.yesterdayEarnings}}
					</view>
				</view>
				<view class="vip-storage-header-item">
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
				items: ["剩余转出额度", "昨日分红"]
			}
		},
		methods: {

		},
		props: {
			vipAssetsInfo: null,
			rollout: Function
		}
	}
</script>

<style>
	@import url("vipstorageheader.css");
</style>
