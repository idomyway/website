# IDEA

#### 远程调试

> jar包方式启动java项目，可以使用idea进行远程调试  
> 1、远程服务器启动项目
> 2、IDEA run Debug \<REMOTE NAME>
> 3、IDEA 断点调试

```bash
nohup java -Xms256m -Xmx256m -jar -Xdebug -Xrunjdwp:transport=dt_socket,suspend=n,server=y,address=<PORT> <JAR NAME>.jar >/dev/null 2>&1 &  
```

```bash
# IDEA 设置
run -> Edit Configurations -> + -> Remote

Name: <REMOTE NAME>
Host: <IP>
Port: <PORT>
```
