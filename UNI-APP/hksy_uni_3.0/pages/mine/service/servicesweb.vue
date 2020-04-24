<template>
	<view class="main-body">
		<view class="main-body-sub" style="margin-top: 0rpx;">
			<text class="services-web-tip">
				您好，现在客服不在线，请留言。如果没有留下您的联系方式，客服将无法和您联系！
			</text>
			<view class="services-web-textarea-wapper">
				<textarea id="message" :value="messagecontent" placeholder="请输入您的留言" placeholder-style="color:#9198AD" 
				 class="services-web-textarea" @input="textFieldOnchanged" />
			</view> 
			<view class="services-web-contact-tip">
				留下以下信息，方便与您及时联系
			</view>
			<view class="services-web-input-placeholder" style="margin-top: 40rpx;">
				<view class="services-web-input-tip">
					姓名：
				</view>
				<input type="text" id="name" :value="name" class="services-web-input" placeholder-class="services-web-textarea-placeholder" placeholder="请输入您的姓名" @input="textFieldOnchanged" />
			</view>
			<view class="services-web-input-placeholder" style="margin-top: 30rpx;">
				<view class="services-web-input-tip">
					手机：
				</view>
				<input type="number" id="cellphone" :value="cellphone" maxlength="11" class="services-web-input" placeholder-class="services-web-textarea-placeholder" placeholder="请输入您的手机号码" @input="textFieldOnchanged" />
			</view>
			<view class="services-web-confirm" @tap="confirmAction">
				提交留言
			</view>
		</view>
	</view>
    <!-- <view>
        <web-view :src="baseURL"></web-view>
    </view> -->
</template>

<script>
    export default {
        data() {
            return {
                //baseURL: "https://tb.53kf.com/code/app/572e949b8197624a50c474c2d88966af/1?device=ios"
				cellphone: "",
				name: "",
				messagecontent: ""
            }
        },
        methods: {  
			textFieldOnchanged(res) {
				var textfieldId = res.target.id
				var textfieldText = res.target.value
				if (textfieldId == "name") {
					this.name = textfieldText
				} else if (textfieldId == "cellphone") {
					this.cellphone = textfieldText
				} else if (textfieldId = "message") {
					this.messagecontent = textfieldText
				}
			},
			confirmAction() {
				if (this.util.emptyObject(this.messagecontent) == true) {
					uni.showToast({
						title: "请输入您的留言内容",
						icon: "none"
					})
				
					return
				}
				
				if (this.util.emptyObject(this.name) == true) {
					uni.showToast({
						title: "请输入您的姓名",
						icon: "none"
					})
				
					return
				}
				
				if (this.util.validateMobile(this.cellphone) == false) {
					uni.showToast({
						title: "请输入正确的手机号",
						icon: "none"
					})
				
					return
				}
				
				uni.showLoading({
					
				})
				this.networking.functionRequest('/addMessage',null,{userId:this.util.userID(),userneame:this.name,phone:this.cellphone,message:this.messagecontent},null,(res)=>{
					
					uni.hideLoading();
					uni.showToast({
						title:res,
						icon:'none'
					});
					this.cellphone = "";
					this.name = "";
					this.messagecontent = "";
				})
				
			}
        }
    } 
</script>

<style>
	@import url("servicesweb.css");
</style>
