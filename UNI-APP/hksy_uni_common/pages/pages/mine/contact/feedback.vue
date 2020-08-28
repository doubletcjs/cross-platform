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
				<view class="image_item_wrapper" v-for="(item, index) in selectPaths" :key="index" :data-index="index">
					<!-- 添加照片 -->
					<view class="image_item_add" v-if="showAddImage(index)" @tap="selectImageAction">
						<image class="item_image" src="../../../../static/images/camera@2x.png" mode="aspectFill"></image>
					</view>
					<!-- 显示照片 -->
					<view class="image_item_had" v-else>
						<image class="item_image_had" :src="item" mode="aspectFill"></image>
						<image class="clear_image" src="../../../../static/images/clear@2x.png" mode="aspectFill" @tap="deleteImage(index)"></image>
					</view>
				</view>
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
			// selectPaths: [1, 2,3,4,5,6,7,8,9]
			selectPaths: [''],
			// selectPaths: [
			// 	'../../../../static/images/feedback@2x.png',
			// 	'../../../../static/images/feedback@2x.png',
			// 	'../../../../static/images/feedback@2x.png',
			// 	'../../../../static/images/feedback@2x.png',
			// 	'../../../../static/images/feedback@2x.png',
			// 	'../../../../static/images/feedback@2x.png',
			// 	'../../../../static/images/feedback@2x.png',
			// 	'../../../../static/images/feedback@2x.png',
			// 	''
			// ]
		};
	},
	methods: {
		// 删除照片
		deleteImage(index) {
			// 假如有9张照片了，最后一张图片不是添加图片
			if (this.selectPaths.length == 9 && this.selectPaths[8] != '') {
				this.selectPaths.splice(index, 1);
				this.selectPaths.push('');
			} else {
				this.selectPaths.splice(index, 1);
			}
			// console.log(index, this.selectPaths);
		},
		selectImageAction() {
			// 添加照片
			uni.hideKeyboard();
			var me = this;
			uni.chooseImage({
				count: 9 - me.selectPaths.length,
				success: res => {
					// console.log(typeof res.tempFilePaths);
					// console.log(JSON.stringify(res.tempFilePaths));

					me.selectPaths.splice(me.selectPaths.length - 1, 1); // 删除''
					// console.log('添加前 ' + me.selectPaths);
					// console.log('添加前 ' + me.selectPaths.length);
					me.selectPaths.push.apply(me.selectPaths, res.tempFilePaths); // 加入用户选择的照片数组
					if (me.selectPaths.length < 9) { // 不足9张添加''
						me.selectPaths.push('');
					}
					// console.log('添加后 ' + me.selectPaths);
					// console.log('添加后 ' + me.selectPaths.length);
				},
				fail: res => {
					if (res.code != '0') {
						uni.showToast({
							title: res.errMsg,
							icon: 'none'
						});
					}
				}
			});
		}
	},
	components: {},
	computed: {
		showAddImage() {
			// 是否显示加号 true 显示添加图片 false 显示相片
			return index => {
				
				if(this.selectPaths[index] == '') { // 如果这个为空就显示添加图片
					return true
				} else {
					return false
				}
				
				// if (index == this.selectPaths.length - 1 && index < 9) {
				// 	return true;
				// } else {
				// 	return false;
				// }
			};
		}
	}
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

.image_item_wrapper {
	width: 32%;
	height: 218rpx;
	margin-bottom: 16rpx;
	background: rgba(247, 246, 245, 1);
	border-radius: 16rpx;
}

.image_item_add {
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
}

.image_item_wrapper:nth-child(3n + 2) {
	margin-left: 2%;
	margin-right: 2%;
}

.item_image {
	width: 101rpx;
	height: 101rpx;
}

.image_item_had {
	width: 100%;
	height: 100%;
	position: relative;
}

.item_image_had {
	width: 100%;
	height: 100%;
	border-radius: 16rpx;
}

.clear_image {
	width: 40rpx;
	height: 40rpx;
	position: absolute;

	right: 16rpx;
	top: 16rpx;
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
