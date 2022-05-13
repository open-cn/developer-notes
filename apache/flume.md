## Flume

Flume 是一个分布式，高可用，高可靠的的系统。用来采集，聚集和传输大量的日志数据从不同的数据源到某一个数据中心。

另外，Flume 不仅仅局限于日志文件的聚集。因为数据源可以自定义，Flume 可以用来传输大量的事件数据(event data)，比如: 网络流量数据(network traffic data)，社交媒体产生的数据(social-media-generated data)，电子邮件信息(email messages)和其他任何可能的数据源。

1） Flume官网地址

http://flume.apache.org/

2）文档查看地址

http://flume.apache.org/FlumeUserGuide.html

3）下载地址

http://archive.apache.org/dist/flume/


### 概述

Flume是由 cloudera 软件公司产出的可分布式日志收集系统，后于 2009 年被捐赠给了 Apache 软件基金会，为 Hadoop 相关组件之一。

Flume 初始的发行版本目前被统称为 Flume OG（original generation），属于 cloudera。

但随着 FLume 功能的扩展，Flume OG 代码工程臃肿、核心组件设计不合理、核心配置不标准等缺点暴露出来，尤其是在 Flume OG 的最后一个发行版本 0.9.4 中，日志传输不稳定的现象尤为严重。

为了解决这些问题，对 Flume 进行了里程碑式的改动：重构核心组件、核心配置以及代码架构，重构后的版本统称为 Flume NG（next generation）；改动的另一原因是将 Flume 纳入 apache 旗下，cloudera Flume 改名为 Apache Flume。

同时 Flume 内部的各种组件不断丰富，用户在开发的过程中使用的便利性得到很大的改善，现已成为 Apache Top 项目之一。



Flume分布式系统中最核心的角色是agent，flume采集系统就是由一个个agent所连接起来形成。每一个agent相当于一个数据(被封装成Event对象)传递员，内部有三个组件：

Source

采集组件，用于跟数据源对接，以获取数据。

Sink

下沉组件，用于往下一级agent传递数据或者往最终存储系统传递数据。

Channel

传输通道组件，用于从source将数据传递到sink。

进入flume目录，执行启动命令：

cd ~/flume
./bin/flume-ng agent -c ./conf/ -f ./conf/log-kafka.properties -n agent -Dflume.root.logger=INFO,console



