<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup" @longtap="emptyAction">
		<view id="menu" class="menu-content" @click.stop="emptyAction" :style="fetchFrame()">
			<view class="menu-item-cell" v-for="(item, index) in menuList" :key="index" :data-index="index" @click.stop="menuItemSelect">
				<view class="menu-item-cell-name">
					{{item}}
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {

			}
		},
		methods: {
			//关闭alert
			closePopup() {
				this.closeAction()
			},
			emptyAction() {},
			//计算坐标
			fetchFrame() {
				var _itemW = 109*2;
				var _itemH = 48 * 2 * this.menuList.length; 

				var _clientX = this.clientX * 2
				var _clientY = this.clientY * 2
				if (_clientX < 0) {
					_clientX = 0
				} 

				var _screenW = uni.getSystemInfoSync().windowWidth*2-64
				var _screenH = uni.getSystemInfoSync().windowHeight*2 
				
				if (_clientX + _itemW > _screenW) {
					_clientX = _screenW - _itemW
				}
				
				if (_clientY + _itemH > _screenH) {
					_clientY = _screenH - _itemH
				}

				var style = "left: " + _clientX + "rpx;" + " " + "top: " + _clientY + "rpx;" 
				return style
			},
			// 选择
			menuItemSelect(res) {
				var index = res.currentTarget.dataset.index 
				this.itemAction(this.menuList[index])
			}
		},
		props: {
			//是否弹出显示
			visible: {
				type: Boolean,
				value: false
			},
			closeAction: Function,
			clientX: {
				type: Number,
				value: 0.0
			},
			clientY: {
				type: Number,
				value: 0.0
			},
			menuList: {
				type: Array,
				value: []
			},
			itemAction: Function,
		}
	}
</script>

<style>
	@import url("drop_down_menu.css");
</style>
