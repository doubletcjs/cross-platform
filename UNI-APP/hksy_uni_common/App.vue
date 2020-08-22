<script>
	export default {
		onLaunch: function() {
			console.log('App Launch')
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		}
	}
</script>

<style>
	/*每个页面公共css */
	.main-body {
		background-color: rgba(255, 255, 255, 1); 
		width: 100%;
		height: 100%;
		position: absolute;
	} 
	.main-body-two {
		background-color: rgba(247,246,245,1); 
		width: 100%;
		height: 100%;
		position: absolute;
	}
	.main_offset {
		margin-left: 32rpx;
		margin-right: 32rpx;
	}
	
</style>
