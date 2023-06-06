[1mdiff --git a/public/xml/balance.xml b/public/xml/balance.xml[m
[1mindex 625adf7..5468d45 100644[m
[1m--- a/public/xml/balance.xml[m
[1m+++ b/public/xml/balance.xml[m
[36m@@ -8,7 +8,7 @@[m
         <!-- 车型 -->[m
         <car-model>EU300</car-model>[m
         <!-- 车辆品牌 -->[m
[31m-        <car-brand>北汽</car-brand>[m
[32m+[m[32m        <car-brand>普莱德</car-brand>[m
         <!-- 里程 -->[m
         <car-mill>193465</car-mill>[m
         <!-- 均衡电流 -->[m
[1mdiff --git a/src/views/HomeView.vue b/src/views/HomeView.vue[m
[1mindex ccded32..4d3553b 100644[m
[1m--- a/src/views/HomeView.vue[m
[1m+++ b/src/views/HomeView.vue[m
[36m@@ -1,98 +1,162 @@[m
 <template>[m
   <div class="home bg">[m
[31m-    <NavTitleBar/>[m
[32m+[m[32m    <NavTitleBar />[m
     <div class="content">[m
       <div class="content_left">[m
[31m-        <div class="module_box left_top_hg" style="background-color:#2e3347;">[m
[32m+[m[32m        <div class="module_box left_top_hg" style="background-color: #2e3347">[m
           <div class="title">在修电池信息</div>[m
           <div class="info_box">[m
             <ul class="battery-info_list">[m
[31m-              <li v-for="(v,i) in batteryInfoList" :key="v.batteryNo" :class="{'battery-info_list_active':i==active}">[m
[31m-                <i class="fa fa-square" aria-hidden="true"></i><span>{{v.batteryNo}}</span><span>{{v.batteryBrand}}</span><span>{{v.faultAppear}}</span>[m
[32m+[m[32m              <li[m
[32m+[m[32m                v-for="(v, i) in batteryInfoList"[m
[32m+[m[32m                :key="v.batteryNo"[m
[32m+[m[32m                :class="{ 'battery-info_list_active': i == active }"[m
[32m+[m[32m              >[m
[32m+[m[32m                <i class="fa fa-square" aria-hidden="true"></i[m
[32m+[m[32m                ><span>{{ v.batteryNo }}</span[m
[32m+[m[32m                ><span>{{ v.batteryBrand }}</span[m
[32m+[m[32m                ><span>{{ v.faultAppear }}</span>[m
               </li>[m
             </ul>[m
           </div>[m
         </div>[m
         <div class="left_bottom_box" ref="banner">[m
[31m-           <el-carousel :height="bannerHeight +'px'" arrow="never" ref="carousel" @mouseenter.native="delHandleMouseEnter">[m
[31m-            <el-carousel-item v-for="(val,index) in eolDetailInfo" :key="index">[m
[31m-              <div class="module_box left_cen_hg" style="overflow: hidden;">[m
[32m+[m[32m          <el-carousel[m
[32m+[m[32m            :height="bannerHeight + 'px'"[m
[32m+[m[32m            arrow="never"[m
[32m+[m[32m            ref="carousel"[m
[32m+[m[32m            @mouseenter.native="delHandleMouseEnter"[m
[32m+[m[32m          >[m
[32m+[m[32m            <el-carousel-item v-for="(val, index) in base_info" :key="index">[m
[32m+[m[32m              <div class="module_box left_cen_hg" style="overflow: hidden">[m
                 <div class="title">电池详细信息</div>[m
                 <div class="info_box">[m
[31m-                    <p class="serial_number_name">电池编号</p>[m
[31m-                    <div class="serial_number_info">{{val.batteryNo}}</div>[m
[32m+[m[32m                  <p class="serial_number_name">电池编号</p>[m
[32m+[m[32m                  <div class="serial_number_info">{{ val.battery_no }}</div>[m
                 </div>[m
               </div>[m
               <ul class="vehicle-info_list">[m
                 <li class="vehicle-info_row">[m
[31m-                    <div class="vehicle-info_item">[m
[31m-                      <p class="vehicle-info_item_name">车辆品牌</p>[m
[31m-                      <div class="vehicle-info_item_info">{{val.car_brand}}</div>[m
[31m-                    </div>[m
[31m-                    <div class="vehicle-info_item">[m
[31m-                      <p class="vehicle-info_item_name">车型</p>[m
[31m-                      <div class="vehicle-info_item_info">{{val.car_type}}</div>[m
[32m+[m[32m                  <div class="vehicle-info_item">[m
[32m+[m[32m                    <p class="vehicle-info_item_name">车辆品牌</p>[m
[32m+[m[32m                    <div class="vehicle-info_item_info">[m
[32m+[m[32m                      {{ val.car_brand }}[m
                     </div>[m
[32m+[m[32m                  </div>[m
[32m+[m[32m                  <div class="vehicle-info_item">[m
[32m+[m[32m                    <p class="vehicle-info_item_name">车型</p>[m
[32m+[m[32m                    <div class="vehicle-info_item_info">{{ val.car_type }}</div>[m
[32m+[m[32m                  </div>[m
                 </li>[m
                 <li class="vehicle-info_row">[m
[31m-                    <div class="vehicle-info_item">[m
[31m-                      <p class="vehicle-info_item_name">车辆类型</p>[m
[31m-                      <div class="vehicle-info_item_info">{{val.car_model}}</div>[m
[31m-                    </div>[m
[31m-                    <div class="vehicle-info_item">[m
[31m-                      <p class="vehicle-info_item_name">里程</p>[m
[31m-                      <div class="vehicle-info_item_info">{{val.car_mill}}</div>[m
[32m+[m[32m                  <div class="vehicle-info_item">[m
[32m+[m[32m                    <p class="vehicle-info_item_name">车辆类型</p>[m
[32m+[m[32m                    <div class="vehicle-info_item_info">[m
[32m+[m[32m                      {{ val.car_model }}[m
                     </div>[m
[32m+[m[32m                  </div>[m
[32m+[m[32m                  <div class="vehicle-info_item">[m
[32m+[m[32m                    <p class="vehicle-info_item_name">里程</p>[m
[32m+[m[32m                    <div class="vehicle-info_item_info">{{ val.car_mill }}</div>[m
[32m+[m[32m                  </div>[m
                 </li>[m
                 <li class="vehicle-info_row">[m
[31m-                    <div class="vehicle-info_item">[m
[31m-                      <p class="vehicle-info_item_name">车辆用途</p>[m
[31m-                      <div class="vehicle-info_item_info">{{val.car_use}}</div>[m
[31m-                    </div>[m
[31m-                    <div class="vehicle-info_item">[m
[31m-                      <p class="vehicle-info_item_name">维修次数</p>[m
[31m-                      <div class="vehicle-info_item_info">{{val.repair_num}}</div>[m
[32m+[m[32m                  <div class="vehicle-info_item">[m
[32m+[m[32m                    <p class="vehicle-info_item_name">车辆用途</p>[m
[32m+[m[32m                    <div class="vehicle-info_item_info">{{ val.car_use }}</div>[m
[32m+[m[32m                  </div>[m
[32m+[m[32m                  <div class="vehicle-info_item">[m
[32m+[m[32m                    <p class="vehicle-info_item_name">维修次数</p>[m
[32m+[m[32m                    <div class="vehicle-info_item_info">[m
[32m+[m[32m                      {{ val.repair_num }}[m
                     </div>[m
[32m+[m[32m                  </div>[m
                 </li>[m
                 <li class="vehicle-info_row">[m
[31m-                    <div class="vehicle-info_item">[m
[31m-                      <p class="vehicle-info_item_name">已完成检测项目</p>[m
[31m-                      <div class="project_box">[m
[31m-                          <div class="project_item" v-for="(v,i) in val.finish_project.project" :key="i">[m
[31m-                            <span>{{v.project_name}}</span>[m
[31m-                            <span>[m
[31m-                              <i class="fa fa-circle-o" :style="{'color':v.project_result=='通过'?'#4ec55b':v.project_result=='未通过'?'#90273a':'#2f3979'}"></i>[m
[31m-                              {{v.project_result}}[m
[31m-                            </span>[m
[31m-                          </div>[m
[32m+[m[32m                  <div class="vehicle-info_item">[m
[32m+[m[32m                    <p class="vehicle-info_item_name">已完成检测项目</p>[m
[32m+[m[32m                    <div class="project_box">[m
[32m+[m[32m                      <div[m
[32m+[m[32m                        class="project_item"[m
[32m+[m[32m                        v-for="(v, i) in val.finish_project.project"[m
[32m+[m[32m                        :key="i"[m
[32m+[m[32m                      >[m
[32m+[m[32m                        <span>{{ v.project_name }}</span>[m
[32m+[m[32m                        <span>[m
[32m+[m[32m                          <i[m
[32m+[m[32m                            class="fa fa-circle-o"[m
[32m+[m[32m                            :style="{[m
[32m+[m[32m                              color:[m
[32m+[m[32m                                v.project_result == '通过'[m
[32m+[m[32m                                  ? '#4ec55b'[m
[32m+[m[32m                                  : v.project_result == '未通过'[m
[32m+[m[32m                                  ? '#90273a'[m
[32m+[m[32m                                  : '#2f3979',[m
[32m+[m[32m                            }"[m
[32m+[m[32m                          ></i>[m
[32m+[m[32m                          {{ v.project_result }}[m
[32m+[m[32m                        </span>[m
                       </div>[m
                     </div>[m
[31m-                    <div class="vehicle-info_item">[m
[31m-                      <p class="vehicle-info_item_name">检测中数据</p>[m
[31m-                      <div class="project_box">[m
[31m-                          <div class="legend">[m
[31m-                            <div class="border_rig">[m
[31m-                              <span>{{val.check_data.check[0]&&val.check_data.check[0].check_name}}</span>[m
[31m-                              <p>{{val.check_data.check[0]&&val.check_data.check[0].check_result}}</p>[m
[31m-                            </div>[m
[31m-                            <div>[m
[31m-                              <span>{{val.check_data.check[1]&&val.check_data.check[1].check_name}}</span>[m
[31m-                              <p>{{val.check_data.check[1]&&val.check_data.check[1].check_result}}</p>[m
[31m-                            </div>[m
[31m-                          </div>[m
[31m-                          <hr style="margin:0 1.25rem;">[m
[31m-                          <div class="legend">[m
[31m-                            <div class="border_rig">[m
[31m-                              <span>{{val.check_data.check[2]&&val.check_data.check[2].check_name}}</span>[m
[31m-                              <p>{{val.check_data.check[2]&&val.check_data.check[2].check_result}}</p>[m
[31m-                            </div>[m
[31m-                            <div>[m
[31m-                              <span>{{val.check_data.check[3]&&val.check_data.check[3].check_name}}</span>[m
[31m-                              <p>{{val.check_data.check[3]&&val.check_data.check[3].check_result}}</p>[m
[31m-                            </div>[m
[31m-                          </div>[m
[32m+[m[32m                  </div>[m
[32m+[m[32m                  <div class="vehicle-info_item">[m
[32m+[m[32m                    <p class="vehicle-info_item_name">检测中数据</p>[m
[32m+[m[32m                    <div class="project_box">[m
[32m+[m[32m                      <div class="legend">[m
[32m+[m[32m                        <div class="border_rig">[m
[32m+[m[32m                          <span>{{[m
[32m+[m[32m                            val.check_data.check[0] &&[m
[32m+[m[32m                            val.check_data.check[0].check_name[m
[32m+[m[32m                          }}</span>[m
[32m+[m[32m                          <p>[m
[32m+[m[32m                            {{[m
[32m+[m[32m                              val.check_data.check[0] &&[m
[32m+[m[32m                              val.check_data.check[0].check_result[m
[32m+[m[32m                            }}[m
[32m+[m[32m                          </p>[m
[32m+[m[32m                        </div>[m
[32m+[m[32m                        <div>[m
[32m+[m[32m                          <span>{{[m
[32m+[m[32m                            val.check_data.check[1] &&[m
[32m+[m[32m                            val.check_data.check[1].check_name[m
[32m+[m[32m                          }}</span>[m
[32m+[m[32m                          <p>[m
[32m+[m[32m                            {{[m
[32m+[m[32m                              val.check_data.check[1] &&[m
[32m+[m[32m                              val.check_data.check[1].check_result[m
[32m+[m[32m                            }}[m
[32m+[m[32m                          </p>[m
[32m+[m[32m                        </div>[m
[32m+[m[32m                      </div>[m
[32m+[m[32m                      <hr style="margin: 0 1.25rem" />[m
[32m+[m[32m                      <div class="legend">[m
[32m+[m[32m                        <div class="border_rig">[m
[32m+[m[32m                          <span>{{[m
[32m+[m[32m                            val.check_data.check[2] &&[m
[32m+[m[32m                            val.check_data.check[2].check_name[m
[32m+[m[32m                          }}</span>[m
[32m+[m[32m                          <p>[m
[32m+[m[32m                            {{[m
[32m+[m[32m                              val.check_data.check[2] &&[m
[32m+[m[32m                              val.check_data.check[2].check_result[m
[32m+[m[32m                            }}[m
[32m+[m[32m                          </p>[m
[32m+[m[32m                        </div>[m
[32m+[m[32m                        <div>[m
[32m+[m[32m                          <span>{{[m
[32m+[m[32m                            val.check_data.check[3] &&[m
[32m+[m[32m                            val.check_data.check[3].check_name[m
[32m+[m[32m                          }}</span>[m
[32m+[m[32m                          <p>[m
[32m+[m[32m                            {{[m
[32m+[m[32m                              val.check_data.check[3] &&[m
[32m+[m[32m                              val.check_data.check[3].check_result[m
[32m+[m[32m                            }}[m
[32m+[m[32m                          </p>[m
[32m+[m[32m                        </div>[m
                       </div>[m
                     </div>[m
[32m+[m[32m                  </div>[m
                 </li>[m
               </ul>[m
             </el-carousel-item>[m
[36m@@ -101,66 +165,148 @@[m
       </div>[m
       <div class="content_cen">[m
         <ul class="module_list_box">[m
[31m-            <li @click="toPage(val.systemStatus,index)" v-for="(val,index) in HomeViewInfoList" :key="index">[m
[31m-              <img class="tip_img" src="../assets/image/Bubble .png" v-show="val.systemStatus==='0'&&showActive==index" />[m
[31m-              <div class="module_item_img" :class="['img'+(index+1)]"></div>[m
[31m-              <div class="module_item_content">[m
[31m-                 <div class="module_name">[m
[31m-                  <span>{{val.systemName}}</span>[m
[31m-                 </div>[m
[31m-                 <div class="module_state">[m
[31m-                  <div>[m
[31m-                    <i class="fa fa-circle-o" :style="{'color':val.systemStatus=='1'?'#47a757':'#4b5164'}"></i>[m
[31m-                    <span :style="{'color':val.systemStatus=='1'?'#fff':'#4b5164'}"> 使用</span>[m
[31m-                  </div>[m
[31m-                  <div>[m
[31m-                    <i class="fa fa-circle-o" :style="{'color':val.systemStatus=='0'?'#47a757':'#4b5164'}"></i>[m
[31m-                    <span :style="{'color':val.systemStatus=='0'?'#fff':'#4b5164'}">空闲</span>[m
[31m-                  </div>[m
[31m-                 </div>[m
[32m+[m[32m          <li[m
[32m+[m[32m            @click="toPage(val.systemStatus, index)"[m
[32m+[m[32m            v-for="(val, index) in HomeViewInfoList"[m
[32m+[m[32m            :key="index"[m
[32m+[m[32m          >[m
[32m+[m[32m            <img[m
[32m+[m[32m              class="tip_img"[m
[32m+[m[32m              src="../assets/image/Bubble .png"[m
[32m+[m[32m              v-show="val.systemStatus === '0' && showActive == index"[m
[32m+[m[32m            />[m
[32m+[m[32m            <div class="module_item_img">[m
[32m+[m[32m              <img[m
[32m+[m[32m                class="systemImage_img"[m
[32m+[m[32m                :src="require('@/assets/image/' + val.systemImage + '.png')"[m
[32m+[m[32m              />[m
[32m+[m[32m            </div>[m
[32m+[m[32m            <!-- <img class="module_item_img" :src="require('@/assets/image/' + val.systemImage + '.png')" > -->[m
[32m+[m[32m            <!-- <div class="module_item_img" :class="['img'+(index+1)]" ></div> -->[m
[32m+[m[32m            <div class="module_item_content">[m
[32m+[m[32m              <div class="module_name">[m
[32m+[m[32m                <span>{{ val.systemName }}</span>[m
[32m+[m[32m              </div>[m
[32m+[m[32m              <div class="module_state">[m
[32m+[m[32m                <div>[m
[32m+[m[32m                  <i[m
[32m+[m[32m                    class="fa fa-circle-o"[m
[32m+[m[32m                    :style="{[m
[32m+[m[32m                      color: val.systemStatus == '1' ? '#47a757' : '#4b5164',[m
[32m+[m[32m                    }"[m
[32m+[m[32m                  ></i>[m
[32m+[m[32m                  <span[m
[32m+[m[32m                    :style="{[m
[32m+[m[32m                      color: val.systemStatus == '1' ? '#fff' : '#4b5164',[m
[32m+[m[32m                    }"[m
[32m+[m[32m                  >[m
[32m+[m[32m                    使用</span[m
[32m+[m[32m                  >[m
[32m+[m[32m                </div>[m
[32m+[m[32m                <div>[m
[32m+[m[32m                  <i[m
[32m+[m[32m                    class="fa fa-circle-o"[m
[32m+[m[32m                    :style="{[m
[32m+[m[32m                      color: val.systemStatus == '0' ? '#47a757' : '#4b5164',[m
[32m+[m[32m                    }"[m
[32m+[m[32m                  ></i>[m
[32m+[m[32m                  <span[m
[32m+[m[32m                    :style="{[m
[32m+[m[32m                      color: val.systemStatus == '0' ? '#fff' : '#4b5164',[m
[32m+[m[32m                    }"[m
[32m+[m[32m                    >空闲</span[m
[32m+[m[32m                  >[m
[32m+[m[32m                </div>[m
               </div>[m
[31m-            </li>[m
[32m+[m[32m            </div>[m
[32m+[m[32m          </li>[m
         </ul>[m
       </div>[m
       <div class="content_right">[m
         <div class="module_box top_hg">[m
           <div class="title">电池车间信息</div>[m
[31m-          <div class="info_box" style="display:flex;">[m
[31m-            <div id="battery_workshop" style="width:50%;height:100%;"></div>[m
[31m-            <div id="passing_rate" style="width:50%;height:100%;"></div>[m
[32m+[m[32m          <div class="info_box" style="display: flex">[m
[32m+[m[32m            <div id="battery_workshop" style="width: 50%; height: 100%"></div>[m
[32m+[m[32m            <div id="passing_rate" style="width: 50%; height: 100%"></div>[m
           </div>[m
         </div>[m
[31m-         <div class="module_box right_cen_hg">[m
[32m+[m[32m        <div class="module_box right_cen_hg">[m
           <div class="title">设备监控信息</div>[m
           <div class="info_box">[m
[31m-            <p class="serial_number_name" style="font-size:1rem;margin:1.25rem 1.875rem">{{equip.equip_name}}</p>[m
[32m+[m[32m            <p[m
[32m+[m[32m              class="serial_number_name"[m
[32m+[m[32m              style="font-size: 1rem; margin: 1.25rem 1.875rem"[m
[32m+[m[32m            >[m
[32m+[m[32m              {{ equip.equip_name }}[m
[32m+[m[32m            </p>[m
             <div class="sys_monitoring_box">[m
[31m-             <div class="sys_monitoring_