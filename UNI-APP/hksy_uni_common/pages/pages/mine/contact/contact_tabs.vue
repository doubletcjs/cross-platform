<!--  -->
<template>
	<view class="main-body">
		<view class="item_wrapper" v-for="(item, index) in listData" :key="index" :data-index="index" @tap="toDetail">
			<view class="title">{{ item.question }}</view>
			<view class="image_wrapper"><image class="arrows_image" src="../../../../static/images/arrows_left@2x.png" mode="aspectFill"></image></view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {};
	},
	methods: {
		toDetail(res) {
			let index = res.currentTarget.dataset.index;
			console.log(this.listData[index].id);
			
			uni.navigateTo({
				url: './questionDetail?id=' + index
			})
		}
	},
	components: {},
	props: {
		listData: {
			type: Array,
			default() { // return [] 是错的，注掉default也是可以的
				return '';
			}
		}
	}
};
</script>

<style>
.item_wrapper {
	height: 90rpx;

	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
	
	margin-left: 32rpx;
	margin-right: 32rpx;
}

.title {
	width: 90%;
	height: 90rpx;
	line-height: 90rpx;
	text-align: center|left;
	font-size:28rpx;;
	color:rgba(50,50,50,1);
	
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;

}

.arrows_image {
	width: 13rpx;
	height: 24rpx;
}
</style>
