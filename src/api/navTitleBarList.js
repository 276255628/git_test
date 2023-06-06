import request from '@/utils/request'

// 首页-获取当前日期
export function CurrentDateList() {
    return request({
        url: '/date',
        method: 'get',
    })
}
// 首页-获取当前天气
export function WeatherList() {
    return request({
        url: '/weather',
        method: 'get',
    })
}

