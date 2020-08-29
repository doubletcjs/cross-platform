<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="alertview-mask" @click.stop="emptyAction">
			<view :class="input == true ? 'alertview-content alertview-content-input' : 'alertview-content'" :style="contentColor ? 'color: '+contentColor+';' : 'color: rgba(50, 50, 50, 1); '">
				{{contentText}}
			</view>
			<view class="alertview-input-content" v-if="input == true">
				<input type="text" v-model="inputText" placeholder="请输入兑换码" class="alertview-input" placeholder-class="alertview-input-placeholder" />
			</view>
			<view style="display: flex; flex-direction: row; align-items: center;">
				<view class="alertview-cancel" :style="cancelColor ? 'color: '+cancelColor+';' : 'color: rgba(235, 102, 91, 1); '"
				 @click="closePopup">
					{{cancelText ? cancelText : '取消'}}
				</view>
				<view class="alertview-confirm" :style="confirmColor ? 'color: '+confirmColor+';' : 'color: rgba(50, 50, 50, 1); '"
				 @click="onConfrim">
					{{confirmText ? confirmText : '确定'}}
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				inputText: ""
			}
		},
		methods: {
			//关闭alert
			closePopup() {
				if (this.closeAction) {
					this.closeAction()
				}
				
				var weakSelf = this
				setTimeout(function() {
					weakSelf.inputText = ""
				}, 400) 
			},
			emptyAction() {},
			onConfrim() {
				if (this.confirmAction) {
					if (this.input == true) {
						this.confirmAction(this.inputText)
					} else {
						this.confirmAction()
					}
				}

				this.closePopup()
			}
		},
		props: {
			//是否弹出显示
			visible: {
				type: Boolean,
				value: false
			},
			closeAction: Function,
			confirmAction: Function,
			contentText: "",
			contentColor: "",
			cancelText: "",
			cancelColor: "",
			confirmText: "",
			confirmColor: "",
			input: {
				type: Boolean,
				value: false
			},
		},

	}
</script>

<style>
	@import url("alertview.css");
</style>
