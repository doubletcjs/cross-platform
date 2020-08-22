<template>
	<view :class="visible == true ? 'i-modal-mask i-modal-mask-show' : 'i-modal-mask'" @click="closePopup">
		<view class="dititalKeyboard-content" @click.stop="emptyAction">
			<!-- 标题 -->
			<view class="title_wrapper">
				<view class="title_text">输入验证码</view>
				<view class="close_wrapper"><view class="close_text" @click="closePopup">X</view></view>
			</view>
			<view class="code_tip">
				验证码已发送到您{{showPhoneNumber}}
			</view>
			<!-- 数字小键盘 -->
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
			activeInput: 0, // 用户输入的验证码的个数
			digitalList: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '-1'],
			paymentPwd: '' // 用户输入的验证码
		};
	},
	computed: {
		payPassWord() {
			var payPassWord = this.paymentPwd.split('') || [];
			// payPassWord.fill('*');
			return payPassWord;
		},
		_digits() {
			let digits = [];
			digits.length = this.digits;
			return digits;
		},
		showPhoneNumber() {
			return this.phoneNumber.substr(0, 3) + '****' + this.phoneNumber.substr(this.phoneNumber.length - 4, this.phoneNumber.length);
		}
	},
	methods: {
		//关闭alert
		closePopup() {
			
			setTimeout(() => {
				this.initData()
			}, 500)
			this.closeAction();
			
		},
		emptyAction() {},
		getKeyNumber: function(val) {
			if (val === '' || (val != -1 && this.activeInput == this.digits)) {
				//空或者已经达到最大值
				return false;
			} else if (val != -1) {
				//数字输入
				this.activeInput++;
				this.paymentPwd += val;
				if (this.activeInput == this.digits) {
					//验证密码输入个数
					this.closePopup();
					return this.$emit('itemTapAction', this.paymentPwd);
				}
			} else {
				//删除
				if (this.activeInput != 0) {
					this.activeInput--;
					this.paymentPwd = this.paymentPwd.substr(0, this.activeInput);
				}
			}
		},
		getKeyboard: function(e) {
			var index = e.target.dataset.index;
			if (index === undefined) return false;
			var _length = this.paymentPwd.length;
			this.activeInput = index <= _length ? index : _length;
		},
		initData: function() {
			this.paymentPwd = "";
			this.activeInput = 0;
		}
	},
	props: {
		//是否弹出显示
		visible: {
			type: Boolean,
			value: false
		},
		digits: {
			// 输入的长度
			type: [Number, String],
			default: 6
		},
		phoneNumber: {
			type: String,
			default: ""
		},
		closeAction: Function
	}
};
</script>

<style>
@import url('codeKeyboard.css');
</style>
