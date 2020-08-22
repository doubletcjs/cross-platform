<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="menu-content" @click.stop="emptyAction">
			<!-- 标题 -->
			<view class="menu-title-content">
				<view class="menu-title">
					更多
				</view>
			</view> 
			<view class="menu-cell-list">
				<view class="menu-cell" v-for="(item, index) in menuList" :key="index" @click="itemTap(index)">
					<image :src="item['icon']" mode="" class="menu-cell-icon"></image>
					<view class="menu-cell-text">
						{{item['name']}}
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				menuList: [
					{
						icon: "/static/images/icon_me_menu_scan@3x.png",
						name: "扫一扫"
					},
					{
						icon: "/static/images/icon_me_menu_shoppingcart@3x.png",
						name: "购物车"
					},
					{
						icon: "/static/images/icon_me_menu_order@3x.png",
						name: "订单"
					},
					{
						icon: "/static/images/icon_me_menu_coupons@3x.png",
						name: "优惠券"
					},
					{
						icon: "/static/images/icon_me_menu_address@3x.png",
						name: "地址管理"
					},
					{
						icon: "/static/images/icon_me_menu_wallet@3x.png",
						name: "钱包"
					},
					{
						icon: "/static/images/icon_me_menu_service@3x.png",
						name: "联系客服"
					},
					{
						icon: "/static/images/icon_me_menu_setting@3x.png",
						name: "设置"
					}, 
				]
			}
		},
		methods: {
			//关闭alert
			closePopup() {
				this.closeAction()
			},
			emptyAction() {},
			//菜单点击
			itemTap(res) { 
				this.closeAction()
				var me = this
				setTimeout(function() {
					me.itemTapAction(me.menuList[res]["name"])
				}, 100)
			},
		},
		props: {
			//是否弹出显示
			visible: {
				type: Boolean,
				value: false
			},
			closeAction: Function,
			itemTapAction: Function,
		}
	}
</script>

<style>
	@import url("mine_menu.css");
</style>
