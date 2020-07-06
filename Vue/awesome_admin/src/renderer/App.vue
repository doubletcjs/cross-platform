<template>
  <div id="app">
    <el-container class="navBar">
      <div class="base-row base-text">
        <div style="margin-right: 40px;">用户管理</div>
        <el-button type="text" @click="homePage">主页</el-button>
        <el-button type="text" @click="aboutPage">关于</el-button>
      </div>
      <el-button type="text" @click="addPage">添加用户</el-button>
    </el-container>
    <div class="base-content">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
export default {
  name: "awesome_admin",
  data() {
    return {};
  },
  methods: {
    homePage() {
      this.$router.push("/");
    },
    aboutPage() {
      this.$router.push("/about");
    },
    addPage() {
      this.$router.push("/creation");
    }
  }
};
</script>

<style>
.navBar {
  background-color: rgba(247, 247, 247, 1);
  border-bottom: solid 1px rgba(227, 227, 248, 1);
  height: 60px;

  position: fixed;
  top: 0;
  left: 0;
  right: 0;

  z-index: 1500;

  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-content: center;
  align-items: center;

  padding-left: 10px;
  padding-right: 10px;
}

.base-row {
  display: flex;
  flex-direction: row;
  align-content: center;
  align-items: center;
}

.base-text {
  font-size: 18rpx;
  color: rgba(0, 0, 0, 0.6);
}

.base-content {
  width: 100%;
  margin-top: 70px;
}
</style>
