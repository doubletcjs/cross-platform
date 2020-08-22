<!-- 我的钱包=>金币提现=>银行卡列表界面=>添加银行卡第一步 -->
<template>
	<view class="main-body">
		<view class="main_offset">
			<view class="title">添加银行卡</view>
			<view class="tip">为了保障您的资金安全，请绑定的是您名下的银行卡</view>
			<view class="input_wrapper">
				<input class="input_cardNO" v-model="inputValue" placeholder="请输入您的银行卡号" placeholder-class="input_cardNO_placeholder" :maxlength="23" @click="clear" />
				<image class="clear" src="../../../../../static/images/clear@2x.png" mode="aspectFit" @click="clear"></image>
			</view>
			<view class="bankName_wrapper" :style="inputValue ? 'visibility: visible;' : 'visibility: hidden;'">
				<image class="bank_logo" src="../../../../../static/images/bank_logo@2x.png" mode="aspectFit" @click="clear"></image>
				<view class="bank_name">招商银行</view>
			</view>
			<view :class="inputValue ? 'button_select' : 'button'" @click="nextClick">下一步</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			inputValue: '',
			isFirst: 0// 有没有添加银行卡号 0 还没有添加银行卡号  1 已经添加银行卡号
		};
	},
	methods: {
		clear() {
			this.inputValue = '';
		},
		nextClick() {
			if (this.inputValue) {
				uni.navigateTo({
					url: 'addBank_two?no=' + this.inputValue + '&name=张三&bank=中国银行&isFirst=' + this.isFirst
				});
			}
		}
	},
	onLoad(option) {
		this.isFirst = option.isFirst
	},
	components: {},
	watch: {
		['inputValue'](val) {
			this.$nextTick(() => {
				this.inputValue = val.replace(/\D/g, '').replace(/....(?!$)/g, '$& ');
			});
		}
	}
};
</script>

<style>
.title {
	margin-top: 64rpx;
	height: 56rpx;
	font-size: 40rpx;
	font-weight: bold;
	line-height: 56rpx;
	color: rgba(50, 50, 50, 1);
}

.tip {
	margin-top: 8rpx;
	height: 33rpx;
	font-size: 24rpx;
	line-height: 33rpx;
	color: rgba(153, 153, 153, 1);
}

.input_wrapper {
	margin-top: 40rpx;

	height: 80rpx;
	background: rgba(247, 246, 245, 1);
	border-radius: 16rpx;

	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
}

.input_cardNO {
	width: 70%;
	height: 40rpx;
	font-size: 28rpx;
	line-height: 40rpx;
	color: rgba(50, 50, 50, 1);
	padding-left: 20rpx;
}

.input_cardNO_placeholder {
	color: rgba(204, 204, 204, 1);
}

.clear {
	width: 32rpx;
	height: 32rpx;
	padding-right: 20rpx;
}

.bankName_wrapper {
	margin-top: 16rpx;
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-items: center;

	height: 33rpx;
	font-size: 24rpx;
	line-height: 33rpx;
	color: rgba(153, 153, 153, 1);
}

.bank_logo {
	width: 32rpx;
	height: 32rpx;
	margin-right: 9rpx;
}

.button {
	margin-top: 120rpx;
	height: 96rpx;
	background: rgba(235, 102, 91, 0.5);
	border-radius: 8rpx;

	height: 96rpx;
	font-size: 32rpx;
	line-height: 96rpx;
	color: rgba(255, 255, 255, 1);
	text-align: center;
}

.button_select {
	margin-top: 120rpx;
	height: 96rpx;
	background: rgba(235, 102, 91, 1);
	border-radius: 8rpx;

	height: 96rpx;
	font-size: 32rpx;
	line-height: 96rpx;
	color: rgba(255, 255, 255, 1);
	text-align: center;
}
</style>
