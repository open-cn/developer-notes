## shell

### 概述

Shell是一个命令处理器，通常运行于文本窗口中，并能执行用户直接输入的命令。

Shell 是一个用 C 语言编写的程序，它是用户使用 Linux 的桥梁。Shell 既是一种命令语言，又是一种程序设计语言。
Shell 是指一种应用程序，这个应用程序提供了一个界面，用户通过这个界面访问操作系统内核的服务。

Unix shell，通常被称作“命令行”，为Unix和类Unix操作系统提供了传统的用户界面。用户通过输入shell所执行的命令，引导计算机的操作。在微软Windows操作系统平台，类似程序是command.com，或者基于Windows NT内核操作系统的cmd.exe。

字符程序 <---> 虚拟终端 <---> 图像显示
shell <---> xterm <---> X11

#### 历史

1971 年，Ken Thompson 发布了第一个 Unix shell：Thompson shell。但是，脚本用户所能做的存在严重限制，这意味着严重制约了自动化以及整个 IT 运营领域。

Bill Joy于20世纪80年代早期，在伯克利的 加利福尼亚大学 开发了C shell。它主要是为了让用户更容易的使用交互式功能，并把ALGOL风格的语法结构变成了C语言风格。它新增了命令历史、别名、文件名替换、 作业控制 等功能。

在 Thompson 发布 shell 六年后，1977 年，Stephen Bourne 发布了 Bourne shell，旨在解决Thompson shell 中的脚本限制。

Bourne shell是早期版本Unix所使用的shell，并成为一个事实上的标准；任何类Unix系统至少拥有一个与Bourne shell相兼容的shell。

有很长一段时间，只有两类shell供人们选择，Bourne shell用来编程，C shell用来交互。为了改变这种状况，AT&T的bell实验室David Korn开发了Korn shell。ksh结合了所有的C shell的交互式特性，并融入了Bourne shell的语法。因此，Korn shell广受用户的欢迎。它还新增了数学计算，进程协作（coprocess）、行内编辑（inline editing）等功能。

POSIX将其标准shell制定为Korn shell的一个严格子集。

Bourne shell程序位于Unix系统的“/bin/sh”。在某些系统中，比如BSD，“/bin/sh”是一个或等同于Bourne shell，但在Linux等其他系统上，“/bin/sh”更多的是一个兼容的、更加富功能性的shell链接。

最开始在Unix系统中流行的是sh，而bash作为sh的改进版本，提供了更加丰富的功能。一般来说，都推荐使用bash作为默认的Shell。

鉴于 bash 过于复杂，有人把 bash 从 NetBSD 移植到 Linux 并更名为 dash (Debian Almquist Shell)，并将 /bin/sh 软链接指向 dash，以获得更快的脚本执行速度。Dash Shell 比 Bash Shell 小的多，符合 POSIX 标准。

Ubuntu 继承了 Debian，从 Ubuntu 6.10 开始默认是 Dash Shell。

Debian 曾经采用 /bin/bash 更改 /bin/dash，目的使用更少的磁盘空间、提供较少的功能、获取更快的速度，但是后来经过shell 脚本测试存在运行问题。因为原先在 bash shell 下可以正常运行的 shell script (shell 脚本)，在 /bin/sh 下运行 shell script 脚本还是会出现一些意想不到的问题，不是100%的兼用。


sh的全名是Bourne Shell。
bash的全名是Bourne Again Shell。
Dash的全名是Debian Almquist Shell。

其他的shell还有：dash、ksh、rsh、csh、zsh等。

```shell
# 查看当前系统支持的 shell 的类型
cat /etc/shells

# 查看当前系统中shell的类型
echo $SHELL

# 更改当前系统的默认 Shell
chsh -s /bin/zsh
或者直接修改 /etc/passwd
```
### shell 脚本

Shell 能从文件中读取命令，这样的文件称为脚本（script）。

1. 作为可执行程序
```shell
chmod +x ./test.sh  #使脚本具有执行权限
./test.sh  #执行脚本
```

直接写 test.sh，linux 系统会去 PATH 里寻找有没有叫 test.sh 的，你的当前目录通常不在 PATH 里，所以写成 test.sh 是会找不到命令的，要用 ./test.sh 告诉系统说，就在当前目录找。

```shell
#!/bin/bash
```

`#!`是一个约定的标记，它告诉系统这个脚本需要用哪一种 Shell 解释器来执行。其他的shell还有：sh、bash、dash、ksh、rsh、csh等。

2. 作为解释器参数
```shell
/bin/sh test.sh
/bin/php test.php
```
这种方式运行的脚本，不需要在第一行指定解释器信息，写了也没用。


set -u （set -o nounset）命令：让脚本遇到错误时停止执行，并指出错误的行数信息。







### 运行模式

交互式shell和非交互式shell（interactive shell and non-interactive shell）

交互式模式就是在终端上执行，输入输出都连接到终端上，shell等待你的输入，并且立即执行你提交的命令，输出命令的运行结果。

shell也可以运行在另外一种模式：非交互式模式。标准输入流和错误流没有连接到终端的shell，例如系统启动脚本、维护脚本，它们不需要交互。另外以shell script(非交互)方式执行。在这种模式下，shell不与你进行交互，而是读取存放在文件中的命令,并且执行它们。当它读到文件的结尾EOF，shell也就终止了。

-s 选项改变标准输入流输出流位置，更改后认为不是交互式吧。
-i 选项强制交互式。
sh -c "" 执行脚本，非交互式。


登录式shell：需要用户名、密码登录后才能进入的shell（通过-、-l、--login选项生成的shell）。

非登录式shell：不需要输入用户名和密码即可打开的Shell，例如：直接命令“bash”就是打开一个新的非登录shell，在Gnome或KDE中打开一个“终端”（terminal）窗口程序也是一个非登录shell。

执行exit命令，退出一个shell（登录或非登录shell）；
执行logout命令，退出登录shell（不能退出非登录shell）。

交互式配置文件执行顺序：`/etc/profile ( /etc/profile.d/*.sh ) > ~/.profile`

非交互式不执行 .bashrc 脚本的。
打开这个 shell 的时候会首先检查一个环境变量 ENV，如果不为空则执行指向的脚本。

 /etc/bash.bashrc


### FAQ

#### `$(( ))`与`$( )`还有`${ }`的区别

在 bash shell 中，`$( )`与``` ` ` ```(反引号) 都是用来做命令替换用的。


- `` ` ` ``很容易与`' '`( 单引号)搞混乱。
- 在多层次的复合替换中，` ` 须要额外的跳脱( \` )处理，而 $( ) 则比较直观。
- `` ` ` ``基本上可用在全部的 unix shell 中使用，若写成 shell script，其移植性比较高。而`$( )`并不见的每一种 shell 都能使用。


使用双括号`$(( ))`，可以使用高级数学表达式。


${ } 用来作变量替换：一般情况下，$var 与 ${var} 并没有啥不一样。但是用 ${ } 会比较精确的界定变量名称的范围。

echo $AB
echo ${A}B







### echo

-n 不加空的新行

### history

```shell
history [-c] [-d offset ] [ n ]
history -anrw [ file name ]
history -ps arg [ arg... ]
```

Options: 

- -c	Clear the history list by deleting all of the entries.
- -d offset	Delete the history entry at offset OFFSET.
- -a	Append history lines from this session to the history file.
- -n	Read all history lines not already read from the history file.
- -r	Read the history file and append the contents to the history list.
- -w	Write the current history to the history file and append them to the history list
- -p	Perform history expansion on each ARG and display the result without storing it in the history list.
- -s	Append the ARGs to the history list as a single entry.

If FILE NAME is given, it is used as the history file. Otherwise, if $HISTFILE has a value, that is used, else ~/.bash_history.

If the $HISTTIMEFORMAT variable is set and not null, its value is used as a format string for strftime to print the timestamp associated with each displayed history entry. No timestamps are printed otherwise.

### fc

FC是LINUX命令用途是处理命令历史列表，fc 命令显示了历史命令文件内容或调用一个编辑器去修改并重新执行以前在 shell 中输入的命令。

```shell
fc [-e ename] [-lnr] [first] [last]
fc -s [pat=rep] [command]
```

Options: 

- -e ENAME	Select which editor to use. Default is FCEDIT, then EDITOR, then vi.
- -l	List lines instead of editing.
- -n	Omit line numbers when listing.
- -r	Reverse the order of the lines (newest listed first).

With the 'fc -s [pat=rep ...] [command]' format, COMMAND is re-executed after the substitution OLD=NEW is performed.

A useful alias to use with this is r='fc -s', so that typing 'r cc' runs the last command beginning with 'cc' and typing 'r' re-executes the last command.

