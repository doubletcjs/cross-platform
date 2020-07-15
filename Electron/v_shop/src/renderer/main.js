import Vue from 'vue'

import ElementUI, {
  Message
} from 'element-ui'
import "element-ui/lib/theme-chalk/index.css";
Vue.use(ElementUI)

import Axios from 'axios'
Axios.defaults.baseURL = 'http://127.0.0.1:8888/api/private/v1/'
Axios.interceptors.request.use(config => {
  config.headers.Authorization = window.sessionStorage.getItem("token")
  return config
})

import less from 'less'
Vue.use(less)

import App from './App'
import router from './router'

if (!process.env.IS_WEB) Vue.use(require('vue-electron'))
Vue.http = Vue.prototype.$http = Axios
Vue.config.productionTip = false
Vue.prototype.$toast = Message

/* eslint-disable no-new */
new Vue({
  components: {
    App
  },
  router,
  template: '<App/>'
}).$mount('#app')