import request from '@/utils/request'

// 获取EOL检测数据
export function eolDetectionList(params) {
    return request({
        url: '/report/safety/list',
        method: 'get',
        params
    })
}
