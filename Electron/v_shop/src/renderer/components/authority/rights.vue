<template>
  <div id="app">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>权限管理</el-breadcrumb-item>
      <el-breadcrumb-item>权限列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-table :data="dataList" border stripe>
        <el-table-column label="#" width="50px" prop="id"></el-table-column>
        <el-table-column label="权限名称" prop="authName"></el-table-column>
        <el-table-column label="路径" prop="path"></el-table-column>
        <el-table-column label="权限等级">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.level == 0">一级</el-tag>
            <el-tag type="success" v-if="scope.row.level == 1">二级</el-tag>
            <el-tag type="warning" v-if="scope.row.level == 2">三级</el-tag>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
export default {
  name: "rights",
  data() {
    return {
      dataList: []
    };
  },
  created() {
    this.getRightList();
  },
  methods: {
    getRightList() {
      const weakSelf = this;
      this.$http.get("rights/list").then(function(res) {
        const response = res.data;
        if (response.meta.status == 200) {
          weakSelf.dataList = response.data;
        } else {
          thih.$message.error(response.meta.msg);
        }
      });
    }
  }
};
</script>

<style scoped>
</style>