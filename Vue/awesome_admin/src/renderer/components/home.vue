<template>
  <div id="app">
    <el-alert :title="toast" type="info" v-if="toast.length > 0" @close="closeAlert"></el-alert>
    <el-input
      v-model="keyword"
      placeholder="搜索"
      :style="toast.length > 1 ? 'margin-top: 10px;' : 'margin-top: 0px;'"
      clearable
    ></el-input>
    <el-container class="table-content">
      <el-table :data="filterBy(this.keyword)" index="id" stripe>
        <el-table-column label="姓名" prop="name"></el-table-column>
        <el-table-column label="邮箱" prop="email"></el-table-column>
        <el-table-column label="电话" prop="phone"></el-table-column>
        <el-table-column>
          <template slot-scope="scope">
            <el-button type="default" @click="showDetail(scope.$index)">详情</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-container>
  </div>
</template>

<script>
export default {
  name: "home",
  data() {
    return {
      dataList: [],
      keyword: "",
      toast: ""
    };
  },
  methods: {
    requestData() {
      var weakSelf = this;
      this.$http.get("http://localhost:3000/users").then(function(res) {
        weakSelf.dataList = res.data;
      });
    },
    filterBy(keyword) {
      return this.dataList.filter(function(account) {
        return account.name.match(keyword);
      });
    },
    closeAlert() {
      this.toast = "";
      this.$route.query.alert = "";
    },
    showDetail(index) {
      var account = this.dataList[index];
      console.log("account :>> ", JSON.stringify(account));
    }
  },
  created() {
    this.requestData();
    this.toast = "";
  },
  updated() {
    if (this.$route.query.alert) {
      this.toast = this.$route.query.alert;

      setTimeout(() => {
        this.toast = "";
        this.$route.query.alert = "";
      }, 3000);
    } else {
      this.toast = "";
    }

    setTimeout(() => {
      if (this.toast.length > 0) {
        this.$route.query.alert = "";
      }
    }, 400);
  }
};
</script>

<style scoped>
.table-content {
  border-left: solid 1px rgba(233, 235, 243, 1);
  border-top: solid 1px rgba(233, 235, 243, 1);
  border-right: solid 1px rgba(233, 235, 243, 1);
}
</style>