<template>
	<view class="home-storage-wapper">
		<view class="home-storage-title">
			为存储而生
		</view>
		<view class="home-storage-tip">
			做IPFS生态的引领者
		</view>
		<uni-grid :column="4" :showBorder="false" :square="false" :highlight="false" style="width: 100%; margin-top: 15rpx;">
			<uni-grid-item v-for="(item, index) in items" :key="index">
				<view class="home-storage-grid-item-wapper">
					<image :src="itemIcons[index]" class="home-storage-grid-item-image"></image>
					<view class="home-storage-grid-item-title">
						{{item}}
					</view>
				</view>
			</uni-grid-item>
		</uni-grid>
	</view>
</template>

<script>
	import uniGrid from "@/components/uni-grid/uni-grid.vue"
	import uniGridItem from "@/components/uni-grid-item/uni-grid-item.vue"

	export default {
		data() {
			return {
				items: ["收益透明", "一键存储", "优质云存储", "大带宽共享", "自主研发", "技术支持", "高性价比", "专业维护"],
				itemIcons: ["../../static/images/ico_home_advantage_profit@3x.png",
					"../../static/images/ico_home_advantage_storage@3x.png", "../../static/images/ico_home_advantage_icloud@3x.png",
					"../../static/images/ico_home_advantage_broadband@3x.png", "../../static/images/ico_home_advantage_research@3x.png",
					"../../static/images/ico_home_advantage_technology@3x.png", "../../static/images/ico_home_advantage_cost@3x.png",
					"../../static/images/ico_home_advantage_maintain@3x.png"
				]
			}
		},
		methods: {

		},
		components: {
			uniGrid,
			uniGridItem
		}
	}
</script>

<style>
	@import url("homestorage.css");
</style>
