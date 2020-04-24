<template>
	<view class="main-body">
		<earningsdetail v-if="currentIndex == 0"></earningsdetail>
		<friendlist v-else-if="currentIndex == 1"></friendlist>
		<invitefriend v-else-if="currentIndex == 2"></invitefriend>
		
		<view class="main-body-sub" style="margin-top: 0;">
			<uniTab :current="currentIndex" :tabs="tabs" :selection="tabSelection"></uniTab>
		</view>
	</view>
</template>

<script>
	import uniTab from "../../components/hksy-uni-tab/hksy-uni-tab.vue"
	import earningsdetail from "./earningsdetail.vue"
	import friendlist from "./invitefriendlist.vue"
	import invitefriend from "./maininvite"

	export default {
		data() {
			return {
				tabs: ["邀请收益", "好友列表", "邀请好友"],
				currentIndex: 0
			}
		},
		methods: {
			tabSelection(index) {
				if (this.currentIndex != index) {
					this.currentIndex = index
				}
			}
		},
		onLoad() {
			
		},
		components: {
			uniTab,
			earningsdetail,
			friendlist,
			invitefriend
		},
		onPullDownRefresh() {
			uni.$emit("inviterefresh_" + this.currentIndex, null)
		},
		created() {
			uni.$emit("inviterefresh_" + this.currentIndex, null)
		},
		onUnload() {
			uni.$off("inviterefresh_0")
			uni.$off("inviterefresh_1")
			uni.$off("inviterefresh_2")
		}
	}
</script>

<style>

</style>
