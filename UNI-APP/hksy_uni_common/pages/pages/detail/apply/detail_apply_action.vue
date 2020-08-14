<template>
	<view>
		<!-- 用户信息 -->
		<view class="detail-apply-action-info">
			<!-- 头像 -->
			<image :src="account['avatar']" mode="" class="detail-apply-action-avatar"></image>
			<!-- 昵称、地区 -->
			<view class="detail-apply-action-account">
				<view class="detail-apply-action-name">
					{{account['name']}}
				</view>
				<view class="detail-apply-action-area">
					地区：{{account['area']}}
				</view>
			</view>
		</view>
		<!-- 加入说明 -->
		<view class="detail-apply-action-content-mask">
			<view class="detail-apply-action-content">
				{{account['content']}}
			</view>
		</view>
		<!-- 黑名单 -->
		<view class="detail-apply-action-blocked" v-if="account['block'] == true">
			<image src="/static/images/block_list_alert@3x.png" mode="" class="detail-apply-action-blocked-icon"></image>
			<view class="detail-apply-action-blocked-content">
				已添加至黑名单，你将不再收到对方的申请消息
			</view>
		</view>
		<!-- status: 0, //0 未处理 1 忽略 2 同意 -->
		<view class="detail-apply-action-column" v-else>
			<view v-if="account['status'] == 0">
				<view class="detail-apply-action-agree" @click="agreeAction">
					同意
				</view>
				<view class="detail-apply-action-ignore" @click="ignoreAction">
					忽略
				</view>
			</view>
			<view v-else-if="account['status'] == 2">
				<view class="detail-apply-action-agree-disable">
					已同意
				</view>
			</view>
			<view v-else-if="account['status'] == 1">
				<view class="detail-apply-action-refuse">
					已忽略
				</view>
			</view>
		</view>
		<!-- 添加、移出黑名单 -->
		<view class="detail-apply-action-block-action" v-if="account['status'] != 2">
			<view class="detail-apply-action-block" @click="blockListHandle">
				{{account['block'] == true ? '移出黑名单' : '加入黑名单'}}
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				account: {}
			}
		},
		methods: {
			//黑名单
			blockListHandle() {
				if (this.account["block"] == true) {
					this.account["block"] = false
					this.handleAccount()
				} else {
					var me = this
					uni.showModal({
						title: "加入黑名单，将不再收到对方的申请信息",
						cancelText: "确认",
						confirmText: "取消",
						cancelColor: "#EB665B",
						confirmColor: "#323232",
						complete(res) {
							if (res.cancel == true) {
								me.account["block"] = true
								this.handleAccount()
							}
						},
						fail(error) {

						}
					})
				}
			},
			//忽略
			ignoreAction() {
				this.account["status"] = 1
				this.handleAccount()
			},
			//同意
			agreeAction() {
				this.account["status"] = 2
				this.handleAccount()
			},
			//处理回调
			handleAccount() {
				var pages = getCurrentPages()
				var prePage = pages[pages.length - 2]
				prePage.edittingItem = this.account
			}
		},
		onLoad(res) {
			if (res["account"] != null) {
				this.account = JSON.parse(res["account"])
			}
		}
	}
</script>

<style>
	@import url("detail_apply_action.css");
</style>
