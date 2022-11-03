export default {
  getSidebarList: state => roleId => state.sidebarMap[roleId],
  getSidebarTheme: state => theme => state.sidebarTheme[theme]
}
