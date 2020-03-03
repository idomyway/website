# EditorConfig

> 项目根目录中添加.editorconfig文件，并在开发工具中安装相应插件，如：VSCode安装EditorConfig for Visual Studio Code

```bash
# editorconfig.org
root = true

[*]
indent_style = space
indent_size = 2
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true

# markdown文件不去掉结尾空格
[*.md]
trim_trailing_whitespace = false
```



