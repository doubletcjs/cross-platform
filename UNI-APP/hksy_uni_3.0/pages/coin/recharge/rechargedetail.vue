<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="tab-box" style="margin-top: 0;">
				<uniTab :current="currentIndex" :tabs="tabs" :selection="tabSelection"></uniTab>
			</view>
			<view class="data-box" v-if="detailList.length > 0">
				<view class="" v-for="(list,index) in detailList" :key="index">
					<!-- 充值的 -->
					<view class="list" v-if="list.type == 47">
						<view class="list-item">
							<view class="list-item-left">
								<view class="price">
									<text>+{{list.price}}</text>
								</view>
								<view class="time">{{ list.createTime }}</view>
								<view v-if="list.status == 2" class="msg error" style="font-size: 22rpx;margin-top: 15rpx;">{{list.remark}}</view>
							</view>
							<view class="list-item-right" v-if="list.status == 1">
								<view class="status">已充值</view>
							</view>
							<view class="list-item-right" v-else-if="list.status == 0 || list.status == 3">
								<view class="status">审核中</view>
							</view>
							<view class="list-item-right" v-else>
								<view class="status" style="color: #FF3465;">审核失败</view>
							</view>
						</view>
						<view class="line"></view>
					</view>
					<!-- 提现的 -->
					<view class="list" v-else-if="list.type == 33">
						<view class="list-item">
							<view class="list-item-left">
								<view class="price">
									<text>-{{list.cashNumber}}</text>
								</view>
								<view class="time">{{ list.createTime }}</view>
								<view class="msg error" v-if="list.cashStatus==2" style="font-size: 22rpx;margin-top: 15rpx;">{{ list.verifyInfo }}</view>
							</view>
							<view class="list-item-right" v-if="list.cashStatus==1">
								<view class="status">已提现</view>
							</view>
							<view class="list-item-right" v-else-if="list.cashStatus==0 || list.cashStatus==3">
								<view class="status">审核中</view>
							</view>
							<view class="list-item-right" v-else>
								<view class="status" style="color: #FF3465;">审核失败</view>
							</view>
						</view>
						<view class="line"></view>
					</view>
					<!-- 互转的 -->
					<view class="list" v-else-if="list.type == 24">
						<view class="list-item">
							<view class="list-item-left">
								<view class="price">
									<text v-if="list.inOrOut==0">-{{list.amount}}</text>
									<text v-else>+{{list.amount}}</text>
								</view>
								<view class="time">{{ list.createTime }}</view>
								<view class="time">对方账户：{{list.otheraccont}}</view>
							</view>
							<view class="list-item-right" v-if="list.inOrOut==0">
								<view class="status">已转出</view>
							</view>
							<view class="list-item-right" v-else>
								<view class="status">已转入</view>
							</view>
						</view>
						<view class="line"></view>
					</view>
				</view>
			</view>

			<view class="nodata" v-else>
				<nodata v-show="show" msg="暂无订单"></nodata>
			</view>

			<view style="width: 100%;" v-if="detailList.length > 0">
				<!-- @clickLoadMore="loadMoreData" -->
				<uni-load-more iconType="auto" color="#9198AD" :status="moreStatus" :contentText="this.util.moreContentText"></uni-load-more>
			</view>
		</view>
	</view>
</template>

<script>
	import uniTab from "../../../components/hksy-uni-tab/hksy-uni-tab.vue"
	import nodata from '../componet/nodata.vue'
	import uniLoadMore from "../../../components/uni-load-more/uni-load-more.vue"
	import coinapi from "../api/coinapi.js"


	export default {
		data() {
			return {
				moreStatus: "more",
				page: 1,
				limit: 10,
				show: false,
				currentIndex: 0,
				tabs: ["全部", "充值", "提现", "互转"],
				detailList: [],
				getAll: 1
			}
		},
		components: {
			uniLoadMore,
			nodata,
			uniTab
		},
		onPullDownRefresh() {
			this.refreshData()
		},
		onLoad(options) {
			this.currentIndex = options.currentIndex;
			this.moreStatus = "more";
			
			if (this.currentIndex == 0) { // 全部
				this.page = 1;
				this.requestDataAll();
			} else if (this.currentIndex == 1) { // 充值
				this.page = 1;
				this.getAll = 0;
				this.requestData()
			} else if (this.currentIndex == 2) { // 提现
				this.page = 1;
				this.getAll = 0;
				this.requesTwithdrawData()
			} else if (this.currentIndex == 3) { // 互转
				this.page = 1;
				this.getAll = 0;
				this.requestExchangeData()
			}
			
			uni.$on('clickLoadMore', (res) => {
				this.loadMoreData(res);
			})
		},
		onUnload() {
			uni.$off('clickLoadMore');
		},
		methods: {
			tabSelection(index) {
				this.currentIndex = index;
				this.moreStatus = "more";
				if (this.currentIndex == 0) { // 全部
					this.page = 1;
					this.requestDataAll();
				} else if (this.currentIndex == 1) { // 充值
					this.page = 1;
					this.getAll = 0;
					this.requestData()
				} else if (this.currentIndex == 2) { // 提现
					this.page = 1;
					this.getAll = 0;
					this.requesTwithdrawData()
				} else if (this.currentIndex == 3) { // 互转
					this.page = 1;
					this.getAll = 0;
					this.requestExchangeData()
				}
			},
			requestDataAll() { // 全部 
				this.getAll = 1;
				if (this.page == 1) {
					this.detailList = [];
				}

				var _this = this;
				console.log("总长度:" + this.detailList.length)
				var isNoMore = false;
				this.requestData().then((res) => {
					console.log("充值长度:" + res.length)
					_this.detailList = _this.detailList.concat([], res);
					if (res.length < _this.limit) {
						isNoMore = true;
					} else {
						isNoMore = false;
					}

					_this.requesTwithdrawData().then((res) => {
						console.log("提现长度:" + res.length)
						_this.detailList = _this.detailList.concat([], res);
						if (res.length < _this.limit) {
							isNoMore = true;
						} else {
							isNoMore = false;
						}

						_this.requestExchangeData().then((res) => {
							console.log("互转长度:" + res.length)
							_this.detailList = _this.detailList.concat([], res);
							if (res.length < _this.limit) {
								isNoMore = true;
							} else {
								isNoMore = false;
							}

							console.log("总长度3:" + _this.detailList.length)
							if (isNoMore == true) {
								_this.moreStatus = "noMore"
							} else {
								_this.moreStatus = "more"
							}

							if (_this.detailList.length == 0) {
								_this.show = true;
							}
						})
					})
				})
			},
			requestExchangeData() { // 互转
				// tbr/queryGoldExchange
				let _this = this;
				return new Promise((reslove, reject) => {
					_this.networking.functionRequest('/queryGoldExchange', null, {
						userId: _this.util.userID(),
						current: _this.page,
						size: _this.limit
					}, null, (data) => {
						if (data) {
							var dataList = []
							dataList = dataList.concat(data.records)
							if (_this.page == 1) {
								if (_this.getAll == 1) { // 全部 
									if (data.records.length == 0) {
										reslove([]);
									} else {
										reslove(dataList);
									}
									// let arr = _this.detailList;
									// _this.detailList = []; 
									// _this.detailList = _this.detailList.concat(arr, dataList);
								} else {
									_this.detailList = [];
									_this.detailList = dataList;
									console.log("requestExchangeData");
									if (_this.detailList.length == 0) {
										_this.show = true;
									}
								}
							} else {
								if (_this.getAll == 1) {
									if (data.records.length == 0) {
										reslove([]);
									} else {
										reslove(dataList);
									}
									// let arr = _this.detailList;
									// _this.detailList = [];
									// _this.detailList = _this.detailList.concat(arr, dataList);
								} else {
									let arr = _this.detailList;
									_this.detailList = [];
									_this.detailList = _this.detailList.concat(arr, dataList);
								}

							}
							// if (dataList.length == 0 && _this.page > 1 && _this.getAll != 1) {
							// 	_this.page -= 1
							// }

							if (_this.getAll != 1) {
								if (_this.page == data.pages || data.pages == 0 || dataList.length == 0) {
									_this.moreStatus = "noMore"
								} else {
									_this.moreStatus = "more"
								}
							}
						} else {
							if (_this.getAll != 1) {
								if (_this.page > 1) {
									_this.page -= 1
									_this.moreStatus = "more"
								}
								if (_this.page == 1) {
									_this.show = true;
									_this.detailList = [];
								}
							}
						}

						uni.stopPullDownRefresh()
					})
				})

			},
			requesTwithdrawData() { // 提现 networking.functionRequest("/transfer", null, params, null, completion)
				let _this = this;
				return new Promise((reslove, reject) => {
					_this.networking.functionRequest('/queryTbWithdrawadLog', null, {
						userId: _this.util.userID(),
						current: _this.page,
						size: _this.limit
					}, null, (data) => {
						if (data) {
							var dataList = []
							dataList = dataList.concat(data.records)
							dataList.forEach(function(value, index, dataList) {
								value.type = "33";
							})

							if (_this.page == 1) {
								if (_this.getAll == 1) { // 全部
									uni.stopPullDownRefresh()
									if (data.records.length == 0) {
										reslove([]);
									} else {
										reslove(dataList);
									}
									// let arr = _this.detailList;
									// _this.detailList = [];
									// _this.detailList = _this.detailList.concat(arr, dataList);
								} else {
									_this.detailList = [];
									_this.detailList = dataList;
									if (_this.detailList.length == 0) {
										_this.show = true;
									}
									console.log("requesTwithdrawData");
								}
							} else {
								if (_this.getAll == 1) {
									if (data.records.length == 0) {
										reslove([]);
									} else {
										reslove(dataList);
									}
									// let arr = _this.detailList;
									// _this.detailList = [];
									// _this.detailList = _this.detailList.concat(arr, dataList);
								} else {
									let arr = _this.detailList;
									_this.detailList = [];
									_this.detailList = _this.detailList.concat(arr, dataList)
								}
							}
							// if (dataList.length == 0 && _this.page > 1  && _this.getAll != 1) {
							// 	_this.page -= 1
							// }

							if (_this.getAll != 1) {
								if (_this.page == data.pages || data.pages == 0 || dataList.length == 0) {
									_this.moreStatus = "noMore"
								} else {
									_this.moreStatus = "more"
								}
							}
						} else {
							if (_this.getAll != 1) {
								if (_this.page > 1) {
									_this.page -= 1
									_this.moreStatus = "more"
								}
								if (_this.page == 1) {
									_this.show = true;
									_this.detailList = [];
								}
							}
						}

						uni.stopPullDownRefresh()
					})
				})

			},
			requestData() { // 充值
				let _this = this;
				return new Promise((reslove, reject) => {
					coinapi.queryOfflinePayDetail(_this.util.userID(), _this.page, _this.limit, (data, msg) => {
						if (data) {
							var dataList = []
							dataList = dataList.concat(data.records)
							dataList.forEach(function(value, index, dataList) {
								value.type = "47";
							})
							if (_this.page == 1) {
								if (_this.getAll == 1) { // 全部 
									if (data.records.length == 0) {
										reslove([]);
									} else {
										reslove(dataList);
									}
									// let arr = _this.detailList;
									// _this.detailList = [];
									// _this.detailList = _this.detailList.concat(arr, dataList);
								} else {
									_this.detailList = [];
									_this.detailList = dataList;
									if (_this.detailList.length == 0) {
										_this.show = true;
									}
									console.log("requestData");
								}
							} else {
								if (_this.getAll == 1) {
									if (data.records.length == 0) {
										reslove([]); 
									} else {
										reslove(dataList);
									}
									// let arr = _this.detailList;
									// _this.detailList = [];
									// _this.detailList = _this.detailList.concat(arr, dataList);
								} else {
									let arr = _this.detailList;
									_this.detailList = [];
									_this.detailList = _this.detailList.concat(arr, dataList)
								}
							}
							// if (dataList.length == 0 && _this.page > 1 && _this.getAll != 1) {
							// 	_this.page -= 1
							// }

							if (_this.getAll != 1) {
								if (_this.page == data.pages || data.pages == 0 || dataList.length == 0) {
									_this.moreStatus = "noMore"
								} else {
									_this.moreStatus = "more"
								}
							}
						} else {
							if (_this.getAll != 1) {
								if (_this.page > 1) {
									_this.page -= 1
									_this.moreStatus = "more"
								}
								if (_this.page == 1) {
									_this.show = true;
									_this.detailList = [];
								}
							}
						}

						uni.stopPullDownRefresh()
					})
				})

			},
			refreshData() {
				this.page = 1;
				if (this.currentIndex == 0) { // 全部
					this.requestDataAll()
				} else if (this.currentIndex == 1) { // 充值
					this.requestData()
				} else if (this.currentIndex == 2) { // 提现
					this.requesTwithdrawData()
				} else if (this.currentIndex == 3) { // 互转
					this.requestExchangeData()
				}
			},
			loadMoreData(res) {
				console.log("loadMoreData");
				console.log(res);
				this.moreStatus = "loading"
				this.page += 1;
				if (this.currentIndex == 0) { // 全部
					this.requestDataAll()
				} else if (this.currentIndex == 1) { // 充值
					this.requestData()
				} else if (this.currentIndex == 2) { // 提现
					this.requesTwithdrawData()
				} else if (this.currentIndex == 3) { // 互转
					this.requestExchangeData()
				}
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
					return "background: transparent"
				}
			}
		},
		created() {
			setTimeout(() => {
				// uni.startPullDownRefresh({

				// })
				uni.stopPullDownRefresh()
			}, 300)

		},
		onNavigationBarButtonTap() { // 客服
			uni.navigateTo({
				url: "../../mine/service/servicesweb"
			})
		}
	}
</script>

<style>
	@import url("rechargedetail.css");
</style>
