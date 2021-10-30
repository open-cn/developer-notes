## ganglia


Ganglia是UC Berkeley发起的一个开源集群监视项目。

Ganglia是一款为HPC（高性能计算）集群而设计的可扩展的分布式监控系统，它可以监视和显示集群中的节点的各种状态信息，它由运行在各个节点上的gmond守护进程来采集CPU 、内存、硬盘利用率、I/O负载、网络流量情况等方面的数据，然后汇总到gmetad守护进程下，使用rrdtool存储数据，最后将历史数据以曲线方式通过PHP页面呈现。

Ganglia的特点如下：

- 良好的扩展性，分层架构设计能够适应大规模服务器集群的需要
- 负载开销低，支持高并发
- 广泛支持各种操作系统（UNIX等）和cpu架构，支持虚拟机

#### WEB 解读
gweb由：Main、Search、Views、Aggregate Graphs、Compare Hosts、Events、Reports、Automatic Rotation、Live Dashboard、Cubism、Mobile这些选项卡组成，用户可以快速查看所需信息。


1、全局网格视图

网格grid是所有集群的集合，在这个grid全局视图中，可以看到每个集群的的图形信息，grid是可用视图中的最高层视图。

```
MyGrid Grid > --Choose a Source

MyGrid Grid (2 sources) (tree view)
CPUs Total:	8
Hosts up:	7
Hosts down:	0
 
Current Load Avg (15, 5, 1m):
  39%, 38%, 40%
Avg Utilization (last hour):
  42%
Localtime:
  2021-10-30 00:43

hadoop_cluster_masters (physical view)
CPUs Total:	4
Hosts up:	4
Hosts down:	0
 
Current Load Avg (15, 5, 1m):
  62%, 59%, 61%
Avg Utilization (last hour):
  71%
Localtime:
  2021-10-30 00:45

hadoop_cluster_workers (physical view)
CPUs Total:	4
Hosts up:	3
Hosts down:	0
 
Current Load Avg (15, 5, 1m):
  16%, 16%, 14%
Avg Utilization (last hour):
  14%
Localtime:
  2021-10-30 00:45

Snapshot of the MyGrid Grid
hadoop_cluster_masters	hadoop_cluster_workers

```

2、集群视图和物理视图

集群视图是某个集群的图形展示，其实集群是许多gmond推送过来数据的集合，集群视图顶部显示了整个集群的综合数据统计。可以在集群视图中快速查看每个主机的各种数据（默认收集cpu、内存、磁盘、网络、load、等信息）。请看下面截图：


上图只是显示了集群视图一半的内容，下图显示了集群另一半内容：



在这个界面中，可以选择要查看的监控数据指标，还可以通过关键字来过滤需要查看的监控数据指标，另外对图形的展示方式（大小、排列方式）都可以进行定制显示。可以看到，ganglia web可以非常方便的对集群所有主机的状态进行综合、整体查看，有助于了解集群整体运行状况。

此外，ganglia对集群下每个主机的负载通过不同的颜色进行标识，点击上图的“图例”可以查看每个颜色代表的负载等级，如下图所示：



如果集群某节点显示红色或者橙色，那么就需要注意了，此节点可能负载较高，需要检查是什么原因导致的负载升高。

下面再看一下集群的物理视图，在集群视图的右上角点击“查看物理状态”，如下图所示：



在上图中随便挑选一台主机，点击进入，进入某台主机的物理视图界面，如下图所示：



3、主机视图

点击上图右上角“查看主机状态”回到主机视图界面。这个界面展示了某台主机的主机视图信息，如下图所示：



这个界面中是针对某个主机监控数据的详细汇总，最上面的图形仍然是默认的汇总图（load、内存、CPU、网络），而在下面显示了此主机其它监控指标，例如disk、process维度、cpu维度等，这些监控指标都是ganglia默认自带的，当然，我们也可以构建自己需要的监控指标，这就是扩展ganglia监控，后面马上会介绍到。

在上图中点击任意一个监控指标，即可查看更详细的监控状态数据，如下图所示：



在这个图中，显示了监控项“bytes_in”的详细监控数据，从图中可以看出，分别显示了1个小时、2个小时、4个小时、1天、1周、1个月、1年的数据状态统计。

监控项“bytes_in”表示每秒收到的字节数，它有四个值，分别是“Now”、“Min”、“Avg”、“Max”，分别表示现在收到的字节数、最小字节数、平均字节数和最大字节数。

这里又说到了监控项，那么ganglia web中默认包含了很多监控项，了解每个监控项的含义对于读懂ganglia web曲线图非常重要，那么这些默认的监控项都代表什么含义呢，下面就详细介绍下每个监控项的含义。












