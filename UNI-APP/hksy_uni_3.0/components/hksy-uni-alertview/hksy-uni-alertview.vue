<template>
	<view class="alert-view-body">
		<view v-if="isCertification == 'true'">
			<view class="alert-view-wapper" style="margin-left: 66rpx; margin-right: 66rpx;">
				<view class="alert-view-title" v-if="title != null" style="margin-bottom: 51rpx;">
					{{title}}
				</view>
				<view style="margin-bottom: 75rpx;">
					<text space="emsp" class="alert-view-content">
						{{content}}
					</text>
				</view>
			</view>
		</view>
		<view v-else-if="isTtransfers == 'true'">
			<view class="alert-view-wapper" style="margin-left: 76rpx; margin-right: 76rpx; justify-content: center; align-items: center;">
				<view class="alert-view-title" v-if="title != null" style="margin-bottom: 41rpx;margin-top: 81rpx;">
					{{title}}
				</view>
				<view style="margin-bottom: 78rpx;">
					<text space="emsp" class="alert-view-content" style="text-align: center; color: rgba(23, 96, 255, 1); font-size: 30rpx;">
						{{content}}
					</text>
				</view>
			</view>
		</view>
		<view v-else>
			<view class="alert-view-wapper">
				<view class="alert-view-title" v-if="title != null">
					{{title}}
				</view>
				<view class="alert-view-content">
					{{content}}
				</view>
			</view>
		</view>
		<view class="alert-view-buttons-wapper" v-if="showCancel=='true'">
			<view class="alert-view-cancel" style="width: 50%;" @tap="cancelAction">
				{{cancelTitle}}
			</view>
			<view class="alert-view-line">

			</view>
			<view class="alert-view-confirm" style="width: 50%;" @tap="confirmAction">
				{{confirmTitle}}
			</view>
		</view>
		<view class="alert-view-buttons-wapper" v-else>
			<view class="alert-view-confirm" style="width: 100%;" @tap="confirmAction">
				{{confirmTitle}}
			</view>
		</view>
	</view>
</template>

<script>
	import uniPopup from "../../components/uni-popup/uni-popup.vue"

	export default {
		data() {
			return {

			}
		},
		methods: {

		},
		components: {
			uniPopup
		},
		props: {
			title: {
				type: String,
				default: null
			},
			content: {
				type: String,
				default: "内容不能为空！"
			},
			showCancel: {
				type: String,
				default: "true"
			},
			cancelTitle: {
				type: String,
				default: "取消"
			},
			confirmTitle: {
				type: String,
				default: "确定"
			},
			cancelAction: Function,
			confirmAction: Function,
			isCertification: {
				type: String,
				default: "false"
			},
			isTtransfers: {
				type: String,
				default: "false"
			}
		}
	}
</script>

<style>
	@import url("hksy-uni-alertview.css");
</style>
