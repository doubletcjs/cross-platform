<template>
	<view class="coin-header-wapper">
		<view class="coin-header-content-wapper">
			<view class="coin-header-content-tip">
				金币资产（个）
			</view>
			<view class="coin-header-content">
				{{coin}}
			</view>
		</view>
		<view class="coin-header-item-content-wapper">
			<view v-for="(item, index) in items" :key="index">
				<view v-if="item.length == 0" class="coin-header-item-line">

				</view>
				<view v-else class="coin-header-item-wapper" :data-index="index" @tap="itemTapAction">
					<image :src="itemIcons[index]" mode="aspectFit" class="coin-header-item-image"></image>
					<view class="coin-header-item">
						{{item}}
					</view>
				</view>
			</view>
		</view>

		<uni-popup type="bottom" ref="coinpopup">
			<actionsheet :titles="actionSheetTitles" :titleAction="actionSheetTitleAction"></actionsheet>
		</uni-popup>
	</view>
</template>

<script>
	import uniPopup from "../../../components/uni-popup/uni-popup.vue"
	import actionsheet from "../../../components/hksy-uni-actionsheet/hksy-uni-actionsheet.vue"

	export default {
		data() {
			return {
				items: ["提现", "", "充值", "", "互转"],
				itemIcons: ["../../static/images/ico_mygold_list_cashout@3x.png", "",
					"../../static/images/ico_mygold_recharge_white@3x.png", "",
					"../../static/images/ico_mygold_transfer_white@3x.png"
				],
				actionSheetTitles: []
			}
		},
		methods: {
			itemTapAction(res) {
				var index = res.currentTarget.dataset.index
				if (this.items[index] == "提现") {
					this.actionSheetTitles = ["USDT提现", "现金提现"]
					this.$refs.coinpopup.open()
				} else if (this.items[index] == "充值") {
					this.actionSheetTitles = ["USDT充值", "线下充值"]
					this.$refs.coinpopup.open()
				} else if (this.items[index] == "互转") {
					this.itemSelect("互转")
				}
			},
			actionSheetTitleAction(index) {
				var title = this.actionSheetTitles[index]
				this.$refs.coinpopup.close()
				var me = this
				setTimeout(() => {
					me.itemSelect(title)
				}, 300)
			}
		},
		props: {
			coin: "",
			itemSelect: Function
		},
		components: {
			uniPopup,
			actionsheet
		}
	}
</script>

<style>
	@import url("coinheader.css");
</style>
