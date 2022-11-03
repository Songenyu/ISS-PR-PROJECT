import types from './types'
export default {
  [types.SET_USER_ID] (state, id) {
    state.id = id
  },
  [types.SET_USER_NAME] (state, userName) {
    state.userName = userName
  },
  [types.SET_USER_ROLEID] (state, roleId) {
    state.roleId = roleId
  }
}
