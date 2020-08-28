<template>
	<view>
		<!-- tab bar -->
		<view class="tab-bar">
			<view v-for="(item, index) in tabs" :key="index" :data-index="index" :class="tabIndex == index ? 'tab-bar-title tab-bar-title-select' : 'tab-bar-title'"
			 @click="tabSelectAction">
				{{item}}
				<!-- indicator -->
				<view class="tab-bar-indicator-mask">
					<view class="tab-bar-indicator" :style="tabIndex == index ? 'background-color: rgba(235, 102, 91, 1);' : ''"></view>
				</view>
			</view>
		</view>
		<!-- 订单列表 -->
		<view class="order-list">
			<!-- 订单 -->
			<view class="order-cell" v-for="(order, index) in orderList" :key="index">
				<!-- 头 -->
				<view class="order-cell-header">
					<!-- 商铺 -->
					<view class="order-cell-row">
						<image src="/static/images/icon_stowe@3x.png" mode="" class="order-cell-header-icon"></image>
						<view class="order-cell-header-name">
							{{order['store']}}
						</view>
					</view>
					<!-- 订单状态 -->
					<view class="order-cell-header-status">
						<!-- orderstatus: 0, // 0 待付款 1 待发货 2 待收货 3 交易完成 4 交易关闭 -->
						{{order['orderstatus'] == 0 ? '待付款' : 
						order['orderstatus'] == 1 ? '待发货' : 
						order['orderstatus'] == 2 ? '待收货' : 
						order['orderstatus'] == 3 ? '交易完成' : 
						order['orderstatus'] == 4 ? '交易关闭' : ''}}
					</view>
				</view>
				<!-- 商品 -->
				<view class="product-cell" v-for="(product, idx) in order['products']" :key="idx">
					<view class="order-cell-row" style="align-items: flex-start; width: 72%;">
						<!-- 封面 -->
						<image src="" mode="" class="product-cell-cover"></image>
						<view class="product-cell-column" style="margin-left: 16rpx; width: 52%;">
							<!-- 名称 -->
							<view class="product-cell-name">
								{{product['name']}}
							</view>
							<!-- 规格 -->
							<text class="product-cell-spec">
								{{product['spec']}}
							</text>
						</view>
					</view>
					<view class="product-cell-column" style="align-items: flex-end; justify-content: flex-start; position: absolute; right: 0; height: 218rpx;">
						<view class="product-cell-row">
							<view class="product-unit">
								¥
							</view>
							<view class="product-price">
								{{product['price']}}
							</view>
						</view>
						<view class="product-count">
							X1
						</view>
						<view :class="product['productstatus'] == 1 ? 'product-status-grey' : 'product-status'">
							<!-- productstatus: 0, // 0 正常状态 1 可退换 2 退换中 3 退换成功 4 退款成功 5 交易超时 6 退款中 7 退货中 -->
							{{product['productstatus'] == 1 ? '退换' :
							 product['productstatus'] == 2 ? '退换中' :
							 product['productstatus'] == 3 ? '退换成功' :
							 product['productstatus'] == 4 ? '退款成功' :
							 product['productstatus'] == 5 ? '交易超时' :
							 product['productstatus'] == 6 ? '退款中' :
							 product['productstatus'] == 7 ? '退货中' : ''}}
						</view>
					</view>
				</view>
				<!-- 结算 -->
				<view class="order-cell-row" style="justify-content: flex-end;">
					<view class="order-cell-product-count">
						共{{order['count']}}件商品
					</view>
					<view class="order-cell-row" style="margin-left: 34rpx;">
						<view class="order-cell-payment">
							实付款:
						</view>
						<view class="rorder-cell-p">
							￥{{order['amount']}}
						</view>
					</view>
				</view>
				<!-- 操作 -->
				<view class="order-cell-row" style="margin-top: 32rpx; justify-content: flex-end;">
					<!-- orderstatus: 0, // 0 待付款 1 待发货 2 待收货 3 交易完成 4 交易关闭 -->
					<view class="order-cell-row" v-if="order['orderstatus'] == 0">
						<view class="order-cell-action">
							取消订单
						</view>
						<view class="order-cell-action-hightlight" style="margin-left: 16rpx;">
							付款
						</view>
					</view>
					<view class="order-cell-row" v-else-if="order['orderstatus'] == 1">
						<view class="order-cell-action">
							申请退款
						</view>
						<view class="order-cell-action-hightlight" style="margin-left: 16rpx;">
							再次购买
						</view>
					</view>
					<view class="order-cell-row" v-else-if="order['orderstatus'] == 2">
						<view class="order-cell-action">
							查看物流
						</view>
						<view class="order-cell-action-hightlight" style="margin-left: 16rpx;">
							确认收货
						</view>
					</view>
					<view class="order-cell-row" v-else-if="order['orderstatus'] == 3"> 
						<view class="order-cell-action-hightlight" style="margin-left: 16rpx;">
							再次购买
						</view>
					</view>
					<view class="order-cell-row" v-else-if="order['orderstatus'] == 4">
						<view class="order-cell-action">
							删除订单
						</view>
						<view class="order-cell-action-hightlight" style="margin-left: 16rpx;">
							再次购买
						</view>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		// orderstatus: 0, // 0 待付款 1 待发货 2 待收货 3 交易完成 4 交易关闭
		// productstatus: 0, // 0 正常状态 1 可退换 2 退换中 3 退换成功 4 退款成功 5 交易超时 6 退款中 7 退货中
		data() {
			return {
				tabs: [
					"全部",
					"待付款",
					"待发货",
					"待收货",
					"已完成",
				],
				tabIndex: 0,
				orderList: [{
						store: "好物角落",
						orderstatus: 0, // 0 待付款 1 待发货 2 待收货 3 交易完成 4 交易关闭
						products: [{
							cover: "",
							name: "手机黄金搭档,PD快充折叠支架无线充电宝",
							count: 1,
							price: 149.00,
							spec: "绿色",
							productstatus: 0, // 0 正常状态 1 可退换 2 退换中 3 退换成功 4 退款成功 5 交易超时 6 退款中 7 退货中
						}, ],
						count: 1,
						amount: 149.00
					},
					{
						store: "剁手党集中营",
						orderstatus: 1, // 0 待付款 1 待发货 2 待收货 3 交易完成 4 交易关闭
						products: [{
							cover: "",
							name: "包包时钟，简洁时尚的家装必备",
							count: 1,
							price: 149.00,
							spec: "皮扣款",
							productstatus: 0, // 0 正常状态 1 可退换 2 退换中 3 退换成功 4 退款成功 5 交易超时 6 退款中 7 退货中
						}, ],
						count: 1,
						amount: 149.00
					},
					{
						store: "铲屎官Club",
						orderstatus: 2, // 0 待付款 1 待发货 2 待收货 3 交易完成 4 交易关闭
						products: [{
								cover: "",
								name: "健脾养胃全价全猫期功能性猫粮",
								count: 1,
								price: 149.00,
								spec: "英格兰短毛",
								productstatus: 1, // 0 正常状态 1 可退换 2 退换中 3 退换成功 4 退款成功 5 交易超时 6 退款中 7 退货中
							},
							{
								cover: "",
								name: "宠物狗狗玩具耐咬大型犬种可使用",
								count: 1,
								price: 149.00,
								spec: "藏南色",
								productstatus: 2, //0 正常状态 1 可退换 2 退换中 3 退换成功 4 退款成功 5 交易超时 6 退款中 7 退货中
							},
						],
						count: 2,
						amount: 298.00
					},
					{
						store: "剁手党集中营",
						orderstatus: 3, // 0 待付款 1 待发货 2 待收货 3 交易完成 4 交易关闭
						products: [{
								cover: "",
								name: "宠物用具，宠物玩具，宠物食物小礼包",
								count: 1,
								price: 149.00,
								spec: "蓝色",
								productstatus: 1, // 0 正常状态 1 可退换 2 退换中 3 退换成功 4 退款成功 5 交易超时 6 退款中 7 退货中
							},
							{
								cover: "",
								name: "沙质谷物碗具有质朴而现代的氛围，营造出令人愉悦的平衡色调。",
								count: 1,
								price: 149.00,
								spec: "杨柳餐具套装",
								productstatus: 3, //0 正常状态 1 可退换 2 退换中 3 退换成功 4 退款成功 5 交易超时 6 退款中 7 退货中
							},
						],
						count: 2,
						amount: 298.00
					},
					{
						store: "剁手党集中营",
						orderstatus: 4, // 0 待付款 1 待发货 2 待收货 3 交易完成 4 交易关闭
						products: [{
							cover: "",
							name: "雅诗兰黛Double Wear粉底液",
							count: 1,
							price: 490.00,
							spec: "P01象牙白",
							productstatus: 5, // 0 正常状态 1 可退换 2 退换中 3 退换成功 4 退款成功 5 交易超时 6 退款中 7 退货中
						}, ],
						count: 1,
						amount: 490.00
					},
					{
						store: "剁手党集中营",
						orderstatus: 4, // 0 待付款 1 待发货 2 待收货 3 交易完成 4 交易关闭
						products: [{
							cover: "",
							name: "宠物狗狗和猫咪的灰色麻绳款宠物玩具",
							count: 1,
							price: 149.00,
							spec: "灰色",
							productstatus: 4, // 0 正常状态 1 可退换 2 退换中 3 退换成功 4 退款成功 5 交易超时 6 退款中 7 退货中
						}, ],
						count: 1,
						amount: 149.00
					},
					{
						store: "剁手党集中营",
						orderstatus: 2, // 0 待付款 1 待发货 2 待收货 3 交易完成 4 交易关闭
						products: [{
								cover: "",
								name: "手机黄金搭档,PD快充折叠支架无线充电宝",
								count: 1,
								price: 149.00,
								spec: "蓝色",
								productstatus: 6, // 0 正常状态 1 可退换 2 退换中 3 退换成功 4 退款成功 5 交易超时 6 退款中 7 退货中
							},
							{
								cover: "",
								name: "沙质谷物碗具有质朴而现代的氛围，营造出令人愉悦的平衡色调。",
								count: 1,
								price: 149.00,
								spec: "购买杨柳餐具\n套装送蓝色收纳袋",
								productstatus: 7, // 0 正常状态 1 可退换 2 退换中 3 退换成功 4 退款成功 5 交易超时 6 退款中 7 退货中
							},
						],
						count: 2,
						amount: 298.00
					},
				]
			}
		},
		methods: {
			//tab
			tabSelectAction(res) {
				var index = res.currentTarget.dataset.index
				this.tabIndex = index
			},
		}
	}
</script>

<style>
	@import url("order_list.css");
	@import url("order_product.css");
</style>
