<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="discuss-input-mask" @click.stop="emptyAction" :style="'bottom:' + keybordHeight + 'rpx;'">
			<view class="discuss-input-row"> 
				<textarea :auto-height="true" maxlength="200" v-model="content" type="text" placeholder="回复布丁：" class="discuss-input"
				 placeholder-class="discuss-input-placeholder"/>
				<image src="/static/images/input_bar_send@3x.png" mode="" class="discuss-input-send" @click="sendContentAction"></image>
			</view>
			<image src="/static/images/input_bar_icon@3x.png" mode="" class="discuss-input-expression"></image>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				content: "",
				keybordHeight: 0
			}
		},
		methods: {
			//关闭alert
			closePopup() {  
				this.closeAction()
				this.content = ""
			},
			emptyAction() {} ,
			// 发送
			sendContentAction() {
				if (this.sendAction != null) {
					this.sendAction(this.content)
					this.closeAction()
				}
			} 
		},
		props: {
			//是否弹出显示
			visible: {
				type: Boolean,
				value: false
			},
			closeAction: Function,
			sendAction: Function,
		},
		mounted() {  
			if (uni.getSystemInfoSync().platform == "android") { 
				this.$mp.page.$getAppWebview().setStyle({
				  softinputMode: "adjustResize"
				})
			} 
		}
	}
</script>

<style>
	@import url("home_page_discuss_input.css");
</style>
