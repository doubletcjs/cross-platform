<template>
	<view>
		<!-- tab -->
		<view class="dynamic-tab">
			<view v-for="(item, index) in tabs" :key="index" class="dynamic-tab-item" :data-index="index" @click="tabSelectAction"
			 :style="tabIndex == index ? 'background-color: rgba(247, 246, 245, 1); color: rgba(50, 50, 50, 1);' : 'color: rgba(153, 153, 153, 1); background-color: rgba(255, 255, 255, 1);'">
				{{item}}
			</view>
		</view>
		<!-- 列表 -->
		<view class="dynamic-cell" v-for="(item, index) in dynamicList" :key="index">
			<view class="dynamic-cell-base-row" style="justify-content: space-between;">
				<!-- 用户信息 -->
				<view class="dynamic-cell-base-row" style="width: 96%;">
					<!-- 头像 -->
					<image src="" mode="aspectFill" class="dynamic-cell-avatar"></image>
					<view class="dynamic-cell-base-column" style="margin-left: 16rpx; width: 80%;">
						<view class="dynamic-cell-base-row">
							<!-- 用户名 -->
							<view class="dynamic-cell-name" :style="item['blogger'] && item['blogger'] == true ? 'max-width: 81%;' : ''">
								{{item['name']}}
							</view>
							<!-- 是否博主 -->
							<view class="dynamic-cell-blogger" v-if="item['blogger'] && item['blogger'] == true">
								落主
							</view>
						</view>
						<!-- 发布时间 -->
						<view class="dynamic-cell-date">
							{{item['date']}}
						</view>
					</view>
				</view>
				<!-- 分享 -->
				<image src="/static/images/dynamic_more@3x.png" mode="" class="dynamic-cell-more" :data-index="index" @click="shareAction"></image>
			</view>
			<!-- 视频 -->
			<view class="dynamic-cell-video" v-if="item['video'] != null" :style="videoStyle(item['video'])">
				<video :preload="true" :src="item['video']['url']" style="width: 100%; height: 100%;" :controls="false" :muted="item['video']['muted']"></video>
				<image :data-index="index" @click="videoMuted" :src="item['video']['muted'] == true ? '/static/images/dynamic_muted_sel@3x.png' : '/static/images/dynamic_muted@3x.png'"
				 mode="" class="dynamic-cell-video-muted"></image>
			</view>
			<!-- 图片 -->
			<view class="dynamic-cell-image" v-if="item['images'] != null && item['images'].length > 0" :style="imageStyle(item['images'])">
				<swiper style="width: 100%; height: 100%;" v-if="item['images'].length > 1" :autoplay="true">
					<swiper-item v-for="(image, imageIndex) in item['images']" :key="imageIndex">
						<image :src="image['url']" mode="aspectFill" style="width: 100%; height: 100%;"></image>
					</swiper-item>
				</swiper>
				<image :src="item['images'][0]['url']" mode="aspectFill" style="width: 100%; height: 100%;" v-else></image>
				<view class="dynamic-cell-image-count" v-if="item['images'].length > 1">
					{{1}}/{{item['images'].length}}
				</view>
			</view>
			<!-- 内容 -->
			<view class="dynamic-cell-base-column" style="width: 100%;">
				<view class="dynamic-cell-content">
					{{item['content']}}
				</view>
				<!-- 预览内容 -->
				<view class="dynamic-cell-subContent" v-if="item['subContent'] && item['subContent'].length > 0">
					{{item['subContent']}}
				</view>
				<!-- 预览全文 -->
				<view class="dynamic-cell-base-row" v-if="item['subContent'] && item['subContent'].length > 0" style="margin-top: 16rpx;">
					<view class="dynamic-cell-subContent-all">
						查看全文
					</view>
					<image src="/static/images/dynamic_more_content@3x.png" mode="" class="dynamic-cell-subContent-arrow"></image>
				</view>
				<!-- 评论 -->
				<text class="dynamic-cell-comment" v-if="item['comments'] && item['comments'].length > 0">
					<text class="dynamic-cell-comment-row" v-for="(comment, idx) in item['comments']" :key="idx" :style="idx == item['comments'].length-1 ? '' : 'margin-bottom: 12rpx;'">
						<text class="dynamic-cell-comment-name">
							{{comment['name']}}：
						</text>
						<text class="dynamic-cell-comment-content">
							{{comment['content']}}
						</text>
					</text>
				</text>
				<!-- 功能按钮 -->
				<view class="dynamic-cell-actions">
					<view class="dynamic-cell-base-row">
						<image :src="item['isCollection'] == true ? '/static/images/dynamic_collection_sel@3x.png' : '/static/images/dynamic_collection@3x.png'"
						 mode="" class="dynamic-cell-actions-icon"></image>
						<view class="dynamic-cell-actions-text">
							{{item['collectionCount'] > 0 ? item['collectionCount'] : '收藏'}}
						</view>
					</view>
					<view class="dynamic-cell-base-row" style="margin-left: 40rpx;">
						<image src="/static/images/dynamic_comment@3x.png" mode="" class="dynamic-cell-actions-icon"></image>
						<view class="dynamic-cell-actions-text">
							{{item['commentCount'] > 0 ? item['commentCount'] : '评论'}}
						</view>
					</view>
					<view class="dynamic-cell-base-row" style="margin-left: 40rpx;">
						<image src="/static/images/discuss_like@3x.png" mode="" class="dynamic-cell-actions-icon"></image>
						<view class="dynamic-cell-actions-text">
							{{item['likeCount'] > 0 ? item['likeCount'] : '赞'}}
						</view>
					</view>
				</view>
			</view>
		</view>
		<!-- 发布 -->
		<view class="dynamic-post" v-if="scrollTop > 250">
			<image src="/static/images/dynamic_post@3x.png" mode="" class="dynamic-post-image" @click="dynamicPost"></image>
		</view>
		<!-- 分享 -->
		<share :visible="sharevisible" :closeAction="shareAction" :itemTapAction="shareItemAction" ref="share"></share>
		<!-- 举报 -->
		<report :visible="reportvisible" :closeAction="reportAction"></report>
		<!-- 发布 -->
		<post :visible="postvisible" :closeAction="dynamicPost"></post>
	</view>
</template>

<script>
	import share from "../../detail/components/detail_share.vue"
	import report from "../../detail/components/detail_report.vue"
	import post from "./home_page_dynamic_post.vue"

	export default {
		data() {
			return {
				sharevisible: false, //分享
				reportvisible: false, //举报 
				postvisible: false, //发布 
				tabs: [
					"最新",
					"热门",
					"精华",
				],
				tabIndex: 0,
				dynamicList: [{
						name: "红鱼",
						blogger: true,
						date: "30分钟前",
						content: "小时候爱吃饺子，纯粹是爱它的美味。现我们吃的，更多是饺子里的家乡味。",
						subContent: "",
						isCollection: false,
						collectionCount: 5,
						commentCount: 0,
						likeCount: 0,
						video: {
							muted: false,
							width: 400,
							height: 300,
							url: "https://img.cdn.aliyun.dcloud.net.cn/guide/uniapp/%E7%AC%AC1%E8%AE%B2%EF%BC%88uni-app%E4%BA%A7%E5%93%81%E4%BB%8B%E7%BB%8D%EF%BC%89-%20DCloud%E5%AE%98%E6%96%B9%E8%A7%86%E9%A2%91%E6%95%99%E7%A8%8B@20181126-lite.m4v"
						},
					},
					{
						name: "红鱼",
						blogger: false,
						date: "07-24  14:34",
						content: "每日一食：自制叉烧！",
						subContent: "",
						isCollection: true,
						collectionCount: 0,
						commentCount: 1000,
						likeCount: 840,
						comments: [{
							name: "彩虹蛋糕",
							content: "好赞，一看就很好吃的"
						}, {
							name: "你喜欢不如我喜欢",
							content: "摆盘太精致了"
						}, ],
						video: {
							muted: false,
							width: 1452,
							height: 1600,
							url: "https://img.cdn.aliyun.dcloud.net.cn/guide/uniapp/%E7%AC%AC1%E8%AE%B2%EF%BC%88uni-app%E4%BA%A7%E5%93%81%E4%BB%8B%E7%BB%8D%EF%BC%89-%20DCloud%E5%AE%98%E6%96%B9%E8%A7%86%E9%A2%91%E6%95%99%E7%A8%8B@20181126-lite.m4v"
						},
					},
					{
						name: "红鱼",
						blogger: false,
						date: "07-24  14:34",
						content: "论摆盘的重要性",
						subContent: "我们的生活一定要充满乐趣，因为这样才能算得上是生活，我们大家平时做饭的时候，可能也没有注意过我活，我们大家平时做饭的时候，可能也没有注意过我.",
						isCollection: false,
						collectionCount: 0,
						commentCount: 0,
						likeCount: 9,
						images: [{
								width: 1452,
								height: 1600,
								url: "https://vkceyugu.cdn.bspapp.com/VKCEYUGU-ask-img/a6dc1da0-ca71-11ea-81ea-f115fe74321c.png"
							},
							{
								width: 1452,
								height: 1600,
								url: "https://vkceyugu.cdn.bspapp.com/VKCEYUGU-public-doc/f7a83f70-ba9a-11ea-b680-7980c8a877b8.png"
							},
							{
								width: 1452,
								height: 1600,
								url: "https://vkceyugu.cdn.bspapp.com/VKCEYUGU-ask-img/a6dc1da0-ca71-11ea-81ea-f115fe74321c.png"
							},
							{
								width: 1452,
								height: 1600,
								url: "https://vkceyugu.cdn.bspapp.com/VKCEYUGU-public-doc/f7a83f70-ba9a-11ea-b680-7980c8a877b8.png"
							}
						]
					},
				]
			}
		},
		methods: {
			//tab
			tabSelectAction(res) {
				var index = res.currentTarget.dataset.index
				this.tabIndex = index
			},
			//视频边框
			videoStyle(video) {
				var width = video["width"]
				var height = video["height"]

				if (width > height) {
					height = (686 * height) / width + "rpx"
					width = 686 + "rpx"
				} else {
					height = (452 * height) / width + "rpx"
					width = 452 + "rpx"
				}

				if (height > uni.getSystemInfoSync().windowHeight) {
					height = uni.getSystemInfoSync().windowHeight
				}

				var style = "width: " + width + ";" + " " + "height: " + height + ";"
				return style
			},
			//图片边框
			imageStyle(images) {
				if (images.length == 1) {
					var image = images[0]
					var width = image["width"]
					var height = image["height"]

					height = (452 * height) / width + "rpx"
					width = 452 + "rpx"

					if (height > uni.getSystemInfoSync().windowHeight) {
						height = uni.getSystemInfoSync().windowHeight
					}

					var style = "width: " + width + ";" + " " + "height: " + height + ";"
					return style
				} else {
					return "width: 686rpx;" + " " + "height: 823rpx;"
				}
			},
			//视频静音
			videoMuted(res) {
				var index = res.currentTarget.dataset.index
				var dynamic = this.dynamicList[index]
				var video = dynamic["video"]
				video.muted = !video.muted
				dynamic["video"] = video
				this.dynamicList[index] = dynamic
			},
			//分享
			shareAction(res) {
				if (res) {
					var otherList = []
					var index = res.currentTarget.dataset.index
					var dynamic = this.dynamicList[index]
					//博主
					if (dynamic.blogger) {
						otherList = [{
							icon: "/static/images/report_icon@3x.png",
							title: "投诉",
							mark: "report"
						}, {
							icon: "/static/images/report_icon@3x.png",
							title: "删除",
							mark: "delete"
						}, ]
					} else {
						otherList = [{
							icon: "/static/images/report_icon@3x.png",
							title: "投诉",
							mark: "report"
						}, ]
					}

					this.$refs.share.updateList(null, otherList.length > 0 ? otherList : null)
				}

				this.sharevisible = !this.sharevisible
			},
			shareItemAction(res) {
				console.log(res)
				if (res == "report") {
					var me = this
					setTimeout(function() {
						me.reportAction()
					}, 200)
				}
			},
			// 举报
			reportAction() {
				this.reportvisible = !this.reportvisible
			},
			// 动态发布
			dynamicPost() {
				this.postvisible = !this.postvisible
			},
			postAction() {

			}
		},
		components: {
			report,
			share,
			post
		},
		props: {
			scrollTop: 0
		}
	}
</script>

<style>
	@import url("home_page_dynamic.css");
</style>
