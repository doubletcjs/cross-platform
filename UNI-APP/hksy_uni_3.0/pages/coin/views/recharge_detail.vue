<template>
	<view class="main-body">
		<view class="main-body-sub" style="margin-top: 0rpx;">
			<view class="nodata-box" v-if="detailList.length==0">
				<nodata v-show="show" msg="暂无订单"></nodata>
			</view>
			
			<view class="recharge-detail-cell-section-wapper">
				<view class="recharge-detail-cell-wapper" v-for="(detail, index) in detailList" :key="index" :style="bottomLine(index, detailList)">
					<view class="recharge-detail-cell-value-wapper">
						<view class="recharge-detail-cell-value">
							+{{parseFloat(detail.price).toFixed(2)}}
						</view>
						<view class="recharge-detail-cell-datetime-wapper">
							<view class="recharge-detail-cell-date">
								{{handleDate(detail.createTime)}}
							</view>
							<view class="recharge-detail-cell-time">
								{{handleTime(detail.createTime)}}
							</view>
						</view>
						<view class="recharge-detail-cell-failremark" v-if="detail.status == 2">
							{{detail.remark}}
						</view>
					</view>
					<view class="recharge-detail-cell-status" v-if="detail.status == 1">
						已充值
					</view>
					<view class="recharge-detail-cell-status" v-else-if="detail.status == 2" style="color: rgba(255, 52, 101, 1);">
						审核失败
					</view>
					<view class="recharge-detail-cell-status" v-else-if="detail.status == 3 || detail.status == 0">
						审核中
					</view>
				</view>
			</view>
			
			<view style="width: 100%;" v-if="detailList.length > 0">
				<uni-load-more iconType="auto" color="#9198AD" :status="moreStatus" :contentText="this.util.moreContentText" @clickLoadMore="loadMoreData"></uni-load-more>
			</view>
		</view>
	</view>
</template>

<script>
	import nodata from '../../coin/componet/nodata.vue'
	import uniLoadMore from "../../../components/uni-load-more/uni-load-more.vue"
	import coinapi from "../../coin/api/coinapi.js"
	
	export default {
		data() {
			return {
				moreStatus: "more",
				page: 1,
				limit: 10,
				show:false
			}
		},
		components: {
			uniLoadMore,
			nodata
		},
		onPullDownRefresh() {
			this.refreshData()
		},
		methods: {
			tabSelection(){
				
			},
			requestData() {
				coinapi.queryOfflinePayDetail(this.util.userID(), this.page, this.limit, (data, msg) => {
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
						this.show = true;
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
			}
		},
		created() {
			setTimeout(() => {
				uni.startPullDownRefresh({

				})
			}, 300)
		},
		onNavigationBarButtonTap() {
			uni.navigateTo({
				url: "../../mine/service/servicesweb"
			})
		}
	}
</script>

<style>
	@import url("rechargedetail.css");
</style>
