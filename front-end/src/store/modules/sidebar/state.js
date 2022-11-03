export default {
  sidebarMap: {
    /* 角色和路由的关联 */
    0: {
      main: [
        // {
        //   path: '/main/my_adminManage/GetAllUser',
        //   icon: 'orders-icon',
        //   title: '人员管理',
        //   group: 'my_adminManage',
        //   children: [
        //   ]},
        // {
        //   path: '/main/my_statics/UserStatics',
        //   icon: 'suncaper-menu-unfold',
        //   title: '用户统计'
        // }
      ]},
    1: {
      main: [
        {
          path: '/main/TextList',
          icon: 'sentence-icon',
          title: 'Text censor',
          children: []
        },
        {
          path: '/main/PictureList',
          icon: 'picture-icon',
          title: 'Picture censor',
          group: 'product',
          children: []
        },
        {
          path: '/main/VedioList',
          icon: 'vedio-icon',
          title: 'Vedio censor',
          group: 'product',
          children: []
        },
        {
          path: '/main/AuditHistory',
          icon: 'orders-icon',
          title: 'censor history'
        }
      ]
    },
    2: {
      main: [

      ]
    },
    3: {
      main: [

      ]
    },

    4: {
      main: [

      ]
    }
  },
  sidebarTheme: {
    dark: {
      // '#1f2c35',
      background: '#1f2c35',
      text: '#ffffff',
      activeText: '#ffffff'
    },
    light: {
      background: '#ffffff',
      text: '#000000',
      activeText: '#1890ff'
    }
  }
}
