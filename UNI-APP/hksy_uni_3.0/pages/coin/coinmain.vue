<template>
	<view class="main-body">
		<view class="main-body-sub" style="margin-top: 0rpx;">
			<coinheader :coin="headerCoin" :itemSelect="headerItemSelect"></coinheader>
			<view class="coin-main-content-wapper">
				<view class="coin-main-detail-title">
					<text>交易明细</text>
					<view class="right_arrow_box" @tap="goDetail">
						<text style="font-size: 26rpx;color: rgba(145,152,173,1);">更多</text>
						<image class="right_arrow" src="../../static/images/right_arrow@3x.png" mode=""></image>
					</view>
				</view>
				<view v-if="detailList.length > 0">
					<view class="coin-main-cell-wapper" v-for="(detail, index) in detailList" :key="index">
						<image src="/static/images/ico_mygold_list_cell_recharge@3x.png" class="coin-main-cell-icon" v-if="detail.type == 47 || detail.type == 43 || detail.type == 38"></image>
						<image
							src="/static/images/ico_mygold_list_cell_cashout@3x.png"
							class="coin-main-cell-icon"
							v-else-if="detail.type == 33 || detail.type == 63 || detail.type == 62"
						></image>
						<image src="/static/images/ico_mygold_list_cell_transfer@3x.png" class="coin-main-cell-icon" v-else></image>
						<view class="coin-main-cell-content-wapper" :style="bottomLine(index, detailList)">
							<view class="coin-main-cell-items-wapper">
								<view
									class="coin-main-cell-phone"
									v-if="detail.type == 47 || detail.type == 43 || detail.type == 38 || detail.type == 33 || detail.type == 63 || detail.type == 62"
								>
									{{ detail.myaccont.substr(0, 3) }}****{{ detail.myaccont.substr(7) }}
								</view>
								<view class="coin-main-cell-phone" v-else>{{ detail.otheraccont.substr(0, 3) }}****{{ detail.otheraccont.substr(7) }}</view>
								<view class="coin-main-cell-date-wapper">
									<view class="coin-main-cell-date">{{ handleDate(detail.createTime) }}</view>
									<view class="coin-main-cell-time">{{ handleTime(detail.createTime) }}</view>
								</view>
							</view>
							<view class="coin-main-cell-value" v-if="detail.inOrOut == 0">-{{ parseFloat(detail.amount).toFixed(2) }}</view>
							<view class="coin-main-cell-value" v-else>+{{ parseFloat(detail.amount).toFixed(2) }}</view>
						</view>
					</view>
				</view>
				<view v-else class="coin-main-no_record">暂无交易信息~</view>
			</view>
		</view>
		<view style="width: 100%; background-color: rgba(21, 25, 54, 1);" v-if="detailList.length > 0">
			<uni-load-more iconType="auto" :status="moreStatus" :contentText="this.util.moreContentText" @clickLoadMore="loadMoreData"></uni-load-more>
		</view>

		<uni-popup ref="certificationalert" type="center">
			<alertview
				title="提示"
				content="  您还没有实名认证，请实名认证后进行操作"
				confirmTitle="实名认证"
				isCertification="true"
				:cancelAction="closePopup"
				:confirmAction="goCertification"
			></alertview>
		</uni-popup>
	</view>
</template>

<script>
import coinheader from './views/coinheader.vue';
import uniLoadMore from '../../components/uni-load-more/uni-load-more.vue';
import coinapi from './api/coinapi.js';
import accountapi from '../account/api/accountapi.js';
import uniPopup from '../../components/uni-popup/uni-popup.vue';
import alertview from '../../components/hksy-uni-alertview/hksy-uni-alertview.vue';

export default {
	data() {
		return {
			moreStatus: 'more',
			page: 1,
			limit: 10,
			detailList: [],
			headerCoin: '0'
		};
	},
	methods: {
		goDetail() { // 更多
			uni.navigateTo({
				url: '../coin/recharge/rechargedetail?currentIndex=0'
			});
		},
		headerItemSelect(type) {
			if (type == '互转') {
				uni.navigateTo({
					url: './cointransfers/cointransfers'
				});
			} else if (type == 'USDT充值') {
				uni.navigateTo({
					url: './recharge/usdtrecharge'
				});
			} else if (type == '线下充值') {
				uni.navigateTo({
					url: './recharge/cashrecharge'
				});
			} else if (type == 'USDT提现') {
				uni.navigateTo({
					url: './withdraw/usdtwithdraw'
				});
			} else if (type == '现金提现') {
				if (this.util.userInfo().personalStatus == 1) {
					uni.navigateTo({
						url: './withdraw/cashwithdraw'
					});
				} else {
					this.$refs.certificationalert.open();
				}
			}
		},
		refreshUserInfo() {
			if (this.util.emptyObject(this.util.userID()) == false) {
				var me = this;
				accountapi.getUserInfo(this.util.userID(), (data, msg) => {
					if (data != null) {
						me.util.recordUserInfo(data);
						me.headerCoin = me.util.formatNumber(me.util.userInfo().coin);
						console.log('更新用户信息');
					}
				});
			}
		},
		requestData() {
			this.refreshUserInfo();
			coinapi.queryBalance(this.util.userID(), this.page, this.limit, (data, msg) => {
				if (data != null) {
					var dataList = [];
					dataList = dataList.concat(data.records);
					if (this.page == 1) {
						this.detailList = dataList;
					} else {
						this.detailList = this.detailList.concat(dataList);
					}
					if (dataList.length == 0 && this.page > 1) {
						this.page -= 1;
					}
					if (this.page == data.pages || data.pages == 0) {
						this.moreStatus = 'noMore';
					} else {
						this.moreStatus = 'more';
					}
				} else {
					if (this.page > 1) {
						this.page -= 1;
						this.moreStatus = 'more';
					}
				}

				uni.stopPullDownRefresh();
			});
		},
		refreshData() {
			this.page = 1;
			this.requestData();
		},
		loadMoreData() {
			this.moreStatus = 'loading';
			this.page += 1;
			this.requestData();
		},
		bottomLine(index, list) {
			if (index == list.length - 1) {
				return '';
			} else {
				return 'border-bottom: solid 2rpx rgba(255, 255, 255, 0.2); ';
			}
		},
		closePopup() {
			this.$refs.certificationalert.close();
		},
		goCertification() {
			this.closePopup();
			uni.navigateTo({
				url: '../account/certification/certificationcenter'
			});
		},
		handleDate(res) {
			var date = res.split(' ')[0];
			return date;
			// return date.split("-")[1] + "-" + date.split("-")[2]
		},
		handleTime(res) {
			var time = res.split(' ')[1];
			return time.split(':')[0] + ':' + time.split(':')[1];
		}
	},
	components: {
		coinheader,
		uniLoadMore,
		uniPopup,
		alertview
	},
	onPullDownRefresh() {
		this.refreshData();
	},
	created() {
		setTimeout(() => {
			uni.startPullDownRefresh({});
		});

		uni.$on(this.kAccountRefresh, () => {
			this.refreshData();
		});
	},
	onShow() {
		this.headerCoin = this.util.formatNumber(this.util.userInfo().coin);
		if (this.detailList.length == 0) {
			uni.startPullDownRefresh({});
		}
	}
};
</script>

<style>
@import url('coinmain.css');
</style>
