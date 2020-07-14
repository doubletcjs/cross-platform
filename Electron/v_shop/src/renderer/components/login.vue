<template>
  <div id="app" class="login-container">
    <div class="login-box">
      <div class="avatar-box">
        <img src="../assets/login_logo.png" class="avatar-image" />
      </div>
      <el-form class="login-form" :rules="rules" :model="form" ref="formRef">
        <el-form-item prop="username">
          <el-input prefix-icon="iconfont icon-user" placeholder="请输入用户名" v-model="form.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            prefix-icon="iconfont icon-3702mima"
            placeholder="请输入密码"
            show-password
            v-model="form.password"
          ></el-input>
        </el-form-item>
        <el-form-item class="btns">
          <el-button type="primary" @click="onConfirm">登录</el-button>
          <el-button type="info" @click="resetForm">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
export default {
  name: "login",
  data() {
    return {
      form: {
        username: "",
        password: ""
      },
      rules: {
        username: [
          {
            required: true,
            message: "请输入用户名",
            trigger: "blur"
          },
          {
            min: 3,
            max: 10,
            message: "长度在 3 到 10 个字符",
            trigger: "blur"
          }
        ],
        password: [
          {
            required: true,
            message: "请输入密码",
            trigger: "blur"
          },
          {
            min: 6,
            max: 15,
            message: "长度在 6 到 15 个字符",
            trigger: "blur"
          }
        ]
      }
    };
  },
  methods: {
    onConfirm() {
      this.$refs.formRef.validate((isSuccessful, data) => {
        if (isSuccessful) {
          this.$http.post("login", this.form).then(function(res) {
            var data = res.data;
            console.log("res :>> ", JSON.stringify(data));
          });
        }
      });
    },
    resetForm() {
      this.$refs.formRef.resetFields();
    }
  }
};
</script>

<style scoped>
.login-container {
  background-color: steelblue;
}

.login-box {
  width: 450px;
  height: 300px;
  background-color: #ffffff;
  border-radius: 3px;

  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}

.avatar-box {
  width: 120px;
  height: 120px;

  padding: 8px;
  border-radius: 50%;
  border: solid 1px #eeeeee;
  background-color: #ffffff;
  box-shadow: 0 0 10px #eeeeee;

  position: absolute;
  left: 50%;
  transform: translate(-50%, -50%);
}

.avatar-image {
  width: 100%;
  height: 100%;

  border-radius: 50%;
  background-color: #eeeeee;
}

.btns {
  display: flex; 
  justify-content: flex-end;
}

.login-form { 
  position: absolute;
  bottom: 0;

  width: 100%;
  padding: 0 20px;
  box-sizing: border-box;
}
</style>