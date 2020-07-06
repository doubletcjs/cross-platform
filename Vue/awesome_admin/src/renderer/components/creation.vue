<template>
  <div id="app">
    <div class="creation-content">
      <div>用户信息</div>
      <div class="creation-item-content">
        姓名
        <el-input v-model="account.name" placeholder="姓名" clearable style="padding-top: 6px;"></el-input>
      </div>
      <div class="creation-item-content">
        电话
        <el-input
          type="number"
          v-model="account.phone"
          placeholder="电话"
          clearable
          style="padding-top: 6px;"
        ></el-input>
      </div>
      <div class="creation-item-content">
        邮箱
        <el-input
          type="email"
          v-model="account.email"
          placeholder="邮箱"
          clearable
          style="padding-top: 6px;"
        ></el-input>
      </div>
      <div class="creation-item-content">
        学历
        <el-input v-model="account.education" placeholder="学历" clearable style="padding-top: 6px;"></el-input>
      </div>
      <div class="creation-item-content">
        毕业学校
        <el-input
          v-model="account.graduationschool"
          placeholder="毕业学校"
          clearable
          style="padding-top: 6px;"
        ></el-input>
      </div>
      <div class="creation-item-content">
        职业
        <el-input v-model="account.profession" placeholder="职业" clearable style="padding-top: 6px;"></el-input>
      </div>
      <div class="creation-item-content">
        个人简介
        <el-input
          type="textarea"
          placeholder="个人简介"
          style="padding-top: 6px;"
          v-model="account['profile']"
        ></el-input>
      </div>
      <el-button type="primary" @click="createAction">添加</el-button>
    </div>
  </div>
</template>

<script>
export default {
  name: "creation",
  data() {
    return {
      account: {}
    };
  },
  methods: {
    createAction() {
      if (!this.account.name || !this.account.phone || !this.account.email) {
        alert("姓名、电话、邮箱不能为空！");
      } else {
        var weakSelf = this;
        this.$http
          .post("http://localhost:3000/users", this.account)
          .then(function(res) {
            weakSelf.$router.push({
              path: "/",
              query: {
                alert: "添加用户信息成功！"
              }
            });
          });
      }
    }
  }
};
</script>

<style scoped>
.creation-content {
  background-color: rgba(243, 243, 244, 1);
  padding-left: 15px;
  padding-right: 15px;
  padding-top: 20px;
  padding-bottom: 20px;

  border-radius: 4px;
}

.creation-item-content {
  padding-top: 8px;
  padding-bottom: 8px;
}
</style>