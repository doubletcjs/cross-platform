<template>
	<view class="storage-header-wapper">
		<view class="storage-header-title">
			个人存储（T）
		</view>
		<view class="storage-header-content-wapper">
			<view class="storage-header-coin-wapper">
				<view class="storage-header-coin" v-if="performance == null">
					0
				</view>
				<view class="storage-header-coin" v-else>
					{{performance.storage}}
				</view>
				<view class="storage-header-coin-util" v-if="performance == null">
					T+0(积分)
				</view>
				<view class="storage-header-coin-util" v-else>
					T+{{performance.hkcstorage}}(积分)
				</view>
			</view>
			<view class="storage-header-buy-wapper" @tap="goProduct">
				<view class="storage-header-buy">
					继续购买
				</view>
				<image src="../../static/images/right_write_arrow@3x.png" mode="aspectFit" class="storage-header-buy-arrow"></image>
			</view>
		</view>
		<view class="storage-header-item-wapper">
			<view class="" v-for="(item, index) in items" :key="index">
				<view class="storage-header-item-value-wapper">
					<view class="storage-header-item-value" v-if="performance == null">
						0
					</view>
					<view v-else>
						<view class="storage-header-item-value" v-if="index==0">
							{{parseFloat(performance.before_yesterday_performance).toFixed(0)}}
						</view>
						<view class="storage-header-item-value" v-else-if="index==1">
							{{parseFloat(performance.yesterday_performance).toFixed(0)}}
						</view>
						<view class="storage-header-item-value" v-else-if="index==2">
							{{parseFloat(performance.expericence).toFixed(0)}}
						</view>
					</view>
					<view class="storage-header-item">
						{{item}}
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				items: ["前日业绩", "昨日业绩", "累计业绩"]
			}
		},
		methods: {
			goProduct() {
				uni.switchTab({
					url: "../store/storepage"
				})
			}
		},
		props: {
			performance: null
		}
	}
</script>

<style>
	@import url("storageheader.css");
</style>
