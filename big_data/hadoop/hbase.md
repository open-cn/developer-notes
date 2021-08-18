## HBase

HBase是Hadoop Database的简称，是建立在Hadoop文件系统之上的分布式面向列的数据库，为横向发展类型数据库，提供快速随机访问海量结构化数据，它是Hadoop生态系统，提供对数据的随机实时读/写访问，是Hadoop文件系统的一部分，利用了Hadoop的文件系统(HDFS)提供的容错能力。

HBase是分布式、面向列族的开源数据库，HDFS为HBase提供可靠的底层数据存储服务，MapReduce为HBase提供高性能的计算能力，Zookeeper为HBase提供稳定服务和Failover机制，可以说,HBase是一个通过大量廉价的机器解决海量数据的高速存储和读取的分布式数据库解决方案。

HBase 是一个高可靠性、高性能、面向列、可伸缩的分布式存储系统，利用 Hbase 技术可在廉价 PC Server 上搭建起大规模结构化存储集群。

HBase 的目标是存储并处理大型的数据，更具体来说是仅需使用普通的硬件配置，就能够处理由成千上万的行和列所组成的大型数据。

Hbase是一种NoSQL数据库，非常适用于海量明细数据（十亿、百亿）的随机实时查询，如交易清单、轨迹行为等。

HBase并不快，只是当数据量很大的时候它慢的不明显。

### 概述

2006 年 Google 技术人员 Fay Chang 发布了一篇文章 Bigtable: A Distributed Storage System for Structured Data。该文章向世人介绍了一种分布式的数据库，这种数据库可以在局部几台服务器崩溃的情况下继续提供高性能的服务。

2007年 Powerset 公司的工作人员基于此文研发了 BigTable 的Java 开源版本，即HBase。刚开始它只是 Hadoop 的一部分。

2008年 HBase 成为了 Apache 的一个子项目。HBase 几乎实现了 BigTable 的所有特性。它被称为一个开源的非关系型分布式数据库。

2010 年成为 Apache 的顶级项目. HBase 的开发速度打破了一直以来跟 Hadoop 版本一致的惯例，因为 HBase 的版本发布速度已经超越了 Hadoop。它的版本号一下从 0.20.x 跳跃到了 0.89.x。

#### 与 Google BigTable 的区别
HBase 是 Google BigTable 的开源实现，但是也有很多不同之处：

- Google BigTable 利用 GFS 作为其文件存储系统，HBase 利用 Hadoop HDFS 作为其文件存储系统；
- Google 运行 MAPREDUCE来处理 BigTable 中的海量数据，HBase 同样利用 Hadoop MapReduce 来处理 HBase 中的海量数据；
- Google BigTable 利用 Chubby 作为协同服务，HBase 利用 Zookeeper 作为对应。


#### 特点
- 海量存储

    Hbase 适合存储 PB 级别的海量数据，在 PB 级别的数据以及采用廉价 PC 存储的情况下，能在几十到百毫秒内返回数据。这与Hbase的极易扩展性息息相关。

    正式因为Hbase良好的扩展性，才为海量数据的存储提供了便利。

- 列式存储
 
    这里的列式存储其实说的是列族存储，Hbase是根据列族来存储数据的。

    列族下面可以有非常多的列，列族在创建表的时候不必指定列。

- 极易扩展

    Hbase 的扩展性主要体现在两个方面：

    - 一个是基于上层处理能力（RegionServer）的扩展，
    -  一个是基于存储的扩展(HDFS)

    通过横向添加 RegionSever 的机器，进行水平扩展，提升 Hbase 上层的处理能力，提升 Hbsae 服务更多 Region 的能力。

    备注：RegionServer 的作用是管理 region、承接业务的访问，通过横向添加 Datanode 的机器，进行存储层扩容，提升Hbase 的数据存储能力和提升后端存储的读写能力。

- 高并发
 
    由于目前大部分使用 Hbase 的架构，都是采用的廉价 PC，因此单个 IO 的延迟其实并不小，一般在几十到上百ms之间。这里说的高并发，主要是在并发的情况下，Hbase 的单个 IO 延迟下降并不多。能获得高并发、低延迟的服务。

- 稀疏

    稀疏主要是针对 Hbase 列的灵活性，在列族中，你可以指定任意多的列，在列数据为空的情况下，是不会占用存储空间的。


### 架构
![Hbase 架构图](images/hbase0.png)

在 Hbase 中有两种服务器:Master 服务器、RegionServer 服务器。一般一个 HBase 集群有一个 Master 服务器和几个 RegionServer 服务器。Master 服务器负责维护表结构信息，实际的数据都存储在 RegionServer 服务器上.

客户端获取数据由客户端直连 RegionServer 的，所以当Master挂掉之后依然可以查询数据，但就是不能新建表了。

RegionServer 是直接负责存储数据的服务器。RegionServer 保存的表数据直接存储在 Hadoop 的 HDFS 上。

RegionServer 非常依赖 ZooKeeper 服务，可以说没有 ZooKeeper 就没有 HBase。

ZooKeeper 在 HBase 中扮演的角色类似一个管家。ZooKeeper 管理了 HBase 所有RegionServer 的信息，包括具体的数据段存放在哪个 RegionServer 上。

客户端每次与 HBase 连接，其实都是先与 ZooKeeper 通信，查询出哪个 RegionServer 需要连接，然后再连接 RegionServer。

#### Master
可能你们会想当然地觉得 Master 是 HBase 的领导，所有的数据、所 有的操作都会经过它。错！其实在HBase中Master的角色不像领导，更像是打杂的。

客户端从 ZooKeeper 获取了 RegionServer 的地址后，会直接从RegionServer 获取数据。其实不光是获取数据，包括插入、删除等所有的数据操作都是直接操作 RegionServer，而不需要经过 Master。

Master 只负责各种协调工作（其实就是打杂），比如建表、删表、移动Region、合并等操作。它们的共性就是需要跨 RegionServer，这些操作由哪个 RegionServer 来执行都不合适，所以 HBase 就将这些操作放到了 Master 上了。

这种结构的好处是大大降低了集群对 Master 的依赖。而 Master 节点一般只有一个到两个，一旦宕机，如果集群对Master的依赖度很大，那么就会产生单点故障问题。

在 HBase 中，即使Master宕机了，集群依然可以正常地运行，依然可以存储和删除数据。

但是, 如果 Master 长时间宕机也是不行的, 毕竟他还是有一些工作需要做的.

主要功能：

1. 监控 RegionServer 
2. 处理 RegionServer 故障转移 
3. 处理元数据的变更 
4. 处理 Region 的分配或转移 
5. 在空闲时间进行数据的负载均衡 
6. 通过 Zookeeper 发布自己的位置给客户端


#### RegionServer
RegionServer 就是存放 Region 的容器，直观上说就是服务器上的一个服务(进程)。

一般来说，一个服务器只会安装一个 RegionServer 服务，不过你实在想在一个服务器上装多个 RegionServer 服务也不是不可以。

当客户端从 ZooKeeper 获取 RegionServer 的地址后，它会直接从 RegionServer获取数据。

优点类似于 Hadoop 中的 DataNode

RegionServer 主要工作：

1. 负责存储 HBase 的实际数据 
2. 处理分配给它的 Region 
3. 刷新缓存到 HDFS 
4. 维护 Hlog 
5. 执行压缩 
6. 负责处理 Region 分片

#### Region
Region 就是一段数据的集合。HBase中的表一般拥有一个到多个 Region。

Region有以下特性：

- Region 不能跨服务器，一个 RegionServer 上有一个或者多个 Region。
- 数据量小的时候，一个 Region 足以存储所有数据；但是，当数据量大的时候，HBase会拆分 Region。
- 当 HBase 在进行负载均衡的时候，也有可能会从一台 RegionServer 上把 Region移动到另一台 RegionServer 上。
- Region 是基于 HDFS 的，它的所有数据存取操作都是调用了 HDFS 的客户端接口来实现的。


### 存储

最基本的存储单位是列（column），一个列或者多个列形成一行 （row）。

传统数据库是严格的行列对齐。比如这行有三个列a、b、c， 下一行肯定也有三个列a、b、c。

而在HBase中，这一行有三个列 a、b、 c，下一个行也许是有 4 个列a、e、f、g。在HBase 中，行跟行的列可以完全不一样，这个行的数据跟另外一个行的数据也可以存储在不同的机器上，甚至同一行内的列也可以存储在完全不同的机器上！

每个行（row）都拥有唯一的行键（row key）来标定这个行的唯一性。每个列都有多个版本，多个版本的值存储在单元格（cell）中。

若干个列又可以被归类为一个列族。

![hbase 表结构](images/hbase1.png)


#### OLTP和OLAP
数据处理大致可以分成两大类：联机事务处理OLTP（on-line transaction processing）、联机分析处理OLAP（On-Line Analytical Processing）。

OLTP是传统的关系型数据库的主要应用，主要是基本的、日常的事务处理，例如银行交易。

面向行的数据库适用于联机事务处理(OLTP)，这样的数据库被设计为小数目的行和列。

OLAP是数据仓库系统的主要应用，支持复杂的分析操作，侧重决策支持，并且提供直观易懂的查询结果。

面向列的数据库适用于在线分析处理(OLAP)，可以设计为巨大表。


#### 名词概念

##### 1. Rowkey的概念
Rowkey的概念和mysql中的主键是完全一样的，Hbase使用Rowkey来唯一的区分某一行的数据。

Hbase只支持3种查询方式：

1. 基于Rowkey的单行查询 
2. 基于Rowkey的范围扫描 
3. 全表扫描

因此，Rowkey对Hbase的性能影响非常大，Rowkey的设计就显得尤为的重要。设计的时候要兼顾基于Rowkey的单行查询也要兼顾Rowkey的范围扫描。

rowkey 行键可以是任意字符串(最大长度是64KB，实际应用中长度一般为 10-100bytes)，最好是16。在 HBase 内部，rowkey 保存为字节数组。

HBase 中无法根据某个column来排序 系统永远是根据 rowkey 来排序的。因此，rowkey 就是决定 row 存储顺序的唯一凭证。而这个排序也很简单：根据字典排序。

如果插入 HBase 的时候，不小心用了之前已经存在的 rowkey。那就会把之前存在的那个row 更新掉。之前已经存在的值会被放到这个单元格的历史记录里面，并不会丢掉，只是需要带上版本参数才可以找到这个值。

一个列上可以存储多个版本的单元格。单元格就是数据存储的最小单元。

##### 2. Column的概念
列，可理解成MySQL列。

在 HBase 中一个列的名称前面总是带着它所属的列族。列名称的规范是列族:列名，比如brother:age、brother:name、parent:age、 parent:name。


##### 3. ColumnFamily的概念
Hbase通过列族划分数据的存储，列族可以包含任意多的列，实现灵活的数据存取。列族是由一个一个的列组成（任意多）。

Hbase表的创建的时候就必须指定列族。就像关系型数据库创建的时候必须指定具体的列是一样的。

Hbase的列族不是越多越好，官方推荐的是列族最好小于或者等于3。

HBase会把相同列族的列尽量放在同一台机器上，所以说，如果想让某几个列被放到一起，你就给他们定义相同的列族。


##### 4.单元格
虽然列已经是 HBase 的最基本单位了，但是，一个列上可以存储多个版本的值，多个版本的值被存储在多个单元格里面，多个版本之间用版本号(Version)来区分。

所以，唯一确定一条结果的表达式应该是行键:列族:列:版本号（rowkey:column family:column:version）。

不过，版本号是可以省略的，默认最后一个版本。

每个列或者单元格的值都被赋予一个时间戳。这个时间戳默认是由系统制定的，也可以由用户显示指定。

##### 5.Rigion 和行的关系
一个 Region 就是多个行的集合。在 Region 中行的排序按照行键（rowkey）字典排序。




### 安装和使用
Hbase 也有 3 种运行模式:

- 单机模式
- 伪分布模式
- 完全分布式模式

### Hive
Hive是一个构建在Hadoop基础之上的数据仓库，主要解决分布式存储的大数据处理和计算问题，Hive提供了类SQL语句，叫HiveQL

通过它可以使用SQL查询存放在HDFS上的数据，sql语句最终被转化为Map/Reduce任务运行，但是Hive不能够进行交互查询——它只能够在Haoop上批量的执行Map/Reduce任务。

Hive适合用来对一段时间内的数据进行分析查询，例如，用来计算趋势或者网站的日志。Hive不应该用来进行实时的查询。因为它需要很长时间才可以返回结果。

Hive诞生于FaceBook，它最初就是为方便FaceBook的数据分析人员而建立的。FaceBook的数据分析人员大多了解SQL的写法，但是如果要用MapReduce来实现同样的分析效果比如多表关联，其学习和开发成本都非常高。所以FaceBook的牛人们就开发了一个组件可以将SQL语句转换为MapReduce，极大的方便了这些数据分析人员。

在大数据架构中，Hive和HBase是协作关系，Hive方便地提供了HiveQL的接口来简化MapReduce的使用，而HBase提供了低延迟的数据库访问。如果两者结合，可以利用MapReduce的优势针对HBase存储的大量内容进行离线的计算和分析。

#### Hive 与 Hbase 的区别
**hive**

- 数据仓库：Hive的本质其实就相当于将 HDFS 中已经存储的文件在 Mysql 中做了一个双射关系，以方便使用 HQL 去管理查询。
- 用于数据分析、清洗：Hive 适用于离线的数据分析和清洗，延迟较高。
- 基于 HDFS、MapReduce：Hive 存储的数据依旧在 DataNode 上，编写的 HQL 语句终将是转换为MapReduce 代码执行。

**hbase**

- 数据库：是一种面向列存储的非关系型数据库。
- 用于存储结构化和非结构化的数据：适用于单表非关系型数据的存储，不适合做关联查询，类似JOIN等操作。
- 基于 HDFS 数据持久化存储的体现形式是Hfile，存放于DataNode中，被ResionServer以region的形式进行管理。
- 延迟较低，接入在线业务使用：面对大量的企业数据，HBase 可以直线单表大量数据的存储，同时提供了高效的数据访问速度。

#### Hive 和 HBase 整合

整合后的目标:

1. 在 Hive 中创建的表能直接创建保存到 HBase 中。
2. 往 Hive 中的表插入数据，数据会同步更新到 HBase 对应的表中。
3. HBase 对应的列簇值变更，也会在 Hive 中对应的表中变更。

Hive 和 HBase 通信主要是依靠 $HIVE_HOME/lib 目录下的hive-hbase-handler-1.2.2.jar 来实现.














