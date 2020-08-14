<template>
	<view>
		<!-- 顶部按钮栏 -->
		<view class="create-title-bar">
			<!-- 返回 -->
			<view class="create-title-back-row" @click="backAction">
				<image src="/static/images/base_back@3x.png" mode="" class="create-title-arrow" style="margin-right: 16rpx;"></image>
				<view class="create-title-back">
					返回
				</view>
			</view>
			<view class="create-title">
				{{title}}
			</view>
			<!-- 完成 -->
			<view class="create-title-next" @click="onConfirmAction">
				完成
			</view>
		</view>
		<!-- 输入框 -->
		<view class="edit-input-content">
			<input type="text" v-model="content" class="edit-input" style="height: 66rpx;" placeholder-class="edit-input-placeholder"
			 :placeholder="'请输入'+title" v-if="type == '0'" />
			<textarea type="text" v-model="content" class="edit-input" style="height: 108rpx;" placeholder-class="edit-input-placeholder"
			 :placeholder="'请输入'+title" v-else />
			</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				title: "",
				type: "0", 
				content: ""
			}
		},
		methods: {
			// 返回
			backAction() {
				uni.navigateBack({
					delta: 1
				})
			},
			// 完成
			onConfirmAction() { 
				var pages = getCurrentPages();
				var prevPage = pages[pages.length - 2]; //上一个页面
				//直接调用上一个页面的setData()方法，把数据存到上一个页面中去
				// 上一个页面最后设置userdata
				if (this.type == "0") {
					prevPage.name = this.content 
				} else {
					prevPage.introduction = this.content 
				}
				
				prevPage.editComplete = true
				uni.navigateBack({
					delta:1
				})
			}, 
		},
		onLoad(res) {
			if (res != null) {
				var type = res["type"]
				var content = res["content"]
				if (type == "0") {
					this.title = "角落名称"   
				} else if (type == "1") {
					this.title = "角落简介" 
				} 
				
				this.type = type
				this.content = content
			} 
		}
	}
</script> 

<style>
	@import url("detail_edit_input.css");
	@import url("../../create/create_title_bar.css");
</style>
