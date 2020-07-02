<template>
  <div class="container">
    <router-link class="btn btn-default" :to="'/customer/'+customer.id">返回</router-link>
    <h1 class="page-header">编辑用户</h1>
    <form v-on:submit="updateCustomer">
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
        <button type="submit" class="btn btn-primary">完成</button>
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
    fetchCustomer(id) {
      var weakSelf = this;
      this.$http
        .get("http://localhost:3000/users/" + id)
        .then(function(response) {
          weakSelf.customer = response.data;
        });
    },
    updateCustomer(res) {
      if (!this.customer.name || !this.customer.phone || !this.customer.email) {
        alert("请添加对应的信息！");
      } else {
        var weakSelf = this;
        this.$http
          .put("http://localhost:3000/users/" + this.customer.id, this.customer)
          .then(function(response) {
            weakSelf.$router.push({
              path: "/customer/" + weakSelf.customer.id,
              query: {
                alert: "用户信息更新成功！"
              }
            });
          });
      }
    }
  },
  created() {
    this.fetchCustomer(this.$route.params.id);
  }
};
</script>

<style>
</style>