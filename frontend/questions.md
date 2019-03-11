# 常见问题

#### 1、vue服务端渲，染服务器内容和客户端虚拟DOM不匹配

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
const addResizeListener = (el, fn) => {
  // 由于ResizeObserver中用到了document，此处直接跳过
  if (isServer) return
  el.__ro__ = new ResizeObserver(resizeHandler)

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
