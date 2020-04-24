<template>
	<view class="order-confirm-body" v-if="product != null">
		<view class="order-confirm-title-wapper">
			<view class="order-confirm-title">
				确认订单
			</view>
			<view class="order-confirm-close-wapper" @tap="colseAction">
				<!-- <image src="/static/images/guanbi@3x.png" mode="aspectFit" class="order-confirm-close-image"></image> -->
			</view>
		</view>

		<view class="order-confirm-item-wapper" style="margin-top: 24rpx;">
			<view class="order-confirm-item-name">
				商品
			</view>
			<view class="order-confirm-item-name" style="">
				{{product.productName}}
			</view>
		</view>
		<view class="order-confirm-item-wapper">
			<view class="order-confirm-item-name">
				售卖价格
			</view>
			<view class="order-confirm-item-name" style="text-align: right;">
				{{parseFloat(price).toFixed(2)}} 个
			</view>
		</view>
		<view class="order-confirm-item-wapper">
			<view class="order-confirm-item-name">
				当前余额
			</view>
			<view class="order-confirm-item-name" style="margin-left: 40rpx; max-width: 410rpx;">
				{{parseFloat(coin).toFixed(2)}} 个
			</view>
		</view>
		<view class="order-confirm-tip" v-if="price - coin > 0">
			余额不足 
		</view>
		<view class="order-confirm-function-wapper" :style="buttonStyle">
			<view class="order-confirm-button-text" style="background-color: rgba(204, 204, 204, 1);border-radius: 15rpx;" @tap="colseAction">
				取 消
			</view>
			<view v-if="price - coin > 0" class="order-confirm-button-text" style="background:rgba(23,96,255,1);border-radius: 15rpx;margin-left: 44rpx;" @tap="buyFunctionAction">
				立即充值
			</view>
			<view v-else class="order-confirm-button-text" style="background:rgba(23,96,255,1);border-radius: 15rpx;margin-left: 44rpx;" @tap="buyFunctionAction">
				{{this.buyString}}
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				coin: 0.0,
				product: {},
				buttonStyle: "margin-top: 170rpx;",
				price: 0.0,
				buyString: "立即购买"
			}
		},
		methods: {
			buyFunctionAction() {
				var recharge = false
				if (this.price - this.coin > 0) {
					recharge = true
				} 
				
				this.buyAction(recharge)
			}
		},
		props: {
			detail: null,
			colseAction: Function,
			buyAction: Function
		},
		created() {
			setTimeout(() => {
				this.price = this.detail.productPreferentialPrice
				this.coin = this.util.userInfo().coin.toFixed(2)
				if (this.price - this.coin > 0) {
					this.buyString = "去充值" 
				}
				
				// #ifdef H5
				if (this.price - this.coin > 0) {
					this.buttonStyle = "margin-top: 70rpx;"
				} else {
					this.buttonStyle = "margin-top: 90rpx;"
				}
				// #endif 

				this.product = this.detail
			}, 0)
		}
	}
</script>

<style>
	@import url("orderconfirm.css");
</style>
