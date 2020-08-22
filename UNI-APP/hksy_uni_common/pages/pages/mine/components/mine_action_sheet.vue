<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="action-sheet-content" @click.stop="emptyAction">
			<view class="action-sheet-cell" v-for="(item, index) in actionList" :key="index" @click.stop="itemTap(index)" :style="actionList.length == 1 ? 'border-top-left-radius: 12rpx; border-top-right-radius: 12rpx;' : index == 0 ? 'border-top-left-radius: 12rpx; border-top-right-radius: 12rpx; border-bottom: solid 12rpx rgba(242, 242, 242, 1);' : index < actionList.length-1 ? 'border-bottom: solid 12rpx rgba(242, 242, 242, 1);': ''">
				{{item}}
			</view>
			<!-- 取消 -->
			<view class="action-sheet-cancel" @click="closePopup">
				取消
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				actionList: []
			}
		},
		methods: {
			//关闭alert
			closePopup() {
				this.closeAction()
			},
			emptyAction() {},
			//分享点击
			itemTap(res) {
				this.closeAction()
				var me = this
				setTimeout(function() {
					me.itemTapAction(me.actionList[res])
				}, 100)
			},
			//初始化数据
			initDataList() {
				if (this.actionList == null || this.actionList.length == 0) {
					this.actionList = ["修改背景"]
				}
			},
			//数据更新
			updateList(list) {
				if (list != null) {
					this.shareList = list
				}
			},
		},
		props: {
			//是否弹出显示
			visible: {
				type: Boolean,
				value: false
			},
			closeAction: Function,
			itemTapAction: Function,
		},
		mounted() {
			this.initDataList()
		}
	}
</script>

<style>
	@import url("mine_action_sheet.css");
</style>
