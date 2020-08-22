<!-- 我的钱包=>金币提现=>银行卡列表界面=>添加银行卡第二步 => 输入支付密码  只有添加第一张的银行卡才输入支付密码的 -->
<template>
	<view class="main-body">
		<view class="main_offset">
			<view class="title" v-if="isFirst">添加银行卡</view>
			<view class="title" else>输入支付密码</view>
			<view class="tip">请输入支付密码，以验证身份</view>
			<view class="pwd-box clearfix" @tap="getKeyboard">
				<view class="pwd-text" v-for="(item, index) in _digits" :key="index" :class="{ active: activeInput == index }">{{ payPassWord[index] }}</view>
			</view>
			<view class="digital-keyboard">
				<view class="new_form_edit">
					<view
						class="new_num"
						hover-class="numActive"
						v-for="item in digitalList"
						:key="item"
						:class="{ 'no-num': item === '' || item === '-1' }"
						@tap="getKeyNumber(item)"
					>
						{{ item }}
					</view>
				</view>
				<!-- 小黑条 -->
				<view class="dititalKeyboard_bottom"><view class="dititalKeyboard_bottom_black"></view></view>				
			</view>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			activeInput: 0, // 用户输入的密码的个数
			paymentPwd: '' ,// 用户输入的密码
			digitsLength: 6,
			digitalList: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '-1'],
			isFirst: 0// 有没有添加银行卡号 0 还没有添加银行卡号  标题为：输入支付密码   1 已经添加银行卡号   标题为：添加银行卡
		};
	},
	methods: {
		getKeyboard: function(e) {
			var index = e.target.dataset.index;
			if (index === undefined) return false;
			var _length = this.paymentPwd.length;
			this.activeInput = index <= _length ? index : _length;
		},
		getKeyNumber: function(val) {
			if (val === '' || (val != -1 && this.activeInput == this.digitsLength)) {
				//空或者已经达到最大值
				return false;
			} else if (val != -1) {
				//数字输入
				this.activeInput++;
				this.paymentPwd += val;
				if (this.activeInput == this.digitsLength) {
					//验证密码输入个数
					console.log("pay Password " + this.paymentPwd);
					uni.$emit('bankList_refresh');
					uni.navigateBack({
					    delta: 3
					});
					
					
				}
			} else {
				//删除
				if (this.activeInput != 0) {
					this.activeInput--;
					this.paymentPwd = this.paymentPwd.substr(0, this.activeInput);
				}
			}
		},
	},
	components: {},
	computed: {
		payPassWord() {
			var payPassWord = this.paymentPwd.split('') || [];
			payPassWord.fill('*');
			return payPassWord;
		},
		_digits() {
			let digits = [];
			digits.length = this.digitsLength;
			return digits;
		},
	},
	onLoad(option) {
		console.log(" pay " + option.isFirst);
		this.isFirst = option.isFirst
	},
};
</script>

<style>
.title {
	margin-top: 64rpx;
	height: 56rpx;
	font-size: 40rpx;
	font-weight: bold;
	line-height: 56rpx;
	color: rgba(50, 50, 50, 1);
}
.tip {
	margin-top: 8rpx;
	height: 33rpx;
	font-size: 24rpx;
	font-weight: 400;
	line-height: 33rpx;
	color: rgba(153, 153, 153, 1);
}

.clearfix {
	zoom: 1;
}

.pwd-box {
	margin-top: 27rpx;
	padding-left: 10upx;
	position: relative;
	text-align: center;
}

.pwd-text {
	position: relative;
	line-height: 110upx;
	vertical-align: middle;
	text-align: center;
	font-size: 50upx;
	font-weight: bold;
	width: 92upx;
	height: 92upx;
	margin-right: 10upx;
	display: inline-block;
	
	background:rgba(247,246,245,1);
	/* border:1px solid rgba(235,102,91,1); */ /* 边框颜色 */
	border-radius:8px;

}

.pwd-text.active:after {
	-webkit-animation: twinkle 1s infinite;
	animation: twinkle 1s infinite;
	height: 70%;
	width: 4upx;
	content: '';
	position: absolute;
	top: 15%;
	left: 50%;
	margin-left: -2upx;
	/* background-color: #EB665B; */ /* 无用到 */
}

@-webkit-keyframes twinkle {
	from {
		background-color: #EB665B;  /** 光标颜色 */
	}

	to {
		background-color: transparent;
	}
}

@keyframes twinkle {
	from {
		background-color: #EB665B;  /** 光标颜色 */
	}

	to {
		background-color: transparent;
	}
}

.digital-keyboard {
	
	width: 100%;
	height: 581rpx;
	position: absolute;
	bottom: 0rpx;
	left: 0rpx;
	background:rgba(204,206,211,0.76); /** 键盘背景色 */
}

/* 键盘 */
.new_form_edit {
	margin-left: 12rpx;
	margin-right: 12rpx;
	margin-top: 14rpx;
	height: 404rpx; /* 92 * 4 + 12 * 3 算出来的 */
	
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: stretch;
	align-content: space-between;
	flex-wrap: wrap;
}

.new_num {
	width: 32.5%;
	font-size:50rpx;
	line-height:92rpx;
	color:rgba(0,0,0,1);
	text-align: center;
	font-weight: bold;
	height:92rpx;
	background:rgba(252,252,254,1);
	box-shadow:0rpx 1rpx 0rpx rgba(137,138,141,1);
	border-radius:16rpx;

}


.new_num.no-num {
	background:transparent;
	box-shadow:0rpx 0rpx 0rpx transparent;
	border-radius:0rpx;
}

.new_num:last-child {
	box-shadow:0rpx 0rpx 0rpx transparent;
	border-radius:0rpx;
	font-size: 0;
	background: transparent url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGAAAABICAYAAAAJZ/BjAAAFUUlEQVR4Xu2dj3EVIRCHNxWYDtQKNBWoFagVqBVoKtBUoFagVqCpQFOBWoGxAk0FOt/zEe/dAxbulj+XHDOZySh3B78P2AUWciD9pEMRuScid0Xk/rZYt0SEnx7TbxH5ti3Yl+3vZyLCvyeng+Sc5TI+FJEXA9HLfanOm4HxXkQ+pHyuJQBa+buOW3iKfrE85yJyLCKfYplaAGCoQfhHc2u4kOfpEY9DQ1NtAIj/eTvOL0Q/k2JiK54NbMblS2sCwJh+FREgxNLFtqC0HJeGv5soMvMlOAquHgyl1O2m8k6M85GIMDRVB0CBafkx8TFab3ytZKZYtR4HAs7EUxG5EfgoPeHBcDiq0QM08XHdKPROy6ilWoHvAIKGhHfnSxhlbMImlQagiU+rR/yrmF6JyMtAxegFm2G1JIDrLL7TPQSB3n67JABN/Lfb8fIqtvxxnWjpzPDHadMLSvQATfwTEaFlXJeETfjhqewpcyFrAJr4+MJM069bos5PPJU+sASwih9uVsz6P/qGISsAq/h6n/7jyXJiAUAT/zoZ3BgGnzGeDUAT/yr7+Xqb383BBGw8OTub0wNW8fMQ+OYEkwGs4ueJT24zAKv4+eKbAVjFnya+CQBNfLbfWAUsmVjOfr3dTcOrYGKXtQmeUDhmru4bTKCol8U3vOtCqUZYE7/WDHc8o9xbX08QOJbFt2Nn5clNBtCL+Ajn86WtIIS2S9mvcGEyc/hOAtCT+FSeIe65R4W5EGJ71VaLh9kAehMf3RGKXnDHEEJM/O+GAQRZAHoU32luCUETn6HHwgCHvCDvjljP4ltCqCl+MoAliG8Bobb4SQAoFDs3odCRWq5mjqcxZThqIb4KQItY61H8KT2hlfgqAHZrQrGaPYufA4G8obBIvB1Lg+vrxUEviA9TMF9a0maKNhxRP2zcONUQP9oDQhvGVlPwnDF9bt4YBN+7a4kfBYDhHZ9C2YRMzFWj0fOpEGqKHwXg2ywmdjF6sKCRuKmf1SDUFj8bwBIMbwyG5tXNXTtKbQjDfEEjTJziOLa9RQGnVMr3jCa+e6Z2HYMAQkZ4J4zaSp3C70kVvwWESW4ocBiOlpC0SRZ1sFxFzdUkuhoaWmfnI0uAoInvNlSsl7JzIKjL0aEw6t4hpIjvlpS1ydrO8aEcdRPyqgA0163HnpAjvtOoFQQVAAVcEoQp4reEkARgKRDmiN8KQjKA3iFYiN8CQhaAXiGwZsXKre8GlanLC5pNYFnG4ghtNoAeIfhCvCnnVPFTeoLVwuQkAL1B8LnKc8XXIDQNzNIK5/6/los6bkVW4sfq2Swwazy36MVF5WQ9PwxHpYKBufOB/RDLb/iGoIvU4NzeekLCxLO7LGYHNHrpCd0prBTIDEBvhnkpIEwBrBDysZsDWCHkQfC50Ke5Rtj3ydUmpIHgurZxXNLsg9qrd5QmPo30lyfrsUUPWCHoEJi3cFXnOB1ZAlhtQhgEC4jjc2bcDnloDWCFsA8hFHu7Cf0sAWCF8B8CYz/G17d8zp1x56UArBD+QQiF/V+usJYEkAKBxa4Sp911s1g2By0/dj/2pvVThNIAUiBQECD0dj3xVETarfA7y9s1AKRAII+7d58dKKujoVNFzH2OFs9lTLibsVP1e7trtQCkQnAVJ3DW/YWKXmEgurvE23fyZgzRu3lUE4CDwO5Z6F7l3Ja3lPy0fHrHXmOqDcAJFrtXeSmippYzuqXZCgCFxzemN/iu9U2tXM/5km6FbwnAiQcIegR7sKF793sWeli2n1tngvokxRL1AGBYAfcnrIYGrmfxnaOA2HhxSaIPK/QX6MaX+wQkmMgAAAAASUVORK5CYII=) center center / auto 50upx no-repeat;
}

.dititalKeyboard_bottom {
	height: 68rpx;
	display: flex;
	justify-content: center;
}

.dititalKeyboard_bottom_black {
	width:268rpx;
	height:10rpx;
	margin-top: 128rpx;
	margin-bottom: 18rpx;
	background:rgba(0,0,0,1);
	border-radius:100rpx;
}

</style>
