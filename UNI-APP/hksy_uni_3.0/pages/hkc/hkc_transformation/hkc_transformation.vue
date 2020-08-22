<template>
	<view class="main-body mian_wrap">
		<view class="main-body-sub">
			<view class="hkc_transformation">
				<view class="hkc_num">
					<text>可用HKC</text>
					<text>{{ allHKC ? allHKC : '0.00' }} HKC</text>
				</view>
				<view class="hkc_change">
					<view class="hkc_change_top">
						转出HKC
					</view>
					<view class="hkc_change_center">
						<input type="number" maxlength="30" v-model="hkc" class="hkc_change_center_input" placeholder-class="input-placeholder"
						 :placeholder="ph" />
						<text class="all" @tap="all">全部转出</text>
					</view>
					<view class="hkc_input_line" />
					<view class="hkc_change_bottom">
						<text>对方账号</text>
						<input type="number" maxlength="11" :focus="off" v-model="phone" class="hkc_change_bottom_input"
						 placeholder-class="input-placeholder" placeholder="请输入对方账号" />
					</view>
				</view>
				<view class="btn-box" id="ListConS">
					<!-- <button @tap="to_hkc_transformation" type="default" class="btn-btn">确认转出</button>
					 <button type="primary">4545456</button> -->
					<view @tap="to_hkc_transformation" class="btn-btn">确认转出</view>
				</view>
			</view>
		</view>

		<uni-popup ref="alertTip" type="center">
			<alertview title="温馨提示" :content="content" isCertification=true confirmTitle="确定" :cancelAction="closePopup"
			 :confirmAction="confirmAction"></alertview>
		</uni-popup>

	</view>
</template>

<script>
	import networking from "../../../public/networking.js";
	import publicAPI from '../../../public/public.js';
	import alertview from "../../../components/hksy-uni-alertview/hksy-uni-alertview.vue";
	export default {
		components: {
			alertview
		},
		data() {
			return {
				hkc: "",
				allHKC: 0,
				hkcText: '',
				ph: '',
				phone: '',
				off: false,
				Onoff: true,
				content: ''
			}
		},
		onLoad(option) {
			// console.log(option)
			this.allHKC = option.reviceCoin;
			this.allHKC = this.allHKC ? this.allHKC : '0.00';
			this.ph = '可转出 ' + this.allHKC + ' HKC';


			let _this = this;
			uni.getSystemInfo({
				success: function(res) {
					console.log(res.pixelRatio);
					console.log(res.windowHeight);
					const query = uni.createSelectorQuery()
					query.select('#ListConS').boundingClientRect()
					query.selectViewport().scrollOffset()

					query.exec(function(res) {

						console.log('打印demo的元素的信息', res);

					})

				}
			});



		},
		onNavigationBarButtonTap(e) { // 右侧顶部导航按钮
			uni.navigateTo({
				url: '../hkc_rule/hkc_rule'
			})
		},
		methods: {
			all() {
				this.hkc = this.allHKC;
			},
			closePopup() {
				this.$refs.alertTip.close();
			},
			confirmAction() {
				this.$refs.alertTip.close();

				let param = {
					"userId": publicAPI.userID(),
					"amount": this.hkc,
					"phone": this.phone
				}
				networking.request_class("/getMutualTransfer", param, (res) => {
					if (res.statusCode == 200) {
						if (res.data.data) { 
							uni.navigateTo({
								url: '../hkc_transformation_finish/hkc_transformation_finish'
							})
						} else {
							uni.showToast({
								title: res.data.msg,
								icon: 'none'
							})
							this.phone = '';
						}
					} else {
						uni.showToast({
							title: res.data.msg,
							icon: 'none'
						})
						this.phone = '';
					}
				})
			},
			to_hkc_transformation() {
				// 互转数量不能为空
				let myreg = /^1[3|4|5|6|7|8|9][0-9]{9}$/;

				if (!this.hkc) {
					uni.showToast({
						title: '互转数量不能为空',
						icon: 'none'
					})
					return false;
				}
				// 互转数量必须大于0
				if (this.hkc <= 0) {
					uni.showToast({
						title: '互转数量必须大于0',
						icon: 'none'
					})
					return false;
				}
				if (!this.phone) {
					uni.showToast({
						title: '请输入正确的用户账号',
						icon: 'none'
					})
					return false;
				}
				// 请输入正确的用户账号
				if (!myreg.test(this.phone)) {
					uni.showToast({
						title: '请输入正确的用户账号',
						icon: 'none'
					})
					return false;
				}

				// 互转操作

				this.content = "是否确认给" + this.phone + "用户转帐 " + this.hkc + " HKC？";
				this.$refs.alertTip.open();

				// uni.showModal({
				// 	content:"是否确认给"+this.phone+"用户转帐 "+this.hkc+" HKC？",
				// 	success(res) {
				// 		if(res.confirm){
				// 			networking.request_class("/getMutualTransfer",param,(res)=>{
				// 				console.log(res)
				// 				if(res.statusCode==200 && res.data.state==200){
				// 					uni.navigateTo({
				// 						url:'../hkc_transformation_finish/hkc_transformation_finish'
				// 					})
				// 				}else{
				// 					uni.showModal({
				// 						content:res.data.msg,
				// 						showCancel:false
				// 					})
				// 					this.phone = '';
				// 					this.off = true;
				// 				}
				// 			})
				// 		}else{

				// 		}
				// 	}
				// })

			}
		}
	}
</script>

<style>
	@import url("./hkc_transformation.css");
</style>
