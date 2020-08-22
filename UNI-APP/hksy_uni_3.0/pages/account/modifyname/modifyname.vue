<template>
	<view class="main-body">
		<view class="main-body-sub modifyname_body" style="margin-top: 0rpx;">
			<view class="modifyname_title">新昵称</view>
			<input
				type="text"
				:placeholder="this.placeholder_text"
				maxlength="11"
				v-model ="nickname"
				placeholder-class="modifyname_input_placeholder_text"
				class="modifyname_input_text"
			/>
		<view class="modifyname_line"></view>
		<view class="modifyname_buttom" @tap="modifyName">确认</view>
		</view>
		
	</view>
</template>

<script>
import accountapi from '../api/accountapi.js';

export default {
	data() {
		return {
			placeholder_text: "请输入昵称",
			nickname: this.util.userInfo().nickname,
		};
	},
	methods: {
		modifyName() {
			
			if (this.util.emptyObject(this.nickname)) {
				
				uni.showToast({
					title: this.placeholder_text,
					icon: "none"
				})
				
			} else { // 更改昵称请求
				
				if(this.nickname == this.util.userInfo().nickname) {
					uni.showToast({
						title: "昵称没有发生变化哦！",
						icon: "none"
					})
					return
				}
				
				uni.showLoading({
							
				})
							
				var me = this
				accountapi.changeAvater(
					me.nickname,
					"",
					(data, msg) => {
						if (data) {
							uni.hideKeyboard();
							uni.$emit(me.kAccountRefresh, null)
							uni.showToast({
								title: "修改昵称成功！",
								icon: "none"
							})
							setTimeout(() => {
								uni.navigateBack({
									delta: 1
								});
							}, 500);
						} else {
							uni.showToast({
								title: msg,
								icon: "none"
							})
						}
							
						uni.hideLoading()
					}
				)
				
			}
			
			
		},
	},
	onShow() {
		
	},
	components: {}
};
</script>

<style>
	@import url("modifyname.css");
</style>
