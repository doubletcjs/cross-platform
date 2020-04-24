<template>
	<view class="main-body">
		<view class="main-body-sub" style="margin-top: 20rpx;">
			<view class="message-cell-wapper" v-for="(message, index) in messages" :key="index">
				<view class="message-cell-title-wapper">
					<image src="/static/images/hotsale@3x.png" class="message-cell-icon"></image>
					<view class="message-cell-title" v-if="message.dicId == 11">
						{{message.title}}
					</view>
					<view class="message-cell-title" v-else>
						恭喜!{{message.content}}的用户认购{{message.clickNum}}T！
					</view> 
				</view>
				<text space="ensp" v-html="message.content" class="message-cell-content" v-if="message.dicId == 11">
					<!-- {{message.content}} -->
				</text>
				<view class="message-cell-date-wapper">
					<view class="message-cell-date">
						{{handleDate(message.createTime)}}
					</view>
					<view class="message-cell-time">
						{{handleTime(message.createTime)}}
					</view>
				</view>
			</view> 
		</view>
	</view>
</template>

<script>
	import messageapi from "./api/messageapi.js"
	export default {
		data() {
			return {
				messages: []
			}
		},
		onPullDownRefresh() {
			this.requestMessages()
		},
		methods: {
			requestMessages() {
				messageapi.getNoticeDetail((data, msg) => {
					if (data != null) {
						this.messages = data
						console.log(this.messages,777)
					} else {
						uni.showToast({
							title: msg
						})
					}
					uni.stopPullDownRefresh()
				})
			},
			handleDate(res) {
				var date = res.split(" ")[0]
				return date
				// return date.split("-")[1] + "-" + date.split("-")[2]
			},
			handleTime(res) {
				var time = res.split(" ")[1]
				return time.split(":")[0] + ":" + time.split(":")[1]
			}
		},
		created() {
			setTimeout(() => {
				uni.startPullDownRefresh({

				})
			}, 10)
		}
	}
</script>

<style>
	@import url("message.css");
</style>
