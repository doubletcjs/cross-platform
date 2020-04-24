<template>
	<view class="main-body">
		<view class="main-body-sub" style="margin-top: 0;" v-if="detail != null">
			<info v-if="currentIndex == 0" :detail="detail"></info>
			<config v-if="currentIndex == 1" :detail="detail"></config>
			<service v-if="currentIndex == 2" :detail="detail"></service> 
			<uniTab :current="currentIndex" :tabs="tabs" :selection="tabSelection"></uniTab>
			<view class="product-detail-buy-wapper" @tap="orderConfirm">
				立即购买
			</view>
			
			<uni-popup type="bottom" ref="buypopup">
				<orderconfirm :detail="detail" :colseAction="closeBuypopup" :buyAction="buyAction"></orderconfirm>
			</uni-popup>
			
			<!-- <uni-popup type="bottom" ref="paycodepopup">
				<paycodeinput :colseAction="closePaycodepopup" :completeAction="completePaycode"></paycodeinput>
			</uni-popup> -->
			
			<uni-popup type="bottom" ref="pw">
				<best-password  :show="showshare" :value="paymentPwd" :forget="false" digits="6" @submit="finish" @cancel="togglePayment"></best-password>
			</uni-popup>
			
		</view>
	</view>
</template>

<script>
	import info from "./productinfo.vue"
	import config from "./productconfig.vue"
	import service from "./productservice.vue"
	import uniTab from "../../components/hksy-uni-tab/hksy-uni-tab.vue"
	import storeapi from "./api/storeapi.js"
	import orderconfirm from "./order/orderconfirm.vue"
	import uniPopup from "../../components/uni-popup/uni-popup.vue"
	import paycodeinput from "../account/paycodefunction/paycodeinput.vue"
	import bestPassword from '@/components/best-password/best-password.vue';
	export default {
		data() {
			return {
				tabs: ["基本信息", "详细配置", "包装售后"],
				currentIndex: 0,
				productId: "",
				detail: null,
				showshare:true,
				paymentPwd:''
			}
		},
		methods: {
			requestProductDetail() {
				uni.showLoading({
					
				})

				var me = this
				storeapi.getProductDetail(this.productId, (data, msg) => {
					if (data != null) {
						me.detail = data
					} else {
						uni.showToast({
							title: msg,
							icon: "none"
						})
					}

					uni.hideLoading()
				})
			},
			tabSelection(index) { 
				if (this.currentIndex != index) {
					this.currentIndex = index
				}
			},
			orderConfirm() {
				this.$refs.buypopup.open() 
			},
			closeBuypopup() {
				this.$refs.buypopup.close()
			},
			closePaycodepopup() {
				// this.$refs.paycodepopup.close()
			},
			finish(val){
				this.completePaycode(val)
				this.togglePayment()
			},
			togglePayment(){
				// this.showshare = false;
				this.$refs.pw.close()
			},
			completePaycode(val) {
				setTimeout(() => {
					uni.showLoading({

					})
					var me = this
					storeapi.buyProduct(this.util.userID(), this.productId, val, (data, msg) => {
						uni.hideLoading()
						if (data != null) {
							// 购买成功
							uni.navigateTo({
								url: "./order/buycomplete"
							})
							
							uni.$emit(me.kAccountRefresh, null)
						} else {
							uni.showToast({
								title: msg,
								icon: "none"
							})
							this.$refs.pw.close()
						}
					})
				}, 400)
			}, 
			buyAction(recharge) {
				this.closeBuypopup()
				setTimeout(() => {
					if (recharge == true) {
						uni.navigateTo({
							url: "../coin/recharge/cashrecharge"
						})
					} else {
						if (this.util.emptyObject(this.util.userInfo().paymentCode) == true) {
							uni.navigateTo({
								url: "../account/paycodefunction/paycodefunction"
							})
						} else {
							// this.$refs.paycodepopup.open()
							this.$refs.pw.open()
						}
					}
				}, 400)
			}
		},
		onLoad(params) {
			if (params != null && params["productId"] != null) {
				this.productId = params["productId"]
				this.requestProductDetail()
			}
		},
		onShow() {
			
		},
		components: {
			info,
			config,
			service,
			uniTab,
			uniPopup,
			orderconfirm,
			paycodeinput,
			bestPassword
		}
	}
</script>

<style>
	@import url("productdetail.css");
</style>
