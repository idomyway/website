# yarn

> 快速、可靠、安全的依赖管理工具。  
> 比npm好用 0_0  

#### 安装

```bash
# 使用npm安装
npm i -g yarn

# 使用npm升级yarn
npm update -g yarn
```

>  相关问题及解决方案  

```bash
# 可能会安装失败，原因基本都是权限问题
# MacOS / Linux
sudo npm i -g yarn

# windows可以使用管理员权限启动的命令行

# 检查
yarn -v

# 如果出现找不到该命令的问题，需要配置全局环境变量
# 该问题多出现在windows系统
# 环境变量中增加npm安装的全局工具的路径
# windows
C:\Users\<%用户名%>\AppData\Roaming\npm

# yarn安装的全局工具不能用的问题
# 该问题多出现在windows系统
# 环境变量中增加yarn安装的全局工具的bin路径
# windows
C:\Users\<%用户名%>\AppData\Local\Yarn\bin
```

#### 常用命令

> 以安装react和http-server为例  

|npm|yarn|
|--:|:---|
| npm i | yarn |
| npm i react -S | yarn add react |
| npm uninstall react -S | yarn remove react |
| npm i react -D | yarn add react -D |
| npm update react -S | yarn upgrade react |
| npm i -g http-server | yarn global add http-server |
| npm update -g http-server | yarn global upgrade http-server |

> 注意：yarn全局安装关键字global必须跟在yarn关键字后面，否则会安装global  