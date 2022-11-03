<template>
  <!--theme="dark"-->
  <suncaper-layout
    theme="dark"
    :logo="logo"
    :sidebar-list="sidebarList"
    :logout="logout"
  />
</template>

<script>
import {mapGetters} from 'vuex'
import Layout from '@/layouts/Layout'
import logo from '@/assets/images/logo.png'
import {userLogout} from '@api/api'

export default {
  name: 'Main',
  data () {
    return {
      logo: {
        src: logo,
        alt: 'Group 17',
        firstDes: 'censor',
        secondDes: 'platform'
      }
    }
  },
  computed: {
    ...mapGetters({
      roleId: 'user/getroleId',
      getSidebarList: 'sidebar/getSidebarList'
    }),
    sidebarList () {
      return this.getSidebarList(this.roleId).main
    }
  },
  methods: {
    logout () {
      userLogout().then(res => {
        this.$router.push({path: '/login'})
      })
    }
  },
  components: {
    'suncaper-layout': Layout
  }
}
</script>
