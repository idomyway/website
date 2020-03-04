# Android构建

#### 1、检查 App Manifest

> 查看默认应用程序清单文件(位于```<app dir>/android/app/src/main/```中的```AndroidManifest.xml```文件)，并验证这些值是否正确，特别是：

* ```application```: 编辑 ```application``` 标签，这是应用的名称。
  ```xml
  <!-- 
    android:usesCleartextTraffic="true" -> android 8 及以后 http/https问题
    android:label="netease_cloud_music" -> 安装后app名字
    android:icon="@mipmap/ic_launcher" -> 安装后app图标，修改图标文件(位于\<app dir>/android/app/src/main/res中的各尺寸图标文件)
  -->
  <application
      android:name="io.flutter.app.FlutterApplication"
      android:label="netease_cloud_music"
      android:icon="@mipmap/ic_launcher"
      android:usesCleartextTraffic="true">
    <!-- activity等 -->
  </application>
  ```
* ```uses-permission```: 权限配置。如果您的应用程序代码不需要Internet访问，请删除```android.permission.INTERNET```权限。标准模板包含此标记是为了启用Flutter工具和正在运行的应用程序之间的通信。
  ```xml
  <!-- 网络请求权限 -->
  <uses-permission android:name="android.permission.INTERNET"/>
  ```

#### 2、查看构建配置

> 查看默认[Gradle 构建文件][gradlebuild]”build.gradle”，它位于```<app dir>/android/app/```，验证这些值是否正确，尤其是：

* ```defaultConfig```:
  * ```applicationId```: 指定始终唯一的 (Application Id)appid。
  * ```versionCode``` & ```versionName```: 指定应用程序版本号和版本号字符串。
  * ```minSdkVersion``` & ```targetSdkVersion```: 指定最低的API级别以及应用程序设计运行的API级别。

#### 4、添加启动图标、启动页

###### 图标

> 当一个新的Flutter应用程序被创建时，它有一个默认的启动器图标。要自定义此图标：

1、图标尺寸：
  drawable-mdpi-icon: 48 x 48  
  drawable-hdpi-icon: 72 x 72  
  drawable-xhdpi-icon: 96 x 96  
  drawable-xxhdpi-icon: 144 x 144  
  drawable-xxxhdpi-icon: 192 x 192  
2、在```<app dir>/android/app/src/main/res/```目录中，将图标文件放入使用配置限定符命名的文件夹中。默认```mipmap-```文件夹演示正确的命名约定。  
3、在```AndroidManifest.xml```中，将```application```标记的```android:icon```属性更新为引用上一步中的图标（例如 ```<application android:icon="@mipmap/ic_launcher" ...```）。  
4、要验证图标是否已被替换，请运行您的应用程序并检查应用图标。  

###### 启动页

> 启动页配置(位于```<app dir>/android/app/src/main/res/drawable/```中的```launch_background.xml```文件)

图片尺寸，竖屏：高 x 宽，横屏：宽 x 高  
drawable-port-mdpi-screen: 480 x 320  
drawable-port-hdpi-screen: 800 x 480  
drawable-port-xhdpi-screen: 1280 x 720  
drawable-port-xxhdpi-screen: 1600 x 960  
drawable-port-xxxhdpi-screen: 1920 x 1280  

```xml
<?xml version="1.0" encoding="utf-8"?>
<!-- Modify this file to customize your launch splash screen -->
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- <item android:drawable="@android:color/white" /> -->
    <!-- You can insert your own image assets here -->
    <item>
        <bitmap android:src="@mipmap/launch_image" />
    </item>
</layer-list>
```

#### 5、app签名

###### （1）创建 keystore

如果您有现有keystore，请跳至下一步。如果没有，请通过在运行以下命令来创建一个：
```bash
# -keystore 生成目录记名字
# -keyalg 加密和数字签名的算法
# -keysize 密钥长度
# -validity 有效天数
# -alias 别名，名称最好与前面-alias的参数保持一致

keytool -genkey -v -keystore ~/appkeystore.jks -keyalg RSA -keysize 2048 -validity 20000 -alias appkeystore

# next 提示输入 “ 密钥库 ” 密码、确认密码
# next 提示输入名字姓氏、组织单位名称、组织名称、城市区域名称、省、国家
# next 提示是否正确，输入 y
# next 提示输入 “ 密钥 ” 密码、确认密码，如果和上面 “ 密钥库 ” 密码相同，直接摁回车键
```

注意：保持文件私密; 不要将它加入到公共源代码控制中。  
注意: keytool可能不在你的系统路径中。它是Java JDK的一部分，它是作为Android Studio的一部分安装的。  

###### （2）引用应用程序中的keystore

创建一个名为```<app dir>/android/key.properties```的文件，其中包含对密钥库的引用：

```
storePassword=<密钥库 密码>
keyPassword=<密钥 密码>
keyAlias=appkeystore
storeFile=<key store 文件路径, 如： /Users/<user name>/appkeystore.jks>
```

注意: 保持文件私密; 不要将它加入公共源代码控制中

###### （3）在gradle中配置签名

通过编辑```<app dir>/android/app/build.gradle```文件为您的应用配置签名

1、替换：
```
android {
```
为：
```
def keystorePropertiesFile = rootProject.file("key.properties")
def keystoreProperties = new Properties()
keystoreProperties.load(new FileInputStream(keystorePropertiesFile))

android {
```

2、替换：
```
buildTypes {
    release {
        // TODO: Add your own signing config for the release build.
        // Signing with the debug keys for now, so `flutter run --release` works.
        signingConfig signingConfigs.debug
    }
}
```
为：
```
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile file(keystoreProperties['storeFile'])
        storePassword keystoreProperties['storePassword']
    }
}
buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```
应用的release版本将自动进行签名。

#### 5、开启混淆

> 默认情况下 flutter 不会开启 Android 的混淆。
> 如果使用了第三方 Java 或 Android 库，也许你想减小 apk 文件的大小或者防止代码被逆向破解。

###### （1）配置混淆

创建 ```/android/app/proguard-rules.pro``` 文件，并添加以下规则：

```
#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
```
上述配置只混淆了 Flutter 引擎库，任何其他库（比如 Firebase）需要添加与之对应的规则。

###### （2）开启混淆/压缩

打开 ```/android/app/build.gradle``` 文件，定位到 buildTypes 块。  
在 ```release```  配置中将 ```minifyEnabled```  和 ```useProguard```  设为 ```true```，再将混淆文件指向上一步创建的文件。  

```json
android {

    ...

    buildTypes {

        release {
            signingConfig signingConfigs.release
            // 压缩，默认启用
            minifyEnabled true
            // Gradle 3.4.0之后默认启用R8，3.2.0之前版本默认ProGuard
            // useProguard true
            // 启用资源压缩
            shrinkResources true
            // 压缩规则
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
}
```

注意：~~开启压缩 ```minifyEnabled true``` 可能会导致无法打包，暂时不启用压缩。~~ 貌似自v1.12.13版本已解决

#### 7、构建一个发布版（release）APK

使用命令行:

1、```cd <app dir>``` (```<app dir>``` 为您的工程目录).  
2、运行```flutter build apk``` (```flutter build``` 默认会包含 ```--release```选项).  

打包好的发布APK位于```<app dir>/build/app/outputs/apk/app-release.apk```。