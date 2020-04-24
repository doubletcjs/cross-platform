<template>
	<view class="main-body">
		<view class="main-body-sub">
			<!-- <web-view :src="poolUrl" v-if="poolUrl.length > 0"></web-view> -->
			<view class="storage-box">
				<view class="storage-title">网络概览 Network Overview</view>
				<view class="storage-data">
					<view class="storage-data-item">
						<view class="storage-data-item-top">
							<text class="storage-data-item-text" space="ensp">Best Tipest</text>
							<image class="storage-data-item-img" src="../../static/images/question@3x.png" mode=""></image>
						</view>
						<view class="storage-data-item-middle">
							<text class="storage-data-item-middle-text" space="ensp">#43260</text>
						</view>
						<view class="storage-data-item-bottom">
							<text class="storage-data-item-bottom-text" space="ensp">Block Height（块高度）</text>
						</view>
					</view>
					<view class="storage-data-item">
						<view class="storage-data-item-top">
							<text class="storage-data-item-text" space="ensp">Avg.Pri of storage</text>
							<image class="storage-data-item-img" src="../../static/images/question@3x.png" mode=""></image>
						</view>
						<view class="storage-data-item-middle2">
							<text class="storage-data-item-middle-text" space="ensp">0.09</text>
							<view class="storage-data-item-middle-b-text">FIL/GB/MO</view>
						</view>
						<view class="storage-data-item-bottom storage-data-item-bottom2">
							<text class="storage-data-item-bottom-text" space="ensp">
								<text style="margin-right: 30rpx;color: #00EAB5;">0%</text>
								<text>(24hrs)</text>
							</text>
						</view>
					</view>
				</view>
				<view class="storage-data-echart">
					<view class="storage-data-echart-title">Avg.Pri of storage</view>
					<view class="storage-data-echart-title-msg">Storage Price（储存均价）</view>
					<view class="qiun-charts">
						
						<canvas canvas-id="canvasLineA"  id="canvasLineA" class="charts" @touchstart="touchLineA">
							<view class="qiun-charts-line" :style="objstyle"></view>
						</canvas>
					</view>
				</view>
				<view class="storage-msg-tip">
					<view class="storage-msg-tip-text">
						Beta版本所有内容为官方测试数据仅做展示 具体数据以正式版为准
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	import uCharts from '../../components/u-charts/u-charts.js';
	var _self;
	var canvaLineA = null;
	export default {
		data() {
			return {
				poolUrl: this.networking.kQrcodeURL.search("hkicloud") == true ? (this.networking.kQrcodeURL +
					"/invite/orepool.html") : "http://39.100.54.18:8080/",
				cWidth: '',
				cHeight: '',
				pixelRatio: 1,
				chartData: {
					categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
					series: [{
						name: '',
						data: [12080, 2200, 13380, 6080, 13080, 7223,12180,9040,13020,5080,13080,6089],
						color: '#1760FF'
					}]
				},
				objstyle:{
					top: '348rpx'
				}

			}
		},
		onLoad() {
			_self = this;
			uni.getSystemInfo({
				success: function(res) {
					if (res.pixelRatio > 1) {
						//正常这里给2就行，如果pixelRatio=3性能会降低一点
						//_self.pixelRatio =res.pixelRatio;
						_self.pixelRatio = 1;
					}
				}
			});
			this.cWidth = uni.upx2px(702);
			this.cHeight = uni.upx2px(400);
			this.showLineA('canvasLineA', this.chartData);
		},
		methods: {
			showLineA(canvasId, chartData) {
				_self = this;
				canvaLineA = new uCharts({
					$this: _self,
					canvasId: canvasId,
					type: 'line',
					fontSize: 12,
					legend: {
						show: false
					},
					dataLabel: false, // 原点字体显示
					disabled:true,
					dataPointShape: true,
					background: '#FFFFFF',
					pixelRatio: _self.pixelRatio,
					categories: _self.chartData.categories,
					series: _self.chartData.series,
					animation: true,
					xAxis: {
						type: 'grid',
						// gridColor: '#CCCCCC',
						gridType: 'line',
						disableGrid:true,
						fontColor:'#9198AD',
						gridEval:1,
						splitNumber:0
					},
					yAxis: {
						gridColor: '#CCCCCC',
						disableGrid:true,
						disabled:true,
						axisLine:false,
						axisLineColor:'#D3D3D3',
						splitNumber: 0,
						fontColor:'#9198AD',
						gridType: 'line',
						min: 10,
						max: 180,
						// disabled:true,
						gridColor:'#9198AD',
						data:{
							calibration:true,
							titleFontColor:'#fff'
						},
						format: (val) => { 
							return val.toFixed(0) + '元'
						}
					},
					width: _self.cWidth * _self.pixelRatio,
					height: _self.cHeight * _self.pixelRatio,
					extra: {
						line: {
							type: 'none'
						}
					}
				});

			},
			touchLineA(e) {
				canvaLineA.showToolTip(e, {
					format: function(item, category) {
						return category + ' ' + item.name + ':' + item.data
					}
				});
			}
		}
	}
</script>

<style>
	@import url("./storagepage.css");
</style>
