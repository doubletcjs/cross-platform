<template>
	<view class="mine-header-wapper" @tap="personalInfo">
		<view class="mine-header-title">
			我的
		</view>
		<view class="mine-header-info-wapper">
			<view class="mine-header-info-account-wapper">
				<image src="../../static/images/default_avatar@3x.png" mode="" class="mine-header-info-portrait" v-if="_emptyObject(account.avater) == true"></image>
				<image :src="account.avater" mode="aspectFill" class="mine-header-info-portrait" v-else></image>
				<view class="mine-header-info-more-wapper">
					<view class="mine-header-info-name-level-wapper" style="margin-bottom: 4rpx;">
						<view class="mine-header-info-name">
							{{account.nickname}}
						</view>
						<view class="mine-header-info-level-wapper">
							<image src="../../static/images/level@3x.png" mode="widthFix" class="mine-header-info-level-image"></image>
							<view class="mine-header-info-level">
								{{account.lv}}
							</view>
						</view>
					</view>
					<view class="mine-header-info-name-level-wapper" style="margin-top: 4rpx;">
						<!-- 图标 -->
						<image src="../../static/images/renzheng@3x.png" mode="aspectFit" class="mine-header-info-safe"></image>
						<view class="mine-header-info-phone">
							{{account.phone.substr(0, 3)}}****{{account.phone.substr(7)}}
						</view>
					</view>
				</view>
			</view>
			<image src="../../static/images/right_arrow@3x.png" mode="widthFix" class="mine-header-info-arrow"></image>
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
			personalInfo() {
				uni.navigateTo({
					url: "../account/personalinfo"
				})
			},
			_emptyObject(str) {
				return this.util.emptyObject(str)
			}
		},
		props: {
			account: {}
		}
	}
</script>

<style>
	@import url("mineheader.css");
</style>
