<!-- 联系客服中常见问题 -->
<template>
	<view class="main-body">
		<view class="top_wrapper">
			<view class="top_item_wrapper">
				<image class="item_image" src="../../../../static/images/staffService@2x.png" mode="aspectFill"></image>
				<view class="item_text">人工客服</view>
			</view>
			<view class="top_item_wrapper" @click="toFeedback">
				<image class="item_image" src="../../../../static/images/feedback@2x.png" mode="aspectFill"></image>
				<view class="item_text">意见反馈</view>
			</view>
		</view>
		<!-- tabbar -->
		<view class="list-content">
			<view class="tab-bar">
				<view
					v-for="(item, index) in tabs"
					:key="index"
					:class="tabIndex == index ? 'tab-bar-title tab-bar-title-select' : 'tab-bar-title'"
					:data-index="index"
					@click="tabSelectAction"
				>
					{{ item }}

					<!-- indicator -->
					<view class="tab-bar-indicator-mask"><view class="tab-bar-indicator" :style="tabIndex == index ? 'background-color: rgba(235, 102, 91, 1);' : ''"></view></view>
				</view>
			</view>
			<!-- 列表内容，根据标题tab index 显示不用页面 -->
			<contactTabs style="margin-top: 25rpx;" v-if="tabIndex == 0" :listData="dynamicData"></contactTabs>
			<contactTabs style="margin-top: 25rpx;" v-else-if="tabIndex == 1" :listData="liveData"></contactTabs>
			<contactTabs style="margin-top: 25rpx;" v-else-if="tabIndex == 2" :listData="mallData"></contactTabs>
		</view>
	</view>
</template>

<script>
import contactTabs from './contact_tabs.vue';
export default {
	data() {
		return {
			tabIndex: 0,
			tabs: ['动态问题', '直播问题', '商城问题'],
			dynamicData: [
				{ id: '1', question: '1如何发布文章？' },
				{ id: '2', question: '2如何发布文章？' },
				{ id: '3', question: '3如何发布文章？3如何发布文章？3如何发布文章？3如何发布文章？3如何发布文章？3如何发布文章？' },
				{ id: '4', question: '4如何发布文章？' },
				{ id: '5', question: '5如何发布文章？' },
				{ id: '6', question: '6如何发布文章？' },
				{ id: '7', question: '7如何发布文章？' }
			],
			liveData: [
				{ id: '1', question: '1如何开播？' },
				{ id: '2', question: '2如何开播？' },
				{ id: '3', question: '3如何开播？' },
				{ id: '4', question: '4如何开播？' },
				{ id: '5', question: '5如何开播？' },
				{ id: '6', question: '6如何开播？' },
				{ id: '7', question: '7如何开播？' }
			],
			mallData: [
				{ id: '1', question: '1什么时候发货？' },
				{ id: '2', question: '2什么时候发货？' },
				{ id: '3', question: '3什么时候发货？' },
				{ id: '4', question: '4什么时候发货？' },
				{ id: '5', question: '5什么时候发货？' },
				{ id: '6', question: '6什么时候发货？' },
				{ id: '7', question: '7什么时候发货？' }
			]
		};
	},
	methods: {
		//tab点击
		tabSelectAction(res) {
			var index = res.currentTarget.dataset.index;
			this.tabIndex = index;
		},
		toFeedback() { // 意见反馈
			uni.navigateTo({
				url: './feedback'
			})
		}
	},
	components: {
		contactTabs
	}
};
</script>

<style>
.top_wrapper {
	height: 266rpx;
	background: #fff;
	border-top: solid 24rpx rgba(0, 0, 0, 0.05);
	border-bottom: solid 24rpx rgba(0, 0, 0, 0.05);

	padding-left: 156rpx;
	padding-right: 156rpx;

	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
}

.top_item_wrapper {
}

.item_image {
	width: 114rpx;
	height: 114rpx;
}

.item_text {
	margin-top: 15rpx;
	height: 40rpx;
	font-size: 28rpx;
	line-height: 40rpx;
	color: rgba(50, 50, 50, 1);
}

.tab-bar {
	width: 100%;
	height: 88rpx;

	background-color: #ffffff;
	border-bottom: solid rgba(0, 0, 0, 0.05) 1rpx;

	display: flex;
	flex-direction: row;
	justify-content: space-around;
	align-items: center;
	align-content: center;
	
	position: relative;
}

.tab-bar-title {
	color: rgba(153, 153, 153, 1);
	font-size: 28rpx;

	padding: 10rpx 0rpx 10rpx 0rpx;
	text-align: center;
	width: 180rpx;
}

.tab-bar-title-select {
	color: rgba(50, 50, 50, 1);
	font-weight: bold;
	font-size: 32rpx;
}

.tab-bar-indicator-mask {
	width: 180rpx;
	height: 6rpx;

	display: flex;
	flex-direction: row;
	justify-content: center;
	align-content: center;

	position: absolute;
	bottom: 0;
}

.tab-bar-indicator {
	width: 32rpx;
	height: 6rpx;
	border-radius: 6rpx;
}
</style>
