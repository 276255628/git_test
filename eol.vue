<template>
  <div class="bg">
    <div class="content">
      <!-- 左部分 -->
      <div class="content_left">
        <div class="module_box left_top_hg" style="background-color: #2e3347">
          <div class="title">动力电池EOL检测系统</div>
          <div class="info_box">
            <img src="../assets/image/equipment.png" class="info_img" />
          </div>
        </div>
        <div class="module_box contnent_left_bottom">
          <p class="sub_title">基本信息</p>
          <ul class="basic_info_list">
            <li>
              <div class="basic_info_item">
                <i class="fa fa-square" aria-hidden="true"></i
                ><span>电池包编号：{{ eolBaseInfoList.batteryNo }}</span>
              </div>
              <div class="basic_info_item">
                <i class="fa fa-square" aria-hidden="true"></i
                ><span>车辆品牌：{{ eolBaseInfoList.carBrand }}</span>
              </div>
            </li>
            <li>
              <div class="basic_info_item">
                <i class="fa fa-square" aria-hidden="true"></i
                ><span>车辆类型：{{ eolBaseInfoList.carType }}</span>
              </div>
              <div class="basic_info_item">
                <i class="fa fa-square" aria-hidden="true"></i
                ><span>车型：{{ eolBaseInfoList.carModel }}</span>
              </div>
            </li>
            <li>
              <div class="basic_info_item">
                <i class="fa fa-square" aria-hidden="true"></i
                ><span>里程：{{ eolBaseInfoList.carMileage }}</span>
              </div>
              <div class="basic_info_item">
                <i class="fa fa-square" aria-hidden="true"></i
                ><span>车辆用途：{{ eolBaseInfoList.carUsed }}</span>
              </div>
            </li>
            <li>
              <div class="basic_info_item">
                <i class="fa fa-square" aria-hidden="true"></i
                ><span>故障现象：{{ eolBaseInfoList.faultAppear }}</span>
              </div>
              <div class="basic_info_item">
                <i class="fa fa-square" aria-hidden="true"></i
                ><span>维修次数：{{ eolBaseInfoList.repairNum }}</span>
              </div>
            </li>
          </ul>
        </div>
      </div>
      <!-- 右盒子 分为上下两个盒子 -->
      <div class="content_right_box">
        <!-- 上盒子 -->
        <div class="content_cen">
          <div class="module_box contnent_cen_top">
            <div class="title">单体检测信息</div>
            <div class="info_box params_list_box">
              <!-- <p class="sub_title">单体信息</p> -->
              <ul class="params_list">
                <li
                  class="params_item"
                  v-for="(v, i) in singleList"
                  :key="'t' + i"
                >
                  <div class="params_item_title">{{ v.singleName }}</div>
                  <div class="params_item_small">电压:{{ v.singleVolt }}</div>
                  <div class="params_item_small">温度:{{ v.singleTemp }}</div>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <!-- 下盒子 -->
        <div class="content_right">
          <div class="module_box chart_box">
            <p class="sub_title">单体温度</p>
            <div class="chart" id="temperature"></div>
          </div>
          <div class="module_box chart_box">
            <p class="sub_title">单体电压</p>
            <div class="chart" id="voltage"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as echarts from "echarts";
import { eolList, eolBaseInfo } from "@/api/eolList";
export default {
  data() {
    return {
      voltChart: null,
      tempChart: null,
      data: {
        base_info: {},
        param_info: {},
        single_info: {},
      },
      singleList: [],
      tempList: [],
      voltList: [],
      eolBaseInfoList: [], //动力电池EOL检测系统-基本信息列表
    };
  },
  methods: {
    temperatureChart(myChart) {
      let option;
      option = {
        grid: {
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
        },
        xAxis: {
          type: "category",
          boundaryGap: false,
        },
        yAxis: {
          type: "value",
          show: false,
          min: function (value) {
            return value.min;
          },
        },
        series: [
          {
            data: this.tempList,
            type: "line",
            smooth: 0.6,
            itemStyle: {
              color: "#533576",
            },
            lineStyle: {
              color: "#533576",
            },
            areaStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                {
                  offset: 0,
                  color: "#4d3270",
                },
                {
                  offset: 1,
                  color: "#27223e",
                },
              ]),
            },
          },
        ],
      };
      option && myChart.setOption(option);
      window.addEventListener("resize", () => {
        myChart.resize();
      });
    },
    voltageChart(myChart) {
      let option;
      option = {
        grid: {
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
        },
        xAxis: {
          type: "category",
          boundaryGap: false,
        },
        yAxis: {
          min: function (value) {
            return value.min;
          },
          type: "value",
          show: false,
        },
        series: [
          {
            data: this.voltList,
            type: "line",
            smooth: 0.6,
            itemStyle: {
              color: "#68448e",
            },
            lineStyle: {
              color: "#3d2e81",
            },
            areaStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                {
                  offset: 0,
                  color: "#1e2345",
                },
                {
                  offset: 1,
                  color: "#26233f",
                },
              ]),
            },
          },
        ],
      };
      option && myChart.setOption(option);
      window.addEventListener("resize", () => {
        myChart.resize();
      });
    },
  },
  async mounted() {
    //EOL单体信息查询
    await eolList().then((res) => {
      this.singleList = res.data;
      let { data } = res;
      data.forEach((item) => {
        this.tempList.push(item.singleTemp);
        this.voltList.push(item.singleVolt);
      });
    });
    // EOL单体基本信息
    eolBaseInfo({
      batteryNo:
      "A1108",
    }).then((res) => {
      this.eolBaseInfoList = res.data;
    });
    this.tempChart = echarts.init(document.getElementById("temperature"));
    this.temperatureChart(this.tempChart);
    this.voltChart = echarts.init(document.getElementById("voltage"));
    this.voltageChart(this.voltChart);
  },
};
</script>

<style lang="scss" scoped>
.bg {
  width: 100%;
  height: 100%;
  background-color: #0f0f1e;
  position: relative;
}
.content {
  position: absolute;
  top: 85px;
  width: 100%;
  height: calc(100% - 85px);
  display: flex;
  & > div {
    height: 100%;
  }
}
.content_left {
  width: 400px;
  margin: 0 60px;
}

.content_right_box {
  display: flex;
  flex: 1;
  flex-direction: column;
  align-content: space-between;
}
.content_cen {
  height: 540px;
}
.content_right {
  display: flex;
  justify-content: space-between;
  flex: 1;
}
.module_box {
  width: 100%;
  background-color: #1f2133;
  margin-left: 10px;
}
.title {
  width: 100%;
  height: 50px;
  background-color: #282155;
  color: #fff;
  font-size: 24px;
  line-height: 50px;
  padding-left: 20px;
  box-sizing: border-box;
}
.info_box {
  width: 100%;
  height: calc(100% - 50px);
}
.left_top_hg {
  height: 65%;
}
.info_img {
  width: 80%;
  height: 90%;
  margin: 5% auto;
  display: block;
  object-fit: contain;
}
.contnent_left_bottom {
  height: calc(35% - 20px);
  margin-top: 20px;
  padding: 10px 0 10px 30px;
  box-sizing: border-box;
}
.sub_title {
  height: 22px;
  color: #a8b4c1;
}
.basic_info_list {
  height: calc(100% - 22px);
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  li {
    width: 100%;
    display: flex;
  }
}
.basic_info_item {
  width: 50%;
  color: #fff;
  font-size: 12px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  i {
    color: #68448e;
    margin-right: 5px;
  }
}
.contnent_cen_top {
  height: 100%;
}
.params_list_box {
  padding: 10px 30px 30px 30px;
  position: relative;

}
.params_list {
  width: calc(100% - 60px);
  height: calc(100% - 42px);
  display: flex;
  flex-wrap: wrap;
  align-content: start;
  overflow: auto;
  position: absolute;
  left: 0;
  top: 0;
  // animation: 10s move infinite linear ;
}

@keyframes move {
  0% {
    top:0px;
  }
  100% {
    top:-450px
  }
}



.params_item {
  width: 24%;
  min-width: 160px;
  height: 100px;
  font-size: 16px;
  background-color: #252739;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  margin-top: 10px;
  margin-left: 1%;
  padding: 10px 20px;
  box-sizing: border-box;
  border-radius: 5px;
  text-align: center;
}

// .params_item_title {
//   color: #fff
// }
.params_item_small {
  display: flex;
  flex-direction: column;
  color: rgb(13, 119, 119)
}

.params_item > div:nth-child(1) {
  // color: #4b5164;
  color: #a8b4c1;

}
.params_item > div:nth-child(2) {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 12px;
}
.params_item > div:nth-child(3) {
  font-size: 12px;
}

.state_img {
  width: 15px;
  height: 10px;
}
.rise {
  background-image: url("../assets/image/rise.png");
}
.decline {
  background-image: url("../assets/image/decline.png");
}
.list_scroll {
  width: 100%;
  height: calc(100% - 62px);
}
.list-style {
  height: 100%;
}
.active_bg:nth-child(2n) {
  background-color: #252739;
}
.content_right_hg {
  height: 50%;
}
.monomer_chart {
  padding: 10px 30px;
  box-sizing: border-box;
}
.monomer_list_title {
  display: flex;
  width: 100%;
  height: 30px;
  line-height: 30px;
  color: #c4c5c9;
  margin: 5px 0;
  font-size: 14px;
  li {
    width: 33%;
    height: 100%;
    text-align: center;
  }
}
.chart_box {
  height: calc(100% - 20px);
  margin-top: 20px;
  padding: 20px 20px 0 20px;
  box-sizing: border-box;
}
.chart {
  height: calc(100% - 32px);
}
</style>
