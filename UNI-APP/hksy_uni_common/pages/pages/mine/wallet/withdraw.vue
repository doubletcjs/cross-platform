<!-- 我的钱包=>金币提现 -->
<template>
	<view class="main-body-two">
		<view class="withdraw_wrapper">
			<view class="bank_wrapper">
				<image class="bank_logo" src="../../../../static/images/bank_logo@2x.png" mode="aspectFit"></image>
				<view class="bank_name">{{bankName}}</view>
				<view class="bank_back_wrapper">
					<image class="bank_back" src="../../../../static/images/arrows_left@2x.png" mode="aspectFit" @click="OCSelectBankDialog"></image>
				</view>
			</view>
			<view class="title">提现金额</view>
			<view class="input_wrapper">
				<view class="rmb_text">￥</view>
				<input class="input_text" type="number" v-model="inputValue" placeholder="请输入金额" placeholder-class="input_text_placeholder" />
			</view>
			<view class="tip_wrapper">
				<view class="withdraw_money">可提现金额5680元</view>
				<view class="withdraw_all" @click="withdraw_all">全部提现</view>
			</view>
		</view>
		<view class="withdraw_tip">请在工作日9:00~17:00之间完成提现操作</view>
		<view :class="inputValue ? 'button_select' : 'button'" @click="submit">确认提现</view>
		<!-- 选择银行对话框 -->
		<selectBankDialog :visible="selectBankDialogVisible" :closeAction="OCSelectBankDialog" :itemTapAction="selectBankNameAction"></selectBankDialog>
		<!-- 数字键盘 -->
		<dititalKeyboard :visible="dititalKeyboardVisible" digits="6" :closeAction="OCDititalKeyboardDialog" @itemTapAction="inputPasswordAction"> </dititalKeyboard>
	</view>
</template>

<script>
import selectBankDialog from './components/selectBankDialog.vue';
import dititalKeyboard from '../../../../components/passwordInput/dititalKeyboard.vue';
export default {
	data() {
		return {
			inputValue: "",
			bankName: "招商银行",
			selectBankDialogVisible: false,
			dititalKeyboardVisible: false,
		};
	},
	methods: {
		// 打开和关闭选择银行对话框
		OCSelectBankDialog() {
			this.selectBankDialogVisible = !this.selectBankDialogVisible
		},
		// 打开和关闭数字键盘对话框
		OCDititalKeyboardDialog() {
			this.dititalKeyboardVisible = !this.dititalKeyboardVisible
		},
		// 回调返回选中银行的名字
		selectBankNameAction(res) {
			this.bankName = res
		},
		// 回调返回用户输入的密码
		inputPasswordAction(res) {
			console.log(res);
			uni.navigateTo({
				url: "withdrawSuccess"
			})
			
		},
		// 确定提交
		submit() {
			if(this.inputValue) {
				this.OCDititalKeyboardDialog()
			} else {
				uni.showToast({
				    title: '请输入提现金额',
					icon: "none",
				    duration: 2000
				});
			}
		},
		// 提现所有
		withdraw_all() {
			this.inputValue = "1234"
		}
	},
	components: {
		selectBankDialog,
		dititalKeyboard
	}
};
</script>

<style>
.withdraw_wrapper {
	margin-top: 32rpx;
	background: #fff;
}
.bank_wrapper {
	height: 96rpx;
	display: flex;
	flex-direction: row;
	justify-content: start;
	align-items: center;

	border-bottom: solid rgba(0, 0, 0, 0.05) 1rpx;
}
.bank_logo {
	width: 48rpx;
	height: 48rpx;
	margin-left: 32rpx;
}
.bank_name {
	margin-left: 16rpx;
	width: 100%;
	height: 45rpx;
	font-size: 32rpx;
	font-weight: 400;
	color: rgba(50, 50, 50, 1);
}
.bank_back_wrapper {
	width: 60rpx;
	height: 56rpx;
	text-align: right;
	margin-right: 32rpx;
}

.bank_back {
	width: 15rpx;
	height: 28rpx;
}
.title {
	font-size: 28rpx;
	line-height: 40rpx;
	margin-top: 24rpx;
	margin-bottom: 16rpx;
	margin-left: 32rpx;
	line-height: 62rpx;
	color: rgba(50, 50, 50, 1);
}
.input_wrapper {
	padding-bottom: 24rpx;
	border-bottom: solid rgba(0, 0, 0, 0.05) 1rpx;

	display: flex;
	flex-direction: row;
}
.rmb_text {
	margin-left: 32rpx;
	width: 56rpx;
	height: 78rpx;
	line-height: 78rpx;
	font-size: 56rpx;
	font-weight: bold;
	color: rgba(50, 50, 50, 1);
}
.input_text {
	margin-right: 32rpx;
	margin-left: 11rpx;
	width: 100%;
	height: 78rpx;
	line-height: 78rpx;
	/* text-align: left; */
	font-size: 28rpx;
	font-weight: bold;
	color: rgba(50, 50, 50, 1);
}
.input_text_placeholder {
	font-weight: normal;
	color: rgba(153, 153, 153, 1);
}
.tip_wrapper {
	height: 88rpx;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
	margin-left: 32rpx;
	margin-right: 32rpx;
}
.withdraw_money {
	height: 40rpx;
	font-size: 28rpx;
	line-height: 40rpx;
	color: rgba(153, 153, 153, 1);
}
.withdraw_all {
	height: 40rpx;
	font-size: 28rpx;
	line-height: 40rpx;
	color: rgba(80, 111, 176, 1);
}
.withdraw_tip {
	margin-top: 26rpx;
	height: 33rpx;
	font-size: 24rpx;
	margin-left: 32rpx;
	line-height: 33rpx;
	color: rgba(153, 153, 153, 1);
}
.button {
	margin-top: 64rpx;
	margin-left: 32rpx;
	margin-right: 32rpx;
	height: 96rpx;
	line-height: 96rpx;
	background: rgba(235, 102, 91, 0.5);
	border-radius: 8rpx;
	color: #ffffff;
	text-align: center;
}
.button_select {
	margin-top: 64rpx;
	margin-left: 32rpx;
	margin-right: 32rpx;
	height: 96rpx;
	line-height: 96rpx;
	background: rgba(235, 102, 91, 1);
	border-radius: 8rpx;
	color: #ffffff;
	text-align: center;
}
</style>
