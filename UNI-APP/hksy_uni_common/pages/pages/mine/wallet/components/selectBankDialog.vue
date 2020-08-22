<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="selectBank-content" @click.stop="emptyAction">
			<!-- 标题 -->
			<view class="title_wrapper">
				<view class="title_text">
					请选择银行
				</view>
				<view class="close_wrapper">
					<view class="close_text" @click="closePopup">X</view>
				</view>
			</view>
			
			<!-- 银行列表 -->
			<scroll-view class="bank_list_wrapper" scroll-y="true" show-scrollbar="true">
				<view class="bank_wrapper" v-for="(item, index) in backList" :key="index" :data-index="index" @click="selectItemAction">
					<image class="bank_logo" src="../../../../../static/images/bank_logo@2x.png" mode="aspectFit"></image>
					<view class="bank_name">{{item}}</view>		
					<image :class="selecIndex == index ? 'select_image' : 'select_image select_image_none' " src="../../../../../static/images/select_bank@2x.png" mode="aspectFit"></image>
				</view>
			</scroll-view>
			
			<view class="use_newBank_wrapper" @click="addBankCard">
				<view class="use_newBank_text">使用新卡提现</view>
				<view class="use_newBank_back_wrapper">
					<image class="newBank_back_image" src="../../../../../static/images/arrows_left@2x.png" mode="aspectFit" ></image>
				</view>
			</view>
			
			<!-- 取消 -->
			<view class="selectBank-cancel" @click="closePopup">
				取消
			</view>
			<view class="selectBank_bottom">
				<view class="selectBank_bottom_black">
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				backList: [
					"招商银行",
					"中国银行",
					"中国建设银行",
					"中国工商银行",
					"中国农业银行",
					"中国交通银行",
					"中国农商银行",
					"广州银行",
					"中国人民银行",
					"中国发展银行"
				],
				selecIndex: -1
			}
		},
		methods: {
			//关闭alert
			closePopup() {
				this.closeAction()
			},
			emptyAction() {},
			selectItemAction(res) {
				let index = res.currentTarget.dataset.index
				this.selecIndex = index
				
				let me = this
				setTimeout(function() { // 回调结果给父组件
					let bankName = me.backList[me.selecIndex]
					me.itemTapAction(bankName)
				}, 100)
				this.closePopup()
				
			},
			addBankCard() {
				this.closePopup()
				uni.navigateTo({
					url: "bank/bankCardList"
				})
			}
		},
		props: {
			//是否弹出显示
			visible: {
				type: Boolean,
				value: false
			},
			closeAction: Function ,
			itemTapAction: Function // 回调结果选择什么银行
		}
	}
</script>

<style>
	@import url("selectBankDialog.css");
</style>

