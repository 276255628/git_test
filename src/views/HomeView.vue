<template>
  <div class="home bg">
    <NavTitleBar />
    <div class="content">
      <div class="content_left">
        <div class="module_box left_top_hg" style="background-color: #2e3347">
          <div class="title">在修电池信息</div>
          <div class="info_box">
            <ul class="battery-info_list">
              <li
                v-for="(v, i) in batteryInfoList"
                :key="v.batteryNo"
                :class="{ 'battery-info_list_active': i == active }"
              >
                <i class="fa fa-square" aria-hidden="true"></i
                ><span>{{ v.batteryNo }}</span
                ><span>{{ v.batteryBrand }}</span
                ><span>{{ v.faultAppear }}</span>
              </li>
            </ul>
          </div>
        </div>
      <!-- 电池详细信息 -->
        <div class="left_bottom_box" ref="banner">
          <el-carousel
            :height="bannerHeight + 'px'"
            arrow="never"
            ref="carousel"
            @mouseenter.native="delHandleMouseEnter"
          >
            <el-carousel-item v-for="(val, index) in base_info" :key="index">
              <div class="module_box left_cen_hg" style="overflow: hidden">
                <div class="title">电池详细信息</div>
                <div class="info_box">
                  <p class="serial_number_name">电池编号</p>
                  <div class="serial_number_info">{{ val.battery_no }}</div>
                </div>
              </div>
              <ul class="vehicle-info_list">
                <li class="vehicle-info_row">
                  <div class="vehicle-info_item">
                    <p class="vehicle-info_item_name">车辆品牌</p>
                    <div class="vehicle-info_item_info">
                      {{ val.car_brand }}
                    </div>
                  </div>
                  <div class="vehicle-info_item">
                    <p class="vehicle-info_item_name">车型</p>
                    <div class="vehicle-info_item_info">{{ val.car_type }}</div>
                  </div>
                </li>
                <li class="vehicle-info_row">
                  <div class="vehicle-info_item">
                    <p class="vehicle-info_item_name">车辆类型</p>
                    <div class="vehicle-info_item_info">
                      {{ val.car_model }}
                    </div>
                  </div>
                  <div class="vehicle-info_item">
                    <p class="vehicle-info_item_name">里程</p>
                    <div class="vehicle-info_item_info">{{ val.car_mill }}</div>
                  </div>
                </li>
                <li class="vehicle-info_row">
                  <div class="vehicle-info_item">
                    <p class="vehicle-info_item_name">车辆用途</p>
                    <div class="vehicle-info_item_info">{{ val.car_use }}</div>
                  </div>
                  <div class="vehicle-info_item">
                    <p class="vehicle-info_item_name">维修次数</p>
                    <div class="vehicle-info_item_info">
                      {{ val.repair_num }}
                    </div>
                  </div>
                </li>
                <li class="vehicle-info_row">
                  <div class="vehicle-info_item">
                    <p class="vehicle-info_item_name">已完成检测项目</p>
                    <div class="project_box">
                      <div
                        class="project_item"
                        v-for="(v, i) in val.finish_project.project"
                        :key="i"
                      >
                        <span>{{ v.project_name }}</span>
                        <span>
                          <i
                            class="fa fa-circle-o"
                            :style="{
                              color:
                                v.project_result == '通过'
                                  ? '#4ec55b'
                                  : v.project_result == '未通过'
                                  ? '#90273a'
                                  : '#2f3979',
                            }"
                          ></i>
                          {{ v.project_result }}
                        </span>
                      </div>
                    </div>
                  </div>
                  <div class="vehicle-info_item">
                    <p class="vehicle-info_item_name">检测中数据</p>
                    <div class="project_box">
                      <div class="legend">
                        <div class="border_rig">
                          <span>{{
                            val.check_data.check[0] &&
                            val.check_data.check[0].check_name
                          }}</span>
                          <p>
                            {{
                              val.check_data.check[0] &&
                              val.check_data.check[0].check_result
                            }}
                          </p>
                        </div>
                        <div>
                          <span>{{
                            val.check_data.check[1] &&
                            val.check_data.check[1].check_name
                          }}</span>
                          <p>
                            {{
                              val.check_data.check[1] &&
                              val.check_data.check[1].check_result
                            }}
                          </p>
                        </div>
                      </div>
                      <hr style="margin: 0 1.25rem" />
                      <div class="legend">
                        <div class="border_rig">
                          <span>{{
                            val.check_data.check[2] &&
                            val.check_data.check[2].check_name
                          }}</span>
                          <p>
                            {{
                              val.check_data.check[2] &&
                              val.check_data.check[2].check_result
                            }}
                          </p>
                        </div>
                        <div>
                          <span>{{
                            val.check_data.check[3] &&
                            val.check_data.check[3].check_name
                          }}</span>
                          <p>
                            {{
                              val.check_data.check[3] &&
                              val.check_data.check[3].check_result
                            }}
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                </li>
              </ul>
            </el-carousel-item>
          </el-carousel>
        </div>
      </div>
      <!-- 中间盒子-所有检测系统的布局结构 -->
      <div class="content_cen">
        <ul class="module_list_box">
          <li
            @click="toPage(val.systemStatus, index)"
            v-for="(val, index) in HomeViewInfoList"
            :key="index"
          >
            <img
              class="tip_img"
              src="../assets/image/Bubble .png"
              v-show="val.systemStatus === '0' && showActive == index"
            />
            <!-- 根据后端加载对应名称的图片 -->
            <div class="module_item_img"  :style="{'background-image':`url(${require('@/assets/image/' + val.systemImage.replace(/system/g,'module').substring(0,10)+(index+1) + '.png')})`}"></div>
            <div class="module_item_content">
              <div class="module_name">
                <span>{{ val.systemName }}</span>
              </div>
              <div class="module_state">
                <div>
                  <i
                    class="fa fa-circle-o"
                    :style="{
                      color: val.systemStatus == '1' ? '#47a757' : '#4b5164',
                    }"
                  ></i>
                  <span
                    :style="{
                      color: val.systemStatus == '1' ? '#fff' : '#4b5164',
                    }"
                  >
                    使用</span
                  >
                </div>
                <div>
                  <i
                    class="fa fa-circle-o"
                    :style="{
                      color: val.systemStatus == '0' ? '#47a757' : '#4b5164',
                    }"
                  ></i>
                  <span
                    :style="{
                      color: val.systemStatus == '0' ? '#fff' : '#4b5164',
                    }"
                    >空闲</span
                  >
                </div>
              </div>
            </div>
          </li>
        </ul>
      </div>
      <div class="content_right">
        <div class="module_box top_hg">
          <div class="title">电池车间信息</div>
          <div class="info_box" style="display: flex">
            <div id="battery_workshop" style="width: 50%; height: 100%"></div>
            <div id="passing_rate" style="width: 50%; height: 100%"></div>
          </div>
        </div>
        <div class="module_box right_cen_hg">
          <div class="title">设备监控信息</div>
          <div class="info_box">
            <p
              class="serial_number_name"
              style="font-size: 1rem; margin: 1.25rem 1.875rem"
            >
              {{ equip.equip_name }}
            </p>
            <div class="sys_monitoring_box">
              <div class="sys_monitoring_left">
                <div class="sys_monitoring_info">
                  <div class="sys_monitoring_info_name">
                    <i class="fa fa-square" aria-hidden="true"></i
                    ><span>设备温度：</span><span>{{ equip.equip_temp }}℃</span>
                  </div>
                </div>
                <div class="sys_monitoring_info">
                  <div class="sys_monitoring_info_name">
                    <i class="fa fa-square" aria-hidden="true"></i
                    ><span>运行时间：</span><span>{{ equip.run_time }}S</span>
                  </div>
                </div>
                <div class="sys_monitoring_info">
                  <div class="sys_monitoring_info_name">
                    <i class="fa fa-square" aria-hidden="true"></i
                    ><span>告警时间：</span><span>{{ equip.equip_warn }}S</span>
                  </div>
                </div>
              </div>
              <img
                v-show="equip.equip_type == '气密'"
                src="../assets/image/module_img1.png"
                class="sys_monitoring_img"
              />
              <img
                v-show="equip.equip_type == '安规'"
                src="../assets/image/module_img2.png"
                class="sys_monitoring_img"
              />
              <img
                v-show="equip.equip_type == 'EOL'"
                src="../assets/image/module_img3.png"
                class="sys_monitoring_img"
              />
              <img
                v-show="equip.equip_type == 'PACK充放电'"
                src="../assets/image/module_img4.png"
                class="sys_monitoring_img"
              />
              <img
                v-show="equip.equip_type == '均衡仪'"
                src="../assets/image/module_img5.png"
                class="sys_monitoring_img"
              />
              <img
                v-show="equip.equip_type == '模组充放电'"
                src="../assets/image/module_img6.png"
                class="sys_monitoring_img"
              />
              <imgomeViewInfoList
                v-show="equip.equip_type == '模组安规'"
                src="../assets/image/module_img7.png"
                class="sys_monitoring_img"
              />
              <img
                v-show="equip.equip_type == '模组EOL'"
                src="../assets/image/module_img8.png"
                class="sys_monitoring_img"
              />
            </div>
          </div>
        </div>
        <div class="module_box right_bottom_hg">
          <div class="title">维修数据统计</div>
          <div class="info_box">
            <div id="maintain" style="width: 100%; height: 100%"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { convertKey } from "@/api/fileParsing";
import * as echarts from "echarts";
import dayjs from "dayjs";
import NavTitleBar from "../components/navTitleBar.vue";
// 获取首页-中间布局-设备信息列表
import { HomeViewList, DeviceList, RepairList } from "@/api/HomeViewList";
// 获取电池包信息
import { eolBaseInfo } from "@/api/eolList";

export default {
  name: "HomeView",
  components: {
    NavTitleBar,
  },
  created() {},
  data() {
    return {
      timer: null,
      timers: null,
      temp: 0,
      equip: {
        equip_name: null,
        equip_temp: null,
        equip_warn: null,
        run_time: null,
      },
      activeNum: 0,
      batteryInfoList: [],
      bannerHeight: null,
      active: 0,
      detection: {
        battery_no: "",
        car_brand: "",
        car_type: "",
        car_model: "",
        car_mill: "",
        car_use: "",
        repair_num: "",
        finish_project: {
          project: [],
        },
      },
      base_info: [],
      systems: [],
      showActive: null,
      showTimer: null,
      HomeViewInfoList: [], //基本信息列表,
      EolDeviceList: [], //电池车间基本信息
      eolDetailInfo: {}, //电池详细信息
    };
  },
  methods: {
    // 电池车间信息
    batteryWorkshopChart() {
      let chartDom = document.getElementById("battery_workshop");
      let myChart = echarts.init(chartDom);
      let option;
      let data = [];
      this.data.right_top.types.type.forEach((item) => {
        data.push({ name: item.type_name, value: item.type_num });
      });
      option = {
        tooltip: {
          backgroundColor: "#1f2133", // 修改背景颜色
          borderColor: "#3a347d",
          textStyle: {
            color: "#fff",
          },
        },
        series: [
          {
            type: "pie",
            radius: "75%",
            center: ["50%", "50%"],
            data: data,
            label: {
              show: false,
            },
            itemStyle: {
              color: function (colors) {
                let colorList = [
                  "#4e0a8a",
                  "#8e85eb",
                  "#3d31b7",
                  "#190a71",
                  "#41428c",
                  "#d7bfef",
                  "#bb8ce7",
                  "#8c43d6",
                  "#682abb",
                ];
                return colorList[colors.dataIndex];
              },
            },
          },
        ],
      };
      option && myChart.setOption(option);
      window.addEventListener("resize", () => {
        myChart.resize();
      });
      let index = 0; //播放所在下标
      let mTime = setInterval(function () {
        myChart.dispatchAction({
          type: "showTip",
          seriesIndex: 0,
          dataIndex: index,
        });
        index++;
        if (index > data.length) {
          index = 0;
        }
      }, 1000);
    },
    passingRateChart() {
      let chartDom = document.getElementById("passing_rate");
      let myChart = echarts.init(chartDom);
      let option;
      let data = [];
      this.data.right_top.types.type;
      data = [
        { name: "通过率", value: this.data.right_top.pass_rate },
        { name: "未通过", value: 100 - this.data.right_top.pass_rate },
      ];
      option = {
        title: {
          zlevel: 0,
          text: [
            `{value| ${this.data.right_top.pass_rate}% }`,
            `{name|通过率}`,
          ].join("\n"),
          top: "center",
          left: "48%",
          textAlign: "center",
          textStyle: {
            rich: {
              name: {
                color: "#636571",
                lineHeight: 20,
              },
              value: {
                color: "#fff",
                fontSize: 18,
                fontWeight: "bold",
              },
            },
          },
        },
        // tooltip: {},
        series: [
          {
            type: "pie",
            radius: ["75%", "70%"],
            center: ["50%", "50%"],
            data: data,
            label: {
              show: false,
            },
            itemStyle: {
              color: function (colors) {
                let colorList = ["#68448e", "#5470c6", "#353072"];
                return colorList[colors.dataIndex];
              },
            },
          },
        ],
      };
      option && myChart.setOption(option);
      window.addEventListener("resize", () => {
        myChart.resize();
      });
    },
    // 柱状统计图
    maintainChart() {
      let chartDom = document.getElementById("maintain");
      let myChart = echarts.init(chartDom);
      let option;
      let times = [];
      let data = [];
      let length = this.data.right_bottom.repair.length - 1;
      this.data.right_bottom.repair.forEach((item, index) => {
        times.push(
          dayjs()
            .subtract(length - index, "day")
            .format("MM-DD")
        );
        data.push(item.repair_nums);
      });

      option = {
        grid: {
          top: 30,
          right: 10,
          bottom: 30,
        },
        tooltip: {},
        xAxis: {
          type: "category",
          data: times,
        },
        yAxis: {
          type: "value",
          splitLine: {
            lineStyle: {
              type: "dashed", //虚线
              color: "#2b2b45",
            },
          },
          axisLine: {
            show: true,
          },
          axisTick: {
            show: true,
          },
        },
        series: [
          {
            data: data,
            type: "bar",
            barWidth: 8,
            itemStyle: {
              color: "#68448e",
              borderRadius: [10, 10, 10, 10],
            },
          },
        ],
      };

      option && myChart.setOption(option);
      window.addEventListener("resize", () => {
        myChart.resize();
      });
    },
    // 当前展示电池详细信息
    initialize() {
      let arr = [];
      //  debugger
      this.batteryInfoList.forEach((item) => {
        this.base_info.forEach((val) => {
          if (item.battery_no == val.battery_no) {
            arr.push(val);
          }
        });
      });
      this.base_info = arr;
    },
    // 关闭鼠标进入停止播放
    delHandleMouseEnter() {
      this.$refs.carousel.handleMouseEnter = () => {};
    },
    // 左边数据变化
    leftChange() {
      this.timer = setInterval(() => {
        this.active++;
        if (this.batteryInfoList.length == this.active) {
          this.active = 0;
        }
      }, 3000);
    },

    // 设备监控信息
    equipmentMonitoringChange() {
      this.timers = setInterval(() => {
        this.activeNum++;
        if (this.activeNum == this.data.right_middle.equip.length) {
          this.activeNum = 0;
        }
        this.equip = this.data.right_middle.equip[this.activeNum];
      }, 2000);
    },
    toPage(state, index) {
      let paths = [
        "/airtight/index",
        "/",
        "/eol/index",
        "/",
        "/balance/index",
        "/",
        "/",
        "/",
        "/quality-testing/menu-list/report",
      ];
      if (state === "0") {
        this.showActive = index;
        clearTimeout(this.showTimer);
        this.showTimer = setTimeout(() => {
          this.showActive = null;
          clearTimeout(this.showTimer);
        }, 2000);
        return;
      }
      this.$router.push(paths[index]);
    },
  },
  async mounted() {
    //首页-中间信息部分-轮询查询
    // 页面一打开初始请求一次
    HomeViewList().then((res) => {
      this.HomeViewInfoList = res.data;
    });
    // 每隔一秒请求最新数据
    setTimeout(() => {
      HomeViewList().then((res) => {
        this.HomeViewInfoList = res.data;
      });
    }, 1000);

    //  在修电池信息
    RepairList().then((res) => {
      this.batteryInfoList = res.data;
    });

    // 电池详细信息
    eolBaseInfo({
      batteryNo: "A1108",
    }).then((res) => {
      console.log(res.data);
    });

    //  电池车间信息
    //   DeviceList().then((res)=>{
    //     this.EolDeviceList=res.data
    //     console.log(this.EolDeviceList);
    //   })

    this.bannerHeight = this.$refs.banner.offsetHeight;
    this.$refs.carousel.handleMouseEnter = () => {};
    // 获取数据
    await this.axios.get("/xml/home.xml").then((response) => {
      let xmlText = response.data;
      let KeyData = this.$x2js.xml2js(xmlText).data;
      let keys = Object.keys(KeyData);
      // 处理数据
      convertKey(keys, KeyData);
      let { home, systems } = KeyData;
      this.data = home;
      this.systems = systems.system;
      this.batteryInfoList = this.data.left_top.battery;
      this.base_info = this.data.left_bottom.base_info;
      // 处理设备监控数据格式
      this.data.right_middle.equip.forEach((item) => {
        item.equip_temp = Number(item.equip_temp);
        item.equip_warn = Number(item.equip_warn);
        item.run_time = Number(item.run_time);
      });
      // console.log(this.data);
    });
    this.batteryWorkshopChart();
    this.maintainChart();
    this.passingRateChart();
    this.initialize();
    this.leftChange();
    this.equip = this.data.right_middle.equip[0];
    this.equipmentMonitoringChange();
    // 跑马灯的高度
    window.addEventListener("resize", () => {
      this.$nextTick(() => {
        if (this.$refs.banner) {
          this.bannerHeight = this.$refs.banner.offsetHeight;
        }
      });
    });
  },
  beforeDestroy() {
    clearInterval(this.timer);
    clearInterval(this.timers);
    this.timer = null;
    this.timers = null;
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
  top: 4.6875rem;
  width: 100%;
  height: calc(100% - 6.875rem);
  display: flex;
  margin-top: 0.625rem;
  & > div {
    height: 100%;
  }
}
.content_left {
  flex: 1;
  margin: 0 3.75rem;
}
.content_cen {
  flex: 2;
}
.content_right {
  flex: 1;
  margin: 0 3.75rem;
}
.module_box {
  width: 100%;
  background-color: #1f2133;
  position: relative;
}
.left_top_hg {
  height: 28%;
}
.top_hg {
  height: 32%;
}
.info_box {
  position: absolute;
  width: 100%;
  height: calc(100% - 3.125rem);
}
.battery-info_list {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
  color: #a8b4c1;
  padding-top: 1.25rem;
  box-sizing: border-box;
  overflow: hidden;
  overflow: auto;
}
.battery-info_list > li {
  height: 30%;
  min-height: 3.125rem;
  font-size: 0.875rem;
  overflow: hidden;
  white-space: nowrap;
  display: flex;
  align-items: center;
  & > span {
    margin-left: 0.625rem;
  }
  & > i {
    color: #68448e;
    margin-left: 0.625rem;
  }
}
.battery-info_list_active {
  background-color: #3f385c;
  color: #fff;
}
.left_bottom_box {
  width: 100%;
  height: 72%;
}
::v-deep.left_bottom_box .el-carousel__indicators {
  display: none;
}
.con_item {
  width: 100%;
  height: 100%;
}
.left_cen_hg {
  margin-top: 1.25rem;
  height: 25%;
}
.serial_number_name {
  color: #a8b4c1;
  font-size: 0.875rem;
  margin: 0.9375rem 1.25rem;
}
.serial_number_info {
  color: #fff;
  font-size: 2.25rem;
  font-weight: 600;
  margin-right: 0.625rem;
  position: absolute;
  right: 0;
  bottom: 0.625rem;
}
.vehicle-info_list {
  height: calc(75% - 1.5625rem);
  margin-top: 0.3125rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  overflow: hidden;
}
.vehicle-info_row {
  height: 20%;
  display: flex;
  justify-content: space-between;
  margin-top: 0.625rem;
}
.vehicle-info_row:nth-child(4) {
  height: 40%;
}
.vehicle-info_item {
  width: 49%;
  height: 100%;
  background-color: #1f2133;
  position: relative;
}
.vehicle-info_item_name {
  color: #a8b4c1;
  font-size: 0.875rem;
  margin: 0.625rem 0 0.3125rem 1.25rem;
}
.vehicle-info_item_info {
  color: #fff;
  font-size: 1.125rem;
  font-weight: 550;
  margin-right: 0.625rem;
  position: absolute;
  right: 0;
  bottom: 0.625rem;
}
.project_box {
  height: calc(100% - 1.875rem);
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  color: #fff;
  font-size: 0.75rem;
  & > div {
    height: 38%;
  }
}
.project_item {
  margin-left: 1.25rem;
}
.project_item > span:nth-child(1) {
  width: 5rem;
  display: inline-block;
}
.project_item > span:nth-child(2) > i {
  margin-right: 0.625rem;
}
.legend {
  display: flex;
  justify-content: space-between;
  font-size: 0.75rem;
  margin: 0 1.25rem;
  & > div {
    flex: 1;
    text-align: center;
  }
  span {
    font-size: 0.75rem;
    color: #a8b4c1;
  }
  p {
    font-size: 0.875rem;
    color: #fff;
    margin-top: 0.3125rem;
  }
}
.border_rig {
  border-right: 0.0625rem solid #fff;
}
.module_list_box {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  align-items: center;
}
.module_list_box > li {
  width: 30%;
  height: 32%;
  display: flex;
  flex-direction: column;
  cursor: pointer;
  position: relative;
}
.module_item_img {
  width: 70%;
  flex: 1;
  margin: 0 auto;
  background-size: 100% 100%;
}
.systemImage_img {
  width: 90%;
}
.tip_img {
  width: 80%;
  position: absolute;
  top: 10%;
  left: 10%;
}
.module_item_content {
  width: 100%;
  height: 5.3125rem;
  background-color: #1f2133;
  padding: 0.9375rem;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}
.module_name {
  display: flex;
  justify-content: center;
  font-size: 1rem;
  font-weight: 600;
  color: #fff;
}
.module_state {
  width: 70%;
  margin: 0 auto;
  display: flex;
  justify-content: space-around;
  color: #fff;
  font-size: 0.875rem;
  i {
    margin: 0 0.3125rem;
  }
}
.right_cen_hg {
  height: calc(30% - 1.25rem);
  margin-top: 1.25rem;
}
.right_bottom_hg {
  height: calc(40% - 2.5rem);
  margin-top: 1.25rem;
}
.sys_monitoring_box {
  width: 90%;
  height: calc(100% - 4.6875rem);
  margin: 0 auto;
  background-color: #262a3d;
  position: relative;
}
.sys_monitoring_left {
  width: 50%;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
}
.sys_monitoring_info {
  display: flex;
  align-items: center;
}
.sys_monitoring_info_name {
  padding-left: 1.25rem;
  font-size: 0.875rem;
  & > i {
    color: #68448e;
    font-size: 0.625rem;
    margin-right: 0.3125rem;
  }
  & > span:nth-child(2) {
    color: #a8b4c1;
  }
  & > span:nth-child(3) {
    color: #fff;
  }
}
.sys_monitoring_img {
  position: absolute;
  right: 0;
  bottom: -1.25rem;
  width: 50%;
}
</style>
