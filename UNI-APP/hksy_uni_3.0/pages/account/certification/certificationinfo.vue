<template>
	<view class="main-body">
		<view class="main-body-sub" style="margin-top: 0rpx;" v-if="items != null">
			<view class="certification-info-cell-section-wapper">
				<view class="certification-info-cell-wapper" v-for="(item, index) in infoSections" :key="index" :style="bottomLine(index, infoSections)">
					<view class="certification-info-cell-text">
						{{items[index]}}
					</view>
					<view class="certification-info-content">
						{{aInfo[index]}}
					</view>
				</view>
			</view>
			<view class="certification-info-cell-section-wapper">
				<view class="certification-info-cell-wapper" style="height: 123rpx;">
					<view class="certification-info-cell-text">
						{{items[3]}}
					</view>
					<view class="certification-info-content">
						{{aInfo[3]}}
					</view>
				</view>
			</view>
			<view class="certification-info-cell-section-wapper">
				<view class="certification-info-cell-wapper" v-for="(item, index) in bankSections" :key="index" :style="bottomLine(index, bankSections)">
					<view class="certification-info-cell-text">
						{{items[index+4]}}
					</view>
					<view class="certification-info-content">
						{{aInfo[index+4]}}
					</view>
				</view>
			</view>
			<!-- <view class="certification-info-cell-wapper" v-for="(item, index) in items" :key="index" :style="bottomLine(index, item)">
				<view class="certification-info-cell-text">
					{{item}}
				</view>
				<view class="certification-info-content">
					{{aInfo[index]}}
				</view>
			</view> -->
		</view>
	</view>
</template>

<script>
	import accountapi from "../api/accountapi.js"

	export default {
		data() {
			return {
				items: null,
				aInfo: ["", "", "", "", "", "", "", "", "", ""],
				infoSections: ["", "", ""],
				bankSections: ["", "", ""]
			}
		},
		methods: {
			getPersonalInfo() {
				var me = this
				accountapi.getPersonalInfo(this.util.userID(), (data, msg) => {
					if (data != null) {
						me.aInfo[0] = data.realName
						me.aInfo[1] = this.util.validateIDCardNumber(data.idcard) == true ? "身份证" : "其他证件"
						me.aInfo[2] = data.idcard.substr(0, 1) + "**************" + data.idcard.substr(data.idcard.length - 1)
						me.aInfo[3] = data.phone.substr(0, 3) + "****" + data.phone.substr(7)
						me.aInfo[4] = data.bankCard.substr(0, 4) + " ************** " + data.bankCard.substr(data.idcard.length - 6)
						me.aInfo[5] = data.bankName
						me.aInfo[6] = data.bankOfDeposit

						me.items = ["姓名", "证件类型", "证件号码", "实名手机号", "银行卡号", "持卡银行", "开户支行"]
					} else {
						uni.showToast({
							title: msg,
							icon: "none"
						})
					}

					uni.stopPullDownRefresh()
				})
			},
			bottomLine(index, list) {
				if (index == list.length - 1) {
					return ""
				} else {
					return "border-bottom: solid 2rpx rgba(21, 25, 54, 1);"
				}
			}
		},
		created() {
			setTimeout(() => {
				uni.startPullDownRefresh({

				})
			}, 100)
		},
		onPullDownRefresh() {
			this.getPersonalInfo()
		}
	}
</script>

<style>
	@import url("certificationinfo.css");
</style>
