<template>
	<view class="certificate-info-wapper main-body">
		<view class="main-body-sub">
			<view class="name-box">
				<view v-for="(item, index) in items" :key="index">
					<view class="certificate-info-input-wapper">
						<text class="certificate-info-input-item" space="ensp">{{ item }}</text>
						<!-- 姓名input -->
						<input
							type="text"
							id="name"
							v-model="inputName"
							class="certificate-info-input"
							:placeholder="itemPlaceholders[index]"
							placeholder-class="certificate-info-input-placeholder"
							v-if="index == 0"
						/>
						<!-- 身份证号码input -->
						<input
							type="text"
							id="idcard"
							maxlength="18"
							v-model="inputIdcard"
							@input="changeValue"
							class="certificate-info-input"
							:placeholder="itemPlaceholders[index]"
							placeholder-class="certificate-info-input-placeholder"
							v-else
						/>
						<view class="inputIdcard-box" v-if="index == 1 && certificationType != 1" @tap="textFieldOnChanged"></view>
					</view>
					<!-- 一条线 -->
					<view v-if="index == 0"><view class="certificate-info_input_line" /></view>
				</view>
			</view>
			<view class="msg-box">
				<view class="certificate-info-idcard-tip" v-if="certificationType == 0">拍摄上传您的二代身份证</view>
				<view class="certificate-info-idcard-tip" v-else>拍摄上传您的证件号码</view>
				<view v-for="(imagePath, index) in idCardImages" :key="index">
					<view class="certificate-info-idcard-side" v-if="index == 1" style="margin-bottom: 40rpx;">{{ idCardSides[index] }}</view>
					<view class="certificate-info-idcard-side" v-else>{{ idCardSides[index] }}</view>
					<view class="certificate-info-idcard-image-wapper">
						<view class="certificate-info-idcard-image-box" v-if="index == 0">
							<image id="front" @tap="selectIdcardImage" :src="frontImagePath" mode="aspectFill" class="certificate-info-idcard-image"></image>
							<text v-show="!frontImagePath" class="certificate-info-idcard-image-text">点击上传</text>
						</view>
						<view class="certificate-info-idcard-image-box" v-else>
							<image id="reverse" @tap="selectIdcardImage" :src="reverseImagePath" mode="aspectFill" class="certificate-info-idcard-image"></image>
							<text v-show="!reverseImagePath" class="certificate-info-idcard-image-text">点击上传</text>
						</view>
					</view>
				</view>
			</view>

			<view class="certificate-info-next-sapper" @tap="confirmInfo"><view class="certificate-info-next">下一步</view></view>
		</view>

		<keyboard-package :type="2" @input="inputIdcardValue" ref="keyboard"></keyboard-package>
	</view>
</template>

<script>
import keyboardPackage from '../../../../components/keyboard-package/keyboard-package.vue';

export default {
	data() {
		return {
			frontImagePath: '',
			reverseImagePath: '',
			inputName: '',
			inputIdcard: '',
			idCardImages: ['', ''],
			idCardSides: ['上传正面身份证', '上传反面身份证'],
			items: ['姓      名', '身份证号码'],
			itemPlaceholders: ['请输入真实姓名', '请输入身份证号码']
		};
	},
	components: {
		keyboardPackage
	},
	methods: {
		changeValue(res) {
			var _this = this;
			let value = res.detail.value;
			setTimeout(function() {
				_this.inputIdcard = value
					.replace(/\s/g, '')
					.replace(/[^0-9a-zA-Z]/g, '')
					.toUpperCase();
				if (!_this.inputIdcard) {
					_this.inputIdcard = '';
				}
			}, 50);
		},
		inputIdcardValue(val) {
			console.log(val);
			if (val === '') {
				this.inputIdcard = this.inputIdcard.substr(0, this.inputIdcard.length - 1);
				console.log(this.inputIdcard);
			} else {
				if (this.inputIdcard.length < 18) {
					val = val.toString();
					this.inputIdcard = this.inputIdcard + val;
					console.log(this.inputIdcard);
				}
			}
		},
		textFieldOnChanged(res) {
			// var id = res.target.id
			// var value = res.target.value
			// console.log(this.certificationType,res)
			// // if (id == "name") {
			// // 	this.inputName = value
			// // } else if (id = "idcard") {
			// // 	if(this.certificationType ==1){

			// // 	}else{
			// // 		this.$refs.keyboard.open()
			// // 	}
			// // 	uni.hideKeyboard()
			// // }
			this.$refs.keyboard.open();
		},
		selectIdcardImage(res) {
			var imageId = res.target.id;
			var me = this;
			uni.chooseImage({
				count: 1,
				success: completeRes => {
					var path = completeRes.tempFilePaths[0];
					if (imageId == 'front') {
						me.frontImagePath = path;
					} else if ((imageId = 'reverse')) {
						me.reverseImagePath = path;
					}
				},
				fail(failRes) {
					if (failRes.code != '0') {
						uni.showToast({
							title: failRes.errMsg,
							icon: 'none'
						});
					}
				}
			});
		},
		confirmInfo() {
			if (this.util.emptyObject(this.inputName) == true) {
				uni.showToast({
					title: '请输入姓名',
					icon: 'none'
				});
				return;
			}

			if (this.certificationType == 0) {
				if (this.util.validateIDCardNumber(this.inputIdcard) == false) {
					uni.showToast({
						title: '请输入正确的身份证号',
						icon: 'none'
					});

					return;
				}

				if (this.util.emptyObject(this.frontImagePath) == true) {
					uni.showToast({
						title: '请上传身份证正面图片',
						icon: 'none'
					});

					return;
				}

				if (this.util.emptyObject(this.reverseImagePath) == true) {
					uni.showToast({
						title: '请上传身份证反面图片',
						icon: 'none'
					});

					return;
				}
			} else {
				if (this.util.emptyObject(this.inputIdcard) == true) {
					uni.showToast({
						title: '请输入证件号码',
						icon: 'none'
					});

					return;
				}

				if (this.util.emptyObject(this.frontImagePath) == true) {
					uni.showToast({
						title: '请上传证件正面图片',
						icon: 'none'
					});

					return;
				}

				if (this.util.emptyObject(this.reverseImagePath) == true) {
					uni.showToast({
						title: '请上传证件反面图片',
						icon: 'none'
					});

					return;
				}
			}

			var info = {
				identityImgFront: this.frontImagePath,
				identityImgReverse: this.reverseImagePath,
				name: this.inputName,
				idCard: this.inputIdcard
			};
			this.getInfoModel(info);
		}
	},
	props: {
		certificationType: 0, // 证件类型  0 身份证 1 其它证件
		getInfoModel: Function
	},
	created() {
		if (this.certificationType != 0) {
			this.idCardSides = ['上传正面证件', '上传反面证件'];
			this.items = ['姓    名', '证件号码'];
			this.itemPlaceholders = ['请输入真实姓名', '请输入证件号码'];
		}
	}
};
</script>

<style>
@import url('certificateinfo.css');
</style>
