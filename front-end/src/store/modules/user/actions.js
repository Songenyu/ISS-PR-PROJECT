import { _getUserInfo } from '@api/user'
import types from './types'
export default {
  async fetchUserInfo ({ commit }) {
    console.log('fetchUserInfo')
    let res = await _getUserInfo()
    // console.log('this.GLOBAL', this.GLOBAL)
    // console.log('this.GLOBAL.loginRes', this.GLOBAL.loginRes)
    // let res = this.GLOBAL.loginRes
    console.log(res)
    if (res.status) {
      commit(types.SET_USER_ID, res.data.id)
      commit(types.SET_USER_NAME, res.data.username)
      commit(types.SET_USER_ROLEID, res.data.roleid)
    }
    return res
  }
}
