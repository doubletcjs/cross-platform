<template>
	<view class="hksy-uni-tab-wapper" v-if="tabs.length > 0">
		<view class="hksy-uni-tab-wapper">
			<view class="hksy-uni-tab-content-wapper" v-for="(tab, index) in tabs" :key="index" :data-index="index" @tap="tabSelection">
				<view class="hksy-uni-tab-text" v-if="index == current" style="color: rgba(23, 96, 255, 1);">
					{{tab}}
				</view>
				<view class="hksy-uni-tab-text" v-else>
					{{tab}}
				</view>
				<view class="hksy-uni-tab-line" v-if="index == current" style="background-color: rgba(23, 96, 255, 1);">

				</view>
				<view class="hksy-uni-tab-line" v-else>

				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		methods: {
			tabSelection(res) {
				var index = res.currentTarget.dataset.index;
				if (this.current != index) {
					this.current = index
				}
				// this.$emit('selection',this.current)
				this.selection(this.current)
			} 
		},
		props: {
			tabs: Array,
			selection: Function,
			current: {
				default:0
			}
		}
	}
</script>

<style>
	@import url("hksy-uni-tab.css");
</style>
