<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="share-content" @click.stop="emptyAction">
			<!-- 标题 -->
			<view class="share-title">
				分享
			</view>
			<!-- 基本分享 -->
			<swiper next-margin="-34rpx" display-multiple-items="4" class="share-swiper" :indicator-dots="false" :autoplay="false" :disable-touch="shareList.length > 4 ? false : true">
				<swiper-item v-for="(item, index) in shareList" :key="index">
					<view class="share-swiper-item" @click="itemTap(index)" style="width: 80%;">
						<image :src="item['icon']" mode="aspectFill" class="share-swiper-item-image"></image>
						<view class="share-swiper-item-text">
							{{item['title']}}
						</view>
					</view>
				</swiper-item>
			</swiper>
			<!-- 关闭 -->
			<view class="share-cancel" @click="closePopup" style="margin-top: 120rpx;">
				取消
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				shareList: []
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
				this.closeAction()
				var me = this
				setTimeout(function() {
					me.itemTapAction(me.shareList[res]["mark"])
				}, 100)
			},
			//初始化数据
			initDataList() {
				if (this.shareList == null || this.shareList.length == 0) {
					this.shareList = [{
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
					]
				}
			},
			//数据更新
			updateList(list) {
				if (list != null) {
					this.shareList = list
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
			this.initDataList()
		}
	}
</script>

<style>
	@import url("../../detail/components/detail_share.css");
</style>
