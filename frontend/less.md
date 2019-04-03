# LESS

> css预处理语言  

### 相关问题

#### 1、less@3.x.x之后的版本，less中使用javascript报错

> 升级less到3.x.x的版本之后报错  

```
// https://github.com/ant-design/ant-motion/issues/44
.bezierEasingMixin();
^
Inline JavaScript is not enabled. Is it set in your options?
      in D:\vscode\iview-admin\node_modules\iview\src\styles\color\bezierEasing.less (line 110, column 0)
```

> 解决方法：开启javascript即可  

```json
{
  loader: "less-loader",
  options: {
    javascriptEnabled: true
  }
}
```

```javascript
/**
 * vue-cli@3.x.x中解决方法，vue.config.js文件
 */
module.exports = {
  css: {
    loaderOptions: {
      less: {
        javascriptEnabled: true
      }
    }
  }
}
```