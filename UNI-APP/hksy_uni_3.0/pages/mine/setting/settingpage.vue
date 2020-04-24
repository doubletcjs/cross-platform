<template>
	<view class="main-body">
		<view class="main-body-sub" style="margin-top: 0rpx;">
			<view class="mine-page-cell-section-wapper">
				<view class="mine-page-cell-wapper" v-for="(item, index) in settings" :key="index" style="height: 123rpx;" :style="bottomLine(index, settings)"
				 :data-index="index" @tap="functionItemAction">
					<view class="mine-page-cell-only-text">
						{{item}}
					</view>
					<view class="mine-page-cell-accessory-wapper">
						<image src="../../../static/images/right_arrow@3x.png" class="mine-page-cell-arrow"></image>
					</view>
				</view>
			</view>
			<view class="mine-page-cell-section-wapper">
				<view class="mine-page-cell-wapper" style="height: 123rpx;" :data-index="2" @tap="functionItemAction">
					<view class="mine-page-cell-only-text">
						关于我们
					</view>
					<view class="mine-page-cell-accessory-wapper">
						<image src="../../../static/images/right_arrow@3x.png" class="mine-page-cell-arrow"></image>
					</view>
				</view>
			</view>
			<view class="mine-page-cell-section-wapper" style="margin-top: 71rpx;">
				<view class="mine-page-cell-wapper" style="height: 98rpx; justify-content: center;" @tap="logoutAction">
					<view class="mine-page-cell-only-text" style="text-align: center; color: rgba(145, 152, 173, 1);">
						退出登录
					</view>
				</view>
			</view>

			<uni-popup ref="logoutalert" type="center">
				<alertview title="注销登录" content="你确认注销当前账号？" confirmTitle="确认" isCertification="true" :cancelAction="closeLogoutPopup"
				 :confirmAction="handleLogout"></alertview>
			</uni-popup>
		</view>
	</view>
</template>

<script>
	import uniPopup from "../../../components/uni-popup/uni-popup.vue"
	import alertview from "../../../components/hksy-uni-alertview/hksy-uni-alertview.vue"

	export default {
		data() {
			return {
				settings: ["密码设置", "注册协议"],
				didSetPaycode: false
			}
		},
		components: {
			uniPopup,
			alertview
		},
		methods: {
			closeLogoutPopup() {
				this.$refs.logoutalert.close()
			},
			logoutAction() {
				this.$refs.logoutalert.open()
			},
			handleLogout() {
				this.closeLogoutPopup()
				setTimeout(() => {
					uni.showLoading({

					})

					var me = this
					setTimeout(function() {
						me.util.logout()
						uni.hideLoading()
					}, 800)
				}, 600)
			},
			bottomLine(index, list) {
				if (index == list.length - 1) {
					return ""
				} else {
					return "border-bottom: solid 2rpx rgba(21, 25, 54, 1); "
				}
			},
			functionItemAction(res) {
				var index = res.currentTarget.dataset.index
				if (index == 1) {
					uni.navigateTo({
						url: "../../account/agreement/agreement"
					})
				} else if (index == 0) {
					if (this.didSetPaycode == true) {
						uni.navigateTo({
							url: "../../account/paycodefunction/paycodefunction"
						})
					} else {
						if (this.util.userInfo().paymentCode == undefined || this.util.userInfo().paymentCode.length == 0) {
							uni.navigateTo({
								url: "../../account/paycodefunction/paycodefunction"
							})
 
							uni.$once(this.kAccountRefresh, () => {
								this.didSetPaycode = true
							})
						} else {
							uni.navigateTo({
								url: "../../account/paycodefunction/paycodefunction?isResest=" + true
							})
						}
					}
				} else if (index == 2) {
					uni.navigateTo({
						url: "../aboutus/aboutus"
					})
				}
			}
		} 
	}
</script>

<style>
	@import url("../minepage.css");
</style>
