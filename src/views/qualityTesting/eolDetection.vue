<template>
  <div class="sub_page">
    <div class="header">
      <ul class="info_list">
        <li>
          <p>测试名称</p>
          <div>{{ EoltestDateList[0].testName }}</div>
        </li>
        <li>
          <p>设备编号</p>
          <div>{{ EoltestDateList[0].deviceId  }}</div>
        </li>
        <li>
          <p>电池包编号</p>
          <div>{{ EoltestDateList[0].batteryNo }}</div>
        </li>
        <li>
          <p>测试人员</p>
          <div>{{  EoltestDateList[0].operator }}</div>
        </li>
        <li>
          <p>室温</p>
          <div>{{ EoltestDateList[0].temperature }}</div>
        </li>
        <li>
          <p>湿度</p>
          <div>{{ EoltestDateList[0].humidity}}</div>
        </li>
        <li>
          <p>开始时间</p>
          <div>{{ EoltestDateList[0].startTime }}</div>
        </li>
        <li>
          <p>总时间</p>
          <div>{{ EoltestDateList[0].totalDuration }}</div>
        </li>
      </ul>
    </div>
    <!-- -->
    <!-- <div class="content" v-for="(v, i) in data.table" :key="i"> -->
    <div class="content" v-for="v in EoltestDateList[0].inspectList" :key="v.inspectId">
      <div class="tab_title">
        <div class="tab_title_item">
          <p>测试项</p>
          <div>{{ v.inspectStep }}</div>
        </div>
        <div class="tab_title_item">
          <p>运行时间</p>
          <div>{{ v.runDuration }}</div>
        </div>
        <div class="tab_title_item">
          <p>结果</p>
          <div class="state">{{ v.inspectResult }}</div>
        </div>
      </div>
      <ul class="tab_box">
        <li>子项序号</li>
        <li>名称</li>
        <li>测试参数</li>
        <li>测试值</li>
        <li>单位</li>
        <li>运行时间</li>
        <li>结果</li>
      </ul>
      <ul
        class="tab_box tab_item active_bg"
        v-for="val in v.itemList"
        :key="val.itemId"
      >
        <li>{{ val.itemId }}</li>
        <li>{{ val.itemStep }}</li>
        <li v-html="wrap(val.paramContent)"></li>
        <li>{{ val.paramValue }}</li>
        <li>{{ val.itemUnit }}</li>
        <li>{{ val.itemDuration }}</li>
        <li class="tab_state">{{ val.itemResult }}</li>
      </ul>
    </div>
  </div>
</template>

<script>
import {eolDetectionList} from '@/api/eolDetectionList'
export default {
  data() {
    return {
      EoltestDateList: [],
      data: {
        table: {},
      },
    };
  },
  created() {
  },
  methods: {
    wrap(value) {
      if (!value) return;
      return value.replace(/@/g, "<br/>");
    },
  },
  async mounted() {
    eolDetectionList({
      batteryNo: "09UPE22EQCUJA1B573100030",
    }).then((res) => {
      this.EoltestDateList=res.data
      console.log(this.EoltestDateList);
    });
    
  },
};
</script>

<style lang="scss" scoped>
.sub_page {
  width: 100%;
  height: 100%;
  padding: 0 20px;
  box-sizing: border-box;
  overflow: auto;
}
.header {
  width: 100%;
  height: 240px;
  background-color: #1e2132;
  margin-top: 10px;
}
.info_list {
  width: 100%;
  height: 100%;
  padding: 5px 10px;
  box-sizing: border-box;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  li {
    width: 24%;
    min-width: 100px;
    height: 100px;
    background-color: #272a3d;
    position: relative;
    overflow: hidden;
    p {
      color: #a8b4c1;
      font-size: 14px;
      margin-left: 20px;
      margin-top: 10px;
    }
    div {
      color: #fff;
      font-size: 20px;
      font-weight: 600;
      position: absolute;
      right: 15px;
      bottom: 10px;
    }
  }
}
.content {
  margin-top: 20px;
  padding: 20px;
  box-sizing: border-box;
  background-color: #1e2132;
}
.tab_title {
  display: flex;
  justify-content: space-between;
  height: 110px;
}
.tab_title_item {
  flex: 1;
  background-color: #262a3b;
  position: relative;
  p {
    color: #a8b4c1;
    font-size: 14px;
    margin-left: 20px;
    margin-top: 10px;
  }
  div {
    color: #fff;
    font-size: 20px;
    font-weight: 600;
    position: absolute;
    right: 15px;
    bottom: 10px;
  }
}
.tab_title_item:nth-child(2) {
  margin: 0 20px;
}
.tab_state,
.tab_title_item .state {
  color: #00b8aa;
}
.tab_box {
  width: 100%;
  display: flex;
  margin: 10px 0;
  color: #fff;
  text-align: center;
  align-items: center;
  & > li:nth-child(3) {
    text-align: left;
  }
}
.tab_box > li:nth-child(1) {
  flex: 1;
}
.tab_box > li:nth-child(2) {
  flex: 2;
}
.tab_box > li:nth-child(3) {
  flex: 2;
}
.tab_box > li:nth-child(4) {
  flex: 1;
}
.tab_box > li:nth-child(5) {
  flex: 1;
}
.tab_box > li:nth-child(6) {
  flex: 1;
}
.tab_box > li:nth-child(7) {
  flex: 1;
}
.active_bg:nth-child(2n-1) {
  background-color: #26273b;
}
.tab_item {
  padding: 15px 0;
  border-radius: 3px;
}
</style>