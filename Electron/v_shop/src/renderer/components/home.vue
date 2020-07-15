<template>
  <div id="app">
    <el-container class="el-body">
      <el-header>
        <div>
          <img src="../assets/heima.png" />
          <span>电商后台管理系统</span>
        </div>
        <el-button type="primary" @click="logoutAction">退出</el-button>
      </el-header>
      <el-container>
        <el-aside :width="collapse ? '64px' : '200px'">
          <div class="toggle-button" @click="toggleCollapse">|||</div>
          <el-menu
            background-color="#545c64"
            text-color="#fff"
            active-text-color="#409fff"
            unique-opened
            :collapse="collapse"
            :collapse-transition="false"
            router
            :default-active="activePath"
          >
            <!-- 一级菜单 -->
            <el-submenu v-for="(menu, index) in menus" :key="menu.id" :index="String(index)">
              <!-- 一级菜单 名称 -->
              <template slot="title">
                <i :class="icons[index]"></i>
                <span>{{menu.authName}}</span>
              </template>
              <!-- 二级菜单 -->
              <el-menu-item
                v-for="item in menu.children"
                :key="item.id"
                :index="'/' + item.path"
                @click="saveNavState('/' + item.path)"
              >
                <template slot="title">
                  <i class="el-icon-menu"></i>
                  <span>{{item.authName}}</span>
                </template>
              </el-menu-item>
            </el-submenu>
          </el-menu>
        </el-aside>
        <el-main>
          <router-view></router-view>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
export default {
  name: "home",
  data() {
    return {
      menus: [],
      icons: [
        "iconfont icon-user",
        "iconfont icon-tijikongjian",
        "iconfont icon-shangpin",
        "iconfont icon-danju",
        "iconfont icon-baobiao"
      ],
      collapse: false,
      activePath: ""
    };
  },
  methods: {
    logoutAction() {
      window.sessionStorage.clear();
      this.$toast.success("退出成功！");
      this.$router.push("/");
    },
    getMenuList() {
      var weakSelf = this;
      this.$http.get("menus").then(function(res) {
        var respon = res.data;
        if (respon.meta.status == 200) {
          weakSelf.menus = respon.data;
        } else {
          weakSelf.$toast.error(respon.meta.msg);
        }
      });
    },
    toggleCollapse() {
      this.collapse = !this.collapse;
    },
    saveNavState(path) {
      window.sessionStorage.setItem("activePath", path);
      this.activePath = window.sessionStorage.getItem("activePath");
    }
  },
  created() {
    this.getMenuList();
    this.activePath = window.sessionStorage.getItem("activePath");
  }
};
</script>

<style lang="less" scoped>
.el-body {
  height: 100%;
}

.el-header {
  background-color: #373d41;
  padding-left: 0;

  display: flex;
  justify-content: space-between;
  align-items: center;

  font-size: 20px;
  color: #fff;

  > div {
    display: flex;
    align-items: center;
    span {
      margin-left: 15px;
    }
  }
}

.el-aside {
  background-color: #333744;

  .el-menu {
    border-right: none;
  }
}

.el-main {
  background-color: #eaedf1;
}

.iconfont {
  margin-right: 10px;
}

.toggle-button {
  background-color: #4a5064;
  font-size: 10px;
  line-height: 28px;
  color: #ffffff;
  text-align: center;
  letter-spacing: 0.2em;
  cursor: pointer;
}
</style>