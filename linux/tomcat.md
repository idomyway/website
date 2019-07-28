# Tomcat（Linux环境下）

> 以Centos 7.4，Tomcat 8.5.43为例

#### 常用配置修改
```bash
# {tomcat-path}/config/server.xml
```
```xml
<!-- 修改默认端口 1 -->
<Server port="8005" shutdown="SHUTDOWN">
  <Service name="Catalina">
    <!-- 修改默认端口 2 -->
    <Connector port="8080" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8443" />
    <!-- 修改默认端口 3 -->
    <Connector port="8009" protocol="AJP/1.3" redirectPort="8443" />
    <Engine name="Catalina" defaultHost="localhost">
      <Host name="localhost"  appBase="webapps" unpackWARs="true" autoDeploy="true">
        <!-- <Context>代表了运行在<Host>上的单个Web应用
             一个<Host>可以有多个<Context>元素，每个Web应用必须有唯一的URL路径
             这个URL路径在<Context>中的属性path中设定。  -->
        <!-- path:指定访问该Web应用的URL入口。 -->
        <!-- docBase:指定Web应用的文件路径，可以给定绝对路径，也可以给定相对于<Host>的appBase属性的相对路径
             如果Web应用采用开放目录结构，则指定Web应用的根目录
             如果Web应用是个war文件，则指定war文件的路径。  -->
        <!-- reloadable:如果这个属性设为true
             tomcat服务器在运行状态下会监视在WEB-INF/classes和WEB-INF/lib目录下class文件的改动
             如果监测到有class文件被更新的，服务器会自动重新加载Web应用。
             在开发阶段将reloadable属性设为true，有助于调试servlet和其它的class文件，但这样用加重服务器运行负荷
             建议在Web应用的发存阶段将reloadable设为false。 -->
        <Context path="/{path}" docBase="/opt/{path-dir}" reloadable="true" />
      </Host>
    </Engine>
  </Service>
</Server>
```