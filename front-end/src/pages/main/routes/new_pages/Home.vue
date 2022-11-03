<template>
    <div class="main">

            <!--后加导航-->
            <!--后加END-->
            <!--后加图片-->
            <div class="main-carousel">
                <div class="container">
                    <transition-group name="fade" tag="div" class="fade">
                        <div class="fade-item" v-for="(item,index) in fadeItems" v-show="index === curIndex" :key="item.imgUrl">

                                <!-- <img :src="item.imgUrl" alt="" > -->

                        </div>
                    </transition-group>
                </div>
            </div>
            <!--后加图片end_echarts_instance_-->
                                            <div id="todayAudi" class="main_container1" style="width:450px;height:450px;margin:-100px 0px 0px 400px;"></div>
                                            <div id="weekAllAudi" class="main_container2" style="width:450px;height:450px;margin:-20px 0px 0px 0px;"></div>
                                            <div id="weekProportio" class="main_container4" style="width:450px;height:450px;margin:-450px 0px 0px 400px"></div>
                                            <div id="weekUnpassCat" class="main_container3" style="width:450px;height:450px;margin:-450px 0px 0px 800px"></div>
            <div class="main-box">
                <div class="main">
                </div>
            </div>
        </div>

</template>

<script>
import {mapGetters} from 'vuex'
import { todayAuditDetials } from '@/api/api.js'
import * as echarts from 'echarts'
export default {
  name: 'Home',
  data () {
    return {
      //  后加
      curIndex: 0,
      timeId: '',
      fadeItems: [
        {imgUrl: './static/img/Home2.png', link: 'https://item.m1i.com/buyphone/redmi4x'}
      ],
      selected: '',
      isNavEnter: false,
      isMenuEnter: false,
      //  后加end

      // 轮播图sb路径
      imgBlock1: '',
      imgBlock2: '',
      imgBlock3: '',
      activeName: '-2',
      all: '全部',

      todayAudit: [],
      weekProportion: [],
      weekUnpassCata: [],
      weekAllAudit: []
    }
  },
  mounted () {
    this.initTodayChart()
    this.initWeekAuditChart()
    this.initWeekProportionChart()
    this.initWeekUnpassCata()
  },
  created () {
  },
  activated () {
  },
  watch: {
  },
  destroyed () {
    var box = document.getElementById('todayAudit')
    box.remove()
    box = document.getElementById('weekAllAudit')
    box.remove()
    box = document.getElementById('weekProportion')
    box.remove()
    box = document.getElementById('weekUnpassCata')
    box.remove()
  },
  computed: {
    ...mapGetters({
      userRoleId: 'user/getroleId',
      userId: 'user/getUserId'
    })
  },
  methods: {
    initTodayChart () {
      var todayAuditChart = this.$echarts.init(document.getElementById('todayAudi'))
      var option
      console.log('this.todayAudit', this.todayAudit)
      console.log('this.initTodayChart')
      option = {
        title: {
          text: 'Censor in today',
          subtext: 'pass proportion',
          left: 'center'
        },
        tooltip: {
          trigger: 'item'
        },
        legend: {
          orient: 'vertical',
          left: 'left'
        },
        series: [
          {
            name: 'Access From',
            type: 'pie',
            radius: '50%',
            data: [
            ],
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }
        ]
      }

      todayAuditDetials().then(res => {
        this.todayAudit = res.data.todayAudit
        option.series[0].data.push({ value: this.todayAudit[0], name: 'not pass' })
        option.series[0].data.push({ value: this.todayAudit[1], name: 'pass' })

        this.weekAllAudit = res.data.weekAllAudit
        this.weekProportion = res.data.weekProportion
        this.weekUnpassCata = res.data.weekUnpassCata
        console.log('this.res', res.data)

        todayAuditChart.clear()
        option && todayAuditChart.setOption(option)
      })
    },
    initWeekAuditChart () {
      var weekAllAudit = document.getElementById('weekAllAudi')
      var weekAllAuditChart = echarts.init(weekAllAudit)
      var option

      option = {
        title: {
          text: 'cencor in a week',
          subtext: 'number of daily censor',
          left: 'center'
        },
        xAxis: {
          type: 'category',
          data: []
        },
        yAxis: {
          type: 'value'
        },
        series: [
          {
            data: [],
            type: 'line'
          }
        ]
      }
      todayAuditDetials().then(res => {
        this.weekAllAudit = res.data.weekAllAudit
        for (let i = 0; i < this.weekAllAudit.length; i++) {
          option.xAxis.data.push(this.weekAllAudit[i].date)
          option.series[0].data.push(this.weekAllAudit[i].number)
        }
        weekAllAuditChart.clear()
        option && weekAllAuditChart.setOption(option)
      })
    },
    initWeekProportionChart () {
      var weekProportion = document.getElementById('weekProportio')
      var weekProportionChart = echarts.init(weekProportion)
      var option

      option = {
        title: {
          text: 'Censor in a week',
          subtext: 'pass proportion',
          left: 'center'
        },
        tooltip: {
          trigger: 'item'
        },
        legend: {
          orient: 'vertical',
          left: 'left'
        },
        series: [
          {
            name: 'Access From',
            type: 'pie',
            radius: '50%',
            data: [
            ],
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }
        ]
      }
      todayAuditDetials().then(res => {
        this.weekProportion = res.data.weekProportion
        option.series[0].data.push({ value: this.weekProportion[0], name: 'not pass' })
        option.series[0].data.push({ value: this.weekProportion[1], name: 'pass' })

        weekProportionChart.clear()
        option && weekProportionChart.setOption(option)
      })
    },
    initWeekUnpassCata () {
      var weekUnpassCata = document.getElementById('weekUnpassCat')
      var weekUnpassCataChart = echarts.init(weekUnpassCata)
      var option

      option = {
        title: {
          text: 'Censor in a week',
          subtext: 'illegal catagory',
          left: 'center'
        },
        tooltip: {
          trigger: 'item'
        },
        legend: {
          orient: 'vertical',
          left: 'left'
        },
        series: [
          {
            name: 'Access From',
            type: 'pie',
            radius: '50%',
            data: [
            ],
            emphasis: {
              itemStyle: {
                shadowBlur: 10,
                shadowOffsetX: 0,
                shadowColor: 'rgba(0, 0, 0, 0.5)'
              }
            }
          }
        ]
      }
      todayAuditDetials().then(res => {
        this.weekUnpassCata = res.data.weekUnpassCata
        option.series[0].data.push({ value: this.weekUnpassCata[0], name: 'porn' })
        option.series[0].data.push({ value: this.weekUnpassCata[1], name: 'banned face' })
        option.series[0].data.push({ value: this.weekUnpassCata[2], name: 'sensitive words' })

        console.log('this.weekunpassCata', this.weekUnpassCata)
        weekUnpassCataChart.clear()
        option && weekUnpassCataChart.setOption(option)
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.fade-item {
    position: relative;
    width: 50%;
    height: 160px;
  }
.fade-item img {
    position:absolute;
    width: 1200px;
    top: 200%;
    transform: translate(50%, -50%);
    margin-left: -391px;
}
</style>
