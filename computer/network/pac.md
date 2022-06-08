## PAC

代理自动配置，Proxy Auto Config

### 概述

PAC是一种网页浏览器技术，用于定义浏览器该如何自动选择适当的代理服务器来访问一个网址。

一个PAC文件包含一个JavaScript形式的函数“FindProxyForURL(url, host)”。这个函数返回一个包含一个或多个访问规则的字符串。用户代理根据这些规则适用一个特定的代理器或者直接访问。当一个代理服务器无法响应的时候，多个访问规则提供了其他的后备访问方法。浏览器在访问其他页面以前，首先访问这个PAC文件。PAC文件中的URL可能是手工配置的，也可能是是通过网页的网络代理自动发现协议（WPAD）自动配置的。

简单来说，PAC是一种自动选择每一个连接是否使用代理服务器，以及选用哪一个代理服务器的技术，而自动选择是通过一个JavaScript脚本文件实现的，这个脚本文件制定了一系列的规则进行判断。

我们选择在系统代理模式中选择PAC模式后，PAC才会生效。
在系统设置里面可以看到PAC脚本地址：http://127.0.0.1:1080/pac?auth=xxx





### 语法规则

- 通配符支持：`*.example.com/*`实际书写时可省略`*`，即：`.example.com/`
- 正则表达式支持：以`\`开始和结束，`\[\w]+:\/\/example.com\`
- 例外规则`@@`：`@@||example.com`，意思是所有 example .com域名下的网址都不走代理
- 匹配地址开始和结尾规则`|`：`|http://example.com、example.com|`，起止规则，意思是以 http://example.com 开始和以 example.com 结束的地址都走代理
- 全匹配规则`||`：`||example.com`，意思是所有 example.com 域名下的网址都走代理（注意：后面需要半角逗号，即英文输入法下逗号）
- 注释规则`!`：

更多语法规则，可以参考AdBlockPlus过滤规则https://adblockplus.org/zh_CN/filters

https://adblockplus.org/en/filter-cheatsheet


