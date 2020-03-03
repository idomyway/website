# Chrome浏览器下载图片

```js
/**
 * src 图片链接
 * filename 下载图片命名
 * ext 图片格式，png jpg
 */
function downloadImg (src, filename, ext) {
  const img = new Image()
  const canvas = document.createElement('canvas')
  const ctx = canvas.getContext('2d')
  const link = document.createElement('a')
  img.setAttribute('crossOrigin', 'anonymous') // 设置允许跨域访问
  img.src = src
  img.onload = () => {
    canvas.width = img.width
    canvas.height = img.height
    ctx.drawImage(img, 0, 0, img.width, img.height)
    link.setAttribute('href', canvas.toDataURL('image/' + ext))
    link.setAttribute('target', '_blank')
    link.setAttribute('download', filename + '.' + ext)
    link.click()
  }
}
```