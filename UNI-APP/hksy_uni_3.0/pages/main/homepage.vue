<template>
	<view class="main-body" style="position: relative;">
		<view class="main-body-sub" style="margin-top: 0rpx;" v-if="bannerList.length > 0">
			<homeheader :notices="noticeList" :bannerList="bannerList" v-if="noticeList.length > 0"></homeheader>
			<homeassets :performance="assets.performancedata" v-if="assets != null"></homeassets>
			<homerecommend :hotProducts="hotProducts"></homerecommend>
			<homestorage v-if="hotProducts != null"></homestorage>
		</view>

		<!-- #ifndef H5 -->
		<uni-popup ref="versionpopalert" type="center" :maskClick="false" v-if="vsersion">
			<versionalert :versionInfo="vsersion" :closeHandle="closeVersionAlert"></versionalert>
		</uni-popup>
		<!-- #endif -->
	</view>
</template>

<script>
	import homeheader from "./views/homeheader.vue"
	import homeassets from "./views/homeassets.vue"
	import homerecommend from "./views/homerecommend.vue"
	import homestorage from "./views/homestorage.vue"
	import api from "./api/mainapi.js"
	import accountapi from "../account/api/accountapi.js"
	import uniPopup from "../../components/uni-popup/uni-popup.vue"
	import versionalert from "./views/versionpopalert.vue"
	export default {
		data() {
			return {
				bannerList: [],
				noticeList: [],
				assets: null,
				hotProducts: null,
				vsersion: null
			}
		},
		components: {
			homeheader,
			homeassets,
			homerecommend,
			homestorage,
			uniPopup,
			versionalert
		},
		methods: {
			refreshData() {
				if (this.util.emptyObject(this.util.userID()) == false) {
					this.refreshUserInfo()
					this.requestBanners(() => {
						this.requestNotice(() => {
							this.requestAssets(() => {
								this.requestUpdate(() => {
									uni.stopPullDownRefresh()
								})
							})
						})
					})
				}
			},
			requestBanners(completion) {
				// 获取轮播图 
				api.getBanners((data, msg) => {
					if (data != null) {
						this.bannerList = data
					}

					completion()
				})
			},
			requestNotice(completion) {
				//公告
				let me = this;
				api.getNotice((data, msg) => {
					if (data != null) {
						this.noticeList = data;
					}
					completion()
				})
			},
			requestAssets(completion) {
				//资产、产品
				api.getMyAssetsDetail(this.util.userID(), (data, msg) => {
					if (data != null) {
						this.assets = data
						this.hotProducts = this.assets.pList.slice(0, 2)
					}
					completion()
				})
			},
			requestUpdate(completion) {

				let platform = uni.getSystemInfoSync().platform
				console.log("platform:" + platform)
				if (platform == 'android') {
					let me = this
					api.getAppVersion((data, msg) => {
						if (data != null) {
							// this.vsersion = data
							// setTimeout(() => {
							// 	this.$refs.versionpopalert.open()
							// }, 100)
							// #ifndef H5
							console.log("版本信息:" + JSON.stringify(data))
							this.vsersion = data

							let serverAppVerson = data.android_version
							let localAppVerson = me.util.currentAppVersion() // build.gradle的版本号  用于测试版显示用的
							// let appVersion = plus.runtime.version // build.gradle的版本号
							// console.log("serverAppVersion " + serverAppVerson + " localAppVerson " + localAppVerson + " app " + appVersion)
							// localAppVerson = this.networking.currentVersion
							
							console.log("serverAppVersion " + serverAppVerson + " localAppVerson " + localAppVerson)

							let isUpdate = me.util.getIntVersionName2(serverAppVerson, localAppVerson)
							// console.log("-----");
							console.log(isUpdate);

							// isUpdate = false;
							// 版本要更新
							if (isUpdate) {
								// console.log("1111111111");
								this.util.recordAppVersionInfo(this.vsersion)
								setTimeout(() => {
									this.$refs.versionpopalert.open()
								}, 100)

							} else {
								this.util.recordAppVersionInfo(null) // 这行代码是点击其它tabs，判断弹出更新对话框
							}

							// #endif 
						}
						completion()
					})
				} else { 
					completion()
				}
			},
			refreshUserInfo() {
				if (this.util.emptyObject(this.util.userID()) == false) {
					var me = this
					accountapi.getUserInfo(this.util.userID(), (data, msg) => {
						if (data != null) {
							me.util.recordUserInfo(data)
							console.log("更新用户信息")
						}
					})
				}
			},
			closeVersionAlert() { // 更新dialog关闭回调
				console.log("关闭更新dialog");
				this.$refs.versionpopalert.close()
			}
		},
		onPullDownRefresh() {
			this.refreshData()
		},
		created() {
			setTimeout(() => {
				uni.startPullDownRefresh({

				})
			})

			uni.$on(this.kAccountRefresh, () => {
				if (this.util.emptyObject(this.util.userID()) == false) {
					this.refreshUserInfo()
					this.requestAssets(() => {

					})
				}
			})
		}
	}
</script>

<style>
	@import url("homepage.css");
</style>
