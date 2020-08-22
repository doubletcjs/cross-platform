<!-- 编辑个人简介 -->
<template>
	<view class="main-body">
		<view class="main_offset">
			<view class="verify_number">{{ introText.length }}/48</view>
			<textarea class="textarea_text" placeholder-class="textarea_text_placeholder" placeholder="请简单介绍一下自己" type="text" maxlength="48" v-model="introText"/>
			<view :class="introText ? 'button_select' : 'button' "  @click="sumbit">完成</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			introText: ''
		};
	},
	methods: {
		sumbit() {
			if(this.introText) {
				
				uni.$emit('mine_edit_refresh');
				uni.navigateBack({
					delta:1
				})
				
			} else {
				uni.showToast({
					title: '请输入个人简介',
					icon: 'none'
				})
			}
		}
	},
	components: {},
	onLoad(option) {
		this.introText = option.intro;
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

.textarea_text {
	padding: 20rpx;
	box-sizing: border-box;
	width: 100%;
	margin-top: 20rpx;
	height:260rpx;
	background:rgba(247,246,245,1);
	border-radius:16rpx;
	
	color: #323232;
	font-size: 28rpx;
}

.textarea_text_placeholder {
	color: rgba(204,204,204,1);
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
