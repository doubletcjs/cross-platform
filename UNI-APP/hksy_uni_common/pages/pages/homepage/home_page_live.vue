<template>
	<view class="live">
		<image src="" mode="aspectFill" class="live-background-image"></image>
		<view class="live-column">
			<view class="live-item-column">
				<view class="live-item-title">
					今日美食制作：柠檬水
				</view>
				<view class="live-item-blogger">
					主播：红鱼
				</view>
			</view>
			<view class="live-item-column" style="width: 100%;">
				<scroll-view scroll-x="true" class="live-item-swiper">
					<image  mode="aspectFill" v-for="(item, index) in images" :key="index" class="live-item-image"> 
					</image>
				</scroll-view> 
				<view class="live-item-action">
					立即观看
				</view>
			</view>
		</view>
		<view class="live-status">
			<view class="live-status-dot">
				
			</view>
			<view class="live-status-text">
				直播中
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				images: [
					"",
					"",
					"",
					"",
				]
			}
		},
		methods: {
			scroll: function(e) {
				console.log(e)
			}
		}
	}
</script>

<style>
	@import url("home_page_live.css");
</style>
