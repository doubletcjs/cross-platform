<!-- 编辑个人昵称 -->
<template>
	<view class="main-body">
		<view class="main_offset">
			<view class="verify_number">{{ userNameText.length }}/16</view>
			<view class="input_wrapper">
				<input class="input_text" placeholder-class="input_text_placeholder" placeholder="请输入昵称" type="text" maxlength="16" v-model="userNameText" />
				<view class="clear" @click="clear">X</view>
			</view>
			<view :class="userNameText ? 'button_select' : 'button'" @click="sumbit">完成</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			userNameText: ''
		};
	},
	methods: {
		sumbit() {
			if (this.userNameText) {
				uni.$emit('mine_edit_refresh');
				uni.navigateBack({
					delta: 1
				});
			} else {
				uni.showToast({
					title: '请输入昵称',
					icon: 'none'
				});
			}
		},
		clear() {
			this.userNameText = ''
		}
	},
	components: {},
	onLoad(option) {
		this.userNameText = option.nickname;
	}
};
</script>

<style>
.verify_number {
	width: 100%;
	height: 45rpx;
	font-size: 32rpx;
	line-height: 45rpx;
	text-align: right;
	color: rgba(153, 153, 153, 1);
}

.input_wrapper {
	margin-top: 20rpx;
	width: 100%;
	height: 96rpx;

	background: rgba(247, 246, 245, 1);
	border-radius: 16rpx;

	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
}

.input_text {
	box-sizing: border-box;

	padding-left: 20rpx;
	text-align: left;

	color: #323232;
	font-size: 28rpx;
}

.clear {
	margin-right: 16rpx;
	width: 32rpx;
	height: 32rpx;
	color: #F7F6F5;
	font-size: 20rpx;
	text-align: center;
	line-height: 32rpx;
	border-radius: 50%;
	background: rgba(153, 153, 153, 1);
}

.input_text_placeholder {
	color: rgba(204, 204, 204, 1);
}

.button {
	margin-top: 67rpx;
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
