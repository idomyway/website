# Nuxt.js

> vue服务端渲染框架  

## 相关问题

#### 1、染服务器内容和客户端虚拟DOM不匹配

> 使用Nuxtjs时遇到的问题

```
[Vue warn]: The client-side rendered virtual DOM tree is not matching server-rendered content. This is likely caused by incorrect HTML markup, for example nesting block-level elements inside <p>, or missing <tbody>. Bailing hydration and performing full client-side render.
```

```javascript
/**
 * plugins/vue-carousel-card.js
 */
import Vue from 'vue'

export default () => {
  if (!process.browser) return false
  // 只有在客户端渲染时引入组件并注册，问题出在此处，服务端和客户端不一致
  const {
    CarouselCard,
    CarouselCardItem
  } = require('vue-carousel-card')
  Vue.component(CarouselCard.name, CarouselCard)
  Vue.component(CarouselCardItem.name, CarouselCardItem)
}
```

###### 解决方法（1）

> 使用<no-ssr></no-ssr>包裹该组件  

```pug
<template lang="pug">
no-ssr
  CarouselCard(:interval="7000" height="300px" type="card" arrow="always")
    CarouselCardItem(v-for="i in 6" :key="i")
      h1(v-text="i")
</template>
```

> 优点：方便快捷起效快，不需要对dependencies的vue组件，有特殊需求  
> 缺点：真的不会SSR

###### 解决方法（2）

> 不区分服务端渲染还是客户端，直接引入并注册组件，以Nuxtjs为例  

```javascript
/**
 * @/plugins/vue-carousel-card.js
 */
import Vue from 'vue'
import {
  CarouselCard,
  CarouselCardItem
} from 'vue-carousel-card'
import 'vue-carousel-card/styles/index.css'

export default () => {
  Vue.component(CarouselCard.name, CarouselCard)
  Vue.component(CarouselCardItem.name, CarouselCardItem)
}
/**
 * nuxt.config.js
 */
plugins: [
  '@/plugins/vue-carousel-card'
]
```

> 但这样又会出现新的问题  
> 如：window is not defined、document is not defined 等问题  
> 需要进行判断，如果在服务端的情况下不去执行使用window或者document的代码 

```javascript
// 部分代码示例（1）
import ResizeObserver from 'resize-observer-polyfill'

const isServer = typeof window === 'undefined'
const addResizeListener = el => {
  // 由于ResizeObserver中用到了document，此处直接跳过
  if (isServer) return
  el.__ro__ = new ResizeObserver(resizeHandler)
}

// 部分代码示例（2）
if(process && process.browser){
  // 判断是客户端再执行
  var FastClick = require('fastclick');
  FastClick.attach(document.body);
}
```

> **坑点**  
> 在.vue文件中的样式最后经过webpack打包成js文件，会用到document（作用是将样式插入到文档）  

```javascript
// 编译后的部分代码示例
function addStyle (obj /* StyleObjectPart */) {
  var update, remove
  var styleElement = document.querySelector('style[' + ssrIdKey + '~="' + obj.id + '"]')

  if (styleElement) {
    if (isProduction) {
      // has SSR styles and in production mode.
      // simply do nothing.
```

> 解决方法，将样式分离，单独引入  

> 优点：照样SSR  
> 缺点：对dependencies的vue组件有特殊要求  

#### 2、组件命名冲突导致内存溢出

> 错误信息  

```javascript
RangeError: Maximum call stack size exceeded
    at RegExp.[Symbol.replace] (<anonymous>)
    at String.replace (<anonymous>)
    at classify (commons.app.js:13279)
    at formatComponentName (commons.app.js:13317)
    at VueComponent.Vue._init (commons.app.js:17610)
    at new VueComponent (commons.app.js:17752)
    at createComponentInstanceForVnode (commons.app.js:15923)
    at init (commons.app.js:15754)
    at createComponent (commons.app.js:18576)
    at createElm (commons.app.js:18523)
```

> 相关vue组件代码，nuxt.js pages目录（相当于路由）  

```html
<template>
  <div>
    <!-- （3）此处使用组件 -->
    <List />
  </div>
</template>
<script>
// 引入组件
import List from '~/views/course/list'

export default {
  name: 'List', // （1）该组件名称为List
  components: { List } // （2）注册于该组件同名的组件
}
</script>
```

> 因为（1）为该组件名称，引入并注册（2）使用的组件与之同名，导致（3）处使用时，会默认获取当前组件，导致服务端渲染时内存溢出  

> 解决方法：该组件name属性和引用组件注册名称不能重名  

> tips: vue spa中不会导致内存溢出，如果注册组件和该组件name属性同名，优先调用该组件[vue文档-name属性](https://cn.vuejs.org/v2/api/#name)  