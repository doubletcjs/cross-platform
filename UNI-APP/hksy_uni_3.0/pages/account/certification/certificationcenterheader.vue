<template>
	<view class="certification-center-header-wapper">
		<view class="certification-center-content-wapper">
			<view class="certification-center-info-wapper">
				<image src="../../../static/images/default_avatar@3x.png" mode="" class="certification-center-portrait" v-if="_emptyObject(account.avater) == true"></image>
				<image :src="account.avater" mode="" class="certification-center-portrait" v-else></image>
				<view class="certification-center-name">
					{{account.nickname}}
				</view>
			</view>
			<view class="certification-center-tip">
				个人隐私信息安全保障中
			</view>
		</view>
		<view class="certification-center-status-wapper" style="background-color: rgba(23, 96, 255, 1);" v-if="account.personalStatus == 1">
			<view class="certification-center-status">
				已验证
			</view>
		</view>
		<view class="certification-center-status-wapper" style="background-color: rgba(145, 152, 173, 1);" v-else>
			<view class="certification-center-status">
				未验证
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
	@import url("certificationcenterheader.css");
</style>
