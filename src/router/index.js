import Vue from 'vue'
import VueRouter from 'vue-router'
import Layout from '../layout/index.vue'
import HomeView from '../views/HomeView.vue'
import Eol from '../views/eol.vue'
import Balance from '../views/balance.vue'
import QualityTesting from '../views/qualityTesting/index.vue'
import Report from '../views/qualityTesting/report.vue'
import SafetyRegulation from '../views/qualityTesting/safetyRegulation.vue'
import EolDetection from '../views/qualityTesting/eolDetection.vue'
import Equilibrium from '../views/qualityTesting/equilibrium.vue'
import Airtight from '../views/airtight.vue'
import ChargeDischarge from '../views/qualityTesting/chargeDischarge.vue'
Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/airtight',
    redirect:'/airtight/index',
    component:Layout ,
    children:[
      {
        path:'/airtight/index',
        name:'airtight',
        component:Airtight
      },
    ]
  },
  {
    path: '/eol',
    redirect:'/eol/index',
    component:Layout ,
    children:[
      {
        path:'/eol/index',
        name:'eol',
        component:Eol
      },
    ]
  },
  {
    path: '/balance',
    redirect:'/balance/index',
    component: Layout,
    children:[
      {
        path:'/balance/index',
        name:'balance',
        component:Balance
      },
    ]
  },
  {
    path: '/quality-testing',
    redirect:'/quality-testing/menu-list',
    component: Layout,
    children:[
      {
        path: '/quality-testing/menu-list',
        redirect:'/quality-testing/menu-list/report',
        name: 'Menu',
        component: QualityTesting,
        children:[
          {
            path:'/quality-testing/menu-list/report',
            name:'Report',
            component:Report
          },
          {
            path:'/quality-testing/menu-list/safety-regulation',
            name:'SafetyRegulation',
            component:SafetyRegulation
          },
          {
            path:'/quality-testing/menu-list/eol-detection',
            name:'EolDetection',
            component:EolDetection
          },
          {
           path:'/quality-testing/menu-list/charge-discharge',
           name:'ChargeDischarge',
           component:ChargeDischarge
          },
          {
            path:'/quality-testing/menu-list/equilibrium',
            name:'equilibrium',
            component:Equilibrium
          }
        ],
      },
    ]
  },
]

const router = new VueRouter({
  mode: "history",
  routes
})

export default router
