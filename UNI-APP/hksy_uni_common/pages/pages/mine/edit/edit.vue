<!-- 编辑资料 -->
<template>
	<view class="main-body-two">
		<view class="headPortrait_item_wrapper">
			<view class="item_text">头像</view>
			<view><image class="hp_image" src="../../../../static/images/homepage_head_icon@3x.png" mode="aspectFill" @tap="changeAvater"></image></view>
			<view><image class="arrows_image" src="../../../../static/images/arrows_left@2x.png" mode="aspectFill"></image></view>
		</view>
		<view class="line"></view>
		<view class="item_wrapper">
			<view class="item_text">街角号</view>
			<view class="value_id_text">123456</view>
		</view>
		<view class="line"></view>
		<view class="item_wrapper">
			<view class="item_text">呢称</view>
			<view class="value_text" @click="toNickName">{{ userName }}</view>
			<view><image class="arrows_image" src="../../../../static/images/arrows_left@2x.png" mode="aspectFill"  @click="toNickName"></image></view>
		</view>
		<view class="line"></view>
		<view class="item_wrapper">
			<view class="item_text">性别</view>
			<view class="value_text" @click="OCGenderDialog">{{ gender }}</view>
			<view><image class="arrows_image" src="../../../../static/images/arrows_left@2x.png" mode="aspectFill" @click="OCGenderDialog"></image></view>
		</view>
		<view class="line"></view>
		<view class="item_wrapper">
			<view class="item_text">地区</view>
			<!-- <view class="value_text">{{ area }}</view> -->
			<picker mode="multiSelector" @columnchange="bindMultiPickerColumnChange" :value="multiIndex" :range="multiArray">
				<view class="value_text">{{ multiArray[0][multiIndex[0]] }}，{{ multiArray[1][multiIndex[1]] }}</view>
			</picker>
			<view><image class="arrows_image" src="../../../../static/images/arrows_left@2x.png" mode="aspectFill"></image></view>
		</view>
		<view class="line"></view>
		<view class="item_wrapper">
			<view class="item_text">生日</view>
			<!-- <view class="value_text">{{ birthday }}</view> -->
			<picker mode="date" :value="date" :start="startDate" :end="endDate" @change="bindDateChange">
				<view class="value_text">{{ date }}</view>
			</picker>
			<view><image class="arrows_image" src="../../../../static/images/arrows_left@2x.png" mode="aspectFill"></image></view>
		</view>
		<view class="line"></view>
		<view class="item_wrapper">
			<view class="item_text">个人简介</view>
			<view class="value_text" style="width: 430rpx;" @click="toEditIntro">{{ intro }}</view>
			<view><image class="arrows_image" src="../../../../static/images/arrows_left@2x.png" mode="aspectFill"></image></view>
		</view>
		<!-- 性别对话框 -->
		<genderDialog :visible="genderDialogVisible" :closeAction="OCGenderDialog" :itemTapAction="selectGenderAction"></genderDialog>
	</view>
</template>

<script>
import genderDialog from '../components/genderDialog.vue';

function getDate(type) {
	const date = new Date();

	let year = date.getFullYear();
	let month = date.getMonth() + 1;
	let day = date.getDate();

	if (type === 'start') {
		year = year - 60;
	} else if (type === 'end') {
		year = year + 2;
	}
	month = month > 9 ? month : '0' + month;
	day = day > 9 ? day : '0' + day;

	return `${year}-${month}-${day}`;
}

export default {
	data() {
		return {
			userName: '我是用户名',
			gender: '男',
			area: '广东 广州',
			birthday: '1998-10-10',
			intro: '这个人很懒什么都没写多出不显示出来',
			genderDialogVisible: false,
			multiArray: [['北京', '上海', '广东', '四川', '湖南'], ['昌平', '海淀', '丰台']], // 这只是第一列第一个和他拖动的第二列的数据
			multiIndex: [0, 0],
			date: getDate({
				format: true
			}),
			startDate: getDate('start'),
			endDate: getDate('end')
		};
	},
	methods: {
		changeAvater() {
			//  更改头像
			var me = this;
			uni.chooseImage({
				count: 1,
				success(chooseImageRes) {
					uni.showLoading({});
					uni.hideLoading();
				},
				fail(error) {
					if (error.msg) {
						uni.showToast({
							title: error.msg,
							icon: 'none'
						});
					}
				}
			});
		},
		// 打开和关闭选择性别对话框
		OCGenderDialog() {
			this.genderDialogVisible = !this.genderDialogVisible;
		},
		// 回调返回选中性别的名字
		selectGenderAction(res) {
			console.log(res);
			this.gender = res
		},
		bindMultiPickerColumnChange: function(e) {
			console.log('修改的列为：' + e.detail.column + '，值为：' + e.detail.value);
			this.multiIndex[e.detail.column] = e.detail.value;
			switch (e.detail.column) {
				case 0: //拖动第1列
					switch (this.multiIndex[0]) {
						case 0:
							this.multiArray[1] = ['昌平', '海淀', '丰台'];
							break;
						case 1:
							this.multiArray[1] = ['上一', '上二'];
							break;
						case 2:
							this.multiArray[1] = ['天河', '白云'];
							break;
						case 3:
							this.multiArray[1] = ['四一', '四二'];
							break;
						case 4:
							this.multiArray[1] = ['湖一', '湖二'];
							break;
					}
					this.multiIndex.splice(1, 0);
					this.multiIndex.splice(2, 0);
					break;
			}
			this.$forceUpdate();
		},
		bindDateChange: function(e) {
			this.date = e.detail.value;
		},
		toEditIntro() {
			uni.navigateTo({
				url: './editIntro?intro=' + this.intro
			});
		},
		toNickName() {
			uni.navigateTo({
				url: './editNickname?nickname=' + this.userName
			});
		}
		
	},
	components: {
		genderDialog
	},
	created() {
		let me = this;
		uni.$on('mine_edit_refresh', () => {
			// 我的个人简介和昵称修改转出回调更新
			setTimeout(() => {
				console.log('更新了.....');
			}, 0);
		});
	},
	onUnload() {
		console.log('onUnload--------');
		uni.$off('mine_edit_refresh');
	}
};
</script>

<style>
.headPortrait_item_wrapper {
	height: 159rpx;
	padding-left: 32rpx;
	background: rgba(255, 255, 255, 1);

	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-items: center;
}

.item_text {
	flex: 1;
	height: 160rpx;
	font-size: 32rpx;
	line-height: 160rpx;
	color: rgba(50, 50, 50, 1);
}

.hp_image {
	width: 80rpx;
	height: 80rpx;
	border-radius: 50%;
}

.arrows_image {
	width: 13rpx;
	height: 24rpx;
	margin-left: 16rpx;
	margin-right: 32rpx;
}

.line {
	margin-left: 32rpx;
	border-bottom: solid 1rpx rgba(0, 0, 0, 0.05);
}

.item_wrapper {
	height: 96rpx;
	padding-left: 32rpx;
	background: rgba(255, 255, 255, 1);

	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-items: center;
}

.value_id_text {
	height: 96rpx;
	margin-right: 34rpx;
	font-size: 32rpx;
	line-height: 96rpx;
	color: rgba(153, 153, 153, 1);
}

.value_text {
	height: 96rpx;
	font-size: 32rpx;
	line-height: 96rpx;
	color: rgba(153, 153, 153, 1);

	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>
