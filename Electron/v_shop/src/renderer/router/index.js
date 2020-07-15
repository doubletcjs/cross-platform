import Vue from 'vue'
import Router from 'vue-router'

import '../assets/css/global.css'
import '../assets/fonts/iconfont.css'

import Login from '../components/login.vue'
import Home from '../components/home.vue'
import Welcome from '../components/welcome.vue'
import Users from '../components/user/users.vue'
import Rights from '../components/authority/rights.vue'
import Roles from '../components/authority/roles.vue'
import Goods from '../components/good/goods.vue'
import Params from '../components/good/params.vue'
import Categories from '../components/good/categories.vue'
import Orders from '../components/order/orders.vue'
import Reports from '../components/data/reports.vue'

Vue.use(Router)
const router = new Router({
  routes: [{
    path: '/',
    name: 'root',
    redirect: '/login'
  }, {
    path: '/login',
    name: 'login',
    component: Login
  }, {
    path: '/home',
    name: 'home',
    component: Home,
    redirect: "/welcome",
    children: [{
        path: '/welcome',
        name: 'welcome',
        component: Welcome
      },
      {
        path: '/users',
        name: 'users',
        component: Users
      },
      {
        path: '/rights',
        name: 'rights',
        component: Rights
      },
      {
        path: '/roles',
        name: 'roles',
        component: Roles
      },
      {
        path: '/categories',
        name: 'categories',
        component: Categories
      },
      {
        path: '/params',
        name: 'params',
        component: Params
      },
      {
        path: '/goods',
        name: 'goods',
        component: Goods
      },
      {
        path: '/orders',
        name: 'orders',
        component: Orders
      },
      {
        path: '/reports',
        name: 'reports',
        component: Reports
      }
    ]
  }]
})

// 路由导航守卫
router.beforeEach((to, from, next) => {
  if (to.path == "/login") {
    return next()
  }

  const token = window.sessionStorage.getItem("token")
  if (!token) {
    return next("/login")
  }

  next()
})

// 解决ElementUI导航栏中的vue-router在3.0版本以上重复点菜单报错问题
const originalPush = Router.prototype.push
Router.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}

export default router