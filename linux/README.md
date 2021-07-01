## Linux


### Linux 服务管理两种方式 service 和 systemctl

#### init 和 service

历史上，Linux 的启动一直采用init 进程。

在类Unix 的计算机操作系统中，Init（初始化的简称）是在启动计算机系统期间启动的第一个进程。

Init 是一个守护进程，它将持续运行，直到系统关闭。它是所有其他进程的直接或间接的父进程。

因为init 的参数全在/etc/init.d目录下，所以使用 init 启动一个服务，应该这样做：

$ sudo /etc/init.d/nginx start


service命令用于对系统服务进行管理，比如启动（start）、停止（stop）、重启（restart）、查看状态（status）等。
相关的命令还包括chkconfig、ntsysv等，chkconfig用于查看、设置服务的运行级别，ntsysv用于直观方便的设置各个服务是否自动启动。

service命令本身是一个shell脚本，它在/etc/init.d/目录查找指定的服务脚本，然后调用该服务脚本来完成任务。

service是一个运行System V init的脚本命令。

$ sudo /etc/init.d/nginx start
// 等价于
$ service nginx start


但是这两种方式均有如下缺点：

- 启动时间长。init 进程是串行启动，只有前一个进程启动完，才会启动下一个进程。
- 启动脚本复杂。init进程只是执行启动脚本，不管其他事情。脚本需要自己处理各种情况，这往往使得脚本变得很长。


#### systemd

Systemd 是Linux 系统中最新的初始化系统（init），它主要的设计目的是克服 System V init 固有的缺点，提高系统的启动速度。

根据 Linux 惯例，字母d是守护进程（daemon）的缩写。 Systemd 这个名字的含义，就是它要守护整个系统。

使用了 Systemd，就不需要再用init 了。Systemd 取代了initd（Initd 的PID 是0） ，成为系统的第一个进程（Systemd 的PID 等于 1），其他进程都是它的子进程。

Systemd 的优点是功能强大，使用方便，缺点是体系庞大，非常复杂。

systemd作用是提高系统的启动速度，尽可能启动较少的进程，尽可能更多进程并发启动。

systemd的Unit放在目录/usr/lib/systemd/system(Centos)或/etc/systemd/system(Ubuntu)


Systemd 并不是一个命令，而是一组命令，涉及到系统管理的方方面面。

##### systemctl是 Systemd 的主命令，用于管理系统

systemctl 提供了一组子命令来管理单个的 unit，其命令格式为：

systemctl [command] [unit]


command 主要有：

start：立刻启动后面接的 unit。

stop：立刻关闭后面接的 unit。

restart：立刻关闭后启动后面接的 unit，亦即执行 stop 再 start 的意思。

reload：不关闭 unit 的情况下，重新载入配置文件，让设置生效。

enable：设置下次开机时，后面接的 unit 会被启动。

disable：设置下次开机时，后面接的 unit 不会被启动。

status：目前后面接的这个 unit 的状态，会列出有没有正在执行、开机时是否启动等信息。

is-active：目前有没有正在运行中。

is-enable：开机时有没有默认要启用这个 unit。

kill ：不要被 kill 这个名字吓着了，它其实是向运行 unit 的进程发送信号。

show：列出 unit 的配置。

mask：注销 unit，注销后你就无法启动这个 unit 了。

unmask：取消对 unit 的注销。


// 重启系统
$ sudo systemctl reboot

// 启动进入救援状态（单用户状态）
$ sudo systemctl rescue

// 管理服务
$ sudo systemctl start nginx



.service文件定义了一个服务，分为[Unit]，[Service]，[Install]三个小节

[Unit]

Description:描述，

After：在network.target,auditd.service启动后才启动

ConditionPathExists: 执行条件

 

[Service]

EnvironmentFile:变量所在文件

ExecStart: 执行启动脚本

Restart: fail时重启

 

[Install]

Alias:服务别名

WangtedBy: 多用户模式下需要的


##### hostnamectl 命令用于查看当前主机的信息。

// 显示当前主机信息
$ hostnamectl

// 设置主机名
$ sudo hostnamectl set-hostname BoodeUbuntu


##### localectl 命令用于查看本地化设置。

// 查看本地化设置
$ localectl

// 设置本地化参数。
$ sudo localectl set-locale LANG=en_GB.utf8
$ sudo localectl set-keymap en_GB

##### timedatectl 命令用于查看当前时区设置

// 查看当前时区设置
$ timedatectl

// 显示所有可用的时区
$ timedatectl list-timezones                                                                                   

// 设置当前时区
$ sudo timedatectl set-timezone America/New_York
$ sudo timedatectl set-time YYYY-MM-DD
$ sudo timedatectl set-time HH:MM:SS

