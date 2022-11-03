const loginPage = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/Login',
    name: 'Login',
    component: () =>
      import(/* webpackChunkName: "Login" */ '../pages/main/routes/new_pages/Login')
  }
]

/* 一切需要登录访问的界面都卸载mainPage里边 */
const mainPage = [

  {
    path: '/main',
    name: 'main',
    component: () =>
      import(/* webpackChunkName: "Main" */ '../pages/main/Main'),
    children: [
      /* 这里配路由 */
      {
        path: 'PictureList',
        name: 'PictureList',
        component: () =>
          import(
            /* webpackChunkName: "First" */ '../pages/main/routes/new_pages/PictureList.vue'
          )
      },
      {
        path: 'VedioList',
        name: 'VedioList',
        component: () =>
          import(
            /* webpackChunkName: "First" */ '../pages/main/routes/new_pages/VedioList.vue'
          )
      },

      {
        path: 'TextList',
        name: 'TextList',
        component: () =>
          import(
            /* webpackChunkName: "First" */ '../pages/main/routes/new_pages/TextList.vue'
          )
      },
      {
        path: 'ContentDetail',
        name: 'ContentDetail',
        component: () =>
          import(
            /* webpackChunkName: "First" */ '../pages/main/routes/new_pages/ContentDetail.vue'
          )

      },
      {
        path: 'AuditHistory',
        name: 'AuditHistory',
        component: () =>
          import(
            /* webpackChunkName: "First" */ '../pages/main/routes/new_pages/AuditHistory.vue'
          )

      },
      {
        path: 'Home',
        name: 'Home',
        component: () =>
          import(
            /* webpackChunkName: "First" */ '../pages/main/routes/new_pages/Home.vue'
          )
      }
      /// /////////////////////////////////////////////////////
    ]
  }
]

const errorPage = [
  {
    path: '/notFound',
    name: 'notFound',
    component: () =>
      import(/* webpackChunkName: "NotFound" */ '../pages/error/NotFound')
  },
  {
    path: '/forbidden',
    name: 'forbidden',
    component: () =>
      import(/* webpackChunkName: "Forbidden" */ '../pages/error/Forbidden')
  },
  {
    path: '/badGateway',
    name: 'badGateway',
    component: () =>
      import(/* webpackChunkName: "BadGateway" */ '../pages/error/BadGateway')
  },
  {
    path: '*',
    redirect: '/notFound'
  }
]
export default [...loginPage, ...mainPage, ...errorPage]
