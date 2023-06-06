import request from '@/utils/request'


// 首页-系统查询状态列表
export function HomeViewList() {
    return request({
        url: '/system/list',
        method: 'get',
    })
}

// 首页-在修电池信息列表
export function RepairList() {
    return request({
        url: '/battery/repair',
        method: 'get',
    })
}

// 首页-所有设备信息查询列表
export function DeviceList() {
    return request({
        url: '/device/list',
        method: 'get',
    })
}


