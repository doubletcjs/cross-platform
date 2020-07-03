<template>
  <div class="container">
    <alert :message="toast" v-if="toast.length > 0"></alert>
    <router-link class="btn btn-default" to="/">返回</router-link>
    <h1 class="page-header">
      {{account.name}}
      <div class="pull-right">
        <router-link class="btn btn-primary" :to="'/edit/'+account.id">编辑</router-link>
        <router-link class="btn btn-danger" to="/">删除</router-link>
      </div>
    </h1>
    <div class="list-group">
      <div class="list-group-item">
        <span class="glyphicon glyphicon-asterisk">
          <span></span>
          {{account.phone}}
        </span>
      </div>
      <div class="list-group-item">
        <span class="glyphicon glyphicon-plus">
          <span></span>
          {{account.email}}
        </span>
      </div>
    </div>
    <div class="list-group">
      <div class="list-group-item">
        <span class="glyphicon glyphicon-asterisk">
          <span></span>
          {{account.education}}
        </span>
      </div>
      <div class="list-group-item">
        <span class="glyphicon glyphicon-plus">
          <span></span>
          {{account.graduationschool}}
        </span>
      </div>
      <div class="list-group-item">
        <span class="glyphicon glyphicon-asterisk">
          <span></span>
          {{account.profession}}
        </span>
      </div>
      <div class="list-group-item">
        <span class="glyphicon glyphicon-plus">
          <span></span>
          {{account.profile}}
        </span>
      </div>
    </div>
  </div>
</template>

<script>
import alert from "../components/alert";
export default {
  name: "detail",
  data() {
    return {
      account: {},
      toast: ""
    };
  },
  components: {
    alert
  },
  methods: {
    requestAccount(id) {
      var weakSelf = this;
      this.$http
        .get("http://localhost:3000/users/" + id)
        .then(function(response) {
          weakSelf.account = response.data;
        });
    }
  },
  created() {
    var id = this.$route.params.id;
    this.requestAccount(id);
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