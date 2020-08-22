<!-- 金币账单 -->
<template>
	<view class="main-body">
		<view class="time_select_wrapper">
			<view class="time_text" @click="OCPSelectTimeDialog">2020.07.01-2020.07.15</view>
			<image class="arrows" @click="OCPSelectTimeDialog" src="../../../../../static/images/arrows_down@2x.png" mode="aspectFit"></image>
		</view>
		<view class="info_wrapper">
			<view class="info_up_wrapper">
				<view class="info_up_text">收入</view>
				<view class="info_up_text">支出</view>
			</view>
			<view class="info_down_wrapper">
				<view class="info_down_text">
					1000
					<span class="info_down_text_span">金</span>
				</view>
				<view class="info_down_text">
					900
					<span class="info_down_text_span">金</span>
				</view>
			</view>
		</view>
		<!-- tabbar -->
		<view class="list-content">
			<view :class="tabSticky == true ? 'tab-bar tab-bar-sticky' : 'tab-bar'" :style="selectTimeDialogVisible ? 'z-index: 0;' : 'z-index: 1500;'">
				<view
					v-for="(item, index) in tabs"
					:key="index"
					:class="tabIndex == index ? 'tab-bar-title tab-bar-title-select' : 'tab-bar-title'"
					:data-index="index"
					@click="tabSelectAction"
				>
					{{ item }}

					<!-- indicator -->
					<view class="tab-bar-indicator-mask"><view class="tab-bar-indicator" :style="tabIndex == index ? 'background-color: rgba(235, 102, 91, 1);' : ''"></view></view>
				</view>
			</view>
			<!-- 列表内容，根据标题tab index 显示不用页面 -->
			<tabsAll v-if="tabIndex == 0"></tabsAll>
			<tabsLive v-else-if="tabIndex == 1"></tabsLive>
			<tabsDynamic v-else-if="tabIndex == 2"></tabsDynamic>
		</view>

		<!-- 顶部栏 -->
<!-- 		<view
			class="top-actions"
			style="position: fixed; top: 0rpx; left: 0; right: 0; height: calc(var(--status-bar-height) + 128rpx); overflow: hidden; z-index: 1500; "
			v-if="tabSticky == true"
		>
			<view class="time_select_wrapper" style="margin-top: 60rpx;">
				<view class="time_text">2020.07.01-2020.07.15</view>
				<image class="arrows" src="../../../../../static/images/arrows_down@2x.png" mode="aspectFit"></image>
			</view>
		</view> -->
		
		<!-- 选择时间对话框 -->
		<selectTimeDialog :visible="selectTimeDialogVisible" :closeAction="OCPSelectTimeDialog" :itemTapAction="selectTimeAction"></selectTimeDialog>
		
	</view>
</template>

<script>
import tabsAll from './tabs_all.vue';
import tabsLive from './tabs_live.vue';
import tabsDynamic from './tabs_dynamic.vue';
import selectTimeDialog from '../components/selectTimeDialog.vue';
export default {
	data() {
		return {
			tabSticky: false,
			tabTop: 0,
			scrollTop: 0,
			tabIndex: 0,
			tabs: ['全部', '直播', '动态'],
			selectTimeDialogVisible: false
		};
	},
	methods: {
		// 打开和关闭选择选择时间对话框
		OCPSelectTimeDialog() {
			this.selectTimeDialogVisible = !this.selectTimeDialogVisible
		},
		//tab点击
		tabSelectAction(res) {
			var index = res.currentTarget.dataset.index;
			this.tabIndex = index;
		},
		selectTimeAction(res) {
			console.log("res " + res);
		}
	},
	components: {
		tabsAll,
		tabsLive,
		tabsDynamic,
		selectTimeDialog
	},
	// onPageScroll(res) {
	// 	this.scrollTop = res.scrollTop
	// 	if (this.tabTop - res.scrollTop <= 128 / 2) {
	// 		this.tabSticky = true
	// 	} else {
	// 		this.tabSticky = false
	// 	}
	// },
	// onReady() {
	// 	var me = this
	// 	let selector = uni.createSelectorQuery().select('.tab-bar');
	// 	selector.boundingClientRect(function(data) {
	// 		me.tabTop = data.top
	// 	}).exec(function() {
	
	// 	})
	// }
};
</script>

<style>
@import url('coinBill.css');
</style>
