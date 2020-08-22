<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="reply-content" @click.stop="emptyAction">
			<!-- 标题栏 -->
			<view class="reply-count-bar">
				<image src="/static/images/base_back@3x.png" mode="" class="reply-count-icon" @click="closePopup"></image>
				<view class="reply-count-text" v-if="discuss != null" @click="closePopup">
					回复（{{discuss['replyCount']}}）
				</view>
			</view>
			<!-- 评论 -->
			<view class="discuss-cell" style="padding-top: 56rpx;">
				<!-- 头像 -->
				<image src="" mode="aspectFill" class="discuss-cell-avatar"></image>
				<view class="discuss-cell-column">
					<view class="discuss-cell-base-column">
						<view class="discuss-cell-base-row">
							<!-- 用户名 -->
							<view class="discuss-cell-name" :style="discuss['blogger'] && discuss['blogger'] == true ? 'max-width: 70%;' : 'max-width: 89%;'">
								{{discuss['name']}}
							</view>
							<!-- 是否博主 -->
							<view class="discuss-cell-blogger" v-if="discuss['blogger'] && discuss['blogger'] == true">
								落主
							</view>
						</view>
						<!-- 发布时间 -->
						<view class="discuss-cell-date">
							{{discuss['date']}}
						</view>
						<!-- 内容 -->
						<view class="discuss-cell-content-mask">
							<view class="discuss-cell-content">
								{{discuss['content']}}
							</view>
						</view>
					</view>
				</view>
				<!-- 点赞 -->
				<view class="discuss-cell-like" @click="likeAction">
					<image :src="discuss['isLike'] == true ? '/static/images/discuss_like_sel@3x.png' : '/static/images/discuss_like@3x.png'"
					 mode="" class="discuss-cell-like-icon"></image>
					<view class="discuss-cell-like-count">
						{{discuss['likeCount'] > 0 ? discuss['likeCount']  : '赞'}}
					</view>
				</view>
			</view>
			<!-- 分割线 -->
			<view style="width: 100%; height: 2rpx; background-color: rgba(153, 153, 153, 0.1)"></view>
			<!-- 全部回复 -->
			<view class="reply-all">
				全部回复
			</view>
			<!-- 回复列表 -->
			<view class="reply-list-content">
				<view class="reply-cell" v-for="(item, index) in replyList" :key="index">
					<!-- 头像 -->
					<image src="" mode="aspectFill" class="discuss-cell-avatar"></image>
					<view class="reply-cell-base-column">
						<!-- 用户名 -->
						<view class="reply-cell-name">
							{{item['name']}}
						</view>
						<!-- 回复内容 --> 
						<text class="reply-cell-content-row">
							<text class="reply-cell-account" v-if="item['replyAccount'] && item['replyAccount'].length > 0">
								回复@{{item['replyAccount']}}：
							</text>
							<text class="reply-cell-content">
								{{item['content']}}
							</text>
							<text class="reply-cell-time" v-if="item['date'] && item['date'].length > 0">
								{{item['date']}}
							</text>
						</text>
					</view>
					<!-- 点赞 -->
					<view class="reply-cell-like" :data-index="index" @click="replyLikeAction">
						<image :src="item['isLike'] == true ? '/static/images/discuss_like_sel@3x.png' : '/static/images/discuss_like@3x.png'"
						 mode="" class="discuss-cell-like-icon"></image>
						<view class="reply-cell-like-count">
							{{item['likeCount'] > 0 ? item['likeCount']  : '赞'}}
						</view>
					</view>
				</view>
			</view>
			<!-- 评论输入框 -->
			<view class="input-bar" @click="discussAction">
				<view class="input-bar-placeholder">
					留下你的精彩讨论吧
				</view>
				<image src="/static/images/input_bar_icon@3x.png" mode="" class="input-bar-icon"></image>
			</view>
			<discussinput :visible="inputvisible" :closeAction="discussAction" :sendAction="sendContentAction"></discussinput>
		</view>
	</view>
</template>

<script>
	import discussinput from "./home_page_discuss_input.vue"

	export default {
		data() {
			return {
				inputvisible: false,
				replyList: [{
					date: "10分钟前",
					content: "是哒",
					name: "晨曦",
					likeCount: 0,
					avatar: "",
					isLike: false,
					replyAccount: ""
				}, {
					date: "",
					content: "季鹰归未、东坡夜饮、笠翁醉蟹、雪芹茄鲞",
					name: "布丁",
					likeCount: 8,
					avatar: "",
					isLike: true,
					replyAccount: ""
				}, {
					date: "10分钟前",
					content: "赞同",
					name: "懒猫",
					likeCount: 0,
					avatar: "",
					isLike: false,
					replyAccount: ""
				}, {
					date: "10分钟前",
					content: "厉害",
					name: "风里",
					likeCount: 0,
					avatar: "",
					isLike: false,
					replyAccount: "布丁"
				}, {
					date: "10分钟前",
					content: "喜欢",
					name: "寻忆味道",
					likeCount: 0,
					avatar: "",
					isLike: false,
					replyAccount: ""
				}, ]
			}
		},
		methods: {
			//关闭alert
			closePopup() {
				this.closeAction()
			},
			emptyAction() {},
			// 点赞
			likeAction(res) {
				var index = res.currentTarget.dataset.index
				this.discuss.isLike = !this.discuss.isLike
			},
			replyLikeAction(res) {
				var index = res.currentTarget.dataset.index
				var reply = this.replyList[index]
				reply.isLike = !reply.isLike
				this.replyList[index] = reply
			},
			// 输入评论
			discussAction() {
				this.inputvisible = !this.inputvisible
			},
			//发评论
			sendContentAction(res) {
				console.log(res)
				uni.showToast({
					title: "发布成功",
					icon: "none"
				})
			}, 
		},
		props: {
			//是否弹出显示
			visible: {
				type: Boolean,
				value: false
			},
			closeAction: Function,
			discuss: null
		},
		components: {
			discussinput
		}
	}
</script>

<style>
	@import url("home_page_reply.css");
	@import url("home_page_discuss.css");
</style>
