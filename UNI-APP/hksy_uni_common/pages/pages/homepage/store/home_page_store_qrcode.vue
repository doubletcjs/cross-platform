<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="qrcode-mask" @click.stop="emptyAction">
			<image src="" mode="aspectFill" class="qrcode-cover"></image>
			<view class="qrcode-name">
				每日一食记的小铺
			</view>
			<image src="" mode="aspectFill" class="qrcode-image"></image>
			<view class="qrcode-tip">
				扫一扫，分享店铺给TA
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {

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
			closeAction: Function,
		}
	}
</script>

<style>
	@import url("home_page_store_qrcode.css");
</style>
