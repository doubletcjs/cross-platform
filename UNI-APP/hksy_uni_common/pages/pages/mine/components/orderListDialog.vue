<!-- 联系客服 我的订单列表 对话框 -->
<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="content_wrapper" @click.stop="emptyAction">
			<!-- 标题 -->
			<view class="title_wrapper">
				<view class="title_text">我的订单</view>
				<view class="close_wrapper"><view class="close_text" @click="closePopup">X</view></view>
			</view>

			<!-- 订单列表 -->
			<scroll-view scroll-y="true" style="height: 774rpx;">
				<view class="list_wrapper" v-for="(item, index) in orderList" :key="index" :data-index="index" @click="selectItemAction">
					<view class="image_wrapper"><image class="order_image" :src="item.goodsImage" mode="aspectFill"></image></view>
					<view class="line">
						<view class="center_wrapper">
							<view class="goodsName_text">{{ item.goodsName }}</view>
							<view class="color_text">颜色分类：{{ item.color }}</view>
							<view class="status_text">{{ item.status }}</view>
						</view>
						<view class="right_wrapper">
							<view class="price_text">
								<span style="24rpx">￥</span>
								{{ item.price }}
							</view>
							<view class="number_text">X{{ item.number }}</view>
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
			orderList: [
				{
					goodsImage: '../../../../static/images/homepage_head_icon@3x.png',
					goodsName: '商品名称沙质谷物碗具有质朴而现代的氛围，营造出令人愉悦的平衡色调。',
					color: '中国红色',
					status: '交易完成',
					price: '388',
					number: 1,
					orderNo: "11111111"
				},
				{
					goodsImage: '../../../../static/images/homepages_default_bg.png',
					goodsName: '2商品名称商品名称商品名称商品名称商品名称1',
					color: '中国红色',
					status: '交易完成',
					price: '388',
					number: 1,
					orderNo: "11111111"
				},
				{
					goodsImage: '../../../../static/images/homepages_default_bg.png',
					goodsName: '3商品名称商品名称商品名称商品名称商品名称1',
					color: '中国红色',
					status: '交易完成',
					price: '388',
					number: 1,
					orderNo: "11111111"
				},
				{
					goodsImage: '../../../../static/images/homepages_default_bg.png',
					goodsName: '4商品名称商品名称商品名称商品名称商品名称1',
					color: '中国红色',
					status: '交易完成',
					price: '388',
					number: 1,
					orderNo: "11111111"
				},
				{
					goodsImage: '../../../../static/images/homepages_default_bg.png',
					goodsName: '5商品名称商品名称商品名称商品名称商品名称1',
					color: '中国红色',
					status: '交易完成',
					price: '388',
					number: 1,
					orderNo: "11111111"
				}
			],
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
			this.selectIndex = index;
			setTimeout(function() {
				// 回调结果给父组件
				let order = me.orderList[me.selectIndex];
				me.itemTapAction(order);
			}, 100);
			this.closePopup();
			
		},
		confirmPopup() {
			if (this.selectIndex == -1) {
				uni.showToast({
					icon: 'none',
					title: '请选择订单'
				});
				return;
			}

			
		}
	},
	props: {
		//是否弹出显示
		visible: {
			type: Boolean,
			value: false
		},
		money: {
			// 支付金额
			type: String,
			value: ''
		},
		discountsText: {
			// 优惠金额
			type: String,
			value: ''
		},
		closeAction: Function,
		itemTapAction: Function // 回调结果选择什么支付
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

.content_wrapper {
	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;

	max-height: 902rpx;
	min-height: 386;
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
	color: #888888;
	font-size: 48rpx;
	line-height: 128rpx;
	text-align: right;
}

.close_text {
	font-size: 36rpx;
}

.list_wrapper {
	display: flex;
	flex-direction: row;
	justify-content: start;
	align-items: flex-start;
	height: 258rpx;

	padding-left: 32rpx;
}

.image_wrapper {
	margin-top: 40rpx;
	width: 120rpx;
	height: 120rpx;
}

.order_image {
	width: 120rpx;
	height: 120rpx;
}

.line {
	display: flex;
	flex-direction: row;
	justify-content: start;
	align-items: flex-start;
	height: 100%;
	width: 100%;

	border-bottom: solid 1rpx rgba(0, 0, 0, 0.05);
}

.center_wrapper {
	margin-top: 40rpx;
	margin-left: 19rpx;
	width: 417rpx;
}

.goodsName_text {
	/* height:80rpx; */
	font-size: 28rpx;
	font-weight: bold;
	color: rgba(50, 50, 50, 1);

	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}

.color_text {
	margin-top: 8rpx;
	width: 100%;
	font-size: 24rpx;
	color: rgba(153, 153, 153, 1);
}

.status_text {
	margin-top: 16rpx;
	width: 100%;
	font-size: 24rpx;
	color: rgba(50, 50, 50, 1);
}

.right_wrapper {
	margin-top: 40rpx;
	margin-right: 32rpx;
	flex: 1;
}

.price_text {
	font-size: 32rpx;
	color: rgba(235, 102, 91, 1);
	text-align: right;
}

.number_text {
	margin-top: 43rpx;
	font-size: 24rpx;
	text-align: right;
	color: rgba(50, 50, 50, 1);
}
</style>
