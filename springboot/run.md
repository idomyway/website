# 启动方式

#### jar包方式，直接启动

```xml
<!-- pom.xml 配置打包方式为jar -->
<packaging>jar</packaging>
```

> 相关脚本，linux，上传jar后可直接在项目根目录运行run.sh脚本  

```bash
<项目目录>
    ├─ <JAR NAME>.jar # 项目jar包
    ├─ run.sh         # 运行脚本，上传jar后可直接运行该脚本
    ├─ start.sh       # 启动脚本
    └─ stop.sh        # 停用脚本
```

> run.sh

```bash
#!/bin/bash
echo stop application
source stop.sh
echo start application
source start.sh
```

> start.sh，如需配置远程调试，[请参照](../ide/idea.md)  

```bash
nohup java -Xms256m -Xmx256m -jar <JAR NAME>.jar >/dev/null 2>&1 &
```

> stop.sh  

```bash
#!/bin/bash
PID=$(ps -ef | grep <JAR NAME>.jar | grep -v grep | awk '{ print $2 }')
if [ -z "$PID" ]
then
  echo Application is already stopped
else
  echo kill -9 $PID
  kill -9  $PID
fi
```