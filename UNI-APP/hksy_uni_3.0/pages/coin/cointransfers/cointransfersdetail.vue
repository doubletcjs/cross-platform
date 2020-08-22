<template>
	<view>
		<view class="main-body">
			<view class="main-body-sub">
				<view class="usdt-recharge-type-wapper">
					<view class="usdt-recharge-type-tip">可转出金币</view>
					<view class="usdt-recharge-type">{{ _formatNumber(coin) }}个</view>
				</view>
				<view class="ctd-card-tip-wapper">
					<view class="ctd-card-tip-title">转出金币数量</view>
					<view class="ctd-card-input-wapper">
						<input
							type="number"
							placeholder="请输入转出金币数量"
							:value="balanceValue"
							placeholder-class="ctd-card-input-placeholder-text"
							class="ctd-card-input-text"
							@input="textFieldOnchanged"
						/>
						<view class="ctd-card-all-text" @tap="rolloutAll">全部转出</view>
					</view>
				</view>
				<view class="ctd-buttom" @tap="showTransfersPopup">确认转出</view>
			</view>
		</view>
		<uni-popup ref="confirmalert" type="center">
			<alertview
				:title="title"
				:content="'转出金币：' + balanceValue + '个'"
				confirmTitle="确认"
				isTtransfers="true"
				:cancelAction="closeTransfersPopup"
				:confirmAction="confirmTransfers"
			></alertview>
		</uni-popup>
	</view>
</template>

<script>
import uniPopup from '../../../components/uni-popup/uni-popup.vue';
import alertview from '../../../components/hksy-uni-alertview/hksy-uni-alertview.vue';
import coinapi from '../api/coinapi.js';

export default {
	data() {
		return {
			title: '确定要转出到金币账户吗?',
			isVip: false, // true 超级存储的转出  false 邀请收益的转出
			coin: '', // 全部转出金币数量
			balanceValue: '' // 用户输入的转出金币数
		};
	},
	components: {
		uniPopup,
		alertview
	},
	methods: {
		textFieldOnchanged(res) {
			var textfieldText = res.target.value;
			this.balanceValue = textfieldText;
		},
		_formatNumber(num) {
			return this.util.formatNumber(num);
		},
		rolloutAll() {
			// 全部转出
			uni.hideKeyboard();
			this.balanceValue = this.coin;
		},
		showTransfersPopup() {
			// 打开转出确认popup
			var msg = '';
			if (this.util.emptyObject(this.balanceValue) == true) {
				msg = '请输入转出金额';
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
			}
		},
		closeTransfersPopup() {
			this.$refs.confirmalert.close();
		},
		confirmTransfers() {
			var me = this;
			if (me.isVip) {
				me.completeVip(me.balanceValue); // 超级存储的互转
			} else {
				me.completeInvitation(me.balanceValue); // 邀请收益的互转
			}
		},
		completeInvitation(val) {
			var me = this;
			setTimeout(() => {
				this.closeTransfersPopup()
				uni.showLoading({});
				coinapi.giftCoinTransfer(me.util.userID(), me.balanceValue, (data, msg) => {
					uni.hideLoading();
					if (data) {
						uni.showToast({
							title: '划转成功!',
							icon: 'none'
						});

						uni.hideKeyboard();
						uni.$emit('inviterefresh_0');
						setTimeout(() => {
							uni.navigateBack({
								delta: 1
							});
						}, 1000);
					} else {
						uni.showToast({
							title: msg,
							icon: 'none'
						});
					}
				});
			}, 400);
		},
		completeVip(val) {
			// 超级存储互转
			var me = this;
			setTimeout(() => {
				uni.showLoading({});
				coinapi.vipgiftCoinTransfer(me.util.userID(), me.balanceValue, (data, msg) => {
					this.closeTransfersPopup()
					uni.hideLoading();
					if (data) {
						uni.showToast({
							title: '划转成功!',
							icon: 'none'
						});

						uni.hideKeyboard();
						uni.$emit('vip_strogae_refresh');
						setTimeout(() => {
							uni.navigateBack({
								delta: 1
							});
						}, 1000);
					} else {
						uni.showToast({
							title: msg,
							icon: 'none'
						});
					}
				});
			}, 400);
		}
	},

	created() {},
	onShow() {
		// this.coin = this.util.userInfo().coin;
	},
	onLoad(params) {
		if (params != null && params['isVip'] == 'true') {
			this.isVip = true;
		} else {
			this.isVip = false;
		}
		this.coin = params['rolloutValue'];
		// console.log('isVip ' + this.isVip + " rolloutValue " + this.coin);
	}
};
</script>

<style>
@import url('cointransfersdetail.css');
</style>
