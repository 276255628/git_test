<template>
  <div class="app-wrapper">
    <NavTitleBar/>
    <div class="view">
       <router-view/>
    </div>
    <div class="nav">
      <div class="nav-bg"></div>
      <div class="nav_img_box">
        <!-- <i class="fa fa-angle-left" @click="toPage(0)"></i> -->
        <img src="../assets/image/home.png" @click="toHome">
        <!-- <i class="fa fa-angle-right" @click="toPage(1)"></i> -->
      </div>
    </div>
  </div>
</template>
<script>
import NavTitleBar from '../components/navTitleBar.vue'
export default {
  components:{
    NavTitleBar
  },
  data() {
    return {
      paths:[],
      num:0
    }
  },
  methods:{
     toPage(flag){
      let path=this.paths
      if(flag==0){
         this.num==0?this.num=path.length-1:this.num--
      }else if(flag==1){
        this.num==path.length-1?this.num=0:this.num++
      }
       this.$router.push(path[this.num])
     },
     toHome(){
        this.$router.push('/')
     },
     getItem(data){
        let pathArr=this.$route.path.split('/')
        data.forEach((item,index)=>{
           let arr=item.path.split('/')
           if(arr[1]==pathArr[1]){
            this.num=index
           }
        })
     }
  },
   mounted() {
     this.paths= JSON.parse(JSON.stringify(this.$router.options.routes));
     this.paths.splice(0,1)
     this.getItem(this.paths)
   },
}
</script>
<style lang="scss">
.app-wrapper{
    width: 100%;
    height: 100%;
}
.nav{
  height: 50px; 
  background-color:#0f0f1e ;
  position: relative;
  overflow: hidden;
}
.nav-bg{
  width: 100%;
  height: 120%;
  background: linear-gradient(to right, #101021 0%, #23233e 50%, #101021 100%);
  border-radius:100% 100% 0 0;
  position: absolute;
  top: 15%;
  z-index: 2;
}
.nav_img_box{
  width: 100%;
  height: 100%;
  position: absolute;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 30px;
  color: #fff;
  z-index: 3;
  i{
    color: #fff;
    margin: 0 10px;
    cursor: pointer;
  }
  img{
    margin: 0 10px;
    cursor: pointer;
    user-select: none;
  }
}
.view{
  height: calc(100% - 50px);
}
</style>
