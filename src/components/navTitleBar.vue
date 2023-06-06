<template>
   <div class="nav_title_bar">
      <div class="nav_left">{{time}}</div>
      <div class="nav_right">
        <img v-if="weather=='晴'" src="../assets/image/fair_weather.svg">
        <img v-else-if="weather.indexOf('雨')!=-1" src="../assets/image/rain.svg">
        <img v-else src="../assets/image/cloudy.svg">
        <span>{{temperature}}℃</span>
      </div>
   </div> 
</template>

<script>
import {CurrentDateList,WeatherList} from '@/api/navTitleBarList'
export default {
   data() {
    return {
        time:null,
        weather:'晴', 
        temperature:"-" 
    }
   },
   mounted(){
    // 获得当前日期
      CurrentDateList().then((res) => {
      this.time=res.data.today
    });

    // 获得当前天气
      WeatherList().then((res) => {
        this.weather=res.data.weather
        this.temperature=res.data.temperature
    });

    // 模拟日期和天气
    //  let date=new Date()
    //  let year = date.getFullYear(); //得到年份
    //  let month = date.getMonth()+1; //得到月份
    //  let day = date.getDate(); //得到日期
    //  this.time=year+'-'+month+'-'+day
    //  this.axios.get('/weather?openId=aiuicus&clientType=android&sign=android&city=北京')
    //  .then(res=>{
    //     this.weather=res.data.data.list[0]
    //  })
   }
}
</script>

<style lang="scss" scoped>
.nav_title_bar {
  position: absolute;
  width: 100%;
  height: 152px;
  background-image: url("../assets/image/title_bar.png");
  background-size: 100% 100%;
  z-index: 1;
}
.nav_left{
    position: absolute;
    top: 15px;
    left: 60px;
    color: #fff;
}
.nav_right{
    position: absolute;
    top: 8px;
    right: 50px;
    color: #fff;
    display: flex;
    align-items: center;
    span{
        margin: 0 10px;
    }
    img{
      width: 28px;
      height: 28px;
    }
}
</style>