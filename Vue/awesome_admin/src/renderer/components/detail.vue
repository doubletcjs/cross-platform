<template>
  <div id="app">
    <el-button
      type="default"
      @click="backAction"
      :style="toast.length > 1 ? 'margin-bottom: 20px;' : 'margin-bottom: 0px;'"
    >返回</el-button>
    <el-alert :title="toast" type="info" v-if="toast.length > 0" @close="closeAlert"></el-alert>
    <div class="base-header-content">
      <h1 style="font-weight: bolder;">{{account.name}}</h1>
      <div class="base-row">
        <el-button type="primary" @click="editAccount">编辑</el-button>
        <el-button type="danger" @click="dialogVisible = true">删除</el-button>
      </div>
    </div>
    <div
      class="base-row-content"
      style="border-top-left-radius: 4px; border-top-right-radius: 4px;"
    >
      <i class="el-icon-loading"></i>
      <div class="base-row-text">{{account.phone}}</div>
    </div>
    <div
      class="base-row-content"
      style="border-bottom: solid 1px rgba(233, 235, 243, 1); border-bottom-left-radius: 4px; border-bottom-right-radius: 4px;"
    >
      <i class="el-icon-loading"></i>
      <div class="base-row-text">{{account.email}}</div>
    </div>
    <div
      class="base-row-content"
      style="margin-top: 20px; border-top-left-radius: 4px; border-top-right-radius: 4px;"
    >
      <i class="el-icon-loading"></i>
      <div class="base-row-text">{{account.education}}</div>
    </div>
    <div class="base-row-content">
      <i class="el-icon-loading"></i>
      <div class="base-row-text">{{account.graduationschool}}</div>
    </div>
    <div class="base-row-content">
      <i class="el-icon-loading"></i>
      <div class="base-row-text">{{account.profession}}</div>
    </div>
    <div
      class="base-row-content"
      style="border-bottom: solid 1px rgba(233, 235, 243, 1); border-bottom-left-radius: 4px; border-bottom-right-radius: 4px;"
    >
      <i class="el-icon-loading"></i>
      <div class="base-row-text">{{account.profile}}</div>
    </div>

    <el-dialog title="提示" :visible.sync="dialogVisible">
      <span>是否删除该条信息</span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="deleteAction">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "detail",
  data() {
    return {
      account: {},
      toast: "",
      dialogVisible: false
    };
  },
  methods: {
    requestData(id) {
      var weakSelf = this;
      this.$http.get("http://localhost:3000/users/" + id).then(function(res) {
        weakSelf.account = res.data;
      });
    },
    editAccount() {
      this.$router.push("/editting/" + this.account.id);
    },
    backAction() {
      this.$router.go(-1);
      this.$route.params.alert = "";
    },
    closeAlert() {
      this.toast = "";
      this.$route.params.alert = "";
    },
    deleteAction() {
      this.dialogVisible = false;

      var weakSelf = this;
      this.$http
        .delete("http://localhost:3000/users/" + this.account.id)
        .then(function(res) {
          weakSelf.$router.push({
            name: "home",
            params: {
              id: weakSelf.account.id,
              alert: "修改用户信息成功！"
            }
          });
        });
    }
  },
  created() {
    var id = this.$route.params.id;
    this.requestData(id);
    this.toast = "";
  },
  updated() {
    if (this.$route.params.alert) {
      this.toast = this.$route.params.alert;

      setTimeout(() => {
        this.toast = "";
        this.$route.params.alert = "";
      }, 3000);
    } else {
      this.toast = "";
    }

    setTimeout(() => {
      if (this.toast.length > 0) {
        this.$route.params.alert = "";
      }
    }, 400);
  }
};
</script>

<style scoped>
.base-row-content {
  height: 44px;

  border-left: solid 1px rgba(233, 235, 243, 1);
  border-top: solid 1px rgba(233, 235, 243, 1);
  border-right: solid 1px rgba(233, 235, 243, 1);

  padding-left: 15px;
  padding-right: 15px;

  display: flex;
  flex-direction: row;
  align-content: center;
  align-items: center;
}

.base-row-text {
  margin-left: 15px;
}

.base-row {
  display: flex;
  flex-direction: row;
}

.base-header-content {
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-content: center;
  align-items: center;

  border-bottom: solid 1px rgba(233, 235, 243, 1);
  margin-bottom: 20px;
}
</style>