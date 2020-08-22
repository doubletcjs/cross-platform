<template>
	<view class="main-body">
		<view class="main-body-sub" style="margin-top: 0rpx;">
			<view class="mine-page-cell-section-wapper">
				<view v-for="(item, index) in infos" :key="index" :style="bottomLine(index, infos)">
					<view class="mine-page-cell-wapper" v-if="index == 0" style="height: 142rpx;" @tap="changeAvater">
						<view class="mine-page-cell-only-text">
							{{item}}
						</view>
						<view class="mine-page-cell-accessory-wapper">
							<image src="../../static/images/default_avatar@3x.png" class="personal-info-cell-portrait" v-if="_emptyObject(account.avater) == true"></image>
							<image :src="account.avater" mode="aspectFill" class="personal-info-cell-portrait" v-else></image>
							<image src="../../static/images/right_write_arrow@3x.png" class="mine-page-cell-arrow"></image>
						</view>
					</view>
					<view class="mine-page-cell-wapper" v-else style="height: 122rpx;" :data-index="index" @tap="functionItemAction">
						<view class="mine-page-cell-only-text">
							{{item}}
						</view>
						<view class="mine-page-cell-accessory-wapper">
							<view class="personal-info-cell-text" v-if="index == 1" style="margin-right: 20rpx;">
								{{nickname}}
							</view>
							<view class="personal-info-cell-text" v-else-if="index == 2">
								{{account.phone.substr(0, 3)}}****{{account.phone.substr(7)}}
							</view>
							<image src="../../static/images/right_write_arrow@3x.png" class="mine-page-cell-arrow" v-if="index != 2"></image>
						</view>
					</view>
				</view>
			</view>
			<view class="mine-page-cell-section-wapper">
				<view class="mine-page-cell-wapper" @tap="certificationCenter">
					<view class="mine-page-cell-only-text">
						实名认证
					</view>
					<view class="mine-page-cell-accessory-wapper">
						<view class="personal-info-cell-text" style="margin-right: 20rpx;" v-if="account.personalStatus == 1">
							已认证
						</view>
						<view class="personal-info-cell-text" style="margin-right: 20rpx;" v-else>
							未认证
						</view>
						<image src="../../static/images/right_write_arrow@3x.png" class="mine-page-cell-arrow"></image>
					</view>
				</view>
			</view> 
		</view>
	</view>
</template>

<script>
	import accountapi from "./api/accountapi.js" 

	export default {
		data() {
			return {
				infos: ["头像", "昵称", "账号"],
				account: this.util.userInfo(),
				nickname: '', 
			}
		},
		methods: {
			certificationCenter() {
				uni.navigateTo({
					url: "./certification/certificationcenter"
				})
			},
			_emptyObject(str) {
				return this.util.emptyObject(str)
			},
			changeAvater() {
				var me = this
				uni.chooseImage({
					count: 1,
					success(chooseImageRes) {
						uni.showLoading({

						})
						me.networking.functionUpload(chooseImageRes.tempFilePaths[0], {}, (url, msg) => {
							if (url != null) {
								accountapi.changeAvater(
									"",
									url,
									(data, msg) => {
										if (data) {
											uni.$emit(me.kAccountRefresh, null)
											me.account.avater = url
											setTimeout(() => {
												uni.hideLoading()
											}, 500)
										} else {
											uni.hideLoading()
											uni.showToast({
												title: msg,
												icon: "none"
											})
										}
									}
									)
							} else {
								uni.hideLoading()
								uni.showToast({
									title: msg,
									icon: "none"
								})
							}
						})
					},
					fail(error) {
						if (error.msg) {
							uni.showToast({
								title: error.msg,
								icon: "none"
							})
						}
					}
				})
			},
			bottomLine(index, list) {
				if (index == list.length - 1) {
					return ""
				} else {
					return "border-bottom: solid 2rpx rgba(21, 25, 54, 1); "
				}
			},
			functionItemAction(res) { 
				var index = res.currentTarget.dataset.index
				if (index == 1) {
					uni.navigateTo({
						url: "./modifyname/modifyname"
					}) 
				}
			}, 
		},
		onShow() {
			this.account = this.util.userInfo() 
			// 这行代码作用是：修改昵称成功后，回到这个页面更新昵称
			this.nickname = this.util.userInfo().nickname 
		} 
	}
</script>

<style>
	@import url("../mine/minepage.css");
	@import url("personalinfo.css"); 
</style>
