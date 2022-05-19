## Apt

Advanced Package Tool，又名apt-get，是一款适用于Unix和Linux系统的应用程序管理器。

### 概述

最初于1998年发布，用于检索应用程序并将其加载到Debian Linux系统。主要用于自动从互联网的软件仓库中搜索、安装、升级、卸载软件或操作系统。

Apt-get成名的原因之一在于其出色的解决软件依赖关系的能力。其通常使用.deb-formatted文件，但经过修改后可以使用apt-rpm处理红帽的Package Manager（RPM）文件。

Apt-get在Linux社区得到广泛使用，成为用来管理桌面、笔记本和网络的重要工具。随着Linux在企业中的普及，Windows和Mac用户了解如何使用apt-get加载应用程序有一定的好处。

另外，随着单片机设备如Raspberry Pi的热度增加，apt-get在这些平台上是比较便捷的应用加载方式。如果你想要加载的应用需要程序库或另一个应用程序才能正常工作，apt-get会帮你找到并加载所需的程序库或应用代码。

使用apt-get的主流Linux系统包括Debian和Ubuntu变异版本。大多数情况下，从命令行运行该工具。桌面上有几个图形前端可以使用，包括Synaptic Package Manager、Ubuntu Software Center、Aptitude和Kpackage。

Raspberry Pi和Beaglebone Black nanoLinux版用户可以很容易地使用apt-get加载程序，因为这些系统通常来自Ubuntu或Debian代码。是debian，ubuntu发行版的包管理工具，与红帽中的yum工具非常类似。

apt-get命令一般需要root权限执行，所以一般跟着sudo命令。

apt 命令行实用程序于2014年推出第一个稳定版本，用于 Debian 发行版 .deb 软件包安装。它最初在不稳定的Debian版本中使用，然后在Debian 8中成为标准。

在 Ubuntu 16.04 发行后，apt 开始流行，并以某种方式取代了 apt-get 。

随着 apt install package 命令的使用频率和普遍性逐步超过 apt-get install package，越来越多的其它 Linux 发行版也开始遵循 Ubuntu 的脚步，开始鼓励用户使用 apt 而不是 apt-get。

大多数人不了解 apt 和 apt-get 之间的区别，并且经常在使用一个或另一个时感到困惑。

两者都是开源命令行工具，用于管理软件包，例如安装，更新，升级和删除。

但是，它们之间仍然存在一些差异。

目前还没有任何 Linux 发行版官方放出 apt-get 将被停用的消息，至少它还有比 apt 更多、更细化的操作功能。对于低级操作，仍然需要 apt-get。

现在这两个命令场景分化了，apt命令是给人用的，apt-get是给脚本自动化用的。






