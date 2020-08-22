<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="usdt-recharge-type-wapper">
				<view class="usdt-recharge-type-tip">当前币种</view>
				<view class="usdt-recharge-type">金币</view>
			</view> 
			<view class="usdt-recharge-wapper">
				<image :src="qrcodePath" class="usdt-recharge-qrcode-image"></image>
				<!-- <image src="/static/images/interflow@3x.png" class="usdt-recharge-qrcode-image"></image> -->
				<view class="usdt-recharge-qrcode-save" @tap="saveQrcodeImage">保存二维码</view>
				
				<!-- #ifdef APP-PLUS -->
				<view class="usdt-recharge-linkcopy-wapper">
					<view class="usdt-recharge-link">{{ usdtAddress }}</view>
					<view class="usdt-recharge-link-copy" @tap="copyLinkAddress">复制链接</view>
				</view>
				<!-- #endif -->
				<!-- #ifdef H5 -->
				<view class="usdt-recharge-linkcopy-wapper">
					<view class="usdt-recharge-link">{{ usdtAddress }}</view>
					<view class="usdt-recharge-link-copy" v-clipboard:copy="usdtAddress" 
					@tap="copyLinkAddress" 
					v-clipboard:success="(type) => onCopyResult('success')"
					v-clipboard:error="(type) => onCopyResult('error')">复制链接</view>
				</view>
				<!-- #endif -->
			</view>
			<view class="usdt-recharge-tip-wapper">
				<view class="usdt-recharge-tip" v-for="(tip, index) in tipItems" :key="index">{{ tip }}</view>
			</view>
		</view>
	</view>
</template>

<script>
	
export default {
	data() {
		return {
			qrcodePath: this.networking.kQrcodeURL + "/" + this.util.userInfo().usdtImgpath,
			usdtAddress: this.util.userInfo().usdtAddr,
			tipItems: [
				'注意',
				'1、请勿向上述地址充值任何非USDT资产，否则资产将不可找回。',
				'2、请注意此地址为BTC链上的USDT。',
				'3、1到6次网络确认可到账，到账后自动转换为金币。',
				'4、最小充值金额100USDT，小于最小金额的充值将不会上账且无法退回。'
			]
		};
	},
	methods: {
		onCopyResult(res) { 
			if (res = 'success') {
				uni.showToast({
					title: '复制成功',
					icon: 'none'
				})
			} else {
				uni.showToast({
					title: '复制失败',
					icon: 'none'
				})
			}
		},
		copyLinkAddress() {
			// #ifdef APP-PLUS
				uni.setClipboardData({
					data: this.usdtAddress,
					success: res => {
						uni.showToast({
							title: '复制成功',
							icon: 'none'
						});
					},
					fail(error) {
						uni.showToast({
							title: error.msg,
							icon: 'none'
						});
					}
				});
			// #endif
			
		},
		saveQrcodeImage() {
			uni.showLoading({});

			uni.getImageInfo({
				src: this.qrcodePath,
				success: res => {
					uni.saveImageToPhotosAlbum({
						filePath: res.path,
						success: saveRes => {
							uni.hideLoading();
							uni.showToast({
								title: '二维码图片保存成功',
								icon: 'none'
							});
						},
						fail(error) {
							uni.hideLoading();
							uni.showToast({
								title: '图片保存失败',
								icon: 'none'
							});
						}
					});
				},
				fail(error) {
					uni.hideLoading();
					uni.showToast({
						title: '获取图片信息失败',
						icon: 'none'
					});
				}
			});
		}
	},
	onLoad() {
		this.qrcodePath = this.networking.kQrcodeURL + "/" + this.util.userInfo().usdtImgpath;
		this.usdtAddress = this.util.userInfo().usdtAddr; 
	}
};
</script>

<style>
@import url('usdtrecharge.css');
</style>
