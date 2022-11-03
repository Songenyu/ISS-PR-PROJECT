<template>
  <div>
    <div class="outer_box">
      <div class="back_one"></div>
      <div class="back_two"></div>
      <div class="login_box">
        <h3 class="title">Welcome</h3>

        <div v-if="loginWay==='1'" class="userNamePassWordForm">

          <el-form ref="userNamePassWordForm" label-position="left" :model="loginUser" :rules="rules"
            label-width="80px">

            <el-form-item label="username" prop="username" style="padding-left: 3.5%;">
              <el-input class="iconfont" type="text" placeholder="please input" style="margin-bottom: 5%;width: 92%;"
                v-model="loginUser.username" />
            </el-form-item>

            <el-form-item label="password" prop="password" style="padding-left: 3.5%;margin-top:2%">
              <el-input class="iconfont" type="password" placeholder="please input" style="margin-bottom: 5%;width: 92%;"
                show-password="false" v-model="loginUser.password" />
            </el-form-item>
          </el-form>
          <el-button class="logIn_btn" type="text" v-on:click="usernameLogin(loginUser)">login</el-button>
        </div>
    </div>

    <div>
    <el-dialog title="Login failed" :visible.sync="loginFailureDialogVisible" width="20%"
      style="color: red;margin-top: 10%">
      <span style="color: orangered;">{{loginFailureDialogDescription}}</span>
    </el-dialog>
    <el-dialog title="Verification code sent successfully" :visible.sync="verifyCodeDialogVisible" width="20%"
      style="margin-top: 10%">
      <span>{{verifyCodeDialogDescription}}</span>
      <span slot="footer" class="dialog-footer">
      </span>
    </el-dialog>
  </div>
</div>
</div>
</template>

<script>
import {usernameLogin} from '@api/api'
export default {
  name: 'login',
  components: {
  },
  mounted () {
    if (location.href.indexOf('#reloaded') === -1) {
      location.href = location.href + '#reloaded'
      location.reload()
    }
  },

  data () {
    return {
      todayAudit: [],
      weekProportion: [],
      weekUnpassCata: [],
      weekAllAudit: [],
      user: {
        id: 0,
        username: '',
        password: '',
        roleId: 0
      },
      loginWay: '1',
      loginUser: {
        id: 0,
        username: '',
        password: '',
        email: '',
        verifyCode: ''
      },
      loginSuccessDialogVisible: false,

      verifyCodeDialogVisible: false,
      verifyCodeDialogTitle: '验证码发送成功',
      verifyCodeDialogDescription: '验证码发送成功，有效期为5分钟，大约两分钟才能收到邮件，请耐心等待',

      loginFailureDialogVisible: false,
      loginFailureDialogTitle: 'login failure',
      loginFailureDialogDescription: 'please input again',

      // 表单验证，需要在 el-form-item 元素中增加 prop 属性
      rules: {
        username: [
          { required: true, message: 'username can not be wrong', trigger: 'blur' },
          { min: 3, max: 18, message: 'the length of username is wrong', trigger: 'blur' }
        ],
        password: [
          { required: true, message: 'password cannot be null', trigger: 'blur' },
          { min: 6, max: 30, message: 'lenth of pass word is worng', trigger: 'blur' }
          // {
          //   trigger: 'blur',
          //   validator: (rule, value, callback) => {
          //     var passwordreg = /(?![A-Z]*$)(?![a-z]*$)(?![0-9]*$)(?![^a-zA-Z0-9]*$)/
          //     console.log(passwordreg.test(value))
          //     if (!passwordreg.test(value)) {
          //       callback(new Error('密码必须由大写字母、小写字母、数字、特殊符号中的2种及以上类型组成!'))
          //     } else {
          //       callback()
          //     }
          //   }
          // }
        ],
        email: [
          { required: true, message: '邮箱不可为空', trigger: 'blur' },
          {
            trigger: 'blur',
            validator: (rule, value, callback) => {
              var emailreg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/
              console.log(emailreg.test(value))
              if (!emailreg.test(value)) {
                callback(new Error('邮箱格式错误'))
              } else {
                callback()
              }
            }
          }
        ],
        verifyCode: [
          { required: true, message: '验证码不可为空', trigger: 'blur' },
          { min: 6, max: 6, message: '验证码长度错误', trigger: 'blur' },
          {
            trigger: 'blur',
            validator: (rule, value, callback) => {
              var verifyCodereg = /^([0-9])+/
              console.log(verifyCodereg.test(value))
              if (!verifyCodereg.test(value)) {
                callback(new Error('验证码格式错误'))
              } else {
                callback()
              }
            }
          }]
      },

      // 对话框显示和隐藏
      dialogVisible: false
    }
  },

  methods: {

    toRegist () {
      this.$refs.Regist.regist()
    },
    toMain () {
      if (this.user !== null) {
        if (this.user.id !== null) {
          this.$message('login success')
          this.loginSuccessDialogVisible = true
          this.$router.push({ name: 'Home',
            query: {
            }})
        } else {
          this.loginFailureDialogVisible = true
        }
      }
      if (this.user === null) {
        this.loginFailureDialogVisible = true
      }
    },
    usernameLogin: function (tempUser) {
      if (tempUser.username === '' || tempUser.password === '') {
        this.loginFailureDialogVisible = true
        return
      }
      usernameLogin(tempUser).then(res => {
        this.user = res.data
        this.user.roleId = res.data.roleid
        console.log(this.user)

        this.toMain()
      })
    }
  }
}

</script>
<style scoped>
.loginBox {
  height: auto;
  width: 300px;
  padding-top: 10%;
  margin: 0px auto;
}

* {
  margin: 0px;
  padding: 0px;
}

body {
  background-color: wheat;
}

input {
  border: none;
  border-bottom: 1px solid #dfdfdf;
  padding: 0px 0px 5px 15px;
  margin-left: 15px;
  font-size: 15px;
  color: #dfdfdf;
}

.outer_box {
  position: relative;
  height: calc(100vh);
}

/* 背景颜色 */
.back_one {
  position: absolute;
  width: 50%;
  height: 100%;
  left: 0px;
  background-color: #7BB6B6;
}

.back_two {
  position: absolute;
  width: 50%;
  height: 100%;
  right: 0px;
  background-color: #E3D0AD;
}

/* 登录窗口 */
.login_box {
  width: 300px;
  height: 350px;
  background-color: #fff;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  box-shadow: 10px 10px #80808079;
}

/* 标题 */
.login_box .title {
  width: 100%;
  text-align: center;
  margin: 35px 0px 35px 0px;
  font-size: 30px;
  color: #52565B;
}

/* p标签的公共样式 */
.login_box p {
  width: 100%;
  height: 40px;
  margin-top: 15px;
  text-align: center;
  justify-content: center;
}

/* iconfont */
.login_box p i {
  padding-top: 1%;
  padding-bottom: 1%;
  color: #52565B;
  font-size: 25px;
}

/* 登录按钮的样式 */
.login_box .logIn_btn {
  width: 80%;
  height: 40px;
  line-height: 40px;
  margin-top: 2.5%;
  margin-left: auto;
  margin-right: auto;

  background-color: #EBF7F3;
  color: #7BB6B6;
  border-radius: 5px;
  -webkit-box-shadow: 0px 0px 3px #e6e5e5;
  box-shadow: 0px 0px 3px #e6e5e5;
  font-weight: bold;
  display: -webkit-box;
  display: -webkit-flex;
  display: -ms-flexbox;
  display: flex;

  display: flex;
  justify-content: center;
  align-items: center;
}

.login_box .logIn_btn span {
  display: block;
  width: 33%;
  /* height: 100%; */
}

.login_box .logIn_btn .left_line {
  height: 20px;
  margin-top: 20px;
  border-left: 2px solid #7BB6B6;
}

.login_box .logIn_btn .right_line {
  height: 20px;
  border-right: 2px solid #7BB6B6;
}

/* 注册按钮 */
.login_box .login {
  width: 100px;
  height: 40px;
  margin: 20px 0px 0px 100px;
  color: #E3D0AD;
  font-weight: bold;
  line-height: 40px;

}

.verifyCodeInput {
  display: inline-flex;
}

.regist_btn {
  margin-top: 3%;
  float: right;
  margin-right: 20%;
  color: #E3D0AD;
  font-size: large;

  /*width: 125.7px;*/
  /*height: 40px;*/
  /*line-height: 40px;*/
  /*background-color: #EBF7F3;*/
  /*color: #7BB6B6;*/
  /*border-radius: 5px;*/
  /*-webkit-box-shadow: 0px 0px 3px #e6e5e5;*/
  /*box-shadow: 0px 0px 3px #e6e5e5;*/
  /*font-weight: bold;*/
  /*display: -webkit-box;*/
  /*display: -webkit-flex;*/
  /*display: -ms-flexbox;*/
  /*display: flex;*/
  /*display: flex;*/
  /*justify-content: center;*/
  /*align-items: center;*/
}

.el-form-item>>>.el-form-item__error {
  margin-top: -5%;
}
</style>
