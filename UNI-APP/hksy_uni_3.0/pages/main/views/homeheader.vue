<template>
	<view style="background-color: rgba(21, 25, 54, 1); width: 100%;">
		<swiper :indicator-dots="false" :autoplay="true" :interval="5000" :duration="1000" class="banner-wapper">
			<swiper-item v-for="(banner, index) in bannerList" :key="index">
				<image :src="banner.imagePath" mode="aspectFill" class="banner-image"></image>
			</swiper-item>
		</swiper>
		<view class="home-header-wapper">
			<view class="home-item-wapper">
				<view class="home-item-content-wapper" v-for="(item, index) in homeItems" :key="index" :data-index="index" @tap="itemSelect">
					<image :src="homeItemIcons[index]" class="home-item-content-image"></image>
					<view class="home-item-content-title">
						{{item}} 
					</view>
				</view>
			</view>
			<view class="home-notice-wapper" @tap="messageCenter">
				<image src="../../static/images/ico_home_notice@3x.png" mode="aspectFit" class="home-notice-logo-wapper"></image>
				<swiper vertical="true" :autoplay="true" :interval="6000" :duration="1000" class="home-notice-swiper-wapper">
					<swiper-item v-for="(notice, index) in notices" :key="index" class="home-notice-swiper-item">
						<view v-if="notice.dicId == 11" class="home-notice-swiper-item-title">
							<text v-html="ClearBr(notice.content)" space="emsp"></text>
						</view>
						<view v-else class="home-notice-swiper-item-title">
							恭喜{{notice.content}}的用户认购{{notice.clickNum}}T！！！
						</view>
					</swiper-item>
				</swiper>
			</view>
		</view>

		<uni-popup ref="certificationalert" type="center">
			<alertview title="提示" content="  您还没有实名认证，请实名认证后进行操作" confirmTitle="实名认证" isCertification=true :cancelAction="closePopup"
			 :confirmAction="goCertification"></alertview>
		</uni-popup>
		<uni-popup ref="feimaalert" type="center">
			<alertview title="温馨提示" content="  期待Filecoin主网上线，Fil币钱包开发中!" showCancel="false" confirmTitle="确定" isCertification=true :cancelAction="closePopup"
			 :confirmAction="closePopup"></alertview>
		</uni-popup>
	</view>
</template>

<script>
	import feimaalert from "../../mine/views/feimaalert.vue"
	import uniPopup from "../../../components/uni-popup/uni-popup.vue"
	import alertview from "../../../components/hksy-uni-alertview/hksy-uni-alertview.vue"
	
	export default {
		data() {
			return {
				homeItems: ["邀请", "钱包", "算力", "金币"],
				homeItemIcons: ["../../static/images/ico_home_invitation@3x.png", "../../static/images/ico_home_wallet@3x.png",
					"../../static/images/ico_home_calculation@3x.png", "../../static/images/ico_home_gold@3x.png"
				]
			}
		},
		components: {
			feimaalert,
			uniPopup,
			alertview
		},
		methods: {
			itemSelect(res) {
				var index = res.currentTarget.dataset.index
				if (index == 0) {
					uni.navigateTo({
						url: "../../pages/inviteearnings/maininvite?isHome="+true
					})
				} else if (index == 2) {
					uni.navigateTo({
						url: "../../pages/hkc/hkc"
					})
				} else if (index == 3) {
					uni.navigateTo({
						url: "../../pages/coin/coinmain"
					}) 
				} else if (index == 1) {
					if (this.util.userInfo().personalStatus == 1) {
						this.$refs.feimaalert.open()
					} else {
						this.$refs.certificationalert.open()
					}
				}
			},
			messageCenter() {
				uni.navigateTo({
					url: "../message/message"
				}) 
			},
			closePopup() {
				this.$refs.certificationalert.close()
				this.$refs.feimaalert.close()
			},
			ClearBr(key) {
				key = key.replace(/<\/?.+?>/g,""); 
				key = key.replace(/[\r\n]/g, ""); 
				return key; 
			},
			goCertification() {
				this.closePopup()
				uni.navigateTo({
					url: "../account/certification/certificationcenter"
				})
			}
		},
		props: {
			notices: null,
			bannerList: null
		}
	}
</script>

<style>
	@import url("homeheader.css");
</style>
