## Windows Subsystem Linux



### 安装

```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

`wsl -l -v`

### docker desktop
```
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

#### use mysql

```
docker pull mysql
docker run -d --rm --name Mysql -e MYSQL_ROOT_PASSWORD=123456 -p 3306:3306 mysql
```

授权密码登录
```mysql
use mysql;
GRANT ALL ON *.* TO 'root'@'%';
flush PRIVILEGES;
```

#### 转移 data 到非系统分区
从系统分区 C:\Users\xxx\AppData\Local\Docker\wsl\data 转出到其他分区
```
wsl --shutdown
wsl --export docker-desktop-data D:\docker-desktop\docker-desktop-data.tar
wsl --unregister docker-desktop-data
wsl --import docker-desktop-data D:\docker-desktop\data D:\docker-desktop\docker-desktop-data.tar --version 2
```

 C:\Users\xxx\AppData\Local\Docker\wsl\distro\ext4.vhdx 这个分区呢？不到150M。































