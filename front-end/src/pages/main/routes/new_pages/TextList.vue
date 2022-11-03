<template>
  <div >
    <el-card class="crumbs-card">
      <div class="crumbs">

        <!-- 面包屑 -->
        <el-breadcrumb separator="/">
          <el-breadcrumb-item to="/">Home</el-breadcrumb-item>
          <el-breadcrumb-item>Uncensored texts</el-breadcrumb-item>
        </el-breadcrumb>

      </div>
    </el-card>
    <ContentList :typeid="typeid"></ContentList>
  </div>
</template>
<script>
import ContentList from './MediaComponents/ContentList.vue'

export default {
  name: 'TextList',
  components: {ContentList},
  props: {
  },
  created () {
  },
  data () {
    return {
      typeid: 0
    }
  },
  computed: {

  },
  methods: {
  }
}
</script>

<style scoped>
</style>
