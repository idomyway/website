# Node.js（Linux环境下）

> 以Centos 7.4，Node.js 10.15.3 二进制文件安装为例  

```bash
# 下载地址https://nodejs.org/en/download/
# 安装教程可参考https://github.com/nodejs/help/wiki/Installation

# 定义node版本
VERSION=v10.15.0
# 定义系统版本
DISTRO=linux-x64
# 创建安装目录
sudo mkdir -p /usr/local/lib/nodejs
# 解压到安装目录
sudo tar -xJvf node-$VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs 

# 修改profile
vim /etc/profile

# 末尾加入以下内容
# Nodejs
VERSION=v10.15.0
DISTRO=linux-x64
export PATH=/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH

# 刷新profile
source /etc/profile

# 检查
node -v
npm -v
```
