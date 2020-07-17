<template>
  <div id="app">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-row :gutter="20">
        <el-col :span="8">
          <el-input placeholder="请输入内容" v-model="keyword" clearable @clear="getUserList">
            <el-button slot="append" icon="el-icon-search" @click="getUserList"></el-button>
          </el-input>
        </el-col>
        <el-col :span="4">
          <el-button type="primary" @click="addDialogVisible">添加用户</el-button>
        </el-col>
      </el-row>
      <el-table :data="dataList" border>
        <el-table-column label="#" type="index"></el-table-column>
        <el-table-column label="姓名" prop="username"></el-table-column>
        <el-table-column label="邮箱" prop="email"></el-table-column>
        <el-table-column label="电话" prop="mobile"></el-table-column>
        <el-table-column label="角色" prop="role_name"></el-table-column>
        <el-table-column label="状态">
          <template slot-scope="scope">
            <el-switch v-model="scope.row.mg_state" @change="stateChange(scope.row)"></el-switch>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="180">
          <template slot-scope="scope">
            <el-button type="primary" icon="el-icon-edit" size="mini"></el-button>
            <el-button type="danger" icon="el-icon-delete" size="mini"></el-button>
            <el-tooltip content="分配角色" placement="top" effect="dark" :enterable="false">
              <el-button type="warning" icon="el-icon-setting" size="mini"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="page"
        :page-sizes="[20, 40, 60, 80]"
        :page-size="limit"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
        background
      ></el-pagination>
    </el-card>

    <el-dialog title="提示" :visible.sync="dialogVisible" width="50%">
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="70px">
        <el-form-item label="用户名" prop="username">
          <el-input v-model="addForm.username"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="addForm.password" show-password></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="addForm.email"></el-input>
        </el-form-item>
        <el-form-item label="手机" prop="mobile">
          <el-input v-model="addForm.mobile"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "users",
  data() {
    return {
      page: 1,
      limit: 20,
      dataList: [],
      keyword: "",
      currentPage: 0,
      total: 0,
      dialogVisible: false,
      addForm: {},
      addFormRules: {
        username: [
          { required: true, message: "请输入用户名", trigger: "blur" },
          {
            min: 3,
            max: 10,
            message: "用户名的长度在3～10个字符之间",
            trigger: "blur"
          }
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur" },
          {
            min: 3,
            max: 15,
            message: "密码的长度在3～15个字符之间",
            trigger: "blur"
          }
        ],
        email: [{ required: true, message: "请输入邮箱", trigger: "blur" }],
        mobile: [{ required: true, message: "请输入手机", trigger: "blur" }]
      }
    };
  },
  created() {
    this.getUserList();
  },
  methods: {
    getUserList() {
      var weakSelf = this;
      this.$http
        .get("users", {
          params: {
            query: this.keyword,
            pagenum: this.page,
            pagesize: this.limit
          }
        })
        .then(function(res) {
          const response = res.data;
          if (response.meta.status == 200) {
            const data = response.data;
            weakSelf.dataList = data.users;
            weakSelf.total = data.total;
          } else {
            weakSelf.$toast.error(response.meta.msg);
          }
        });
    },
    handleSizeChange(newSize) {
      this.limit = newSize;
      this.getUserList();
    },
    handleCurrentChange(newPage) {
      this.page = newPage;
      this.getUserList();
    },
    stateChange(info) {
      var weakSelf = this;
      this.$http
        .put("users/" + info.id + "/state/" + info.mg_state)
        .then(function(res) {
          const response = res.data;
          if (response.meta.status == 200) {
            weakSelf.$toast.success("更新用户状态成功！");
          } else {
            info.mg_state = !info.mg_state;
            weakSelf.$toast.error("更新用户状态失败！");
          }
        });
    },
    addDialogVisible() {
      this.dialogVisible = !this.dialogVisible;
    }
  }
};
</script>

<style lang="scss" scoped>
</style>