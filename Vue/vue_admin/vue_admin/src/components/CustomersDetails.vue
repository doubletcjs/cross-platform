<template>
  <div class="container">
    <alert v-if="alertContent.length > 0" alertTitle :alertContent="alertContent"></alert>
    <router-link to="/" class="btn btn-default">返回</router-link>
    <h1 class="page-header">
      {{customer.name}}
      <span class="pull-right">
        <router-link :to="'/editcustomer/'+customer.id" class="btn btn-primary">编辑</router-link>
        <button class="btn btn-danger" @click="deleteCostomer(customer.id)">删除</button>
      </span>
    </h1>
    <ul class="list-group">
      <li class="list-group-item">
        <span class="glyphicon glyphicon-asterisk">{{customer.phone}}</span>
      </li>
      <li class="list-group-item">
        <span class="glyphicon glyphicon-plus">{{customer.email}}</span>
      </li>
    </ul>
    <ul class="list-group">
      <li class="list-group-item">
        <span class="glyphicon glyphicon-asterisk">{{customer.education}}</span>
      </li>
      <li class="list-group-item">
        <span class="glyphicon glyphicon-plus">{{customer.graduationschool}}</span>
      </li>
      <li class="list-group-item">
        <span class="glyphicon glyphicon-asterisk">{{customer.profession}}</span>
      </li>
      <li class="list-group-item">
        <span class="glyphicon glyphicon-plus">{{customer.profile}}</span>
      </li>
    </ul>
  </div>
</template>

<script>
import alert from "../components/Alert";
export default {
  name: "customersdetails",
  data() {
    return {
      customer: {},
      alertContent: ""
    };
  },
  components: {
    alert
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
    deleteCostomer(id) {
      var weakSelf = this;
      this.$http
        .delete("http://localhost:3000/users/" + id)
        .then(function(response) {
          weakSelf.$router.push({
            path: "/",
            query: {
              alert: "用户删除成功！"
            }
          });
        });
    }
  },
  created(res) {
    this.fetchCustomer(this.$route.params.id);
    this.alertContent = "";
  },
  updated() {
    if (this.$route.query.alert) {
      this.alertContent = this.$route.query.alert;
    }
  }
};
</script>

<style>
</style>