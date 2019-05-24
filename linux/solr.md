# Solr（Linux环境下）

> 以Centos 7.4，solr 8.1 为例  

#### 安装

```bash
# 下载压缩包http://lucene.apache.org/solr/mirrors-solr-latest-redir.html
# /opt/solr-8.1.0.tgz
cd /opt

# 解压
tar -xzvf solr-8.1.0.tgz

# 创建core
cd /opt/solr-8.1.0/server/solr/configsets
cp -r _default ../
mv _default <core name>

# 创建软连接
ln -s /opt/solr-8.1.0/bin/solr /usr/local/sbin/

# 启动服务 start：启动服务；stop：停止服务；restart：重启服务 -p 自定义端口 -m 内存
solr start -p 8398 -force -m 1g

# 开机自动启动，/etc/rc.local中加入
vim /etc/rc.local

solr start -p 8398 -force -m 1g
```

#### 使用

> 基本使用  

```bash
# 访问 http://<ip>:8398/solr

# 菜单 -> Core Admin

# 添加core，名字为上一步文件夹名（core name）
```

> 添加hanlp-lucene-plugin插件，中文分词器，分词插件  

```bash
# https://github.com/hankcs/hanlp-lucene-plugin
# 下载jar包hanlp-portable-1.7.3.jar、hanlp-lucene-plugin-1.1.6.jar

# 添加jar包到
cd /opt/solr-8.1.0/server/solr-webapp/webapp/WEB-INF/lib

# 修改配置文件
cd /opt/solr-8.1.0/server/solr/<core name>/conf
vim managed-schema

# 末尾<schema></schema>标签内增加相关配置
<fieldType name="text_cn" class="solr.TextField">
    <analyzer type="index">
        <tokenizer class="com.hankcs.lucene.HanLPTokenizerFactory" enableIndexMode="true"/>
    </analyzer>
    <analyzer type="query">
        <!-- 切记不要在query中开启index模式 -->
        <tokenizer class="com.hankcs.lucene.HanLPTokenizerFactory" enableIndexMode="false"/>
    </analyzer>
</fieldType>
<!-- 业务系统中需要分词的字段都需要指定type为text_cn -->
<field name="my_field1" type="text_cn" indexed="true" stored="true"/>
<field name="my_field2" type="text_cn" indexed="true" stored="true"/>

# 重启solr服务
```

#### 相关问题

```bash
# *** [WARN] ***  Your Max Processes Limit is currently 7270. 
# It should be set to 65000 to avoid operational disruption. 
# If you no longer wish to see this warning, set SOLR_ULIMIT_CHECKS to false in your profile or solr.in.sh
# WARNING: Starting Solr as the root user is a security risk and not considered best practice. Exiting.
#         Please consult the Reference Guide. To override this check, start with argument '-force'

# 启动时后面加参数-force
solr start -p 8398 -force -m 1g
```