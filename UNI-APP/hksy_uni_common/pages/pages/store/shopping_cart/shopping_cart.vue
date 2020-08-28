<template>
	<view class="main-body">
		<view v-if="orderList.length > 0">
			<view class="shopping-cart-bottom">
				<view class="shopping-cart-row" @click="selectAllOrders">
					<image :src="allProducts ? '/static/images/detail_member_chose_sel@3x.png' : '/static/images/detail_member_chose@3x.png'"
					 mode="" class="shopping-cart-icon"></image>
					<view class="shopping-cart-all">
						全选
					</view>
				</view>
				<view class="shopping-cart-row">
					<view class="shopping-cart-column" style="align-items: flex-end;">
						<view class="shopping-cart-row">
							<view class="shopping-cart-total">
								合计:
							</view>
							<view class="shopping-cart-total-price">
								￥{{totalPrice}}
							</view>
						</view>
						<view class="shopping-cart-row" style="margin-top: 8rpx;">
							<view class="shopping-cart-freight">
								不包含运费
							</view>
						</view>
					</view>
					<view class="shopping-cart-settlement">
						结算
					</view>
				</view>
			</view>
			<view class="shopping-cart-list">
				<view class="shopping-cart-cell" v-for="(order, index) in orderList" :key="index">
					<view class="shopping-cart-cell-header" v-if="order.products.length > 0">
						<view class="shopping-cart-row">
							<image :src="order['selectall'] ? '/static/images/detail_member_chose_sel@3x.png' : '/static/images/detail_member_chose@3x.png'"
							 mode="" class="shopping-cart-icon" :data-section="index" @click="goodSelectAll"></image>
							<image src="/static/images/icon_stowe@3x.png" mode="" class="shopping-cart-cell-store"></image>
							<view class="shopping-cart-cell-store-name">
								{{order['storename']}}
							</view>
						</view>
						<view class="shopping-cart-cell-coupon" :data-section="index" @click="couponsAction">
							领券
						</view>
					</view>
					<view class="shopping-cart-product-mask" v-for="(product, idx) in order.products" :key="idx">
						<view class="shopping-cart-product-delete" :data-section="index" :data-row="idx" @click="removeProduct">
							删除
						</view>
						<view class="shopping-cart-product-collection" :data-section="index" :data-row="idx" @click="collectProduct">
							收藏
						</view>
						<!-- 商品 -->
						<view class="shopping-cart-product" :style="styleResults[index][idx]" :data-section="index" :data-row="idx"
						 @touchstart="touchS" @touchmove="touchM" @touchend="touchE">
							<!-- style="left: -266rpx; right: 266rpx;" -->
							<image :src="product['select'] ? '/static/images/detail_member_chose_sel@3x.png' : '/static/images/detail_member_chose@3x.png'"
							 mode="" class="shopping-cart-icon" :data-section="index" :data-row="idx" @click="goodSelect"></image>
							<view class="shopping-cart-product-row">
								<image src="" mode="" class="shopping-cart-product-cover"></image>
								<view class="shopping-cart-product-column">
									<view style="display: flex; flex-direction: column;">
										<view class="shopping-cart-product-name">
											{{product['name']}}
										</view>
										<view class="shopping-cart-product-spec">
											{{product['spec']}}
										</view>
									</view>
									<view class="shopping-cart-product-bottom">
										<view style="display: flex; flex-direction: row; align-items: flex-end;">
											<view class="shopping-cart-product-util">
												¥
											</view>
											<view class="shopping-cart-product-price">
												{{product['price']}}
											</view>
										</view>
										<view class="shopping-cart-product-count-mask">
											<!-- - -->
											<view class="shopping-cart-product-count-action" :data-section="index" :data-row="idx" @click="countDown">
												-
											</view>
											<!-- count -->
											<view class="shopping-cart-product-count">
												{{product['number']}}
											</view>
											<!-- + -->
											<view class="shopping-cart-product-count-action" :data-section="index" :data-row="idx" @click="countUp">
												+
											</view>
										</view>
									</view>
								</view>
							</view>
						</view>
					</view>
				</view>
			</view>
		</view>
		<view class="shopping-cart-empty-content" v-else>
			<image src="" mode="" class="shopping-cart-empty-image"></image>
			<view class="shopping-cart-empty">
				购物车还是空的哦~
			</view>
			<view class="shopping-cart-empty-jump" @click="backHomeAction">
				去角落逛逛
			</view>
		</view>
		<!-- 领券 -->
		<coupons :visible="couponsvisible" :closeAction="couponsAction"></coupons>
	</view>
</template>

<script>
	import coupons from "../coupons/store_coupons_receive.vue"

	export default {
		data() {
			return {
				orderList: [{
						storename: "剁手党集中营",
						selectall: false,
						products: [{
								number: 1,
								price: 148,
								name: "手机黄金搭档,PD快充折叠支架无线充电宝1",
								spec: "蓝色",
								cover: "",
								select: false,
							},
							{
								number: 2,
								price: 149,
								name: "手机黄金搭档,PD快充折叠支架无线充电宝2",
								spec: "蓝色",
								cover: "",
								select: false,
							},
						]
					},
					{
						storename: "剁手党集中营1",
						selectall: false,
						products: [{
								number: 3,
								price: 128,
								name: "手机黄金搭档,PD快充折叠支架无线充电宝3",
								spec: "蓝色",
								cover: "",
								select: false,
							},
							{
								number: 4,
								price: 158,
								name: "手机黄金搭档,PD快充折叠支架无线充电宝4",
								spec: "蓝色",
								cover: "",
								select: false,
							},
							{
								number: 5,
								price: 118,
								name: "手机黄金搭档,PD快充折叠支架无线充电宝5",
								spec: "蓝色",
								cover: "",
								select: false,
							},
							{
								number: 6,
								price: 198,
								name: "手机黄金搭档,PD快充折叠支架无线充电宝6",
								spec: "蓝色",
								cover: "",
								select: false,
							},
						]
					},
					{
						storename: "剁手党集中营2",
						selectall: false,
						products: [{
							number: 7,
							price: 298,
							name: "手机黄金搭档,PD快充折叠支架无线充电宝7",
							spec: "蓝色",
							cover: "",
							select: false,
						}, {
							number: 8,
							price: 398,
							name: "手机黄金搭档,PD快充折叠支架无线充电宝8",
							spec: "蓝色",
							cover: "",
							select: false,
						}, {
							number: 9,
							price: 498,
							name: "手机黄金搭档,PD快充折叠支架无线充电宝9",
							spec: "蓝色",
							cover: "",
							select: false,
						}, ]
					}, {
						storename: "剁手党集中营3",
						selectall: false,
						products: [{
							number: 10,
							price: 98,
							name: "手机黄金搭档,PD快充折叠支架无线充电宝10",
							spec: "蓝色",
							cover: "",
							select: false,
						}, ]
					}, {
						storename: "剁手党集中营4",
						selectall: false,
						products: [{
							number: 11,
							price: 1298,
							name: "手机黄金搭档,PD快充折叠支架无线充电宝11",
							spec: "蓝色",
							cover: "",
							select: false,
						}, {
							number: 12,
							price: 1198,
							name: "手机黄金搭档,PD快充折叠支架无线充电宝12",
							spec: "蓝色",
							cover: "",
							select: false,
						}, {
							number: 13,
							price: 998,
							name: "手机黄金搭档,PD快充折叠支架无线充电宝13",
							spec: "蓝色",
							cover: "",
							select: false,
						}, {
							number: 14,
							price: 598,
							name: "手机黄金搭档,PD快充折叠支架无线充电宝14",
							spec: "蓝色",
							cover: "",
							select: false,
						}, ]
					}, {
						storename: "剁手党集中营5",
						selectall: false,
						products: [{
							number: 15,
							price: 798,
							name: "手机黄金搭档,PD快充折叠支架无线充电宝15",
							spec: "蓝色",
							cover: "",
							select: false,
						}, ]
					},
				],
				startX: "",
				actionButtonsWidth: 266, //删除按钮宽度单位（rpx）
				styleResults: [],
				totalPrice: 0.0, //总价
				allProducts: false,
				couponsvisible: false,
			}
		},
		components: {
			coupons
		},
		methods: {
			// 领券
			couponsAction(res) {
				if (res) {
					var section = res.currentTarget.dataset.section
				}
				this.couponsvisible = !this.couponsvisible
			},
			// 返回首页
			backHomeAction() {
				uni.switchTab({
					url: "/pages/tabs/home/home_tab",
				});
			},
			// 滑动
			touchS(res) {
				if (res.changedTouches.length == 1) {
					//设置触摸起始点水平方向位置
					this.startX = res.touches[0].clientX * 2
					this.fetchDefaultStyle()
				}
			},
			touchM(res) {
				// left: -266rpx; right: 266rpx
				if (res.changedTouches.length == 1) {
					//手指移动时水平方向位置
					var moveX = res.touches[0].clientX * 2
					//手指起始点位置与移动期间的差值
					var disX = this.startX - moveX
					var _actionButtonsWidth = this.actionButtonsWidth
					var txtStyle = ""
					if (disX == 0 || disX < 0) {
						//如果移动距离小于等于0，说明向右滑动，文本层位置不变
						txtStyle = "left: 0; right: 0;"
					} else if (disX > 0) {
						//移动距离大于0，文本层left值等于手指移动距离
						txtStyle = "left: -" + disX + "rpx;" + " " + "right: " + disX + "rpx;"
						if (disX >= _actionButtonsWidth) {
							//控制手指移动距离最大值为删除按钮的宽度
							txtStyle = "left: -" + _actionButtonsWidth + "rpx;" + " " + "right: " + _actionButtonsWidth + "rpx;"
						}
					}

					//获取手指触摸的是哪一项
					var section = res.currentTarget.dataset.section
					var row = res.currentTarget.dataset.row

					var styles = this.styleResults[section]
					styles[row] = txtStyle
					this.$set(this.styleResults, section, styles)
				}
			},
			touchE(res) {
				if (res.changedTouches.length == 1) {
					//手指移动结束后水平位置
					var endX = res.changedTouches[0].clientX * 2
					//触摸开始与结束，手指移动的距离
					var disX = this.startX - endX
					var _actionButtonsWidth = this.actionButtonsWidth
					//如果距离小于删除按钮的1/2，不显示删除按钮
					var txtStyle = disX > _actionButtonsWidth / 2 ? ("left: -" + _actionButtonsWidth + "rpx;" + " " + "right: " +
						_actionButtonsWidth + "rpx;") : "left: 0; right: 0;"

					//获取手指触摸的是哪一项
					var section = res.currentTarget.dataset.section
					var row = res.currentTarget.dataset.row

					var styles = this.styleResults[section]
					styles[row] = txtStyle
					this.$set(this.styleResults, section, styles)
				}
			},
			// 默认样式
			fetchDefaultStyle() {
				var _orders = []
				for (var i = 0; i < this.orderList.length; i++) {
					var order = this.orderList[i]
					var _products = []
					for (var j = 0; j < order.products.length; j++) {
						_products.push("left: 0; right: 0;")
					}
					_orders.push(_products)
				}

				this.styleResults = _orders
			},
			// 数量切换
			countUp(res) {
				var section = res.currentTarget.dataset.section
				var row = res.currentTarget.dataset.row

				var products = this.orderList[section].products
				var product = products[row]
				var number = product.number
				number += 1
				product.number = number
				products[row] = product

				this.orderList[section].products = products
				this.priceCalculate()
			},
			countDown(res) {
				var section = res.currentTarget.dataset.section
				var row = res.currentTarget.dataset.row

				var products = this.orderList[section].products
				var product = products[row]
				var number = product.number
				number -= 1
				if (number < 1) {
					number = 1
				}

				product.number = number
				products[row] = product

				this.orderList[section].products = products
				this.priceCalculate()
			},
			// 商品选择
			goodSelect(res) {
				var section = res.currentTarget.dataset.section
				var row = res.currentTarget.dataset.row

				var products = this.orderList[section].products
				var product = products[row]
				product.select = !product.select
				products[row] = product

				var selectall = true
				for (var i = 0; i < products.length; i++) {
					var item = products[i]
					if (item.select == false) {
						selectall = false
						break
					}
				}

				this.orderList[section].selectall = selectall
				this.orderList[section].products = products

				this.priceCalculate()
			},
			goodSelectAll(res) {
				var section = res.currentTarget.dataset.section
				var products = this.orderList[section].products
				var selectall = !this.orderList[section].selectall
				for (var i = 0; i < products.length; i++) {
					var item = products[i]
					item.select = selectall
					products[i] = item
				}

				this.orderList[section].selectall = selectall
				this.orderList[section].products = products

				this.priceCalculate()
			},
			// 商品价格计算
			priceCalculate() {
				var price = 0.0
				var _allProducts = true
				for (var i = 0; i < this.orderList.length; i++) {
					var order = this.orderList[i]
					for (var j = 0; j < order.products.length; j++) {
						var product = order.products[j]
						if (product.select) {
							price += product.price * product.number
						}
					}

					if (order.selectall == false) {
						_allProducts = order.selectall
					}
				}

				this.totalPrice = price
				this.allProducts = _allProducts
			},
			// 全部商品选择
			selectAllOrders() {
				this.allProducts = !this.allProducts
				var _orderList = this.orderList
				for (var i = 0; i < _orderList.length; i++) {
					var order = _orderList[i]
					for (var j = 0; j < order.products.length; j++) {
						var product = order.products[j]
						product.select = this.allProducts
						order.products[j] = product
					}

					order.selectall = this.allProducts
					_orderList[i] = order
				}

				this.priceCalculate()
			},
			// 删除商品
			removeProduct(res) {
				this.fetchDefaultStyle()
				var section = res.currentTarget.dataset.section
				var row = res.currentTarget.dataset.row
				var weakSelf = this
				uni.showModal({
					title: "提示",
					content: "是否删除该商品？",
					cancelText: "取消",
					confirmText: "确定",
					complete(e) {
						if (e.confirm) {
							var orders = weakSelf.orderList[section]
							var products = orders.products
							products.splice(row, 1)
							orders.products = products
							if (products.length == 0) {
								weakSelf.orderList.splice(section, 1)
							} else {
								weakSelf.orderList[section] = orders
							}

							weakSelf.priceCalculate()
						}
					}
				})
			},
			// 收藏商品 
			collectProduct(res) {
				this.fetchDefaultStyle()
				var section = res.currentTarget.dataset.section
				var row = res.currentTarget.dataset.row
				console.log(res)
			}
		},
		onShow() {
			this.fetchDefaultStyle()
		}
	}
</script>

<style>
	@import url("shopping_cart.css");
</style>
