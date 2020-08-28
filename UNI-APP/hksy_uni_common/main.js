import Vue from 'vue'
import App from './App'
import Util from 'public/util.js'
// 聊天客服的依赖
// import vueInputFile from 'vue-input-file'
// import animated from 'animate.css' 

Vue.config.productionTip = false
Vue.prototype.util = Util

// Vue.use(animated)
// Vue.use(vueInputFile, { component: 'InputFile' })

App.mpType = 'app'

const app = new Vue({
    ...App
})
app.$mount()
