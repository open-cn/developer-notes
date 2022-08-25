## 虚拟专用网络

Virtual Private Network，VPN

VPN的真正作用：在互联网上建立一条虚拟的加密通道。提供给企业之间或者个人与公司之间安全数据传输的隧道，OpenVPN无疑是Linux下开源VPN的先锋，提供了良好的性能和友好的用户GUI。

OpenVPN 是一个基于 OpenSSL 库的应用层 VPN 实现。和传统 VPN 相比，它的优点是简单易用。

它大量使用了OpenSSL加密库中的SSLv3/TLSv1协议函数库。
目前OpenVPN能在Solaris、Linux、OpenBSD、FreeBSD、NetBSD、Mac OS X与Microsoft Windows以及Android和iOS上运行，并包含了许多安全性的功能。它并不是一个基于Web的VPN软件，也不与IPsec及其他VPN软件包兼容。

NetworkExtension是苹果提供的用于配置 VPN 和定制、扩展核心网络功能的框架。Network Extension 最早出现在 iOS 8，不过只能调用 iOS 系统自带的 IPSec 和 IKEv2 协议的 VPN。在 iOS 9 中，开发者终于可以实现非标准化的私密VPN技术。连上以后，Status Bar上都会有一个“VPN”的标示，尽管那不一定是VPN。



### 虚拟网卡

OpenVpn的技术核心是虚拟网卡，其次是SSL协议实现。

虚拟网卡是使用网络底层编程技术实现的一个驱动软件，安装后在主机上多出现一个网卡，可以像其它网卡一样进行配置。服务程序可以在应用层打开虚拟网卡，如果应用软件（如IE）向虚拟网卡发送数据，则服务程序可以读取到该数据，如果服务程序写合适的数据到虚拟网卡，应用软件也可以接收得到。虚拟网卡在很多的操作系统下都有相应的实现，这也是OpenVpn能够跨平台一个很重要的理由。

在OpenVpn中，如果用户访问一个远程的虚拟地址（属于虚拟网卡配用的地址系列，区别于真实地址），则操作系统会通过路由机制将数据包（TUN模式）或数据帧（TAP模式）发送到虚拟网卡上，服务程序接收该数据并进行相应的处理后，通过SOCKET从外网上发送出去，远程服务程序通过SOCKET从外网上接收数据，并进行相应的处理后，发送给虚拟网卡，则应用软件可以接收到，完成了一个单向传输的过程，反之亦然。


### 网络

OpenVPN所有的通信都基于一个单一的IP端口， 默认且推荐使用UDP协议通讯，同时TCP也被支持。

OpenVPN连接能通过大多数的代理服务器，并且能够在NAT的环境中很好地工作。服务端具有向客户端“推送”某些网络配置信息的功能，这些信息包括：IP地址、路由设置等。

OpenVPN提供了两种虚拟网络接口：通用Tun/Tap驱动，通过它们，可以建立三层IP隧道，或者虚拟二层以太网，后者可以传送任何类型的二层以太网络数据。传送的数据可通过LZO算法压缩。

在选择协议时候，需要注意2个加密隧道之间的网络状况，如有高延迟或者丢包较多的情况下，请选择TCP协议作为底层协议，UDP协议由于存在无连接和重传机制，导致要隧道上层的协议进行重传，效率非常低下。

IANA（Internet Assigned Numbers Authority）指定给OpenVPN的官方端口为1194。OpenVPN 2.0以后版本每个进程可以同时管理数个并发的隧道。

OpenVPN使用通用网络协议（TCP与UDP）的特点使它成为IPsec等协议的理想替代，尤其是在ISP（Internet service provider）过滤某些特定VPN协议的情况下。


### 加密和验证

OpenVPN使用OpenSSL库加密数据与控制信息：它使用了OpenSSL的加密以及验证功能，意味着，它能够使用任何OpenSSL支持的算法。它提供了可选的数据包HMAC功能以提高连接的安全性。此外，OpenSSL的硬件加速也能提高它的性能。

OpenVPN提供了多种身份验证方式，用以确认参与连接双方的身份，包括：预享私钥，第三方证书以及用户名/密码组合。预享密钥最为简单，但同时它只能用于建立点对点的VPN；基于PKI的第三方证书提供了最完善的功能，但是需要额外的精力去维护一个PKI证书体系。

OpenVPN2.0后引入了用户名/口令组合的身份验证方式，它可以省略客户端证书，但是仍有一份服务器证书需要被用作加密。


### 安全

OpenVPN与生俱来便具备了许多安全特性：它在用户空间运行，无须对内核及网络协议栈作修改；初始完毕后以chroot方式运行，放弃root权限；使用mlockall以防止敏感数据交换到磁盘。

OpenVPN通过PKCS#11支持硬件加密标识，如智能卡。



### 其他软件

- OpenSSH，能实现二/三层的基于隧道的VPN。
- stunnel，使用SSL向任何单一端口的TCP服务提供安全保护。







