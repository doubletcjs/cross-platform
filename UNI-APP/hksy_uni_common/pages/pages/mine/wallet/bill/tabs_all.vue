<!-- 金币账单  全部tabs -->
<template>
	<view class="main-body">
		<view class="all_item_Wrapper" v-for="(item, index) in allList" :key="index" :data-index="index">
			<view class="image_wrapper">
				<image class="headPortrait" :src="item.image" mode="aspectFit"></image>
			</view>			
			<view class="item_right_wrapper">
				<view class="name_text">{{ item.name }}</view>
				<view class="middle_wrapper">
					<view class="giftsType_text">{{ item.giftsType }}</view>
					<view class="money_text">{{ item.money }} <span class="money_text_span">金 </span></view>
				</view>
				<view class="time_text">{{ item.time }}</view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			allList: [
				{
					image: '/../../../../static/images/bank_logo@2x.png',
					name: '可可树1',
					giftsType: '直播收礼',
					time: '2020.07.15 12:00',
					money: '+10000'
				},
				{
					image: '/../../../../static/images/pay_wx@2x.png',
					name: '可可树2可可树2可可树2可可树2可可树2可可树2可可树2可可树2',
					giftsType: '打赏小视频',
					time: '2020.07.15 12:00',
					money: '+100000'
				},
				{
					image: '/../../../../static/images/bank_logo@2x.png',
					name: '可可树3',
					giftsType: '打算文章',
					time: '2020.07.15 12:00',
					money: '+10'
				},
				{
					image: '/../../../../static/images/pay_wx@2x.png',
					name: '可可树4',
					giftsType: '直播送礼',
					time: '2020.07.15 12:00',
					money: '-10'
				},
				{
					image: '/../../../../static/images/pay_wx@2x.png',
					name: '可可树5',
					giftsType: '直播收礼',
					time: '2020.07.15 12:00',
					money: '+10'
				},
				{
					image: '/../../../../static/images/pay_wx@2x.png',
					name: '可可树6',
					giftsType: '直播收礼',
					time: '2020.07.15 12:00',
					money: '+10'
				},
				{
					image: '/../../../../static/images/pay_wx@2x.png',
					name: '可可树7',
					giftsType: '直播收礼',
					time: '2020.07.15 12:00',
					money: '+10'
				}
			]
		};
	},
	methods: {},
	components: {}
};
</script>

<style>
.all_item_Wrapper {
	height: 176rpx;
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
}

.image_wrapper {
	width: 149rpx;
	height: 100%;
}

.headPortrait {
	margin-left: 32rpx;
	margin-right: 53rpx;
	margin-top: 24rpx;
	width: 64rpx;
	height: 64rpx;
	border-radius: 50%;
}

.item_right_wrapper {
	width: calc(100% - 149rpx);
	border-bottom: solid rgba(0, 0, 0, 0.05) 1rpx;
}

.name_text {
	
	margin-top: 24rpx;
	margin-right: 149rpx;
	height: 45rpx;
	font-size: 32rpx;
	font-weight: bold;
	line-height: 45rpx;
	color: rgba(27, 27, 27, 1);
	letter-spacing: 2rpx;
	
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.middle_wrapper {
	height: 56rpx;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

.giftsType_text {
	
	height: 56rpx;
	font-size: 24rpx;
	line-height: 56rpx;
	text-align: 56rpx;
	text-align: center|left;
	color: rgba(153, 153, 153, 1);
}

.money_text {
	margin-right: 32rpx;
	height:56rpx;
	font-size:40rpx;
	font-weight:bold;
	line-height:56rpx;
	text-align: center;
	color:rgba(50,50,50,1);
}

.money_text_span {
	font-size: 24rpx;
	font-weight: normal;
}

.time_text {
	font-size: 24rpx;
	line-height: 33rpx;
	color: rgba(153, 153, 153, 1);
}
</style>
