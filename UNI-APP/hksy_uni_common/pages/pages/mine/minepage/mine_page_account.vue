<template>
	<view class="account">
		<!-- 头像 -->
		<image src="" mode="" class="account-avatar"></image>
		<view class="account-buttons">
			<image src="/static/images/icon_me_setting@3x.png" mode="" class="account-setting" @click="goSetting" v-if="otherPage == false"></image>
			<view class="account-button-content" @click="funcAction">
				{{otherPage == true ? 'ta的角落' : '编辑资料'}}
			</view>
		</view>
		<!-- 用户名 -->
		<view class="account-name">
			是凉白开鸭
		</view>
		<!-- 用户id -->
		<view class="account-userid">
			街角号：{{1231412}}
		</view>
		<!-- 简介 -->
		<view class="account-introduction">
			这个人很懒什么都没介绍
		</view>
		<!-- 加入的角落(本人) 获取的赞 被收藏次数 -->
		<view class="account-item-content">
			<view class="account-item" v-for="(item, index) in itemList" :key="index">
				<view class="account-item-count">
					0
				</view>
				<view class="account-item-name">
					{{item}}
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				itemList: [
					"加入的角落",
					"获取的赞",
					"被收藏次数",
				]
			}
		},
		methods: {
			//设置
			goSetting() {
				console.log("goSetting")
			},
			funcAction() {
				if (this.otherPage == true) {
					this.goPageList()
				} else {
					this.editInfo()
				}
			},
			//编辑资料
			editInfo() { 
				uni.navigateTo({ 
					url: "/pages/pages/mine/edit/edit", 
				})
			},
			//角落列表
			goPageList() {
				uni.navigateTo({
					url: "/pages/pages/mine/minepage/mine_page_list", 
				})
			}
		},
		props: {
			// 别人主页
			otherPage: {
				type: Boolean,
				value: false
			},
		},
		mounted() {
			if (this.otherPage) {
				this.itemList = [
					"获取的赞",
					"被收藏次数",
				]
			}
		}
	}
</script>

<style>
	@import url("mine_page_account.css");
</style>
