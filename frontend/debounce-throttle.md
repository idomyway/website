# 函数防抖(debounce)、函数节流(throttle)

#### 函数防抖(debounce)

> 介绍：当调用动作n毫秒后，才会执行该动作，若在这n毫秒内又调用此动作则将重新计算执行时间  
> 场景：实时搜索（keyup）、拖拽（mousemove）  

```javascript
/**
 * 未防抖
 * -------------------------
 * ^^^^^^^^^^^^^^^^^^^^^^^^^
 * 防抖
 * -------------------------
 *                         ^
 */
// ES6常用实现
const debounce = (fn, delay = 1000) => {
  let timer = undefined
  return () => {
    timer && clearTimeout(timer)
    timer = setTimeout(() => {
      fn && fn()
    }, delay)
  }
}

// 使用
window.onscroll = debounce(() => {
  console.log(document.documentElement.scrollTop)
}, 500)
```

#### 函数节流(throttle)

> 介绍：预先设定一个执行周期，当调用动作的时刻大于等于执行周期则执行该动作，然后进入下一个新周期  
> 窗口调整（resize）、页面滚动（scroll）、抢购疯狂点击（mousedown）  

```javascript
/**
 * 未节流
 * -------------------------
 * ^^^^^^^^^^^^^^^^^^^^^^^^^
 * 节流
 * -------------------------
 * ^   ^   ^   ^   ^   ^   ^
 */
/**
 * ES6常用实现（1） -- 基于时间间隔
 * 触发第一次，如需触发结束后时间间隔需加else setTimeout
 */
// 基础版
const throttle = (fn, delay = 100) => {
  let last = 0
  return () => {
    let now = Date.now()
    if (now - last >= delay) {
      fn && fn()
      last = now
    }
  }
}
// 触发结束后时间间隔
const throttle = (fn, delay = 100) => {
  let last = 0
  let timer = undefined
  return () => {
    let now = Date.now()
    timer && clearTimeout(timer)
    if (now - last >= delay) {
      fn && fn()
      last = now
    } else {
      timer = setTimeout(() => {
        fn && fn()
      }, delay)
    }
  }
}
/**
 * ES6常用实现（2） -- 基于setTimeout
 * 不会触发第一次
 */
const throttle = (fn, delay = 100) => {
  let timer = undefined
  return () => {
    if (timer) {
      return false
    } else {
      timer = setTimeout(() => {
        fn && fn()
        clearTimeout(timer)
        timer = undefined
      }, delay)
    }
  }
}

// 使用
window.onscroll = throttle(() => {
  console.log(document.documentElement.scrollTop)
}, 1000)
```