<template>
	<view>
		<!-- 顶部按钮栏 -->
		<view class="create-title-bar">
			<!-- 返回 -->
			<view class="create-title-back-row" @click="backAction">
				<view class="create-title-back">
					取消
				</view>
			</view>
			<!-- 下一步 -->
			<view class="create-title-next" @click="nextAction">
				下一步
			</view>
		</view>
		<!-- 创建内容 -->
		<view class="creation-content">
			<!-- 封面 -->
			<view class="creation-image-background">
				<view class="creation-image-content">
					<image :src="
              cover.length == 0
                ? '/static/images/creation_image_cover@3x.png'
                : cover
            "
					 mode="aspectFill" class="creation-image"></image>
					<!-- 选择图片 -->
					<image src="/static/images/creation_image_addition@3x.png" mode="" class="creation-image-addition" @click="selectImageAction"></image>
				</view>
			</view>
			<!-- 名称 -->
			<input type="text" v-model="title" class="creation-input" placeholder-class="creation-input-placeholder" placeholder="请输入角落名称" />
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				cover: "",
				title: "",
			};
		},
		methods: {
			// 返回
			backAction() {
				uni.navigateBack({
					delta: 1,
				});
			},
			// 选择图片
			selectImageAction() {
				var weakSelf = this;
				uni.chooseImage({
					count: 1,
					complete(res) {
						var paths = res.tempFilePaths;
						weakSelf.cover = paths[0];
					},
					fail(error) {},
				});
			},
			// 下一步
			nextAction() {
				if (this.cover.length > 0 && this.title.length > 0) {
					uni.navigateTo({
						url: "./create_classify?" +
							"cover=" +
							this.cover +
							"&" +
							"title=" +
							this.title,
					});
				} else {
					uni.showToast({
						title: "名称或者封面图片不能为空！",
						icon: "none",
					});
				}
			},
		},
	};
</script>

<style>
	@import url("create_title_bar.css");
	@import url("create_base.css");
</style>
