<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="uni-steps">
				<uni-steps :options="lists" :activeColor="activeColor" :active="active"></uni-steps>
			</view>
			<view class="main-body-sub" v-if="stepPage > 0" style="background-color: white;">
				<stepinfo :certificationType="certificationType" :getInfoModel="getInfoModel" v-if="stepPage == 1"></stepinfo>
				<stepphone v-else-if="stepPage == 2" :getPhoneModel="getPhoneModel"></stepphone>
				<stepbank v-else-if="stepPage == 3" :getBankModel="getBankModel"></stepbank>
			</view>
		</view>
	</view>
</template>

<script>
	import uniSteps from '../../../../components/uni-steps/uni-steps.vue'
	import stepinfo from "./certificateinfo.vue"
	import stepphone from "./certificatephone.vue"
	import stepbank from "./certificatebank.vue"
	import accountapi from "../../api/accountapi.js"
	
	export default {
		data() {
			return {
				activeColor: "#1760FF",
				stepPage: 1,
				certificationType: 0,
				uploadModel: {},
				active: 0,
				lists: [{
					title: '身份认证'
				}, {
					title: '绑定手机'
				}, {
					title: '绑定银行卡'
				}],
				uploading: false
			}
		},
		onLoad(options) {
			this.certificationType = options.certificationType;
			
			let title = "身份证验证";
			if (this.certificationType == 1) {
				title = "其它证件验证"
			}
			
			uni.setNavigationBarTitle({
				title: title
			})
			this.stepPage = 1;
			this.active = this.stepPage - 1;
		},
		components: {
			stepinfo,
			stepphone,
			stepbank,
			uniSteps
		},
		methods: {
			certificateSelect() {
				uni.showActionSheet({
					itemList: ["大陆身份证", "其它证件"],
					complete: (res) => {
						var index = res.tapIndex
						this.certificationType = index
						var title = "身份证验证"
						if (index == 1) {
							title = "其它证件验证"
						}
						uni.setNavigationBarTitle({
							title: title
						})
						this.stepPage = 1
					},
					fail: (res) => {
						this.stepPage = 0
						uni.navigateBack({
							delta: 1
						})
					}
				})
			},
			getInfoModel(info) {
				Object.assign(this.uploadModel, info);
				this.stepPage += 1;
				this.active += 1;
			},
			getPhoneModel(phone) {
				Object.assign(this.uploadModel, phone);
				this.stepPage += 1;
				this.active += 1;
			},
			getBankModel(bank) {
				Object.assign(this.uploadModel, bank)
				this.uploadModel["userId"] = this.util.userID()

				uni.hideKeyboard()
				this.uploadImages()
			},
			uploadImages(completion) {
				uni.showLoading({

				})

				var me = this
				this.networking.functionMultipleUpload([this.uploadModel.identityImgFront, this.uploadModel.identityImgReverse], (
					urlList, msg) => {
					uni.hideLoading()
					if (urlList.length > 0) {
						me.uploadModel.identityImgFront = urlList[0]
						me.uploadModel.identityImgReverse = urlList[1]

						me.submitAction()
					} else {
						uni.showToast({
							title: msg,
							icon: "none"
						})
					}
				})
			},
			submitAction() {
				if (this.uploading == false) {
					this.uploading = true
					uni.showLoading({

					})

					accountapi.authentication(this.uploadModel, (data, msg) => {
						uni.hideLoading()
						if (data != null) {
							uni.showToast({
								title: "认证提交成功",
								icon: "none"
							})

							uni.$emit(this.kAccountRefresh, null)
							setTimeout(() => {
								uni.navigateBack({
									delta: 1
								})
							}, 1600)
						} else {
							uni.showToast({
								title: msg,
								icon: "none"
							})
							this.uploading = false
						}
					})
				}
			}
		},
		created() {

		}
	}
</script>

<style scoped>
	.uni-steps {
		height: 145rpx;
		display: flex;
		background-color: #1C233F;
		padding-top: 26rpx;
		box-sizing: border-box;
		margin-bottom: 20rpx;
	}
</style>
