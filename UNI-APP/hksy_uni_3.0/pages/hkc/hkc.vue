<template>
	<view class="main-body mian_wrap">
		<view class="top_data">
			<view class="top_wrap">
				<view class="box">
					<view class="num">
						<view class="data_num" id="data_num">{{userInfo.reviceCoin ? userInfo.reviceCoin : '0.00'}}</view>
						<view class="title_data">HKC</view>
					</view>
					<view class="hkc_p_wrap">
						<view class="hkc_pao_data">
							<view class="hkc_pao " :class="['hkc_pao'+index,{slide:isSlides[index]}]" v-for="(pao_item,index) in pao_data"
							 @tap="paoClick(pao_item,index)">
								<view class="hkc_pao_box"><text>{{ pao_item.amount }}</text></view>
								<view class="hkc_text">HKC</view>
							</view>
						</view>
					</view>
				</view>
			</view>
			<view class="hkc_no">
				<text v-if="userInfo.hashrate-10 < 0">当前算力不足10T，无法享受HKC收益</text>
				<text v-else class="hashrate_text">我的算力 : {{ userInfo.hashrate }} T</text>
			</view>
		</view>
		<view class="hkc_btn_box">
			<view class="hkc_exchange" @tap="goTransfers">HKC互转</view>
			<view class="hkc_inter_transformation" @tap="conversion">HKC兑换</view>
		</view>
		<view class="hkc_circumstances">
			<view class="hkc_circumstances_s">
				<text>累计已送 : {{ userInfo.haveToDig ? userInfo.haveToDig : '0.00' }} HKC</text>
			</view>
			<view class="hkc_circumstances_c">
				<text>已兑换 : {{ userInfo.hkcStorage ? userInfo.hkcStorage : '0' }} T</text>
			</view>
		</view>
		<!-- 释放周期 -->
		<view class="hkc_period">
			<view class="hck_release">释放周期</view>
			<view class="hkc_hck_release_num">
				<text>已释放 </text>
				<text class="hkc_hck_release_num_text">{{ proportion ? proportion + '%': '0%' }}</text>
			</view>
			<view class="hkc_position">
				<!-- 图表 -->
				<view class="qiun-charts">
					<text class="qiun-charts0">0%</text>
					<text class="qiun-charts100">100%</text>
					<div class="c_top"></div>
					<view class="c">
						<view class="c_m"></view>
						<!-- 中心点 -->
						<view class="z" :style="styleObj">
							<view class="zhuan_z"></view>
							<view class="yuan">
								<view class="yuan_c"></view>
							</view>
						</view>
						<view class="zhuan" :style="styleObj2">
							<view class="zhuan_1"></view>
							<view class="zhuan_2"></view>
						</view>
					</view>
				</view>
			</view>
		</view>
		<view class="hkc_historic_records" @tap="goHistory(0)">
			<text class="hkc_history_text">HKC收取记录</text>
			<image class="img_right" src="../../static/images/right_arrow@3x.png" mode=""></image>
		</view>
		<view class="hkc_historic_records" @tap="goHistory(1)">
			<text class="hkc_history_text">HKC兑换明细</text>
			<image class="img_right" src="../../static/images/right_arrow@3x.png" mode=""></image>
		</view>
		
		<uni-popup type="bottom" ref="buypopup">
			<!-- v-on:selectData="selectData" -->
			<conversion :detail="detail" :colseAction="closeBuypopup" :buyAction="buyAction"></conversion>
		</uni-popup>
		<!-- 密码框 -->
		<uni-popup type="bottom" ref="paycodepopup">
			<paycodeinput :colseAction="closePaycodepopup" :Details="Details" :completeAction="completePaycode"></paycodeinput>
		</uni-popup>
		
		<uni-popup type="bottom" ref="pw">
			<best-password  :show="showshare" :Details="Details" :value="paymentPwd" :forget="false" digits="6" @submit="finish" @cancel="togglePayment"></best-password>
		</uni-popup>
		
		<uni-popup ref="feimaalert" type="center">
			<alertview title="温馨提示" :content="alertContent" showCancel="false" confirmTitle="确定" isCertification=true :cancelAction="closePopup"
			 :confirmAction="closePopup"></alertview>
		</uni-popup>
		 
	</view>
</template>

<script>
	import alertview from "../../components/hksy-uni-alertview/hksy-uni-alertview.vue";
	import uniPopup from "../../components/uni-popup/uni-popup.vue";
	import conversion from "./conversion/conversion.vue";
	import paycodeinput from "../account/paycodefunction/paycodeinput.vue";
	import publicAPI from '../../public/public.js';
	import api from "./api/hkcApi.js";
	import networking from "../../public/networking.js";
	import bestPassword from '@/components/best-password/best-password.vue';
	
	var _self;
	var canvaGauge = null;
	export default {
		components:{
			uniPopup,
			conversion,
			paycodeinput,
			alertview,
			bestPassword
		},
		data() {
			return {
				showshare:true,
				paymentPwd:'',
				pao_data: [],
				isSlides: [false, false, false, false, false, false],
				off: true,
				userInfo: {},
				proportion: 0,
				Details:'',
				alertContent:'  对不起，你的HKC不够兑换存储器， 请继续努力！。',
				detail:{},
				hashrate:0,
				selectHkcRate:0,
				styleObj: {
					position: 'absolute',
					left: '-0rpx',
					top: '0rpx',
					right: '0',
					bottom: '0',
					margin: 'auto',
					width: '0rpx',
					height: '0rpx',
					backgroundColor: '#151936',
					zIndex: 15,
					borderRadius: '50%',
					transition: 'all 1s',
					transform: 'rotate(0deg)'
				},
				styleObj2: {
					position: 'absolute',
					left: '-2.5rpx',
					top: '0rpx',
					right: '0',
					bottom: '0',
					margin: 'auto',
					width: '0px',
					height: '0px',
					backgroundColor: 'red',
					zIndex: 5,
					borderRadius: '50%',
					transition: 'all 1s',
					transform: 'rotate(0deg)'
				},
				num: 0,
				gNum: 0
			}
		},
		onHide() {
			uni.$emit(this.kAccountRefresh, null)
		},
		onLoad() {
			let that = this;
			uni.$on('selectData',function(data){
				that.selectHkcRate = data.value*data.hashrate_item;
				that.Details = that.selectHkcRate + " HKC";
				console.log(that.Details)
			})
			
		}, 
		onShow() {
			_self = this;
			this.cWidth = uni.upx2px(750);
			this.cHeight = uni.upx2px(500);
			this.getNoChargerHkc();
			this.getUserHkc();
		},
		created() {
			
		},
		onNavigationBarButtonTap(e) { // 右侧顶部导航按钮
		   uni.navigateTo({
				url:'hkc_rule/hkc_rule'
		   })	 
		},
		methods: {
			finish(val){
				this.completePaycode(val)
				this.togglePayment()
			},
			togglePayment(){
				// this.showshare = false;
				this.$refs.pw.close()
			},
			closePopup(){
				this.$refs.feimaalert.close()
			},
			completePaycode(val){
				let param = {
					"userId": publicAPI.userID(),
					"paymentCode":val,
					"hkcRate":this.selectHkcRate
				}
				// console.log(param)
				api.exchangeTNumber(param,(res)=>{
					// console.log(res)
					// 兑换成功跳转到成功页面
					if(res == '兑换成功'){
						uni.navigateTo({
							url:"hkc_finish/hkc_finish"
						})
					}else{
						this.$refs.pw.close()
					}
				})
			},
			closePaycodepopup() {
				this.$refs.paycodepopup.close()
			},
			buyAction(){
				let userInfo = publicAPI.userInfo();
				this.closeBuypopup();
				// console.log('兑换',userInfo)
				// 判断有支付密码
				if(!userInfo.paymentCode){
					uni.showToast({
						title:"您还没有设置支付密码，请尽快设置支付密码!",
						icon:'none'
					})
					return false;
				}
				// 判断可以兑换
				if(this.userInfo.reviceCoin - this.selectHkcRate < 0){
					// uni.showToast({
					// 	title:"对不起，您的HKC不够兑换存储器，请继续努力!",
					// 	icon:'none'
					// })
					this.$refs.feimaalert.open()
					return false;
				}
				setTimeout(()=>{
					// this.$refs.paycodepopup.open()
					this.$refs.pw.open()
				},400)
			},
			closeBuypopup() {
				this.$refs.buypopup.close()
			},
			goHistory(index) {
				if(index==0){
					uni.navigateTo({
						url:"hkc_history/hkc_history"
					})
				}else{
					uni.navigateTo({
						url:"hkc_details/hkc_details"
					})
				}
			},
			conversion() {
				// 去兑换
				let hkcRate = this.userInfo.reviceCoin;
				let _this = this;
				let param = {
					"userId": publicAPI.userID(),
					"reviceCoin": hkcRate
				}
				networking.request_class("/hkcExchange",param,(res)=>{
					// console.log(res)
					if(res.statusCode==200){
						if(!res.data.data){
							this.alertContent = '  ' + res.data.msg;
							this.$refs.feimaalert.open();
						}else{
							this.detail = res.data.data;
							this.hashrate = res.data.data.hashrate;
							this.selectHkcRate = res.data.data.hashrate;
							this.Details = this.hashrate + " HKC";
							this.$refs.buypopup.open();
						}
					}
					
				})
			},
			goTransfers() {
				// 去互转
				uni.navigateTo({
					url:"./hkc_transformation/hkc_transformation?reviceCoin=" + this.userInfo.reviceCoin
				})
			},
			changeDeg(data) {
				this.gNum = Math.round(data * 1.8);
				if(this.gNum >= 180){
					this.gNum = 180
				}
				
				this.styleObj.transform = 'rotate(' + this.gNum + 'deg)';
				this.styleObj2.transform = 'rotate(' + this.gNum + 'deg)';
			},
			getNoChargerHkc() {
				let userId = publicAPI.userID();
				api.getNoChargerHkc(userId, (res) => {
					if (!res) {
						// console.log('获取数据为空', res)
					} else {
						this.pao_data = [];
						if (Object.prototype.toString.call(res).indexOf('Array') !== -1) {
							this.pao_data = res.slice(0, 6);
						}else{
							console.log('返回的数据不是数组类型:',res)
						}
					}
				})
			},
			getUserHkc() { // 用户数据
				let userId = publicAPI.userID();
				api.getUserHkc(userId, (res) => {
					console.log('用户HKC',res)
					let hkcQ_num = 0;
					let pro_num = 0;
					this.userInfo = res;
					if (this.userInfo.reviceCoin == 0) {
						hkcQ_num = 0;
						pro_num = 0;
					} else {
						if(!this.userInfo.haveToDig || !this.userInfo.havaCoin){
							hkcQ_num = 0;
						}else{
							hkcQ_num = parseFloat((this.userInfo.haveToDig / this.userInfo.havaCoin) * 100);
						}
						pro_num = hkcQ_num.toFixed(2); // 24.23 + '%'
					}
					
					// 比例
					this.proportion = pro_num;
					
					this.changeDeg(this.proportion)
					
				})


			},
			chargerHkc(pao_item) {
				let hkcId = pao_item.id;
				// console.log(hkcId)
				
				let param = {
					"userId": publicAPI.userID(),
					"hkcId": hkcId
				}
				api.chargerHkc(param, (res) => {
					console.log(res)
					this.getUserHkc();
					this.getNoChargerHkc();
				})
			},
			paoClick(pao_item, index) {
				if (!this.off) {
					return false;
				}
				if (this.off) {
					this.off = false;
					this.isSlides.splice(index, 1, true);
					// console.log(pao_item, index, this.isSlides[index])
					this.chargerHkc(pao_item)
					setTimeout(() => {
						this.isSlides.splice(0, 1, false);
						for (let i = 0; i < this.isSlides.length; i++) {
							this.isSlides.splice(i, 1, false);
						}
						this.off = true;
					}, 400)
				}

			}
		}
	}
</script>

<style scoped>
	@import url("hkc.css");
</style>
