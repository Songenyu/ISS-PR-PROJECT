<template>
  <div class="header">
    <div class="header-left">
      <a
        href="javascript:;"
        class="header-icon"
        @click="collapseTrigger"
        role="button"
      >
        <s-icon
          v-if="collapse===true"
          icon="suncaper-menu-fold"
        />
        <s-icon
          v-else
          icon="suncaper-menu-unfold"
        />
      </a>
      <span class="header-title text-center">Welcome，{{roleName}} </span>
    </div>

    <div class="header-right">

      <s-icon
              icon="suncaper-user"
              class="text-center"
      />
      <span class="text-center" >
          {{userName}}
        </span>
      <a
              href="javascript:;"
              class="header-logout"
              @click="logout"
              role="button"
      >
        <s-tooltip effect="dark" content="退出" placement="bottom">
          <s-icon
                  icon="suncaper-quit"
          />
        </s-tooltip>
      </a>
    </div>
  </div>
</template>

<script>
import Icon from '@/components/Icon'
import {Tooltip} from 'element-ui'
import {} from '@api/api' // d userLogout

export default {
  name: 's-header',
  props: {
    collapseTrigger: Function,
    collapse: Boolean,
    logout: Function,
    userName: String,
    roleName: String,
    userRoleId: Number
  },
  components: {
    's-icon': Icon,
    's-tooltip': Tooltip
  },
  methods: {
    submitMysearch () {
      if (this.mySearch.searchContent === '') {
        this.$message('默认为查找所有，如果想查看所有建议输入/all/')
      }
      if (this.mySearch.searchMethod === '') {
        this.$message('请选择搜索方向')
      } else if (this.mySearch.searchMethod < 2) {
        console.log('this.mySearch.searchMethod')
        console.log(this.mySearch.searchMethod)
        this.$router.push({name: 'Goods',
          query: {searchMethod: this.mySearch.searchMethod,
            searchContent: this.mySearch.searchContent}})
      } else {
        this.$router.push({name: 'GetSearchUser',
          query: {searchMethod: this.mySearch.searchMethod,
            searchContent: this.mySearch.searchContent}})
      }
    }
  },
  data () {
    return {
      mySearch: {
        searchMethod: '',
        searchContent: '',
        categoryID: []
      },
      searchResults: []
    }
  }
}
</script>

<style lang="less" scoped>
  @import "../assets/styles/var";
  .header {
    width: 100%;
    height: 10%;
    padding: 0 23px;
    line-height: 59px;
    box-sizing: border-box;
    background: #ffffff;
    border-bottom: 1px solid @borderBottomColor;
    overflow: hidden;
    > span {
      vertical-align: middle;
    }
  }
  .header-left {
    display: inline-block;
    float: left;
  }
  .header-right {
    font-size: 14px;
    float: right;
    display: inline-block;
    /*display: inline-flex;*/
  }
.header-title {
  font-size: 14px;
  margin-left: 10px;
}
  .header-icon {
    font-size: 22px;
    color: inherit;
    outline: none;
    display: inline-block;
    /*display:flex;*/
    text-decoration: none;
    /*vertical-align: top;*/
    vertical-align: middle;
    &:hover {
      color: @dch;
    }
  }
  .header-logout {
    .header-icon;
    .text-center;
    font-size: 14px;
    margin-left: 10px;
    line-height: normal;
    &:hover {
      color: red;
    }
  }
  .text-center{
    vertical-align: middle;
  }
  .search{
    display: inline-block;
    font-size: 14px;
    margin:0px auto;
    vertical-align: middle;
    margin-left: 15%;
    margin-top: 1.5%;
    width: 50%
  }
</style>
