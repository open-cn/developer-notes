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









