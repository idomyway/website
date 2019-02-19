# MySQL（Linux环境下）

> 以Centos 7.4，MySQL5.7.x为例

#### 安装

```bash
# 1、查看已安装的mysql
rpm -qa|grep -i mysql

# 2、删除之前版本
yum -y remove 已安装的名称
# 如：
yum -y remove mysql-community-client-5.6.38-2.el7.x86_64

# 3、更新源并安装
cd /home
wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
rpm -ivh mysql57-community-release-el7-11.noarch.rpm
yum -y install mysql-server

# 4、启动服务
systemctl start mysqld
```

#### 移动相关目录

> 移动data目录，log目录，相关操作（安装完需先启动mysql，生成数据库文件和log文件之后再进行移动操作）

```bash
# 停止服务
systemctl stop mysqld

# 创建目录
mkdir -p /home/mysql/data/

# 修改属主和属组
chown mysql.mysql /home/mysql/data

# 复制mysql data目录
cp -a /var/lib/mysql /home/mysql/data/

# 建立链接（如果更新data目录后无法启动适应链接的方式）
#ln -s /home/mysql/data/mysql /usr/lib/mysql

# 修改my.cfg
vim /etc/my.cnf
datadir=/home/mysql/data/mysql

# 复制mysql原有data目录可不修改此配置
#socket=/home/mysql/data/mysql/mysql.sock

# 创建目录
mkdir -p /home/mysql/logs

# 修改属主和属组
chown mysql.mysql /home/mysql/logs

# 移动log文件，-a带权限复制
cp -a /var/log/mysqld.log /home/mysql/logs

# 修改log目录
vim /etc/my.cnf
server_id=1
expire_logs_days=10
log-error=/home/mysql/logs/mysqld.log

# 启动mysql
systemctl stop mysqld

# 开启自动启动
systemctl enable mysqld
```

#### 创建用户、数据库，授权数据库权限，远程连接

```sql
-- 1、创建用户名，%代表可以远程连接
use mysql;
CREATE USER 'username'@'%' IDENTIFIED BY 'password';
-- 2、创建数据库
create database testdb;
-- 3、用户授权使用指定数据库的指定权限
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON testdb.* TO 'username'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```

#### 修改root密码

```bash
# 1、修改配置文件
vim /etc/my.cnf
# 增加
skip-grant-tables

# 2、重启mysql服务
systemctl restart mysqld

# 3、进入mysq命令行
mysql -uroot
# ERROR 2002 (HY000): Can’t connect to local MySQL server through socket ‘/var/lib/mysql/mysql.sock’ (2)
#mysql -uroot -S /home/mysql/data/mysql/mysql.sock

# 4、执行sql
use mysql;
SET SQL_SAFE_UPDATES = 0;
update mysql.user set authentication_string=password('root') where User='root';
flush privileges;
SET SQL_SAFE_UPDATES = 1;

# 5、修改配置文件
vim /etc/my.cnf
# 去掉
skip-grant-tables

# 6、重启mysql服务
systemctl restart mysqld

# 7、使用新密码进入mysql
mysql -uroot -p
# 输入密码进入
```

#### 常见错误

> ERROR 1820 \(HY000\): You must reset your password using ALTER USER statement before executin

```sql
-- 解决方法
-- 1、修改用户密码
alter user 'root'@'localhost' identified by 'youpassword';
-- 或者
set password=password("youpassword");

-- 2、刷新权限
flush privileges;
help contents;
```



