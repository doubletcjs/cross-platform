<template>
	<view>
		<view class="detail-apply-section" v-for="(item, index) in dataList" :key="index">
			<view class="detail-apply-section-title">
				{{item['date']}}
			</view>
			<view class="detail-apply-cell-column">
				<view class="detail-apply-cell" v-for="(account, idx) in item['accountList']" :key="idx" :data-section="index"
				 :data-row="idx" @click="detailAction">
					<view class="detail-apply-cell-row" :style="account['status'] == 0 ? 'width: 65%;' : 'width: 85%;'">
						<!-- 头像 -->
						<image :src="account['avatar']" mode="" class="detail-apply-cell-avatar"></image>
						<!-- 用户信息 -->
						<view class="detail-apply-cell-info" :style="account['status'] == 0 ? 'width: 75%;' : 'width: 76%;'">
							<!-- 用户名 -->
							<view class="detail-apply-cell-name">
								{{account['name']}}
							</view>
							<!-- 内容 -->
							<view class="detail-apply-cell-content">
								{{account['content']}}
							</view>
						</view>
					</view>
					<!-- 状态 -->
					<view class="detail-apply-cell-row" v-if="account['status'] == 0">
						<view class="detail-apply-cell-ignore" :data-section="index" :data-row="idx" @click.stop="ignoreAction">
							忽略
						</view>
						<view class="detail-apply-cell-agree" :data-section="index" :data-row="idx" @click.stop="agreeAction">
							同意
						</view>
					</view>
					<view class="detail-apply-cell-row" v-else>
						<view class="detail-apply-cell-status" v-if="account['status'] == 1">
							已忽略
						</view>
						<view class="detail-apply-cell-status" v-else>
							已同意
						</view>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				dataList: [{
						date: "2020.07.11",
						accountList: [{
								avatar: "",
								name: "小红鱼",
								content: "热爱美食，来学习了~",
								status: 0, //0 未处理 1 忽略 2 同意
								area: "广东 广州", //地区
								block: true, //黑名单
								id: 1
							},
							{
								avatar: "",
								name: "晨曦",
								content: "鱼儿拉我进去，我是晨曦~",
								status: 0, //0 未处理 1 忽略 2 同意
								area: "广东 广州", //地区
								block: false, //黑名单
								id: 2
							},
							{
								avatar: "",
								name: "布丁",
								content: "我是你的布姐姐呀， 我来你...",
								status: 0, //0 未处理 1 忽略 2 同意
								area: "广东 广州", //地区
								block: false, //黑名单
								id: 13
							},
						]
					},
					{
						date: "2020.07.10",
						accountList: [{
							avatar: "",
							name: "假懒猫",
							content: "健身游泳，了解一下~",
							status: 1, //0 未处理 1 忽略 2 同意
							area: "广东 广州", //地区
							block: false, //黑名单
							id: 1123
						}, {
							avatar: "",
							name: "风里",
							content: "终于等到你角落开启了~陶器...",
							status: 2, //0 未处理 1 忽略 2 同意
							area: "广东 广州", //地区
							block: false, //黑名单
							id: 123445
						}, {
							avatar: "",
							name: "寻忆味道",
							content: "姐姐的陶器太好看了~~~~想买~",
							status: 2, //0 未处理 1 忽略 2 同意
							area: "广东 广州", //地区
							block: false, //黑名单
							id: 12431
						}, {
							avatar: "",
							name: "亦城",
							content: "美食呀~拉我进去~",
							status: 2, //0 未处理 1 忽略 2 同意
							area: "广东 广州", //地区
							block: false, //黑名单
							id: 2345
						}, ]
					}
				],
				edittingItem: null
			}
		},
		methods: {
			//同意
			agreeAction(res) {
				var section = res.currentTarget.dataset.section
				var row = res.currentTarget.dataset.row
				var accountList = this.dataList[section]["accountList"]
				var account = accountList[row]
				account["status"] = 2
				accountList[row] = account
				this.dataList[section]["accountList"] = accountList
			},
			//忽略
			ignoreAction(res) {
				var section = res.currentTarget.dataset.section
				var row = res.currentTarget.dataset.row
				var accountList = this.dataList[section]["accountList"]
				var account = accountList[row]
				account["status"] = 1
				accountList[row] = account
				this.dataList[section]["accountList"] = accountList
			},
			//详情
			detailAction(res) {
				var section = res.currentTarget.dataset.section
				var row = res.currentTarget.dataset.row
				var accountList = this.dataList[section]["accountList"]
				var account = accountList[row]
				uni.navigateTo({
					url: "detail_apply_action?account=" + JSON.stringify(account)
				})
			}
		},
		onShow() {
			if (this.edittingItem != null) { 
				
			}
		}
	}
</script>

<style>
	@import url("detail_apply.css");
</style>
