# Axios

> Axios 是一个基于promise的HTTP库，可以用在浏览器和node.js中。

#### 安装

```bash
yarn add axios

# or
npm i axios -S
```

#### 基本使用

```javascript
/**
 * 1、基础使用1
 * axios(config)
 * 2、基础使用2，url不在配置中指定
 * axios(url[, config])
 * 3、默认请求方法别名
 * 使用别名方法时， url、method、data 这些属性都不必在配置中指定。
 * axios.request(config)
 * axios.get(url[, config])
 * axios.delete(url[, config])
 * axios.head(url[, config])
 * axios.post(url[, data[, config]])
 * axios.put(url[, data[, config]])
 * axios.patch(url[, data[, config]])
 * 4、并发
 * axios.all(iterable)
 * axios.spread(callback)
 * 例：
 * let axiosList=[
 *    axios.get('url1', { params: 'xxx' }),
 *    axios.get('url2', { params: 'xxx' })
 * ]
 * axios.all(axiosList).then(axios.spread((res1,res2) => {
 *   console.log(res1,res2) // 分别是两个请求的返回值
 * })
 * 5、创建实例
 * axios.create([config])
 */

/**
 * promise方式
 */
function get () {
  axios.get('/user?ID=12345')
    .then(res => {
      console.log(res)
    })
    .catch(err => {
      console.log(err)
    })
}
function post () {
  axios.post('/user', {
      firstName: 'Fred',
      lastName: 'Flintstone'
    })
    .then(res => {
      console.log(res)
    })
    .catch(err => {
      console.log(err)
    })
}
/**
 * async/await方式
 */
async function gets () {
  try {
    let data1 = await axios.get('url1', { params: 'xxx' })
    let data2 = await axios.get('url2', { params: 'xxx' })
    console.log(data1, data2)
  } catch (error) {
    console.log(error)
  }
}
```

#### 常用配置

```javascript
import axios from 'axios'
import qs from 'qs'

/**
 * axios config
 */
// url 前缀
axios.defaults.baseURL = process.env.NODE_ENV === 'production' ? '/web/' : '/api/'
// 跨域请求时携带cookie
axios.defaults.withCredentials = true
/**
 * axios 默认 Content-Type: application/json;charset=UTF-8
 * 请求正文为Request Payload，格式是json格式的字符串
 * 台用@RequestParam是接收不到参数的，只能用@RequestBody
 * 配置transformRequest，参数使用qs转换
 * 请求头Content-Type会被设置为: application/x-www-form-urlencoded
 * 请求正文为Form Data，格式是key=value&key1=value2
 * 对于 Form Data 请求，后台无需任何注解，即可解析参数
 */
// 请求数据转json字符串（JSON.stringify()不行）
axios.defaults.transformRequest = [params => qs.stringify(params)]
// 请求统一额外参数
axios.defaults.params = { apiuser: 'debug' }
// 请求拦截器
axios.interceptors.request.use(config => {
  // 请求发出前，可以开始加载动画之类的操作
  return config
}, error => {
  // 请求发出错误处理
  return Promise.reject(error)
})
// 响应拦截器
axios.interceptors.response.use(response => {
  // 接收到响应处理，停止加载动画之类操作
  return response
}, error => {
  // 响应错误处理，统一异常处理
  console.log(error.stack)
  return Promise.reject(error)
})
```

#### 使用全局默认配置，特殊使用时配置

> 使用了上述全局配置之后，请求头Content-Type会被设置为: application/x-www-form-urlencoded
> 如果上传文件需要将Content-Type设置为multipart/form-data，具体使用如下所示

```javascript
/**
 * 使用axios上传文件，ajax文件上传
 */
// input(type="file" onchange="fileChange" multiple="multiple")
// 设置multiple可以选择多个文件
function fileChange (e) {
  // 获取文件对象数组
  let files = e.target.files
  // 创建一个FormData，存储需要提交的表单数据，如果通过ajax方式上传文件，必须使用FormData
  let formData = new FormData()
  // 普通表单数据
  formData.append('num', 123)
  formData.append('name', 'aa')
  // 文件数据
  formData.append('file', files[0])
  // 多个文件数据需要遍历放入
  for (let f of files) {
    formData.append('files', f)
  }
  // 上传data必须转为formData
  axios.post('/upload', formData, {
    // 覆盖默认设置中的transformRequest设置
    transformRequest: [(params, headers) => {
      // 请求头Content-Type 为multipart/form-data
      headers = {
        'Content-Type': 'multipart/form-data'
      }
      // 取消qs参数转换
      return params
    }],
    // 上传进度
    onUploadProgress ({ loaded, total }) {
      let p = (loaded / total * 100).toFixed(0) + '%'
      console.log(p)
    }
  }).then(res => console.log(res))
}
```
