<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="title">
				<view class="title-date view">日期</view>
				<view class="title-num view">数量</view>
				<view class="title-status  view">状态</view>
			</view>
			<view class="content-box">
				<view class="no-data" v-if="nodata">
					<nodata msg="暂无记录"></nodata>
				</view>
				<view class="content-item" v-for="(hkcdetail_item,index) in hkcdetail" :key="index">
					<view class="content-item-date">{{ getTime(hkcdetail_item) }}</view>
					<view class="content-item-num">{{ hkcdetail_item.amount }}</view>
					<view class="content-item-status/">{{ hkcdetail_item.type == 1 ? "已收取" : "未收取" }}</view>
				</view>
			</view>
			<view style="width: 100%; background-color: rgba(21, 25, 54, 1);" v-if="hkcdetail.length > 0">
				<uni-load-more iconType="auto" :status="moreStatus" :contentText="this.util.moreContentText" @clickLoadMore="loadMoreData"></uni-load-more>
			</view>
		</view>
	</view>
</template>

<script>
	import nodata from '../../coin/componet/nodata.vue';
	import publicAPI from '../../../public/public.js';
	import networking from "../../../public/networking.js";
	import uniLoadMore from "../../../components/uni-load-more/uni-load-more.vue"
	export default {
		components:{
			uniLoadMore,
			nodata
		},
		data() {
			return {
				hkcdetail:[],
				page:1,
				limit:20,
				moreStatus:"more",
				nodata:false
			}
		},
		onLoad() {
			this.getUserHkcDetail(this.page)
		},
		onNavigationBarButtonTap(e) { // 右侧顶部导航按钮
		   uni.navigateTo({
				url:'../hkc_rule/hkc_rule'
		   })	 
		},
		methods: {
			onPullDownRefresh(){
				uni.stopPullDownRefresh()
			},
			onReachBottom(e){
				
			},
			loadMoreData(){
				this.page = this.page + 1;
				this.getUserHkcDetail(this.page)
			},
			getTime(data){
				if(!data) {
					return false;
				}
				return data.createTime.split(" ")[0]
			},
			getUserHkcDetail(page){
				let param = {
					userId : publicAPI.userID(),
					page:page,
					limit:this.limit
				}
				networking.functionRequest("/getUserHkcDetail", null, param, null, (res)=>{
					// console.log(res)
					let _this = this;
					if(res.records.length > 0){
						res.records.forEach(function(value){
							_this.hkcdetail.push(value);
						})
					}else{
						this.moreStatus = "noMore"
					}
					if(!this.hkcdetail.length){
						this.nodata = true;
					}
					uni.stopPullDownRefresh()
				})
			}
		}
	}
</script>

<style>
	@import url("hkc_history.css");
</style>
