<!-- 代金券选择对话框 -->
<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="selectCoupon-content" @click.stop="emptyAction">
			<!-- 标题 -->
			<view class="title_wrapper">
				<view class="title_text">{{ title }}</view>
				<view class="close_wrapper"><view class="close_text" @click="closePopup">X</view></view>
			</view>

			<!-- 优惠列表 -->
			<scroll-view scroll-y="true" show-scrollbar="true" style="height: 336rpx; margin-bottom: 40rpx;">
			<view class="coupon_wrapper" v-for="(item, index) in couponList" :key="index" :data-index="index" @click="selectItemAction">
				<view class="item_wrapper">
					<image
						class="select_image"
						:src="selectItem(index)"
						mode="aspectFit"
					></image>
					<view class="rmb_text">￥</view>
					<view class="money_text">{{ item.money }}</view>
					<view class="line"></view>
					<view class="coupon_info_wrapper">
						<view class="content_text">{{ item.content }}</view>
						<view class="time_text">{{ item.time }}</view>
					</view>
				</view>
			</view>
			</scroll-view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			couponList: [
				{
					money: '20',
					content: '充值满148可用',
					time: '2020.05.20-2020.06.20'
				},
				{
					money: '100',
					content: '充值满648可用',
					time: '2020.05.20-2020.06.20'
				},
				{
					money: '300',
					content: '充值满1248可用',
					time: '2020.05.20-2020.06.20'
				},
				{
					money: '400',
					content: '充值满1248可用',
					time: '2020.05.20-2020.06.20'
				},
				{
					money: '500',
					content: '充值满1248可用',
					time: '2020.05.20-2020.06.20'
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
			
			let me = this;
			if(me.selecIndex == index) { // 已经选中了，变成不选中
				me.selecIndex = -1
				setTimeout(function() {
					me.itemTapAction("-1");
				}, 100);
			} else {
				me.selecIndex = index;
				setTimeout(function() {
					// 回调结果给父组件
					let money = me.couponList[me.selecIndex].money;
					me.itemTapAction(money);
				}, 100);
			}
			this.closePopup();
		},
	},
	props: {
		//是否弹出显示
		visible: {
			type: Boolean,
			value: false
		},
		title: {
			// 标题
			type: String,
			value: ''
		},
		closeAction: Function,
		itemTapAction: Function // 回调结果选择什么支付
	},
	computed: {
		selectItem() {
			return (index) => {
				
				if(this.selecIndex == index) {
					return '/static/images/detail_member_chose_sel@3x.png'
				} else {
					return '/static/images/detail_member_chose@3x.png'
				}
				// return '../../../../../static/images/detail_member_chose_sel@3x.png'				
			}
		}
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

.selectCoupon-content {
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;

	height: 504rpx;
	display: flex;
	flex-direction: column;

	background-color: rgba(255, 255, 255, 1);
	border-radius: 16rpx 16rpx 0rpx 0rpx;
}

.title_wrapper {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
	height: 128rpx;
	padding-left: 32rpx;
	padding-right: 32rpx;
}

.title_text {
	font-size: 34rpx;
}

.close_wrapper {
	height: 128rpx;
	width: 48rpx;
	color: #707070;
	font-size: 48rpx;
	line-height: 128rpx;
	text-align: right;
}

.coupon_wrapper {
	display: flex;
	flex-direction: row;
	justify-content: start;
	align-items: center;
	height: 160rpx;
	margin-bottom: 16rpx;

	padding-left: 32rpx;
	padding-right: 32rpx;
}

.item_wrapper {
	width: 100%;
	height:160rpx;
	background:rgba(253,231,207,1);
	box-shadow:0rpx 3rpx 6rpx rgba(65,62,59,0.16);
	border-radius:16rpx;
	
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-items: center;
	
	color:rgba(235,102,91,1);
}

.select_image {
	width: 32rpx;
	height: 32rpx;
	margin-left: 32rpx;
}

.rmb_text {
	font-size:24rpx;
	margin-left: 52rpx;
}

.money_text {
	margin-left: 8rpx;
	width:130rpx;
	font-size:56rpx;
	font-weight:bold;
}

.line {
	height: 127rpx;
	border-left: 1rpx dotted rgba(235,102,91,1);
}

.coupon_info_wrapper {
	margin-left: 64rpx;
	margin-right: 32rpx;
}

.content_text {
	font-size:32rpx;
}

.time_text {
	margin-top: 9rpx;
	font-size: 24rpx;
}

</style>
