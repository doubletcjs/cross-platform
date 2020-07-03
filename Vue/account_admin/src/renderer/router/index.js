import Vue from 'vue'
import Router from 'vue-router'

import About from "../components/about"
import Home from "../components/home"
import Detail from "../components/detail"
import Add from "../components/add"
import Edit from "../components/edit"

Vue.use(Router)

export default new Router({
  routes: [{
      path: '/',
      name: 'home',
      component: Home
    }, {
      path: '/about',
      name: 'about',
      component: About
    },
    {
      path: '/detail/:id',
      name: 'detail',
      component: Detail
    },
    {
      path: '/add',
      name: 'add',
      component: Add
    },
    {
      path: '/edit/:id',
      name: 'edit',
      component: Edit
    }
  ]
})