# Linux下JDK安装及配置

> 以Centos 7.4，JDK 1.8 为例

```bash
# 下载二进制压缩包https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
# jdk-8u201-linux-x64.tar.gz

# 解压
tar -xzvf jdk-8u191-linux-x64.tar.gz

# 修改profile
vim /etc/profile

# 最后面添加
export JAVA_HOME=/home/jdk1.8.0_191
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin

# 重新初始化profile
source /etc/profile

# 查看配置结果
java -version
```



