# IDEA

#### 远程调试

> jar包方式启动java项目，可以使用idea进行远程调试  
> 1、远程服务器启动项目
> 2、IDEA run Debug \<REMOTE NAME>
> 3、IDEA 断点调试

```bash
nohup java -Xms256m -Xmx256m -jar -Xdebug -Xrunjdwp:transport=dt_socket,suspend=n,server=y,address=<PORT> <JAR NAME>.jar >/dev/null 2>&1 &  
```

```bash
# IDEA 设置
run -> Edit Configurations -> + -> Remote

Name: <REMOTE NAME>
Host: <IP>
Port: <PORT>
```

#### 常用插件

> File -> Settings -> Plugins

```bash
# 社区版Spring支持
Spring Assistant

# Flutter相关，自动安装Dart
Flutter

# JRebel IDEA上热部署
JRebel and XRebel for IntelliJ
# 破解
# 1、生成GUID：https://www.guidgen.com/
# 2、Help -> JRebel -> Activation -> Team URL分别填写
https://jrebel.qekang.com/<生成的GUID>
<邮箱>
# 3、 勾选协议，Activate JRebel
# 4、next enable JRebel -> I agree
# 5、重启IDEA，JRebel setup guide按照提示操作

# Mybatis扩展支持
Free Mybatis plugin
```

#### 常用设置

> 路径等配置

```bash
# 字体及大小
File -> Settings -> Editor -> Font
Font: Consolas
Size: 16
Line Spacing: 1.2

# Maven，使用本地Maven
File -> Settings -> Build, Execution, Deployment -> Build Tools -> Maven
Maven home directory: <选择本地Maven根目录>
User settings file: <勾选 Override，选择本地Maven中conf/setting.xml>

# JDK设置，一般系统会自动设置，无需手动设置
File -> Settings -> Build, Execution, Deployment -> Build Tools -> Maven -> Runner
JRE: <选择本地SDK>

# Flutter SDK路径设置，配置后，Dart会自动配置
File -> Settings -> Languages & Frameworks -> Flutter
Flutter SDK path: <选择本地Flutter根目录>

# 关闭Idea版本自动更新
File -> Settings -> Appearance & Behavior -> System Settings -> Updates
<取消选中 Automatically check updates for ...>

# 取消代码重复提示
File -> Settings -> Editor -> Inspections -> General -> Duplicated Code
<取消选中>

# 注释模版，java方法
File -> Settings -> Editor -> Live Templates
1、右侧 + 选择 Template Group
填写名字 <java comment template>
2、右侧 + 选择 Live Template
3、设置
（1）Abbreviation: <method comment>
（2）Description: <method comment>
（3）Template text:
*
 * $target$
 $param$
 * @return $return$
 */
（4）Expand with: <选择Enter>
（5）Edit variables:
param: groovyScript("def result=''; def params=\"${_1}\".replaceAll('[\\\\[|\\\\]|\\\\s]', '').split(',').toList(); for(i = 0; i < params.size(); i++) {if(i==0){result ='* @param ' + params[i] + ((i < params.size() - 1) ? '\\n' : '');}else{result +=' * @param ' + params[i] + ((i < params.size() - 1) ? '\\n' : '');}}; return result", methodParameters())
return: methodReturnType()

# 注释模版，java类
File -> Settings -> Editor -> File and Code Templates
1、选中Files -> Class
2、选择Includes -> File Header
/**
 * ${ClassName}
 * @author <用户名>
 * @since ${YEAR}-${MONTH}-${DAY} ${HOUR}:${MINUTE}:00
 */
```

> 快捷键

```bash
# 代码补全，Eclipse中Alt + /
File -> Settings -> Keymap -> Main menu -> Code -> Completion
Cyclic Expand Word: <右键，Remove Alt + />
Basic: <Add Keyboard Shutcut Alt + />
```