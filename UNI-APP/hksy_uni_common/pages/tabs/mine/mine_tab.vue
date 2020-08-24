<template>
	<view>
		<!-- 背景 -->
		<background :otherPage="false" :backgroundShare="shareAction" :backgroundMore="menuAction" :backgroundSwitch="backgroundSwitch"></background>
		<view class="list-content">
			<!-- 账号信息 -->
			<account :otherPage="false"></account>
			<!-- tab -->
			<view :class="tabSticky == true ? 'tab-bar-mask tab-bar-mask-sticky' : 'tab-bar-mask'">
				<!-- top-bar -->
				<view class="top-bar" v-if="tabSticky == true">
					<image src="/static/images/icon_me_more@3x.png" mode="" class="top-bar-icon" @click="menuAction"></image>
					<image src="/static/images/icon_me_share_grey@3x.png" mode="" class="top-bar-icon" @click="shareAction"></image>
					<view class="top-bar-row">
						<image src="" mode="" class="top-bar-avatar"></image>
						<view class="top-bar-name">是凉白开鸭</view>
					</view>
				</view>
				<!-- tab bar -->
				<view class="tab-bar">
					<view v-for="(item, index) in tabs" :key="index" :class="tabIndex == index ? 'tab-bar-title tab-bar-title-select' : 'tab-bar-title'"
					 :data-index="index" @click="tabSelectAction">
						{{ item }}
						<!-- indicator -->
						<view class="tab-bar-indicator-mask">
							<view class="tab-bar-indicator" :style="tabIndex == index ? 'background-color: rgba(235, 102, 91, 1);' : ''"></view>
						</view>
					</view>
				</view>
			</view>
			<!-- 动态 -->
			<dynamic v-if="tabIndex == 0"></dynamic>
			<!-- 收藏 -->
			<collection v-else-if="tabIndex == 1"></collection>
			<!-- 喜欢 -->
			<favorite v-else-if="tabIndex == 2"></favorite>
		</view>
		<!-- 分享 -->
		<share :visible="sharevisible" :closeAction="shareAction" :itemTapAction="shareItemAction"></share>
		<!-- 菜单 -->
		<minemenu :visible="menuvisible" :closeAction="menuAction" :itemTapAction="menuItemAction"></minemenu>
		<!-- 修改背景 -->
		<backgroundaction :visible="backgroundvisible" :closeAction="backgroundSwitch" :itemTapAction="backgroundSwitchItem"></backgroundaction>
	</view>
</template>

<script>
	import background from '../../pages/mine/minepage/mine_page_background.vue';
	import account from '../../pages/mine/minepage/mine_page_account.vue';
	import dynamic from '../../pages/mine/minepage/dynamic/mine_page_dynamic.vue';
	import favorite from '../../pages/mine/minepage/favorite/mine_page_favorite.vue';
	import collection from '../../pages/mine/minepage/collection/mine_page_collection.vue';
	import share from '../../pages/mine/components/social_share.vue';
	import minemenu from '../../pages/mine/components/mine_menu.vue';
	import backgroundaction from "../../pages/mine/components/mine_action_sheet.vue"

	export default {
		data() {
			return {
				tabSticky: false,
				tabs: ['动态', '收藏', '喜欢'],
				tabIndex: 0,
				tabTop: 0,
				sharevisible: false, //分享
				menuvisible: false, //分享
				backgroundvisible: false //修改背景
			};
		},
		methods: {
			//tab
			tabSelectAction(res) {
				var index = res.currentTarget.dataset.index;
				this.tabIndex = index;
			},
			// 分享
			shareAction() {
				this.sharevisible = !this.sharevisible;
			},
			// 分享点击
			shareItemAction(res) {
				console.log(res);
				if (res == 'report') {
					var me = this;
					setTimeout(function() {
						me.reportAction();
					}, 200);
				}
			},
			// 菜单
			menuAction() {
				this.menuvisible = !this.menuvisible;
			},
			// 菜单点击
			menuItemAction(res) {
				console.log(res);

				if (res == '扫一扫') {
					uni.navigateTo({
						url: ''
					});
				} else if (res == '购物车') {
					uni.navigateTo({
						url: ''
					});
				} else if (res == '订单') {
					uni.navigateTo({
						url: ''
					});
				} else if (res == '优惠卷') {
					uni.navigateTo({
						url: ''
					});
				} else if (res == '地址管理') {
					uni.navigateTo({
						url: ''
					});
				} else if (res == '钱包') {
					uni.navigateTo({
						url: '../../pages/mine/wallet/wallet_page'
					});
				} else if (res == '联系客服') {
					uni.navigateTo({
						url: '../../pages/mine/contact/contact'
					});
				} else if (res == '设置') {
					uni.navigateTo({
						url: ''
					});
				}
			},
			//修改背景
			backgroundSwitch() {
				this.backgroundvisible = !this.backgroundvisible
			},
			backgroundSwitchItem(res) {
				console.log(res)
			}
		},
		components: {
			background,
			account,
			dynamic,
			favorite,
			collection,
			share,
			minemenu,
			backgroundaction
		},
		onLoad(res) {
			if (res.otherPage != null) {
				this.otherPage = true;
				this.tabs = ['动态', '喜欢'];
			}

			this.tabSticky = false;
		},
		onPageScroll(res) {
			this.scrollTop = res.scrollTop;
			if (this.tabTop - res.scrollTop <= 40 + uni.getSystemInfoSync().statusBarHeight) {
				this.tabSticky = true;
			} else {
				this.tabSticky = false;
			}
		},
		onReady() {
			var me = this;
			let selector = uni.createSelectorQuery().select('.tab-bar');
			selector
				.boundingClientRect(function(data) {
					me.tabTop = data.top;
					if (me.tabTop < 0) {
						me.tabTop = -me.tabTop;
					}
				})
				.exec(function() {});
		}
	};
</script>

<style>
	@import url('../../pages/mine/minepage/mine_page.css');
</style>
