# VSCode

#### 配置

```javascript
{
    // 取消提示js装饰器的错误提示
    "javascript.implicitProjectConfig.experimentalDecorators": true,
    "explorer.autoReveal": false,
    "editor.fontSize": 18,
    "terminal.integrated.fontSize": 17,
    // 命令行工具，以git为例
    // "terminal.integrated.shell.windows": "C:\\Program Files\\Git\\bin\\bash.exe",
    "editor.tabSize": 2,
    "editor.multiCursorModifier": "ctrlCmd",
    "editor.snippetSuggestions": "top",
    "editor.formatOnPaste": true,
    "workbench.colorTheme": "Monokai",
    "workbench.startupEditor": "newUntitledFile",
    "workbench.sideBar.location": "left",
    "window.zoomLevel": 0,
    "breadcrumbs.enabled": false,
    // eslint 代码自动检查相关配置
    "eslint.enable": true,
    "eslint.run": "onType",
    "eslint.options": {
        "extensions": [
            ".js",
            ".vue",
            ".jsx"
        ]
    },
    "eslint.validate": [
        "javascriptreact",
        "vue",
        "javascript",
        {
            "language": "vue",
            "autoFix": true
        },
        "html",
        {
            "language": "html",
            "autoFix": true
        }
    ],
    // 不校验vue模版中的自定义标签使用闭合标签
    "vetur.validation.template": false,
    "workbench.iconTheme": "vscode-icons" /* ,
    // px转rem设置
    "px2rem.rootFontSize": 50,
    "px2rem.isNeedNotes": false */
}
```

#### 常用插件

```bash
# 中文
Chinese (Simplified) Language Pack for Visual Studio Code
# 编辑器代码格式化
EditorConfig for VS Code
# js格式校验
ESLint
# git忽略
gitignore
# css预编译stylus
language-stylus
# 路径自动补全
Path Intellisense
# react
Simple React Snippets
# sublime键位
Sublime Text Keymap
# vue
Vetur
# 资源管理器图标
vscode-icons
# () [] {} 匹配高亮区分，有版本2可用
Bracket Pair Colorizer
# flutter开发插件，自动安装dart插件
Flutter
# flutter 模版
Flutter Widget Snippets


# px2rem.rootFontSize 默认设计稿宽750px，默认使用iphone7 设备宽375px 开发，按照index.js[x]中的rem自适应计算方法为 50
# 详细配置查看该插件说明
px2rem
```

#### 部分快捷键配置

```bash
# 1、代码提示
# 原快捷键 Ctrl + space，与系统冲突，修改即可
# 文件 -> 首选项 -> 键盘快捷方式，搜索“触发建议”，修改为 Alt + / ，按enter键保存即可
```
