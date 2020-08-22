<!-- 支付对话框 -->
<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="gender-content" @click.stop="emptyAction">
			<view class="gender_wrapper" v-for="(item, index) in genderList" :key="index" :data-index="index" @click="selectItemAction">{{ item.name }}</view>
			<view class="selectGender_cancel" @click="closePopup">取消</view>
			<view class="selectGender_bottom"><view class="selectGender_bottom_black"></view></view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			genderList: [
				{
					id: '1',
					name: '男'
				},
				{
					logo: '0',
					name: '女'
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
			let me = this;
			setTimeout(function() {
				// 回调结果给父组件
				let name = me.genderList[me.selecIndex].name;
				me.itemTapAction(name);
			}, 100);
			this.closePopup();
		},
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

.gender-content {
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;

	height: 418rpx;
	display: flex;
	flex-direction: column;

	background-color: rgba(255, 255, 255, 1);
	border-radius: 16rpx 16rpx 0rpx 0rpx;

	/** 页面统一字体 */
	color: rgba(27, 27, 27, 1);
	font-size: 30rpx;
}

.gender_wrapper {
	height: 112rpx;
	border-bottom: solid 9rpx rgba(0, 0, 0, 0.05);
	
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: center;
	
}

.selectGender_cancel {
	height: 112rpx;
	line-height: 112rpx;
	text-align: center;
	border-top: solid 10rpx rgba(0, 0, 0, 0.05);
}

.selectGender_bottom {
	height: 68rpx;
	display: flex;
	justify-content: center;
}

.selectGender_bottom_black {
	width: 268rpx;
	height: 10rpx;
	margin-top: 40rpx;
	margin-bottom: 18rpx;
	background: rgba(0, 0, 0, 1);
	border-radius: 100rpx;
}
</style>
