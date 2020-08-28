<!-- 客服 -->
<template>
	<view class="main-body-two">
		<scroll-view class="chatList_wrapper" id="chatList_wrapper" scroll-y="true">
			<view class="chatList_item_wrapper" v-for="(item, index) in chatList" :key="index" :data-index="index">
				<!-- 客服的布局 -->
				<view class="service_wrapper" v-if="item.type == 0">
					<view class="time_text">{{ item.time }}</view>
					<view class="service_chat_wrapper" v-if="item.msgType == 0">
						<image class="headImage" :src="item.headImage" mode="aspectFit"></image>
						<view class="service_text">{{ item.content }}</view>
					</view>
				</view>
				<!-- 用户 -->
				<view class="user_wrapper" v-if="item.type == 1">
					<view class="time_text">{{ item.time }}</view>
					<!-- 纯文字聊天 -->
					<view class="user_chat_wrapper" v-if="item.msgType == 0">
						<image class="headImage" :src="item.headImage" mode="aspectFit"></image>
						<view class="user_text">{{ item.content }}</view>
					</view>
					<!-- 订单 -->
					<view class="user_chat_wrapper" v-if="item.msgType == 1">
						<image class="headImage" :src="item.headImage" mode="aspectFit"></image>
						<view class="order_wrapper">
							
							<view class="order_top_wrapper">
								<view class="goodsImage_view">
									<image class="goodsImage" :src="item.order.goodsImage" mode="aspectFill"></image>
								</view>
								<view class="orderInfo_wrapper">
									<view class="order_goodsName_text">
										{{item.order.goodsName}}
									</view>
									<view class="order_color_text">
										颜色分类：{{item.order.color}}
									</view>
									<view class="orderStatus_text">
										{{item.order.status}}
									</view>
								</view>
							</view>
							<view class="orderNo_text">
								订单号：{{item.order.orderNo}}
							</view>
							
						</view>
					</view>
				</view>
			</view>
		</scroll-view>
		<!-- 底部输入框 -->
		<view class="bottom_box_wrapper">
			<view class="bottom_input_wrapper">
				<view class="input_wrapper" :style="questionText ? 'width:490rpx;' : 'width:568rpx;'">
					<textarea auto-height class="input_text" placeholder-class="input_text_placeholder" placeholder="请输入文字" type="text" v-model="questionText" />
				</view>
				<!-- +号，功能键 发送键 -->
				<view class="function_wrapper">
					<image class="service_add" src="../../../../static/images/service_add@2x.png" mode="aspectFit" @click="showAdd"></image>
					<image v-if="questionText" class="send_image" src="../../../../static/images/question_send@2x.png" mode="aspectFit" @click="sendQuestion"></image>
				</view>
			</view>
			<!-- class="animated bounceInUp" -->
			<addFileImage v-show="addFileShow" class="bounceInUp" ref="File" id="File"></addFileImage>
		</view>
		<!-- 选择订单列表对话框 -->
		<orderListDialog :visible="showOrderList" :closeAction="showOrderDialog" :itemTapAction="selectOrderAction"></orderListDialog>		
	</view>
</template>

<script>
// TODO 未实现地方，1.一进入界面，滑动到底，2.功能菜单未写成，没有顶上去聊天界面
import addFileImage from '../components/addFileimg.vue';
import orderListDialog from '../components/orderListDialog.vue';
export default {
	data() {
		return {
			chatList: [
				{
					headImage: '../../../../static/images/feedback@2x.png',
					type: 1, // 0 客服  1  用户
					msgType: 1, // 消息类型  0 文本  1订单  2图片
					order: {
						goodsImage: '../../../../static/images/homepages_default_bg.png',
						goodsName: '5商品名称商品名称商品名称商品名称商品名称1',
						color: '中国红色',
						status: '交易完成',
						price: '388',
						number: 1,
						orderNo: "11111111"
					},
					time: '2020-08-25 12:12'
				},
				{
					headImage: '../../../../static/images/feedback@2x.png',
					type: 0, // 0 客服  1  用户
					msgType: 0, // 消息类型  0 文本  1订单  2图片
					content: '111嗨，请问有什么可以帮到您~',
					time: '2020-08-25 12:00'
				},
				{
					headImage: '../../../../static/images/feedback@2x.png',
					type: 1, // 0 客服  1  用户
					msgType: 0, // 消息类型  0 文本  1订单  2图片
					content:
						'如何我的订单到哪了呢，在哪可以看如何我的订单到哪了呢，在哪可以看如何我的订单到哪了呢，在哪可以看如何我的订单到哪了呢，在哪可以看如何我的订单到哪了呢，在哪可以看如何我的订单到哪了呢，在哪可以看如何我的订单到哪了呢，在哪可以看如何我的订单到哪了呢，在哪可以看如何我的订单到哪了呢，在哪可以看如何我的订单到哪了呢，在哪可以看',
					time: '2020-08-25 12:03'
				},
				{
					headImage: '../../../../static/images/feedback@2x.png',
					type: 0, // 0 客服  1  用户
					msgType: 0, // 消息类型  0 文本  1订单  2图片
					content: '222嗨，请问有什么可以帮到您~',
					time: '2020-08-25 12:06'
				},
				{
					headImage: '../../../../static/images/feedback@2x.png',
					type: 1, // 0 客服  1  用户
					msgType: 0, // 消息类型  0 文本  1订单  2图片
					content: '如何我的订单到哪了呢，在哪可以看',
					time: '2020-08-25 12:09'
				},
				{
					headImage: '../../../../static/images/feedback@2x.png',
					type: 0, // 0 客服  1  用户
					msgType: 0, // 消息类型  0 文本  1订单  2图片
					content: '333嗨，请问有什么可以帮到您~',
					time: '2020-08-25 12:06'
				},
				{
					headImage: '../../../../static/images/feedback@2x.png',
					type: 1, // 0 客服  1  用户
					msgType: 0, // 消息类型  0 文本  1订单  2图片
					content: '如何我的订单到哪了呢，在哪可以看',
					time: '2020-08-25 12:09'
				}				
			],
			questionText: '', // 用户输入问题内容
			addFileShow: false, // 显示更多功能
			showOrderList: false, // 显示订单列表对话框
		};
	},
	methods: {
		// 显示功能键
		showAdd() {
			this.addFileShow = !this.addFileShow;
		},
		// 显示订单列表对话框
		showOrderDialog() {
			this.showOrderList = !this.showOrderList;
		},
		// 发送问题 纯文字
		sendQuestion() {},
		// 发送图片
		sendImgs(res) {},
		// 回调返回选中订单
		selectOrderAction(res) {
			console.log(JSON.stringify(res));
			
		},
	},
	components: {
		addFileImage,
		orderListDialog
	},
	created() {
		let me = this;
		uni.$on('closeFileModol', () => {
			setTimeout(() => {
				// console.log('closeFileModol--------');
			}, 0);
		});
		uni.$on('sendImg', res => {
			console.log(res);
			me.sendImgs(res);
		});
		uni.$on('openOderderList', res => {
			console.log(res);
			this.showAdd()
			this.showOrderDialog()
		});
	},
	onUnload() {
		// console.log('onUnload--------');
		uni.$off('closeFileModol');
		uni.$off('sendImg');
		uni.$off('openOderderList')
	}
};
</script>

<style>
@import url('staffService.css');
</style>
