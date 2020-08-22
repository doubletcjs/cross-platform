<!-- 时间选择对话框 -->
<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="selectTime-content" @click.stop="emptyAction">
			<!-- 标题 -->
			<view class="title_wrapper">
				<view class="title_text">请选择时间</view>
				<view class="close_wrapper"><view class="close_text" @click="closePopup">X</view></view>
			</view>

			<view class="tradingHour_title">交易时间</view>
			<view class="th_list_wrapper">
				<view
					:class="selecIndex == index ? 'th_item_text_select' : 'th_item_text'"
					v-for="(item, index) in th_list"
					:key="index"
					:data-index="index"
					@click="selectItemAction"
				>
					{{ item }}
				</view>
			</view>
			<view class="tradingHour_title" style="margin-top: 64rpx;">自定义</view>
			<view class="custom_th_list_wrapper">
				<view :class="timeClick == 0 ? 'custom_th_item_text_select' : 'custom_th_item_text'" @click="selectStartTime">{{ startTime }}</view>
				<view class="custom_line">-</view>
				<view :class="timeClick == 1 ? 'custom_th_item_text_select' : 'custom_th_item_text'" @click="selectEndTime">{{ endTime }}</view>
			</view>
			<!-- 日期选择器 -->
			<picker-view class="picker_wrapper" v-if="timeIsVisible" :indicator-style="indicatorStyle" :value="slectValue" @change="bindChange">
				<picker-view-column>
					<view class="picker_item" v-for="(item, index) in select_years" :key="index">{{ item }}年</view>
				</picker-view-column>
				<picker-view-column>
					<view class="picker_item" v-for="(item, index) in select_months" :key="index">{{ item }}月</view>
				</picker-view-column>
				<picker-view-column>
					<view class="picker_item" v-for="(item, index) in select_days" :key="index">{{ item }}日</view>
				</picker-view-column>
			</picker-view>
			<view class="selectTime_ok" @click="confirmPopup">确认</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		const date = new Date();
		const select_years = [];
		const year = date.getFullYear(); // 获取当前日期对象的年份
		const select_months = [];
		const month = date.getMonth() + 1; // 获取当前时间对象的月份
		const select_days = [];
		const day = date.getDate(); // 获取当前日期对象是几日

		for (let i = 2000; i <= date.getFullYear(); i++) {
			select_years.push(i);
		}

		for (let i = 1; i <= 12; i++) {
			select_months.push(i);
		}

		for (let i = 1; i <= 31; i++) {
			select_days.push(i);
		}

		return {
			select_years,
			year,
			select_months,
			month,
			select_days,
			day,
			slectValue: [9999, month - 1, day - 1],

			th_list: ['近一月', '近三月', '近半年', '近一年'],
			selecIndex: -1,
			startTime: this.util.formatDate(new Date(), 'yyyy年MM月dd日'),
			endTime: this.util.formatDate(new Date(), 'yyyy年MM月dd日'),
			timeIsVisible: false,
			timeClick: -1, // 0 开始时间点击   1 结束时间点击
			/**
			 * 解决动态设置indicator-style不生效的问题
			 */
			indicatorStyle: `height: ${Math.round(uni.getSystemInfoSync().screenWidth / (750 / 100))}px;`
		};
	},
	methods: {
		//关闭alert
		closePopup() {
			this.closeAction();
		},
		emptyAction() {},
		selectItemAction(res) {
			// 交易时间点击
			let index = res.currentTarget.dataset.index;
			this.selecIndex = index;
			this.timeClick = -1;
		},
		confirmPopup() {
			// 点击事件
			console.log("  " + this.selecIndex, " " +this.timeClick);
			if (this.selecIndex > -1) { // 交易时间
				let me = this;
				setTimeout(function() {
					// 回调结果给父组件
					let name = me.th_list[me.selecIndex];
					me.itemTapAction(name);
				}, 100);
				this.closePopup();
			} else if(this.timeClick == 0 || this.timeClick == 1) { // 自定义时间
			
				console.log(" startTime = " + this.startTime + " this.endTime = " + this.endTime);
			
				this.closePopup();
			} else {
				uni.showToast({
					title: "您还没有选择时间",
					icon: "none"
				})
			}
			
		},
		selectStartTime() {
			// let time = this.util.formatDate(new Date(), 'yyyy-MM-dd');
			// console.log(time);
			this.timeIsVisible = true;
			this.timeClick = 0;
			this.selecIndex = -1;
		},
		selectEndTime() {
			this.timeIsVisible = true;
			this.timeClick = 1;
			this.selecIndex = -1;
		},
		bindChange(e) {
			const val = e.detail.value;
			// console.log("val = " +  val);
			// console.log("typeof val = " + typeof val);
			this.year = this.select_years[val[0]];
			this.month = this.select_months[val[1]];
			this.day = this.select_days[val[2]];

			if (this.timeClick == 0) {
				this.startTime = this.year + '年' + this.month + '月' + this.day + '日';
			} else if (this.timeClick == 1) {
				this.endTime = this.year + '年' + this.month + '月' + this.day + '日';
			}
		}
	},
	props: {
		//是否弹出显示
		visible: {
			type: Boolean,
			value: false
		},
		closeAction: Function,
		itemTapAction: Function // 回调结果选择什么时间
	},
	computed: {}
};
</script>

<style>
.i-modal-mask {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 1000;
	/* transition: all 0.2s ease-in-out; */ /* 为了去掉弹出tabs的显示 */
	opacity: 0;
	visibility: hidden;
	width: 100%;
	height: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;

	background-color: rgba(0, 0, 0, 0.4);
}

.i-modal-mask-show {
	opacity: 1;
	visibility: visible;
}

.selectTime-content {
	padding-left: 32rpx;
	padding-right: 32rpx;

	position: fixed;
	bottom: 0;
	left: 0;
	right: 0;

	max-width: 894rpx;
	min-height: 699rpx;
	display: flex;
	flex-direction: column;

	background-color: rgba(255, 255, 255, 1);
	border-radius: 16rpx 16rpx 0rpx 0rpx;
}

.title_wrapper {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
	height: 128rpx;
}

.title_text {
	font-size: 34rpx;
}

.close_wrapper {
	height: 128rpx;
	width: 48rpx;
	color: #707070;
	font-size: 48rpx;
	line-height: 128rpx;
	text-align: right;
}

.tradingHour_title {
	margin-top: 32rpx;
	height: 40rpx;
	font-size: 28rpx;
	line-height: 40rpx;
	color: rgba(50, 50, 50, 1);
}

.th_list_wrapper {
	margin-top: 17rpx;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

.th_item_text {
	width: 23%;
	height: 64rpx;
	background: rgba(255, 255, 255, 1);
	border: 1rpx solid rgba(0, 0, 0, 0.2);
	border-radius: 8rpx;

	font-size: 28rpx;
	line-height: 64rpx;
	text-align: center;
	color: rgba(153, 153, 153, 1);
}

.th_item_text_select {
	width: 23%;
	height: 64rpx;
	background: rgba(235, 102, 91, 1);
	border: 1rpx solid rgba(235, 102, 91, 1);
	border-radius: 8rpx;

	font-size: 28rpx;
	line-height: 64rpx;
	text-align: center;
	color: #ffffff;
}

.custom_th_list_wrapper {
	margin-top: 16rpx;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

.custom_th_item_text {
	width: 100%;
	height: 64rpx;
	background: rgba(247, 246, 245, 1);
	border: 1rpx solid rgba(247, 246, 245, 1);
	border-radius: 8rpx;

	font-size: 28rpx;
	line-height: 64rpx;
	text-align: center;
	color: rgba(153, 153, 153, 1);
}

.custom_th_item_text_select {
	width: 100%;
	height: 64rpx;
	background: rgba(247, 246, 245, 1);
	border: 1rpx solid rgba(235, 102, 91, 1);
	border-radius: 8rpx;

	font-size: 28rpx;
	line-height: 64rpx;
	text-align: center;
	color: rgba(153, 153, 153, 1);
}

.custom_line {
	width: 14rpx;
	height: 64rpx;
	margin-left: 12rpx;
	margin-right: 12rpx;
	font-size: 24rpx;
	line-height: 64rpx;
	text-align: center;
	color: rgba(153, 153, 153, 1);
}

.picker_wrapper {
	margin-top: 35rpx;
	height: 336rpx;
}

.picker_item {
	height: 84rpx;
	line-height: 100rpx;
	font-size: 28rpx;
	text-align: center;
}

.selectTime_ok {
	margin: 65rpx 0rpx 73rpx 0rpx;
	height: 96rpx;
	font-size: 32rpx;
	line-height: 86rpx;
	text-align: center;
	color: #ffffff;
	background: rgba(235, 102, 91, 1);
	border-radius: 8px;
}
</style>
