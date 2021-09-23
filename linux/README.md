## Linux

处理命令行参数是一个相似而又复杂的事情，为此，C提供了getopt/getopt_long等函数，
C++的boost提供了Options库，在shell中，处理此事的是getopts和getopt。

getopts和getopt功能相似但又不完全相同，其中getopt是独立的可执行文件，而getopts是由Bash内置的。

命令行选项的三种风格；原始的 Unix 风格、GNU 风格和 X 工具包风格。
1   UNIX options, which may be grouped and must be preceded by a dash.
2   BSD options, which may be grouped and must not be used with a dash.
3   GNU long options, which are preceded by two dashes.

在最初的 Unix 传统中，命令行选项是单个字母，前面有一个连字符。不接受以下参数的模式标志选项可以组合在一起；因此，如果 -a和-b是模式选项，则 -ab或-ba也是正确的并启用两者。选项的参数（如果有）跟在它后面（可选地用空格分隔）。在这种风格中，小写选项优先于大写。当您使用大写选项时，它们最好是小写选项的特殊变体。

最初的 Unix 风格是在缓慢的 ASR-33 电传打字机上演变而来的，这使得简洁成为一种美德 因此是单字母选项。按住shift键需要实际的努力；因此偏好小写，并使用“-”（而不是可能更合乎逻辑的“+”）来启用选项。

GNU 样式使用以两个连字符开头的选项关键字（而不是关键字字母）。几年后，当一些相当复杂的 GNU 实用程序开始用完单字母选项键时，它发展了。它仍然很受欢迎，因为 GNU 选项比旧样式的字母汤更容易阅读。GNU 风格的选项不能在不分隔空格的情况下组合在一起。选项参数（如果有）可以由空格或单个“=”（等号）字符分隔。

选择了 GNU 双连字符选项引导符，以便可以在同一命令行中明确混合传统的单字母选项和 GNU 样式的关键字选项。因此，如果您的初始设计只有很少且简单的选项，那么您可以使用 Unix 风格，而不必担心以后需要切换到 GNU 风格时会导致不兼容的“标志日”。另一方面，如果您使用的是 GNU 风格，那么至少为最常见的选项支持单字母等效项是一种很好的做法。

令人困惑的是，X 工具包样式使用单个连字符和关键字选项。它由 X 工具包解释，在将过滤后的命令行交给应用程序逻辑进行解释之前，过滤和处理某些选项（例如-geometry和 -display）。X 工具包样式与经典的 Unix 或 GNU 样式均不正确兼容，并且不应在新程序中使用，除非与旧 X 约定兼容的价值似乎非常高。

许多工具接受不与任何选项字母相关联的裸连字符，作为指示应用程序从标准输入读取的伪文件名。将双连字符识别为停止选项解释并按字面处理所有以下参数的信号也是惯例。

大多数 Unix 编程语言都提供了可以为您解析经典 Unix 或 GNU 风格的命令行的库（也解释双连字符约定）。

##### history search

**failed reverse-i-search**

Linux Bash now allows forward search using cntrl + S and backward search using cntrl + R . Please check if your terminal traps cntrl + S & cntrl + Q for flow control. If that's the case you can disable this by using stty -ixon.

##### Socket Statistics

ss是Socket Statistics的缩写。顾名思义，ss命令可以用来获取socket统计信息，它可以显示和netstat类似的内容。但ss的优势在于它能够显示更多更详细的有关TCP和连接状态的信息，而且比netstat更快速更高效。

-h, --help 帮助信息

-V, --version 程序版本信息

-n, --numeric 不解析服务名称

-r, --resolve        解析主机名

-a, --all 显示所有套接字（sockets）

-l, --listening 显示监听状态的套接字（sockets）

-o, --options        显示计时器信息

-e, --extended       显示详细的套接字（sockets）信息

-m, --memory         显示套接字（socket）的内存使用情况

-p, --processes 显示使用套接字（socket）的进程

-i, --info 显示 TCP内部信息

-s, --summary 显示套接字（socket）使用概况

-4, --ipv4           仅显示IPv4的套接字（sockets）

-6, --ipv6           仅显示IPv6的套接字（sockets）

-0, --packet         显示 PACKET 套接字（socket）

-t, --tcp 仅显示 TCP套接字（sockets）

-u, --udp 仅显示 UCP套接字（sockets）

-d, --dccp 仅显示 DCCP套接字（sockets）

-w, --raw 仅显示 RAW套接字（sockets）

-x, --unix 仅显示 Unix套接字（sockets）

-f, --family=FAMILY  显示 FAMILY类型的套接字（sockets），FAMILY可选，支持  unix, inet, inet6, link, netlink

-A, --query=QUERY, --socket=QUERY

      QUERY := {all|inet|tcp|udp|raw|unix|packet|netlink}[,QUERY]

-D, --diag=FILE     将原始TCP套接字（sockets）信息转储到文件

-F, --filter=FILE   从文件中都去过滤器信息

       FILTER := [ state TCP-STATE ] [ EXPRESSION ]

ss -tnlp

##### ps

ps 提供了很多的选项参数，常用的有以下几个：

l 长格式输出；
u 按用户名和启动时间的顺序来显示进程；
j 用任务格式来显示进程；
f 用树形格式来显示进程；
a 显示所有用户的所有进程（包括其它用户）；
x 显示无控制终端的进程；
r 显示运行中的进程；
ww 避免详细参数被截断；

e 显示所有进程。
f 全格式。

au(x) 输出格式 :USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND

USER: 行程拥有者
PID: pid
%CPU: 占用的 CPU 使用率
%MEM: 占用的记忆体使用率
VSZ: 占用的虚拟记忆体大小
RSS: 占用的记忆体大小
TTY: 终端的次要装置号码 (minor device number of tty)
STAT: 该行程的状态:
    D    不可中断     Uninterruptible sleep (usually IO)
    R    正在运行，或在队列中的进程　　runnable (on run queue)
    S    处于休眠状态　　sleeping
    T    停止或被追踪　　traced or stopped
    Z    僵尸进程　　a defunct('zombie') process
    W    进入内存交换（从内核2.6开始无效）
    X    死掉的进程
    <    高优先级
    N    低优先级
    L    有些页被锁进内存
    s    包含子进程
    +    位于后台的进程组；
    l    多线程，克隆线程  multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
START: 行程开始时间
TIME: 执行的时间
COMMAND:所执行的指令










#### 其他

lsb_release -a，即可列出所有版本信息

getconf LONG_BIT  （Linux查看版本说明当前CPU运行在32bit模式下， 但不代表CPU不支持64bit）

```
【附】系统信息查询大全
# uname -a # 查看内核/操作系统/CPU信息 
# head -n 1 /etc/issue # 查看操作系统版本 
# cat /proc/cpuinfo # 查看CPU信息 
# hostname # 查看计算机名 
# lspci -tv # 列出所有PCI设备 
# lsusb -tv # 列出所有USB设备 
# lsmod # 列出加载的内核模块 
# env # 查看环境变量资源 
# free -m # 查看内存使用量和交换区使用量 
# df -h # 查看各分区使用情况 
# du -sh <目录名> # 查看指定目录的大小 
# grep MemTotal /proc/meminfo # 查看内存总量 
# grep MemFree /proc/meminfo # 查看空闲内存量 
# uptime # 查看系统运行时间、用户数、负载 
# cat /proc/loadavg # 查看系统负载磁盘和分区 
# mount | column -t # 查看挂接的分区状态 
# fdisk -l # 查看所有分区 
# swapon -s # 查看所有交换分区 
# hdparm -i /dev/hda # 查看磁盘参数(仅适用于IDE设备) 
# dmesg | grep IDE # 查看启动时IDE设备检测状况网络 
# ifconfig # 查看所有网络接口的属性 
# iptables -L # 查看防火墙设置 
# route -n # 查看路由表 
# netstat -lntp # 查看所有监听端口 
# netstat -antp # 查看所有已经建立的连接 
# netstat -s # 查看网络统计信息进程 
# ps -ef # 查看所有进程 
# top # 实时显示进程状态用户 
# w # 查看活动用户 
# id <用户名> # 查看指定用户信息 
# last # 查看用户登录日志 
# cut -d: -f1 /etc/passwd # 查看系统所有用户 
# cut -d: -f1 /etc/group # 查看系统所有组 
# crontab -l # 查看当前用户的计划任务服务 
# chkconfig –list # 列出所有系统服务 
# chkconfig –list | grep on # 列出所有启动的系统服务程序 

# rpm -qa # 查看所有安装的软件包

查看/proc/uptime文件计算系统启动时间：
cat /proc/uptime
输出: 5113396.94 575949.85

第一数字即是系统已运行的时间5113396.94秒，运用系统工具date即可算出系统启动时间

date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"

输出: 2018-01-02 06:50:52

查看/proc/uptime文件计算系统运行时间

cat /proc/uptime| awk -F. '{run_days=$1 / 86400;run_hour=($1 % 86400)/3600;run_minute=($1 % 3600)/60;run_second=$1 % 60;printf("系统已运行：%d天%d时%d分%d秒",run_days,run_hour,run_minute,run_second)}'

输出:系统已运行：1天1时36分13秒

Linux查看物理CPU个数、核数、逻辑CPU个数
# 总核数 = 物理CPU个数 X 每颗物理CPU的核数 
# 总逻辑CPU数 = 物理CPU个数 X 每颗物理CPU的核数 X 超线程数

# 查看物理CPU个数
cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l
2

# 查看每个物理CPU中core的个数(即核数)
cat /proc/cpuinfo| grep "cpu cores"| uniq
cpu cores       : 2

# 查看逻辑CPU的个数
cat /proc/cpuinfo| grep "processor"| wc -l


# 查看CPU信息（型号）
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
      4  Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

输入命令cat /proc/cpuinfo 查看physical id有几个就有几个物理cpu；查看processor有几个就有几个逻辑cpu。
(一)概念
① 物理CPU
实际Server中插槽上的CPU个数
物理cpu数量，可以数不重复的physical id有几个
② 逻辑CPU 
/proc/cpuinfo用来存储cpu硬件信息的
信息内容分别列出了processor 0 –processor n 的规格。这里需要注意，n+1是逻辑cpu数
一般情况，我们认为一颗cpu可以有多核，加上intel的超线程技术(HT), 可以在逻辑上再分一倍数量的cpu core出来
逻辑CPU数量=物理cpu数量 x cpu cores 这个规格值 x 2(如果支持并开启ht)    
备注一下：Linux下top查看的CPU也是逻辑CPU个数
 ③ CPU核数
一块CPU上面能处理数据的芯片组的数量、比如现在的i5 760,是双核心四线程的CPU、而 i5 2250 是四核心四线程的CPU
一般来说，物理CPU个数×每颗核数就应该等于逻辑CPU的个数，如果不相等的话，则表示服务器的CPU支持超线程技术

lscpu命令，查看的是cpu的统计信息，包括型号、主频、内核信息等


内存

概要查看内存情况  free  -m    详细情况：cat /proc/meminfo

查看硬盘和分区分布： lsblk
列出所有可用块设备的信息，而且还能显示他们之间的依赖关系，但是它不会列出RAM盘的信息

如果要看硬盘和分区的详细信息：fdisk -l

使用“df -k”命令，以KB为单位显示磁盘使用量和占用率，-m则是以M为单位显示磁盘使用量和占用率

网卡

查看网卡硬件信息
# lspci | grep -i 'eth'
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 06)

查看系统的所有网络接口：ifconfig -a

如果要查看某个网络接口的详细信息，例如eth0的详细参数和指标：ethtool eth0

查看pci信息，即主板所有硬件槽信息：lspci

如果要更详细的信息:lspci -v 或者 lspci -vv

如果要看设备树:lspci -t


 Linux /proc目录详解

1. /proc目录
Linux 内核提供了一种通过 /proc 文件系统，在运行时访问内核内部数据结构、改变内核设置的机制。proc文件系统是一个伪文件系统，它只存在内存当中，而不占用外存空间。它以文件系统的方式为访问系统内核数据的操作提供接口。
用户和应用程序可以通过proc得到系统的信息，并可以改变内核的某些参数。由于系统的信息，如进程，是动态改变的，所以用户或应用程序读取proc文件时，proc文件系统是动态从系统内核读出所需信息并提交的。下面列出的这些文件或子文件夹，并不是都是在你的系统中存在，这取决于你的内核配置和装载的模块。另外，在/proc下还有三个很重要的目录：net，scsi和sys。 Sys目录是可写的，可以通过它来访问或修改内核的参数，而net和scsi则依赖于内核配置。例如，如果系统不支持scsi，则scsi 目录不存在。
除了以上介绍的这些，还有的是一些以数字命名的目录，它们是进程目录。系统中当前运行的每一个进程都有对应的一个目录在/proc下，以进程的 PID号为目录名，它们是读取进程信息的接口。而self目录则是读取进程本身的信息接口，是一个link。

2. 子文件或子文件夹
/proc/buddyinfo 每个内存区中的每个order有多少块可用，和内存碎片问题有关
/proc/cmdline 启动时传递给kernel的参数信息
/proc/cpuinfo cpu的信息
/proc/crypto 内核使用的所有已安装的加密密码及细节
/proc/devices 已经加载的设备并分类
/proc/dma 已注册使用的ISA DMA频道列表
/proc/execdomains Linux内核当前支持的execution domains
/proc/fb 帧缓冲设备列表，包括数量和控制它的驱动
/proc/filesystems 内核当前支持的文件系统类型
/proc/interrupts x86架构中的每个IRQ中断数
/proc/iomem 每个物理设备当前在系统内存中的映射
/proc/ioports 一个设备的输入输出所使用的注册端口范围
/proc/kcore 代表系统的物理内存，存储为核心文件格式，里边显示的是字节数，等于RAM大小加上4kb
/proc/kmsg 记录内核生成的信息，可以通过/sbin/klogd或/bin/dmesg来处理
/proc/loadavg 根据过去一段时间内CPU和IO的状态得出的负载状态，与uptime命令有关
/proc/locks 内核锁住的文件列表
/proc/mdstat 多硬盘，RAID配置信息(md=multiple disks)
/proc/meminfo RAM使用的相关信息
/proc/misc 其他的主要设备(设备号为10)上注册的驱动
/proc/modules 所有加载到内核的模块列表
/proc/mounts 系统中使用的所有挂载
/proc/mtrr 系统使用的Memory Type Range Registers (MTRRs)
/proc/partitions 分区中的块分配信息
/proc/pci 系统中的PCI设备列表
/proc/slabinfo 系统中所有活动的 slab 缓存信息
/proc/stat 所有的CPU活动信息
/proc/sysrq-trigger 使用echo命令来写这个文件的时候，远程root用户可以执行大多数的系统请求关键命令，就好像在本地终端执行一样。要写入这个文件，需要把/proc/sys/kernel/sysrq不能设置为0。这个文件对root也是不可读的
/proc/uptime 系统已经运行了多久
/proc/swaps 交换空间的使用情况
/proc/version Linux内核版本和gcc版本
/proc/bus 系统总线(Bus)信息，例如pci/usb等
/proc/driver 驱动信息
/proc/fs 文件系统信息
/proc/ide ide设备信息
/proc/irq 中断请求设备信息
/proc/net 网卡设备信息
/proc/scsi scsi设备信息
/proc/tty tty设备信息
/proc/net/dev 显示网络适配器及统计信息
/proc/vmstat 虚拟内存统计信息
/proc/vmcore 内核panic时的内存映像
/proc/diskstats 取得磁盘信息
/proc/schedstat kernel调度器的统计信息
/proc/zoneinfo 显示内存空间的统计信息，对分析虚拟内存行为很有用

以下是/proc目录中进程N的信息
/proc/N pid为N的进程信息
/proc/N/cmdline 进程启动命令
/proc/N/cwd 链接到进程当前工作目录
/proc/N/environ 进程环境变量列表
/proc/N/exe 链接到进程的执行命令文件
/proc/N/fd 包含进程相关的所有的文件描述符
/proc/N/maps 与进程相关的内存映射信息
/proc/N/mem 指代进程持有的内存，不可读
/proc/N/root 链接到进程的根目录
/proc/N/stat 进程的状态
/proc/N/statm 进程使用的内存的状态
/proc/N/status 进程状态信息，比stat/statm更具可读性
/proc/self 链接到当前正在运行的进程
```





