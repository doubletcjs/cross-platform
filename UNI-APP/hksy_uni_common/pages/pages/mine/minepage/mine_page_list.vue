<template>
	<view style="margin-top: 40rpx;">
		<view class="page-list-cell" v-for="(item, index) in dataList" :key="index">
			<view class="page-list-cell-row">
				<!-- 封面 -->
				<image src="" mode="" class="page-list-cell-cover"></image>
				<view class="page-list-cell-column">
					<view class="page-list-cell-name">
						{{item['name']}}
					</view>
					<view class="page-list-cell-introduce">
						{{item['introduce']}}
					</view>
				</view>
			</view>
			<view class="page-list-cell-join">
				加入
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				dataList: [
					{
						cover: "",
						name: "探寻",
						introduce: "开始一段艰苦的冒险经历"
					},
					{
						cover: "",
						name: "健康吃货",
						introduce: "能吃不等于会吃，健康…"
					},
					{
						cover: "",
						name: "动漫联盟",
						introduce: "分享好物良品，让剁手…"
					},
					{
						cover: "",
						name: "铲屎官Club",
						introduce: "如何成为一个合格的铲…"
					}
				]
			}
		},
		methods: {
			
		}
	}
</script>

<style>
	@import url("mine_page_list.css");
</style>
