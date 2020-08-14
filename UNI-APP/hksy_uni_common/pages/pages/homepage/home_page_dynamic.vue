<template>
	<view>
		<!-- tab -->
		<view class="dynamic-tab">
			<view v-for="(item, index) in tabs" :key="index" class="dynamic-tab-item" :data-index="index" @click="tabSelectAction" :style="tabIndex == index ? 'background-color: rgba(247, 246, 245, 1); color: rgba(50, 50, 50, 1);' : 'color: rgba(153, 153, 153, 1); background-color: rgba(255, 255, 255, 1);'">
				{{item}}
			</view>
		</view> 
	</view>
</template>

<script>
	export default {
		data() {
			return {
				tabs: [
					"最新",
					"热门",
					"精华",
				],
				tabIndex: 0
			}
		},
		methods: { 
			//tab
			tabSelectAction(res) {
				var index = res.currentTarget.dataset.index
				this.tabIndex = index
			}
		}
	}
</script>

<style>
	@import url("home_page_dynamic.css");
</style>
