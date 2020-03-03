# 小程序授权相关

> openid 用户唯一标识，小程序、公众号等，每个应用唯一，不同应用中不相同  
> unionid 同平台下相等，小程序、公众号、App等，需绑定到同一开放平台下  
> session_key 会话密钥，解析小程序中 encryptedData, iv  
>  
> 注意：auth.code2Session 凭证校验时，一定能获取的值 openid, session_key  
> unionid 需要满足[特定条件](https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/union-id.html)才能直接获取  
> 否则需要通过 session_key 解析 encryptedData, iv 获取  

#### 问题描述

> 特殊性情况下，如：新账号首次注册、已注册账号首次登录等，使用 session_key 解析 encryptedData, iv 失败，无法获取 unionid  
> 
> 原因：  
> 小程序端需要先 wx.login 获取 code，然后通过 wx.getUserInfo 获取 encryptedData, iv  
> 如果使用小程序 Button 的 getUserInfo 提示用户授权登录 则无法先调用 wx.login 获取 code  
>   
> 解决办法：在授权登录页面 onLoad 生命周期中调用 wx.login 获取 code  
> 由于 code 默认[有效时间](https://developers.weixin.qq.com/miniprogram/dev/api/open-api/login/wx.login.html)为5分钟，应该设置定时任务，每 4 分钟调用 wx.login 更新 code  

```javascript
/** 部分代码示例 **/
// wxml
<button open-type="getUserInfo" bindgetuserinfo="getUserInfo">获取用户信息</button>
// js
Page({
  data: {
    code: '',
    timer: undefined
  },
  onLoad () {
    this.getCodeFunc()
    var timer = setInterval(this.getCodeFunc, 4 * 60 * 1000)
    this.setData({ timer })
  },
  onUnload () {
    this.timer && clearInterval(this.timer)
  },
  getCodeFunc () {
    var _this = this
    wx.login({
      success (res) {
        if (res.code) {
          _this.setData({
            code: res.code
          })
        }
      }
    })
  },
  getUserInfo (e) {
    var encryptedData = e.detail.encryptedData
    var iv = e.detail.iv
    this.doLoginRequest(encryptedData, iv, this.code)
  },
  doLoginRequest (encryptedData, iv, code) {
    // TODO login request
  }
})
```