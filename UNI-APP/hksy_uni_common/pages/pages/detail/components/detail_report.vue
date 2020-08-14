<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="report-content" @click.stop="emptyAction">
			<!-- 标题 -->
			<view class="report-title">
				投诉
			</view>
			<!-- 内容 -->
			<view class="report-classify-content">
				<view class="report-classify-item-content">
					<view :class="reportIndex == index ? 'report-classify-item-select' : 'report-classify-item'" v-for="(item, index) in reportList"
					 :key="index" :style="index % 3 == 0 ? '' : 'margin-left: 47rpx;'" :data-index="index" @click="selectClassifyAction">
						{{item}}
					</view>
				</view>
			</view>
			<!-- 关闭 -->
			<view class="report-cancel" @click="closePopup">
				取消
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				reportList: [
					"敏感时政",
					"垃圾广告",
					"人身攻击",
					"内容抄袭"
				],
				reportIndex: -1
			}
		},
		methods: {
			//关闭alert
			closePopup() {
				this.closeAction()
			},
			emptyAction() {},
			selectClassifyAction(res) {
				var index = res.currentTarget.dataset.index
				this.reportIndex = index
			}
		},
		props: {
			//是否弹出显示
			visible: {
				type: Boolean,
				value: false
			},
			closeAction: Function 
		}
	}
</script>

<style>
	@import url("detail_report.css");
</style>
