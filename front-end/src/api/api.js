import http from '@http/http'

/**
 * 检测api
 */
export const detectSentence = (input) => http.GET('/api/detectSentence/', {input})
export const auditPicture = (location) => http.GET('/api/auditPicture/', { location })
export const videoDetection = (location) => http.GET('/api/videoDetection/', { location })

/**
*  session相关
* */
// 前端获取用户信息
export const _getUserInfo = (errMsg) => http.GET('/api/web/getLoginUser/', {}, errMsg)
// 退出
export const userLogout = (errMsg) => http.GET('/api/auth/logout', {}, errMsg)

/**
* 登录注册
* */
// 用户名-密码登录
export const usernameLogin = (user) => http.GET('/api/web/userNameLogin/', user)
/*
* 审核—数据库相关
*/
// 审核之后更新content表中的内容
export const updateContenAuditResult = ({ id, checkresult, lablefrommodel }) => http.GET('/api/web/updateContenAuditResult/', { id, checkresult, lablefrommodel })
// 审核有了明确结果之后新加history中的内容
export const insertHistory = (history) => http.GET('/api/web/insertHistory/', history)
// 查看审核记录 getAuditHistory
export const getAuditHistory = (page) => http.GET('/api/web/getAuditHistory/', page)

/*
* 内容相关
*/
//  根据条件搜索 未审核或者需要人工审核的内容 (默认type与checkresult)
export const getContentByTypeId = (searchCondition) => http.GET('/api/web/getContentByTypeId/', searchCondition)
//  根据条件搜索 未审核或者需要人工审核的内容 (默认type与checkresult)
export const bulkAudit = (no) => http.GET('/api/web/bulkAudit/', no)

export const todayAuditDetials = () => http.GET('/api/web/todayAuditDetials/', {})
