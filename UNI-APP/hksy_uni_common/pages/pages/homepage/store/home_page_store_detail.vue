<template>
	<view>
		<!-- 商铺名称 -->
		<view class="store-info">
			<image src="" mode="aspectFill" class="store-info-cover"></image>
			<view class="store-info-name">
				每日一食记的小铺
			</view>
		</view>
		<!-- 简介 -->
		<view class="store-introduction">
			商店简介
			<view class="store-introduction-content">
				浦贝陶的制作历史悠久，起源于明末清初，据说是随李自成军中一个叫李忠的部下将江西景德镇的陶器烧制技艺带至易门并在浦贝一带流传。后来经文物专家对浦贝“李忠碗窑”出土的陶器进行考证，得以证实“浦贝陶”的制作历史确为明末清初，至今已有350多年。
			</view>
		</view>
		<view class="store-base-cell" @click="showQrcode">
			<view class="store-base-cell-name">
				店铺二维码
			</view>
			<view class="store-base-row">
				<image src="/static/images/store_qrcode@3x.png" mode="" class="store-base-cell-qrcode"></image>
				<image src="/static/images/arrows_left@2x.png" mode="" class="store-base-cell-arrow"></image>
			</view>
		</view>
		<view class="store-base-cell">
			<view class="store-base-cell-name">
				所在地
			</view> 
			<view class="store-base-cell-value">
				广州
			</view>
		</view>
		<view class="store-base-cell">
			<view class="store-base-cell-name">
				开店时间
			</view>
			<view class="store-base-cell-value">
				2020-07-24
			</view>
		</view> 
		<!-- 二维码 -->
		<qrcode :visible="qrcodevisible" :closeAction="showQrcode"></qrcode>
	</view>
</template>

<script>
	import qrcode from "./home_page_store_qrcode.vue"
	
	export default {
		data() {
			return {
				qrcodevisible: false
			}
		},
		methods: {
			//店铺二维码
			showQrcode() {
				this.qrcodevisible = !this.qrcodevisible
			}
		},
		components: {
			qrcode
		}
	}
</script>

<style>
	@import url("home_page_store_detail.css");
</style>
