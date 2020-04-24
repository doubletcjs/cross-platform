<template>
	<view class="main-body">
		<swiper :indicator-dots="false" :autoplay="false" style="width: 100%; height: 100%;" :current="current" @change="atChange">
			<swiper-item class="swiper-item-wapper" v-for="(item, index) in items" :key="index">
				<view class="swiper-item-wapper">
					<image :src="item" mode="aspectFit" class="swiper-image"></image>
					<view class="swiper-item-next-wapper" @tap="nextGuide">
						
					</view>
				</view>
			</swiper-item>
		</swiper>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				items: ["../../static/images/appguide_0@3x.png", "../../static/images/appguide_1@3x.png",
					"../../static/images/appguide_2@3x.png"
				],
				current: 0
			}
		},
		methods: {
			nextGuide() {
				if (this.current == this.items.length - 1) {
					if (this.util.token() == null || this.util.token().length == 0) {
						uni.reLaunch({
							url: "/pages/account/loginregister/loginregister"
						})
					} else {
						uni.reLaunch({
							url: "/pages/main/homepage"
						})
					}

					let currentVersion = this.util.currentAppVersion();
					this.util.recordLastAppVersion(currentVersion);
				} else {
					this.current += 1
				}
			},
			atChange(res) {
				this.current = res.detail.current
			}
		}
	}
</script>

<style>
	.swiper-item-wapper {
		width: 100%;
		
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
		align-content: center;
	}

	.swiper-image {
		width: 100%;
		height: 100%;
		position: fixed;
		width: 100%;
		height: 100%;
		left: 0;
		top: 0;
	}

	.swiper-item-next-wapper {
		width: 60%;
		height: 30%;

		position: fixed;
		bottom: 0;
		right: 0;
	}
</style>
