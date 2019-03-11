# http-server

> http-server是一个简单的，零配置的命令行http服务器。

#### 安装

```bash
npm install http-server -g

# or
yarn global add http-server
```

#### 使用

```
http-server [path] [options]
```

#### 可用选项

```
-p 要使用的端口（默认为8080）

-a 要使用的地址（默认为0.0.0.0）

-d 显示目录列表（默认为'True'）

-i 显示autoIndex（默认为'True'）

-g或者--gzip当启用时（默认为'False'），它将./public/some-file.js.gz代替./public/some-file.js当文件的gzip压缩版本存在且请求接受gzip编码时。

-e或者--ext如果没有提供默认文件扩展名（默认为'html'）

-s或者--silent从输出中抑制日志消息

--cors通过Access-Control-Allow-Origin标头启用CORS

-o 启动服务器后打开浏览器窗口

-c设置缓存控制max-age标头的缓存时间（以秒为单位），例如-c10为10秒（默认为“3600”）。要禁用缓存，请使用-c-1。

-U或--utc在日志消息中使用UTC时间格式。

-P或者将--proxy所有无法在本地解析的请求代理到给定的URL。例如：-P http://someurl.com

-S或--ssl启用https。

-C或--certssl cert文件的路径（默认值：cert.pem）。

-K或--keyssl密钥文件的路径（默认值：key.pem）。

-r或--robots提供/robots.txt（其内容默认为'User-agent：* \ nDisisis：/'）

-h或--help打印此列表并退出。
```



