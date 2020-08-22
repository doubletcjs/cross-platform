<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="post-content" @click.stop="emptyAction">
			<!-- 标题 -->
			<view class="post-title">
				发布
			</view>
			<view class="post-item-content">
				<view class="post-item" v-for="(item, index) in itemList" :key="index">
					<image :src="item['icon']" mode="" class="post-item-cover"></image>
					<view class="post-item-title">
						{{item['title']}}
					</view>
				</view>
			</view>
			<!-- 取消 -->
			<view class="post-cancel" @click="closePopup">
				取消
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				itemList: [
					{
						icon: "/static/images/dynamic_post_photo@3x.png",
						title: "照片"
					},
					{
						icon: "/static/images/dynamic_post_video@3x.png",
						title: "视频"
					},
					{
						icon: "/static/images/dynamic_post_live@3x.png",
						title: "直播"
					} 
				]
			}
		},
		methods: {
			//关闭alert
			closePopup() {
				this.closeAction()
			},
			emptyAction() {},
		},
		props: {
			//是否弹出显示
			visible: {
				type: Boolean,
				value: false
			},
			closeAction: Function 
		}
	}
</script>

<style>
	@import url("home_page_dynamic_post.css");
</style>
