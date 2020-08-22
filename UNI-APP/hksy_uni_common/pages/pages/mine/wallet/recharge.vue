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
			<view class="list_wrapper" v-for="(item, index) in rachargeList" :key="index" :data-index="index" @click="toPay">
				<view class="list_top">
					<image class="list_coin_image" src="/../../../../../static/images/icon_money@2x.png" mode="aspectFit"></image>
					<view class="list_coin_text">{{ item.coin }}</view>
				</view>
				<view class="list_rmb">{{ item.rmb }}</view>
			</view>
		</view>
		<view class="tip_bottom_text">充值即代表同意<span style="color: #506FB0; margin-left: 10rpx;">街角充值协议</span></view>
		<!-- 支付对话框 -->
		<payDialog :visible="payDialogVisible" :money="selectMoney" :closeAction="OCPayDialog" :itemTapAction="selectPayTypeAction"></payDialog>
		
	</view>
</template>

<script>
import payDialog from './components/payDialog.vue';
export default {
	data() {
		return {
			rachargeList: [
				{ coin: "10", rmb: '￥1.00' },
				{ coin: "20", rmb: '￥2.00' },
				{ coin: "50", rmb: '￥5.00' },
				{ coin: "100", rmb: '￥10.00' },
				{ coin: "500", rmb: '￥50.00' },
				{ coin: "1000", rmb: '￥1000.00' },
				{ coin: "5000", rmb: '￥500.00' },
				{ coin: "10000", rmb: '￥1000.00' },
				{ coin: "50000", rmb: '￥5000.00' }
			],
			coin: 1234,
			payDialogVisible: false,
			selectMoney: ''
		};
	},
	methods: {
		// 打开和关闭选择支付对话框
		OCPayDialog() {
			this.payDialogVisible = !this.payDialogVisible
		},
		// 回调返回选中银行的名字
		selectPayTypeAction(res) {
			console.log(res);
			uni.navigateTo({
				url: "rechargeSuccess"
			})
		},
		toPay(res) {
			let index = res.currentTarget.dataset.index
			this.selectMoney = this.rachargeList[index].coin
			this.OCPayDialog()
		}
	},
	components: {
		payDialog
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
	
	background:rgba(247,246,245,1);
	border-radius:16rpx;
	
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
	margin-left: 8rpx;
	font-size:32rpx;
	font-weight:bold;
	color:rgba(50,50,50,1);
}

.list_rmb {
	margin-top: 7rpx;
	font-size:28rpx;
	color:rgba(153,153,153,1);
}

.tip_bottom_text {
	margin: 34rpx 32rpx 0rpx 32rpx;
	font-size:26rpx;
	color:#999999;
}

</style>
