<template>
  <div class="sub_page">
     <div class="head_portrait"><img src="../../assets/image/icon.png">检测人：{{data.detect_man}}</div>
     <div class="content_box">
        <div class="top_content_box">
           <div class="top_left_module">
             <ul class="info_list">
                <li>
                    <p>电池编号</p>
                    <div>{{data.battery_no}}</div>
                </li>
                <li>
                    <p>车型</p>
                    <div>{{data.car_model}}</div>
                </li>
                <li>
                    <p>VIN</p>
                    <div>{{data.vin}}</div>
                </li>
                <li>
                    <p>车辆品牌</p>
                    <div>{{data.car_brand}}</div>
                </li>
                <li>
                    <p>里程（Km）</p>
                    <div>{{data.total_mill}}</div>
                </li>
                <li>
                    <p>车牌号</p>
                    <div>{{data.license_plate}}A</div>
                </li>
                <li>
                    <p>车辆用途</p>
                    <div>{{data.car_type}}</div>
                </li>
                <li>
                    <p>车辆注册时间</p>
                    <div>{{data.register_time}}</div>
                </li>
                <li>
                    <p>故障时间</p>
                    <div>{{data.fault_time}}</div>
                </li>
                <li style="width:100%;">
                    <p>车辆用途</p>
                    <div>客户反馈续航里程短，续航不足100公里</div>
                </li>
                <li style="width:100%;">
                    <p>维修历史</p>
                    <div>{{data.repair_history=='null'?'无历史维修记录':data.repair_history}}</div>
                </li>
            </ul>
           </div>
           <div class="top_right_module">
              <ul class="monomer_list_title" style="font-size:16px;">
                    <li>名称</li>
                    <li>测试值</li>
                    <li>标准值</li>
                    <li>单位</li>
                    <li>结果</li>
              </ul>
                <div class="list_scroll">
                    <ul class="monomer_list_title active_bg" v-for="(v,i) in data.diagnosis_table.diagnosis_item" :key="'t'+i">
                        <li>{{v.name}}</li>
                        <li><div class="text">{{v.test_value}}</div><div class="state_img" :class="[v.test_value>v.standard_value?'rise':'decline']" v-if="v.result=='NO'"></div></li>
                        <li>{{v.standard_value}}</li>
                        <li>{{v.unit}}</li>
                        <li><i class="fa fa-circle dot" :style="{color:v.result=='YES'?'#00a89e':'#fd214a'}"></i>{{v.result}}</li>
                    </ul>
                </div>
           </div>
        </div>
        <div class="bottom_content_box">
           <div class="bottom_left_module">
               <div id="differential_pressure" style="width:100%;height:100%"></div>
           </div>
           <div class="bottom_right_module">
               <div class="card">
                   <div class="card_title">评估意见</div>
                   <div class="con_text_box">
                       <i class="fa fa-circle"></i>
                       <div>{{data.suggesstion}}</div>
                       <i class="fa fa-ellipsis-h "></i>
                   </div>
               </div>
               <div class="card">
                    <div class="card_title">维修方案</div>
                    <div class="con_text_box">
                       <i class="fa fa-circle"></i>
                       <div>{{data.repair_plan}}</div>
                       <i class="fa fa-ellipsis-h "></i>
                   </div>
               </div>
           </div>
        </div>
     </div>
  </div>
</template>

<script>
import *as echarts from 'echarts'
import {convertKey} from '../../api/fileParsing'
export default {
  data() {
    return {
        myChart:null,
        data:{
            diagnosis_table:{},
            single_volt_data:{},
        },
        fullVoltList:[],
        endVoltList:[],
        aisleList:[]
    }
  },
  methods:{
      differentialPressureChart(myChart){
        let option;
        option = {
        grid:{
            top:80,
            left:60,
            right:50,
            bottom:30
        },
        title:{
            text:'单体压差数据',
            textStyle:{
                color:'#a8b4c1',
                fontSize:'14',
                fontWeight: 500,
            },
            top:20,
            left:40
        },
        legend:{
            icon:'circle',
            itemHeight:8,
            top:20,
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
            data:this.aisleList,
            axisTick:{
                show:false // 不显示坐标轴刻度线
            },
        },
        yAxis: {
            type: 'value',
            max:4,
            splitLine:{
               lineStyle:{
                 color:'#3a3f51',
               }
            },
             axisLine: {
                show: true,    // 是否显示坐标轴轴线
            },
            axisTick: {
                show: true,    // 是否显示坐标轴刻度
            },
        },
        series: [
                {
            name:'满电电压',
            type: 'line',
            data: this.fullVoltList,
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
            name:'放电末端电压',
            type: 'line',
            data: this.endVoltList,
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
    this.myChart=echarts.init(document.getElementById('differential_pressure'));
    // 获取数据
    await  this.axios.get('/xml/report.xml').then(response => {
            let xmlText = response.data;
            this.data = this.$x2js.xml2js(xmlText).data
            let keys=Object.keys(this.data);
            convertKey(keys,this.data);
            console.log(this.data);
            this.data.single_volt_data.single_volt.forEach(item => {
                this.fullVoltList.push(item.full_volt)
                this.endVoltList.push(item.end_volt)
                this.aisleList.push(item.volt_no)
            });
        });
    this.differentialPressureChart(this.myChart)
    }
}
</script>

<style lang="scss" scoped>
.sub_page{
    width: 100%;
    height: 100%;
}
.head_portrait{
    display: flex;
    justify-content:flex-end;
    align-items: center;
    color: #a8b4c1;
    margin-right: 60px;
    img{
        margin: 0 8px;
    }
}
.content_box{
    height: calc(100% - 30px);
    margin: 0 60px;
    margin-top: 6px;
}
.top_content_box{
    height: 45%;
    display: flex;
    justify-content: space-between;
}
.top_left_module{
    width: 40%;
    height: 100%;
    background-color: #1d2031;
    overflow: hidden;
}
.info_list{
    width: 100%;
    height: 100%;
    padding: 5px 10px;
    box-sizing: border-box;
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    li{
        width: 32%;
        min-width: 100px;
        height: 17%;
        background-color: #272a3d;
        margin-top: 5px;
        position: relative;
        overflow: hidden;
        p{
           color: #a8b4c1;
           font-size: 14px;
           margin-left: 20px;
           margin-top: 10px;
        }
        div{
            font-weight: 600;
            color: #fff;
            font-size: 14px;
            position: absolute;
            right: 10px;
            bottom: 5px;
        }
    }
}
.top_right_module{
    width: 60%;
    height: 100%;
    margin-left: 20px;
    background-color: #1d2031;
    overflow: hidden;
    padding: 20px 30px;
    box-sizing: border-box;
}
.monomer_list_title{
    display: flex;
    width: 100%;
    height: 30px;
    line-height: 30px;
    color: #c4c5c9;
    margin: 10px 0;
    font-size: 14px;
    text-align: center;
    li{
        width: 20%;
        height: 100%;
        padding-left: 5px;
        box-sizing: border-box;
    }
}
.list_scroll{
    width: 100%;
    height: calc(100% - 62px);
    // overflow: auto;
}
.list-style{
    height: 100%;
}
.active_bg:nth-child(2n){
    background-color:#252739;
}
.dot{
    font-size: 12px;
    margin-right: 10px;
}
.text{
    display: inline-block;
    min-width: 45px;
}
.state_img{
    display: inline-block;
    width: 15px;
    height: 10px;
}
.rise{
    background-image: url('../../assets/image/rise.png');
}
.decline{
    background-image: url('../../assets/image/decline.png');
}
.bottom_content_box{
    width: 100%;
    height: calc(55% - 20px);
    margin-top: 20px;
    display: flex;
    justify-content: space-between;
    &>div{
        height: 100%;
        
    }
}
.bottom_left_module{
    width: 70%;
    background-color: #1d2031;
}
.bottom_right_module{
    width: calc(30% - 20px);
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
.card{
    width: 100%;
    height: 48%;
    background-color: #1d2031;
    padding: 20px;
    box-sizing: border-box;
}
.card_title{
    color: #a8b4c1;
    font-size: 14px;
}
.con_text_box{
    display: flex;
    margin-top: 10px;
    &>i:nth-child(1){
        color: #68448e;
        font-size: 14px;
        margin: 5px 20px 10px 0;
    }
    div{
        font-size: 14px;
        color: #989fab;
    }
     &>i:nth-child(3){
        color: #c8d0db;
        font-size: 14px;
        margin-left: 20px;
    }
}
</style>