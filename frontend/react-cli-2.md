# React-Cli 2

> 整体项目可以参考[react-cli-2](https://github.com/jekorx/react-cli-2)  

> 基于[create-react-app@2.1.5](https://facebook.github.io/create-react-app/)搭建  
> 使用[react-app-rewired@^2.1.0](https://github.com/timarney/react-app-rewired)非eject方式修改webpack相关配置  
> 关于eslint，使用standard规则（个人习惯）  

#### 依赖

```bash
## devDependencies
# 配合react-app-rewired，定义一些功能
customize-cra@^0.2.12
# CRA核心react-scripts，默认使用eslint@5.12.0，固定版本
eslint@5.12.0
# eslint规则相关依赖
eslint-config-standard@^12.0.0
eslint-plugin-import@^2.16.0
eslint-plugin-node@^8.0.1
eslint-plugin-promise@^4.0.1
eslint-plugin-standard@^4.0.0
# 使用scss，需加入node-sass依赖
node-sass@^4.11.0
# 修改webpack相关配置
react-app-rewired@^2.1.0
# 开发时模块热更新
react-hot-loader@^4.7.2
# 默认在dependencies中，移动到devDependencies
react-scripts@2.1.5
```

#### 项目根目录添加config-overrides.js

```javascript
const path = require('path')
const {
  addBabelPlugin,
  addDecoratorsLegacy,
  addWebpackAlias,
  useEslintRc
} = require('customize-cra')

const resolve = function (dir) {
  return path.resolve(__dirname, 'src', dir)
}

/**
 * `react-app-rewire-hot-loader` https://www.npmjs.com/package/react-app-rewire-hot-loader
 */
const rewireHotLoader = (config, env) => {
  if (env === 'production') {
    return config
  }
  // Find a rule which contains eslint-loader
  const condition = u => typeof u === 'object' && u.loader && u.loader.includes('eslint-loader')
  const rule = config.module.rules.find(rule => rule.use && rule.use.some(condition))
  if (rule) {
    const use = rule.use.find(condition)
    if (use) {
      // Inject the option for eslint-loader
      use.options.emitWarning = true
    }
  }
  // If in development, add 'react-hot-loader/babel' to babel plugins.
  return addBabelPlugin('react-hot-loader/babel')(config)
}

/**
 * 修改默认配置
 */
module.exports = function (config, env) {
  // 开发模式使用react-hot-loader
  rewireHotLoader(config, env)

  // 使用自定义.eslintrc
  useEslintRc('./.eslintrc')(config)

  // 装饰器，主要用于mobx
  addDecoratorsLegacy()(config)

  // 别名
  addWebpackAlias({
    '@src': resolve(''),
    '@api': resolve('api'),
    '@store': resolve('store'),
    '@routes': resolve('routes'),
    '@pages': resolve('pages'),
    '@layouts': resolve('layouts'),
    '@components': resolve('components'),
    '@styles': resolve('assets/styles'),
    '@images': resolve('assets/images')
  })(config)

  // 返回config
  return config
}
```

#### 修改package.json

```bash
  "scripts": {
-   "start": "react-scripts start",
+   "start": "react-app-rewired start",
-   "build": "react-scripts build",
+   "build": "react-app-rewired build",
-   "test": "react-scripts test",
+   "test": "react-app-rewired test",
    "eject": "react-scripts eject"
  }
```

#### 配置环境变量

> 开发，在项目根目录添加.env.development文件  

```bash
## cra webpack配置中默认的部分变量
# 取消自动打开浏览器
BROWSER=none
```

> 生产，在项目根目录添加.env.production文件  

```bash
## cra webpack配置中默认的部分变量
# public path，资源前缀
# 如<script src="/react-app/static/js/7.9a597b96.chunk.js">
PUBLIC_URL=/react-app
# sourcemap
GENERATE_SOURCEMAP=false
```

#### 关于跨域

> 在package.json中添加proxy即可  

```
"proxy": "http://192.168.0.11",
```

#### 附.eslintrc相关配置

```json
{
  "extends": [
    "standard",
    "plugin:react/recommended"
  ],
  "env": {
    "browser": true,
    "commonjs": true,
    "node": true,
    "es6": true
  },
  "parser": "babel-eslint",
  "parserOptions": {
    "ecmaVersion": 7,
    "sourceType": "module",
    "ecmaFeatures": {
      "jsx": true,
      "legacyDecorators": true
    }
  },
  "settings": {
    "react": {
      "version": "detect"
    }
  },
  "plugins": [
    "react"
  ],
  "rules": {
    "arrow-parens": [
      "error",
      "as-needed"
    ],
    "object-curly-spacing": [
      1,
      "always"
    ]
  }
}
```

#### 相关问题

```bash
# eslint warning
Warning: React version not specified in eslint-plugin-react settings. 

# 在.eslintrc中添加以下内容，指定react版本即可
"settings": {
  "react": {
    "version": "detect"
  }
},
```

```bash
# 控制台警告
React-Hot-Loader: react-🔥-dom patch is not detected. React 16.6+ features may not work.

# 不影响使用，估计在react-hot-loader 4.7.2之后的版本会去掉该提示
# https://github.com/gaearon/react-hot-loader/blob/f15b108cfac2aa6b8f98496b1e3103a4ad1c9e9c/src/reactHotLoader.js#L122
```

