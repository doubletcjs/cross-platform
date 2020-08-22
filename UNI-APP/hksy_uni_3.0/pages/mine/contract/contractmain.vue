<template>
	<view class="contract-body main-body">
		<view class="main-body-sub">
			<view class="data-box" v-if="contractList.length > 0">
				<view class="contract-cell-wapper" v-for="(contract, index) in contractList" :key="index" :data-Index="index" @tap="functionItemAction"
				 :style="bottomLine(index, contractList)">
					<view class="contract-cell-content">
						<image src="/static/images/icon-ipf@3x.png" mode="aspectFit" class="contract-cell-image"></image>

						<view class="contract-cell-name">
							{{contract.contractNumber}}
						</view>
					</view>
					<image src="/static/images/ico-download@3x.png" mode="aspectFit" class="contract-cell-arrow"></image>
				</view>
				<view style="width: 100%;" v-if="contractList.length > 0">
					<uni-load-more iconType="auto" :status="moreStatus" :contentText="this.util.moreContentText" @clickLoadMore="loadMoreData"></uni-load-more>
				</view>
			</view>

			<view class="nodata" v-else>
				<nodata v-show="show" msg="暂无合同" msg2=""></nodata>
			</view>
		</view>
	</view>
</template>

<script>
	import nodata from '../../coin/componet/nodata.vue';
	import uniLoadMore from "../../../components/uni-load-more/uni-load-more.vue"
	import serviceapi from "../service/api/serviceapi.js"

	export default {
		data() {
			return {
				moreStatus: "more",
				limit: 10,
				page: 1,
				show: false, // 加载中不显示加载结果的图
				contractList: [],
				isInit: false // true 生成合同  false 得到合同列表
			}
		},
		components: {
			uniLoadMore,
			nodata
		},
		onPullDownRefresh() {
			if (this.isInit == false) {
				this.refreshData()
			} else {
				this.createContract() // 第一次进入页面，先生成合同，然后得到合同列表
			}
		},
		created() {
			this.isInit = true
			setTimeout(() => {
				uni.startPullDownRefresh({

				})
			}, 100) 
		},
		methods: {
			createContract() { // 生成合同
				var me = this
				serviceapi.createContract(this.util.userID(), (data, msg) => {
					me.isInit = false

					if (data) {
						me.requestData()
					} else {
						uni.showToast({
							title: msg,
							icon: "none"
						})
					}
				})
			},
			refreshData() {
				this.page = 1
				this.requestData(null)
			},
			loadMoreData() {
				this.moreStatuss = "loading"
				this.page += 1
				this.requestData(null)
			},
			requestData() { // 得到合同列表
				var me = this
				// 合同列表(分页)
				serviceapi.getContractDetail(this.util.userID(), this.page, this.limit, (data, mag) => {
					if (data) {
						var dataList = []
						dataList = dataList.concat(data.records)
						if (me.page == 1) {
							me.contractList = dataList
						} else {
							me.contractList = me.contractList.concat(dataList)
						}

						if (dataList.length == 0 && me.page > 1) {
							me.page -= 1
						}

						if (me.contractList.length == 0) {
							me.show = true;
						}

						if (me.page == data.pages || data.pages == 0) {
							me.moreStatus = "noMore"
						} else {
							me.moreStatus = "more"
						}
					} else {
						if (me.page > 1) {
							me.page -= 1
							me.moreStatus = "more"
						}

						if (me.page == 1) {
							me.show = true;
						}
					}

					uni.stopPullDownRefresh()
				})
			},
			functionItemAction(res) {
				var index = res.currentTarget.dataset.index
				var item = this.contractList[index]
				var fileUrl = this.networking.kQrcodeURL.replace(/4008/g, "808") + "/" + item.contractAddress
				console.log(fileUrl)

				// #ifdef APP-PLUS
				uni.showLoading({

				})
				uni.downloadFile({
					url: fileUrl,
					success: (data) => {
						uni.hideLoading()

						var filePath = data.tempFilePath.replace(/blob:/, "")
						uni.openDocument({
							filePath: filePath,
							fail(error) {
								uni.showToast({
									title: error.mag,
									icon: "none"
								})
							}
						})
					},
					fail(error) {
						uni.hideLoading()
						uni.showToast({
							title: error.mag,
							icon: "none"
						})
					}
				})
				// #endif

				// #ifdef H5
				window.open(fileUrl)
				// #endif
			},
			bottomLine(index, list) { // 生成一条线
				if (index == list.length - 1) {
					return ""
				} else {
					return "border-bottom: solid 2rpx rgba(145, 152, 173, 0.2); "
				}
			}
		}
	}
</script>

<style>
	@import url("contractmain.css");
</style>
