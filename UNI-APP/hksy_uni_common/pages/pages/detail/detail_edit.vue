<template>
	<view>
		<!-- 封面 -->
		<view class="edit-base-header">
			<view class="edit-base-text">
				角落头像
			</view>
			<image :src="cover.length == 0 ? '/static/images/creation_image_cover@3x.png' : cover" mode="aspectFill" class="edit-base-header-cover"></image>
			<!-- 选择图片 -->
			<image src="/static/images/creation_image_addition@3x.png" mode="" class="edit-image-addition" @click="selectImageAction"></image>
		</view>
		<!-- cell -->
		<view class="detail-item-cell-section">
			<!-- 名称 -->
			<view class="detail-item-cell" @click="inputContentAction(0)">
				<view class="detail-item-cell-name">
					角落名称
				</view>
				<view class="detail-item-cell-row">
					<view class="detail-item-cell-value">
						每日一食记
					</view>
					<image src="/static/images/detail_arrow@3x.png" mode="" class="detail-item-cell-arrow"></image>
				</view>
			</view> 
			<!-- 简介 -->
			<view class="detail-item-cell" @click="inputContentAction(1)">
				<view class="detail-item-cell-name">
					角落简介
				</view>
				<view class="detail-item-cell-row">
					<view class="detail-item-cell-value">
						相濡以滋味，相忘于江湖...
					</view>
					<image src="/static/images/detail_arrow@3x.png" mode="" class="detail-item-cell-arrow"></image>
				</view>
			</view>
		</view>
		<!-- 分类 -->
		<view class="edit-classify-content">
			<view class="create-classify" style="margin-top: 56rpx; font-size: 32rpx;">
				选择分类
			</view>
			<view class="create-classify-item-content">
				<view :class="classifyIndex == index ? 'create-classify-item-select' : 'create-classify-item'" v-for="(item, index) in classifyList"
				 :key="index" :style="index % 4 == 0 ? '' : 'margin-left: 47rpx;'" :data-index="index" @click="selectClassifyAction">
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
				classifyList: [
					"科技",
					"教育",
					"医疗",
					"娱乐",
					"经济",
					"生活",
					"设计",
					"摄影"
				],
				classifyIndex: -1,
				cover: "",
			}
		},
		methods: {
			// 选择分类
			selectClassifyAction(res) {
				var index = res.currentTarget.dataset.index
				this.classifyIndex = index
			},
			// 选择图片
			selectImageAction() {
				var weakSelf = this
				uni.chooseImage({
					count: 1,
					complete(res) {
						var paths = res.tempFilePaths
						weakSelf.cover = paths[0]
					},
					fail(error) {

					}
				})
			},
			//输入内容
			inputContentAction(type) {
				uni.navigateTo({
					url: "detail_edit_input?type="+type
				})
			}
		}
	}
</script>

<style>
	@import url("detail_edit.css"); 
	@import url("../detail/detail_item_cell.css");
	@import url("../create/create_classify.css");
</style>
