<template>
    <div>
        <el-dialog
                title="title"
                :visible.sync="dialogVisible"
                width="30%"
        >
            <span>{{description}}</span>
            <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
      </span>
        </el-dialog>
    </div>
</template>
<script>
export default {
  name: 'Dialog',
  props: [ 'title', 'description' ],
  data () {
    return {
      dialogVisible: true
    }
  }
}
</script>

<style scoped>

</style>
