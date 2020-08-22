<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="share-content" @click.stop="emptyAction">
			<!-- 标题 -->
			<view class="share-title">
				分享
			</view>
			<!-- 基本分享 -->
			<swiper display-multiple-items="5" class="share-swiper" :indicator-dots="false" :autoplay="false" :disable-touch="otherList.length > 5 ? false : true">
				<swiper-item v-for="(item, index) in baseList" :key="index">
					<view class="share-swiper-item" @click="itemTap(index)">
						<image :src="item['icon']" mode="aspectFill" class="share-swiper-item-image"></image>
						<view class="share-swiper-item-text">
							{{item['title']}}
						</view>
					</view>
				</swiper-item>
			</swiper>
			<view style="width: 100%; height: 1rpx; background-color: rgba(0, 0, 0, 0.1);"></view>
			<!-- 其它分享 -->
			<swiper display-multiple-items="5" class="share-swiper" :indicator-dots="false" :autoplay="false" :disable-touch="otherList.length > 5 ? false : true">
				<swiper-item v-for="(item, index) in otherList" :key="index">
					<view class="share-swiper-item" @click="itemTap(index+baseList.length)">
						<image :src="item['icon']" mode="aspectFill" class="share-swiper-item-image"></image>
						<view class="share-swiper-item-text">
							{{item['title']}}
						</view>
					</view>
				</swiper-item>
			</swiper>
			<!-- 关闭 -->
			<view class="share-cancel" @click="closePopup">
				取消
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				baseList: [],
				otherList: [],
			}
		},
		methods: {
			//关闭alert
			closePopup() {
				this.closeAction()
			},
			emptyAction() {},
			//分享点击
			itemTap(res) {
				var _list = this.baseList.concat(this.otherList)
				this.closeAction()
				var me = this
				setTimeout(function() {
					me.itemTapAction(_list[res]["mark"])
				}, 100)
			},
			//初始化数据
			initDataList() { 
				if (this.baseList == null || this.baseList.length == 0) {
					this.baseList = [{
							icon: "/static/images/share_wechat_icon@3x.png",
							title: "分享给\n微信好友",
							mark: "wechat"
						},
						{
							icon: "/static/images/share_wechatzone_icon@3x.png",
							title: "分享到\n朋友圈",
							mark: "wechazone"
						},
						{
							icon: "/static/images/share_weibo_icon@3x.png",
							title: "分享到\n微博",
							mark: "weibo"
						},
						{
							icon: "/static/images/share_qq_icon@3x.png",
							title: "分享给\nQQ好友",
							mark: "qq"
						},
						{
							icon: "/static/images/copy_link_icon@3x.png",
							title: "分享链接",
							mark: "sharelink"
						},
					]
				}

				if (this.otherList == null || this.otherList.length == 0) {
					this.otherList = [{
						icon: "/static/images/report_icon@3x.png",
						title: "投诉",
						mark: "report"
					}, {
						icon: "/static/images/report_icon@3x.png",
						title: "删除",
						mark: "delete"
					}, ]
				}
			}, 
			//数据更新
			updateList(baseShareItems, otherShareItems) {
				if (baseShareItems != null) {
					this.baseList = baseShareItems
				}
				
				if (otherShareItems != null) {
					this.otherList = otherShareItems 
				}
			},
		},
		props: {
			//是否弹出显示
			visible: {
				type: Boolean,
				value: false
			},
			closeAction: Function,
			itemTapAction: Function,
		},
		mounted() { 
			/*
			[
				"wechat",
				"wechazone",
				"weibo",
				"qq",
				"sharelink",
				"report",
				"delete",
			]
			*/
			this.initDataList()
		}
	}
</script>

<style>
	@import url("detail_share.css");
</style>
