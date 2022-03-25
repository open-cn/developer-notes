## Windows Subsystem Linux

适用于 Linux 的 Windows 子系统

WSL 可让开发人员按原样运行 GNU/Linux 环境 - 包括大多数命令行工具、实用工具和应用程序 - 且不会产生传统虚拟机或双启动设置开销。

WSL 2 是 WSL 体系结构的一个新版本，它支持适用于 Linux 的 Windows 子系统在 Windows 上运行 ELF64 Linux 二进制文件。 它的主要目标是提高文件系统性能，以及添加完全的系统调用兼容性。

WSL 2 使用最新、最强大的虚拟化技术在轻量级实用工具虚拟机 (VM) 中运行 Linux 内核。 但是，WSL 2 不是传统的 VM 体验。

### 安装

```powershell
wsl --install
```

旧版本 wsl 安装
```powershell
# 启用可选的 WSL 和虚拟机平台组件
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
# 下载并安装最新 Linux 内核
# 将 WSL 2 设置为默认值
wsl --set-default-version 2
# 下载发行版
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing
curl.exe -L -o ubuntu-2004.appx https://aka.ms/wslubuntu2004
# 安装发行版
Add-AppxPackage .\app_name.appx
```

### 使用
```powershell
wsl --help

wsl --install --distribution <Distribution Name>

wsl --list --online
wsl --list --verbose

wsl --update
wsl --status

wsl --set-default-version <Version> # 设置默认 wsl 版本
wsl --set-default <Distribution Name> # 设置默认 Linux 发行版
wsl --set-version <distribution name> <versionNumber> # 设置 wsl 版本

<DistributionName> config --default-user <Username> # 设置默认用户
ubuntu config --default-user liuxy

wsl ~ # 在用户的主目录中启动
wsl --distribution <Distribution Name> --user <User Name> # 运行特定的 Linux 发行版
wsl --user <Username>

wsl --mount <DiskPath>

wsl --shutdown
wsl --terminate <Distribution Name>

# 从系统分区 C 转出到其他分区
wsl --shutdown

wsl --export <Distribution Name> <FileName> # 把ext4.vhdx镜像导出成tar文件
wsl --export Ubuntu D:\ubuntu\ubuntu.tar

wsl --unregister <DistributionName> # 注销并卸载 Linux 发行版
wsl --unregister Ubuntu

wsl --import <Distribution Name> <InstallLocation> <FileName> # 把tar文件导入成ext4.vhdx镜像
wsl --import Ubuntu D:\ubuntu D:\ubuntu\ubuntu.tar --version 2
```

启动目录改成`//wsl$/Ubuntu/home/liuxy`

#### 禁用互操作性

```shell
# 临时禁用
sudo echo 0 > /proc/sys/fs/binfmt_misc/WSLInterop
# 临时启用
sudo echo 1 > /proc/sys/fs/binfmt_misc/WSLInterop
```

#### 高级设置配置

/etc/wsl.conf
C:\Users\<UserName>\.wslconfig


#### docker desktop
```shell
docker network prune
docker images prune
docker system prune -a --volumes
```

/mnt/wsl/docker-desktop/cli-tools/
/mnt/wsl/docker-desktop/docker-desktop-proxy

/mnt/wsl/docker-desktop-data/data
/mnt/wsl/docker-desktop-data/isoCache
/mnt/wsl/docker-desktop-data/tarCache/entries/docker.tar/xxx/
/mnt/wsl/docker-desktop-data/version-pack-data

/mnt/wsl/docker-desktop-bind-mounts/Ubuntu

\\wsl$\docker-desktop-data

\\wsl$\docker-desktop-data\version-pack-data\community\docker\overlay2 \ randomstring \ diff folder

\\wsl$\docker-desktop

\\wsl$\docker-desktop-data\version-pack-data\community\docker\volumes is now empty with a metadata.db file

##### use mysql

```shell
docker pull mysql
docker run -d --rm --name Mysql -e MYSQL_ROOT_PASSWORD=123456 -p 3306:3306 mysql
```

授权密码登录
```mysql
use mysql;
GRANT ALL ON *.* TO 'root'@'%';
flush PRIVILEGES;
```

##### 转移 data 到非系统分区
从系统分区 C:\Users\xxx\AppData\Local\Docker\wsl\data 转出到其他分区
```powershell
wsl --shutdown
wsl --export docker-desktop-data D:\docker-desktop\docker-desktop-data.tar
wsl --unregister docker-desktop-data
wsl --import docker-desktop-data D:\docker-desktop\data D:\docker-desktop\docker-desktop-data.tar --version 2
```

 C:\Users\xxx\AppData\Local\Docker\wsl\distro\ext4.vhdx 这个分区呢？不到150M。






























