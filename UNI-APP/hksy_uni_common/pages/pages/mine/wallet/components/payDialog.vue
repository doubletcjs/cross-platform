<!-- 支付对话框 -->
<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="selectPay-content" @click.stop="emptyAction">
			<!-- 标题 -->
			<view class="title_wrapper">
				<view class="title_text">支付金额： <span style="color: #EB665B; font-weight: bold;"> ￥{{ money }}</span></view>
				<view class="close_wrapper"><view class="close_text" @click="closePopup">X</view></view>
			</view>

			<!-- 支付列表 -->
			<view class="pay_wrapper" v-for="(item, index) in payList" :key="index" :data-index="index" @click="selectItemAction">
				<image class="pay_logo" :src="item.logo" mode="aspectFit"></image>
				<view class="pay_name">{{ item.name }}</view>
				<image
					:class="selecIndex == index ? 'select_image' : 'select_image select_image_none'"
					src="../../../../../static/images/select_bank@2x.png"
					mode="aspectFit"
				></image>
			</view>

			<view class="selectPay_ok" @click="confirmPopup">确认支付</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			payList: [
				{
					logo: '/../../../../static/images/pay_ali@2x.png',
					name: '支付宝支付'
				},
				{
					logo: '/../../../../static/images/pay_wx@2x.png',
					name: '微信支付'
				}
			],
			selecIndex: -1
		};
	},
	methods: {
		//关闭alert
		closePopup() {
			this.closeAction();
		},
		emptyAction() {},
		selectItemAction(res) {
			let index = res.currentTarget.dataset.index;
			this.selecIndex = index;
		},
		confirmPopup() {
			let me = this;
			setTimeout(function() {
				// 回调结果给父组件
				let name = me.payList[me.selecIndex].name;
				me.itemTapAction(name);
			}, 100);
			this.closePopup();
		}
	},
	props: {
		//是否弹出显示
		visible: {
			type: Boolean,
			value: false
		},
		money: {
			// 支付金额
			type: String,
			value: ''
		},
		closeAction: Function,
		itemTapAction: Function // 回调结果选择什么支付
	}
};
</script>

<style>
.i-modal-mask {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 1000;
	transition: all 0.2s ease-in-out;
	opacity: 0;
	visibility: hidden;
	width: 100%;
	height: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;

	background-color: rgba(0, 0, 0, 0.4);
}

.i-modal-mask-show {
	opacity: 1;
	visibility: visible;
}

.selectPay-content {
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;

	height: 528rpx;
	display: flex;
	flex-direction: column;

	background-color: rgba(255, 255, 255, 1);
	border-radius: 16rpx 16rpx 0rpx 0rpx;

	/** 页面统一字体 */
	color: #323232;
	font-size: 32rpx;
}

.title_wrapper {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
	height: 128rpx;
	padding-left: 32rpx;
	padding-right: 32rpx;
}

.title_text {
	font-size: 34rpx;
}

.close_wrapper {
	height: 128rpx;
	width: 48rpx;
	color: #707070;
	font-size: 48rpx;
	line-height: 128rpx;
	text-align: right;
}

.pay_wrapper {
	display: flex;
	flex-direction: row;
	justify-content: start;
	align-items: center;
	height: 112rpx;

	padding-left: 32rpx;
	padding-right: 32rpx;
}

.pay_logo {
	height: 56rpx;
	width: 56rpx;
}

.pay_name {
	width: 100%;
	margin-left: 16rpx;
	height: 45rpx;
	font-size: 32rpx;
	line-height: 45rpx;
	color: rgba(50, 50, 50, 1);
}

.select_image {
	width: 48rpx;
	height: 48rpx;
	visibility: visible;
}

.select_image_none {
	visibility: hidden;
}

.selectPay_ok {
	margin: 40rpx 32rpx 40rpx 32rpx;
	height:96rpx;
	font-size:32rpx;
	line-height: 86rpx;
	text-align: center;
	color: #FFFFFF;
	background:rgba(235,102,91,1);
	border-radius:8px;
}
</style>
