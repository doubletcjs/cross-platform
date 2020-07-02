<template>
  <div class="container">
    <h1 class="page-header">添加用户</h1>
    <form v-on:submit="addCustomer">
      <div class="well">
        <h4>用户信息</h4>
        <div class="form-group">
          <label>姓名</label>
          <input type="text" class="form-control" placeholder="姓名" v-model="customer.name" />
        </div>
        <div class="form-group">
          <label>电话</label>
          <input type="number" class="form-control" placeholder="电话" v-model="customer.phone" />
        </div>
        <div class="form-group">
          <label>邮箱</label>
          <input type="email" class="form-control" placeholder="邮箱" v-model="customer.email" />
        </div>
        <div class="form-group">
          <label>学历</label>
          <input type="text" class="form-control" placeholder="学历" v-model="customer.education" />
        </div>
        <div class="form-group">
          <label>毕业学校</label>
          <input
            type="text"
            class="form-control"
            placeholder="毕业学校"
            v-model="customer.graduationschool"
          />
        </div>
        <div class="form-group">
          <label>职业</label>
          <input type="text" class="form-control" placeholder="职业" v-model="customer.profession" />
        </div>
        <div class="form-group">
          <label>个人简介</label>
          <textarea rows="8" class="form-control" v-model="customer.profile"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">添加</button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  name: "add",
  data() {
    return {
      customer: {}
    };
  },
  methods: {
    addCustomer(res) {
      if (!this.customer.name || !this.customer.phone || !this.customer.email) {
        alert("请添加对应的信息！");
      } else {
        var weakSelf = this;
        this.$http
          .post("http://localhost:3000/users", this.customer)
          .then(function(response) {
            weakSelf.$router.push({
              path: "/",
              query: {
                alert: "用户信息添加成功！"
              }
            });
          });
      }
    }
  }
};
</script>

<style>
</style>