<template>
	<view class="paycode-input-body">
		<view class="paycode-input-title-wapper">
			<view class="paycode-input-title">
				请输入支付密码
			</view>
			<view class="paycode-input-close-wapper" @tap="colseAction">
				<image src="/static/images/close@3x.png" mode="aspectFit" class="paycode-input-close-image"></image>
			</view>
		</view>
		<view style="text-align: center;">{{Details}}</view>
		<view class="paycode-wapper">
			<validcode ref="pwd" :maxlength="6" :isPwd="true" @finish="inputFinish"></validcode>
		</view>
	</view>
</template>

<script>
	import validcode from "../../../components/p-validCode/validCode.vue"
	import keyboardPackage from '../../../components/keyboard-package/keyboard-package.vue'
	export default {
		data() {
			return {
				
			}
		},
		methods: {
			inputFinish(val) {
				this.colseAction()
				uni.hideKeyboard()
				this.completeAction(val)
			}
		},
		props: {
			colseAction: Function,
			completeAction: Function,
			Details: String
		},
		components: {
			validcode
		}
	}
</script>

<style>
	@import url("paycodeinput.css");
</style>
