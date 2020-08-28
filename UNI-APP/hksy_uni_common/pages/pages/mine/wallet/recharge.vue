<!-- 我的钱包=>金币充值 -->
<template>
	<view class="main-body">
		<view class="top_title">我的金币</view>
		<view class="myCoin_wrapper">
			<image class="coin_image" src="/../../../../../static/images/icon_money@2x.png" mode="aspectFit"></image>
			<view class="coin_text">
				{{ coin }}
				<span style="font-size:26rpx; font-weight: normal; margin-left: 4rpx;">元</span>
			</view>
		</view>
		<view class="recharge_wrapper">
			<view class="recharge_text">充值</view>
			<view class="tip_text">不提倡未成年人充值消费</view>
		</view>
		<view class="recharge_list">
			<view :class="index == selectPayIndex ? 'list_wrapper_select' :'list_wrapper'" v-for="(item, index) in rachargeList" :key="index" :data-index="index" @click="toSelectPayIndex">
				<view class="list_top">
					<image class="list_coin_image" src="/../../../../../static/images/icon_money@2x.png" mode="aspectFit"></image>
					<view class="list_coin_text" v-if="item.give == ''">{{ item.coin }}</view>
					<view class="list_coin_text" v-else>
					{{ item.coin }} <span class="list_coin_give_text">{{item.give}}</span>
					</view>
				</view>
				<view class="list_rmb">{{ item.rmb }}</view>
			</view>
		</view>
		<view class="coupon_wrapper">
			<view class="coupon_text">代金卷</view>
			<view class="select_coupon_text" @click="OCCouponDialog">{{couponText}}</view>
			<image class="coupon_image" src="/../../../../../static/images/arrows_left@2x.png" mode="aspectFit"></image>
		</view>
		<view class="button" @click="toPay">确认充值</view>
		<view class="tip_bottom_text">
			充值即代表同意
			<span style="color: #506FB0; margin-left: 10rpx;">街角充值协议</span>
		</view>

		<!-- 支付对话框 -->
		<payDialog :visible="payDialogVisible" :money="selectMoney" :discountsText="couponMoney" :closeAction="OCPayDialog" :itemTapAction="selectPayTypeAction"></payDialog>
		<!-- 优惠券对话框 -->
		<CouponDialog :visible="couponDialogVisible" title='优惠券' :closeAction="OCCouponDialog" :itemTapAction="selectCouponAction"></CouponDialog>
		
	</view>
</template>

<script>
import payDialog from './components/payDialog.vue';
import CouponDialog from './components/selectCouponDialog.vue';
export default {
	data() {
		return {
			rachargeList: [
				{ coin: '60', rmb: '￥6.00', give: '' },
				{ coin: '300', rmb: '￥30.00', give: '' },
				{ coin: '1280', rmb: '￥128.00', give: '+68' },
				{ coin: '3280', rmb: '￥328.00', give: '', give: '+328' },
				{ coin: '6480', rmb: '￥648.00', give: '+972' },
				{ coin: '12800', rmb: '￥1280.00', give: '+2560' }
			],
			coin: 1234,
			payDialogVisible: false,
			selectMoney: '',
			selectPayIndex: -1, // 选中那一个充值金额
			couponDialogVisible: false,
			couponText: '请选择代金券',
			couponMoney: '', // 代金券优惠金额
		};
	},
	methods: {
		// 打开和关闭选择支付对话框
		OCPayDialog() {
			this.payDialogVisible = !this.payDialogVisible;
		},
		// 打开和关闭选择优惠券对话框
		OCCouponDialog() {
			this.couponDialogVisible = !this.couponDialogVisible;
		},
		// 回调返回选中银行的名字
		selectPayTypeAction(res) {
			console.log(res);
			uni.navigateTo({
				url: 'rechargeSuccess'
			});
		},
		// 回调返回选中优惠券
		selectCouponAction(res) {
			
			if(res == "-1") {
				this.couponMoney = ""
				this.couponText = "请选择代金券"
			} else {
				this.couponMoney = res
				this.couponText = "已经优惠" + res + "元"
			}
			

		},
		// 选中那一个充值金额
		toSelectPayIndex(res) {
			let index = res.currentTarget.dataset.index;
			this.selectMoney = this.rachargeList[index].coin;
			this.selectPayIndex = index;
			
			
		},
		// 确认充值
		toPay(res) {
			if(this.selectPayIndex == -1) {
				uni.showToast({
					icon: 'none',
					title: '请选择充值金额',
				})
			} else {
				this.OCPayDialog();
			}
			
		}
	},
	components: {
		payDialog,
		CouponDialog
	}
};
</script>

<style>
.top_title {
	margin: 32rpx 32rpx 0rpx 32rpx;
	height: 37rpx;
	font-size: 26rpx;
	color: rgba(50, 50, 50, 1);
}

.myCoin_wrapper {
	margin-top: 32rpx;
	display: flex;
	flex-direction: row;
	justify-content: start;
	align-items: center;
	border-bottom: solid rgba(247, 246, 245, 1) 16rpx;
}

.coin_image {
	margin-left: 32rpx;
	margin-bottom: 59rpx;
	width: 56rpx;
	height: 56rpx;
}

.coin_text {
	margin-left: 11rpx;
	margin-bottom: 59rpx;
	height: 56rpx;
	font-size: 56rpx;
	font-weight: bold;
	line-height: 56rpx;
	color: rgba(50, 50, 50, 1);
}

.recharge_wrapper {
	margin: 26rpx 32rpx 0rpx 32rpx;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

.recharge_text {
	font-size: 32rpx;
	font-weight: bold;
	color: rgba(50, 50, 50, 1);
}

.tip_text {
	font-size: 24rpx;
	color: rgba(153, 153, 153, 1);
}

.recharge_list {
	margin: 25rpx 32rpx 0rpx 32rpx;
	display: flex;
	flex-direction: row;
	justify-content: space-between; /* 主轴上的对齐方式 */
	align-items: stretch;
	align-content: space-between; /* 多根轴线的对齐方式 */
	flex-wrap: wrap;
}

.list_wrapper {
	width: 32%;
	height: 141rpx;
	margin-top: 16rpx;

	background: rgba(247, 246, 245, 1);
	border:1px solid rgba(247, 246, 245, 1);
	border-radius: 16rpx;

	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.list_wrapper_select {
	
	width: 32%;
	height: 141rpx;
	margin-top: 16rpx;
	
	background:rgba(255,230,228,1);
	border:1px solid rgba(235,102,91,1);
	border-radius: 16rpx;
	
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	
}

.list_top {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	justify-content: flex-start;
	align-items: center;
}

.list_coin_image {
	width: 32rpx;
	height: 32rpx;
}

.list_coin_text {
	margin-left: 4rpx;
	font-size: 32rpx;
	font-weight: bold;
	color: rgba(50, 50, 50, 1);
}

.list_coin_give_text {
	font-size:24rpx;
	color:rgba(235,102,91,1);
}

.list_rmb {
	margin-top: 7rpx;
	font-size: 28rpx;
	color: rgba(153, 153, 153, 1);
}

.coupon_wrapper {
	margin-top: 49rpx;
	padding-left: 32rpx;
	padding-right: 32rpx;
	height: 112rpx;
	padding-top: 8rpx;

	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;

	border-top: solid 1rpx rgba(0, 0, 0, 0.05);
}

.coupon_text {
	width: 100rpx;
	font-size: 28rpx;
	font-weight: bold;
	color: rgba(50, 50, 50, 1);
}

.select_coupon_text {
	width: calc(100% - 100rpx);
	margin-right: 8rpx;
	text-align: right;
	font-size: 28rpx;
	color: rgba(153, 153, 153, 1);
}

.coupon_image {
	width: 15rpx;
	height: 24rpx;
}

.button {
	margin-top: 96rpx;
	margin-left: 32rpx;
	margin-right: 32rpx;
	height: 96rpx;
	background: rgba(235, 102, 91, 1);
	border-radius: 8rpx;

	font-size: 32rpx;
	line-height: 96rpx;
	text-align: center;
	color: rgba(255, 255, 255, 1);
}

.tip_bottom_text {
	margin: 64rpx 32rpx 88rpx 32rpx;
	font-size: 26rpx;
	text-align: center;
	color: #999999;
}
</style>
