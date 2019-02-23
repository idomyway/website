# Jenkins安装

> Jenkins安装前需先安装JDK，可参照[JDK安装及配置](/linux/jdk.md)

#### 安装

> 方式1，推荐

```bash
# 添加yum源
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# 导入密钥
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# 安装
sudo yum install -y jenkins
```

> 方式2，下载[离线安装包](https://jenkins.io/download/)安装
> 以Centos 7.4 为例，下载jenkins-2.150.3-1.1.noarch.rpm

```bash
rpm -ih jenkins-2.150.3-1.1.noarch.rpm
```

#### 修改java目录

```bash
vim /etc/init.d/jenkins

# 大约75行，添加java目录
candidates="
/home/jdk1.8.0_191/bin/java
...
"

# 保存后运行一下命令，重新加载
systemctl daemon-reload

# 启动
systemctl start jenkins
```

#### 开机启动

```bash
# 由于Jenkins不是Native Service，所以需要用chkconfig命令而不是systemctl命令
sudo /sbin/chkconfig jenkins on
```

#### 修改默认端口号

```bash
vim /etc/sysconfig/jenkins

# 大约56行，将默认端口8080修改即可
JENKINS_PORT="8765"

# 重启服务
systemctl restart jenkins
```