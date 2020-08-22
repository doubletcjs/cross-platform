<template>
	<view class="main-body">
		<view class="main-body-sub" style="margin-top: 0rpx;">
			<vipstorageheader :vipAssetsInfo="vipAssetsInfo" :rollout="vipRollout" v-if="isVip == true"></vipstorageheader>
			<storageheader :performance="performance" v-else></storageheader>
			<view class="storage-main-content-wapper" v-if="detailList.length > 0">
				<view v-if="isVip == true">
					<view class="storage-main-detail-title">
						分红明细
					</view>

					<view class="storage-main-cell-wapper" v-for="(detail, index) in detailList" :key="index" :style="bottomLine(index, detailList)">
						<view class="storage-main-cell-items-wapper">
							<view class="storage-main-cell-name">
								分红收益(个)
							</view>
							<view class="storage-main-cell-phone">
								{{detail.createTime}}
							</view>
						</view>
						<view class="storage-main-cell-value" v-if="detail.inOrOut == 0">
							-{{parseFloat(detail.amount).toFixed(2)}}
						</view>
						<view class="storage-main-cell-value" v-else>
							+{{parseFloat(detail.amount).toFixed(2)}}
						</view>
					</view>
				</view>
				<view v-else>
					<view class="storage-main-detail-title">
						直排业绩
					</view>

					<view class="storage-main-cell-wapper" v-for="(detail, index) in detailList" :key="index" :style="bottomLine(index, detailList)">
						<view class="storage-main-cell-items-wapper">
							<view class="storage-main-cell-name">
								{{detail.nickname}}
							</view>
							<view class="storage-main-cell-phone">
								{{detail.phone.substr(0,3)}}****{{detail.phone.substr(7)}}
							</view>
						</view>
						<view class="storage-main-cell-value">
							{{parseFloat(detail.experience).toFixed(2)}}
						</view>
					</view>
				</view>
			</view>
			<view class="nodata" v-else>
				<view class="storage-main-detail-title">
					直排业绩
				</view>
				<view class="no-msg">
					<text v-if="isVip == true">暂无分红信息~</text>
					<text v-else>暂无业绩信息~</text>
				</view>
			</view>
			<view style="width: 100%; background-color: rgba(21, 25, 54, 1);" v-if="detailList.length > 0">
				<uni-load-more iconType="auto" :status="moreStatus" :contentText="this.util.moreContentText" @clickLoadMore="loadMoreData"></uni-load-more>
			</view>
		</view>
	</view>
</template>

<script>
	import storageheader from "./views/storageheader.vue"
	import vipstorageheader from "./views/vipstorageheader.vue"
	import uniLoadMore from "../../components/uni-load-more/uni-load-more.vue"
	import storageapi from "./api/storageapi.js"
	import coinapi from "../coin/api/coinapi.js"

	export default {
		data() {
			return {
				isVip: false,
				performance: null,
				moreStatus: "more",
				page: 1,
				limit: 20,
				detailList: [],
				vipAssetsInfo: null,
				confrimRollout: false,
				rolloutInputValue: ""
			}
		},
		methods: {
			bottomLine(index, list) {
				if (index == list.length - 1) {
					return ""
				} else {
					return "border-bottom: solid 2rpx rgba(255, 255, 255, 0.2);"
				}
			},
			getPerformanceDatas() {
				storageapi.getPerformanceDatas(this.util.userID(), (data, msg) => {
					if (data) {
						this.performance = data
						this.refreshData()
					} else {
						uni.showToast({
							title: msg,
							icon: "none"
						})

						uni.stopPullDownRefresh()
					}
				})
			},
			requestData() {
				if (this.isVip == true) {
					storageapi.vipminerInfo(this.util.userID(), this.page, this.limit, (data, msg) => {
						if (data) {
							var dataList = []
							dataList = dataList.concat(data.pageObj.records)
							if (this.page == 1) {
								this.vipAssetsInfo = data
								// console.log("==" + JSON.stringify(data));
								this.detailList = dataList
							} else {
								this.detailList = this.detailList.concat(dataList)
							}

							if (dataList.length == 0 && this.page > 1) {
								this.page -= 1
							}

							if (this.page == data.pageObj.pages || data.pageObj.pages == 0) {
								this.moreStatus = "noMore"
							} else {
								this.moreStatus = "more"
							}
						} else {
							if (this.page > 1) {
								this.page -= 1
								this.moreStatus = "more"
							}
						}

						uni.stopPullDownRefresh()
					})
				} else {
					storageapi.getPerformanceDatasList(this.util.userID(), this.page, this.limit, (data, msg) => {
						if (data) {
							var dataList = []
							dataList = dataList.concat(data.records)
							if (this.page == 1) {
								this.detailList = dataList
							} else {
								this.detailList = this.detailList.concat(dataList)
							}

							if (dataList.length == 0 && this.page > 1) {
								this.page -= 1
							}

							if (this.page == data.pages || data.pages == 0) {
								this.moreStatus = "noMore"
							} else {
								this.moreStatus = "more"
							}
						} else {
							if (this.page > 1) {
								this.page -= 1
								this.moreStatus = "more"
							}
						}

						uni.stopPullDownRefresh()
					})
				}
			},
			refreshData() {
				this.page = 1
				this.requestData()
			},
			loadMoreData() {
				this.moreStatus = "loading"
				this.page += 1
				this.requestData()
			},
			vipRollout() {
				if (this.vipAssetsInfo != null) {
					
					let totalCoin = parseFloat(this.vipAssetsInfo.totalCoin).toFixed(2) // 总资产
					let limitCoin = parseFloat(this.vipAssetsInfo.limitCoin).toFixed(2) // 剩余转出额度
					// 那一个值小，就传那一个值过去
					// let rolloutValue = totalCoin > limitCoin ? limitCoin : totalCoin
					// console.log("=====" + rolloutValue);
					
					console.log(" totalCoin " + totalCoin + " limitcoin " + limitCoin);
					// 那一个值小，就传那一个值过去
					let rolloutValue = 0
					// let rolloutValue = giftcoin > limitcoin ? limitcoin : giftcoin
					console.log(totalCoin - limitCoin > 0);
					if(totalCoin - limitCoin > 0) {
						rolloutValue = limitCoin
					} else {
						rolloutValue = totalCoin
					}
					console.log("=====" + rolloutValue);
					
					uni.navigateTo({
						url: "../coin/cointransfers/cointransfersdetail?isVip=" + "true&rolloutValue=" + rolloutValue
					})
				}
			},
			textFieldOnchanged(res) {
				var textfieldText = res.target.value
				this.rolloutInputValue = textfieldText
			}
		},
		onPullDownRefresh() {
			if (this.isVip == true) {
				this.refreshData()
			} else {
				this.getPerformanceDatas()
			}
		},
		onLoad(params) {
			if (params != null && params["isVip"] == "true") {
				uni.setNavigationBarTitle({
					title: "超级存储"
				})

				this.isVip = true
			}
		},
		components: {
			storageheader,
			uniLoadMore,
			vipstorageheader,
		},
		created() {
			setTimeout(() => {
					uni.startPullDownRefresh({
				})
			}, 0)
			
			let me = this
			uni.$on("vip_strogae_refresh", () => { // 超级存储转出回调更新

				setTimeout(() => {

						if (this.isVip == true) { //不知为什么不能直接uni.startPullDownRefresh({})和onPullDownRefresh()
							this.refreshData()
						} else {
							this.getPerformanceDatas()
						}
						
				}, 0)
			})
		},
		onUnload() {
			console.log("onUnload--------");
			uni.$off("vip_strogae_refresh")
		}
	}
</script>

<style>
	@import url("storagemain.css");
	@import url("../inviteearnings/earningsdetail.css");
</style>
