<template>
  <div class="goods" id="goods" name="goods">
    <!-- 主要内容区 -->
    <div class="main">
      <div class="search">
        <el-card>
          <el-form :inline="true" :model="searchCondition" size="mini" style="width:100%;    margin-left: 80px;">
            <el-form-item label="content ID:" label-width="">
              <el-input placeholder="please input" v-model="searchCondition.id" clearable>
              </el-input>
            </el-form-item>
            <el-form-item label="content title:" label-width="">
              <el-input placeholder="please input" v-model="searchCondition.mediatitle" clearable>
              </el-input>
            </el-form-item>
            <el-form-item label="publisher ID:" label-width="">
              <el-input placeholder="please input" v-model="searchCondition.userid" clearable>
              </el-input>
            </el-form-item>
            <el-form-item label="publisher name:" label-width="">
              <el-input placeholder="please input" v-model="searchCondition.username" clearable>
              </el-input>
            </el-form-item>
            <el-form-item label="content resource:" label-width="">
              <el-input placeholder="please input" v-model="searchCondition.fromresource" clearable>
              </el-input>
            </el-form-item>
            <el-form-item label="censor state:">
              <el-select v-model="searchCondition.lablefrommodel" placeholder="">
                <el-option label="" value=''></el-option>
                <el-option label="uncensored" value=-2></el-option>
                <el-option label="need manual censor" value=-1></el-option>
              </el-select>
            </el-form-item>

            <el-form-item>
              <el-button type="primary" icon="el-icon-search" size="mini" @click="getContentByTypeId()">search
              </el-button>
            </el-form-item>
            <el-form-item label="batch size:" style="    margin-left: 250px;">
              <el-select v-model="batchSize" placeholder="">
                <el-option v-for="item in batchSizeOptions" :key="item.value" :label="item.value" :value="item.value">
                </el-option>
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="el-icon-search" size="mini" @click="bulkAudit()">model bulk censor
              </el-button>
            </el-form-item>
          </el-form>
        </el-card>

      </div>

      <!-- 展示概要 -->
      <div class="list">
        <MediaList :list="medias" :userId="userId" :typeid="typeid" v-if="medias.length > 0"></MediaList>
        <div v-else class="none-product">
          <img style="" v-if="typeid === 1" src="@assets/images/No-image-found.jpg">
          <img style="" v-if="typeid === 0" src="@assets/images/No-text-found.png" width="20%"
            height="20%">
          <img style="" v-if="typeid === 2" src="@assets/images/No-video-found.png">
        </div>
      </div>
      <!-- 展示概要over -->

      <!-- 分页 -->
      <div class="pagination">
        <el-pagination @size-change="pageSizeChange" @current-change="pageNoChange"
          :current-page="searchCondition.pageNo" :page-sizes="[8, 12, 16]" :page-size="searchCondition.pageSize"
          layout="total, sizes, prev, pager, next, jumper" :total="searchCondition.totals">
        </el-pagination>
      </div>
      <!-- 分页END -->
    </div>
  </div>
</template>
<script>
import { getContentByTypeId, bulkAudit } from '@api/api'
import MediaList from './MediaList'
// import { mapGetters } from 'vuex'

export default {
  name: 'ContentList',
  components: { MediaList },
  props: ['typeid'],
  computed: {
    userRoleId: 'user/getroleId',
    userId: 'user/getUserId'
  },
  data () {
    return {
      medias: [],
      page4search: 0,
      searchCondition: {
        id: '',
        mediatitle: '',
        userid: '',
        username: '',
        fromresource: '',
        lablefrommodel: '',

        typeid: '',
        checkresult: 0,

        // 发送搜索请求专用
        pageNo: 1,
        pageSize: 8,
        totals: 100
      },
      maxSize: '',
      batchSize: '',
      batchSizeOptions: [],
      contentids: []
    }
  },
  created () {
    this.getContentByTypeId()
  },
  methods: {
    getContentByTypeId () {
      this.searchCondition.typeid = this.typeid
      getContentByTypeId(this.searchCondition).then(res => {
        this.medias = res.data.medias
        this.searchCondition.totals = res.data.totals
        this.maxSize = res.data.maxSize
        console.log('this.maxSize', this.maxSize)
        this.$notify({
          title: '',
          message: 'the number of the contents is ' + this.searchCondition.totals +
          ' . \rthere are ' + this.maxSize + ' piece of content can be bulk censored on this page',
          position: 'bottom-right'
        })
        this.initBatchOptions()
      })
    },
    initBatchOptions () {
      let max = this.maxSize
      this.batchSizeOptions = []
      for (;max >= 1; max /= 2) {
        this.batchSizeOptions.push({ value: Math.floor(max) })
        console.log(this.batchSizeOptions)
      }
    },
    bulkAudit () {
      if (this.batchSize === '') {
        return
      }
      this.$message({
        showClose: true,
        message: 'censoring and updating the database'
      })

      for (let i = 0; i < this.batchSize; i++) {
        if (this.medias[i].lablefrommodel === -2) {
          this.contentids.push(this.medias[i].id)
        }
      }

      // for (let i = 0; i < this.contentids.length; i++) {
      //   let id = [this.contentids[i]]
      //   bulkAudit({ ids: id, typeid: this.typeid })
      // }
      bulkAudit({ ids: this.contentids, typeid: this.typeid }).then(res => {
        this.getContentByTypeId()
      })
    }

  },
  // 返回顶部
  backtop () {
    const timer = setInterval(function () {
      const top = document.documentElement.scrollTop || document.body.scrollTop
      const speed = Math.floor(-top / 5)
      document.documentElement.scrollTop = document.body.scrollTop =
                  top + speed

      if (top === 0) {
        clearInterval(timer)
      }
    }, 20)
  },
  // 页码变化调用currentChange方法
  pageNoChange (currentPage) {
    this.searchCondition.pageNo = currentPage
    this.getContentByTypeId()
    this.backtop()
  },
  // 页码变化调用currentChange方法
  pageSizeChange (pageSize) {
    this.searchCondition.pageSize = pageSize
    this.getContentByTypeId()
    this.backtop()
  }

}
</script>

<style scoped>
.goods {
    background-color: #f5f5f5;
}

/* 分类标签CSS */
.goods .nav {
    background-color: white;
}

.goods .nav .product-nav {
    width: 1225px;
    height: 40px;
    line-height: 40px;
    margin: 0 auto;
}

.nav .product-nav .title {
    padding-left: 1.5%;
    width: 50px;
    font-size: 16px;
    font-weight: 700;
    float: left;
}

/* 分类标签CSS END */

/* 主要内容区CSS */
.goods .main {
    margin: 0 auto;
    max-width: 1225px;
}

.goods .main .list {
    min-height: 650px;
    padding-top: 14.5px;
    margin-left: -13.7px;
    padding-left: 6%;
    overflow: auto;
}

.goods .main .pagination {
    height: 50px;
    text-align: center;
}

.goods .main .none-product {
    color: #333;
    margin-left: 13.7px;
}

/* 主要内容区CSS END */
</style>
