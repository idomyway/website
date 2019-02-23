# Vue-Quill-Editor（自定义使用）

> 基于Vue的Quill富文本编辑器自定义toolbar  
> 1、图片拖拽上传服务器后，在文本区域内添加图片  
> 2、图片弹窗上传选择，在文本区域内添加图片  
> 3、将样式默认使用class的替换为内联样式  

```pug
<template lang="pug">
  div
    quillEditor(
      ref="editorRef"
      v-model="content"
      :options="editorOption"
      @change="onContentChange")
      div(:id="[toolbar]" slot="toolbar")
        span.ql-formats
          button.ql-bold(type="button")
        span.ql-formats
          button.ql-italic(type="button")
        span.ql-formats
          button.ql-underline(type="button")
        span.ql-formats
          button.ql-strike(type="button")
        span.ql-formats
          button.ql-blockquote(type="button")
        span.ql-formats
          button.ql-code-block(type="button")
        span.ql-formats
          button.ql-header(value="1" type="button")
        span.ql-formats
          button.ql-header(value="2" type="button")
        span.ql-formats
          button.ql-list(value="ordered" type="button")
        span.ql-formats
          button.ql-list(value="bullet" type="button")
        span.ql-formats
          button.ql-script(value="sub" type="button")
        span.ql-formats
          button.ql-script(value="super" type="button")
        //- 缩进无法使用内联样式代替class样式
        //span.ql-formats
          button.ql-indent(value="-1" type="button")
        //span.ql-formats
          button.ql-indent(value="+1" type="button")
        //span.ql-formats
          button.ql-direction(value="rtl" type="button")
        span.ql-formats
          //- 默认字体大小
          //select.ql-size
            option(value="small")
            option(selected)
            option(value="large")
            option(value="huge")
          //- 自定义字体大小，需对应修改js中SizeStyle.whitelist，以及相关样式
          select.ql-size
            option(value="12px") 12px
            option(selected) 14px
            option(value="16px") 16px
            option(value="18px") 18px
            option(value="20px") 20px
            option(value="22px") 22px
            option(value="24px") 24px
            option(value="26px") 26px
            option(value="28px") 28px
            option(value="30px") 30px
            option(value="32px") 32px
        span.ql-formats
          select.ql-header
            option(value="1")
            option(value="2")
            option(value="3")
            option(value="4")
            option(value="5")
            option(value="6")
            option(selected="selected")
        span.ql-formats
          select.ql-color
            option(selected="selected")
            option(value="#e60000")
            option(value="#ff9900")
            option(value="#ffff00")
            option(value="#008a00")
            option(value="#0066cc")
            option(value="#9933ff")
            option(value="#ffffff")
            option(value="#facccc")
            option(value="#ffebcc")
            option(value="#ffffcc")
            option(value="#cce8cc")
            option(value="#cce0f5")
            option(value="#ebd6ff")
            option(value="#bbbbbb")
            option(value="#f06666")
            option(value="#ffc266")
            option(value="#ffff66")
            option(value="#66b966")
            option(value="#66a3e0")
            option(value="#c285ff")
            option(value="#888888")
            option(value="#a10000")
            option(value="#b26b00")
            option(value="#b2b200")
            option(value="#006100")
            option(value="#0047b2")
            option(value="#6b24b2")
            option(value="#444444")
            option(value="#5c0000")
            option(value="#663d00")
            option(value="#666600")
            option(value="#003700")
            option(value="#002966")
            option(value="#3d1466")
        span.ql-formats
          select.ql-background
            option(value="#000000")
            option(value="#e60000")
            option(value="#ff9900")
            option(value="#ffff00")
            option(value="#008a00")
            option(value="#0066cc")
            option(value="#9933ff")
            option(selected="selected")
            option(value="#facccc")
            option(value="#ffebcc")
            option(value="#ffffcc")
            option(value="#cce8cc")
            option(value="#cce0f5")
            option(value="#ebd6ff")
            option(value="#bbbbbb")
            option(value="#f06666")
            option(value="#ffc266")
            option(value="#ffff66")
            option(value="#66b966")
            option(value="#66a3e0")
            option(value="#c285ff")
            option(value="#888888")
            option(value="#a10000")
            option(value="#b26b00")
            option(value="#b2b200")
            option(value="#006100")
            option(value="#0047b2")
            option(value="#6b24b2")
            option(value="#444444")
            option(value="#5c0000")
            option(value="#663d00")
            option(value="#666600")
            option(value="#003700")
            option(value="#002966")
            option(value="#3d1466")
        span.ql-formats
          //- 默认字体
          //select.ql-font
            option(selected="selected")
            option(value="serif")
            option(value="monospace")
          //- 自定义字体，需对应修改js中FontStyle.whitelist，以及相关样式
          select.ql-font
            option(selected="selected")
            option(value="宋体") 宋体
            option(value="黑体") 黑体
            option(value="楷体") 楷体
            option(value="微软雅黑") 微软雅黑
            option(value="Arial") Arial
            option(value="Verdana") Verdana
            option(value="Georgia") Georgia
            option(value="Times New Roman") Times New Roman
            option(value="Microsoft JhengHei") Microsoft JhengHei
            option(value="Trebuchet MS") Trebuchet MS
            option(value="Courier New") Courier New
            option(value="Impact") Impact
            option(value="Comic Sans MS") Comic Sans MS
            option(value="Consolas") Consolas
        span.ql-formats
          select.ql-align
            option(selected="selected")
            option(value="center")
            option(value="right")
            option(value="justify")
        span.ql-formats
          button.ql-clean(type="button")
        span.ql-formats
          button.ql-link(type="button")
        span.ql-formats
          //- 自定义图片选择器
          button(type="button" @click="imgModal = true")
            svg(viewBox="0 0 18 18")
              rect.ql-stroke(height="10" width="12" x="3" y="4")
              circle.ql-fill(cx="6" cy="7" r="1")
              polyline.ql-even.ql-fill(points="5 12 5 11 7 9 8 10 11 7 13 9 13 12 5 12")
        span.ql-formats
          button.ql-video(type="button")
    //- 使用iview modal
    Modal(
      v-model="imgModal"
      title="选择图片"
      :mask-closable="false")
      div
        div(style="text-align: center")
          input(
            ref="imgFileRef"
            type="file"
            style="display: none !important"
            :accept="accept"
            @change="fileChange")
          div(
            ref="imgRef"
            :style="`display: inline-block; width: 300px; height: 180px; border: 2px dashed; position: relative; border-color: ${ isDropImgOver ? '#666' : '#CCC' }`"
            @click="$refs.imgFileRef.click()")
            Progress(
              v-if="percent > 0 && percent < 100"
              style="position: absolute; top: 75px"
              :percent="percent"
              hide-info)
            img(
              v-if="imgUrl"
              style="width: 100%; height: 100%"
              :src="imgUrl")
            img(
              v-else
              style="width: 100%; height: 100%"
              src="@images/img.png")
          p(style="padding: 6px 0; color: #777") 点击或拖拽图片到上方区域上传图片，或者在下方输入图片链接上传图片
        div
          Input(
            v-model="netImgUrl"
            style="width: 80%"
            placeholder="请输入图片链接获取网络图片")
          Button(
            type="info"
            icon="earth"
            @click="imgUrl = netImgUrl"
            style="float: right"
            :disabled="!netImgUrl") 网络获取
      div(slot="footer")
        Button(type="primary" @click="insertImg") 确认
        Button(@click="imgModal = false") 取消
</template>
```
```javascript
<script>
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'
import _Quill from 'quill'
import { quillEditor } from 'vue-quill-editor'

// 默认图片类型
const allowType = {
  '.png': 'image/png',
  '.jpg': 'image/jpeg'/* ,
  '.jpeg': 'image/jpeg',
  '.bmp': 'image/bmp',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.tif': 'image/tiff' */
}

/**
 * 对Quill的自定义修改
 */
const Quill = window.Quill || _Quill
// 将样式默认使用class的替换为内联样式
let SizeStyle = Quill.import('attributors/style/size')
let FontStyle = Quill.import('attributors/style/font')
let AlignStyle = Quill.import('attributors/style/align')
// 自定义字体大小尺寸，需对应修改html中下拉框，以及相关样式
SizeStyle.whitelist = ['12px', '16px', '18px', '20px', '22px', '24px', '26px', '28px', '30px', '32px']
// 自定义字体类型，需对应修改html中下拉框，以及相关样式
FontStyle.whitelist = ['宋体', '黑体', '楷体', '微软雅黑', 'Arial', 'Verdana', 'Georgia', 'Times New Roman', 'Microsoft JhengHei', 'Trebuchet MS', 'Courier New', 'Impact', 'Comic Sans MS', 'Consolas']
Quill.register(SizeStyle, true)
Quill.register(FontStyle, true)
Quill.register(AlignStyle, true)

export default {
  name: 'Editor',
  components: { quillEditor },
  props: { value: String, placeholder: String },
  data () {
    return {
      content: this.value,
      toolbar: '',
      imgModal: false,
      imgUrl: '',
      netImgUrl: '',
      isDropImgOver: false
    }
  },
  computed: {
    editor () { return this.$refs.editorRef.quill },
    accept () { return Object.keys(allowType).join(',') },
    editorOption () {
      // 解决同一个组件中出现多个富文本id冲突的问题
      let id = 'toolbar-' + Math.random().toString(16).substring(2)
      this.toolbar = id // eslint-disable-line
      return {
        placeholder: this.placeholder,
        modules: {
          toolbar: '#' + id
        }
      }
    }
  },
  watch: {
    value (val) {
      if (this.editor && val !== this.content) this.content = val
    },
    modal (val) {
      if (!val) {
        this.imgUrl = ''
        this.netImgUrl = ''
      }
    }
  },
  mounted () {
    this.$nextTick(() => {
      /**
       * 拖拽上传图片并插入富文本
       */
      // 获取quillEditor中的editor
      let editor = this.$refs.editorRef.$refs.editor
      editor.ondragenter = e => this.dropInsertHandler(e)
      editor.ondragover = e => this.dropInsertHandler(e)
      editor.ondragleave = e => this.dropInsertHandler(e)
      editor.ondrop = e => {
        const files = e.dataTransfer.files
        if (files && files.length > 0) {
          this.fileUpload(files[0], this.insertImg)
        }
        this.dropInsertHandler(e, false)
      }
    })
  },
  methods: {
    fileUpload (file, callback) {
      // 判断格式
      // 判断大小
      // ...

      // 上传图片并返回图片访问url
      // this.imgUrl = imgUrl
      // callback && callback()
    },
    insertImg () {
      if (this.imgUrl) {
        this.editor.focus()
        this.editor.insertEmbed(this.editor.getSelection().index, 'image', this.imgUrl)
        this.modal = false
      } else alert('没有可用的图片！')
    },
    onContentChange () {
      this.$emit('input', this.content)
    },
    fileChange ({ target: { files } }) {
      if (files && files.length > 0) {
        this.fileUpload(files[0])
      }
    },
    dropInsertHandler (e) {
      e.preventDefault() // 阻止离开时的浏览器默认行为
      e.stopPropagation() // 阻止冒泡
    }
  }
}
</script>
```
```stylus
<style lang="stylus">
.ql-container
  font-size 14px
.ql-snow
  .ql-picker
    &.ql-size
      .ql-picker-item
        &[data-value="12px"]::before
          font-size 12px
        &[data-value="16px"]::before
          font-size 16px
        &[data-value="18px"]::before
          font-size 18px
        &[data-value="20px"]::before
          font-size 20px
        &[data-value="22px"]::before
          font-size 22px
        &[data-value="24px"]::before
          font-size 24px
        &[data-value="26px"]::before
          font-size 26px
        &[data-value="28px"]::before
          font-size 28px
        &[data-value="30px"]::before
          font-size 30px
        &[data-value="32px"]::before
          font-size 32px
    &.ql-font
      .ql-picker-item
        &[data-value="宋体"]::before
          font-family '宋体'
        &[data-value="黑体"]::before
          font-family '黑体'
        &[data-value="楷体"]::before
          font-family '楷体'
        &[data-value="微软雅黑"]::before
          font-family '微软雅黑'
        &[data-value="Arial"]::before
          font-family 'Arial'
        &[data-value="Verdana"]::before
          font-family 'Verdana'
        &[data-value="Georgia"]::before
          font-family 'Georgia'
        &[data-value="Times New Roman"]::before
          font-family 'Times New Roman'
        &[data-value="Microsoft JhengHei"]::before
          font-family 'Microsoft JhengHei'
        &[data-value="Trebuchet MS"]::before
          font-family 'Trebuchet MS'
        &[data-value="Courier New"]::before
          font-family 'Courier New'
        &[data-value="Impact"]::before
          font-family 'Impact'
        &[data-value="Comic Sans MS"]::before
          font-family 'Comic Sans MS'
        &[data-value="Consolas"]::before
          font-family 'Consolas'
</style>
```