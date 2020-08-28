<template>
	<view class="main-body" style="background-color: rgba(247, 246, 245, 1);">
		<!-- 顶部按钮栏 -->
		<view class="create-title-bar">
			<!-- 返回 -->
			<image src="/static/images/base_back@3x.png" mode="aspectFit" style="width: 44rpx; height: 44rpx; margin-left: -6rpx;"
			 @click="backAction"></image>
			<!-- 添加 -->
			<image src="/static/images/icon_address_add@3x.png" mode="aspectFit" style="width: 44rpx; height: 44rpx; margin-right: -2rpx;" @click="createAction"></image>
			<view style="font-size: 36rpx; color: rgba(50, 50, 50, 1); position: absolute; left: 164rpx; right: 164rpx; text-align: center;">
				地址管理
			</view>
		</view>
		<!-- 列表 -->
		<view class="list-content">
			<view class="address-cell" v-for="(address, index) in addressList" :key="index">
				<view class="address-cell-row" style="padding-left: 32rpx; padding-right: 32rpx;">
					<view class="address-cell-name">
						{{address['name']}}
					</view>
					<view class="address-cell-phone">
						{{address['phone']}}
					</view>
				</view>
				<view class="address-cell-row" style="padding-left: 32rpx; padding-right: 32rpx; align-items: flex-start; margin-top: 16rpx;">
					<view class="address-cell-default" v-if="address['default'] == true">
						默认
					</view>
					<view class="address-cell-label" v-else-if="address['label'].length > 0">
						{{address['label']}}
					</view> 
					<view class="address-cell-address" :style="address['default'] == false && address['label'].length == 0 ? 'margin-left: 0rpx; max-width: 100%;' : ''">
						{{address['address']}}
					</view>
				</view>
				<!-- 分割线 -->
				<view class="address-cell-line">
					
				</view>
				<!-- 按钮 -->
				<view class="address-cell-row" style="height: 88rpx; justify-content: flex-end; padding-right: 32rpx;">
					<view class="address-cell-action" :data-index="index" @click="deleteAction">
						删除
					</view>
					<view class="address-cell-action" style="margin-left: 64rpx;">
						修改
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
				addressList: [{
						name: "张三",
						phone: "136****1234",
						default: true,
						label: "",
						address: "广东省广州市白云区人和芳华路星航国际大909会议室",
					},
					{
						name: "张三",
						phone: "136****1234",
						default: false,
						label: "公司",
						address: "广东省广州市白云区人和芳华路星航国际大909会议室",
					},
					{
						name: "张三",
						phone: "136****1234",
						default: false,
						label: "家",
						address: "广东省广州市白云区人和芳华路星航国际大909会议室",
					},
					{
						name: "张三",
						phone: "136****1234",
						default: false,
						label: "",
						address: "广东省广州市白云区人和芳华路星航国际大909会议室会议室会议室会议室",
					}
				]
			}
		},
		methods: {
			// 返回
			backAction() {
				uni.navigateBack({
					delta: 1,
				});
			},
			// 创建
			createAction() {
				uni.navigateTo({
					url: "./address_editor"
				})
			},
			// 删除
			deleteAction(res) {
				var index = res.currentTarget.dataset.index
				uni.showModal({
					title: "确定删除改地址？",
					cancelText: "否",
					confirmText: "是",
					cancelColor: "#323232",
					confirmColor: "#EB665B",
				})
			},
		}
	}
</script>

<style>
	@import url("../../create/create_title_bar.css");
	@import url("address_list.css");
</style>
