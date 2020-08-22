<template>
	<view class="main-body">
		<view class="main-body-sub">
			<detailHeader :earningsForUser="earningsForUser" :rollout="rolloutAction"></detailHeader>
			<view class="earnings-detail-content-wapper" v-if="earningsDetailList.length > 0">
				<view class="earnings-detail-detail-title">
					邀请收益明细
				</view>
				<view class="earnings-detail-cell-wapper" v-for="(detail, index) in earningsDetailList" :key="index" :style="bottomLine(index, earningsDetailList)">
					<view class="earnings-detail-cell-items-wapper">
						<view class="earnings-detail-cell-phone">
							{{detail.phone.substr(0,3)}}****{{detail.phone.substr(7)}}
						</view>
						<view class="earnings-detail-cell-date-wapper">
							<view class="earnings-detail-cell-date">
								{{handleDate(detail.createTime)}}
							</view>
							<view class="earnings-detail-cell-time">
								{{handleTime(detail.createTime)}}
							</view>
						</view>
					</view>
					<view class="earnings-detail-cell-value" v-if="detail.inOrOut == 0">
						-{{parseFloat(detail.amount).toFixed(2)}}
					</view>
					<view class="earnings-detail-cell-value" v-else>
						+{{parseFloat(detail.amount).toFixed(2)}}
					</view>
				</view>
			</view>
			<view class="no-data" v-else>
				<view class="earnings-detail-detail-title">
					邀请收益明细
				</view>
				<view class="nodata-text">
					暂无收益信息~
				</view>
			</view>
			<view style="width: 100%; background-color: rgba(21, 25, 54, 1);" v-if="earningsDetailList.length > 0">
				<uni-load-more iconType="auto" :status="moreStatus" :contentText="this.util.moreContentText" @clickLoadMore="loadMoreData"></uni-load-more>
			</view>
		</view>
	</view>
</template>

<script>
	import uniLoadMore from "../../components/uni-load-more/uni-load-more.vue"
	import detailHeader from "./views/earningsdetailheader.vue"
	import inviteearningsapi from "./api/inviteearningsapi.js"
	// import uniPopup from "../../components/uni-popup/uni-popup.vue"
	import coinapi from "../coin/api/coinapi.js"

	export default {
		data() {
			return {
				moreStatus: "more",
				page: 1,
				limit: 10,
				earningsForUser: null,
				earningsDetailList: [],
				confrimRollout: false,
				rolloutInputValue: ""
			}
		},
		methods: {
			getEarningsForUser() {
				inviteearningsapi.getEarningsForUser(this.util.userID(), (data, msg) => {
					if (data) {
						this.earningsForUser = data
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
				inviteearningsapi.getEarningsDetailForUser(this.util.userID(), this.page, this.limit, (data, msg) => {
					if (data) {
						var dataList = []
						dataList = dataList.concat(data.records)
						if (this.page == 1) {
							this.earningsDetailList = dataList
						} else {
							this.earningsDetailList = this.earningsDetailList.concat(dataList)
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
			handleDate(res) {
				var date = res.split(" ")[0]
				return date
				// return date.split("-")[1] + "-" + date.split("-")[2]
			},
			handleTime(res) {
				var time = res.split(" ")[1]
				return time.split(":")[0] + ":" + time.split(":")[1]
			},
			bottomLine(index, list) {
				if (index == list.length - 1) {
					return ""
				} else {
					return "border-bottom: solid 2rpx rgba(255, 255, 255, 0.2); "
				}
			},
			rolloutAction() {
				console.log(555)
				let giftcoin = parseFloat(this.earningsForUser.giftcoin).toFixed(2) // 总资产
				let limitcoin = parseFloat(this.earningsForUser.limitcoin).toFixed(2) // 剩余转出额度
				console.log(" giftcoin " + giftcoin + " limitcoin " + limitcoin);
				// 那一个值小，就传那一个值过去
				let rolloutValue = 0
				// let rolloutValue = giftcoin > limitcoin ? limitcoin : giftcoin
				console.log(giftcoin - limitcoin > 0);
				if (giftcoin - limitcoin > 0) {
					rolloutValue = limitcoin
				} else {
					rolloutValue = giftcoin
				}
				console.log("=====" + rolloutValue);
				uni.navigateTo({
					url: "../coin/cointransfers/cointransfersdetail?isVip=" + "false&rolloutValue=" + rolloutValue
				})
			},
			closeRolloutAction() {
				this.$refs.rolloutpopup.close()
				var me = this
				setTimeout(() => {
					me.rolloutInputValue = ""
					me.confrimRollout = false
				}, 300)
			},
			textFieldOnchanged(res) {
				var textfieldText = res.target.value
				this.rolloutInputValue = textfieldText
			}
		},
		components: {
			uniLoadMore,
			detailHeader,
			// uniPopup
		},
		created() {
			if (this.earningsDetailList.length == 0) {
				this.getEarningsForUser()
			}

			var me = this
			uni.$on("inviterefresh_0", () => {
				me.getEarningsForUser()
			})
		},
		onLoad() {
			let me = this;
			uni.$on('rollout', function() {
				me.rolloutAction()
			})
		}
	}
</script>

<style>
	@import url("earningsdetail.css");
</style>
