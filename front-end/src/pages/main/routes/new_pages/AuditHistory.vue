<template>
    <div>
        <el-card class="crumbs-card">
            <div class="crumbs">
                <el-breadcrumb separator="/">
                    <el-breadcrumb-item :to="{ path: '/main/' }">Home</el-breadcrumb-item>
                    <el-breadcrumb-item >Audit history</el-breadcrumb-item>

                </el-breadcrumb>
            </div>
        </el-card>
        <el-card class="container">
            <el-table
                    ref="filterTable"
                    :data="audits"
                    style="width: 100%"
                    stripe
                    border>
        <!-- contentid,mediatitle,username(审核人员),createtime,method,pass_field,reason -->
                <el-table-column prop="id"
                                 label="audit id"
                                 width="80%"
                >
                </el-table-column>
                <el-table-column prop="contentid"
                                 label="content id"
                                 width="100%"
                >
                </el-table-column>
                <el-table-column prop="mediatitle" label="media Title" >
                </el-table-column>

                <el-table-column prop="username"
                                 label="auditor"
                                 width="80%"
                >
                </el-table-column>
                <el-table-column prop="createtime"
                                 label="audit time"
                >
                </el-table-column>
                <el-table-column prop="method" label="method" width="120%" >
                </el-table-column>

                <el-table-column prop="pass_field"
                                 label="Pass ?"
                                 width="80%"
                >

                </el-table-column>
                <el-table-column prop="reason"
                                 label="reason"
                                 width="100%"
                >

                </el-table-column>

                <!-- <el-table-column fixed="right" label="进行审核" width="200">
                    <template slot-scope="scope">
                        <el-button @click="shenhe(scope.row)" type="text" size="small">提交审核</el-button>
                    </template>
                </el-table-column> -->
            </el-table>

            <el-pagination
                    @size-change="pageSizeChange"
                    @current-change="pageNoChange"
                    :current-page="page.pageNo"
                    :page-sizes="[10, 20, 30, 40]"
                    :page-size="page.pageSize"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="page.totals">
            </el-pagination>
        </el-card>

    </div>
</template>

<script>
import { getAuditHistory } from '@api/api'
export default {
  name: 'AuditHistory',
  data () {
    return {
      page: {
        pageNo: 1,
        pageSize: 10,
        totals: 0
      },
      audits: []
      // what to show
      /**
       * contentid,mediatitle,username(审核人员),createtime,method,pass_field,reason
       * + return totals
      */
    }
  },
  created () {
    this.getAuditHistory()
  },
  methods: {
    getAuditHistory () {
      getAuditHistory(this.page).then(res => {
        this.audits = res.data.audits
        this.page.totals = res.data.totals
      })
    },
    pageSizeChange: function (pageSize) {
      this.page.pageSize = pageSize
      this.getAuditHistory()
    },
    pageNoChange: function (pageNo) {
      this.page.pageNo = pageNo
      this.getAuditHistory()
    }
  }
}
</script>

<style scoped>

</style>
