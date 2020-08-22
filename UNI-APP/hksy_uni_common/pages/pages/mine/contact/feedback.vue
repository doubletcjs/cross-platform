<!-- 意见反馈 -->
<template>
	<view class="main-body">
		<view class="main_offset">
			<view class="title_text" style="margin-top: 32rpx;">建议反馈</view>
			<textarea class="textarea_text" placeholder-class="textarea_text_placeholder" placeholder="请您写一下建议反馈" type="text" maxlength="48" v-model="feebakcText" />
			<view class="title_text" style="margin-top: 48rpx;">联系方式</view>
			<input class="input_text" placeholder-class="input_text_placeholder" placeholder="请输入你的手机号码" type="number" maxlength="11" v-model="contactText" />
			<view class="title_text" style="margin-top: 48rpx;">上传图片</view>
			<view class="image_wrapper">
				<view class="image_item_add" v-for="(item, index) in selectPaths" :key="index" :data-index="index">
					<image class="item_image" src="../../../../static/images/camera@2x.png" mode="aspectFill"></image>
				</view>
				<!-- 				<view class="image_item_had">
					<image class="item_image" src="../../../../static/images/camera@2x.png" mode="aspectFill"></image>
					<image class="clear_image" src="../../../../static/images/clear@2x.png" mode="aspectFill"></image>
				</view> -->
			</view>
			<view :class="feebakcText && contactText ? 'button_select' : 'button'" @click="sumbit">提交</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			feebakcText: '',
			contactText: '',
			selectPaths: [1, 2,3,4,5,6,7,8]
		};
	},
	methods: {},
	components: {}
};
</script>

<style>
.title_text {
	height: 40rpx;
	font-size: 28rpx;
	font-weight: bold;
	line-height: 40rpx;
	color: rgba(50, 50, 50, 1);
}

.textarea_text {
	width: 100%;
	height: 260rpx;
	box-sizing: border-box;
	margin-top: 20rpx;
	padding-top: 30rpx;
	padding-left: 20rpx;
	background: rgba(247, 246, 245, 1);
	border-radius: 16rpx;

	color: #323232;
	font-size: 28rpx;
}

.textarea_text_placeholder {
	color: rgba(204, 204, 204, 1);
}

.input_text {
	margin-top: 20rpx;
	width: 100%;
	height: 96rpx;
	padding-left: 20rpx;
	box-sizing: border-box;
	background: rgba(247, 246, 245, 1);
	border-radius: 16rpx;

	text-align: center|left;
	line-height: 96rpx;
	color: #323232;
	font-size: 28rpx;
}

.input_text_placeholder {
	color: rgba(204, 204, 204, 1);
}

.image_wrapper {
	width: 100%;
	margin-top: 29rpx;

	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-items: center;
	flex-wrap: wrap;
	align-content: flex-start;
}

.image_item_add {
	width: 32%;
	height: 218rpx;
	margin-bottom: 16rpx;
	background: rgba(247, 246, 245, 1);
	border-radius: 16rpx;

	display: flex;
	justify-content: center;
	align-items: center;
}

.image_item_add:nth-child(3n+2) {
	margin-left: 2%;
	margin-right: 2%;
}

.item_image {
	width: 101rpx;
	height: 101rpx;
}

.button {
	margin-top: 67rpx;
	margin-bottom: 67rpx;
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
	margin-bottom: 67rpx;
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
