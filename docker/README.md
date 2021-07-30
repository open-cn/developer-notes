## docker

### Docker 有三个组件和三个基本元素

- Docker Client : 这是一个泛称，他既可以是命令行工具docker，也可以是任何遵循Docker API的客户端。用来向 Docker Daemon发起请求，执行相应的容器管理操作。
- Docker Daemon : Docker服务的守护进程。Docker Daemon负责响应Docker Client发过来的请求。
- Docker Registry : Docker Images的仓库，就像git的仓库一样，并且提供安全的账号管理可以管理只有自己可见的私人image。官方的 Registry，叫做Dock Hub(http://hub.Docker.com)

- Docker Container : Docker的容器，负责应用程序的运行，包括操作系统、用户添加的文件以及元数据。 
- Docker Images : Docker的镜像，暂时可以认为这个就像我们要给电脑装系统用的系统CD盘，里面有操作系统的程序，并且还有一些CD盘在系统的基础上安装了必要的软件，做成的一张 “只读” 的CD。
- DockerFile : 文件指令集，用来说明如何自动创建Docker镜像。

### Docker 使用的Linux核心组件

- AUFS(chroot) – 用来建立不同的操作系统和隔离运行时的硬盘空间
- Namespace – 用来隔离Container的执行空间
- Cgroup – 分配不同的硬件资源
- SELinux – 用来保护linux的网络安全
- Netlink – 用来让不同的Container之间的进程保持通信
- Netfilter – 建立Container埠為基礎的網路防火牆封包過濾
- AppArmor – 保護Container的網路及執行安全
- Linux Bridge – 讓不同Container或不同主機上的Container能溝通
...

AUFS -> Another Union File System，AUFS的技术可以让多个文件目录union成一个新的目录，并且可以对这个新的目录进行读写操作。

那这有什么用呢？如果你有一张只读的cd数据盘，但是你却想编辑里面的内容，你通常的做法是不是把内容拷贝到本地硬盘，然后再编辑。但如果你可以利用AUFS技术，你就可以将硬盘中的一个空目录和你的cd数据盘进行union形成一个新的目录，接着你对这个目录读取，会得到的cd盘内的数据，当你对这个目录的内容进行编辑，编辑的内容AUFS会自动讲修改内容保存在你union的那个空目录内，当你再次读区的时候，AUFS也会将你硬盘中记录的改动内容优先于CD数据盘中的内容读取出来，这样对你来说这就完全是一个可编辑的目录内容了。

cgroup -> 最初名为 process container, 在2007年更名为 Control Groups 并整合进 Linux 内核。


namespace 的6项隔离

|namespace|系统调用参数|隔离内容|
|---|---|---|
|1.UTS     | CLONE_NEWUTS  | 主机名与域名|
|2.IPC     | CLONE_NEWIPC  | 信号量、消息列表和共享内存|
|3.PID     | CLONE_NEWPID  | 进程编号|
|4.Network | CLONE_NEWNET  | 网络设备、网格栈、端口等|
|5.Mount   | CLONE_NEWNS   | 挂载点（文件系统）|
|6.User    | CLONE_NEWUSER | 用户和用户组|

Linux 3.8 版本后才支持user namespace。

查看/proc/[pid]/ns文件
`ls -l /proc/$$/ns`



### Docker 版本
Docker从17.03开始分为企业版与社区版，社区版并非阉割版，而是改了个名称；企业版则提供了一些收费的高级特性。

EE版本维护期1年；CE的stable版本三个月发布一次，维护期四个月；另外CE还有edge版，一个月发布一次。

版本迭代计划<br>
Docker从17.03开始，转向基于时间的 YY.MM 形式的版本控制方案，类似于Canonical为Ubuntu所使用的版本控制方案。

Docker CE有两种版本：

1. edge版本每月发布一次，主要面向那些喜欢尝试新功能的用户。
2. stable版本每季度发布一次，适用于希望更加容易维护的用户（稳定版）。

edge版本只能在当前月份获得安全和错误修复。而stable版本在初始发布后四个月内接收关键错误修复和安全问题的修补程序。

#### on macOS:
install docker.app

目前只有 edge 版 带 Kubernetes 功能
```
$ docker --version
Docker version 18.03, build c97c6d6

$ docker-compose --version
docker-compose version 1.21.0, build 8dd22a9

$ docker-machine --version
docker-machine version 0.14.0, build 9ba6da9


$ docker run hello-world
// 让docker daemon从docker hub上拉了一个"hello-world"的image,并且通过这个image创建了一个container
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
ca4f61b1923c: Pull complete
Digest: sha256:ca0eeb6fb05351dfc8759c20733c91def84cb8007aa89a5bf606bc8b315b9fc7
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.
...

$ docker run -d -p 80:80 --name webserver nginx
open http://localhost/
$ docker container stop webserver
$ docker container rm webserver

[docker container ]
$ docker [container] create      Create a new container
$ docker [container] rm          Remove one or more containers
$ docker [container] rename      Rename a container
$ docker container ls (docker ps) -a
-a 查看所有，包括停止的容器
-l 查看最近，包括停止的容器
$ docker [container] start       Start one or more stopped containers
$ docker [container] pause       Pause all processes within one or more containers
$ docker [container] unpause     Unpause all processes within one or more containers
$ docker [container] stop        Stop one or more running containers
$ docker [container] restart     Restart one or more containers
$ docker [container] kill        Kill one or more running containers

$ docker [container] attach      Attach local standard input, output, and error streams to a running container
$ docker [container] commit      Create a new image from a container's changes
$ docker [container] diff        Inspect changes to files or directories on a container's filesystem
$ docker [container] export      Export a container's filesystem as a tar archive
$ docker container inspect     Display detailed information on one or more containers
$ docker [container] port        List port mappings or a specific mapping for the container
$ docker container prune       Remove all stopped containers
$ docker [container] stats       Display a live stream of container(s) resource usage statistics
$ docker [container] top         Display the running processes of a container
$ docker [container] update      Update configuration of one or more containers
$ docker [container] wait        Block until one or more containers stop, then print their exit codes

$ docker container run         Run a command in a new container
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
-i 使用交互模式
-t 分配一个伪终端
--name 指定容器名称，否则随机分配
-p 暴露端口

$ docker [container] exec        Run a command in a running container
$ docker [container] cp          Copy files/folders between a container and the local filesystem
$ docker [container] logs        Fetch the logs of a container


[docker image ]
$ docker [image] build
$ docker [image] history
$ docker [image] import
$ docker image inspect
$ docker [image] load
$ docker image ls (docker images)
$ docker image prune
$ docker [image] pull
$ docker [image] push
$ docker image rm nginx (docker rmi)
$ docker [image] save
$ docker [image] tag


$ docker search
$ docker login  
$ docker logout

```

##### docker 子命令

docker 环境信息   info, version
容器生命周期管理   create, exec, kill, pause, restart, rm, run, start, stop, unpause
镜像仓库命令       login, logout, pull, push, search
镜像管理          build, images, import, load, rmi, save, tag, commit
容器运维操作      attach, export, inspect, port, ps, rename, stats, top, wait, cp, diff, update
容器资源管理      volume, network
系统日志信息      events, history, logs

### Docker Compose
Docker Compose 项目是 Docker 官方的开源项目，负责实现对 Docker 容器集群的快速编排，开源地址：https://github.com/docker/compose

Docker Compose 中的两个重要概念：

1. 服务 (service)：一个应用容器，实际上可以运行多个相同镜像的实例。
2. 项目 (project)：由一组关联的应用容器组成的一个完整业务单元。

一个项目可以由多个服务关联（容器）而成，并使用docker-compose.yml进行管理。

#### YAML 配置命令
- build 指定 Dockerfile 所在的目录地址，用于构建镜像，并使用此镜像创建容器，比如上面配置的build: .
- command 容器的执行命令
- dns 自定义 dns 服务器
- expose  暴露端口配置，但不映射到宿主机，只被连接的服务访问
- extends 对docker-compose.yml的扩展，配置在服务中
- image 使用的镜像名称或镜像 ID
- links 链接到其它服务中的容器（一般桥接网络模式使用）
- net 设置容器的网络模式（四种：bridge, none, container:[name or id]和host）
- ports 暴露端口信息，主机和容器的端口映射
- volumes 数据卷所挂载路径设置



#### Docker Compose 常用命令
- docker-compose build  构建项目中的镜像，--force-rm：删除构建过程中的临时容器；--no-cache：不使用缓存构建；--pull：获取最新版本的镜像
- docker-compose up -d  构建镜像、创建服务和启动项目，-d表示后台运行
- docker-compose run ubuntu ls -d 指定服务上运行一个命令，-d表示后台运行
- docker-compose logs 查看服务容器输出日志
- docker-compose ps 列出项目中所有的容器
- docker-compose pause [service_name] 暂停一个服务容器
- docker-compose unpause [service_name] 恢复已暂停的一个服务容器
- docker-compose restart  重启项目中的所有服务容器（也可以指定具体的服务）
- docker-compose stop 停止运行项目中的所有服务容器（也可以指定具体的服务）
- docker-compose start  启动已经停止项目中的所有服务容器（也可以指定具体的服务）
- docker-compose rm 删除项目中的所有服务容器（也可以指定具体的服务），-f：强制删除（包含运行的）
- docker-compose kill 强制停止项目中的所有服务容器（也可以指定具体的服务）

#### on ubuntu:
##### Install old Docker from Ubuntu’s repositories:
```
apt-get update
apt-get install -y docker.io
```

##### Uninstall old versions
Older versions of Docker were called docker or docker-engine. If these are installed, uninstall them:
`sudo apt-get remove docker docker-engine docker.io`


##### Trusty 14.04
Unless you have a strong reason not to, install the linux-image-extra-* packages, which allow Docker to use the aufs storage drivers.
```
$ sudo apt-get update
$ sudo apt-get install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual
```

##### Xenial 16.04 and newer
一、 Install Docker CE

1. Install using the repository<br>
**SET UP THE REPOSITORY**
```
$ sudo apt-get update

$ sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo apt-key fingerprint 0EBFCD88

$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```
note: arch=amd64/armhf/ppc64el/s390x

**INSTALL DOCKER CE**
```
$ sudo apt-get update
$ sudo apt-get install docker-ce
$ apt-cache madison docker-ce
docker-ce | 18.03.0~ce-0~ubuntu | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages
$ sudo apt-get install docker-ce=<VERSION>
```

**UPGRADE DOCKER CE**
To upgrade Docker CE, first run sudo apt-get update, then follow the installation instructions, choosing the new version you want to install.

2. Install from a package
https://download.docker.com/linux/ubuntu/dists/{Ubuntu version}/pool/stable/arm

```
$ sudo dpkg -i /path/to/package.deb
```

3. Install using the convenience script
```
$ curl -fsSL get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
```

二、 Uninstall Docker CE
```
$ sudo apt-get purge docker-ce
$ sudo rm -rf /var/lib/docker
```

#### 配置docker代理
mkdir -p /etc/systemd/system/docker.service.d
添加如下内容到/etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://127.0.0.1:8118" "NO_PROXY=localhost,172.16.0.0/16,127.0.0.1,10.244.0.0/16"
重启docker
systemctl daemon-reload && systemctl restart docker

systemctl enable docker 
systemctl start docker

