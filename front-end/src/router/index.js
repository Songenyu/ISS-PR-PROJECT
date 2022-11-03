import Vue from 'vue'
import Router from 'vue-router'
import NProgress from 'nprogress'
import permission from './permission'
import store from '../store/'
import { clearHttpRequestingList } from '@http/httpRequestList'
import routes from './routes'

Vue.$httpRequestList = []
Vue.use(Router)

let router = new Router({
  routes
})
router.beforeEach((to, from, next) => {
  if (to.meta.keepAlive) {
    store.commit('routecache/keepAlive', to.name)
  }
  clearHttpRequestingList()
  NProgress.start()
  /* 白名单： 不需要登录就能访问的界面（登录、注册、修改密码） */
  const whiteList = store.getters['permission/getWhiteList']
  if (whiteList.indexOf(to.name) > -1 || whiteList.indexOf(to.path) > -1) {
    console.log('whiteList', whiteList, whiteList.indexOf(to.name))
    console.log(whiteList.indexOf(to.name), '1')
    next()
  } else if (!store.getters['user/getUserId']) {
    console.log('whiteList:', whiteList)
    console.log(to.name, '1')
    console.log('store.getters[user getUserId]', store.getters['user/getUserId'])

    store.dispatch('user/fetchUserInfo').then(res => {
      if (res.status) {
        // 权限校验
        permission(store, routes, to, next)
      } else {
        switch (res.code) {
          case -500:
            next({ name: 'badGateway' })
            break
          case 70005:
            next({ name: 'login' })
            break
        }
      }
    })
  } else {
    // 权限校验
    permission(store, routes, to, next)
  }
})
router.afterEach(() => {
  NProgress.done()
})
export default router
