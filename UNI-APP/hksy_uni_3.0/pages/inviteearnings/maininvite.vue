<template>
	<view class="main-body">
		<view class="main-body-sub" style="padding-bottom: 0;">
			<view class="main-invite-content-image-wapper">
				<view class="main-invite-link-wapper">
					<view class="main-invite-link-tip-wapper">
						<view class="main-invite-link-tip">邀请链接：</view>
						<view class="main-invite-link">{{ inviteLink }}</view>
					</view>

					<!-- #ifdef APP-PLUS -->
					<view class="main-invite-copy" @tap="copyLinkAddress">复制链接</view>
					<!-- #endif  -->
					<!-- #ifdef H5 -->
					<view
						class="main-invite-copy"
						v-clipboard:copy="this.util.appDownload()"
						v-clipboard:success="type => onCopyResult('success')"
						v-clipboard:error="type => onCopyResult('error')"
					>
						复制链接
					</view>
					<!-- #endif  -->
				</view>
			</view>

			<view class="main-invite-wapper">
				<view :class="qrcodeClass">
					<!-- #ifdef APP-PLUS -->

					<!-- <image :src="codePath" class="main-invite-qrcode"></image> -->
					<!--
						val  要生成的内容
						onval  监听val值变化自动重新生成二维码
						usingComponents 是否使用了自定义组件模式（主要是为了修复非自定义组件模式时 v-if 无法生成二维码的问题）
						loadMake	Boolean 组件初始化完成后自动生成二维码，val需要有值
						@result  
					-->
					<view class="">
						<tki-qrcode
							class="main-invite-qrcode"
							ref="qrcode"
							cid="1"
							:val="tkiQrcodeurl"
							:size="size"
							:onval="usingComponents"
							:usingComponents="usingComponents"
							:loadMake="usingComponents"
							:showLoading="!usingComponents"
							@result="qrR"
						/>
					</view>
					<!-- <image class="main-invite-qrcode" :src="qrcodeSrc" /> -->
					<!-- <canvas canvas-id="qrcode" :style="{width: `${size}px`, height: `${size}px`}" /> -->
					<view class="main-invite-qrcode-tip" @tap="saveQrcodeImage">保存二维码</view>
					<!-- #endif  -->

					<!-- #ifdef H5 -->
					<view class="main-invite-qrcode" style="margin-left: 80rpx; margin-right: 80rpx;">
						<vue-qr style="width: 100%; height: 100%;" :logoSrc="logoSrc" :text="this.tkiQrcodeurl" ref="qrcode_id" :size="size" :margin="20" qid="qrcode"></vue-qr>
					</view>
					<!-- <image :src="codePath" class="main-invite-qrcode"></image> -->
					<view class="main-invite-qrcode-tip">长按二维码保存</view>
					<!-- #endif  -->
				</view>
				<view class="main-invite-code-wapper">
					<view class="main-invite-code-tip">您的专属邀请码:</view>
					<view class="main-invite-code">{{ account.code }}</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
import { Base64 } from 'js-base64';
import tkiQrcode from '../../components/tki-qrcode/tki-qrcode.vue'; // app使用二维码
// import uQRCode from '../../components/uqrcode/uqrcode.js'; // app使用二维码

// #ifdef H5
import VueQr from '@/components/vue_qr/src/packages/vue-qr.vue'; // h5使用二维码生成  // https://github.com/Binaryify/vue-qr
// #endif

// console.log(898989);
export default {
	components: {
		tkiQrcode,
		// #ifdef H5
		VueQr
		// #endif
	},
	data() {
		return {
			tkiQrcodeurl: '', // 要生成二维码的内容
			showImg: false,
			result: '',
			size: 324,
			qrcodeCodePath: '',
			usingComponents: true,
			account: this.util.userInfo(),
			codePath: this.networking.kQrcodeURL + '/' + this.util.userInfo().codePath,
			inviteLink: this.util.appDownload(),
			isHome: false,
			qrcodeClass: 'main-invite-qrcode-wapper',
			logoSrc: '' ,// 一定要这样的，并且是空值
			
			qrcodeSrc: '',
		};
	},
	onLoad(options) {
		if (options.isHome != null) {
			this.qrcodeClass = 'main-invite-home-qrcode-wapper';
		} 
		this.tkiQrcodeurl = this.networking.kQrcodeURL + '/invite/openshare?' + 'invitation_code=' + this.account.code + '&a=' + Math.random();

	},
	methods: {
		// make() {
		// 	console.log("--1-1---");
		// 	uni.showLoading({
		// 		title: '二维码生成中',
		// 		mask: true
		// 	});
		// 	console.log("--2---");
		// 	uQRCode.make({
		// 		canvasId: 'qrcode',
		// 		text: "eee",
		// 		size: 324,
		// 		margin: 10,
		// 		fileType: 'jpg',
		// 		success: res => {
		// 			console.log("--------");
		// 			this.qrcodeSrc = res;
		// 		},
		// 		complete: () => {
		// 			uni.hideLoading();
		// 		},
		// 		fail: res => {
		// 			console.log("fail " +  res);
		// 		}
		// 	});
		// 	console.log("000000");
		// },
		qrR(e) {
			// 生成的图片base64或图片临时地址
			let str = e;
			this.result = e;
			// console.log("图片地址 " + this.result); // 一大串字符串,可能base64
		},
		onCopyResult(res) {
			console.log(res);
			if ((res = 'success')) {
				uni.showToast({
					title: '复制成功',
					icon: 'none'
				});
			} else {
				uni.showToast({
					title: '复制失败',
					icon: 'none'
				});
			}
		},
		dataURLtoBlob(dataurl) {
			var arr = dataurl.split(','),
				mime = arr[0].match(/:(.*?);/)[1],
				bstr = atob(arr[1]),
				n = bstr.length,
				u8arr = new Uint8Array(n);
			while (n--) {
				u8arr[n] = bstr.charCodeAt(n);
			}
			return new Blob([u8arr], { type: mime });
		},
		copyLinkAddress() {
			// #ifdef APP-PLUS
			uni.setClipboardData({
				data: this.util.appDownload(),
				success: res => {
					uni.showToast({
						title: '复制成功',
						icon: 'none'
					});
				},
				fail(error) {
					console.log(error);
					uni.showToast({
						title: error.msg,
						icon: 'none'
					});
				}
			});
			// #endif
		},
		dataURLtoBlobs(dataUrl) {
			const arr = dataUrl.split(',');
			const mine = arr[0].match(/:(.*?);/)[1];
			const bstr = atob(arr[1]);
			let n = bstr.length;
			const u8arr = new Uint8Array(n);

			while (n--) {
				u8arr[n] = bstr.charCodeAt(n);
			}
			return new Blob(u8arr, { type: mine });
		},
		saveQrcodeImage() {
			// #ifdef H5
			// let url = window.URL.createObjectURL(this.dataURLtoBlobs(this.result))
			// let a = document.createElement('a');
			// // a.setAttribute('href',url)
			// a.href = url;
			// a.download = url;
			// // a.setAttribute('download',url)
			// a.click()
			// a.remove()
			// window.open(url)

			// let _this = this;
			// uni.getImageInfo({
			// 	src:this.result,
			// 	success(res){
			// 		console.log(res)
			// 		let url = window.URL.createObjectURL(_this.dataURLtoBlobs(res.path))
			// 		console.log("--url " + url);
			// 		let a = document.createElement('a');
			// 		// a.setAttribute('href',url)
			// 		a.href = url;
			// 		a.download = url;
			// 		a.click()
			// 	},
			// 	fail(res){
			// 		console.log(res)
			// 	}
			// })
			// uni.showToast({
			// 	title:'请长按二维码下载保存',
			// 	icon:'none'
			// })

			var img = new Image();
			img.onload = function() {
				var canvas = document.createElement('canvas');
				canvas.width = img.width;
				canvas.height = img.height;
				var ctx = canvas.getContext('2d');
				// 将img中的内容画到画布上
				ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
				// 将画布内容转换为Blob
				canvas.toBlob(blob => {
					// blob转为同源url
					var blobUrl = window.URL.createObjectURL(blob);
					// console.log('blodUrl ' + blobUrl);
					// 创建a链接
					// blobUrl = "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1906469856,4113625838&fm=26&gp=0.jpg"
					// blobUrl = blobUrl + ".jpg"
					// blobUrl = blobUrl.replace("blob:", "") // 去掉就无法下载
					alert(blobUrl);
					var a = document.createElement('a');
					a.href = blobUrl;
					a.download = '';
					// 触发a链接点击事件，浏览器开始下载文件
					a.click();
				});
			};
			img.src = this.result;
			// 必须设置，否则canvas中的内容无法转换为blob
			img.setAttribute('crossOrigin', 'Anonymous');

			// #endif

			// #ifdef APP-PLUS
			uni.showLoading({});
			uni.getImageInfo({
				src: this.result,
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

			// #endif
		}
	},
	onShow() {
		// http://www.beefil.com/invite/openshare?invitation_code=gdlxr
		this.account = this.util.userInfo();
		this.codePath = this.networking.kQrcodeURL + '/' + this.account.codePath;
		this.inviteLink = this.util.appDownload();

		this.tkiQrcodeurl = this.networking.kQrcodeURL + '/invite/openshare?' + 'invitation_code=' + this.account.code + '&a=' + Math.random();
		// this.make()
		// console.log("show");
	},
	onReady() {
		this.tkiQrcodeurl = this.networking.kQrcodeURL + '/invite/openshare?' + 'invitation_code=' + this.account.code + '&a=' + Math.random();
	},
	onHide() {
		this.tkiQrcodeurl = '';
	},
	onUnload() {
		this.tkiQrcodeurl = '';
	},
	created() {
		var me = this;
		// console.log('this.codePath === ' + this.codePath);
		this.tkiQrcodeurl = this.networking.kQrcodeURL + '/invite/openshare?' + 'invitation_code=' + this.account.code + '&a=' + Math.random();
		console.log("------" + this.tkiQrcodeurl);
		
		uni.$on('inviterefresh_2', () => {
			me.account = me.util.userInfo();
			me.codePath = me.networking.kQrcodeURL + '/' + me.account.codePath;

			setTimeout(() => {
				uni.stopPullDownRefresh();
			}, 400);
		});
	}
};
</script>

<style>
@import url('maininvite.css');
</style>
