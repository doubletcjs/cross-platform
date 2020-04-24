<template>
	<view class="order-confirm-body" v-if="product != null">
		<view class="top-title">确认兑换</view>
		<view class="item-list">
			<view class="">可兑换存储器T数</view>
			<view class="pall-box">
				<view class="uni-list-cell-db">
					<picker @change="bindPickerChange" :value="index" :range="array" range-key="name">
						<view class="uni-input">{{array[index].name}}</view>
					</picker>
				</view>
				<view class="pull-down"></view>
			</view>
		</view>
		<view class="item-list">
			<view class="">抵扣HKC算力</view>
			<view class="">
				{{ hashrate_now ? hashrate_now : '0.00' }} HKC
			</view>
		</view>
		<view class="item-list">
			<view class="">当前HKC</view>
			<view class="">
				{{ detail ? detail.reviceCoin : '0.00' }} HKC
			</view>
		</view>
		<view class="btn-box">
			<view class="btn-text"  @tap="colseAction">取消</view>
			<view class="btn-text btn-text-color" @tap="buyAction">{{buyString}}</view>
		</view>
	</view>
</template>

<script>
	export default {
		name:'conversion',
		data() {
			return {
				coin: 0.0,
				product: {},
				buttonStyle: "margin-top: 170rpx;",
				price: 0.0,
				years:[1,2,3],
				index:0,
				hashrate_now:0,
				array: [{name:'华科闪云存储器2T',value:2},{name:'华科闪云存储器6T',value:6}, {name:'华科闪云存储器12T',value:12}],
				visible:false,
				buyString: "立即兑换"
			}
		}, 
		methods: {
			buyFunctionAction() {
				var recharge = false
				if (this.price - this.coin > 0) {
					recharge = true
				}
				// this.$emit('buyAction',recharge)
			},
			bindPickerChange(e){
				let objdata = {
					name:'',
					value:'',
					hashrate_item:''
				}
				let hashrate_item = this.detail.hashrate/2;
				this.index = e.target.value;
				this.hashrate_now = hashrate_item * this.array[this.index].value;
				Object.assign(objdata,this.array[this.index]);
				Object.assign(objdata,{hashrate_item:hashrate_item});
				
				// console.log(objdata)
				uni.$emit("selectData", objdata);
				
			}
		},
		props: {
			detail: null,
			colseAction: Function,
			buyAction: Function
		},
		created() {
		  this.hashrate_now	= this.detail.hashrate
		}
	}
</script>

<style>
	@import url("conversion.css");
</style>
