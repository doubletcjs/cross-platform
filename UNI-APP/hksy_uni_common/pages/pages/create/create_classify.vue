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
			<!-- 完成 -->
			<view class="create-title-next" @click="finishAction">
				完成
			</view>
		</view>
		<!-- 分类 -->
		<view class="create-classify-content">
			<view class="create-classify-row">
				<image :src="cover" mode="aspectFill" class="create-classify-cover"></image>
				<view class="create-classify-title">
					{{ title }}
				</view>
			</view>
			<view class="create-introduction">
				<textarea v-model="introduction" placeholder="请输入角落简介" placeholder-class="create-introduction-placeholder"></textarea>
			</view>
			<view class="create-classify">
				选择分类
			</view>
			<view class="create-classify-item-content">
				<view :class="
            classifyIndex == index
              ? 'create-classify-item-select'
              : 'create-classify-item'
          "
				 v-for="(item, index) in classifyList" :key="index" :style="index % 4 == 0 ? '' : 'margin-left: 47rpx;'"
				 :data-index="index" @click="selectClassifyAction">
					{{ item }}
				</view>
			</view>
		</view>
		<!-- 用户协议 -->
		<view class="create-agreement-row">
			<!-- agreement == true ? '' : '' -->
			<image :src="
          agreement == true
            ? '/static/images/detail_create_sel@3x.png'
            : '/static/images/detail_create_unsel@3x.png'
        "
			 class="create-agreement-button" @click="selectAgreement"></image>
			<view class="create-agreement" @click="selectAgreement">
				我已经阅读并同意
			</view>
			<view class="create-agreement-name" @click="showAgreement">
				《街角落主规则》
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				cover: "",
				title: "",
				introduction: "",
				classify: "",
				introduction: "",
				classifyList: [
					"科技",
					"教育",
					"医疗",
					"娱乐",
					"经济",
					"生活",
					"设计",
					"摄影",
				],
				classifyIndex: -1,
				agreement: false,
			};
		},
		methods: {
			// 返回
			backAction() {
				uni.navigateBack({
					delta: 1,
				});
			},
			// 完成
			finishAction() {
				if (
					this.introduction.length > 0 &&
					this.classifyIndex >= 0 &&
					this.agreement == true
				) {
					uni.navigateTo({
						url: "create_complete",
					});
				}
			},
			// 选择分类
			selectClassifyAction(res) {
				var index = res.currentTarget.dataset.index;
				this.classifyIndex = index;
			},
			// 用户协议
			showAgreement() {
				uni.navigateTo({
					url: "create_rule",
				});
			},
			// 选择用户协议
			selectAgreement() {
				this.agreement = !this.agreement;
			},
		},
		onLoad(params) {
			this.cover = params["cover"];
			this.title = params["title"];
		},
	};
</script>

<style>
	@import url("create_title_bar.css");
	@import url("create_classify.css");
</style>
