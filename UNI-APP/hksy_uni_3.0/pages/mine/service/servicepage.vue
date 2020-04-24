<template>
	<view class="main-body">
		<view class="main-body-sub" style="margin-top: 0rpx;">
			<view class="mine-page-cell-section-wapper">
				<view class="mine-page-cell-wapper" v-for="(item, index) in services" :key="index" style="height: 123rpx;"
				 :data-index="index" @tap="serviceAction" :style="bottomLine(index, services)">
					<view class="mine-page-cell-only-text">
						{{item}}
					</view>
					<view class="mine-page-cell-accessory-wapper">
						<image src="../../../static/images/right_arrow@3x.png" class="mine-page-cell-arrow"></image>
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
				services: ["下载合同", "联系客服"]
			}
		},
		methods: {
			serviceAction(res) {
				var index = res.currentTarget.dataset.index
				if (index == 0) {
					if (this.util.userInfo().personalStatus == 1) {
						uni.navigateTo({
							url: "../contract/contractmain"
						})
					} else {
						uni.showToast({
							title: "您还没有实名认证,请实名认证后在进行操作",
							icon: "none"
						})
					}
				} else if (index == 1) {
					uni.navigateTo({
						url: "./servicesweb"
					})
				}
			},
			bottomLine(index, list) {
				if (index == list.length - 1) {
					return ""
				} else {
					return "border-bottom: solid 2rpx rgba(21, 25, 54, 1); "
				}
			}
		}
	}
</script>

<style>
	@import url("../minepage.css");
</style>
