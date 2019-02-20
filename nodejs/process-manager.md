# PM2（Process Manager 2）

> Node进程管理工具，简化Node App管理的繁琐任务，如性能监控、自动重启、负载均衡等。

#### 常用命令

```bash
# 启动app
pm2 start yarn --name AppName -- start

# 查看所有app
pm2 list
# or
pm2 ls

# 启动，all表示全部app，CMD表示命令（如：yarn），-i max 表示cluster模式，数量为最大cpu核数，--watch表示当文件变化时自动重启应用，args表示参数
pm2 start [id | AppName | all | CMD] --name [AppName] -i max --watch -- [args]

# 停止，all表示全部app
pm2 stop [id | AppName | all]

# 重启，相当于先 stop 再 start，会导致服务短时间内无法使用，all表示全部app
pm2 restart [id | AppName | all]

# 热重载，多用于cluster模式，逐个重新启动所有进程，始终保持至少一个进程在运行，实现不停机重载
pm2 reload [AppName]

# 删除，all表示全部app
pm2 delete [id | AppName | all]

# 监控
pm2 monit [id | AppName]

# 日志
pm2 logs
```

#### 常见错误

> windows系统常见错误（1）

```bash
# 报错信息
C:\USERS\<username>\APPDATA\ROAMING\NPM\YARN.CMD:1
(function (exports, require, module, __filename, __dirname) { @IF EXIST "%~dp0\node.exe" (
                                                              ^
SyntaxError: Invalid or unexpected token
    at new Script (vm.js:79:7)
    at createScript (vm.js:251:10)
    at Object.runInThisContext (vm.js:303:10)
    at Module._compile (internal/modules/cjs/loader.js:656:28)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:699:10)
    at Module.load (internal/modules/cjs/loader.js:598:32)
    at tryModuleLoad (internal/modules/cjs/loader.js:537:12)
    at Function.Module._load (internal/modules/cjs/loader.js:529:3)
    at Object.<anonymous> (C:\Users\wangdg\AppData\Local\Yarn\Data\global\node_modules\pm2\lib\ProcessContainerFork.js:27:21)
    at Module._compile (internal/modules/cjs/loader.js:688:30)
C:\USERS\<username>\APPDATA\ROAMING\NPM\YARN.CMD:1
(function (exports, require, module, __filename, __dirname) { @IF EXIST "%~dp0\node.exe" (

# 错误分析
在Windows上，yarn.cmd它不是有效的，您必须直接运行Node.js命令

# 解决方法
pm2 start C:\Users\<username>\AppData\Roaming\npm\node_modules\yarn\bin\yarn.js --name nuxt -- start
```



