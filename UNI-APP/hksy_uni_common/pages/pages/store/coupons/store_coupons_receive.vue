<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="coupons-content" @click.stop="emptyAction">
			<view class="coupons-title">
				领券
				<image src="/static/images/icon_address_close@3x.png" mode="" class="coupons-close" @click="closePopup"></image>
			</view>
			<view class="coupons-cell-content">
				<view class="coupons-cell" v-for="(coupon, index) in coupons" :key="index" style="box-shadow: 0px 8px 8px rgba(153, 153, 153, 0.2);">
					<view class="coupons-cell-row">
						<view class="coupons-cell-row">
							<view class="coupons-cell-unit">
								￥
							</view>
							<view class="coupons-cell-price">
								{{coupon['price']}}
							</view>
						</view>
						<view class="coupons-cell-column">
							<view class="coupons-cell-name">
								{{coupon['name']}}
							</view>
							<view class="coupons-cell-date">
								{{coupon['date']}}
							</view>
						</view>
					</view>
					<view class="coupons-cell-receive" :style="coupon['status'] == 1 ? 'color: rgba(153, 153, 153, 1);' : 'color: rgba(235, 102, 91, 1);'">
						{{coupon['status'] == 1 ? '已领取' : '立即领取'}}
					</view>
					<image src="/static/images/icon_coupons_receive@3x.png" mode="" class="coupons-cell-didreceive" v-if="coupon['status'] == 1"></image>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				coupons: [{
						price: 50,
						name: "全场满199可用",
						status: 1, // 0 未领取 1 已领取
						date: "2020.05.20-2020.06.20"
					},
					{
						price: 30,
						name: "指定商品满99可用",
						status: 0, // 0 未领取 1 已领取
						date: "2020.05.20-2020.06.20"
					}
				]
			}
		},
		methods: {
			//关闭alert
			closePopup() {
				this.closeAction()
			},
			emptyAction() {},
		},
		props: {
			//是否弹出显示
			visible: {
				type: Boolean,
				value: false
			},
			closeAction: Function,
		}
	}
</script>

<style>
	@import url("store_coupons_receive.css");
</style>
