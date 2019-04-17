# PHP（Linux环境下）

> 以Centos 7.4，PHP 7.1.x 为例  

#### 安装

```bash
# 配置源
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

# 安装php71w和各种拓展
yum -y install php71w php71w-cli php71w-common php71w-devel php71w-embedded php71w-fpm php71w-gd php71w-mbstring php71w-mysqlnd php71w-opcache php71w-pdo php71w-xml

# 测试
php -v
```

#### 支持nginx HTTP服务

> nginx linux环境安装，请[参照](./nginx.md)

```bash
# 修改配置文件
vim /etc/php.ini
# line.762 取消注释，修改为0
cgi.fix_pathinfo=0

# 启动fpm服务
/usr/sbin/php-fpm

# 开机自动启动，/etc/rc.local中加入
vim /etc/rc.local

/usr/sbin/php-fpm

# nginx配置

location / {
    root   html;
    index  index.php index.html index.htm;
}

location ~* \.php$ {
    fastcgi_index   index.php;
    fastcgi_pass    127.0.0.1:9000;
    include         fastcgi_params;
    fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
    fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
}

# 重启nginx
nginx -s reload

# 测试
rm /home/nginx/html/index.html
echo "<?php phpinfo(); ?>" >> /home/nginx/html/index.php

# 使用浏览器打开，会显示 phpinfo() 
```