import Vue from 'vue'
import Router from 'vue-router'
import Login from '../components/login.vue'
import '../assets/css/global.css'
import '../assets/fonts/iconfont.css'

Vue.use(Router)

export default new Router({
  routes: [{
    path: '/',
    name: 'root',
    redirect: '/login'
  }, {
    path: '/login',
    name: 'login',
    component: Login
  }]
})