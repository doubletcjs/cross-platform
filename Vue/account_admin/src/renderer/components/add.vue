<template>
  <div class="container">
    <h1 class="page-header">添加用户</h1>
    <div class="well">
      <h4>用户信息</h4>
      <div class="list-group">
        <label>姓名</label>
        <input type="text" placeholder="姓名" class="form-control" v-model="account.name" />
      </div>
      <div class="list-group">
        <label>电话</label>
        <input type="number" placeholder="电话" class="form-control" v-model="account.phone" />
      </div>
      <div class="list-group">
        <label>邮箱</label>
        <input type="email" placeholder="邮箱" class="form-control" v-model="account.email" />
      </div>
      <div class="list-group">
        <label>学历</label>
        <input type="text" placeholder="学历" class="form-control" v-model="account.education" />
      </div>
      <div class="list-group">
        <label>毕业学校</label>
        <input
          type="text"
          placeholder="毕业学校"
          class="form-control"
          v-model="account.graduationschool"
        />
      </div>
      <div class="list-group">
        <label>职业</label>
        <input type="text" placeholder="职业" class="form-control" v-model="account.profession" />
      </div>
      <div class="list-group">
        <label>个人简介</label>
        <textarea rows="7" class="form-control" placeholder="个人简介" v-model="account.profile"></textarea>
      </div>
      <button class="btn btn-primary" @click="addConfirm">添加</button>
    </div>
  </div>
</template>

<script>
export default {
  name: "add",
  data() {
    return {
      account: {}
    };
  },
  methods: {
    addConfirm() {
      if (!this.account.name || !this.account.phone || !this.account.email) {
        alert("姓名、电话、邮箱不能为空！");
      } else {
        var weakSelf = this;
        this.$http
          .post("http://localhost:3000/users", this.account)
          .then(function(response) {
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

<style lang="scss" scoped>
</style>