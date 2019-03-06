# webpack

> webpack@^4.29.6为例，详细文档可以参考[webpack中文文档](https://www.webpackjs.com/concepts/)  

#### 依赖

```bash
# babel，可以使用新版语法
@babel/core@^7.3.4
babel-loader@^8.0.5
html-webpack-plugin@^3.2.0
# webpack
webpack@^4.29.6
# webpack4之前的版本webpack-cli在webpack里面，4开始，单独一个模块
webpack-cli@^3.2.3
# 开发，用于页面自动刷新
webpack-dev-server@^3.2.1
# webpack配置覆盖合并
webpack-merge@^4.2.1
```

#### webpack配置文件

```javascript
const path = require('path')
const HTMLWebpackPlugin = require('html-webpack-plugin')
// 路径转换
function resolve(dir) {
  return path.join(__dirname, '.', dir)
}
// webpack配置
module.exports = {
  // webpack4必须制定模式
  // 会将 process.env.NODE_ENV 的值设为 development。
  // 启用 NamedChunksPlugin 和 NamedModulesPlugin
  mode: 'development',
  // 会将 process.env.NODE_ENV 的值设为 production。
  // 启用 FlagDependencyUsagePlugin, FlagIncludedChunksPlugin, ModuleConcatenationPlugin, 
  // NoEmitOnErrorsPlugin, OccurrenceOrderPlugin, SideEffectsFlagPlugin 和 UglifyJsPlugin
  // mode: 'production',
  // 入口文件
  entry: resolve('src/index.js'),
  // 输出文件
  output: {
    // 文件名
    filename: '[name].js',
    // 文件目录
    path: resolve('dist')
  },
  // 模块
  module: {
    // 处理规则
    rules: [
      {
        // 匹配js文件
        test: /\.js$/,
        // 使用babel处理，可以写新版js语法
        use: 'babel-loader',
        // 匹配目录，只匹配根目录下src目录
        include: resolve('src')
      }
    ]
  },
  // 插件
  plugins: [
    // 用于处理html，将打包的js和css引用插入到index.html
    new HTMLWebpackPlugin({
      // 标题
      title: 'Webpack',
      // 模版
      template: resolve('src/index.html'),
      // 给定的图标路径，可将其添加到输出html中
      favicon: resolve('src/assets/favicon.ico')
    })
  ],
  // webpack dev server 配置
  devServer: {
    // 热替换
    hot: true,
    // 指定使用一个 host。默认是 localhost
    // 如果希望服务器外部可访问"0.0.0.0"，但是在浏览器中会自动打开http://0.0.0.0:7890/
    host: '127.0.0.1',
    // 端口
    port: 7890,
    // 启动后自动在浏览器中打开
    open: true
  }
}
```

#### package.json中配置相关命令

```json
// --progress显示打包进度 --colors颜色高亮 --config制定配置文件
"scripts": {
  // 打包
  "build": "webpack --progress --colors --config webpack.prod.conf.js",
  // 开发
  "dev": "webpack-dev-server --progress --colors --config webpack.dev.conf.js"
},
```

#### 运行

```bash
# 安装依赖
npm i
# or
cnpm i
# or fast
yarn

# 开发运行
npm run dev
# or
yarn dev

# 生产打包
npm run build
# or
yarn build
```
