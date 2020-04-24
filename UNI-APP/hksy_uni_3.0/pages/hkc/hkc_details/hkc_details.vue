<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="tab-box" style="margin-top: 0;">
				<uniTab :current="currentIndex" :tabs="tabs" :selection="tabSelection"></uniTab>
			</view>
			<view class="data-box">
				<view class="" v-for="(list,index) in detailList" :key="index">
					<!-- 兑换 -->
					<view class="list" v-if="list.type == 33">
						<view class="list-item">
							<view class="list-item-left">
								<view class="price">
									<text>-{{list.hkcRate}}HKC</text>
								</view>
								<view class="time">{{ list.createTime }}</view>
								
							</view>
							<view class="list-item-right">
								<view class="status">兑换</view>
							</view>
						</view>
						<view class="line" v-if="getAll==1"></view>
						<view class="line"  v-else></view>
					</view>

					<!-- 互转的 -->
					<view class="list" v-else-if="list.type == 3 || list.type == 2">
						<view class="list-item">
							<view class="list-item-left">
								<view class="price">
									<text v-if="list.type == 3">-{{list.amount}}HKC</text>
									<text v-else>+{{list.amount}}HKC</text>
								</view>
								<view class="time">{{ list.createTime }}</view>
								<view class="time">对方帐户：{{list.otheraccont}}</view>
							</view>
							<view class="list-item-right" v-if="list.type == 3">
								<view class="status">转出</view>
							</view>
							<view class="list-item-right" v-else>
								<view class="status">转入</view>
							</view>
						</view>
						<view class="line"></view>
					</view>

				</view>

				<view style="width: 100%;margin-top: 10rpx;" v-if="detailList.length >= 0">
					<uni-load-more iconType="auto"  color="#9198AD" :status="moreStatus" :contentText="this.util.moreContentText"
					></uni-load-more>
					<!--  @clickLoadMore="loadMoreData" -->
				</view>
			</view>

			<view class="nodata">
				<nodata v-show="show" msg="暂无记录"></nodata>
			</view>
			
		</view>
	</view>
</template>

<script>
	import nodata from '../../coin/componet/nodata.vue';
	import uniTab from "../../../components/hksy-uni-tab/hksy-uni-tab.vue";
	import uniLoadMore from "../../../components/uni-load-more/uni-load-more.vue";
	
	export default {
		components: {
			nodata,
			uniTab,
			uniLoadMore
		},
		data() {
			return {
				moreStatus: "more",
				page: 1,
				limit: 10,
				show: false,
				currentIndex: 0,
				tabs: ["全部", "兑换", "互转"],
				detailList: [],
				getAll: 1
			}
		},
		onLoad() {
			uni.$on('clickLoadMore',(res)=>{
				this.loadMoreData(res)
			})
			this.getAllData()
		},
		onPullDownRefresh() {
			this.page = 1;
			if (this.currentIndex == 0) { // 全部
				this.getAllData()
			} else if (this.currentIndex == 1) { // 兑换
				this.getExchangeData()
			} else if (this.currentIndex == 2) { // 互转
				this.getTransformationData()
			}
			uni.stopPullDownRefresh();
		},
		methods: {
			tabSelection(index) {
				this.currentIndex = index;
				this.page = 1;
				this.currentIndex = index;
				if (this.currentIndex == 0) { // 全部
					this.getAll = 1;
					this.getAllData()
				} else if (this.currentIndex == 1) { // 兑换
					this.getAll = 0;
					this.getExchangeData()
				} else if (this.currentIndex == 2) { // 互转
					this.getAll = 0;
					this.getTransformationData()
				}
			},
			getAllData() { // 全部
				let _this = this;
				this.getAll = 1;
				if (this.page == 1) {
					this.detailList = [];
				}
				this.getExchangeData().then((res) => {
					console.log(res,11111)
					_this.getTransformationData().then((res) => {
						console.log(res,2222222)
					})
				})
			},
			getTransformationData() { // 互转
				let _this = this;
				return new Promise((reslove, reject) => {
					_this.networking.functionRequest('/queryHkcExchange', null, {
						userId: _this.util.userID(),
						page: _this.page,
						limit: _this.limit
					}, null, (data) => {
						if (data != null) {
							var dataList = []
							dataList = dataList.concat(data.records)
							if (_this.page == 1) {
								if (_this.getAll == 1) { // 全部
									let arr = _this.detailList;
									_this.detailList = [];
									_this.detailList = _this.detailList.concat(arr,dataList)
									uni.stopPullDownRefresh()
									if (data.records.length == 0) {
										reslove([]);
									} else {
										reslove(_this.detailList);
									}
									
								} else {
									_this.detailList = [];
									_this.detailList = dataList;
									uni.stopPullDownRefresh()
								}
							} else {
								uni.stopPullDownRefresh()
								if (_this.getAll == 1) {
									if (data.records.length == 0) {
										reslove([]);
									} else {
										reslove(_this.detailList);
									}
									let arr = _this.detailList;
									_this.detailList = [];
									_this.detailList = _this.detailList.concat(arr,dataList)
								} else {
									let arr = _this.detailList;
									_this.detailList = [];
									_this.detailList = _this.detailList.concat(arr,dataList)
								}

							}
							
							if (_this.page == data.pages || data.pages == 0 || dataList.length == 0) {
								_this.moreStatus = "noMore"
							} else {
								_this.moreStatus = "more"
							}
						} else {
							if (_this.page > 1) {
								_this.page -= 1
								_this.moreStatus = "more"
							}
							if (_this.page == 1) {
								_this.show = true;
								_this.detailList = [];
							}
						}
						uni.stopPullDownRefresh()
					})
				})
			},
			getExchangeData() { // 兑换
				let _this = this;
				return new Promise((reslove, reject) => {
					_this.networking.functionRequest('/queryUserHkc	', null, {
						userId: _this.util.userID(),
						page: _this.page,
						limit: _this.limit
					}, null, (data) => {
						console.log(data)
						if (data != null) {
							var dataList = []
							dataList = dataList.concat(data.records)
							dataList.forEach(function(value, index, dataList) {
								value.type = "33";
							})

							if (_this.page == 1) {
								if (_this.getAll == 1) { // 全部
									let arr = _this.detailList;
									_this.detailList = [];
									_this.detailList = _this.detailList.concat(arr,dataList)
									uni.stopPullDownRefresh()
									if (data.records.length == 0) {
										reslove([]);
									} else {
										reslove(_this.detailList);
									}
								} else {
									_this.detailList = [];
									_this.detailList = dataList;
									uni.stopPullDownRefresh()
								}
							} else {
								if (_this.getAll == 1) {
									if (data.records.length == 0) {
										reslove([]);
									} else {
										reslove(_this.detailList);
									}
									let arr = _this.detailList;
									_this.detailList = [];
									_this.detailList = _this.detailList.concat(arr,dataList)
								} else {
									let arr = _this.detailList;
									_this.detailList = [];
									_this.detailList = _this.detailList.concat(arr,dataList)
								}
							}
							
							if (_this.page == data.pages || data.pages == 0 || dataList.length == 0) {
								_this.moreStatus = "noMore"
							} else {
								_this.moreStatus = "more"
							}
						} else {
							if (_this.page > 1) {
								_this.page -= 1
								_this.moreStatus = "more"
							}
							if (_this.page == 1) {
								_this.show = true;
								_this.detailList = [];
							}
						}
						uni.stopPullDownRefresh()
					})
				})
			},
			loadMoreData() {
				this.moreStatus = "loading"
				this.page += 1;
				if (this.currentIndex == 0) { // 全部
					this.getAllData()
				} else if (this.currentIndex == 1) { // 兑换
					this.getExchangeData()
				} else if (this.currentIndex == 2) { // 互转
					this.getTransformationData()
				}
			},
			bottomLine(index, list) {
				if (index == list.length - 1) {
					return "background: transparent"
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
			}
		}
	}
</script>

<style scoped>
	@import url("hkc_details.css");
</style>
