<template>
	<view class="main-body">
		<view class="main-body-sub" style="margin-top: 0;" v-if="detail != null">
			<info v-if="currentIndex == 0" :detail="detail"></info>
			<config v-if="currentIndex == 1" :detail="detail"></config>
			<service v-if="currentIndex == 2" :detail="detail"></service>
			<uniTab :current="currentIndex" :tabs="tabs" :selection="tabSelection"></uniTab>
			<view :class="!countingDown ? 'product-detail-buy-wapper' : 'product-detail-no-buy-wapper'" @tap="orderConfirm">{{ title }}</view>

			<uni-popup type="bottom" ref="buypopup"><orderconfirm :detail="detail" :colseAction="closeBuypopup" :buyAction="buyAction"></orderconfirm></uni-popup>

			<!-- <uni-popup type="bottom" ref="paycodepopup">
				<paycodeinput :colseAction="closePaycodepopup" :completeAction="completePaycode"></paycodeinput>
      </uni-popup>-->

			<uni-popup type="bottom" ref="pw">
				<best-password :show="showshare" :value="paymentPwd" :forget="false" digits="6" @submit="finish" @cancel="togglePayment"></best-password>
			</uni-popup>
			<uni-popup ref="payMsgAlert" type="center">
				<alertview title="提示" :content="errorMsg" showCancel=false
				 :confirmAction="payMsgAlertClose"></alertview>
			</uni-popup>
		</view>
	</view>
</template>

<script>
import info from './productinfo.vue';
import config from './productconfig.vue';
import service from './productservice.vue';
import uniTab from '../../components/hksy-uni-tab/hksy-uni-tab.vue';
import storeapi from './api/storeapi.js';
import orderconfirm from './order/orderconfirm.vue';
import uniPopup from '../../components/uni-popup/uni-popup.vue';
import paycodeinput from '../account/paycodefunction/paycodeinput.vue';
import bestPassword from '@/components/best-password/best-password.vue';
import alertview from "../../components/hksy-uni-alertview/hksy-uni-alertview.vue"
export default {
	data() {
		return {
			tabs: ['基本信息', '详细配置', '包装售后'],
			currentIndex: 0,
			productId: '',
			detail: null,
			showshare: true,
			paymentPwd: '',
			title: '立即购买',
			countDownSecond: 60,
			countingDown: false ,// true 开始倒计时，不能购买矿机
			errorMsg: "", // 出错信息
		};
	},
	methods: {
		requestProductDetail() {
			uni.showLoading({});

			var me = this;
			storeapi.getProductDetail(this.productId, (data, msg) => {
				if (data) {
					me.detail = data[0].product;
					// console.log(JSON.stringify(data));
					// console.log(JSON.stringify(data[0].product));
					// console.log(JSON.stringify(data[0].product.productPreferentialPrice));
					// console.log(JSON.stringify(data[0].product.productUnitPrice));
					// console.log(parseFloat(data[0].product.productPreferentialPrice).toFixed(2));
					// console.log(parseFloat(data[0].product.productUnitPrice).toFixed(2));
					// console.log(JSON.stringify(data[0].type));
					// console.log(JSON.stringify(data[0].latTime));
					// 开始倒计时
					// data[0].type = 0;
					// data[0].latTime = 5;
					if (data[0].type == 1) {
						me.startCountDown(data[0].latTime);
						this.countingDown = true;
					}
				} else {
					uni.showToast({
						title: msg,
						icon: 'none'
					});
				}

				uni.hideLoading();
			});
		},

		startCountDown(latTime) {
			this.countDownSecond = latTime;
			this.countingDownAction();
		},
		countingDownAction() {
			if (this.countDownSecond == 0) {
				this.title = '立即购买';
				this.countingDown = false;
			} else {
				var me = this;
				this.countDownSecond -= 1;
				this.title = '系统结算中，' + me.s_to_hs(this.countDownSecond) + '后可以购买。';

				setTimeout(() => {
					me.countingDownAction();
				}, 1000);
			}
		},
		s_to_hs(s) { // 秒数转分钟秒数
			//计算分钟
			//算法：将秒数除以60，然后下舍入，既得到分钟数
			var h;
			h = Math.floor(s / 60);
			//计算秒
			//算法：取得秒%60的余数，既得到秒数
			s = s % 60;
			//将变量转换为字符串
			h += '';
			s += '';
			//如果只有一位数，前面增加一个0
			h = h.length == 1 ? '0' + h : h;
			s = s.length == 1 ? '0' + s : s;
			return h + ':' + s;
		},

		tabSelection(index) {
			if (this.currentIndex != index) {
				this.currentIndex = index;
			}
		},
		orderConfirm() {
			if (!this.countingDown) {
				this.$refs.buypopup.open();
			}
		},
		closeBuypopup() {
			this.$refs.buypopup.close();
		},
		closePaycodepopup() {
			// this.$refs.paycodepopup.close()
		},
		finish(val) {
			this.completePaycode(val);
			this.togglePayment();
		},
		togglePayment() {
			// this.showshare = false;
			this.$refs.pw.close();
		},
		completePaycode(val) { // 购买存储器
			setTimeout(() => {
				uni.showLoading({});
				var me = this;
				storeapi.buyProduct(this.util.userID(), this.productId, val, (data, msg) => {
					uni.hideLoading();
					if (data) {
						// 购买成功
						uni.navigateTo({
							url: './order/buycomplete'
						});

						uni.$emit(me.kAccountRefresh, null);
					} else {
						// 购买失败，不管什么情况重调getProductDetail，是因为20分系统结算，19分进来，21分用户点击购买
						this.requestProductDetail(); 
						this.$refs.pw.close();
						me.errorMsg = msg;
						setTimeout(() => {
							this.$refs.payMsgAlert.open()
						}, 500);						
						console.log("--" + msg);
					}
				});
			}, 400);
		},
		buyAction(recharge) {
			this.closeBuypopup();
			setTimeout(() => {
				if (recharge == true) {
					uni.navigateTo({
						url: '../coin/recharge/cashrecharge'
					});
				} else {
					if (this.util.emptyObject(this.util.userInfo().paymentCode) == true) {
						uni.navigateTo({
							url: '../account/paycodefunction/paycodefunction'
						});
					} else {
						// this.$refs.paycodepopup.open()
						this.$refs.pw.open();
					}
				}
			}, 400);
		},
		payMsgAlertClose() {
			this.$refs.payMsgAlert.close()
		},
	},
	onLoad(params) {
		if (params != null && params['productId'] != null) {
			this.productId = params['productId'];
			this.requestProductDetail();
		}
	},
	onShow() {},
	components: {
		info,
		config,
		service,
		uniTab,
		uniPopup,
		orderconfirm,
		paycodeinput,
		bestPassword,
		alertview
	}
};
</script>

<style>
@import url('productdetail.css');
</style>
