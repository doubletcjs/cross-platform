<template>
  <div class="container">
    <alert alertTitle :alertContent="alertContent" v-if="alertContent.length > 0"></alert>
    <h1 class="page-header">用户管理系统</h1>
    <input type="text" class="form-control" placeholder="搜索" v-model="filterInput" />
    <table class="table table-striped well">
      <thead>
        <tr>
          <th>姓名</th>
          <th>电话</th>
          <th>邮箱</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in filterBy(customers, filterInput)" :key="item.id">
          <td>{{item.name}}</td>
          <td>{{item.phone}}</td>
          <td>{{item.email}}</td>
          <td>
            <router-link class="btn btn-default" :to="'/customer/'+item.id">详情</router-link>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import alert from "../components/Alert";

export default {
  name: "customers",
  data() {
    return {
      customers: [],
      alertContent: "",
      filterInput: ""
    };
  },
  methods: {
    fetchCustomers() {
      var weakSelf = this;
      this.$http.get("http://localhost:3000/users").then(function(response) {
        weakSelf.customers = response.data;
      });
    },
    filterBy(list, keywork) {
      return list.filter(function(customer) {
        return customer.name.match(keywork);
      });
    }
  },
  created() {
    this.alertContent = "";
    this.fetchCustomers();
  },
  updated() {
    if (this.$route.query.alert) {
      this.alertContent = this.$route.query.alert;
    }
  },
  components: {
    alert
  }
};
</script>

<style>
</style>