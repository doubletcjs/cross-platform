<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="wallet-transfers-tip-wapper">
				<view class="wallet-transfers-tip">可转FIL币数量</view>
				<view class="wallet-transfers-tip">3425个</view>
			</view>
			<view class="wallet-cell-section-wapper">
				<view class="wallet-transfers-item-tip">转出数量</view>
				<view class="wallet-transfers-input-wapper" style="border-bottom: solid 1.6rpx rgba(145, 152, 173, 0.2);">
					<input type="digit" id="balance" :value="balanceValue" @input="textFieldOnchanged" :placeholder="placeholder"
					 placeholder-class="wallet-transfers-input-placeholder" class="wallet-transfers-input" style="width: 80%;" />
					<view class="wallet-transfers-rollout" @tap="rolloutAll">全部转出</view>
				</view>
				<view class="wallet-transfers-item-tip" style="font-size: 30rpx;">Filecoin钱包地址</view>
				<view class="wallet-transfers-input-wapper" style="border-bottom: solid 1.6rpx rgba(145, 152, 173, 0.2);">
					<input type="digit" id="address" :value="addressValue" @input="textFieldOnchanged" placeholder="请输入您Filecoin钱包地址"
					 placeholder-class="wallet-transfers-input-placeholder" class="wallet-transfers-input" style="width: 100%;" />
				</view>
			</view>
			<view class="wallet-transfers-confirm" @tap="confirmTransfers">确认转出</view>
			<view class="wallet-transfers-info">
				温馨提示，如有任何疑问请联系在线客服（请在工作日9:00-17:00之间转账）
			</view>
		</view>
		<!-- 请输入支付密码popup -->
		<uni-popup type="bottom" ref="paycodepopup">
			<paycodeinput :colseAction="closePaycodepopup" :completeAction="completePaycode"></paycodeinput>
		</uni-popup>
	</view>
</template>

<script>
	import uniPopup from '../../components/uni-popup/uni-popup.vue';
	import paycodeinput from '../account/paycodefunction/paycodeinput.vue';
	export default {
		data() {
			return {
				coin: '',
				balanceValue: '',
				accountValue: '',
				placeholder: '',
				addressValue: ''
			}
		},
		methods: {
			textFieldOnchanged(res) {
				var textfieldId = res.target.id;
				var textfieldText = res.target.value;

				if (textfieldId == 'balance') {
					this.balanceValue = textfieldText;
				} else if (textfieldId == 'address') {
					this.addressValue = textfieldText;
				}
			},
			rolloutAll() {
				uni.hideKeyboard();
				this.balanceValue = this.util.userInfo().coin;
			},
			confirmTransfers() {

			},
			closePaycodepopup() {
				this.$refs.paycodepopup.close();
			},
			completePaycode(val) {
				/*
				if (data) {
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
				*/
			},
			_formatNumber(num) {
				return this.util.formatNumber(num);
			}
		},
		onShow() {
			this.coin = this.util.userInfo().coin;
			this.placeholder = '可转出FIL币数量' + this.coin + '个';
		},
		components: {
			uniPopup,
			paycodeinput
		}
	}
</script>

<style>
	@import url("walletrollout.css");
</style>
