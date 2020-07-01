import Vue from 'vue'
import Router from 'vue-router'

import Customers from '../../components/Customers'
import About from '../../components/About'

Vue.use(Router)

export default new Router({
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
    },
  ]
})