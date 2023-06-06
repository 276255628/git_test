<template>
   <div class="sub_page">
       <div class="content">
            <ul class="monomer_list_title" style="font-size:16px;">
               <li>工步序号</li>
               <li>工步名称</li>
               <li>测试项名称</li>
               <li>测试值范围</li>
               <li>测试温度范围</li>
               <li>时刻1</li>
               <li>时刻2</li>
               <li>测试阶段时间</li>
               <li>单体电压最低</li>
               <li>单体电压最高</li>
               <li>测试/计算值</li>
               <li>检测结果</li>
            </ul>
            <ul class="monomer_list_title interval_bg" v-for="(v,i) in data.item" :key="i">
                <li>{{v.step_num}}</li>
                <li>{{v.step_name}}</li>
                <li>{{v.test_name}}</li>
                <li>{{v.test_scope}}</li>
                <li>{{v.temp_scope}}</li>
                <li>{{v.time_one}}</li>
                <li>{{v.time_two}}</li>
                <li>{{v.test_stage_time}}</li>
                <li>{{v.single_volt_min}}</li>
                <li>{{v.single_volt_max}}</li>
                <li>{{v.test_compute_value}}</li>
                <li style="color:#00a69d">{{v.result}}</li>
            </ul>
       </div>
   </div>
</template>

<script>
import {convertKey} from '../../api/fileParsing'
export default {
   data() {
    return {
        data:{}
    }
   },
   methods:{

   },
  async mounted(){
    await  this.axios.get('/xml/chargeDischarge.xml').then(response => {
        let xmlText = response.data;
        this.data = this.$x2js.xml2js(xmlText).data
        let keys=Object.keys(this.data);
        convertKey(keys,this.data);
        console.log(this.data);
      
    });
   }
}
</script>

<style lang="scss" scoped>
.sub_page{
    width: 100%;
    height: 100%;
    padding: 0 20px;
    box-sizing: border-box;
    overflow: auto;
}
.content{
    padding: 10px;
    background-color: #1e2132;
}
.monomer_list_title{
    display: flex;
    width: 100%;
    height: 30px;
    line-height: 30px;
    color: #a8b4c1;
    margin: 5px 0;
    font-size: 14px;
    li{
        flex: 1;
        height: 100%;
        text-align: center;
        white-space: nowrap; // 不换行
        overflow: hidden;
        text-overflow: ellipsis
    }
}
.monomer_list_title>li:nth-child(3){
    min-width: 250px;
}
.monomer_list_title>li:nth-child(8){
    min-width: 100px;
}
.interval_bg:nth-child(2n){
    background-color: #252738;
}
</style>