<template>
	<view class="main-body">
		<!-- <web-view :src="galaxyUrl" v-if="galaxyUrl.length > 0"></web-view> -->
		<view class="galaxy-wapper">
			<image src="../../static/images/galaxy.gif" mode="widthFix"></image>
			<view class="galaxy-tip">
				敬请期待
			</view>
		</view>

		<!-- #ifndef H5 -->
		<uni-popup ref="versionpopalert" type="center" :maskClick="false" v-if="vsersion">
			<versionalert :versionInfo="vsersion" :closeHandle="closeVersionAlert"></versionalert>
		</uni-popup>
		<!-- #endif -->
	</view>
</template>

<script>
	import uniPopup from "../../components/uni-popup/uni-popup.vue"
	import versionalert from "../main/views/versionpopalert.vue"

	export default {
		data() {
			return {
				galaxyUrl: this.networking.kQrcodeURL + "/invite/SkyDrive.html",
				vsersion: null
			}
		},
		methods: {
			closeVersionAlert() { // 更新dialog关闭回调
				console.log("关闭更新dialog");
				this.$refs.versionpopalert.close()
			}
		},
		components: {
			uniPopup,
			versionalert
		},
		created() {
			// #ifndef H5
			if (this.util.appVersionInfo() != null) {
				this.vsersion = this.util.appVersionInfo()
				setTimeout(() => {
					this.$refs.versionpopalert.open()
				}, 100)
			}
			// #endif
		}
	}
</script>

<style>
	.galaxy-wapper {
		width: 100%;
		height: 100%;

		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		align-content: center;
	}

	.galaxy-tip {
		font-size: 30rpx;
		color: rgba(145, 152, 173, 1);

		margin-top: 57rpx;
	}
</style>
