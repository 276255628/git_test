const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  lintOnSave: false,
  publicPath: "/",
  transpileDependencies: true,
  devServer:{
    historyApiFallback: true,
    allowedHosts: 'all',
    proxy:{
      '/dev-api':{
        target:'http://192.168.4.200:8080',
        changeOrigin: true,
        pathRewrite:{
           '^/dev-api': ''
        }
      },
      '/weather':{
        target:'http://autodev.openspeech.cn/csp/api/v2.1/weather',
        changeOrigin: true,
        pathRewrite:{
           '^/weather': ''
        }
      },
    }
  }
})
