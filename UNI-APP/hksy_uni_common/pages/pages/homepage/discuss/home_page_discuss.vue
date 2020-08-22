<template>
	<view>
		<!-- tab -->
		<view class="discuss-tab">
			<view v-for="(item, index) in tabs" :key="index" class="discuss-tab-item" :data-index="index" @click="tabSelectAction"
			 :style="tabIndex == index ? 'background-color: rgba(247, 246, 245, 1); color: rgba(50, 50, 50, 1);' : 'color: rgba(153, 153, 153, 1); background-color: rgba(255, 255, 255, 1);'">
				{{item}}
			</view>
		</view>
		<!-- 列表 -->
		<view class="discuss-cell" v-for="(item, index) in discussList" :key="index" :style="index == discussList.length-1 ? 'margin-bottom: 120rpx;' : ''">
			<!-- 头像 -->
			<image src="" mode="aspectFill" class="discuss-cell-avatar"></image>
			<view class="discuss-cell-column">
				<view class="discuss-cell-base-column">
					<view class="discuss-cell-base-row">
						<!-- 用户名 -->
						<view class="discuss-cell-name" :style="item['blogger'] && item['blogger'] == true ? 'max-width: 70%;' : 'max-width: 89%;'">
							{{item['name']}}
						</view>
						<!-- 是否博主 -->
						<view class="discuss-cell-blogger" v-if="item['blogger'] && item['blogger'] == true">
							落主
						</view>
					</view>
					<!-- 发布时间 -->
					<view class="discuss-cell-date">
						{{item['date']}}
					</view>
					<!-- 内容 -->
					<view class="discuss-cell-content-mask">
						<view class="discuss-cell-content" :style="(unfoldList[index].needUnfold == true && unfoldList[index].didUnfold == false) ? '-webkit-line-clamp: 4;' : ''">
							{{item['content']}}
						</view>
						<!-- 文本展开 -->
						<view class="discuss-cell-content-unfold" v-if="unfoldList[index].needUnfold == true && unfoldList[index].didUnfold == false"
						 :data-index="index" @click="unfoldContent">
							展开
						</view>
					</view>
					<!-- 回复数 -->
					<view class="discuss-cell-base-row" style="margin-top: 24rpx;" v-if="item['replyCount'] && item['replyCount'] > 0">
						<view class="discuss-cell-reply" :data-index="index" @click="replyAction">
							{{item['replyCount']}}条回复
						</view>
						<image src="/static/images/detail_arrow@3x.png" class="discuss-cell-reply-arrow"></image>
					</view>
				</view>
			</view>
			<!-- 分割线 -->
			<view class="discuss-cell-line" :style="index == discussList.length-1 ? 'height: 0rpx; background-color: rgba(153, 153, 153, 0);' : ''"></view>
			<!-- 点赞 -->
			<view class="discuss-cell-like" :data-index="index" @click="likeAction">
				<image :src="item['isLike'] == true ? '/static/images/discuss_like_sel@3x.png' : '/static/images/discuss_like@3x.png'" mode="" class="discuss-cell-like-icon"></image>
				<view class="discuss-cell-like-count">
					{{item['likeCount'] > 0 ? item['likeCount']  : '赞'}}
				</view>
			</view>
		</view>
		<!-- 评论输入框 -->
		<view class="discuss-input-bar" v-if="scrollTop > 250" @click="discussAction">
			<view class="discuss-input-bar-placeholder">
				留下你的精彩讨论吧
			</view>
			<image src="/static/images/input_bar_icon@3x.png" mode="" class="discuss-input-bar-icon"></image>
		</view>
		<discussinput :visible="inputvisible" :closeAction="discussAction" :sendAction="sendContentAction"></discussinput>
		<reply :visible="replyvisible" :closeAction="replyAction" :discuss="currentDiscuss"></reply>
	</view>
</template>

<script>
	import discussinput from "./home_page_discuss_input.vue"
	import reply from "./home_page_reply.vue"

	export default {
		data() {
			return {
				tabIndex: 0,
				tabs: [
					"最新",
					"热门",
				],
				discussList: [],
				unfoldList: [],
				inputvisible: false,
				replyvisible: false,
				currentDiscuss: {}
			}
		},
		methods: {
			//tab
			tabSelectAction(res) {
				var index = res.currentTarget.dataset.index
				this.tabIndex = index
			},
			//重新计算评论内容高度
			reloadCellContent() {
				for (var i = 0; i < this.discussList.length; i++) {
					if (i + 1 > this.unfoldList.length) {
						this.unfoldList.push({
							needUnfold: false,
							didUnfold: false
						})
					}
				}

				var me = this
				setTimeout(function() {
					let selector = uni.createSelectorQuery().selectAll('.discuss-cell-content');
					selector.boundingClientRect(function(data) {
						for (var i = 0; i < data.length; i++) {
							var info = data[i]
							var height = info.height * 2
							if (height > 166) {
								var unfold = me.unfoldList[i]
								unfold.needUnfold = true
								me.unfoldList[i] = unfold
							}
						}
					}).exec(function() {

					})
				}, 210);
			},
			// 展开内容
			unfoldContent(res) {
				var index = res.currentTarget.dataset.index
				var unfold = this.unfoldList[index]
				unfold.didUnfold = true
				this.unfoldList[index] = unfold
			},
			// 点赞
			likeAction(res) {
				var index = res.currentTarget.dataset.index
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
			//回复 
			replyAction(res) {
				if (res) {
					var index = res.currentTarget.dataset.index
					var discuss = this.discussList[index]
					this.currentDiscuss = discuss 
				}
				this.replyvisible = !this.replyvisible
			}
		},
		created() {
			var me = this
			setTimeout(function() {
				me.discussList = [{
						replyCount: 88,
						blogger: true,
						date: "30分钟前",
						content: "小时候爱吃饺子，纯粹是爱它的美味，现我们吃的，更多是饺子里的家乡味",
						name: "红鱼",
						likeCount: 99,
						avatar: "",
						isLike: false
					},
					{
						replyCount: 2,
						blogger: false,
						date: "07-24  14:34",
						content: "我最喜欢的还是大才子蔡澜，笔下不仅有豪华饭店还有街边小摊",
						name: "晨曦",
						likeCount: 0,
						avatar: "",
						isLike: true
					},
					{
						replyCount: 2,
						blogger: false,
						date: "07-24  13:34",
						content: "说起文人谈美食，脑子里就迸出一串串名字——季鹰归未、东坡夜饮、笠翁醉蟹、雪芹茄鲞，还有写了《藕与莼菜》的叶我最喜欢的还是大才子蔡澜，笔下不仅有豪华饭店还有街边小摊",
						name: "晨曦",
						likeCount: 99,
						avatar: "",
						isLike: false
					},
					{
						replyCount: 2,
						blogger: false,
						date: "07-24  13:34",
						content: "说起文人谈美食，脑子里就迸出一串串名字——季鹰归未、东坡夜饮、笠翁醉蟹、雪芹茄鲞，还有写了《藕与莼菜》的叶我最喜欢的还是大才子蔡澜，笔下不仅有豪华饭店还有街边小摊",
						name: "晨曦",
						likeCount: 99,
						avatar: "",
						isLike: false
					},
					{
						replyCount: 2,
						blogger: false,
						date: "07-24  13:34",
						content: "说起文人谈美食，脑子里就迸出一串串名字——季鹰归未、东坡夜饮、笠翁醉蟹、雪芹茄鲞，还有写了《藕与莼菜》的叶我最喜欢的还是大才子蔡澜，笔下不仅有豪华饭店还有街边小摊",
						name: "晨曦",
						likeCount: 99,
						avatar: "",
						isLike: false
					},
				]

				me.reloadCellContent();
			}, 510);
		},
		props: {
			scrollTop: 0
		},
		components: {
			discussinput,
			reply
		}
	}
</script>

<style>
	@import url("home_page_discuss.css");
	@import url("home_page_discuss_input.css");
</style>
