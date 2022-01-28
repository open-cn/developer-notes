## network


### DNS

域名系统Domain Name System

1. 在互联网上需要用IP的，但事实上，我们在使用的时候，通常输入的是域名而不是IP。
2. 互联网上传输数据都是要用IP的，DNS所干的事，就是把域名转换为IP，也即域名解析。
3. 互联网上有非常多的域名服务器，共同完成域名解析功能。每个域名服务器内部会记录着一些域名和IP的对应（以及其他一些类似的数据），每条这样的数据称为一个记录。

#### 概述

域名系统是分层和分散的命名系统，用于识别可通过Internet或其他Internet 协议(IP) 网络访问的计算机、服务和其他资源。DNS 中包含的资源记录将域名与其他形式的信息相关联。这些最常用于将人类友好的域名映射到计算机使用底层网络协议定位服务和设备所需的数字IP 地址，但随着时间的推移已经扩展以执行许多其他功能。自 1985 年以来，域名系统一直是 Internet 功能的重要组成部分。

使用更简单、更容易记住的名称代替主机的数字地址可以追溯到 ARPANET 时代。斯坦福研究所（现为SRI International ）维护了一个名为HOSTS.TXT的文本文件，该文件将主机名映射到 ARPANET 上计算机的数字地址。Elizabeth Feinler开发并维护了第一个 ARPANET 目录。数字地址的维护，称为分配号码列表，由南加州大学信息科学研究所(ISI) 的Jon Postel负责，他的团队与 SRI 密切合作。

地址是手动分配的。通过 Feinler 指导的 SRI网络信息中心(NIC) 在工作时间致电，将计算机及其主机名和地址添加到主文件中。后来，Feinler 在 NIC 的服务器上建立了WHOIS目录，用于检索有关资源、联系人和实体的信息。她和她的团队开发了域的概念。Feinler 建议域应该基于计算机物理地址的位置。例如，教育机构的计算机将具有edu域。她和她的团队从 1972 年到 1989 年管理着主机命名注册表。

到 1980 年代初，维护一个单一的集中式主机表变得缓慢且笨重，新兴的网络需要一个自动命名系统来解决技术和人员问题。Postel 将在五个相互竞争的解决方案提案之间达成妥协的任务交给了Paul Mockapetris。Mockapetris 于 1983 年创建了域名系统。

互联网工程任务组于 1983 年 11 月在 RFC 882 和 RFC 883 中发布了原始规范。

1984 年，加州大学伯克利分校的四名学生 Douglas Terry、Mark Painter、David Riggle 和 Songnian Zhou为伯克利互联网名称域（通常称为BIND ）编写了第一个Unix名称服务器实现。1985 年，DEC的 Kevin Dunlap大幅修改了 DNS 实施。从那时起， Mike Karels、Phil Almquist 和Paul Vixie一直在维护 BIND。在 1990 年代初期，BIND 被移植到Windows NT平台。

1987 年 11 月，RFC 1034 和 RFC 1035 取代了 1983 年的 DNS 规范。一些额外的征求意见书已提议对核心 DNS 协议进行扩展。

#### DNS根服务器架构

A INTERNIC.NET（美国，弗吉尼亚州） 198.41.0.4；2001:503:ba3e::2:30
B 美国信息科学研究所（美国，加利弗尼亚州） 192.228.79.201；2001:500:84::b
C PSINet（美国，弗吉尼亚州） 192.33.4.12；2001:500:2::c
D 马里兰大学（美国马里兰州） 199.7.91.13；2001:500:2d::d
E 美国航空航天管理局（美国加利弗尼亚州） 192.203.230.10；2001:500:a8::e
F 因特网软件联盟（美国加利弗尼亚州） 192.5.5.241；2001:500:2f::f
G 美国国防部网络信息中心（美国弗吉尼亚州） 192.112.36.4；2001:500:12::d0d
H 美国陆军研究所（美国马里兰州） 198.97.190.53；2001:500:1::53
I Netnod（瑞典，斯德哥尔摩） 192.36.148.17；2001:500:7fe::53
J VeriSign（美国，弗吉尼亚州） 192.58.128.30；2001:503:c27::2:30
K RIPE NCC（英国，伦敦） 193.0.14.129；2001:7fd::1
L ICANN（美国，弗吉尼亚州） 199.7.83.42；2001:500:9f::42
M WIDE Project（日本，东京） 202.12.27.33；2001:dc3::35

根服务器主要用来管理互联网的主目录，全世界只有13台。这13台根域名服务器中名字分别为“A”至“M”，其中10台设置在美国，另外各有一台设置于英国、瑞典和日本。1个为主根服务器，放置在美国。其余12个均为辅根服务器，其中9个放置在美国，欧洲2个，位于英国和瑞典，亚洲1个，位于日本。

所有根服务器均由美国政府授权的互联网域名与号码分配机构ICANN统一管理，负责全球互联网域名根服务器、域名体系和IP地址等的管理。

这13台根服务器可以指挥Firefox或Internet Explorer这样的Web浏览器和电子邮件程序控制互联网通信。

由于根服务器中有经美国政府批准的260个左右的互联网后缀（如．com、．net等）和一些国家的指定符（如法国的．fr、挪威的．no等），自成立以来，美国政府每年花费近50多亿美元用于根服务器的维护和运行，承担了世界上最繁重的网络任务和最巨大的网络风险。

##### DNS根镜像服务器

DNS根服务器的镜像服务器

镜像服务器(Mirror server)与主服务器的服务内容都是一样的，只是放在一个不同的地方，分担主机的负载。

截至2014年10月，全球有504台根服务器，被编号为A到M共13个标号。大部分借由任播（Anycast）技术，编号相同的根服务器使用同一个IP，504台根服务器总共只使用13个IP，因此可以抵抗针对其所进行的分布式拒绝服务攻击（DDoS）。

中国大陆在北京有三台编号为L的镜像，编号为F、I、J的镜像各一台，共6台；香港有编号为D、J的镜像各2台，编号为A、F、I、L的镜像各一台，共8台；台湾则有编号为F、I、J各一台，共3台。

##### DNS协议

DNS协议的最初定义要从20世纪80年代未期开始算起，它使用了端口上的UDP和TCP协议。

UDP通常用于查询和响应，TCP用于主服务器和从服务器之间的区传送.遗憾的是，在所有UDP实现中能保证正常工作的最大包长是512字节，对于在每个包中必须含有数字签名的一些DNS新特性（例如，DNSSEC）来说实在是太小了。

512字节的限制还影响了根服务器的数量和名字。

要让所有的根服务器数据能包含在一个512字节的UDP包中，根服务器只能限制在13个，而每个服务器要使用字母表中的单个字母命名。

以太网数据的长度必须在46-1500字节之间，这是由以太网的物理特性决定的。

事实上，这个1500字节就是网络层IP数据包的长度限制，理论上，IP数据包最大长度是65535字节。

这是由IP首部16比特总长度所限制的，去除20字节IP首部和8个字节UDP首部，UDP数据包中数据最大长度为65507字节。

在Internet数据传输中，UDP数据长度控制在576字节（Internet标准MTU值），而在许多UDP应用程序设计中数据包被限制成512字节或更小。这样可以防止数据包的丢失。

许多解析器首先发送一条UDP查询，如果它们接收到一条被截断的响应，则会用TCP重新发送该查询。

这个过程绕过了512字节的限制，但是效率不高。您或许认为DNS应该避开UDP，总是使用TCP，但是TCP连接的开销大得多。

一次UDP名字服务器交换可以短到两个包：一个查询包、一个响应包。一次TCP交换则至少包含7个包：三次握手初始化TCP会话、一个查询包、一个响应包以及最后一次握手来关闭连接。

##### 根域文件

所有根域名服务器都是以同一份根域文件返回顶级域名权威服务器（包括通用顶级域和国家顶级域），文件只有550KB大小。截至2004年12月12日，一共记录了258个顶级域和773个不同的顶级域权威服务器。对于没被收录的顶级域，通过根域名服务器是没法查出相应的权威服务器。

##### 顶级域

顶级域分为国家及地区顶级域、通用顶级域、基础建设顶级域(.arpa(用于反向查询))和国际顶级域(IDN)

国家及地区代码顶级域（Country Code top-level domain,ccTLD），是用两字母的国家或地区名缩写代称的顶级域，其域名的指定及分配，政治因素考量在技术和商业因素之上。这些顶级域均由两个字母组成，大部分使用ISO 3166-1标准。

2002年时共有243个国家及地区顶级域。

2010年起，互联网号码分配局开始分配国际化国家及地区顶级域，这项改变使得国码域名可以使用当地文字，例如增加了中文国码域名(.中国及.中國、.香港、.台湾及.台灣)，国际化国码域名也不限于两个字（例如.新加坡是三个字）。

到2016年4月为止，共有303个国家及地区顶级域。

通用顶级域（Generic top-level domain, gTLD）是互联网名称与数字地址分配机构（IANA）管理的顶级域（TLD）之一。该机构专门负责互联网的域名系统。如.com;.info;.net及.org。

一个域名的所有者可以通过查询WHOIS数据库而被找到；对于大多数根域名服务器，基本的WHOIS由ICANN维护，而WHOIS的细节则由控制那个域的域注册机构维护。

对于国家及地区顶级域名，通常由该域名权威注册机构负责维护WHOIS。例如中国互联网络信息中心（China Internet Network Information Center）负责.CN域名的WHOIS维护，香港互联网注册管理有限公司（Hong Kong Internet Registration Corporation Limited）负责.HK域名的WHOIS维护，台湾网络信息中心（Taiwan Network Information Center）负责.TW域名的WHOIS维护。

##### 域维护

域维护是指通过DNS协议来在主域名服务器和从域名服务器之间维护同一个zone文件。

DNS中有两种域维护手段，一种是全量传输AXFR(full zone transfer)，另一种是增量传输IXFR(incremental zone transfer)。

1. 全量传输AXFR

全量传输时，从域名服务器从主域名服务器上请求zone文件，poll的时间间隔由SOA(Start of Authority)记录中的refresh标签定义。请求zone文件的过程是从域名服务器向主域名服务器发送查询来实现，如果主域名服务器中SOA记录中的序列号(serial number标签定义)大于从域名服务器SOA记录的序列号，从域名服务器就会向主域名服务器发送全量传输请求。所以主域名服务器一旦改变了zone文件，则需要增加它该zone中的序列号。

通常情况下，序列号sn遵循“年+月+日+编号”的格式，如2003080803表示该zone是2003年8月8日的第三次更新。

全量传输时在TCP的53端口上进行。

2. 增量传输(IXFR)

传递非常大的zone文件是非常耗资源的（时间、带宽等），尤其是只有zone中的一个记录改变的时候，没有必要传递整个zone文件，增量传输是允许主域名服务器和从域名服务器之间只传输那些改变的记录。

需要注意的是，不是所有的域名服务器都支持增量传输，当不支持增量传输时，主从间就采用全量传输的方式。

3. 通告(NOTIFY)

从服务器每隔refresh时间向主服务器发送请求，只有主服务器的SOA中的序列号大于从服务器的序列号才传输，但是如果这个时间间隔比较大的话（比如12个小时），快速变化的网络环境可能不允许有如此大时间的差异。所以在实现了通告消息的DNS集群中，DNS主服务器的zone文件发生改变后，它立即向从服务器发送一个NOTIFY消息，告诉从服务器我的zone文件发生改变了，接着从服务器马上对比两者的序列号，再采用上面介绍的全量传输或者增量传输的方法请求zone文件。BIND本身支持通告，通告的配置是在named.conf中的zone中的option中配置，配置指令是notify, also-notify和notify-source。

4. 动态更新

每次需要更新zone文件的时候都需要停止域名服务器并重启，这样当zone文件很多的时候域名服务器重启时加载zone文件需要很多的时间。所以需要有一种不停止查询服务而且快速更新zone文件地方机制，这种机制主要有两种：

一种是允许外部进程在服务器运行的时候更新zone文件；

另外一种是将zone中的资源记录RR存储在数据库中，每次查找zone中记录的时候动态读取。

##### DNS 安全

1. zone文件受到的威胁可能有：文件被无意或有意篡改或删除。这种威胁是较好应对的，最主要的方法是制定很好的系统管理策略，zone文件和其他的配置文件需要严格而安全的读写权限。
2. 动态更新和域传输受到的威胁可能有：未授权的更新、zone文件在传输过程中被篡改（经常是把域名篡改为别的IP）。这种威胁通常的应对方法是TSIG(Transaction SIGnature)策略（这个策略定义在RFC2845中）。TSIG策略中会计算出一个key，这个key是通过单向散列(能轻松地从输入得出值，但很难通过值猜出输入)计算出来的，然后传输zone文件的双方在传输过程中都带上这个key，如果key不对就拒绝传输。
3. 远程查询受到的威胁可能有：cache污染（IP欺骗、数据拦截或错误的master主机地址）。cache污染是指cache中内容可能将您的域名重定向到了一个错误的服务器。这种威胁通常的应对方法是域名系统安全扩展（DNSSEC, Domain Name System Security Extensions），它是为DNS客户端（解析器）提供的的DNS数据来源，数据完整性验证，但不提供或机密性和认证的拒绝存在扩展集。

中国用户在访问带有.com等后缀的国外网站时，大多仍需要经过国外的域名服务器进行解析，中美海底光缆一旦发生断裂，便会发生解析问题，中国东部、太平洋西海岸地区，属于地震多发地带，再加上台风等环境因素影响，形势显得更加严峻。

美国控制了域名解析的根服务器，也就控制了相应的所有域名，如果美国不想让人访问某些域名，就可以屏蔽掉这些域名，使它们的IP地址无法解析出来，那么这些域名所指向的网站就相当于从互联网的世界中消失了。比如，2004年4月，由于“.ly”域名瘫痪，导致利比亚从互联网上消失了3天。

攻击整个因特网最有力、最直接，也是最致命的方法恐怕就是攻击根域名服务器了。

1997年7月，这些域名服务器之间自动传递了一份新的关于因特网地址分配的总清单，然而这份清单实际上是空白的。这一人为失误导致了因特网出现最严重的局部服务中断，造成数天之内网面无法访问，电子邮件也无法发送。

2002年的10月21日美国东部时间下午4:45开始，这13台服务器又遭受到了有史以来最为严重的也是规模最为庞大的一次网络袭击。此次受到的攻击是DDoS攻击，超过常规数量30至40倍的数据猛烈地向这些服务器袭来并导致其中的9台不能正常运行。7台丧失了对网络通信的处理能力，另外两台也紧随其后陷于瘫痪。10月21日的这次攻击对于普通用户来说可能根本感觉不到受到了什么影响。

#### 中国互联网络信息中心

中国互联网络信息中心（China Internet Network Information Center，缩写为CNNIC），于1997年6月3日成立的互联网管理和服务机构。

中国互联网络信息中心成立伊始，由中国科学院主管、中国科学院计算机网络信息中心（CNIC）实际运行；2014年末，改由中央网络安全和信息化委员会办公室（国家互联网信息办公室）主管；2019年，改由工业和信息化部主管。现总部位于北京市中关村南四街4号中国科学院软件园1号楼。

中国的顶级域名.cn和中文域名注册管理机构

##### 争议

1. CNNIC制作的上网辅助软件“中文上网官方版软件”因其强制安装和无法彻底卸载，一度被北京市网络行业协会列入10款流氓软件名单并勒令整改。为此，CNNIC起诉把它列为流氓软件的杀毒软件制作者。

2. 有杀毒软件制作者批评CNNIC，打着官方的旗号，混淆该软件与中文域名之区别，令公众误以为国家发展中文域名，就等于支持该软件。

3. 2008年，CNNIC收回被抢注的奥运冠军域名，被回收者表示不服。

4. 2009年12月9日，CNNIC被中国中央电视台《焦点访谈》曝光对.cn域名管理不善，致使色情网站可以轻而易举地更换域名。12月11日晚，CNNIC发出公告，公告暗指从2009年12月14日9时起，禁止个人注册CN域名。2010年1月底，CNNIC要求所有cn域名提交个人身份证复印件，由于没有出台适当的隐私保护条例，遭cn域名持有者抵制，不得已将个人身份证信息提交的最后的期限推迟到3月15日。但是提交信息的并不多。

5. 2009年，中国互联网络信息中心（CNNIC）的一名员工向Mozilla申请要求将 CNNIC 加入 Mozilla 的 根证书列表，并且得到了批准。后来微软也把 CNNIC加到了Windows的根证书列表里。2015年，因CNNIC发行的一个中级CA被发现发行了Google域名的假证书，许多用户选择不信任CNNIC颁发的数字证书。并引起对CNNIC滥用证书颁发权力的担忧。2015年4月2日，Google宣布不再承认CNNIC所颁发的电子证书。4月4日，继Google之后，Mozilla也宣布不再承认CNNIC所颁发的电子证书。2016年8月，CNNIC官方网站已放弃使用自行发行的根证书签发的站点证书，改用由DigiCert颁发的证书。

#### DNS务器
##### 公共DNS服务器

谷歌公共DNS：8.8.8.8；8.8.4.4

南京信风 114DNS：114.114.114.114；114.114.115.115 有植入广告嫌疑。
114DNS安全版：114.114.114.119；114.114.115.119
114DNS家庭版：114.114.114.110；114.114.115.110

腾讯 DNSPod DNS+：119.29.29.29；119.28.28.28；182.254.118.118；182.254.116.116
360 DNS派：101.226.4.6；218.30.118.6
BAI DNS : 223.113.97.99
PdoMo-DNS：101.132.183.99；193.112.15.186
FUN DNS：119.23.248.241
骆驼云安全DNS：63.223.94.66
CuteDNS：123.206.61.167；119.29.105.234；101.236.28.23；120.77.212.84
P站DNS：123.207.137.88；115.159.220.214；115.159.146.99；123.206.21.48
HI!XNS（纯净无劫持）：40.73.101.101

微步在线 oneDNS 纯净版：117.50.10.10；52.80.52.52 节点少，速率一般，微步在线优势在于恶意拦截，纯净版不推荐。
微步在线 oneDNS 拦截版：117.50.11.11；52.80.66.66 内置的威胁拦截引擎可大幅度减少网民上网受到恶意网站攻击的危害。

CFIEC Public DNS IPv6：240c::6666；240c::6644 我国首个IPv6公共DNS

CNNIC SDNS：1.2.4.8；210.2.4.8；2001:dc7:1000::1 中央政府权威公共DNS解析系统，不做任何评价。
清华大学TUNA DNS666：101.6.6.6；2001:da8::666 教育网首选，解析结果纯净。
百度 BaiduDNS：180.76.76.76；2400:da00::6666
阿里 AliDNS：223.5.5.5；223.6.6.6；2400:3200::1；2400:3200:baba::1
中国科学技术大学 DNS：教育网：202.38.95.110；电信：202.141.160.110；移动：202.141.176.110；2001:da8:d800:95::110 多次改动DNS服务器IP，稳定性较差，支持纯净解析及5353特殊端口。


##### 中国电信DNS

58.217.249.137     58.217.249.138 江苏省南京市 南京信风网络科技有限公司DNS服务器电信节点
58.217.249.160     58.217.249.161 江苏省南京市 南京信风网络科技有限公司DNS服务器电信节点
59.51.78.210     59.51.78.211 湖南省
60.191.244.5     60.191.244.5 浙江省金华市
61.128.128.68     61.128.128.68 重庆市
61.128.192.68     61.128.192.68 重庆市
61.130.254.34     61.130.254.36 浙江省湖州市
61.132.163.68     61.132.163.68 安徽省
61.134.1.4     61.134.1.4 陕西省西安市 电信DNS
61.134.1.5     61.134.1.5 陕西省西安市
61.139.2.69     61.139.2.69 四川省成都市
61.139.39.73     61.139.39.73 四川省泸州市
61.139.54.66     61.139.54.66 四川省凉山州西昌市
61.147.37.1     61.147.37.1 江苏省
61.153.81.75     61.153.81.75 浙江省宁波市
61.166.150.101     61.166.150.101 云南省昆明市
61.166.150.123     61.166.150.123 云南省
61.166.150.139     61.166.150.139 云南省昆明市
61.177.7.1     61.177.7.1 江苏省苏州市
61.187.98.3     61.187.98.3 湖南省株洲市
61.187.98.6     61.187.98.6 湖南省株洲市

112.100.100.100     112.100.100.100 黑龙江省 电信DNS
113.111.211.22     113.111.211.22 广东省广州市
116.228.111.118     116.228.111.118 上海市
116.228.111.18     116.228.111.18 上海市
118.118.118.1     118.118.118.1 上海市 (全国通用)
118.118.118.118     118.118.118.118 上海市 (全国通用)
168.95.1.1     168.95.1.1 台湾省 中华电信(HiNet)数据中心DNS服务器
168.95.192.11 68.95.192.1 台湾省 中华电信(HiNet)数据中心DNS服务器
180.168.255.18     180.168.255.18 上海市
180.76.76.76     180.76.76.76 北京市 北京百度网讯科技有限公司公共DNS服务器(电信节点)
202.100.192.68     202.100.192.68 海南省
202.100.199.8     202.100.199.8 海南省三亚市
202.100.96.68     202.100.96.68 宁夏银川市
202.101.107.85     202.101.107.85 福建省泉州市
202.101.172.35     202.101.172.35 浙江省杭州市
202.101.172.47     202.101.172.47 浙江省杭州市
202.101.224.68     202.101.224.71 江西省
202.101.226.68     202.101.226.69 江西省九江市
202.101.6.2     202.101.6.2 上海市
202.101.98.55     202.101.98.55 福建省福州市
202.102.199.68    202.102.199.68 安徽省芜湖市
202.102.200.101     202.102.200.101 安徽省蚌埠市
202.102.213.68     202.102.213.68 安徽省
202.102.3.141     202.102.3.141 江苏省常州市
202.102.3.144     202.102.3.144 江苏省常州市
202.102.7.90     202.102.7.90 江苏省扬州市
202.102.8.141     202.102.8.141 江苏省南通市
202.103.0.117     202.103.0.117 湖北省武汉市
202.103.0.68     202.103.0.68 湖北省武汉市
202.103.176.22     202.103.176.22 广东省茂名市
202.103.224.68     202.103.224.68 广西南宁市
202.103.225.68     202.103.225.68 广西柳州市
202.103.24.68     202.103.24.68 湖北省武汉市
202.103.44.150     202.103.44.150 湖北省武汉市
202.96.103.36     202.96.103.36 浙江省
202.96.104.15     202.96.104.16 浙江省宁波市
202.96.104.25     202.96.104.26 浙江省宁波市
202.96.107.27     202.96.107.29 浙江省绍兴市
202.96.128.166     202.96.128.166 广东省广州市
202.96.128.68     202.96.128.68 广东省广州市
202.96.128.86     202.96.128.86 广东省广州市
202.96.134.133     202.96.134.133 广东省深圳市
202.96.134.33     202.96.134.33 广东省深圳市
202.96.144.47     202.96.144.47 广东省汕头市
202.96.154.15     202.96.154.15 广东省深圳市
202.96.209.133     202.96.209.133 上海市
202.96.209.5     202.96.209.6 上海市
202.96.96.68     202.96.96.68 浙江省杭州市
202.98.192.67     202.98.192.67 贵州省
202.98.198.167     202.98.198.167 贵州省
202.98.224.68     202.98.224.68 西藏拉萨市
202.98.96.68     202.98.96.68 四川省成都市
210.200.211.193     210.200.211.193 台湾省 亚太电信股份有限公司DNS服务器
210.200.211.225     210.200.211.225 台湾省 亚太电信股份有限公司DNS服务器
218.2.135.1     218.2.135.1 江苏省南京市
218.2.2.2     218.2.2.2 江苏省南京市
218.4.4.4     218.4.4.4 江苏省苏州市
218.6.200.139     218.6.200.139 四川省成都市
218.76.192.100     218.76.192.101 湖南省邵阳市
218.85.152.99     218.85.152.99 福建省福州市
218.85.157.99     218.85.157.99 福建省福州市
218.89.0.124     218.89.0.124 四川省乐山市
219.141.136.10     219.141.136.10 北京市
219.141.140.10     219.141.140.10 北京市
219.141.148.37     219.141.148.37 北京市
219.141.148.39     219.141.148.39 北京市
219.146.0.130     219.146.0.130 山东省济南市
219.146.1.66     219.146.1.66 山东省 (济南省际节点)
219.147.1.66     219.147.1.66 山东省 (济南省际节点)
219.147.198.230     219.147.198.230 黑龙江省齐齐哈尔市
219.148.204.66     219.148.204.66 辽宁省沈阳市 (全省通用)
219.149.194.55     219.149.194.56 吉林省长春市
219.149.6.99     219.149.6.99 辽宁省大连市
219.150.32.132     219.150.32.132 天津市
220.168.208.3     220.168.208.3 湖南省常德市
220.168.208.6     220.168.208.6 湖南省常德市
220.170.64.68     220.170.64.68 湖南省衡阳市
220.181.70.210     220.181.70.210 北京市 电信互联网数据中心公众DNS服务器
220.187.24.2     220.187.24.2 浙江省舟山市
220.187.24.6     220.187.24.6 浙江省舟山市
221.228.255.1     221.228.255.1 江苏省无锡市
221.232.129.30     221.232.129.30 湖北省武汉市
222.172.200.68     222.172.200.68 云南省
222.221.0.9     222.221.0.12 云南省昆明市
222.221.5.240     222.221.5.241 云南省昆明市 云南电信公众信息产业有限公司DNS服务器
222.222.222.222     222.222.222.222 河北省石家庄市
222.243.129.81     222.243.129.81 湖南省
222.75.152.129     222.75.152.129 宁夏银川市
222.85.85.85     222.85.85.85 河南省
222.88.88.88     222.88.88.88 河南省洛阳市

##### 中国移动DNS

112.4.0.55     陕西 西安
211.103.13.101    江苏 无锡
211.103.55.50     江苏 苏州
211.136.112.50 上海
211.136.150.66 上海
211.136.17.107    湖北 荆州
211.136.17.108   广西 南宁
211.136.18.171   广东 深圳
211.136.192.6     广东
211.136.20.203    湖北 咸宁
211.136.20.204   广东 广州
211.136.28.228    北京
211.136.28.231    北京
211.136.28.234    北京
211.136.28.237    北京
211.137.130.19    陕西
211.137.130.3     陕西 西安
211.137.160.185 天津
211.137.160.5   天津
211.137.191.26    山东 济南
211.137.241.34 黑龙江 哈尔滨
211.137.241.35 黑龙江 哈尔滨
211.137.32.178   辽宁 沈阳
211.137.58.20      湖北 武汉
211.137.64.163    湖北 武汉
211.137.82.4     四川
211.138.106.18    山西
211.138.106.19    山西
211.138.106.2     山西 吕梁
211.138.106.3     山西
211.138.106.7     山西 运城
211.138.13.66    河北 邯郸
211.138.151.161  福建 福州
211.138.156.66    福建 福州
211.138.164.6   海南 海口
211.138.180.2     安徽 淮北
211.138.180.3     安徽 淮北
211.138.200.69    江苏 常州
211.138.242.18   广西 南宁
211.138.245.180  广西
211.138.30.66     北京
211.138.75.123  青海 西宁
211.138.91.1       内蒙古 巴彦淖尔
211.138.91.2    内蒙古 呼和浩特
211.139.136.68   广东
211.139.163.6    广东
211.139.29.68      云南
211.139.5.29    贵州 贵阳
211.139.5.30    贵州 贵阳
211.139.73.34    西藏 拉萨
211.139.73.35    西藏 拉萨
211.140.10.2     浙江 金华
211.140.13.188    浙江 杭州
211.140.188.188  浙江 舟山
211.140.197.58   辽宁 大连
211.141.0.99    吉林 吉林
211.141.16.99       吉林
211.141.85.68     江西 南昌
211.141.90.68     江西 赣州
211.141.90.69     江西 南昌
211.142.210.100 湖南 湘潭
211.142.210.101 湖南 岳阳
211.142.210.98 湖南 株洲
211.142.210.99 湖南 长沙
211.142.236.87 湖南 株洲
211.143.181.178  福建 福州
211.143.181.179  福建 福州
211.143.60.56    河北 石家庄
218.200.6.139      陕西 西安
218.201.124.18    山东 淄博
218.201.124.19    山东 淄博
218.201.17.2     重庆
218.201.21.132    重庆
218.201.4.3     重庆
218.201.96.130    山东 烟台
218.202.1.166     云南 昭通
218.202.152.130 新疆 乌鲁木齐
218.202.152.131 新疆 乌鲁木齐
218.203.160.194 甘肃 兰州
218.203.160.195 甘肃 兰州
218.207.128.4     福建 泉州
218.207.130.118  福建 泉州
218.207.217.241  福建 福州
218.207.217.242  福建 福州
221.130.13.133    江苏 南京
221.130.162.223  安徽 安庆
221.130.32.100    北京
221.130.32.103    北京
221.130.32.106    北京
221.130.32.109    北京
221.130.33.52      北京
221.130.33.60      北京
221.130.56.241    江苏 无锡
221.131.143.69    江苏 徐州
221.176.88.95   海南 海口
221.179.35.81     重庆
221.179.38.7     重庆

##### 中国联通DNS

58.22.96.66  福建省
58.240.57.33  江苏省南京市
58.241.208.46  江苏省盐城市
58.242.2.2  安徽省合肥市
60.12.166.166  浙江省金华市
61.135.164.13 61.135.164.18 北京市

113.207.20.15 113.207.20.18 重庆市 阿里巴巴(中国)有限公司公共DNS服务器联通节点
119.6.6.6  四川省成都市
123.125.81.6  北京市 上海聚流软件科技有限公司公共DNS服务器联通节点
124.161.97.234  四川省
124.161.97.238  四川省
124.161.97.242  四川省
140.207.198.6  上海市 上海聚流软件科技有限公司公共DNS服务器联通节点
202.102.134.68 202.102.134.70 山东省青岛市
202.102.152.3  山东省济南市
202.102.154.3  山东省济南市
202.102.224.68  河南省
202.102.227.68  河南联通xDSL
202.106.0.20  北京市
202.106.196.115 北京市
202.106.196.233 202.106.196.234 北京市
202.106.46.151  北京市
202.96.64.68  辽宁省沈阳市
202.96.69.38  辽宁省大连市
202.96.75.68  辽宁省沈阳市
202.96.86.18  辽宁省抚顺市
202.97.224.68 202.97.224.69 黑龙江省
202.98.0.68  吉林省长春市
202.98.1.11  吉林省长春市
202.98.5.68  吉林省长春市
202.99.104.68  天津市
202.99.160.68  河北省
202.99.166.4  河北省
202.99.168.8  河北省保定市
202.99.192.66  山西省太原市
202.99.192.68  山西省太原市
202.99.224.67  内蒙古呼和浩特市(cns)
202.99.224.68  内蒙古呼和浩特市(nmdns)
202.99.224.8  内蒙古呼和浩特市(netcool)
202.99.96.68  天津市
203.93.185.33 203.93.185.34 新疆乌鲁木齐市
210.21.196.6  广东省深圳市
210.22.70.3  上海市
211.90.72.65  内蒙古呼和浩特市
211.90.80.65  山西省太原市
211.91.88.129  安徽省合肥市
211.92.136.81  贵州省贵阳市
211.93.24.129  黑龙江省哈尔滨市
211.93.64.129  吉林省(全省通用)
211.95.1.97  上海市
211.95.193.97  广东省广州市
211.95.72.1  上海市
211.97.64.129 211.97.64.130 广西南宁市
211.97.96.65  海南省海口市
218.104.111.114  湖北省武汉市
218.104.111.122  湖北省武汉市
218.104.128.106  福建省
218.104.32.106  江苏省苏州市
218.24.249.18  辽宁省盘锦市
218.24.249.2  辽宁省盘锦市
218.29.106.250  河南省郑州市
218.29.117.126  河南省郑州市
218.29.12.166  河南省南阳市
218.29.122.70  河南省郑州市
218.29.156.138  河南省三门峡市
218.29.172.149  河南省濮阳市
218.29.174.166  河南省濮阳市
218.29.188.210  河南省郑州市
218.29.188.243  河南省郑州市
218.29.193.118  河南省郑州市
218.29.203.182 18.29.203.18 河南省郑州市
218.29.209.106  河南省郑州市
218.29.222.108  河南省郑州市新密市
218.29.223.150  河南省郑州市新密市
218.29.228.70  河南省郑州市巩义市
218.29.236.14  河南省郑州市
218.29.237.82  河南省郑州市
218.29.254.154  河南省漯河市
218.29.39.19  河南省南阳市
218.29.4.227  河南省南阳市
218.29.4.249  河南省南阳市
218.29.42.233  河南省南阳市
218.29.5.148  河南省南阳市
218.29.7.233  河南省南阳市
218.29.72.222 18.29.72.22 河南省郑州市
218.29.90.149  河南省郑州市
220.248.192.12 220.248.192.13 江西省南昌市
221.11.132.2  海南省海口市
221.12.1.226 221.12.1.228 浙江省杭州市
221.12.33.227 221.12.33.228 浙江省宁波市
221.12.65.227 221.12.65.228 浙江省温州市
221.3.131.11 221.3.131.12 云南省
221.4.66.66  广东省广州市
221.5.203.86  重庆市
221.5.203.90  重庆市
221.5.203.98 221.5.203.99 重庆市
221.6.4.66 221.6.4.67 江苏省南京市
221.7.1.20 221.7.1.21 新疆
221.7.128.68  广西南宁市
221.7.136.68  广西柳州市
221.7.34.10  甘肃省兰州市
221.7.92.86  重庆市
221.7.92.98  重庆市


#### DNS记录

递归DNS所采用的递归式查询

##### NS记录

如果DNS给你回应一条NS记录，就是告诉你，这个家伙是某个域的权威DNS，有事你去问它。

##### A记录

A记录就是最经典的域名和IP的对应。

##### CNAME记录

这种记录比较有趣，你问DNS一个域名，它回CNAME记录，意思是说，你要解析的这个域名，还有另一个域名(也就是别名)，你去解析那个好了。

#### DNS 缓存

操作系统缓存

应用缓存