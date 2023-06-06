<template>
  <div class="bg">
    <div class="content">
        <div class="content-left">
           <div class="content-left_box">
                <div class="module_box left_sub_top_hg">
                    <div class="title">便携式模组并充维护仪</div>
                    <div class="info_box">
                        <img src="../assets/image/instrument.png" class="info_img">
                    </div>
                </div>
               <div class="con_box">
                    <div class="module_box basic_info">
                        <div class="title">基本信息</div>
                        <div class="info_box">
                           <ul class="info_list">
                               <li>
                                    <p>电池包编号</p>
                                    <div>{{data.base_info.battery_no}}</div>
                               </li>
                               <li>
                                    <p>车型</p>
                                    <div>{{data.base_info.car_model}}</div>
                               </li>
                               <li>
                                    <p>均衡电压</p>
                                    <div>3.650v</div>
                               </li>
                               <li>
                                    <p>车辆品牌</p>
                                    <div>{{data.base_info.car_brand}}</div>
                               </li>
                               <li>
                                    <p>里程（Km）</p>
                                    <div>{{data.base_info.car_mill}}</div>
                               </li>
                               <li>
                                    <p>均衡电流</p>
                                    <div>{{data.base_info.balance_elec}}A</div>
                               </li>
                               <li>
                                    <p>车辆用途</p>
                                    <div>{{data.base_info.car_use}}</div>
                               </li>
                               <li>
                                    <p>维修次数</p>
                                    <div>{{data.base_info.repair_nums}}</div>
                               </li>
                               <li>
                                    <p>均衡时间</p>
                                    <div>{{balanceTime}}S</div>
                               </li>
                           </ul>
                        </div>
                    </div>
                    <div class="module_box channel_info_box">
                        <div class="title">通道信息</div>
                        <div class="info_box">
                            <ul class="channel_info_list">
                                <li>
                                    <p>现有空闲通道数</p>
                                    <div>{{data.channel_info.free_channel_nums}}</div>
                                </li>
                                <li>
                                    <p>均衡完成通道数</p>
                                    <div>{{data.channel_info.finish_channel_nums}}</div>
                                </li>
                                <li>
                                    <p>现有均衡通道数</p>
                                    <div>{{data.channel_info.now_channel_nums}}</div>
                                </li>
                                <li>
                                    <p>故障通道数</p>
                                    <div>{{data.channel_info.error_channel_nums}}</div>
                                </li>

                            </ul>
                        </div>
                    </div>
               </div>
           </div>
           <div class="module_box test_info_chart">
              <div class="title">测试数据</div>
              <div class="info_box charts_box">
                <div class="chart_item">
                    <div class="sub_title">电压实时柱状图</div>
                    <div id="test_info" class="chart"></div>
                </div>
                <div class="chart_item">
                    <div class="sub_title">安时实时柱状图</div>
                    <div id="ampere" class="chart"></div>
                </div>
                </div>
           </div>
        </div>
        <div class="content-right">
           <div class="module_box" style="height:100%">
                <div class="title">均衡监控信息</div>
                <div class="info_box">
                    <ul class="aisles_list">
                        <li v-for="(v,i) in aisleList" :key="i" class="border_state">
                            <div>
                                <span>通道{{v.channel_inde}}</span>
                            </div>
                            <div style="color:#0d7777">电压：{{v.channel_volt_init}}V</div>
                            <div>电流：{{v.channel_elec}}A</div>
                            <div style="color:#0d7777">安时：{{v.channel_ampere_init}}H</div>
                        </li>
                        <li v-for="v in 28" :key="v+20">
                            <div>
                                <span>通道{{v+20}}</span>
                            </div>
                            <div>电压：{{data.close_channel.channel_volt}}</div>
                            <div>电流：{{data.close_channel.channel_elec}}</div>
                            <div>安时：{{data.close_channel.channel_ampere}}</div>
                        </li>
                    </ul>
                </div>
           </div>
        </div>
    </div>
  </div>
</template>

<script>
import * as echarts from "echarts";
import {convertKey} from '@/api/fileParsing'
export default {
    data() {
        return {
            myChart:null,
            ampereChart:null,
            myChartTime:null,
            ampereChartTime:null,
            timer:null,
            data:{
                base_info:{},
                channel_info:{},
                close_channel:{},
                conn_channel:{}
            },
            aisleList:[],
            nameList:[],
            voltList:[],
            ampereList:[],
            balanceTime:0,
        }
    },
    methods:{
        testInfoChart(myChart){
            let option;
            option = {
            grid:{
               top:20,
               left:30,
               right:10,
               bottom:20
            },
            tooltip:{
                position:'right'
            },
            xAxis: {
                type: 'category',
                data: this.nameList,
                axisTick:{
                    show:false // 不显示坐标轴刻度线
                },
                axisLabel: {
                    show: false, // 不显示坐标轴上的文字
                },
            },
            yAxis: {
                type: 'value',
                splitLine:{
                    // show:false // 不显示网格线
                    lineStyle:{
                        color: '#3e4253'
                    }
                },
            },
            series: [
                {
                    name:'电压',
                    type: 'bar',
                    barWidth:14,
                    data: this.voltList,
                    symbol: (params)=>{
                        if(params==Math.max(...this.voltList)){
                            return 'circle'
                        }else{
                            return 'none'
                        }
                    },
                    lineStyle:{
                        color:'#6e8ae1'
                    },
                    itemStyle : {
                            color:'#6e8ae1'
                    },
                },
            ]
            };

            option && myChart.setOption(option);
            window.addEventListener('resize',()=>{
                myChart.resize()
            })
             let index = 0; //播放所在下标
            clearInterval(this.myChartTime)
           this.myChartTime=setInterval(()=> {
            myChart.dispatchAction({
                type: 'showTip',
                seriesIndex: 0,
                dataIndex: index
            });
            index++;
            if(index > this.voltList.length) {
                index = 0;
            }
            }, 1000);
        },
        ampereChartEvent(myChart){
            let option;
            option = {
            grid:{
               top:20,
               left:30,
               right:10,
               bottom:20
            },
            tooltip:{
                position:'right'
            },
            xAxis: {
                type: 'category',
                data: this.nameList,
                axisTick:{
                    show:false // 不显示坐标轴刻度线
                },
                axisLabel: {
                    show: false, // 不显示坐标轴上的文字
                },
            },
            yAxis: {
                type: 'value',
                splitLine:{
                    // show:false // 不显示网格线
                    lineStyle:{
                        color: '#3e4253'
                    }
                },
            },
            series: [
                 {
                    name:'安时',
                    type: 'bar',
                    data: this.ampereList,
                    symbol: (params)=>{
                        if(params==Math.max(...this.ampereList)){
                            return 'circle'
                        }else{
                            return 'none'
                        }
                    },
                    lineStyle:{
                        color:'#a381dc'
                    },
                    itemStyle : {
                        color:'#a381dc'
                    },
                }
            ]
            };

            option && myChart.setOption(option);
            window.addEventListener('resize',()=>{
                myChart.resize()
            })
            let index = 0; //播放所在下标
            clearInterval(this.ampereChartTime)
           this.ampereChartTime=setInterval(()=> {
            myChart.dispatchAction({
                type: 'showTip',
                seriesIndex: 0,
                dataIndex: index
            });
            index++;
            if(index > this.ampereList.length) {
                index = 0;
            }
            }, 1000);
        },
        Calculation(num1, num2) {
            let sq1, sq2, m;
            try {
            sq1 = num1.toString().split('.')[1].length;
            } catch (e) {
            sq1 = 0;
            }
            try {
            sq2 = num2.toString().split('.')[1].length;
            } catch (e) {
            sq2 = 0;
            }
            m = Math.pow(10, Math.max(sq1, sq2));
            return (num1 * m + num2 * m) / m;
        },
        simulationData(){
        this.timer=setInterval(()=>{
            this.voltList=[]
            this.ampereList=[]
            this.aisleList=this.aisleList.filter(item=>{
                    let length1=item.channel_volt_init.toString().split('.')[1].length
                    let length2=item.channel_volt_max.toString().split('.')[1].length
                    let ms = Math.pow(10, Math.max(length1, length2));
                    if(item.channel_volt_init*ms<item.channel_volt_max*ms){
                        item.channel_volt_init=this.Calculation(item.channel_volt_init,item.channel_volt_upper)
                    }
                    item.channel_ampere_init=(this.Calculation(item.channel_ampere_init,item.channel_ampere_upper)).toFixed(2)
                    this.voltList.push(item.channel_volt_init)
                    this.ampereList.push(item.channel_ampere_init)
                    return item
                })
                this.testInfoChart(this.myChart)
                this.ampereChartEvent(this.ampereChart)
        },20000)
        }
    },
    async mounted (){
        this.myChart = echarts.init(document.getElementById('test_info'));
        this.ampereChart = echarts.init(document.getElementById('ampere'));

      // 获取数据
        await this.axios.get('/xml/balance.xml').then(response => {
            let xmlText = response.data;
            this.data = this.$x2js.xml2js(xmlText).data
            let keys=Object.keys(this.data);
            convertKey(keys,this.data);
            console.log(this.data);
            this.balanceTime=this.data.base_info.balance_time
        });
       //  初始化通道信息
       this.data.conn_channel.channel&&
       this.data.conn_channel.channel.forEach(item => {
            this.voltList.push(item.channel_volt_init)
            this.ampereList.push(item.channel_ampere_init)
            this.nameList.push(item.channel_inde)
       });
        this.aisleList=this.data.conn_channel.channel
        this.testInfoChart(this.myChart)
        this.ampereChartEvent(this.ampereChart)
        // 模拟数据
        this.simulationData()
        setInterval(()=>{
          this.balanceTime++
        },1000)
    },
    beforeDestroy() {
        clearInterval(this.timer);
        clearInterval(this.myChartTime);
        clearInterval(this.ampereChartTime);
        this.timer = null;
        this.ampereChartTime
        this.myChartTime
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
.content {
  position: absolute;
  top: 85px;
  width: 100%;
  height: calc(100% - 85px);
  display: flex;
  padding: 0 60px;
  box-sizing: border-box;
  overflow: hidden;
  & > div {
    height: 100%;
  }
}
.content-left{
    width: 60%;
}
.content-right{
    width: 40%;
    margin-left: 20px;
}
.content-left_box{
    height: 60%;
    display: flex;
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
}
.left_sub_top_hg{
    width: 35%;
    height: 100%;
    margin-right: 20px;
}
.info_img{
    width: 80%;
    height: 90%;
    margin: 5% auto;
    display: block;
    object-fit: contain;
}
.con_box{
    width: 65%;
}
.basic_info{
    width: 100%;
    height: 55%;
}
.channel_info_box{
    width: 100%;
    height: calc(45% - 20px);
    margin-top: 20px;
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
        height: 28%;
        background-color: #272a3d;
        margin-top: 5px;
        position: relative;
        p{
           color: #a8b4c1;
           font-size: 14px;
           margin-left: 20px;
           margin-top: 10px;
        }
        div{
            color: #fff;
            font-weight: 600;
            position: absolute;
            right: 10px;
            bottom: 5px;
        }
    }
}
.channel_info_list{
    width: 100%;
    height: 100%;
    padding: 5px 10px;
    box-sizing: border-box;
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    li{
        width: 49%;
        height: 44%;
        background-color: #272a3d;
        margin-top: 5px;
        position: relative;
        p{
           color: #a8b4c1;
           font-size: 14px;
           margin-left: 20px;
           margin-top: 10px;
        }
        div{
            color: #fff;
            font-weight: 600;
            position: absolute;
            right: 10px;
            bottom: 5px;
        }
    }
}
.test_info_chart{
    height: calc(40% - 20px);
    margin-top: 20px;
}
.aisles_list{
    width: 100%;
    height: 100%;
    display: flex;
    flex-wrap: wrap;
    font-size: 11px;
    overflow: auto;
    padding: 20px;
    box-sizing: border-box;
    li{
        width: 15%;
        min-width: 100px;
        height: 96px;
        border-radius: 5px;
        background-color: #252739;
        margin: 5px;
        color: #a2a3ab;
        display: flex;
        flex-direction: column;
        justify-content: space-around;
        padding: 9px;
        box-sizing: border-box;
        white-space: nowrap;
        &>div:nth-child(1){
            display: flex;
            justify-content: space-between
            i{color: #4fd05a;}
        }
    }
}
.border_state{
    border: 2px solid #4c3799;
    box-sizing: border-box;
}
.charts_box{
    display: flex;
    justify-content: space-between;
    padding: 10px 20px;
    box-sizing: border-box;
}
.chart_item{
    width: 49%;
    height: 100%;
}
.sub_title{
    font-size: 14px;
    color: #a8b4c1;
    margin-bottom: 10px;
    margin-left: 10px;
}
.chart{
    width: 100%;
    height: calc(100% - 30px);
    background-color: #262a3b;
}
</style>
