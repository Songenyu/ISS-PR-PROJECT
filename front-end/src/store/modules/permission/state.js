export default {
  /* 这个白名单存的是组件名 */
  whiteList: ['/', 'notFound', 'Login', 'forbidden', 'badGateway', 'regist'],
  /* 权限映射：  12345表示角色类型, *表示所有 */
  permissionMap: {
    0: {
      main: ['*']
    },
    1: {
      main: ['*']
    },
    2: {
      main: ['*']
    },
    3: {
      main: ['*']
      // myProductPage: ['*']
    },
    4: {
      main: ['*']
    }
  }
}
