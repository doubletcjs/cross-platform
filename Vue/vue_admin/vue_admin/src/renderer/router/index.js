import Vue from 'vue'
import Router from 'vue-router'

import Customers from '../../components/Customers'
import About from '../../components/About'
import Add from '../../components/Add'
import Detail from '../../components/CustomersDetails'
import Edit from '../../components/Edit'

Vue.use(Router)

export default new Router({
  history: true,
  routes: [
    // {
    //   path: '/',
    //   name: 'landing-page',
    //   component: require('@/components/LandingPage').default
    // },
    // {
    //   path: '*',
    //   redirect: '/',
    //   component: Customers
    // },
    {
      path: "/",
      name: "主页",
      component: Customers
    }, {
      path: "/about",
      name: "联系我们",
      component: About
    }, {
      path: "/add",
      name: "添加用户",
      component: Add
    }, {
      path: "/customer/:id",
      name: "详情",
      component: Detail
    }, {
      path: "/editcustomer/:id",
      name: "编辑",
      component: Edit
    }
  ]
})