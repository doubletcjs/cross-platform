<template>
	<view style="background-color: rgba(21, 25, 54, 1); padding-bottom: 26rpx; width: 100%; height: 100%;">
		<mineheader :account="account"></mineheader>
		<view class="mine-page-cell-section-wapper">
			<view class="mine-page-cell-wapper" v-for="(item, index) in mineList" :key="index" :data-index="index" @tap="mineAction"
			 :style="bottomLine(index, mineList)">
				<view class="mine-page-cell-image-text-wapper">
					<image :src="mineIconList[index]" class="mine-page-cell-image"></image>
					<view class="mine-page-cell-text">
						{{item}}
					</view>
				</view>
				<view class="mine-page-cell-accessory-wapper">
					<view class="mine-page-cell-accessory-text" v-if="index == 3">
						{{_formatNumber(account.coin)}}个
					</view>
					<view class="mine-page-cell-accessory-text" v-else-if="index == 5">
						我的邀请码：{{account.code}}
					</view>
					<image src="../../static/images/right_arrow@3x.png" class="mine-page-cell-arrow"></image>
				</view>
			</view>
		</view>
		<view class="mine-page-cell-section-wapper">
			<view class="mine-page-cell-wapper" v-for="(item, index) in settingList" :key="index" :data-index="index" @tap="settingAction"
			 :style="bottomLine(index, settingList)">
				<view class="mine-page-cell-image-text-wapper">
					<image :src="settingIconList[index]" class="mine-page-cell-image"></image>
					<view class="mine-page-cell-text">
						{{item}}
					</view>
				</view>
				<view class="mine-page-cell-accessory-wapper">
					<image src="../../static/images/right_arrow@3x.png" class="mine-page-cell-arrow"></image>
				</view>
			</view>
		</view>

		<uni-popup ref="certificationalert" type="center">
			<alertview title="提示" content="  您还没有实名认证，请实名认证后进行操作" confirmTitle="实名认证" isCertification="true" :cancelAction="closePopup"
			 :confirmAction="goCertification"></alertview>
		</uni-popup>
		<uni-popup ref="feimaalert" type="center">
			<!-- <feimaalert :closeHandle="closePopup"></feimaalert> -->
			<alertview title="温馨提示" content="  期待Filecoin主网上线，Fil币钱包开发中!" showCancel="false" confirmTitle="知道了"
			 isCertification="true" :cancelAction="closePopup" :confirmAction="closePopup"></alertview>
		</uni-popup>
		<uni-popup ref="vipstoragealert" type="center">
			<alertview title="超级存储" content="* 您目前还不是超级存储 , 成为超级存储需要在 -我的钱包- 充值购买 , 购买成功后则显示每日分红收益" showCancel=false
			 :confirmAction="vipStorageAlertClose"></alertview>
		</uni-popup>

		<!-- #ifndef H5 -->
		<uni-popup ref="versionpopalert" type="center" :maskClick="false" v-if="vsersion">
			<versionalert :versionInfo="vsersion" :closeHandle="closeVersionAlert"></versionalert>
		</uni-popup>
		<!-- #endif -->
	</view>
</template>

<script>
	import mineheader from "./views/mineheader.vue"
	import accountapi from "../account/api/accountapi.js"
	import feimaalert from "./views/feimaalert.vue"
	import uniPopup from "../../components/uni-popup/uni-popup.vue"
	import alertview from "../../components/hksy-uni-alertview/hksy-uni-alertview.vue"
	import versionalert from "../main/views/versionpopalert.vue"

	export default {
		data() {
			return {
				mineList: ["我的钱包", "我的存储", "我的算力", "我的金币", "超级存储", "邀请收益"],
				mineIconList: ["../../static/images/ico_my_wallet@3x.png", "../../static/images/ico_my_storage@3x.png",
					"../../static/images/ico_my_calculation@3x.png", "../../static/images/ico_my_gold@3x.png",
					"../../static/images/ico_my_super@3x.png", "../../static/images/ico_my_invitation@3x.png"
				],
				settingList: ["联系客服", "设置中心"],
				settingIconList: ["../../static/images/ico_my_service@3x.png", "../../static/images/ico_my_setup@3x.png"],
				account: this.util.userInfo(),
				vsersion:""
			}
		},
		methods: {
			mineAction(res) {
				var index = res.currentTarget.dataset.index
				if (index == 3) { // 我的金币
					uni.navigateTo({
						url: "../coin/coinmain"
					})
				} else if (index == 1) {
					uni.navigateTo({
						url: "../storage/storagemain"
					})
				} else if (index == 4) { // 超级存储
					if (this.account.vipminerStatus == 0) {
						this.$refs.vipstoragealert.open()
					} else {
						uni.navigateTo({
							url: "../storage/storagemain?isVip=" + "true"
						})
					}
				} else if (index == 5) { // 邀请收益
					uni.navigateTo({
						url: "../inviteearnings/inviteearnings"
					})
				} else if (index == 0) {
					if (this.account.personalStatus == 1) {
						this.$refs.feimaalert.open()
					} else {
						this.$refs.certificationalert.open()
					}
				} else if (index == 2) {
					uni.navigateTo({
						url: "../hkc/hkc"
					})
				}
			},
			settingAction(res) {
				var index = res.currentTarget.dataset.index
				if (index == 0) {
					uni.navigateTo({ // 联系客服
						url: "./service/servicepage"
					})
				} else {
					uni.navigateTo({ // 设置中心
						url: "./setting/settingpage"
					})
				}
			},
			refreshUser() {
				if (this.util.emptyObject(this.util.userID()) == false) {
					var me = this
					accountapi.getUserInfo(this.util.userID(), (data, msg) => {
						me.util.recordUserInfo(data)
						me.account = data
						setTimeout(() => {
							uni.stopPullDownRefresh()
						}, 200)
					})
				}
			},
			_formatNumber(num) {
				return this.util.formatNumber(num)
			},
			bottomLine(index, list) {
				if (index == list.length - 1) {
					return ""
				} else {
					return "border-bottom: solid 1.6rpx rgba(21, 25, 54, 1);"
				}
			},
			closePopup() {
				this.$refs.certificationalert.close()
				this.$refs.feimaalert.close()
			},
			goCertification() {
				this.closePopup()

				uni.navigateTo({
					url: "../account/certification/certificationcenter"
				})
			},
			vipStorageAlertClose() {
				this.$refs.vipstoragealert.close()
			},
			closeVersionAlert() { // 更新dialog关闭回调
				console.log("关闭更新dialog");
				this.$refs.versionpopalert.close()
			}
		},
		components: {
			mineheader,
			feimaalert,
			uniPopup,
			alertview,
			versionalert
		},
		onShow() {
			this.account = this.util.userInfo()
		},
		onPullDownRefresh() {
			this.refreshUser()
		},
		created() {
			// #ifndef H5
			if (this.util.appVersionInfo() != null) {
				this.vsersion = this.util.appVersionInfo()
				setTimeout(() => {
					this.$refs.versionpopalert.open()
				}, 100)
			}
			// #endif
		}
	}
</script>

<style>
	@import url("minepage.css");
</style>
