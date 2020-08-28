<template>
	<view class="main-body" style="background-color: rgba(247, 246, 245, 1);">
		<!-- 顶部按钮栏 -->
		<view class="create-title-bar">
			<!-- 返回 -->
			<image src="/static/images/base_back@3x.png" mode="aspectFit" style="width: 44rpx; height: 44rpx; margin-left: -6rpx;"
			 @click="backAction"></image>
			<!-- 保存 -->
			<view style="height: 44rpx; margin-right: -2rpx; font-size: 32rpx; color: rgba(50, 50, 50, 1);">
				保存
			</view>
			<view style="font-size: 36rpx; color: rgba(50, 50, 50, 1); position: absolute; left: 164rpx; right: 164rpx; text-align: center;">
				地址管理
			</view>
		</view>
		<!-- 列表 -->
		<view class="list-content">
			<!-- 收货人 -->
			<view class="editor-cell">
				<view class="editor-cell-name">
					收货人
				</view>
				<input type="text" value="" class="editor-cell-select" placeholder-class="editor-cell-input-placeholder"
				 placeholder="请输入收货人名称" />
				<view class="editor-cell-line"></view>
			</view>
			<!-- 手机号码 -->
			<view class="editor-cell">
				<view class="editor-cell-name">
					手机号码
				</view>
				<input type="number" value="" class="editor-cell-select" placeholder-class="editor-cell-input-placeholder"
				 placeholder="请输入手机号码" />
				<view class="editor-cell-line"></view>
			</view>
			<!-- 地区 -->
			<view class="editor-cell">
				<view class="editor-cell-name">
					地区
				</view>
				<view class="editor-cell-select" style="color: rgba(204, 204, 204, 1);" @click="addressSelection">
					省市区、县乡镇等
				</view>
				<image src="/static/images/detail_arrow@3x.png" mode="" class="editor-cell-select-arrow"></image>
				<view class="editor-cell-line"></view>
			</view>
			<!-- 详细地址 -->
			<view class="editor-cell" style="height: 136rpx; align-items: flex-start;">
				<view class="editor-cell-name" style="margin-top: 28rpx;">
					详细地址
				</view>
				<textarea value="" placeholder="街道、门牌号等" class="editor-cell-input" placeholder-class="editor-cell-input-placeholder" />
				</view>
			<!-- 分割 -->
			<view class="editor-cell-sapce-line"></view>
			<!-- 地址标签 -->
			<view class="editor-cell" style="justify-content: space-between;">
				<view class="editor-cell-name">
					地址标签
				</view> 
				<view class="editor-cell-row" style="margin-right: 32rpx;">
					<view class="editor-cell-label" v-for="(label, index) in lableList" :key="index" :data-index="index" @click="labelSelect" :style="index == labelIndex ? 'background-color: rgba(1, 152, 117, 0.2); color: rgba(1, 152, 117, 1);' : ''">
						{{label}}
					</view>
				</view>
				<view class="editor-cell-line"></view>
			</view>
			<!-- 设为默认地址 -->
			<view class="editor-cell" style="justify-content: space-between;">
				<view class="editor-cell-name">
					设为默认地址
				</view>  
				<switch checked="true" @change="" color="rgba(247, 246, 245, 1)" />
			</view>
			<!-- 分割 -->
			<view class="editor-cell-sapce-line"></view>
			<!-- 邮编 -->
			<view class="editor-cell">
				<view class="editor-cell-name">
					邮编
				</view>  
				<input type="number" value="" class="editor-cell-select" placeholder-class="editor-cell-input-placeholder" placeholder="请输入请输入邮编" />
			</view>
		</view>
		<!-- 地址选择器 -->
		<selection :visible="selectionvisible" :closeAction="addressSelection"></selection>
	</view>
</template>

<script>
	import selection from "./address_selection.vue"
	
	export default {
		data() {
			return {
				labelIndex: -1,
				lableList: [
					"家",
					"公司",
					"学校",
					"其他",
				],
				selectionvisible: false
			}
		},
		methods: {
			// 返回
			backAction() {
				uni.navigateBack({
					delta: 1,
				});
			},
			// 切换标签
			labelSelect(res) {
				var index = res.currentTarget.dataset.index
				this.labelIndex = index
			},
			// 地址选择器
			addressSelection() {
				this.selectionvisible = !this.selectionvisible
			}
		},
		components: {
			selection
		}
	}
</script>

<style>
	@import url("address_editor.css");
	@import url("../../create/create_title_bar.css");
</style>
