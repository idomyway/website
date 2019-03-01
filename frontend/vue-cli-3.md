# Vue-Cli-3

> 根据提示完成初始化项目后可以使用```vue ui```命令使用GUI界面管理项目  
> 默认配置可以满足绝大多数项目，非常方便  
> 如需进一步了解可参考[VUE CLI官方文档](https://cli.vuejs.org/zh/guide/)  

#### 配置

> 在项目根目录下添加vue.config.js

```javascript
const path = require('path')

function resolve (dir) {
  return path.join(__dirname, dir)
}

module.exports = {
  devServer: {
    // 端口
    port: 8520,
    // 跨域（本人使用vue-cli-3没有此配置也不会出现跨域问题，具体原因没有深入研究）
    proxy: {
      '/api/': {
        target: 'http://127.0.0.1/',
        changeOrigin: true
      }
    }
  },
  // webpack链式操作
  chainWebpack: config => {
    // 别名
    config.resolve.alias
      .set('@', resolve('src'))
      .set('@api', resolve('src/api'))
      .set('@store', resolve('src/store'))
      .set('@pages', resolve('src/pages'))
      .set('@layouts', resolve('src/layouts'))
      .set('@components', resolve('src/components'))
      .set('@styles', resolve('src/assets/styles'))
      .set('@images', resolve('src/assets/images'))
      .set('@utils', resolve('src/utils'))
      .set('@static', resolve('static'))
  }
}
````
