<template>
	<view class="main-body" style="background-color: rgba(247, 246, 245, 1);">
		<!-- 顶部按钮栏 -->
		<view class="create-title-bar">
			<!-- 返回 -->
			<view class="create-title-back-row" @click="backAction">
				<image src="/static/images/base_back@3x.png" mode="" class="create-title-arrow" style="margin-right: 16rpx;"></image>
				<view class="create-title-back">
					返回
				</view>
			</view>
			<view class="create-title">
				角落详情
			</view>
			<!-- 分享 -->
			<image src="/static/images/detail_share@3x.png" mode="" class="detail-share" @click="shareAction"></image>
		</view>
		<view class="detail-content">
			<!-- 基本信息 -->
			<view class="detail-info-content">
				<!-- logo -->
				<image src="" mode="" class="detail-info-logo"></image>
				<!-- 标题 -->
				<view class="detail-info-name">
					每日一食记
				</view>
				<view class="detail-info-row">
					<!-- id -->
					<view class="detail-info-id">
						ID:1234658
					</view>
					<!-- 分类 -->
					<view class="detail-info-classify">
						生活
					</view>
				</view>
				<!-- 简介 -->
				<view class="detail-introduction-row">
					<view class="detail-introduction-tip">
						简介
					</view>
					<view class="detail-introduction">
						相濡以滋味，相忘于江湖，每一个制造和享用美食的人无不经历江湖夜雨，期待桃李春风。
					</view>
				</view>
			</view>
			<!-- 博主 -->
			<view class="detail-blogger-content">
				<!-- 头像 -->
				<image src="" mode="" class="detail-blogger-avatar"></image>
				<!-- 名称 -->
				<view class="detail-blogger-name">
					落主：{{'红鱼'}}
				</view>
			</view>
			<!-- cell -->
			<view class="detail-item-cell-section">
				<!-- 资料 -->
				<view class="detail-item-cell" v-if="normalMember == false" @click="editAction">
					<view class="detail-item-cell-name">
						编辑资料
					</view>
					<view class="detail-item-cell-row">
						<view class="detail-item-cell-value">
							每日一食记
						</view>
						<image src="/static/images/detail_arrow@3x.png" mode="" class="detail-item-cell-arrow"></image>
					</view>
				</view>
				<!-- 成员 -->
				<view class="detail-item-cell" @click="memberAction">
					<view class="detail-item-cell-name">
						角落成员
					</view>
					<view class="detail-item-cell-row">
						<!-- 成员 -->
						<view class="detail-item-cell-member-content">
							<image :src="item" mode="aspectFill" class="detail-item-cell-member" v-for="(item, index) in members" :key="index"
							 :style="index > 0 ? 'margin-left: -28rpx;' : ''">

							</image>
						</view>
						<view class="detail-item-cell-value">
							23361人
						</view>
						<image src="/static/images/detail_arrow@3x.png" mode="" class="detail-item-cell-arrow"></image>
					</view>
				</view>
				<!-- 新申请 -->
				<view class="detail-item-cell" v-if="normalMember == false" @click="applyAction">
					<view class="detail-item-cell-name">
						新的申请
					</view>
					<view class="detail-item-cell-row">
						<view class="detail-item-cell-number-red">
							1
						</view>
						<image src="/static/images/detail_arrow@3x.png" mode="" class="detail-item-cell-arrow"></image>
					</view>
				</view>
			</view>
			<!-- 更新提示 -->
			<view class="detail-update-alert-content">
				<view class="detail-update-alert-name">
					动态更新提示
				</view>
				<view class="detail-update-alert-value">
					关闭后，只有@你的消息才会提示
				</view>
				<switch checked="true" color="rgba(1, 152, 117, 1)" class="detail-update-alert-switch" />
			</view>
			<!-- 退出 -->
			<view class="detail-exist">
				退出角落
			</view>
		</view>
		<!-- 分享 -->
		<share :visible="sharevisible" :closeAction="shareAction" :itemTapAction="shareItemAction" :otherShareItems="otherList"></share>
		<!-- 举报 -->
		<report :visible="reportvisible" :closeAction="reportAction"></report>
	</view>
</template>

<script>
	import share from "./components/detail_share.vue"
	import report from "./components/detail_report.vue"

	export default {
		data() {
			return {
				members: [
					"http://api.cocoachina.com/uploads/200803/2d476347f62ab786f9a90557fc17e7a1.png",
					"http://api.cocoachina.com/uploads/200803/77f1572968682e97d38ba3dc2d4ad469.png",
					"http://api.cocoachina.com/uploads/200803/55f77f7b2d8bcc57e6920341f94805ee.png",
					"https://dss2.bdstatic.com/6Ot1bjeh1BF3odCf/it/u=4043541485,1482392114&fm=85&app=92&f=JPEG?w=121&h=75&s=67D63C9EC4F179924AF8E4EA0300F031",
					"http://api.cocoachina.com/uploads/200803/1cf48ff3dccf9752244cdd86f339e437.png",
					"http://api.cocoachina.com/uploads/200803/5e7e941ec92ac5455f319ce26d29457e.png",
					"http://api.cocoachina.com/uploads/200803/40e66752f9888eda8322ce40df19014c.png",
					"http://api.cocoachina.com/uploads/200803/90f42a1b3abd29b16a8d32017da206fd.png",
				],
				normalMember: false,
				sharevisible: false, //分享
				reportvisible: false, //举报
				otherList: [{
					icon: "/static/images/report_icon@3x.png",
					title: "投诉",
					mark: "report"
				}, ]
			}
		},
		methods: {
			// 返回
			backAction() {
				uni.navigateBack({
					delta: 1
				})
			},
			// 资料编辑
			editAction() {
				uni.navigateTo({
					url: "edit/detail_edit"
				})
			},
			// 成员
			memberAction() {
				uni.navigateTo({
					url: "member/detail_member"
				})
			},
			// 申请
			applyAction() {
				uni.navigateTo({
					url: "apply/detail_apply"
				})
			},
			// 分享
			shareAction() {
				this.sharevisible = !this.sharevisible
			},
			// 分享点击
			shareItemAction(res) {
				console.log(res)
				if (res == "report") {
					var me = this
					setTimeout(function() {
						me.reportAction()
					}, 200)
				}
			},
			// 举报
			reportAction() {
				this.reportvisible = !this.reportvisible
			},
		},
		components: {
			share,
			report
		}
	}
</script>

<style>
	@import url("../create/create_title_bar.css");
	@import url("detail_page.css");
	@import url("detail_base_info.css");
	@import url("detail_blogger.css");
	@import url("detail_item_cell.css");
	@import url("detail_update_alert.css");
</style>
