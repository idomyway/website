# 禅道安装（Linux环境下）

> 以Centos 7.4，ZenTaoPMS.11.4.1 为例

```bash
# nginx中新建项目根目录html_zen_tao（和html同级）

# 配置nginx.conf
server {
    listen 8888;
    server_name 140.143.232.110;
    location / {
        root html_zen_tao;
        index index.php index.html index.htm;
    }
    location ~* \.php$ {
        fastcgi_index   index.php;
        fastcgi_pass    127.0.0.1:9000;
        include         fastcgi_params;
        # fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
        # 自定义项目根目录后需用绝对路径方式配置SCRIPT_FILENAME
        # 否则访问php文件会显示 No input file specified.
        fastcgi_param   SCRIPT_FILENAME    /opt/nginx/html_zen_tao/$fastcgi_script_name;  
        fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
    }
}

# 下载禅道项目管理软件源码 https://www.zentao.net/download/80131.html
# ZenTaoPMS.11.4.1.zip
# 解压到html_zen_tao
unzip ZenTaoPMS.11.4.1.zip

# 通过IP地址访问http://IP:PORT/zentaopms/www/index.php
# 根据提示进行安装
```

#### 常见问题

> PDO扩展、PDO_MySQL扩展、MBSTRING扩展 未加载  

```bash
# 修改配置文件
vim /etc/php.ini
# line.725，修改并添加
extension_dir = "/usr/lib64/php/modules"
extension=pdo_mysqlnd.so
extension=mbstring.so
extension=pdo.so

# 重启php-fpm
ps aux | grep php-fpm

kill -9 xxxx # 你懂得

/usr/sbin/php-fpm
```