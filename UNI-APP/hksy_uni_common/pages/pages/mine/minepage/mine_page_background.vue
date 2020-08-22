<template>
	<view class="background" @click="switchBackgroud">
		<!-- 背景 -->
		<image src="" mode="" class="background-image"></image>
		<view class="background-button-bar">
			<!-- 更多 -->
			<image src="/static/images/homepage_menu@3x.png" mode="" class="background-setting" @click.stop="more" v-if="otherPage == false"></image>
			<image src="/static/images/base_back_white@3x.png" mode="" class="background-back" @click.stop="backAction" v-else></image>
			<!-- 分享 -->
			<image src="/static/images/icon_me_share@3x.png" mode="" class="background-share" @click.stop="share"></image>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				actionsheetvisible: false
			}
		},
		methods: {
			//切换背景
			switchBackgroud() {
				if (this.otherPage == false) {
					if (this.backgroundSwitch != null) {
						this.backgroundSwitch();
					}
				}
			},
			//更多
			more() {
				if (this.backgroundMore != null) {
					this.backgroundMore()
				}
			},
			//分享
			share() {
				if (this.backgroundShare != null) {
					this.backgroundShare()
				}
			},
			//返回
			backAction() {
				uni.navigateBack({
					delta: 1
				})
			}
		},
		props: {
			// 别人主页
			otherPage: {
				type: Boolean,
				value: false
			},
			backgroundShare: Function,
			backgroundMore: Function,
			backgroundSwitch: Function,
		} 
	}
</script>

<style>
	@import url("mine_page_background.css");
</style>
