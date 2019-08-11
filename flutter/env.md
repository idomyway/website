# Flutter 环境安装配置

#### MaxOS系统

> 1、安装 Flutter sdk （包含 dart sdk）  

```bash
# https://flutter.dev/docs/get-started/install/macos
# 下载并解压，将 flutter 文件夹复制到 /Users/<username>/Programs/ 目录下

# 配置 .bash_profile
FLUTTER_HOME=/Users/<username>/Programs/flutter
PATH=$PATH:$FLUTTER_HOME/bin
export PATH
```

> 2、安装 XCode，直接从 AppStore 下载安装  

> 3、执行命令切换默认XCode  

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

> 4、安装 brew  

```bash
# 切换到下载目录
cd /Users/<username>/Downloads

# 生成 brew 安装文件
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install >> brew_install

# 编辑 brew_install
# 将 line.9 (新版本好像没有 CORE_TAP_REPO，则略过)
BREW_REPO = "https://github.com/Homebrew/brew".freeze
CORE_TAP_REPO = "https://github.com/Homebrew/homebrew-core".freeze 
# 替换为
BREW_REPO = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git".freeze
CORE_TAP_REPO = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git".freeze

# 执行脚本安装
/usr/bin/ruby brew_install

# 安装完后删除 brew_install 文件
rm brew_install
```

> 5、安装 cocoapods  

```bash
# brew install 安装前会 Updating Homebrew，速度很慢
# 替换镜像源
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

# 安装
brew install cocoapods

# 执行命令，此步骤速度很慢
pod setup
# 使用清华大学开源镜像，该步骤解决 pod setup 速度慢的问题
cd ~/.cocoapods/repos 
pod repo remove master
git clone https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git master
# 工程的podFile第一行加上 ? 未使用，作用未知，运行 flutter doctor 命令成功
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
```

> 6、安装 IOS tools

```bash
brew update

brew install --HEAD usbmuxd

brew link usbmuxd

brew install --HEAD libimobiledevice

brew install ideviceinstaller

brew install ios-deploy
```

> 7、安装Android Studio，创建安装虚拟设备 AVD  

```bash
# 直接下载安装即可 Android Studio

# 注意mac上可能会提示 Android Studio 使用系统日历隐私，不授权可能无法完成初始化配置

# 完成初始化配置，其中 android/sdk 目录需要配置到 .bash_profile 中
ANDROID_HOME=/Users/<username>/Programs/Android/sdk
export ANDROID_HOME

# 安装完成打开，在创建项目的页面，右下角，Configure -> Plugins，在 Marketplace 里面搜索 并安装 flutter 插件（自动安装 Dart 插件），重启

# Configure -> AVD Manager，创建新安卓虚拟设备
# 一般选择 Phone -> Nexus 5 -> Android 8.0（需下载） -> Finish 点击绿色三角启动虚拟设备

# 提示 Android license status unknown
# 运行命令添加 Android license 即可
flutter doctor --android-licenses
```

> 8、如果使用 VS Code，需要安装 flutter 插件，自动安装 Dart 插件  