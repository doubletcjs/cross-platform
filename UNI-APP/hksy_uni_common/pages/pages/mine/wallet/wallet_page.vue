<template>
	<view>
		<view class="wallet-background">
			<!-- 背景 -->
			<image src="/static/images/wallet_back@3x.png" mode="aspectFill" class="wallet-background-image"></image>
			<view class="wallet-bar">			
				<!-- 标题 -->
				<view class="wallet-bar-title">
					钱包
				</view>
				<!-- 返回 -->
				<image src="/static/images/base_back_white@3x.png" mode="" class="wallet-bar-back" @click="backAction"></image>
				<!-- 账单 -->
				<view class="wallet-bar-order" @click="toBillAction">
					账单
				</view>
			</view>
			<view class="wallet-content">
				<view class="wallet-content-title">
					我的金币
				</view>
				<view class="wallet-content-row">
					<view class="wallet-content-amount-row">
						<view class="wallet-content-amount">
							16,900
						</view>
						<view class="wallet-content-unit">
							金
						</view>
					</view>
					<view class="wallet-content-recharge" @click="rechargeAction">
						充值
					</view>
				</view>
			</view>
			<view class="wallet-bottom">
				<view class="wallet-bottom-item">
					<view class="wallet-bottom-item-title">
						可兑换金额（元）
					</view>
					<view class="wallet-bottom-item-row">
						<view class="wallet-bottom-item-uitl">
							￥
						</view>
						<view class="wallet-bottom-item-amount">
							5,680
						</view>
					</view>
					<view class="wallet-bottom-item-value" @click="toWithdraw">
						提现
					</view>
				</view>
				<view class="wallet-bottom-item">
					<view class="wallet-bottom-item-title">
						银行卡（张）
					</view>
					<view class="wallet-bottom-item-row">
						<view class="wallet-bottom-item-amount">
							1
						</view>
					</view>
					<view class="wallet-bottom-item-value" @click="bindCardAction">
						绑定新卡
					</view>
				</view>
			</view>
		</view> 
		<!-- 列表 -->
		<view class="wallet-list" v-if="dataList.length > 0">
			<view class="wallet-list-tip">
				<view class="wallet-list-tip-left">
					充值提现明细
				</view>
				<view class="wallet-list-tip-right" @click="detailAction">
					查看详情
				</view>
			</view>
			<view class="wallet-list-cell" v-for="(item, index) in dataList" :key="index">
				<view class="wallet-list-cell-column">
					<!-- 金额 -->
					<view class="wallet-list-cell-amount">
						-10000
					</view>
					<!-- 日期 -->
					<view class="wallet-list-cell-date">
						2020.07.15 12:00
					</view>
				</view>
				<view class="wallet-list-cell-status">
					<!-- color: rgba(50, 50, 50, 1); -->
					充值
				</view>
				<!-- 分割线 -->
				<view class="wallet-list-cell-line"></view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				dataList: [
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
				]
			}
		},
		methods: {
			// 返回
			backAction() {
				console.log("=====");
				uni.navigateBack({
					delta: 1
				})
			},
			// 明细
			detailAction() {
				uni.navigateTo({
					url: "./wallet_recharge_detail"
				})
			},
			// 充值
			rechargeAction() {
				uni.navigateTo({
					url: "./recharge"
				})
			},
			// 提现
			toWithdraw() {
				uni.navigateTo({
					url: "./withdraw"
				})
			},
			// 绑定新卡
			bindCardAction() {
				uni.navigateTo({
					url: "./bank/bankCardList"
				})
			},
			// 账单
			toBillAction() {
				uni.navigateTo({
					url: "./bill/coinBill"
				})
			}
		}
	}
</script>

<style>
	@import url("wallet_page.css");
</style>
