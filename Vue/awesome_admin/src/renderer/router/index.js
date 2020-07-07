import Vue from 'vue'
import Router from 'vue-router'

import Home from '../components/home'
import About from '../components/about'
import Creation from '../components/creation'
import Detail from '../components/detail'
import Edit from '../components/editting'

Vue.use(Router)

const originalPush = Router.prototype.push
Router.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}

export default new Router({
  routes: [{
    path: '/',
    name: 'home',
    component: Home
  }, {
    path: '/about',
    name: 'about',
    component: About
  }, {
    path: '/creation',
    name: 'creation',
    component: Creation
  }, {
    path: '/detail/:id',
    name: 'detail',
    component: Detail
  }, {
    path: '/editting/:id',
    name: 'editting',
    component: Edit
  }, ]
})