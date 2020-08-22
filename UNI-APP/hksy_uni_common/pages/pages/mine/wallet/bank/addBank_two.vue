<!-- 我的钱包=>金币提现=>银行卡列表界面=>添加银行卡第二步 -->
<template>
	<view class="main-body">
		<view class="title">验证银行卡信息</view>
		<view class="tip">为了保障您的资金安全，请绑定的是您名下的银行卡</view>
		<view class="row_wrapper" style="margin-top: 60rpx;">
			<view class="label_text">持卡人</view>
			<view class="value_text">{{name}}</view>
		</view>
		<view class="row_wrapper">
			<view class="label_text">卡号</view>
			<view class="value_text">{{showCardNO(cardNo)}}</view>
		</view>
		<view class="row_wrapper">
			<view class="label_text">卡类型</view>
			<view class="value_text">{{bankName}}</view>
		</view>
		<view class="row_wrapper">
			<view class="label_text">手机号码</view>
			<input class="phone_text" placeholder-class="phone_text_placeholder" type="number" :maxlength="11" v-model="inputPhone" placeholder="请输入你的手机号" />
		</view>
		<view class="agreement_text">阅读<span style="color:rgba(80,111,176,1) ;" @click="toAgreement">《用户协议》</span></view>
		<view :class="inputPhone.length == 11 ? 'button_select' : 'button'" @click="submit">同意协议并验证</view>
		<!-- 验证码对话框 -->
		<codeKeyboard :visible="codeKeyboardVisible" digits="6" :phoneNumber="inputPhone" :closeAction="OCDCodeKeyboardDialog" @itemTapAction="inputPasswordAction"> </codeKeyboard>		
	</view>
</template>

<script>
import codeKeyboard from '../../../../../components/codeInput/codeKeyboard.vue';
export default {
	data() {
		return {
			cardNo: '',
			name: '',
			bankName: '',
			inputPhone: '',
			codeKeyboardVisible: false,
			isFirst: 0// 有没有添加银行卡号 0 还没有添加银行卡号  1 已经添加银行卡号
		};
	},
	methods: {
		submit() {
			if(this.inputPhone.length == 11) {
				this.OCDCodeKeyboardDialog()
			}
		},
		// 跳去用户协议
		toAgreement() {
			console.log("-----------");
		},
		// 打开和关闭验证码对话框
		OCDCodeKeyboardDialog() {
			this.codeKeyboardVisible = !this.codeKeyboardVisible
		},
		// 回调返回用户输入的验证码
		inputPasswordAction(res) {
			
			// 1 添加银行卡    0  输入支付密码
			uni.navigateTo({
				url: "payPassword?isFirst=" + this.isFirst
			})
			
			// if(this.isFirst) { // 
				
			// } else { // 还没有银行卡号，要跳去支付密码
			// 	uni.navigateTo({
			// 		url: "payPassword?isFirst=" + this.isFirst
			// 	})
			// }
			
			
			
		},
	},
	computed: {
		// 银行卡号显示*号
		showCardNO() {
			return (bankName) => bankName.substr(0, 4) + ' **** **** **** ' + bankName.substr(bankName.length - 4, bankName.length);
		}
	},
	components: {
		codeKeyboard
	},
	onLoad(option) {
		this.cardNo = option.no;
		this.name = option.name;
		this.bankName = option.bank;
		this.isFirst = option.isFirst
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
	margin-right: 32rpx;
	margin-left: 32rpx;
}

.tip {
	margin-top: 8rpx;
	height: 33rpx;
	font-size: 24rpx;
	line-height: 33rpx;
	color: rgba(153, 153, 153, 1);
	margin-right: 32rpx;
	margin-left: 32rpx;
}

.row_wrapper {
	height: 79rpx;
	line-height: 79rpx;
	border-bottom: solid 1rpx rgba(0, 0, 0, 0.05);

	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-items: center;
}

.label_text {
	width: 113rpx;
	font-size: 28rpx;
	font-weight: bold;
	color: rgba(50, 50, 50, 1);
	margin-left: 32rpx;
}

.value_text {
	margin-left: 49rpx;
	font-size: 28rpx;
	color: rgba(153, 153, 153, 1);
	margin-right: 32rpx;
}

.phone_text{
	margin-left: 49rpx;
	font-size: 28rpx;
	color: rgba(50, 50, 50, 1);
	margin-right: 32rpx;
}

.phone_text_placeholder{
	color: rgba(153, 153, 153, 1);
}

.agreement_text {
	margin-top: 17rpx;
	margin-left: 32rpx;
	font-size:26rpx;
	line-height:62rpx;
	color:rgba(153,153,153,1);
}

.button {
	margin-top: 67rpx;
	margin-right: 32rpx;
	margin-left: 32rpx;
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
	margin-top: 67rpx;
	margin-right: 32rpx;
	margin-left: 32rpx;
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
