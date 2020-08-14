<template>
	<view class="banner">
		<swiper display-multiple-items="1" style="height: 240rpx;">
			<swiper-item v-for="(item, index) in banners" :key="index">
				<view class="banner-item"></view>
			</swiper-item>
		</swiper>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				banners: [""]
			}
		},
		methods: {
			
		}
	}
</script>

<style>
	@import url("home_page_banner.css");
</style>
