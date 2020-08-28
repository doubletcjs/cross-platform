<template>
	<view class="box" id="box">
		<view class="item" v-for="(item, index) in listArray" :key="index" @tap="getFile(index)">
			<view class="item_list">
				<view class="input img_box" ref="input" >
					<image class="image" :src="imageArray[index]"></image>
				</view>
			</view>
			<view class="text">{{ item }}</view>
		</view>
	</view>
</template>

<script>
export default {
	name: 'AddFileImg',
	data() {
		return {
			listArray: ['相册', '拍摄','订单'],
			imageArray: ['../../../../static/images/question_album@2x.png','../../../../static/images/question_take@2x.png', '../../../../static/images/question_order@2x.png'],
			images: [],
			files: []
		};
	},
	methods: {
		close(){
			uni.$emit('closeFileModol','close')
		},
		getFile(index) {
			if (index == 0) {  // 相册
				uni.chooseImage({
					count: 9, //默认9
					sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
					sourceType: ['album'], //从相册选择
					success: function(res) {
						// 文件地址 res.tempFilePaths  文件对象 res.tempFiles
						let tempFiles = res.tempFiles;
						uni.$emit('sendImg', { tempFiles: tempFiles });
					}
				});
			}
			if(index == 1){ // 拍摄
				uni.chooseImage({
					count: 9, //默认9
					sizeType: ['original', 'compressed'], //可以指定是原图还是压缩图，默认二者都有
					sourceType: ['camera'], //从相册选择
					success: function(res) {
						// 文件地址 res.tempFilePaths  文件对象 res.tempFiles
						let tempFiles = res.tempFiles;
						uni.$emit('sendImg', { tempFiles: tempFiles });
					}
				});
				console.log('选择拍摄')
			}
			if (index == 2) { // 订单
				uni.$emit('openOderderList', "1");
			}
		},
		
	},
	mounted() {
		
	},
	created() {}
};
</script>

<style lang="scss" scoped>
.box {
	width: 100%;
	// height: 288rpx;
	padding-top: 42rpx;
	padding-bottom: 86rpx;
	display: flex;
	justify-content: flex-start;
	align-items: flex-start;
	flex-wrap: wrap;
	
	.item {
		width: 25%;
		display: flex;
		justify-content: center;
		align-items: center;
		flex-wrap: wrap;
		text-align: center;
		.item_list {
			width: 80%;
			display: flex;
			justify-content: center;
			align-items: center;
			flex-wrap: wrap;
			.img_box {
				width: 101rpx;
				height: 101rpx;
				position: relative;
				.image {
					width: 100%;
					height: 100%;
				}
				
			}
		}
		.text {
			width: 100%;
			margin-top: 25rpx;
			font-size:28rpx;
			color:rgba(50,50,50,1);
		}
	}
}
</style>
