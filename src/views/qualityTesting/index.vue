<template>
  <div class="bg">
    <div class="content">
      <div class="menu_box">
        <el-menu router :default-active="path" class="el-menu-vertical-demo" background-color="#202430"
          text-color="#fff" active-text-color="#67438e">
          <el-menu-item index="/quality-testing/menu-list/report">
            <i class="fa fa-circle icon_dot"></i>
            <span slot="title" class="nav_title">诊断报告</span>
          </el-menu-item>
          <el-menu-item index="/quality-testing/menu-list/safety-regulation">
            <i class="fa fa-window-minimize icon_line"></i>
            <span slot="title" class="nav_title">安规检测</span>
          </el-menu-item>
          <el-menu-item index="/quality-testing/menu-list/eol-detection">
            <i class="fa fa-window-minimize icon_line"></i>
            <span slot="title" class="nav_title">EOL检测</span>
          </el-menu-item>
          <el-menu-item index="/quality-testing/menu-list/charge-discharge">
            <i class="fa fa-window-minimize icon_line"></i>
            <span slot="title" class="nav_title">充放电检测</span>
          </el-menu-item>
          <el-menu-item index="/quality-testing/menu-list/equilibrium">
            <i class="fa fa-circle icon_dot"></i>
            <span slot="title" class="nav_title">质检报告</span>
          </el-menu-item>
          <el-menu-item index="/quality-testing/menu-list/equilibrium">
            <i class="fa fa-window-minimize icon_line"></i>
            <span slot="title" class="nav_title">均衡</span>
          </el-menu-item>
        </el-menu>
      </div>
      <div class="page">
        <div class="page_img_box">
          <i class="fa fa-angle-left" @click="toPage(0)"></i>
        <router-view />
        <i class="fa fa-angle-right" @click="toPage(1)"></i>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      path: '/quality-testing/menu-list/report'
    }
  },
  methods: {

  },
  mounted() {
    this.path = this.$route.path
  }
}
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
  box-sizing: border-box;
}

.menu_box {
  position: absolute;
  width: 300px;
  top: -39px;
  bottom: -50px;
  padding-top: 85px;
  z-index: 1;
  background-color: #202430;
}

.icon_dot {
  margin: 0 20px;
  font-size: 10px;
}

.icon_line {
  margin-left: 40px;
  margin-right: 20px;
  font-size: 10px;
  position: relative;
  bottom: 3px;
}

.nav_title {
  color: #fff !important;
}

::v-deep .el-submenu__title {
  height: 73px;
  line-height: 73px;
}

::v-deep.el-submenu .el-menu-item {
  height: 73px;
  line-height: 73px;
}

::v-deep .el-menu-item.is-active {
  background-color: #272b3b !important;
}

::v-deep .el-menu {
  border-right: none;
}

.page {
  flex: 1;
  height: 100%;
  margin-left: 300px;
}
.page .page_img_box {
  display: flex;
}
.page .page_img_box i{
  color: #fff;
  font-size: 45px;
  margin-top: 240px;
  padding: 0 20px;
}


::v-deep(.el-submenu.is-active > .el-submenu__title) i {
  color: #67438e;
}
</style>