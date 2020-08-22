<!-- 我的钱包=>金币提现=>银行卡列表界面 -->
<template>
	<view class="main-body">
		<!-- 还没有添加银行卡 -->
		<view class="noCard_addCard_wrapper" v-if="!isFirst" @click="toAddBank">
			<view class="noCard_plus">+</view>
			<view class="noCard_text">添加银行卡</view>
		</view>
		<!-- 银行卡列表 -->
		<view class="list_wrapper" v-else>
			<view class="list_item_wrapper" v-for="(card, index) in cardList" :key="index" :data-index="index">
				<view class="list_bg_wrapper"><image class="list_bg" src="/../../../../../../static/images/bank_bg@2x.png" mode="center"></image></view>
				<view class="card_info_wrapper">
					<image class="bank_logo" src="/../../../../../../static/images/bank_logo@2x.png" mode="aspectFit"></image>
					<view class="crad_info_right">
						<view class="bank_name_text">{{ card.bankName }}</view>
						<view class="card_type_text">{{ card.cardType }}</view>
					</view>
				</view>
				<view class="card_no">{{ showCardNO(card.cardNO) }}</view>
			</view>
			<view class="addCard_wrapper">
				<view class="addCard_plus">+</view>
				<view class="addCard_text" @click="toAddBank">添加银行卡</view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			cardList: [
				{
					cardNO: '123456789012345678901',
					cardType: '储蓄卡',
					bankName: '中国银行'
				},
				{
					cardNO: '123456789012345678902',
					cardType: '储蓄卡',
					bankName: '中国工商银行'
				}
			],
			isFirst: 0 // 有没有添加银行卡号 0 还没有添加银行卡号  1 已经添加银行卡号
		};
	},
	methods: {
		toAddBank() {
			uni.navigateTo({
				url: 'addBank_one?isFirst=' + this.isFirst
			});
		}
	},
	computed: {
		// 银行卡号显示*号
		showCardNO() {
			return cardNo => '**** **** **** ' + cardNo.substring(cardNo.length - 4);
		}
	},
	created() {
		let me = this;
		uni.$on('bankList_refresh', () => {
			// 超级存储转出回调更新
			setTimeout(() => {
				console.log('银行卡列表刷新');
			}, 0);
		});
	},
	onUnload() {
		console.log('bankCardList onUnload--------');
		uni.$off('bankList_refresh');
	}
};
</script>

<style>
@import url('bankCardList.css');
</style>
