<template>
	<view class="main-body">
		<view class="main-body-sub" style="padding-bottom: 0;">
			<view class="main-invite-content-image-wapper">
				<view class="main-invite-link-wapper">
					<view class="main-invite-link-tip-wapper">
						<view class="main-invite-link-tip">
							邀请链接：
						</view>
						<view class="main-invite-link">
							{{inviteLink}}
						</view>
					</view>
					<view class="main-invite-copy" @tap="copyLinkAddress" v-clipboard:copy="this.util.appDownload()"
					 v-clipboard:success="(type) => onCopyResult('success')" v-clipboard:error="(type) => onCopyResult('error')">
						复制链接
					</view>
				</view>
			</view>
			
			<view class="main-invite-wapper">
				<view :class="qrcodeClass">
					<!-- <image :src="codePath" class="main-invite-qrcode"></image> -->
					<view>
						
					</view>
					<tki-qrcode class="main-invite-qrcode" v-if="!result"
					    ref="qrcode"
					    cid="1"
					    :val="tkiQrcodeurl"
					    :size="size"
							:onval="usingComponents"
					    :usingComponents="usingComponents"
							:loadMake="usingComponents"
					    :showLoading="!usingComponents"
					    @result="qrR" />
					<view class="main-invite-qrcode-tip" @tap="saveQrcodeImage">
						保存二维码
					</view>
				</view>
				<view class="main-invite-code-wapper">
					<view class="main-invite-code-tip">
						您的专属邀请码:
					</view>
					<view class="main-invite-code">
						{{account.code}}
					</view>
					
				</view>
			</view>
		</view>
	</view>
</template>

<script>

	import tkiQrcode from "../../components/tki-qrcode/tki-qrcode.vue"
	
	console.log(898989)
	export default {
		components:{
			tkiQrcode
		},
		data() {
			return {
				showImg:false,
				result:'',
				size:324,
				qrcodeCodePath:'',
				usingComponents:true,
				account: this.util.userInfo(),
				codePath: this.networking.kQrcodeURL + "/" + this.util.userInfo().codePath,
				inviteLink: this.util.appDownload(),
				isHome: false,
				qrcodeClass: "main-invite-qrcode-wapper"
			}
		},
		onLoad(options) {
			if (options.isHome != null) {
				this.qrcodeClass = "main-invite-home-qrcode-wapper"
			}
			this.tkiQrcodeurl = this.networking.kQrcodeURL + '/invite/login.html?' + 'invitation_code='+this.account.code + '&a='+ Math.random();
			// // this.tkiQrcodeurl = 'http://www.beefil.com/invite/login.html'
			// console.log(this.tkiQrcodeurl)
			// console.log(this.networking.kQrcodeURL,this.util.userInfo().codePath,9999)
		},
		methods: {
			qrR(e){
				// this.tkiQrcodeurl = e;
				// let _this = this;
				let str = e;
				console.log(e,'二维码生成了')
				// this.result = e;
				uni.setStorage({
					key:'qrImg',
					data:str,
					success() {
						console.log('保存二维码成功了')
						
					}
				})
			},
			onCopyResult(res) {
				console.log(res)
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
					data: this.util.appDownload(),
					success: (res) => {
						uni.showToast({
							title: "复制成功",
							icon: "none"
						})
					},
					fail(error) {
						console.log(error)
						uni.showToast({
							title: error.msg,
							icon: "none"
						})
					}
				})
				// #endif
			},
			saveQrcodeImage() {
				uni.showLoading({

				})

				uni.getImageInfo({
					src: this.codePath,
					success: (res) => {
						uni.saveImageToPhotosAlbum({
							filePath: res.path,
							success: (saveRes) => {
								uni.hideLoading()
								uni.showToast({
									title: "二维码图片保存成功",
									icon: "none"
								})
							},
							fail(error) {
								uni.hideLoading()
								uni.showToast({
									title: "图片保存失败",
									icon: "none"
								})
							}
						})
					},
					fail(error) {
						uni.hideLoading()
						uni.showToast({
							title: "获取图片信息失败",
							icon: "none"
						})
					}
				})
			}
		},
		onShow() {
			// http://www.beefil.com/invite/login.html?invitation_code=gdlxr
			this.account = this.util.userInfo()
			this.codePath = this.networking.kQrcodeURL + "/" + this.account.codePath
			this.inviteLink = this.util.appDownload();
			
			this.tkiQrcodeurl = this.networking.kQrcodeURL + '/invite/login.html?' + 'invitation_code='+this.account.code + '&a='+ Math.random()
			// this.tkiQrcodeurl = 'http://www.beefil.com/invite/login.html'
			console.log("ohshow" + this.tkiQrcodeurl)
			
		},
		onReady() {
			this.tkiQrcodeurl = this.networking.kQrcodeURL + '/invite/login.html?' + 'invitation_code='+this.account.code + '&a='+ Math.random()
		},
		onHide() {
			this.tkiQrcodeurl = '';
		},
		onUnload(){
			this.tkiQrcodeurl = '';
		},
		created() {
			var me = this
			console.log("this.codePath === " + this.codePath);
			this.tkiQrcodeurl = this.networking.kQrcodeURL + '/invite/login.html?' + 'invitation_code='+this.account.code + '&a='+ Math.random();
			
			uni.$on("inviterefresh_2", () => {
				me.account = me.util.userInfo()
				me.codePath = me.networking.kQrcodeURL + "/" + me.account.codePath

				setTimeout(() => {
					uni.stopPullDownRefresh()
				}, 400)
			})
		}
	}
</script>

<style>
	@import url("maininvite.css");
</style>
