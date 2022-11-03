<!--
 * @Description: 列表组件，用于首页、全部商品页面的商品列表
 * @Author: hai-27
 * @Date: 2020-02-07 16:23:00
 * @LastEditors: hai-27
 * @LastEditTime: 2020-04-05 13:22:22
 -->
<template>

    <div id="myList" class="myList">
        <ul>
            <li v-for="item in list" :key="item.id">

                <router-link :to="{ name: 'ContentDetail', query: {media:item} }">
                    <img :src="item.url" alt v-if="typeid===1"/>
                    <img :src="item.frameurl" alt v-if="typeid===2" />
                    <el-input v-if="typeid===0" type="textarea" autosize v-model="item.strings" style="display: block;min-height: 100px;list-style: none;"
                    readonly>
                </el-input>
                    <h3>Publisher:&nbsp;{{item.username}}</h3>
                    <h3>Title:&nbsp;{{item.mediatitle}}</h3>
                    <h3>UploadTime:&nbsp;{{item.createtime}}</h3>
                    <h3>From:&nbsp;{{item.fromresource}}</h3>
                    <el-tag style="margin-left: 70px;" type="warning" v-if="item.lablefrommodel===-2">Uncensored</el-tag>
                    <el-tag style="margin-left: 30px;" type="danger" v-if="item.lablefrommodel===-1">Need manual censor</el-tag>
                    <!-- <p>
                        <span v-if="item.generalProductRole===0">整体估价{{item.caigouTotalPrice}}元</span>
                        <span v-if="item.generalProductRole===1">商品单价{{item.gongyingPrice}}元</span>
                    </p> -->
                    <!-- <h3 v-if="item.checkState===0">
                        <el-tag type="danger" v-if="item.checkState===0">unchecked</el-tag>
                    </h3>
                    <h3 v-if="item.checkState===1">
                        <el-tag type="danger" v-if="item.checkResult===0">invalid</el-tag>
                        <el-tag type="success" v-if="item.checkResult===1">valid</el-tag>
                    </h3> -->
                </router-link>
            </li>
            <!-- <li v-show="isMore && list.length>=1" id="more">
                <router-link :to="{ name: 'Goods', query: {categoryID:categoryID} }">
                    浏览更多
                    <i class="el-icon-d-arrow-right"></i>
                </router-link>
            </li> -->
        </ul>
    </div>
</template>
<script>
export default {
  name: 'MediaList',
  // list为父组件传过来的商品列表
  // isMore为是否显示“浏览更多”
  props: ['list', 'isMore', 'isDelete', 'userId', 'typeid'],
  created () {
    console.log('MediaList:list', this.list)
  },
  data () {
    return {
    }
  },
  computed: {

  },
  methods: {
  }
}
</script>
<style scoped>
.myList ul li {
        z-index: 1;
        float: left;
        width: 250px;
        height: 325px;
        padding: 10px 0;
        margin: 0 0 14.5px 13.7px;
        background-color: white;
        -webkit-transition: all 0.2s linear;
        transition: all 0.2s linear;
        position: relative;
        list-style: none;
    }
    .myList ul li:hover {
        z-index: 2;
        -webkit-box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        -webkit-transform: translate3d(0, -2px, 0);
        transform: translate3d(0, -2px, 0);
        list-style: none;
    }
    .myList ul li img {
        display: block;
        width: 242px;
        height: 162px;
        margin: 0 auto;
        list-style: none;
        /* background: url(@assets/images/pdf.png) no-repeat 50%; */

    }
    .myList ul li h2 {
        margin: 25px 10px 0;
        font-size: 14px;
        font-weight: 400;
        color: #333;
        text-align: center;
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
        list-style: none;
    }
    .myList ul li h3 {
        margin: 15px -13px;
        height: 18px;
        font-size: 14px;
        font-weight: 550;
        color: #000000;
        text-align: center;
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
        list-style: none;
    }
    .myList ul li p {
        margin: 10px 10px 10px;
        text-align: center;
        color: #ff6700;
        list-style: none;
    }
    .myList ul li p .del {
        margin-left: 0.5em;
        color: #b0b0b0;
        text-decoration: line-through;
        list-style: none;
    }
    .myList #more {
        text-align: center;
        line-height: 280px;
    }
    .myList #more a {
        font-size: 18px;
        color: #333;
    }
    .myList #more a:hover {
        color: #ff6700;
    }

    a {
        text-decoration: none;
    }

    .router-link-active {
        text-decoration: none;
    }

    .el-tag {
        margin-top: -10px;
        background-color: #ecf5ff;
        border-color: #d9ecff;
        height: 32px;
        padding: 0 10px;
        line-height: 30px;
        font-size: 18px;
        border-width: 1px;
        border-style: solid;
        border-radius: 4px;
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        white-space: nowrap;
    }
</style>
