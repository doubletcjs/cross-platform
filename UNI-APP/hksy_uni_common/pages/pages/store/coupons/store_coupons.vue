<template>
	<view class="main-body" style="background-color: rgba(247, 246, 245, 1);">
		<view class="coupons-list">
			<view class="coupons-cell" v-for="(coupon, index) in coupons" :key="index" :style="coupon['status'] == 1 ? 'background-color: rgba(255, 255, 255, 1);' : ''">
				<view class="coupons-cell-row">
					<view class="coupons-column">
						<view class="coupons-cell-row">
							<view class="coupons-cell-unit" :style="coupon['status'] == 1 ? 'color: rgba(153, 153, 153, 1);' : ''">
								￥
							</view>
							<view class="coupons-cell-price" :style="coupon['status'] == 1 ? 'color: rgba(153, 153, 153, 1);' : ''">
								{{coupon['price']}}
							</view>
						</view>
						<view class="coupons-full" :style="coupon['status'] == 1 ? 'color: rgba(153, 153, 153, 1);' : ''">
							{{coupon['full']}}
						</view>
					</view>
					<view class="coupons-cell-column">
						<view class="coupons-cell-name" style="color: rgba(27, 27, 27, 1);">
							{{coupon['name']}}
						</view>
						<view class="coupons-cell-date" style="color: rgba(153, 153, 153, 1);">
							{{coupon['tip']}}
						</view>
						<view class="coupons-cell-date" style="color: rgba(153, 153, 153, 1);">
							{{coupon['date']}}
						</view>
					</view>
				</view>
				<view class="coupons-cell-receive" :style="coupon['status'] == 1 ? 'color: rgba(153, 153, 153, 1); border-left: solid 1rpx rgba(153, 153, 153, 1); border-left-style: dotted;' : 'color: rgba(235, 102, 91, 1);'">
					{{coupon['status'] == 1 ? '已失效' : '立即使用'}}
				</view>
			</view>
		</view>
		<!-- 兑换 -->
		<view class="coupons-exchange" @click="exchangeAction">
			兑换券
		</view>
		<!-- 兑换弹框 -->
		<exchange :visible="exchangevisible" :cancelColor="'rgba(153, 153, 153, 1)'" :confirmColor="'rgba(235, 102, 91, 1)'"  :confirmText="'兑换'" :contentText="'兑换码'" :input="true" :closeAction="exchangeAction" :confirmAction="exchangeConfirm"></exchange>
	</view>
</template>

<script>
	import exchange from "../../../../components/alertview/alertview.vue"

	export default {
		data() {
			return {
				exchangevisible: false, 
				coupons: [{
						price: 50,
						name: "苹果旗舰店使用",
						tip: "店铺商品可用",
						full: "满199使用",
						status: 0, // 0 可使用 1 已失效
						date: "2020.05.20-2020.06.20"
					},
					{
						price: 30,
						name: "苹果旗舰店使用",
						tip: "店铺商品可用",
						full: "满99使用",
						status: 0, // 0 可使用 1 已失效
						date: "2020.05.20-2020.06.20"
					},
					{
						price: 30,
						name: "苹果旗舰店使用",
						tip: "店铺商品可用",
						full: "满99使用",
						status: 1, // 0 可使用 1 已失效
						date: "2020.05.20-2020.06.20"
					}
				]
			}
		},
		methods: {
			// 兑换弹框
			exchangeAction() {
				this.exchangevisible = !this.exchangevisible
			},
			exchangeConfirm(res) {
				console.log(res)
			}
		},
		components: {
			exchange
		}
	}
</script>

<style>
	@import url("store_coupons.css");
	@import url("store_coupons_receive.css");
</style>
