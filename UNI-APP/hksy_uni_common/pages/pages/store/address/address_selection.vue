<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="selection-content" @click.stop="emptyAction">
			<!-- 标题 -->
			<view class="selection-title">
				地区
				<image src="/static/images/icon_address_close@3x.png" mode="" class="selection-close" @click="closePopup"></image>
			</view>
			<!-- tab -->
			<view class="selection-tab">
				<view class="selection-tab-item" @click="tabSwitch(0)">
					中国大陆
					<view class="selection-tab-indicator-mask">
						<view class="selection-tab-indicator" :style="tabIndedx == 0 ? 'background-color: rgba(235, 102, 91, 1);' : ''">

						</view>
					</view>
				</view>
				<view class="selection-tab-item" style="margin-left: 102rpx;" @click="tabSwitch(1)">
					港澳台及海外
					<view class="selection-tab-indicator-mask">
						<view class="selection-tab-indicator" :style="tabIndedx == 1 ? 'background-color: rgba(235, 102, 91, 1);' : ''">

						</view>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				tabIndedx: 0
			}
		},
		methods: {
			//关闭alert
			closePopup() {
				this.closeAction()
			},
			emptyAction() {},
			//切换tab
			tabSwitch(res) {
				console.log(res)
				this.tabIndedx = res
			}
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
	@import url("address_selection.css");
</style>
