import request from '@/utils/request'


// 单体检测信息数据
export function eolList() {
    return request({
        url: '/eol/list',
        method: 'get',
    })
}


// 动力电池EOL检测系统基本信息

export function eolBaseInfo(params) {
    return request({
        url: '/battery/eol/get',
        method: 'get',
        params
    })
}
