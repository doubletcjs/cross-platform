<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="coin-transfers-tip-wapper">
				<view class="coin-transfers-tip">金币资产</view>
				<view class="coin-transfers-tip">{{ _formatNumber(coin) }}个</view>
			</view>
			<view class="mine-page-cell-section-wapper" style="margin-top: 70rpx;">
				<view class="coin-transfers-item-tip">转出数量</view>
				<view class="coin-transfers-input-wapper" style="border-bottom: solid 1.6rpx rgba(21, 25, 54, 1);">
					<input type="digit" id="balance" :value="balanceValue" @input="textFieldOnchanged" :placeholder="placeholder"
					 placeholder-class="coin-transfers-input-placeholder" class="coin-transfers-input" style="width: 80%;" />
					<view class="coin-transfers-rollout" @tap="rolloutAll">全部转出</view>
				</view>
				<view class="coin-transfers-content-wapper">
					<view class="coin-transfers-content">对方账户</view>
					<input type="number" maxlength="11" id="account" v-model="accountValue" @input="textFieldOnchanged" placeholder="请输出对方账户手机号码"
					 placeholder-class="coin-transfers-input-placeholder" class="coin-transfers-input" style="width: 70%; text-align: right;" />
				</view>
			</view>
			<view class="coin-transfers-confirm" :style="style" @tap="confirmTransfers">确认转出</view>
		</view>

		<uni-popup ref="confirmalert" type="center">
			<alertview :title="'您确认转账到' + accountValue + '?'" :content="'转账金币：' + balanceValue + '个'" confirmTitle="确认"
			 isTtransfers="true" :cancelAction="closeConfirm" :confirmAction="showPaycode"></alertview>
		</uni-popup>

		<!-- 请输入支付密码popup -->
		<uni-popup type="bottom" ref="paycodepopup">
			<paycodeinput :colseAction="closePaycodepopup" :completeAction="completePaycode"></paycodeinput>
		</uni-popup>
	</view>
</template>

<script>
	import uniPopup from '../../../components/uni-popup/uni-popup.vue';
	import paycodeinput from '../../account/paycodefunction/paycodeinput.vue';
	import alertview from '../../../components/hksy-uni-alertview/hksy-uni-alertview.vue';
	import coinapi from '../api/coinapi.js';

	export default {
		data() {
			return {
				coin: '',
				balanceValue: '',
				accountValue: '',
				placeholder: '',
				style: {
					top: ''
				}
			};
		},
		components: {
			uniPopup,
			paycodeinput,
			alertview
		},
		onReady() {
			let _this = this;

			uni.getSystemInfo({
				success(res) {
					_this.style.top = (res.windowHeight - 98) + 'rpx';
				}
			})
		},
		methods: {
			textFieldOnchanged(res) {
				var textfieldId = res.target.id;
				var textfieldText = res.target.value;

				if (textfieldId == 'balance') {
					this.balanceValue = textfieldText;
				} else if (textfieldId == 'account') {
					textfieldText = textfieldText
						.replace(/\s/g, '')
						.replace(/[^0-9]/g, '')
						.toUpperCase();
					this.accountValue = textfieldText;
					setTimeout(() => {
						this.accountValue = textfieldText;
					}, 0);
				}
			},
			rolloutAll() {
				uni.hideKeyboard();
				this.balanceValue = this.util.userInfo().coin;
			},
			emptyTranfersInfo() {
				uni.hideKeyboard();
				this.balanceValue = '';
				this.accountValue = '';
			},
			confirmTransfers() {
				var msg = '';
				if (this.util.emptyObject(this.balanceValue) == true) {
					msg = '请输入转出金额';
				} else if (this.util.emptyObject(this.accountValue) == true) {
					msg = '请输入账户';
				} else if (this.accountValue == this.util.userInfo().phone) {
					msg = '无法转入当前登录账户';
				}

				if (msg.length > 0) {
					uni.showToast({
						title: msg,
						icon: 'none'
					});
					return;
				}

				uni.hideKeyboard();
				if (this.util.emptyObject(this.util.userInfo().paymentCode) == true) {
					// 设置支付密码
					uni.navigateTo({
						url: '../../account/paycodefunction/paycodefunction'
					});
				} else {
					this.$refs.confirmalert.open();
					/*
						var me = this
						uni.showModal({
							title: "您确认转账到" + this.accountValue + "?",
							content: "转账金币：" + this.balanceValue + "个",
							cancelText: "取消",
							confirmText: "确定",
							cancelColor: "#9198AD",
							confirmColor: "#1760FF",
							success: function(res) {
								if (res.confirm) {
									me.$refs.paycodepopup.open()
								} else if (res.cancel) {
									console.log('用户点击取消');
								}
							}
						})
						*/
				}
			},
			closePaycodepopup() {
				this.$refs.paycodepopup.close();
			},
			closeConfirm() {
				this.$refs.confirmalert.close();
			},
			showPaycode() { 
				this.closeConfirm() 
				this.$refs.paycodepopup.open();
			},
			completePaycode(val) {
				setTimeout(() => {
					uni.showLoading({});

					var me = this;
					var params = {};
					params['ownerUserId'] = this.util.userID();
					params['phone'] = this.accountValue;
					params['paymentCode'] = val;
					params['balance'] = this.balanceValue;

					coinapi.transfer(params, (data, msg) => {
						if (data != null) {
							uni.$emit(me.kAccountRefresh, null);

							setTimeout(() => {
								uni.hideLoading();
								// 转出成功
								uni.redirectTo({
									url: '../recharge/rechargecomplete?currentIndex=3'
								});
							}, 800);
						} else {
							uni.showToast({
								title: msg,
								icon: 'none'
							});
						}
					});
				}, 400);
			},
			_formatNumber(num) {
				return this.util.formatNumber(num);
			}
		},
		onShow() {
			this.coin = this.util.userInfo().coin;
			this.placeholder = '可转出' + this.coin + '个';
		}
	};
</script>

<style>
	@import url('cointransfers.css');
	@import url('../../mine/minepage.css');
</style>
