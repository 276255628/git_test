import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import 'font-awesome/css/font-awesome.min.css';
import './assets/style/index.css'
import VueScroll from '@david-j/vue-j-scroll';
import x2js from 'x2js'
import axios from 'axios' //引入axios
Vue.prototype.axios = axios
Vue.prototype.$x2js = new x2js()
Vue.use(VueScroll);

Vue.config.productionTip = false
Vue.use(ElementUI);
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
