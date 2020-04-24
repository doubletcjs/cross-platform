<template>
	<view class="version-alert-wapper" v-if="versionInfo != null">
		<image src="/static/images/app_update@3x.png" mode="widthFix" style="width: 480rpx;"></image>
		<view class="version-alert-title">{{ getVersion(versionInfo) }}版本系统升级</view>
		<view class="version-alert-content-wapper">
			<view class="version-alert-content" v-for="(info, index) in infoList(versionInfo.readme)" :key="index">{{ info }}</view>
		</view>
		<view class="version-alert-download" @tap="updateVersion(versionInfo.android_download)">升级新版本</view>

		<!-- <image src="/static/images/ico_del@3x.png" mode="" class="version-alert-close" @tap="closeHandle"></image> -->
	</view>
</template>

<script>
export default {
	data() {
		return {};
	},
	methods: {
		getVersion(info) {
			return uni.getSystemInfoSync().platform == 'android' ? info.android_version : info.ios_version;
		},
		infoList(infos) {
			return infos.split(';');
		},
		updateVersion(down_url) {
			if (uni.getSystemInfoSync().platform === 'android') {
				// android处理
				console.log('运行Android上');
				console.log('down_url ' + down_url);

				//设置 最新版本apk的下载链接
				var downloadApkUrl = down_url;
				var dtask = plus.downloader.createDownload(downloadApkUrl, {}, function(d, status) {
					// 下载完成
					if (status == 200) {
						plus.runtime.install(plus.io.convertLocalFileSystemURL(d.filename), {}, {}, function(error) {
							uni.showToast({
								title: '安装失败',
								duration: 1500
							});
						});
					} else {
						uni.showToast({
							title: '更新失败',
							duration: 1500
						});
					}

					console.log('status ' + status);
				});

				try {
					dtask.start(); // 开启下载的任务
					var prg = 0;
					var showLoading = plus.nativeUI.showWaiting('正在下载'); //创建一个showWaiting对象
					dtask.addEventListener('statechanged', function(task, status) {
						// 给下载任务设置一个监听 并根据状态  做操作
						switch (task.state) {
							case 1:
								showLoading.setTitle('正在下载');
								break;
							case 2:
								showLoading.setTitle('已连接到服务器');
								break;
							case 3:
								prg = parseInt((parseFloat(task.downloadedSize) / parseFloat(task.totalSize)) * 100);
								showLoading.setTitle('  正在下载' + prg + '%  ');
								break;
							case 4:
								plus.nativeUI.closeWaiting();
								//下载完成
								break;
						}
					});
				} catch (err) {
					plus.nativeUI.closeWaiting();
					uni.showToast({
						title: '更新失败',
						mask: false,
						duration: 1500
					});
				}

				this.closeHandle();
			} else {
				console.log('运行iOS上');
				plus.runtime.openURL(this.vsersion.ios_download, function(res) {
					// console.log(res);
					this.closeHandle();
				});
			}
		}
	},
	props: {
		versionInfo: null,
		closeHandle: Function
	}
};
</script>

<style>
@import url('versionpopalert.css');
</style>
