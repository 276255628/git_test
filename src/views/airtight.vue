<template>
    <div class="bg">
        <div class="contenr_box">
            <div class="content">
                <div class="content_left">
                    <div class="module_box tit_img_hg">
                        <div class="title">多功能气密性检测系统</div>
                        <div class="info_box">
                            <img src="../assets/image/airtight.png" class="info_img">
                        </div>
                    </div>
                </div>
                <div class="content_cen">
                    <div class="module_box cen_top_hg">
                        <div class="title">基本信息</div>
                        <div class="info_box">
                            <ul class="info_list">
                                <li>
                                    <p>电池包编号</p>
                                    <div>A1108</div>
                                </li>
                                <li>
                                    <p>车型</p>
                                    <div>EU300</div>
                                </li>
                                <li>
                                    <p>车辆品牌</p>
                                    <div>北汽</div>
                                </li>
                                <li>
                                    <p>测试类型</p>
                                    <div>低压(1-10 KPa)</div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="module_box cen_bottom_hg">
                        <div class="title">测试值</div>
                        <div class="info_box test_con">
                        <div class="test_info_box">
                            <div class="test_info"><i class="fa fa-square" aria-hidden="true"></i><span>当前压力值：</span><span class="test_info_text">{{pressure}} KPa</span></div>
                            <div class="test_info"><i class="fa fa-square" aria-hidden="true"></i><span>测试泄露值：</span><span class="test_info_text">{{divulge}} Pa</span></div>
                            <div class="test_info">
                                <i class="fa fa-square" aria-hidden="true"></i>
                                <span>状态：</span><span class="test_info_text">
                                    {{status}}
                                </span>
                            </div>
                        </div>
                        <div class="test_progress">
                            <el-progress type="circle" :percentage="progressBar" :stroke-width="10" :width="160" :show-text="false"></el-progress>
                            <div class="progress_text">
                                <p>{{progress}}</p>
                                <span v-show="progress!='等待中'&&progress!='PASS'">当前进度</span>
                            </div>
                        </div>
                        <div class="test_legend">
                            <!-- <img src="../assets/image/high_white.png" class="test_img"> -->
                            <div class="high"><img src="../assets/image/high_grey.png" class="test_img">高压检测</div>
                            <div class="low"><img src="../assets/image/low_white.png" class="test_img">低压检测</div>
                            <!-- <img src="../assets/image/low_grey.png" class="test_img"> -->
                        </div>
                        </div>
                    </div>
                </div>
                <div class="content_right">
                    <div class="module_box" style="height:100%;">
                        <div class="title">参数设置</div>
                        <div class="info_box">
                            <ul class="params_info_list">
                                <li>
                                    <p>充气时间</p>
                                    <div>600.0 s</div>
                                </li>
                                <li>
                                    <p>保压时间</p>
                                    <div>60.0 s</div>
                                </li>
                                <li>
                                    <p>检测时间</p>
                                    <div>60.0 s</div>
                                </li>
                                <li>
                                    <p>设定压力</p>
                                    <div>3 KPa</div>
                                </li>
                                <li>
                                    <p>保压上限</p>
                                    <div>4.55KPa</div>
                                </li>
                                <li>
                                    <p>保压下限</p>
                                    <div>1.9KPa</div>
                                </li>
                                <li>
                                    <p>泄露上限</p>
                                    <div>40 Pa</div>
                                </li>
                                <li>
                                    <p>泄露下限</p>
                                    <div>-30 Pa</div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
             <div class="module_box chart">
               <div class="title">气密性压力曲线图</div>
               <div class="info_box">
                 <div id="test_data_chart" style="width:100%;height:100%;"></div>
               </div>
            </div>
        </div>
        <!-- 进度条自定义渐变颜色 -->
       <svg width="100%" height="100%">
        <defs>
            <linearGradient id="purple" x1="100%" y1="0%" x2="0%" y2="100%">
            <stop offset="0%" style="stop-color: rgb(32, 34, 53)" stop-opacity="1"></stop>
            <stop offset="80%" style="stop-color: rgb(103, 67, 140)" stop-opacity="1"></stop>
            </linearGradient>
        </defs>
        </svg>
    </div>
</template>

<script>
import * as echarts from "echarts";
import CountTo from 'vue-count-to'
import {convertKey} from '@/api/fileParsing'
export default {
   components: {
    CountTo
   },
   data() {
    return {
        myChart:null,
        data:{},
        pressure:0,
        divulge:0,
        pressureList:[],
        divulgeList:[],
        progress:null,
        progressBar:0,
        status:'',
        times:0,
        timer:null
    }
   },
   methods:{
     testDataChart(myChart){
        let option;
        option = {
        grid:{
            top:45,
            left:80,
            right:160,
            bottom:30
        },
        legend:{
            icon:'circle',
            itemHeight:8,
            right:'right',
            orient: 'vertical',
            textStyle:{
                color:'#a8b4c1',
                fontFamily:'AlibabaPuHuiTi'
            }
        },
        xAxis: {
            type: 'category',
            boundaryGap: false,
            axisTick:{
                show:false // 不显示坐标轴刻度线
            },
            axisLabel: {
                show: false, // 不显示坐标轴上的文字
            },
        },
        yAxis:[
            {
                type: 'value',
                name:'当前压力值',
                splitLine:{
                    lineStyle:{
                        color:'#3a3f51',
                    }
                },
                axisLabel:{
                  formatter:'{value} Kpa',
                }
            },
            {
                type: 'value',
                name:'测试泄露值',
                // position: 'left',
                // offset: 70,
                axisLabel:{
                  formatter:'{value} pa',
                },
                splitLine:{
                lineStyle:{
                    color:'#3a3f51',
                },
                },
                axisLine: {
                    show: false,
                },
                 axisTick:{
                    show:false
                },
            },
        ],
        series: [
            {
                name:'当前压力值',
                type: 'line',
                data: this.pressureList,
                smooth: 0.6,
                symbolSize:10,
                symbol: 'none',
                lineStyle:{
                    color:'#a47ce5'
                },
                itemStyle : {
                    color:'#a47ce5'
                }
            },
            {
                name:'测试泄露值',
                type: 'line',
                yAxisIndex: 1,
                data: this.divulgeList,
                smooth: 0.6,
                symbolSize:10,
                symbol: 'none',
                lineStyle:{
                    color:'#6e88e5'
                },
                itemStyle : {
                    color:'#6e88e5'
                }
            }
        ]
        };

        option && myChart.setOption(option);
        window.addEventListener('resize',()=>{
            myChart.resize()
        })
     }
   },
  async mounted (){
    await this.axios.get('/xml/airtight.xml').then(response => {
        let xmlText = response.data;
        this.data = this.$x2js.xml2js(xmlText).data
        let keys=Object.keys(this.data);
        convertKey(keys,this.data);
        console.log(this.data);
    });
    this.myChart=echarts.init(document.getElementById('test_data_chart'));
    this.pressureList=[]
    this.divulgeList=[]
    this.testDataChart(this.myChart)
     let dataLength=this.data.item.length
    this.timer=setInterval(()=>{
    let {leak,now, progress,status}=this.data.item[this.times]
        this.pressureList.push(now)
        this.divulgeList.push(leak)
        this.progress=progress
        if(this.progress=="PASS"){
            this.progressBar=100
        }
        if(String( parseInt(progress))!='NaN'){
            this.progressBar=Number(progress)
        }
        this.pressure=now
        this.divulge=leak
        this.status=status
        this.testDataChart(this.myChart)
        this.times++
        if(this.times===dataLength){
            clearInterval(this.timer);
        }

    },1000)
   },
    beforeDestroy() {
        clearInterval(this.timer);
        this.timer = null;
    }
}
</script>

<style lang="scss" scoped>
.bg {
  width: 100%;
  height: 100%;
  background-color:#0f0f1e ;
  position: relative;
}
.contenr_box{
  position: absolute;
  top: 85px;
  width: 100%;
  height: calc(100% - 85px);
  padding: 0 60px;
  box-sizing: border-box;
}
.content {
  height: 60%;
  display: flex;
  & > div {
    height: 100%;
  }
}
.content_left{
   flex: 1;
}
.content_cen{
   flex: 1.5;
   margin: 0 40px;
}
.content_right{
   flex: 1.5;
}
.module_box {
  width: 100%;
  background-color: #1f2133;
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
  overflow: hidden;
}
.info_img{
    width: 80%;
    height: 80%;
    margin: 10% auto;
    display: block;
    object-fit: contain;
}
.tit_img_hg{
    height: 100%;
}
.cen_top_hg{
    height: 40%;
}
.cen_bottom_hg{
    height: calc(60% - 40px);
    margin-top: 40px;
}
.params_info_list,
.info_list{
    width: 100%;
    height: 100%;
    padding: 5px 10px;
    box-sizing: border-box;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    li{
        width: 49%;
        height: 44%;
        background-color: #272a3d;
        position: relative;
        p{
           color: #a8b4c1;
           font-size: 14px;
           margin-left: 20px;
           margin-top: 10px;
        }
        div{
            font-weight: 600;
            color: #fff;
            position: absolute;
            right: 10px;
            bottom: 5px;
        }
    }
}
.params_info_list li{
    height: 22%;
}
.test_con{
    display: flex;
    padding: 20px;
    box-sizing: border-box;
}
.test_info_box{
    width: 35%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
}
.test_info{
    width: 100%;
    color: #a8b4c1;
    font-size: 14px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    i{
        color: #68448e;
        margin-right: 5px;
    }
}
.test_info_text{
    color: #fff;
}
.test_progress{
    width: 45%;
    padding-left: 5%;
    display: flex;
    align-items: center;
    box-sizing: border-box;
    position: relative;
}
::v-deep .el-progress-circle {
   // 进度条颜色
   svg > path:nth-child(2) {
     stroke: url(#purple);
   }
 }
::v-deep .el-progress-circle__track {
    stroke: #2d3246;
    stroke-width: 2px !important;  // 大小
}
.progress_text{
    width: 160px;
    text-align: center;
    position: absolute;
    color: #fff;
    font-size: 20px;
    font-weight: 600;
    p{
        color: #fff;
        font-size: 30px;
    }
    span{
        font-size: 12px;
        color: #585f6f;
    }
}
.test_legend{
    width: 20%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
}
.high{
    height: 25%;
    display: flex;
    align-items: center;
    background-color: #343456;
    border-radius: 5px;
    color: #4f4f73;
}
.low{
    height: 25%;
    display: flex;
    align-items: center;
    border-radius: 5px;
    background-color: #4c3799;
    color: #fff;
}
.test_img{
    width: 15%;
    margin: 0 10px;
}
.chart{
    height: calc(40% - 20px);
    margin-top: 20px;
}
</style>
