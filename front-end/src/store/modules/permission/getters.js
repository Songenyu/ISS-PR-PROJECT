export default {
  getPermission: state => roleId => state.permissionMap[roleId],
  getWhiteList: state => state.whiteList
}
