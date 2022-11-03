<template>
    <div id="details">
        <!-- 头部 -->
        <el-card class="crumbs-card">
          <div class="crumbs">

            <!-- 面包屑 -->
            <el-breadcrumb separator="/">
              <el-breadcrumb-item to="/main/">Home</el-breadcrumb-item>
              <el-breadcrumb-item>Check</el-breadcrumb-item>
              <el-breadcrumb-item>Content Detail</el-breadcrumb-item>
            </el-breadcrumb>

          </div>
        </el-card>
        <!-- 头部END -->
    <!-- 主要内容 -->
    <div class="main">
        <!-- 左侧图 -->
        <div class="block">
            <div >
                <el-link :href="media.url" v-if="media.typeid!==0">
                    <img v-if="media.typeid===2"
                            style="height:450px;width:450px;margin-left: 100px;"
                            :src="media.frameurl"
                            :alt="media.mediatitle"
                            :onerror="defaultImg"
                    />
                    <img v-if="media.typeid===1" style="height:450px;width:450px;margin-left: 100px;" :src="media.url"
                      :alt="media.mediatitle" :onerror="defaultImg" />
                </el-link>
                <el-input v-if="media.typeid===0" type="textarea" autosize v-model="media.strings"
                  style="height:450px;width:450px;margin-left: 100px;" readonly>
                  </el-input>

            </div>
        </div>
        <!-- 左侧图END -->

        <!-- 右侧内容区 -->
        <div class="content" style="display: inline-grid;">
            <div style="display: inline-flex;">
                <p class="intro">state:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                <el-tag type="warning" v-if="media.lablefrommodel===-2" style="    margin-top: 20px;">uncensored</el-tag>
                <el-tag type="danger" v-if="media.lablefrommodel===-1" style="    margin-top: 20px;">need manual censor</el-tag>
                <el-tag type="success" v-if="media.lablefrommodel!==-2 && media.lablefrommodel!==-1" style="    margin-top: 20px;">censored</el-tag>
            </div>
            <div style="display: inline-flex;">
                <p class="intro">upload time:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                <p class="store">{{media.createtime}}</p>
            </div>
            <div style="display: inline-flex;">
                <p class="intro">media title:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                <p class="intro">{{media.mediatitle}}</p>
            </div>
                        <div style="display: inline-flex;">
                          <p class="intro">publisher name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                          <p class="intro">{{media.username}}</p>
                        </div>
                        <div style="display: inline-flex;">
                          <p class="intro">publisherID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
                          <p class="intro">{{media.userId}}</p>
                        </div>
           <!-- 可以放是否审核通过，没有通过的话再加上原因 -->
            <!-- <div class="price">
                    <span   v-if="product.generalProductRole===0">
                        整体估价:&nbsp;&nbsp;&nbsp;{{product.caigouTotalPrice}}元</span>
                <div class="orderCountDown" v-if="product.generalProductRole===0"  >
                    {{timeCount}}
                </div>
                <span   v-if="product.generalProductRole===1">
                        商品单价:&nbsp;&nbsp;&nbsp;{{product.gongyingPrice}}元</span>
            </div> -->

            <!-- 内容区底部按钮 -->
            <div class="button">
                <el-button v-if="media.checkresult===0 && media.typeid!==0" class="shop-cart" @click="dialogManualAudit=true">manual censor</el-button>
                <el-button v-if="media.checkresult===0 && media.lablefrommodel!==-1" class="shop-cart" @click="modelAudit()"> model censor</el-button>
            </div>
        </div>
        <!-- 右侧内容区END -->
    </div>
    <!-- 主要内容END -->

        <!--model审核不通过/通过 dialogModelPass-->
        <el-dialog title="model audit result" :visible.sync="dialogModelPass">
            <el-form >
                <el-form-item label="audit result" label-width="120px" >
                    <el-input readonly v-if="media.checkresult===1" v-model="auditResultSuccessFilling"> </el-input>
                    <el-input readonly v-if="media.checkresult===-1" v-model="auditResultFailureFilling"> </el-input>
                  </el-form-item>
                <el-form-item label="reason:" v-if="media.checkresult===-1">
                    <el-checkbox-group v-model="illegalCatagory">
                      <el-checkbox v-for="item in allCatagoryIdAndName"
                      :key="item.id"
                      :label="item.id"
                      :name="item.name"
                      disabled
                      >{{item.name}}</el-checkbox>
                    </el-checkbox-group>
                </el-form-item>
                <el-form-item label="porn probability:" v-if="media.checkresult===-1 && media.typeid!==0">
                  <el-input readonly v-model="pornProbablityFilling">
                  </el-input>
                </el-form-item>
                <el-form-item label="banned faces" v-if="media.checkresult===-1 && media.typeid!==0">
                  <el-input readonly v-model="connectFacesAndTimesString"></el-input>
                </el-form-item>
                <el-form-item label="sensitive words" v-if="media.checkresult===-1 && media.typeid===0">
                  <el-input readonly v-model="connectSentiWordAndTimesSting"></el-input>
                </el-form-item>
            </el-form>
            <el-button type="primary" @click="dialogModelPass = false">confirm</el-button>
        </el-dialog>

        <!-- 需要人工审核的弹窗 dialogNeedManualAudit -->
          <el-dialog title="need manual audit" :visible.sync="dialogNeedManualAudit">
                  <el-form>
                    <el-form-item label="audit result:" label-width="120px">
                      <el-input readonly v-model="auditResultFilling"> </el-input>
                    </el-form-item>
                    <el-form-item label="porn probability:" >
                      <el-input readonly v-model="pornProbablityFilling">
                      </el-input>
                    </el-form-item>
                  </el-form>
                  <el-button type="primary" @click="dialogNeedManualAudit = false">confirm</el-button>
          </el-dialog>

        <!-- 进行人工审核的弹窗 -->
        <el-dialog title="manual audit" :visible.sync="dialogManualAudit">
          <el-form :model="history.reason">
            <el-form-item label="Does it include porn?" v-if="media.typeid!==0">
              <el-switch style="display: block;margin-top: 8px;"
                  v-model="pornJudgementIndialog"
                  active-color="#ff4949"
                  inactive-color="#13ce66"
                  active-text="yes"
                inactive-text="no">
              </el-switch>
            </el-form-item>
            <el-form-item label="Does it include banned faces?" v-if="media.typeid!==0">
              <el-switch style="display: block;margin-top: 8px;" v-model="includeFacesIndialog" active-color="#ff4949" inactive-color="#13ce66"
                active-text="yes" inactive-text="no">
              </el-switch>
            </el-form-item>
          </el-form>
          <el-button @click="dialogManualAudit = false">cancel</el-button>
          <el-button type="primary" @click="manualAudit() ">confirm</el-button>
        </el-dialog>
    </div>
</template>

<script>
import { auditPicture, detectSentence, videoDetection,
  updateContenAuditResult, insertHistory } from '@api/api'
import {mapGetters} from 'vuex'

export default {
  name: 'ContentDetail',
  components: {},
  data () {
    return {

      defaultImg: 'this.src="' + require('@assets/images/pdf.png') + '"',

      pornProbablityFilling: '(normal:0-0.75, fuzzy:0.75-0.95, porn:0.95-1)',
      auditResultFilling: 'there may be some porn content, it needs manual audit',
      auditResultSuccessFilling: 'pass the audit',
      auditResultFailureFilling: 'fail to pass the audit',
      porn: 0.0001,
      pornJudgementIndialog: false,
      includeFacesIndialog: false,
      face: [],
      sensitiveWords: [],
      connectFacesAndTimesString: '',
      connectSentiWordAndTimesSting: '',
      history: {
        userid: 0,
        contentid: 0,
        method: 1,
        pass_field: 0,
        reason: 0
      },
      // 违规类型的checkbox
      illegalCatagory: [],
      // 按理说应该从后端取的
      allCatagoryIdAndName: [
        {
          id: 1,
          name: 'porn'
        },
        {
          id: 2,
          name: 'banned faces'
        },
        {
          id: 3,
          name: 'sensitive words'
        }
      ],
      media: {
        id: 0,
        typeid: 1,
        userid: 2,
        fromresource: '',
        mediatitle: '',
        checkresult: 0,
        lablefrommodel: -2,
        url: '',
        frameurl: '',
        strings: null,
        createtime: '2022-10-19 15:21:02',
        updatetime: '2022-10-19 15:21:06',
        is_deleted: 0,
        username: '',
        email: '',
        roleid: 0,
        inwhitelist: 1
      },
      user: {
        id: ''
      },

      dialogNeedManualAudit: false,
      dialogModelPass: false,
      dialogManualAudit: false
    }
  },
  computed: {
    ...mapGetters({
      userRoleId: 'user/getroleId',
      userId: 'user/getUserId'
    })
  },
  created () {
    this.media = this.$route.query.media
    console.log('this.media', this.media)
    this.user.id = this.$route.query.userId
  },
  methods: {
    /**
     * 审核方面的函数、调用审核接口、获取结果
     * 三种model审核
     * */
    modelAudit () {
      if (this.media.typeid === 0) {
        this.stringAudit()
      }
      if (this.media.typeid === 1) {
        this.pictureAudit()
      }
      if (this.media.typeid === 2) {
        this.vedioAudit()
      }
    },
    stringAudit () {
      let input = this.media.strings
      detectSentence(input).then(res => {
        this.sensitiveWords = res.data
        console.log(this.sensitiveWords)

        this.updateThisMediaChecAndlablefrommodel()
        this.updateContenAuditResult()

        this.insertHistory(1)

        this.reason2IllegalCatagory()
        this.wordsConnectNameAndType()
        this.showDialogs()
      })
    },
    pictureAudit () {
      let location = this.prePictureVedioModelAudit()
      auditPicture(location).then(res => {
        let data = res.data
        this.afterPictureVedioModelAudit(data)
      }
      )
    },
    vedioAudit () {
      let location = this.prePictureVedioModelAudit()
      videoDetection(location).then(res => {
        let data = res.data
        this.afterPictureVedioModelAudit(data)
      })
    },
    // 人工审核
    manualAudit () {
      this.media.checkresult = 1
      this.media.lablefrommodel = 1
      if (this.pornJudgementIndialog === true) {
        this.media.checkresult = -1
        this.media.lablefrommodel = 0
        this.history.reason = 1
      }
      if (this.includeFacesIndialog === true) {
        this.media.checkresult = -1
        this.media.lablefrommodel = 0
        this.history.reason += 2
      }
      this.updateContenAuditResult()
      this.insertHistory(0)
      this.dialogManualAudit = false
      this.$message({
        showClose: true,
        message: 'successfully upload the manual audit'
      })
    },

    /**
     * 图片和视频 送审前的操作
     */
    prePictureVedioModelAudit () {
      let location = this.media.url
      console.log('this.media.url', this.media.url)
      console.log('location', location)

      this.$message({
        showClose: true,
        message: 'running the model,please wait a moment'
      })
      return location
    },
    afterPictureVedioModelAudit (data) {
      console.log('data', data)
      this.porn = data.porn.toFixed(5)
      this.face = data.face
      this.pornProbablityFilling = this.porn + ' ' + this.pornProbablityFilling
      console.log('this.porn', this.porn)
      console.log('this.face', this.face, this.face.length === 0)
      // 将name与times连接，以方便在el展示
      this.connectNameAndTimes()

      this.updateThisMediaChecAndlablefrommodel()

      // dialog 通知用户 是否有色情、lyf；模型是否审核通过
      // 更新数据库
      // 更新content表 checkresult,lablefrommodel,updateTime, 另需要id进行查询
      // updateTime 在后端更新
      this.updateContenAuditResult()

      // 在明确 审核方法 以及 审核结果 的情况下，新添 审核记录表
      // 即 只有最后一种情况 不 更新审核记录表  this.media.lablefrommodel = -1，this.media.checkresult = 0
      console.log('run this.inserHistory', 'condition:', this.media.lablefrommodel, this.media.checkresult)
      this.insertHistory(1)
      this.reason2IllegalCatagory()
      this.showDialogs()
    },

    /**
     * 向后端发送 更新数据库的请求
    */
    updateContenAuditResult () {
      updateContenAuditResult({
        id: this.media.id,
        checkresult: this.media.checkresult,
        lablefrommodel: this.media.lablefrommodel
      }).then()
    },
    insertHistory (usedMethod) {
      // !A+!B = !(AB)
      if (this.media.lablefrommodel !== -1 || this.media.checkresult !== 0) {
        console.log('run inserHistory')
        // history赋值
        this.history.userid = this.userId
        this.history.contentid = this.media.id
        this.history.method = usedMethod
        this.history.pass_field = 1
        if (this.media.lablefrommodel + this.media.checkresult < 0) {
          this.history.pass_field = 0
        }
        insertHistory(this.history).then()
      }
    },

    /**
    * utils 只是为相关页面提供函数，或者为其他
    * */
    updateThisMediaChecAndlablefrommodel () {
      if (this.media.typeid !== 0) {
        if (this.porn < 0.75) {
          // 两个条件同时满足
          if (this.face.length === 0) {
            console.log('1')
            this.media.lablefrommodel = 1
            this.media.checkresult = 1
            this.history.reason = 0
          } else {
            // 不是porn但是有lyf
            console.log('2')
            // 不通过就要history.reason 设置值
            this.history.reason = 2

            this.media.lablefrommodel = 0
            this.media.checkresult = -1
          }
        }
        // 完完全全大冤种，是porn
        if (this.porn >= 0.95) {
          console.log('3')
          if (this.face.length === 0) {
            this.history.reason = 1
          }
          if (this.face.length !== 0) {
            this.history.reason = 3
          }
          this.media.lablefrommodel = 0
          this.media.checkresult = -1
        }
        // 不知道是不是porn看 是否有lyf
        if (this.porn >= 0.75 && this.porn < 0.95) {
          if (this.face.length !== 0) {
            console.log('4')
            // 先设成2，只算做有face
            this.history.reason = 2
            this.media.lablefrommodel = 0
            this.media.checkresult = -1
          } else {
            // 需要人工审核
            console.log('5')
            this.media.lablefrommodel = -1
            this.media.checkresult = 0
          }
        }
      } else {
        if (this.sensitiveWords.length !== 0) {
          this.media.lablefrommodel = 0
          this.media.checkresult = -1
          this.history.reason = 4
        } else {
          this.media.lablefrommodel = 1
          this.media.checkresult = 1
          this.history.reason = 0
        }
      }
    },

    // 人工进行审核的弹窗 不予展示
    // 此函数仅为 点击model审核 过后的可能出现的弹窗
    showDialogs () {
      if (this.media.lablefrommodel === -1 && this.media.checkresult === 0) {
        // 需要人工审核弹窗
        this.dialogNeedManualAudit = true
      } else if (this.media.lablefrommodel === 1 && this.media.checkresult === 1) {
        // model审核结果弹窗
        this.dialogModelPass = true
      } else {
        // model审核不通过，但是由于大致内容相同可以合并到一起
        // model审核结果弹窗
        console.log('审核不通过')
        this.dialogModelPass = true
      }
    },

    // 按理说应该在后端查找数据库然后新添一个字段
    reason2IllegalCatagory () {
      if (this.history.reason === 1) {
        this.illegalCatagory = [1]
      }
      if (this.history.reason === 2) {
        this.illegalCatagory = [2]
      }
      if (this.history.reason === 3) {
        this.illegalCatagory = [1, 2]
      }
      if (this.history.reason === 4) {
        this.illegalCatagory = [3]
      }
    },
    connectNameAndTimes () {
      let i = 0
      for (;i < this.face.length; i++) {
        this.connectFacesAndTimesString =
          this.face[i].name + ' appears ' +
          this.face[i].times + ' times ' + '; '
      }
    },
    wordsConnectNameAndType () {
      let i = 0
      for (;i < this.sensitiveWords.length; i++) {
        this.connectSentiWordAndTimesSting =
        this.sensitiveWords[i].name + ' appears ' +
        this.sensitiveWords[i].times + ' times ' + '; '
      }
    }
  }
}
</script>

<style>
    /* 头部CSS */
    #details .page-header {
        height: 64px;
        margin-top: -20px;
        z-index: 4;
        background: #fff;
        border-bottom: 1px solid #e0e0e0;
        -webkit-box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.07);
        box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.07);
    }
    #details .page-header .title {
        width: 1225px;
        height: 64px;
        line-height: 64px;
        font-size: 18px;
        font-weight: 400;
        color: #212121;
        margin: 0 auto;
    }
    #details .page-header .title p {
        padding-left: 2%;
        float: left;
    }
    #details .page-header .title .list {
        padding-right: 3%;
        height: 64px;
        float: right;
    }
    #details .page-header .title .list li {
        float: left;
        margin-left: 20px;
    }
    #details .page-header .title .list li a {
        font-size: 14px;
        color: #616161;
    }
    #details .page-header .title .list li a:hover {
        font-size: 14px;
        color: #ff6700;
    }
    /* 头部CSS END */

    /* 主要内容CSS */
    #details .main {
        width: 1225px;
        height: 560px;
        padding-top: 30px;
        margin: 0 auto;
    }
    #details .main .block {
        margin-left: -3%;
        float: left;
        width: 450px;
        height: 450px;

    }
    #details .el-carousel .el-carousel__indicator .el-carousel__button {
        background-color: rgba(163, 163, 163, 0.8);
    }
    #details .main .content {
        float: right;
        margin-left: 25px;
        width: 650px;
        background-color: rgb(244, 244, 244);
    }
    #details .main .content .name {
        height: 30px;
        line-height: 30px;
        font-size: 24px;
        font-weight: normal;
        color: #212121;
    }
    #details .main .content .intro {
        color: #b0b0b0;
        padding-top: 10px;
    }
    #details .main .content .store {
        color: #ff6700;
        padding-top: 10px;
    }
    #details .main .content .price {
        display: block;
        font-size: 18px;
        color: #ff6700;
        border-bottom: 1px solid #e0e0e0;
        padding: 25px 0 25px;
    }
    #details .main .content .price .del {
        font-size: 14px;
        margin-left: 10px;
        color: #b0b0b0;
        text-decoration: line-through;
    }
    #details .main .content .pro-list {
        background: #f9f9fa;
        padding: 30px 60px;
        margin: 50px 0 50px;
    }
    #details .main .content .pro-list span {
        line-height: 30px;
        color: #616161;
    }
    #details .main .content .pro-list .pro-price {
        float: right;
    }
    #details .main .content .pro-list .pro-price .pro-del {
        margin-left: 10px;
        text-decoration: line-through;
    }
    #details .main .content .pro-list .price-sum {
        color: #ff6700;
        font-size: 24px;
        padding-top: 20px;
    }
    #details .main .content .button {
        height: 55px;
        margin: 10px 0 20px 0;
    }
    #details .main .content .button .el-button {
        float: left;
        height: 55px;
        font-size: 16px;
        color: #fff;
        border: none;
        text-align: center;
    }
    #details .main .content .button .shop-cart {
        width: 180px;
        background-color: #ff6700;
    }
    #details .main .content .button .shop-cart:hover {
        background-color: #f25807;
    }

    #details .main .content .button .like {
        display: flex;
        justify-content: center;
        align-items: center;

        width: 180px;
        margin-left: 40px;
        background-color: #b0b0b0;
    }
    #details .main .content .button .like:hover {
        background-color: #757575;
    }
    #details .main .content .pro-policy li {
        float: left;
        margin-right: 20px;
        color: #b0b0b0;
    }
    #details .main .content .price .orderCountDown{
        display: inline-block;
        width: 20%;
        vertical-align: middle;
        margin-left: 30%;
        /*background-color: #ff6874;*/
        color: #ff6874;
        /*float: right;*/
    }
    .router-link-active {
        text-decoration: none;
    }
    /* 主要内容CSS END */
    .daishenheBunengchakanjingjia {
    }
</style>
