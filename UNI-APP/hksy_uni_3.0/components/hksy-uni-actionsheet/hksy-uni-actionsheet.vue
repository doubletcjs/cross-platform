<template>
	<view class="actionsheet-body">
		<view class="actionsheet-cell-wapper" v-for="(title, index) in titles" :key="index" :data-index="index" @tap="tapTitle">
			{{title}}
		</view>
		<view class="actionsheet-cell-wapper" v-if="showCancel == true" style="margin-top: 40rpx;" @tap="cancelAction">
			取消
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
			tapTitle(res) {
				var index = res.currentTarget.dataset.index 
				this.titleAction(index) 
			},
			cancelAction() {
				this.titleAction(-1) 
			}
		},
		props: {
			titles: null,
			titleAction: Function,
			showCancel: false
		}
	}
</script>

<style>
	@import url("hksy-uni-actionsheet.css");
</style>
