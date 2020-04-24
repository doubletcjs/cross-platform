<template>
	<view class="main-body">
		<view class="main-body-sub">
			<view v-if="isTest" class="about-app-introduction">dev_{{ version }}_{{ kQrcodeURL }}</view>
			<image src="../../../static/images/logo_guanyuwomen@3x.png" mode="aspectFit" class="about-logo-image"></image>
			<view class="about-app-introduction-wapper">
				<view class="about-app-introduction">
					<text>
						华科闪云（广东）科技有限公司（简称华科闪云）,总部位于广州市，是国内首批IPFS生态布道者，专业的分布式存储服务整体方案提供商，业界领先的IPFS & Filecoin终端服务提供商。
						&nbsp;&nbsp;&nbsp;&nbsp;华科闪云目前拥有包括IPFS硬件技术研发,IPFS协议研究,IPFS底层程序开发，IPFS应用程序研发，IDC建设及运维等在内的数十名专业IPFS技术研发人才。
						&nbsp;&nbsp;&nbsp;&nbsp;华科闪云技术研发团队在研究IPFS底层协议的基础上，全力以赴跟踪和研究Filecoin的运行机制，优化IDC机房配置，参与IPFS生态建设；并积极布局和拓展人工智能硬件及软件产品，探索为人工智能领域注入多元化的应用，为边缘计算提供可靠有效的市场策略。
						&nbsp;&nbsp;&nbsp;&nbsp;华科闪云凭借丰富的行业垂直领域技术经验，从存储器研发、网络运营合作、机房选址、到人员运维，每个环节都经过严格的把控和精心设计，华科闪云数据中心以为IPFS生态提供安全、高效、可靠的保障支持为使命，为IPFS生态体系的各层次参与者提供存储器、数据支持、知识服务、应用开发、以及高效的分布式存储解决方案等一体化服务。
					</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			isTest: this.networking.isTest,
			kQrcodeURL: this.networking.kQrcodeURL,
			version: this.util.currentAppVersion()
		};
	},
	methods: {},
	computed: {
	}
};
</script>

<style>
@import url('aboutus.css');
</style>
