<script>
	export default {
		onLaunch: function() {
			console.log('App Launch')
			//#ifdef APP-PLUS
			plus.screen.lockOrientation("portrait")
			
			
			console.log('平台=1=' + uni.getSystemInfoSync().platform);
			switch (uni.getSystemInfoSync().platform) {
				case 'android':
					// 更改android虚拟键的颜色
					var Color = plus.android.importClass("android.graphics.Color");
					plus.android.importClass("android.view.Window");    
					var mainActivity = plus.android.runtimeMainActivity();    
					var window_android = mainActivity.getWindow();    
					window_android.setNavigationBarColor(Color.argb(255,28, 35, 63));  
					
					plus.navigator.closeSplashscreen(); // 没有多大的效果
					break;
				case 'ios':
					plus.navigator.closeSplashscreen();
					break;
				default:
					break;
			}

			//#endif

			this.loginStatusCheck()
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		},
		methods: {
			loginStatusCheck() { 
				
				// 一定时间强制用户退出
				let lastTime = this.util.getLoginTime()
				console.log("lastTime " + lastTime)
				if(lastTime) { // 如果登录过
					let currentTime = new Date().getTime()
					console.log("lastTime " + lastTime + " currentTime " + currentTime);
					console.log("difftime " + (currentTime - lastTime));
					if((currentTime - lastTime) > 1000 * 60 * 60 * 24 * 7) { // 一周时间
						this.util.logout()
					}
				}	
				
				let currentVersion = this.networking.currentVersion // h5的版本要手动更改
				console.log("app currentVersion " + currentVersion);
				// #ifndef H5
				currentVersion = plus.runtime.version
				// #endif 
				console.log("app currentVersion " + currentVersion);
				this.util.recordCurrentAppVersion(currentVersion); 
				var lastVersion = this.util.lastAppVersion();   
				if (lastVersion == null || lastVersion.length == 0 || currentVersion != lastVersion) {
					//显示引导页  每次安装新版本都显示
					uni.reLaunch({
						url: "/pages/guide/appguide"
					})
				} else {
					if (this.util.token() == null || this.util.token().length == 0) {
						uni.reLaunch({
							url: "/pages/account/loginregister/loginregister"
						})
					}
				}
			}
		}
	}
</script>

<style>
	/*每个页面公共css */
	page{
		background-color: rgba(21, 25, 54, 1); 
	}
	
	.main-body {
		background-color: rgba(21, 25, 54, 1);
		width: 100%;
		height: 100%;
		position: absolute;
	}
	
	.main-body-sub {
		display: flex;
		flex-direction: column;

		margin-top: 20rpx;
		padding-bottom: 20rpx;

		background-color: rgba(21, 25, 54, 1);
	}
</style>
