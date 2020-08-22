<template>
	<view>
		<!-- 背景 -->
		<background :otherPage="otherPage" :backgroundShare="shareAction" :backgroundMore="menuAction"></background>
		<view class="list-content">
			<!-- 账号信息 -->
			<account :otherPage="otherPage"></account>
			<!-- tab -->
			<view :class="tabSticky == true ? 'tab-bar-mask tab-bar-mask-sticky' : 'tab-bar-mask'">
				<!-- top-bar -->
				<view class="top-bar" v-if="tabSticky == true">
					<image src="/static/images/icon_me_more@3x.png" mode="" class="top-bar-icon" @click="menuAction"></image>
					<image src="/static/images/icon_me_share_grey@3x.png" mode="" class="top-bar-icon" @click="shareAction"></image>
					<view class="top-bar-row">
						<image src="" mode="" class="top-bar-avatar"></image>
						<view class="top-bar-name">
							是凉白开鸭
						</view>
					</view>
				</view>
				<!-- tab bar -->
				<view class="tab-bar">
					<view v-for="(item, index) in tabs" :key="index" :class="tabIndex == index ? 'tab-bar-title tab-bar-title-select' : 'tab-bar-title'"
					 :data-index="index" @click="tabSelectAction">
						{{item}}
						<!-- indicator -->
						<view class="tab-bar-indicator-mask">
							<view class="tab-bar-indicator" :style="tabIndex == index ? 'background-color: rgba(235, 102, 91, 1);' : ''"></view>
						</view>
					</view>
				</view>
			</view>
			<view v-if="otherPage == true">
				<!-- 动态 -->
				<dynamic :otherPage="otherPage" v-if="tabIndex == 0"></dynamic>
				<!-- 喜欢 -->
				<favorite :otherPage="otherPage" v-if="tabIndex == 1"></favorite>
			</view>
			<view v-else>
				<!-- 动态 -->
				<dynamic :otherPage="otherPage" v-if="tabIndex == 0"></dynamic>
				<!-- 收藏 -->
				<collection :otherPage="otherPage" v-if="tabIndex == 1"></collection>
				<!-- 喜欢 -->
				<favorite :otherPage="otherPage" v-if="tabIndex == 2"></favorite>
			</view>
		</view>
		<!-- 分享 -->
		<share :visible="sharevisible" :closeAction="shareAction" :itemTapAction="shareItemAction"></share>
		<!-- 菜单 -->
		<minemenu :visible="menuvisible" :closeAction="menuAction" :itemTapAction="menuItemAction"></minemenu>
	</view>
</template>

<script>
	import background from "./mine_page_background.vue"
	import account from "./mine_page_account.vue"
	import dynamic from "./dynamic/mine_page_dynamic.vue"
	import favorite from "./favorite/mine_page_favorite.vue"
	import collection from "./collection/mine_page_collection.vue"
	import share from "../components/social_share.vue"
	import minemenu from "../components/mine_menu.vue"

	export default {
		data() {
			return {
				otherPage: false, // 别人主页
				tabSticky: false,
				tabs: [
					"动态",
					"收藏",
					"喜欢",
				],
				tabIndex: 0,
				tabTop: 0,
				sharevisible: false, //分享
				menuvisible: false, //分享
			}
		},
		methods: {
			//tab
			tabSelectAction(res) {
				var index = res.currentTarget.dataset.index
				this.tabIndex = index
			},
			// 分享
			shareAction() {
				this.sharevisible = !this.sharevisible
			},
			// 分享点击
			shareItemAction(res) {
				console.log(res)
				if (res == "report") {
					var me = this
					setTimeout(function() {
						me.reportAction()
					}, 200)
				}
			},
			// 菜单
			menuAction() {
				this.menuvisible = !this.menuvisible
			},
			// 菜单点击
			menuItemAction(res) {
				console.log(res)
			},
		},
		components: {
			background,
			account,
			dynamic,
			collection,
			favorite,
			share,
			minemenu
		},
		onLoad(res) {
			if (res.otherPage != null) {
				this.otherPage = true
				this.tabs = [
					"动态",
					"喜欢",
				]
			}

			this.tabSticky = false
		},
		onPageScroll(res) {
			this.scrollTop = res.scrollTop
			if (this.tabTop - res.scrollTop <= 40 + uni.getSystemInfoSync().statusBarHeight) {
				this.tabSticky = true
			} else {
				this.tabSticky = false
			}
		},
		onReady() {
			var me = this
			let selector = uni.createSelectorQuery().select('.tab-bar');
			selector.boundingClientRect(function(data) {
				me.tabTop = data.top
				if (me.tabTop < 0) {
					me.tabTop = -(me.tabTop)
				}
			}).exec(function() {

			})
		}
	}
</script>

<style>
	@import url("mine_page.css");
</style>
