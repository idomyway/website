# Redis（Linux环境下）

> 以Centos 7.4，redis 5.0.x 为例  

#### 安装

```bash
# 下载压缩包https://redis.io/download
# /opt/redis-5.0.4.tar.gz
cd /opt

# 解压
tar -xzvf redis-5.0.4.tar.gz

# 编译
cd /opt/redis-5.0.4
make

# 安装
cd /opt/redis-5.0.4/src
make install PREFIX=/usr/local/redis

# 复制配置文件到安装目录
cp -a /opt/redis-5.0.4/redis.conf /usr/local/redis

# 修改配置
vim /usr/local/redis/redis.conf

bind 127.0.0.1              # line.69 注释掉
port <port>                 # line.92 修改默认端口
daemonize yes               # line.136 守护进程 yes
requirepass <your password> # line.507 设置密码
maxmemory <bytes>           # line.566 可使用最大内存，单位字节（bytes）
notify-keyspace-events Ex   # line.1066 键空间通知，过期事件的监听

# 创建软连接
ln -s /usr/local/redis/bin/* /usr/local/sbin/

# 启动服务
redis-server /usr/local/redis/redis.conf

# 开机自动启动，/etc/rc.local中加入
vim /etc/rc.local

redis-server /usr/local/redis/redis.conf
```

#### 测试连接

```bash
# 无密码
redis-cli

# 有密码
redis-cli -a <your password>

> ping
pong
```