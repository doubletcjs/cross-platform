<template>
  <div class="container">
    <alert :message="toast" v-if="toast.length > 0"></alert>
    <h1 class="page-header">用户列表</h1>
    <input type="text" placeholder="搜索" class="form-control" v-model="keyworkInput" />
    <table class="table well">
      <thead>
        <tr>
          <td>姓名</td>
          <td>邮箱</td>
          <td>电话</td>
          <td></td>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in filterBy(dataList, keyworkInput)" :key="item.id">
          <td>{{item.name}}</td>
          <td>{{item.email}}</td>
          <td>{{item.phone}}</td>
          <td>
            <router-link class="btn btn-default" :to="'/detail/'+item.id">详情</router-link>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import "bootstrap/dist/css/bootstrap.min.css";
import alert from "../components/alert";

export default {
  name: "home",
  data() {
    return {
      dataList: [],
      keyworkInput: "",
      toast: ""
    };
  },
  components: {
    alert
  },
  methods: {
    requestData() {
      var weakSelf = this;
      this.$http.get("http://localhost:3000/users").then(function(response) {
        weakSelf.dataList = response.data;
      });
    },
    filterBy(list, keywork) {
      return list.filter(function(item) {
        return item.name.match(keywork);
      });
    }
  },
  created() {
    this.requestData();
    this.toast = "";
  },
  updated() {
    if (this.$route.query.alert) {
      this.toast = this.$route.query.alert;
    } else {
      this.toast = "";
    }
  }
};
</script>

<style lang="scss" scoped>
</style>