import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'predictor',
      component: require('@/components/Predictor/Predictor').default
    },
    {
      path: '*',
      redirect: '/'
    }
  ]
})
