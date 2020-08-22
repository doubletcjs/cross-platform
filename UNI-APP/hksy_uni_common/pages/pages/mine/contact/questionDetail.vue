<!--  -->
<template>
	<view class="main-body">
		<view class="main_offset">
			<view class="title_text">{{ title }}</view>
			<view class="answer_text">交易订单的订单状态显示“交易成功”后的15天内，过了15天的评价期，评价入口关闭。您可以在180天之内进行追评哦~</view>
			<view class="tip_wrapper">
				<view class="line"></view>
				<view class="tip_text">以上方案是否解决了您的问题？</view>
				<view class="line"></view>
			</view>
			<view class="solve_wrapper">
				<view class="resolved_wrapper">
					<image class="image" src="../../../../static/images/resolved@2x.png" mode="aspectFill"></image>
					<view class="resolved_text">已解决</view>
				</view>
				<view class="unsolved_wrapper">
					<image class="image" src="../../../../static/images/unsolved@2x.png" mode="aspectFill"></image>
					<view class="unsolved_text">未解决</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			id: '',
			title: '购买多久时间可以评论购买多久时间可以评论购买多久时间可以评论购买多久时间可以评论购买多久时间可以评论购买多久时间可以评论',
			answer: ''
		};
	},
	methods: {},
	components: {},
	onLoad(option) {
		this.id = option.id;
	}
};
</script>

<style>
.title_text {
	margin-top: 48rpx;
	font-size: 32rpx;
	font-weight: bold;
	color: rgba(27, 27, 27, 1);
}
.answer_text {
	margin-top: 24rpx;
	font-size: 28rpx;
	color: rgba(50, 50, 50, 1);
}

.tip_wrapper {
	width: 100%;
	margin-top: 64rpx;
	height: 29rpx;
	line-height: 29rpx;
	text-align: center;

	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
}
.line {
	background: transparent;
	flex: 1;
	height: 1rpx;
	border-top: 1rpx dotted rgba(0, 0, 0, 0.2);
}
.tip_text {
	height: 29rpx;
	margin-left: 10rpx;
	margin-right: 10rpx;
	font-size: 21rpx;
	line-height: 29rpx;
	color: rgba(153, 153, 153, 1);
	
}

.solve_wrapper {
	margin-top: 67rpx;
	margin-bottom: 67rpx;
	margin-left: 133rpx;
	margin-right: 133rpx;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
}

.resolved_wrapper {
	width: 179rpx;
	height: 60rpx;

	background: rgba(247, 246, 245, 1);
	border-radius: 8rpx;

	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
}

.image {
	width: 44rpx;
	height: 44rpx;
	margin-left: 22rpx;
}

.resolved_text {
	margin-right: 29rpx;
	font-size: 28rpx;
	text-align: center;
	color: rgba(235, 102, 91, 1);
}

.unsolved_wrapper {
	width: 179rpx;
	height: 60rpx;

	border: 1rpx solid rgba(247, 246, 245, 1);
	border-radius: 4rpx;

	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
}

.unsolved_text {
	margin-right: 29rpx;
	font-size: 28rpx;
	text-align: center;
	color: rgba(153, 153, 153, 1);
}
</style>
