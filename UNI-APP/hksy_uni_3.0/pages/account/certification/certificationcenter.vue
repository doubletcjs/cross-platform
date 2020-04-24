<template>
	<view class="main-body">
		<view class="main-body-sub">
			<centerheader :account="account"></centerheader>
			<view class="mine-page-cell-section-wapper">
				<view class="mine-page-cell-wapper" v-for="(item, index) in certifications" :key="index" style="height: 123rpx;"
				 :data-index="index" @tap="functionItemAction" :style="bottomLine(index, certifications)">
					<view class="mine-page-cell-only-text">
						{{item}}
					</view>
					<view class="mine-page-cell-accessory-wapper">
						<view class="certification-center-cell-text">
							{{statusString}}
						</view>
						<image src="/static/images/right_arrow@3x.png" class="mine-page-cell-arrow"></image>
					</view>
				</view>
			</view>

			<uni-popup type="bottom" ref="certificationpopup">
				<actionsheet :titles="actionSheetTitles" :titleAction="actionSheetTitleAction" :showCancel="true"></actionsheet>
			</uni-popup>
		</view>
	</view>
</template>

<script>
	import centerheader from "./certificationcenterheader.vue"
	import actionsheet from "../../../components/hksy-uni-actionsheet/hksy-uni-actionsheet.vue"
	import uniPopup from "../../../components/uni-popup/uni-popup.vue"

	export default {
		data() {
			return {
				certifications: ["实名信息", "身份验证"],
				account: this.util.userInfo(),
				statusString: this.util.userInfo().personalStatus == 0 ? "未完善" : "已上传",
				actionSheetTitles: ["大陆身份证", "其它证件"]
			}
		},
		methods: {
			functionItemAction(res) {
				var index = res.currentTarget.dataset.index
				var item = this.certifications[index]
				if (item == "实名信息") {
					if (this.account.personalStatus == 0) {
						uni.showToast({
							title: "未实名",
							icon: "none"
						})
					} else {
						uni.navigateTo({
							url: "./certificationinfo"
						})
					}
				} else if (item == "身份验证") {
					if (this.account.personalStatus == 1) { //  1 已实名认证
						uni.showToast({
							title: "已实名认证",
							icon: "none"
						})
					} else {
						this.$refs.certificationpopup.open()
					}
				}
			},
			bottomLine(index, list) {
				if (index == list.length - 1) {
					return ""
				} else {
					return "border-bottom: solid 2rpx rgba(21, 25, 54, 1); "
				}
			},
			actionSheetTitleAction(index) {
				if (index == -1) {
					this.$refs.certificationpopup.close()
				} else {
					var certificationType = index
					//0 身份证验证 1 其它证件验证
					uni.navigateTo({
						url: "./main/certificationmain?certificationType=" + certificationType
					})

					this.$refs.certificationpopup.close()
				}
			}
		},
		components: {
			centerheader,
			uniPopup,
			actionsheet
		},
		onShow() {
			this.account = this.util.userInfo()
			this.statusString = this.account.personalStatus == 0 ? "未完善" : "已上传"
		}
	}
</script>

<style>
	@import url("../../mine/minepage.css");
	@import url("./certificationcenterheader.css");
</style>
