<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="cash-recharge-wapper">
				<view class="cash-recharge-wapper-top">
					<view class="cash-recharge-tip-wapper"><view class="cash-recharge-tip-text">请按提示信息向我司付款</view></view>
					<view style="margin-top: 40rpx;">
<!-- 												<view class="cash-recharge-item-wapper" v-for="(item, index) in items" :key="index">
							<view class="cash-recharge-item-key">
								{{item}}
							</view>
							<view v-if="index < 3">
								<view class="cash-recharge-item-value">
									请联系销售人员或者相关人员
								</view>
							</view>
						</view> -->

						<view v-for="(item, index) in items" :key="index">
							<view class="cash-recharge-item-wapper">
								<view class="cash-recharge-item-key">{{ item }}</view>
								<view v-if="index < 3"><view class="cash-recharge-item-value">请联系销售人员或者相关人员</view></view>
							</view>
							<view v-if="index != 2">
								<view class="cash_recharge_input_line"/>
							</view>
						</view>
					</view>
				</view>

				<view class="cash-recharge-image-wapper">
					<view class="cash-recharge-image-wapper-title">付款完成后提交凭证</view>
					<view class="input-box">
						<text>转账金额 :</text>
						<input type="number" class="input-box-input" maxlength="22" placeholder-class="placeholder-class" v-model="coinValue" placeholder="请输入充值金额" />
					</view>
					<view class="cash_recharge_input_line" style="margin-top: 30rpx;"/>
					<view class="upload-img">上传充值凭证</view>
					<view class="upload-img-list-box">
						<view class="upload-img-list" v-for="(path, index) in selectPaths" :key="index">
							<view class="delect-img" @tap="delImg(index)">
								<image src="../../../static/images/ico_del@3x.png" mode="" style="width: 100%;height: 100%;"></image>
							</view>
							<image :src="path" class="upload-img-list-imgItem" mode="widthFix"></image>
						</view>
					</view>

					<view v-if="selectPaths.length < 9">
						<!-- <image src="/static/images/add@3x.png" mode="widthFix" @tap="selectImageAction"></image> -->
						<view class="img-box" @tap="selectImageAction">
							<view class="img-box-wrap">
								<view class="img-box-c">+</view>
								<view class="img-box-text">点击上传</view>
							</view>
						</view>
					</view>
				</view>
				<view class="cash-recharge-confirm-wapper" @tap="confirmAction">确认充值</view>
				<view class="cash-recharge-confirm-tip-wapper">
					<view class="cash-recharge-confirm-tip">温馨提示，如有任何疑问请联系在线客服</view>
					<view class="cash-recharge-confirm-tip">（请在工作日9:00-17:00之间转账）</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
import coinapi from '../api/coinapi.js';
// "上传充值凭证："
export default {
	data() {
		return {
			items: ['收款方户名：', '收款方开户行：', '收款方账号：'],
			selectPaths: [],
			coinValue: ''
		};
	},
	methods: {
		delImg(index) {
			this.selectPaths.splice(index, 1);
			// console.log(index,this.selectPaths)
		},
		selectImageAction() {
			uni.hideKeyboard();
			var me = this;
			uni.chooseImage({
				count: 9 - this.selectPaths.length,
				success: res => {
					me.selectPaths.push.apply(me.selectPaths, res.tempFilePaths);
				},
				fail: res => {
					if (res.code != '0') {
						uni.showToast({
							title: res.errMsg,
							icon: 'none'
						});
					}
				}
			});
		},
		confirmAction() {
			if (this.util.emptyObject(this.coinValue) == true || parseFloat(this.coinValue) <= 0.0) {
				uni.showToast({
					title: '请输入金额,必须大于0',
					icon: 'none'
				});
				return;
			}

			if (this.selectPaths.length < 1) {
				uni.showToast({
					title: '请上传凭证',
					icon: 'none'
				});
				return;
			}

			uni.hideKeyboard();
			this.uploadImages();
		},
		textFieldOnchanged(res) {
			var textfieldId = res.target.id;
			var textfieldText = res.target.value;

			this.coinValue = textfieldText;
		},
		uploadImages(completion) {
			uni.showLoading({});

			var me = this;
			this.networking.functionMultipleUpload(this.selectPaths, (urlList, msg) => {
				uni.hideLoading();
				if (urlList.length > 0) {
					me.confirmRecharge(urlList.toString());
				} else {
					uni.showToast({
						title: msg,
						icon: 'none'
					});
				}
			});
		},
		confirmRecharge(urls) {
			uni.showLoading({});

			var me = this;
			coinapi.offlineRecharge(this.util.userID(), urls, this.coinValue, (data, msg) => {
				uni.hideLoading();
				if (data) {
					uni.$emit(me.kcoinRefresh, null);
					setTimeout(() => {
						uni.hideLoading();
						me.emptyRechargeInfo();
						// 充值成功
						uni.redirectTo({
							url: './rechargecomplete?currentIndex=1'
						});
					}, 800);
				} else {
					uni.showToast({
						title: msg,
						icon: 'none'
					});
				}
			});
		},
		emptyRechargeInfo() {
			uni.hideKeyboard();
			this.coinValue = '';
			this.selectPaths = [];
		}
	},
	onNavigationBarButtonTap() {
		uni.navigateTo({
			url: './rechargedetail'
		});
	}
};
</script>

<style>
@import url('cashrecharge.css');
</style>
