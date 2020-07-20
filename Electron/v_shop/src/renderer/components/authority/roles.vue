<template>
  <div id="app">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/welcome' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>角色管理</el-breadcrumb-item>
      <el-breadcrumb-item>角色列表</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <el-button type="primary">添加角色</el-button>
      <el-table :data="roleList" border stripe>
        <el-table-column type="expand">
          <template slot-scope="scope">
            <el-row
              v-for="(item1, i1) in scope.row.children"
              :index="i1"
              :key="item1.id"
              :class="['bdbottom', i1 == 0 ? 'bdtop' : '']"
            >
              <el-col :span="5">
                <el-tag closable>{{item1.authName}}</el-tag>
                <i class="el-icon-caret-right"></i>
              </el-col>
              <el-col :span="19">
                <el-row
                  v-for="(item2, i2) in item1.children"
                  :index="i2"
                  :key="item2.id"
                  :class="[i2 == 0 ? '' : 'bdtop']"
                >
                  <el-col :span="6">
                    <el-tag type="success" closable>{{item2.authName}}</el-tag>
                    <i class="el-icon-caret-right"></i>
                  </el-col>
                  <el-col :span="18">
                    <el-tag
                      type="warning"
                      closable
                      v-for="(item3, i3) in item2.children"
                      :index="i3"
                      :key="item3.id"
                    >{{item3.authName}}</el-tag>
                  </el-col>
                </el-row>
              </el-col>
            </el-row>
          </template>
        </el-table-column>
        <el-table-column type="index" label="#"></el-table-column>
        <el-table-column prop="roleName" label="角色名称"></el-table-column>
        <el-table-column prop="roleDesc" label="角色描述"></el-table-column>
        <el-table-column label="操作" width="300px">
          <template slot-scope="scope">
            <el-button type="primary" size="mini" icon="el-icon-edit">编辑</el-button>
            <el-button type="danger" size="mini" icon="el-icon-delete">删除</el-button>
            <el-button type="warning" size="mini" icon="el-icon-setting">分配权限</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
export default {
  name: "roles",
  data() {
    return {
      roleList: []
    };
  },
  created() {
    this.getRoleList();
  },
  methods: {
    getRoleList() {
      const weakSelf = this;
      this.$http.get("roles").then(function(res) {
        console.log("res :>> ", res.data);
        const response = res.data;
        if (response.meta.status == 200) {
          weakSelf.roleList = response.data;
        } else {
          weakSelf.$message.error(response.meta.msg);
        }
      });
    }
  }
};
</script>

<style scoped>
.el-tag {
  margin: 7px;
} 

.bdtop {
  border-top: 1px solid #eee;
}

.bdbottom {
  border-bottom: 1px solid #eee;
}
</style>