# Linux下JDK配置

```bash
# 修改profile
vim /etc/profile

# 最后面添加
export JAVA_HOME=/home/jdk1.8.0_191
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin

# 重新初始化profile
source /etc/profile
```



