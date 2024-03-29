## Web浏览器


### 概述
#### 历史

- 1993年发布的一款浏览器 Mosaic
很快就出现了另一个浏览器，这就是著名的Mozilla。后来Mozilla更名为Netscape，也就是网景。Mozilla后来变成了Firefox。
- 1998年2月23日，网景公司建立了Mozilla组织，开发用于测试目的的Mozilla浏览器，这个浏览器不适合直接为最终用户使用。
- 当美国在线（AOL，网景母公司）完全的从Mozilla组织中撤出后，Mozilla基金会在2003年7月15日成立了。
- 在2005年8月3日，Mozilla基金会建立了一个完全拥有的子公司叫Mozilla公司来继续开发和发布Mozilla Firefox和Mozilla Thunderbird。

基金会享有免税资格，下属机构Mozilla公司也是免税的。


### 浏览器内核
浏览器内核主要包括以下三个技术分支：排版渲染引擎、 JavaScript引擎，以及其他。

V8与WebKit被用于Chrome浏览器中。


#### JavaScript引擎
javaScript的解释、编译、执行

Mozilla
-> SpiderMonkey，第一款JavaScript引擎
-> Rhino，由Mozilla基金会管理，开放源代码，完全以Java编写。
-> TraceMonkey
-> JaegerMonkey

Google
-> V8 开放源代码，由Google丹麦开发

微软
-> Chakra(JScript引擎)

Opera
-> Linear A
-> Linear B
-> Futhark
-> Carakan

其它
-> KJS KDE的ECMAScript/JavaScript引擎
  -> Nitro（原名SquirrelFish），为Safari 4编写。
-> Narcissus 开放源代码，由Brendan Eich编写（他也参与编写了SpiderMonkey）。
-> Tamarin 由Adobe Labs编写，Flash Player 9所使用的引擎。



#### 渲染排版引擎
负责对网页语法的解释（HTML、javaScript、引入css等），并渲染（显示）网页

在Mozilla将其排版引擎（Gecko）作为独立于浏览器的一个配件之后，“排版引擎”这个词汇才被广泛使用。

网页浏览器的排版引擎也被称为页面渲染引擎


Gecko
Gecko是套开放源代码的、以C++编写的网页排版引擎。Gecko是跨平台的。
Firefox 浏览器
由Netscape公司Mozilla组织开发。1998年，Netscape在于IE浏览器竞争失利之后，成立了非正式组织Mozilla，由其开发新一代内核，后命名为“Gecko”。FireFox也是这班人开发出来了，因此这也就是Mozilla一直使用的内核。


Presto
取代了旧版 Opera 浏览器中所使用的Elektra
被Google Chrome的Blink内核取代


Trident （又称为MSHTML）
微软网页浏览器Internet Explorer
IE6、IE7、IE8（Trident 4.0）、IE9（Trident 5.0）、IE10（Trident 6.0）

由微软开发，并于1997年10月首次在ie 4.0中使用，凭借其windows垄断优势，Trident市场占有率一直很高。然而垄断并非，没有竞争就没有进步，长期以往，Trident内核一度停滞不前，更新缓慢，甚至一度与W3C标准脱节。2011年，从ie 9开始，Trident开始支持HTML5和CSS 3，因此我们也经常会看到有些网站在浏览时会提示用户（在Internet Explorer 9.0+以上浏览效果最佳）。前端程序员做浏览器兼容一般也不再会考虑ie 8之前的浏览器了。


EdgeHTML
微软网页浏览器Microsoft Edge


Tasman
微软的Internet Explorer for Mac浏览器


KHTML
由KDE在1998年开发的排版引擎。KHTML拥有速度快捷的优点，但对错误语法的容忍度则比Mozilla产品所使用的Gecko引擎小。

navigator.userAgent 中的 KHTML, like Gecko 代表伪装 Gecko 表示兼容

KHTML引擎支持下列标准：
* HTML 4.01
* HTML 5 支持
* CSS 1
* CSS 2.1 (screen and paged media)
* CSS 3 Selectors、Other (multiple backgrounds, box-sizing and text-shadow)
* PNG, MNG, JPEG, GIF 图形格式
* DOM 1, 2 及部分的 DOM 3
* ECMA-262/JavaScript 1.5
* 部分 SVG 支持


WebKit
Webkit引擎包含了WebCode排版引擎和JavaScriptCode解析引擎，分别是从KDE的KHTML和KJS衍生而来，它们都是自由软件，在GPL条约下授权，同时支持BSD系统开发。

Safari浏览器的 WebKit 所包含的 WebCore 排版引擎是KHTML的衍生产品。WebKit 早先由 Apple 由 KHTML 项目 fork 出来

在2005年，苹果宣布将WebKit完全开源（之前仅有从KHTML直接搬来的WebCore及JavaScriptCore是开源的）。

2008年，Chrome浏览器使用WebKit引擎是Android团队的建议，而Chrome主要用的其实还是从KHTML那里来的WebCore，它不太用WebCore之外苹果开发的东西，而是使用自己开发的多进程浏览器架构等。

2010 年随着 OS X Lion 一起面世的 WebKit2。由于 WebKit2 在 WebCore 层面上实现的进程隔离在一定程度上与 Google Chrome/Chromium 自己的沙箱设计存在冲突，故 Google Chrome/Chromium 一直停留在 WebKit，使用 Backport 的方式实现和主线 WebKit2 的兼容。显而易见这增加了 WebKit 和 Chromium 的复杂性，且在一定程度上影响了 Chromium 的架构移植工作。

2013年，Google 决定从 WebKit fork 出自己的 Blink Web 引擎。


WebCore包含了浏览器引擎的核心部分如处理html、dom、css、svg、获取资源、渲染页面过程控制、回调/通知外壳程序以及与Javascript实现的Binding等等；


#### 现状
WebKit      Active      <https://webkit.org/status/>
Blink       Active
EdgeHTML    Active
Gecko       Active
KHTML       Discontinued
Presto      Discontinued
Trident     Discontinued














附录：

KDE，K桌面环境(K Desktop Environment)的缩写。一种著名的运行于 Linux、Unix 以及FreeBSD 等操作系统上的自由图形桌面环境，整个系统采用的都是 TrollTech 公司所开发的Qt程序库（目前属于Digia公司）。KDE是Linux 操作系统上流行的桌面环境之一。

Konqueror是一个免费的开源Web浏览器和文件管理器，为文件系统（例如本地文件，远程FTP服务器上的文件和磁盘映像中的文件）提供Web访问和文件查看器功能。它构成了KDE软件编译的核心部分。

Konqueror于2000年10月23日首次出现在KDE的第2版。它取代了它的前身KFM（KDE文件管理器）。随着KDE 4的发布，Dolphin取代Konqueror成为默认的KDE文件管理器，但KDE社区继续将Konqueror维护为默认的KDE Web浏览器。

Qt 是一个1991年由Qt Company开发的跨平台C++图形用户界面应用程序开发框架。它既可以开发GUI程序，也可用于开发非GUI程序，比如控制台工具和服务器。Qt是面向对象的框架，使用特殊的代码生成扩展（称为元对象编译器(Meta Object Compiler, moc)）以及一些宏，Qt很容易扩展，并且允许真正地组件编程。

1991年，Haavard Nord和Eirik Chambe-Eng两位挪威软件工程师开始开发Qt框架。
1995年5月，首次发布Qt的第一个正式版本，由挪威Trolltech公司发布。
2008年6月，Trolltech公司被诺基亚公司收购，Qt也因此成为诺基亚旗下的编程语言工具。
2012年8月，Qt被芬兰IT服务公司Digia收购。
2014年4月，跨平台集成开发环境Qt Creator 3.1.0正式发布，实现了对于iOS的完全支持，新增WinRT、Beautifier等插件，废弃了无Python接口的GDB调试支持，集成了基于Clang的C/C++代码模块，并对Android支持做出了调整，至此实现了全面支持iOS、Android、WP,它提供给应用程序开发者建立艺术级的图形用户界面所需的所有功能。基本上，Qt 同 X Window 上的 Motif，Openwin，GTK 等图形界面库和 Windows 平台上的 MFC，OWL，VCL，ATL 是同类型的东西。
2014年9月，Digia 公司宣布成立“The Qt Company”全资子公司。




