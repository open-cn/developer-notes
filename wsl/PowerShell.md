## Windows PowerShell

### 端口转发

netsh(Network Shell) 是一个windows系统本身提供的功能强大的网络配置命令行工具。 导出配置脚本：netsh -c interface ip dump > c:\interface.txt 导入配置脚本：netsh -f c:\interface.txt。

```
netsh interface portproxy show all

netsh interface portproxy add v4tov4 listenport=8000 listenaddress=192.168.12.132 connectport=8000 connectaddress=127.0.0.1

netsh interface portproxy delete v4tov4 listenport=8000 listenaddress=192.168.12.132
```



### scoop——Windows下的包管理系统
要求powershell3或以上版本， .NET Framework 4.5或以上版本。
```
$PSVersionTable.PSVersion.Major   #查看Powershell版本
$PSVersionTable.CLRVersion.Major  #查看.NET Framework版本
```

##### 安装 scoop
在 PowerShell 中输入下面内容，保证允许本地脚本的执行：
```
set-executionpolicy remotesigned -scope currentuser
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

or

Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex
```


##### 安装其他软件
```
scoop search git
scoop install git

scoop install aria2
scoop config aria2-max-connection-per-server 16
scoop config aria2-split 16
scoop config aria2-min-split-size 1M

scoop uninstall 7zip # 卸载

scoop update #更新 scoop
scoop update 7zip # 更新7zip
scoop * # 更新全部

scoop bucket add extras # 添加官方维护的extras bucket
scoop bucket add versions

scoop install calibre gimp inkscape latex zotero

scoop bucket add scoopbucket https://github.com/yuanying1199/scoopbucket # 添加第三方bucket

scoop install scoopbucket/cajviewerlite

```

- "extras": "https://github.com/lukesampson/scoop-extras.git",
- "versions": "https://github.com/scoopinstaller/versions",
- "nightlies": "https://github.com/scoopinstaller/nightlies",
- "nirsoft": "https://github.com/kodybrown/scoop-nirsoft",
- "php": "https://github.com/nueko/scoop-php.git",
- "nerd-fonts": "https://github.com/matthewjberger/scoop-nerd-fonts.git",
- "nonportable": "https://github.com/oltolm/scoop-nonportable",
- "java": "https://github.com/se35710/scoop-java",
- "games": "https://github.com/Calinou/scoop-games"

### Chocolatey——Windows下的包管理系统

#### 管理员权限运行cmd.exe或powershell.exe

##### 安装 Chocolatey
```cmd
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

##### 安装其他软件
```
choco install ${packagename} -y
cinst ${packagename} -y

choco install git.install
choco install 7zip.install

choco install googlechrome

choco install jdk8

choco install nodejs.install // 最新版本，当前是11.6.0
choco install nodejs-lts     // lts的最新版本，当前是10.15.0

choco install vscode

choco install intellijidea-community // 社区版
choco install intellijidea-ultimate  // 旗舰版

choco install jdk8 googlechrome vscode 7zip // 一次安装多个软件包
choco install nodejs.install --version 0.10.35 // 安装指定版本
```

##### 根据配置安装所有软件
```
choco install dev-package.config // 安装dev-package.config文件内描述的所有软件包
```
```xml
<?xml version="1.0" encoding="utf-8"?>
    <packages>
      <package id="jdk8" />
      <package id="googlechrome" version="71.0.3578.98" />
      <package id="vscode" />
      <package id="7zip" />
    </packages>
```





