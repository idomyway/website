# ESLint

> ESLint是一个语法规则和代码风格的检查工具。

> 项目中使用ESLint可以避免一些低级错误、格式错误，统一项目代码风格，更有利于团队协作等。

> 开发工具中需添加ESLint扩展，如：VSCode中ESLint插件。

> 个人更倾向于使用standard规范，以standard规范为例。

#### 在Reactjs脚手架create-react-app@1.5.2中使用ESLint

```javascript
/*
 * 由于CRA中默认支持ESLint，只需添加相关依赖和配置即可
 */

// 1、安装依赖
yarn add babel-eslint eslint eslint-config-standard eslint-plugin-import eslint-plugin-node eslint-plugin-promise eslint-plugin-react eslint-plugin-standard -D

// 2、eslint相关配置，项目根目录中添加.eslintrc文件
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
      "jsx": true
    }
  },
  "plugins": [
    "react"
  ],
  "rules": {
    "arrow-parens": ["error", "as-needed"],
    "object-curly-spacing": [1, "always"]
  }
}

// 3、eslint校验忽略，项目根目录中添加.eslintignore文件
/build/
/public/
/*.js
```

#### 在Vuejs脚手架vue-cli@2.9.x中使用ESLint

```javascript
/*
 * 只需在构建项目时根据提示操作即可
 */

// 1、构建项目时，Use ESLint to lint your code? Y

// 2、Pick an ESLint preset，选择上下箭头选择Standard (https://github.com/standard/standard)
```

#### 在Nuxtjs脚手架create-nuxt-app@2.4.0中使用ESLint

```javascript
// 1、构建项目时，Choose features to install，上下箭头+空格勾选Linter / Formatter这一项

// 2、去除不必要的依赖
yarn remove @nuxtjs/eslint-config -D

// 3、修改.eslintrc.js
module.exports = {
  root: true,
  env: {
    browser: true,
    node: true
  },
  parserOptions: {
    parser: 'babel-eslint'
  },
  extends: [
    // '@nuxtjs'
    // https://github.com/vuejs/eslint-plugin-vue#priority-a-essential-error-prevention
    // consider switching to `plugin:vue/strongly-recommended` or `plugin:vue/recommended` for stricter rules.
    'plugin:vue/essential',
    // https://github.com/standard/standard/blob/master/docs/RULES-en.md
    'standard'
  ],
  // required to lint *.vue files
  plugins: [
    'vue'
  ],
  // add your custom rules here
  rules: {
    // allow async-await
    'generator-star-spacing': 'off',
    // allow debugger during development
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off'
  }
}
```