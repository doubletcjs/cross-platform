<template>
	<view>
		<!-- 商品列表 -->
		<view class="dynamic-item-content">
			<!-- 左侧 -->
			<view class="dynamic-item-list">
				<view v-for="(item, index) in leftDynamics" :key="index" class="dynamic-item-cell">
					<!-- 封面 -->
					<image src="" mode="" class="dynamic-item-cell-image" :style="objectStyle(item.object)"></image>
					<!-- 标题 -->
					<view class="dynamic-item-cell-title">
						{{item['title']}}
					</view>
					<view class="dynamic-item-cell-row" style="justify-content: space-between; margin-top: 16rpx; margin-left: 16rpx; margin-right: 16rpx;">
						<view class="dynamic-item-cell-row">
							<!-- 头像 -->
							<image src="" mode="" class="dynamic-item-cell-avatar"></image>
							<!-- 用户名 -->
							<view class="dynamic-item-cell-name">
								{{item['account']['name']}}
							</view>
						</view>
						<!-- 喜欢数  -->
						<view class="dynamic-item-cell-row">
							<image :src="item['isLike'] == true ? '/static/images/icon_me_like_sel@3x.png' : '/static/images/icon_me_like@3x.png'"
							 mode="" class="dynamic-item-cell-like"></image>
							<view class="dynamic-item-cell-like-count">
								{{item['likeCount']}}
							</view>
						</view>
					</view>
					<!-- 视频标记 -->
					<image src="/static/images/icon_me_video@3x.png" mode="" class="dynamic-item-cell-video" v-if="item['isVedio'] == true"></image>
				</view>
			</view>
			<!-- 右侧 -->
			<view class="dynamic-item-list">
				<view v-for="(item, index) in rightDynamics" :key="index" class="dynamic-item-cell">
					<!-- 封面 -->
					<image src="" mode="" class="dynamic-item-cell-image" :style="objectStyle(item.object)"></image>
					<!-- 标题 -->
					<view class="dynamic-item-cell-title">
						{{item['title']}}
					</view>
					<view class="dynamic-item-cell-row" style="justify-content: space-between; margin-top: 16rpx; margin-left: 16rpx; margin-right: 16rpx;">
						<view class="dynamic-item-cell-row">
							<!-- 头像 -->
							<image src="" mode="" class="dynamic-item-cell-avatar"></image>
							<!-- 用户名 -->
							<view class="dynamic-item-cell-name">
								{{item['account']['name']}}
							</view>
						</view>
						<!-- 喜欢数  -->
						<view class="dynamic-item-cell-row">
							<image :src="item['isLike'] == true ? '/static/images/icon_me_like_sel@3x.png' : '/static/images/icon_me_like@3x.png'"
							 mode="" class="dynamic-item-cell-like"></image>
							<view class="dynamic-item-cell-like-count">
								{{item['likeCount']}}
							</view>
						</view>
					</view>
					<!-- 视频标记 -->
					<image src="/static/images/icon_me_video@3x.png" mode="" class="dynamic-item-cell-video" v-if="item['isVedio'] == true"></image>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				dynamics: [{
					title: "视频标题",
					isVedio: true,
					cover: "",
					object: {
						width: 335,
						height: 424,
						url: ""
					},
					account: {
						name: "是凉白开鸭是凉白开鸭",
						avatar: ""
					},
					likeCount: 123,
					isLike: false,
				}, {
					title: "文章标题最多不可以超过20个字符超这显示…",
					isVedio: false,
					cover: "",
					object: {
						width: 335,
						height: 250,
						url: ""
					},
					account: {
						name: "是凉白开鸭",
						avatar: ""
					},
					likeCount: 4123,
					isLike: true,
				}, {
					title: "文章标题最多不可以超过20个字符超这显示…",
					isVedio: false,
					cover: "",
					object: {
						width: 335,
						height: 250,
						url: ""
					},
					account: {
						name: "是凉白开鸭是凉白开鸭",
						avatar: ""
					},
					likeCount: 6123,
					isLike: false,
				}, {
					title: "文章标题",
					isVedio: false,
					cover: "",
					object: {
						width: 335,
						height: 424,
						url: ""
					},
					account: {
						name: "是凉白开鸭是凉白开鸭",
						avatar: ""
					},
					likeCount: 1123,
					isLike: false,
				}, {
					title: "视频标题aaa",
					isVedio: true,
					cover: "",
					object: {
						width: 335,
						height: 250,
						url: ""
					},
					account: {
						name: "是凉白开鸭…",
						avatar: ""
					},
					likeCount: 8123,
					isLike: false,
				}, {
					title: "视频标题aaa",
					isVedio: true,
					cover: "",
					object: {
						width: 335,
						height: 250,
						url: ""
					},
					account: {
						name: "是凉白开鸭…",
						avatar: ""
					},
					likeCount: 8123,
					isLike: false,
				}, {
					title: "视频标题aaa",
					isVedio: true,
					cover: "",
					object: {
						width: 335,
						height: 250,
						url: ""
					},
					account: {
						name: "是凉白开鸭…",
						avatar: ""
					},
					likeCount: 8123,
					isLike: false,
				}, ],
				leftDynamics: [],
				rightDynamics: [],
			}
		},
		methods: {
			//瀑布流数组
			fetchWaterfall() {
				this.leftDynamics = []
				this.rightDynamics = []
				for (var i = 0; i < this.dynamics.length; i++) {
					if (i % 2 == 0) {
						this.leftDynamics.push(this.dynamics[i])
					} else if (i % 2 == 1) {
						this.rightDynamics.push(this.dynamics[i])
					}
				}
			},
			//图片边框
			objectStyle(object) {
				var width = object["width"]
				var height = object["height"]

				height = (335 * height) / width + "rpx"
				width = 335 + "rpx"

				if (height > uni.getSystemInfoSync().windowHeight) {
					height = uni.getSystemInfoSync().windowHeight
				}

				var style = "width: " + width + ";" + " " + "height: " + height + ";"
				return style
			},
		},
		created() {
			this.fetchWaterfall()
		}
	}
</script>

<style>
	@import url("../dynamic/mine_page_dynamic.css");
</style>
