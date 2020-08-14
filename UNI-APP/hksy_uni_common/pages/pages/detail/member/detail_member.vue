<template>
	<view>
		<!-- 搜索 -->
		<view class="detail-member-search-content">
			<view class="detail-member-search-mask">
				<!-- 图标 -->
				<image src="/static/images/home_tab_search_icon@3x.png" mode="" class="detail-member-search-icon"></image>
				<input type="text" class="detail-member-search-input" placeholder="搜索成员" placeholder-class="detail-member-search-input-placeholder"
				 @input="keyworkInput" />
			</view>
		</view>
		<!-- 列表 -->
		<view class="detail-member-list-content" :style="edittingList == true ? 'margin-bottom: 96rpx;' : ''">
			<view v-if="searchList.length > 0">
				<!-- 搜索结果 -->
				<view class="detail-member-cell" v-for="(item, index) in searchList" :key="index">
					<!-- 头像 -->
					<image src="" mode="aspectFill" class="detail-member-cell-avatar" style="background-color: rgba(153, 153, 153, 0.3);"></image>
					<!-- 名称 -->
					<view class="detail-member-cell-name">
						用户名
					</view>
				</view>
			</view>
			<view v-else>
				<!-- 落主、管理员 -->
				<view class="detail-member-section" style="border-bottom: solid 24rpx rgba(247, 246, 245, 1);">
					<view class="detail-member-section-title">
						落主、管理员
					</view>
					<view class="detail-member-cell" v-for="(item, index) in adminList" :key="index" id="admin-cell" :data-index="index"
					 @longtap="adminLongPress">
						<!-- 头像 -->
						<image src="" mode="aspectFill" class="detail-member-cell-avatar" style="background-color: rgba(153, 153, 153, 0.3);"></image>
						<!-- 名称 -->
						<view class="detail-member-cell-admin-name">
							用户名
						</view>
						<!-- 管理员 -->
						<view class="detail-member-cell-blogger" v-if="index == 0">
							落主
						</view>
						<view class="detail-member-cell-admin" :style="edittingList == true ? 'right: 116rpx;' : ''" v-else>
							管理员
						</view>
						<image src="/static/images/detail_member_chose@3x.png" mode="aspectFit" class="detail-member-cell-select" v-if="edittingList == true && index > 0"></image>
					</view>
				</view>
				<!-- 成员 -->
				<view class="detail-member-section">
					<view class="detail-member-section-title">
						成员
					</view>
					<view class="detail-member-cell" v-for="(item, index) in memberList" :key="index" id="member-cell" :data-index="index"
					 @longtap="memberLongPress">
						<!-- 头像 -->
						<image src="" mode="aspectFill" class="detail-member-cell-avatar" style="background-color: rgba(153, 153, 153, 0.3);"></image>
						<!-- 名称 -->
						<view class="detail-member-cell-name">
							用户名
						</view>
						<image src="/static/images/detail_member_chose@3x.png" mode="aspectFit" class="detail-member-cell-select" v-if="edittingList == true"></image>
					</view>
				</view>
			</view>
		</view>
		<!-- 底部栏 -->
		<view class="detail-member-bottom" v-if="edittingList == true">
			<view class="detail-member-bottom-base-row">
				<view class="detail-member-bottom-select">
					已选
				</view>
				<view class="detail-member-bottom-select-number">
					0
				</view>
			</view>
			<view class="detail-member-bottom-base-row">
				<view class="detail-member-bottom-cancel" @click="edittingList = false">
					取消
				</view> 
				<view class="detail-member-bottom-delete">
					删除成员
				</view> 
			</view>
		</view>
		<!-- 菜单 -->
		<dropdownmenu :visible="menuvisible" :closeAction="menuAction" :clientX="clientX" :clientY="clientY" :menuList="menuList"
		 :itemAction="menuItemAction"></dropdownmenu>
	</view>
</template>

<script>
	import dropdownmenu from "../components/drop_down_menu.vue"

	export default {
		data() {
			return {
				adminList: [
					"",
					"",
					"",
				],
				memberList: [
					"",
					"",
					"",
					"",
					"",
					"",
				],
				searchList: [

				],
				menuvisible: false,
				clientX: 0.0,
				clientY: 0.0,
				menuList: [],
				adminIndex: 0,
				memberIndex: 0,
				edittingList: false
			}
		},
		methods: {
			//搜索输入
			keyworkInput(res) {
				var keywork = res.detail.value
				this.searchList = []
				for (var i = 0; i < keywork.length; i++) {
					this.searchList.push("")
				}
			},
			//菜单长按事件 
			adminLongPress(res) {
				// 处理长按事件   
				this.menuList = [
					"取消管理员",
					"转让落主",
					"批量管理",
					"删除该成员",
				]
				this.menuCoordinate(res)
			},
			memberLongPress(res) {
				// 处理长按事件 
				this.menuList = [
					"设置管理员",
					"批量管理",
					"删除该成员",
				]
				this.menuCoordinate(res)
			},
			//菜单事件 
			menuCoordinate(res) {
				if (this.edittingList == false) {
					var touches = res.touches
					var touch = touches[0]
					this.clientX = touch.clientX
					this.clientY = touch.clientY
					
					this.menuAction()
					
					var index = res.currentTarget.dataset.index
					var id = res.currentTarget.id
					if (id == "member-cell") {
						this.memberIndex = index
					} else if (id == "admin-cell") {
						this.adminIndex = index
					}
				} 
			},
			menuAction() {
				this.menuvisible = !this.menuvisible
			},
			menuItemAction(res) {
				this.menuAction()

				if (res == "删除该成员") {
					uni.showModal({
						title: "是否删除成员【布丁】",
						cancelText: "取消",
						confirmText: "删除",
						cancelColor: "#323232",
						confirmColor: "#EB665B",
						complete() {

						},
						fail(error) {

						}
					})
				} else if (res == "设置管理员") {
					uni.showModal({
						title: "是否设置成员【布丁】为管理员",
						cancelText: "取消",
						confirmText: "设置管理员",
						cancelColor: "#323232",
						confirmColor: "#EB665B",
						complete() {

						},
						fail(error) {

						}
					})
				} else if (res == "取消管理员") {

				} else if (res == "转让落主") {
					uni.showModal({
						title: "是否设置【布丁】为落主，转让后则你成为普通成员",
						cancelText: "取消",
						confirmText: "转让落主",
						cancelColor: "#323232",
						confirmColor: "#EB665B",
						complete() {

						},
						fail(error) {

						}
					})
				} else if (res == "批量管理") {
					this.edittingList = true
				}
			}
		},
		components: {
			dropdownmenu
		}
	}
</script>

<style>
	@import url("detail_member.css");
</style>
