import Vue from 'vue'
import App from './App'
import Util from 'public/public.js'
import Networking from 'public/networking.js'

Vue.config.productionTip = false
Vue.prototype.util = Util
Vue.prototype.networking = Networking
import VueClipboard from 'vue-clipboard2'

Vue.prototype.kAccountRefresh = "AccountRefresh"
Vue.prototype.kMainColor = "rgba(21, 25, 54, 1)"

App.mpType = 'app';

Vue.use(VueClipboard)

const app = new Vue({
    ...App
})
app.$mount()
