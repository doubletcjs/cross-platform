<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view class="invite-friend-list-content-wapper" v-if="friendList.length > 0">
				<view class="invite-friend-list-title">
					邀请好友明细
				</view>
				<view class="invite-friend-list-cell-wapper" v-for="(friend, index) in friendList" :key="index" :style="bottomLine(index, friendList)">
					<view class="invite-friend-list-cell-items-wapper">
						<view class="invite-friend-list-cell-phone">
							{{friend.phone.substr(0,3)}}****{{friend.phone.substr(7)}}
						</view>
						<view class="invite-friend-list-cell-date-wapper">
							<view class="invite-friend-list-cell-date">
								{{handleDate(friend.createTime)}}
							</view>
							<view class="invite-friend-list-cell-time">
								{{handleTime(friend.createTime)}}
							</view>
						</view>
					</view>
					<!-- <view class="invite-friend-list-member">
						会员
					</view> -->
					<view class="invite-friend-list-notmember" v-if="friend.dicId == 1">
						非会员
					</view>
					<view class="invite-friend-list-member" v-else>
						会员
					</view>
					<!-- <view class="invite-friend-list-member" v-if="personalStatus == 1">
						会员
					</view>
					<view class="invite-friend-list-notmember" v-else>
						非会员
					</view> -->
				</view>
			</view>
			<view v-else class="nodata">
				<view class="invite-friend-list-title">
					邀请好友明细
				</view>
				<view class="nodata-text">
					暂无好友信息~
				</view>
			</view>
			<view style="width: 100%; background-color: rgba(21, 25, 54, 1);" v-if="friendList.length > 0">
				<uni-load-more iconType="auto" :status="moreStatus" :contentText="this.util.moreContentText" @clickLoadMore="loadMoreData"></uni-load-more>
			</view>
		</view>
	</view>
</template>

<script>
	import uniLoadMore from "../../components/uni-load-more/uni-load-more.vue"
	import inviteearningsapi from "./api/inviteearningsapi.js"

	export default {
		data() {
			return {
				moreStatus: "more",
				page: 1,
				limit: 10,
				friendList: [],
				personalStatus: this.util.userInfo().personalStatus
			}
		},
		methods: {
			requestData() {
				inviteearningsapi.getMyFriend(this.util.userID(), this.page, this.limit, (data, msg) => {
					if (data != null) {
						var dataList = []
						dataList = dataList.concat(data.records)
						if (this.page == 1) {
							this.friendList = dataList
						} else {
							this.friendList = this.friendList.concat(dataList)
						}

						if (dataList.length == 0 && this.page > 1) {
							this.page -= 1
						}

						if (this.page == data.pages || data.pages == 0) {
							this.moreStatus = "noMore"
						} else {
							this.moreStatus = "more"
						}
					} else {
						if (this.page > 1) {
							this.page -= 1
							this.moreStatus = "more"
						}
					}

					uni.stopPullDownRefresh()
				})
			},
			refreshData() {
				this.page = 1
				this.requestData()
			},
			loadMoreData() {
				this.moreStatus = "loading"
				this.page += 1
				this.requestData()
			},
			handleDate(res) {
				var date = res.split(" ")[0]
				return date
				// return date.split("-")[1] + "-" + date.split("-")[2]
			},
			handleTime(res) {
				var time = res.split(" ")[1]
				return time.split(":")[0] + ":" + time.split(":")[1]
			},
			bottomLine(index, list) {
				if (index == list.length - 1) {
					return ""
				} else {
					return "border-bottom: solid 2rpx rgba(255, 255, 255, 0.2); "
				}
			}
		},
		components: {
			uniLoadMore
		},
		created() {
			if (this.friendList.length == 0) {
				this.refreshData()
				console.log("getMyFriend")
			}

			var me = this
			uni.$on("inviterefresh_1", () => {
				me.refreshData()
			})

			this.personalStatus = this.util.userInfo().personalStatus;
		}
	}
</script>

<style>
	@import url("invitefriendlist.css");
</style>
