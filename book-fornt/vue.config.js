const { defineConfig } = require('@vue/cli-service')
module.exports = {
  publicPath: process.env.NODE_ENV === 'production' ? './' : './',
  outputDir: 'dist',
  indexPath: 'index.html',
  lintOnSave: false,
  devServer:{
    port:8020, // 启动端口号
    open:true,  // 启动后是否自动打开网页
  }
}
