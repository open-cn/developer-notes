## HBase

HBase是Hadoop Database的简称，是建立在Hadoop文件系统之上的分布式面向列的数据库，为横向发展类型数据库，提供快速随机访问海量结构化数据，它是Hadoop生态系统，提供对数据的随机实时读/写访问，是Hadoop文件系统的一部分，利用了Hadoop的文件系统(HDFS)提供的容错能力。

HBase是分布式、面向列族的开源数据库，HDFS为HBase提供可靠的底层数据存储服务，MapReduce为HBase提供高性能的计算能力，Zookeeper为HBase提供稳定服务和Failover机制，可以说，HBase是一个通过大量廉价的机器解决海量数据的高速存储和读取的分布式数据库解决方案。

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
可能你们会想当然地觉得 Master 是 HBase 的领导，所有的数据、所有的操作都会经过它。错！其实在HBase中Master的角色不像领导，更像是打杂的。

客户端从 ZooKeeper 获取了 RegionServer 的地址后，会直接从 RegionServer 获取数据。其实不光是获取数据，包括插入、删除等所有的数据操作都是直接操作 RegionServer，而不需要经过 Master。

Master 只负责各种协调工作（其实就是打杂），比如建表、删表、移动Region、合并等操作。它们的共性就是需要跨 RegionServer，这些操作由哪个 RegionServer 来执行都不合适，所以 HBase 就将这些操作放到了 Master 上了。

这种结构的好处是大大降低了集群对 Master 的依赖。而 Master 节点一般只有一个到两个，一旦宕机，如果集群对 Master 的依赖度很大，那么就会产生单点故障问题。

在 HBase 中，即使 Master 宕机了，集群依然可以正常地运行，依然可以存储和删除数据。

但是，如果 Master 长时间宕机也是不行的，毕竟他还是有一些工作需要做的.

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

最初，每张表只有一个 region，当一个 region 变得太大时，它就分裂成 2 个子 region。2个子 region，各占原始 region 的一半数据，仍然被相同的 region server 管理。然后 Region server 向 HBase master 节点汇报拆分完成.

如果集群内还有其他 region server，master 节点倾向于做负载均衡，所以 master 节点有可能调度新的 region 到其他 region server，由其他 region 管理新的分裂出的 region。

Region 的拆分分为自动拆分和手动拆分。

自动拆分采用不同的策略。0.94 版本之前采用的是 ConstantSizeRegionSplitPolicy 策略。从名字上就可以看出这个策略就是按照固定大小来拆分Region。它唯一用到的参数是： hbase.hregion.max.filesize, 默认值是 10G。0.94 版本之后，默认使用 IncreasingToUpperBoundRegionSplitPolicy 策略。这种策略从名字上就可以看出是限制不断增长的文件尺寸的策略。我们以前使用传统关系型数据库的时候或许有这样的经验，有的数据库的文件增长是翻倍增长的，比如第一个文件是64MB，第二个就是 128MB，第三个就是256MB。

Region有以下特性：

- Region 不能跨服务器，一个 RegionServer 上有一个或者多个 Region。
- 数据量小的时候，一个 Region 足以存储所有数据；但是，当数据量大的时候，HBase会拆分 Region。
- 当 HBase 在进行负载均衡的时候，也有可能会从一台 RegionServer 上把 Region移动到另一台 RegionServer 上。
- Region 是基于 HDFS 的，它的所有数据存取操作都是调用了 HDFS 的客户端接口来实现的。


### 存储

最基本的存储单位是列（column），一个列或者多个列形成一行 （row）。

传统数据库是严格的行列对齐。比如这行有三个列a、b、c，下一行肯定也有三个列a、b、c。

而在HBase中，这一行有三个列 a、b、 c，下一个行也许是有 4 个列a、e、f、g。在HBase 中，行跟行的列可以完全不一样，这个行的数据跟另外一个行的数据也可以存储在不同的机器上，甚至同一行内的列也可以存储在完全不同的机器上！

每个行（row）都拥有唯一的行键（row key）来标定这个行的唯一性。每个列都有多个版本，多个版本的值存储在单元格（cell）中。

若干个列又可以被归类为一个列族。

![hbase 表结构](images/hbase1.png)

#### 三维有序存储
Hfile是HBase中Key-value数据的存储格式。key就是{row key，column(=< family> + < label>)，version} ，而value就是cell中的值。

HBase的三维有序存储中的三维是指：rowkey（行主键），column key(columnFamily+< label>)，timestamp(时间戳或者版本号)三部分组成的三维有序存储。

##### rowkey
rowkey是行的主键，它是以字典顺序排序的。所以 rowkey的设计是至关重要的，关系到你应用层的查询效率。我们在根据rowkey范围查询的时候，我们一般是知道startRowkey，如果我们通过scan只传startRowKey ：d开头的，那么查询的是所有比d大的都查了，而我们只需要d开头的数据，那就要通过endRowKey来限制。我们可以通过设定endRowKey为：d 开头，后面的根据你的rowkey组合来设定，一般是加比startKey大一位。

##### column key
column key是第二维，数据按rowkey字典排序后，如果rowkey相同，则是根据column key来排序的，也是按字典排序。

我们在设计table的时候要学会利用这一点。比如我们的收件箱。我们有时候需要按主题排序，那我们就可以把主题这设置为我们的column key，即设计为columnFamily+主题这样的设计。

##### timestamp
timestamp 时间戳，是第三维，这是个按降序排序的，即最新的数据排在最前面。

#### OLTP 和 OLAP
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

在 HBase 内部，rowkey 保存为字节数组。

rowkey 行键可以是任意字符串，最大长度是64KB，实际应用中长度一般为 10~100bytes。不过建议是越短越好，控制在 64 个字节以内是比较好。目前操作系统是都是 64 位系统，内存 8 字节对齐。控制在 8 个字节的次幂比较好: 比如，16字节，32字节，64字节比较好。

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

#### hbase shell

```bash
help # 帮助命令

list # 查看当前数据库中有哪些表


# 创建一个表，表名叫student，这个表内有一个列族叫info
# 定义表的时候不需要定义列.
create 'student','info'


# Hbase 是使用 put 命令向表中插入数据的.
put 'student','1001','info:sex','male'
put 'student','1001','info:age','20'

put 'student','1002','info:name','zhiling'
put 'student','1002','info:sex','female'
put 'student','1002','info:age','18'


# 查看表数据 - 全表扫描
scan 'student'

# 查看表数据 - 限制起始行和结束行的扫描
# STARROW和STOPROW必须大写.
# 显示的结果也是前闭后开的区间
scan 'student', {STARTROW => '1002'}
scan 'student', {STARTROW => '1001', STOPROW => '1001'}

# 查看表数据 - 获取指定行或者指定列的数据
get 'student', '1001' # 指定行
get 'student', '1001', 'info:age' # 指定列
get 'student', '1001', {COLUMN =>  'info:age', VERSIONS => 2} # 指定版本数


# 统计表数据行
count 'student'


# 更新指定列的数据
# 更新数据和添加数据的操作是一样的，都是使用的 put 命令.
# 如果指定行的列不存在就是添加，如果存在就是更新值. 但是旧值还存在，只是形成了不同的版本.
put 'student','1002','info:name','lisi'
put 'student','1002','info:name','fengjie'

# 删除数据
deleteall 'student', '1001' # 删除某行所有数据
delete 'student','1002','info:sex' # 删除某列数据

# 清空表数据
# 清空表会自动先 disable，然后再 truncate。
truncate 'student'

# 删除表
# 需要先把表 disable，然后再 drop
disable 'student'
drop 'student'

# 查看表结构
describe 'student'

# 变更表结构
alter 'student', {NAME => 'info', VERSIONS => 3} #  设置表 student 中ifno列族每列可以保存 3 个版本的数据

```

### 最佳实践

##### 高可用
HBase 集群支持对 Hmaster 的高可用配置。

##### 预分区

每一个 region 维护着 startRow 与 endRowKey，如果加入的数据符合某个region 维护的 rowKey 范围，则该数据交给这个 region 维护。

那么依照这个原则，我们可以将数据所要投放的分区提前大致的规划好，以提高HBase 性能。在生产环境中，基本都会对表进行预分区。

有几种预分区的方式:

1. 手动设定分区点
create 'staff1','info','partition1',SPLITS =>['1000','2000','3000','4000']

2. 生成16进制序列预分区
create 'staff2','info','partition2',{NUMREGIONS => 15, SPLITALGO => 'HexStringSplit'}


3. 按照文件中设置的规则预分区
创建splits.txt文件内容如下：
```txt
aaaa
bbbb
cccc
dddd
```

然后执行：create 'staff3','partition3',SPLITS_FILE => 'splits.txt'

4. 使用 JavaAPI 创建预分区
```java
//自定义算法，产生一系列Hash散列值存储在二维数组中
byte[][] splitKeys = 某个散列值函数
//创建HBaseAdmin实例
HBaseAdmin hAdmin = new HBaseAdmin(HBaseConfiguration.create());
//创建HTableDescriptor实例
HTableDescriptor tableDesc = new HTableDescriptor(tableName);
//通过HTableDescriptor实例和散列值二维数组创建带有预分区的HBase表
hAdmin.createTable(tableDesc, splitKeys);
```
例如：
```java
public static void customSplitRegion(String tableName, String f1) throws IOException {
    if (isTableExists(tableName)) return;


    HTableDescriptor desc = new HTableDescriptor(TableName.valueOf(tableName));
    desc.addFamily(new HColumnDescriptor(f1));
    byte[][] keys = {
            Bytes.toBytes("aa"),
            Bytes.toBytes("bb"),
            Bytes.toBytes("cc"),
            Bytes.toBytes("dd"),
    };
    admin.createTable(desc, keys);

}
```

#### RowKey 设计
一条数据的唯一标识就是 rowkey，那么这条数据存储于哪个分区，取决于 rowkey 处于哪个一个预分区的区间内。设计 rowkey 的主要目的 ，就是让数据均匀的分布于所有的 region 中，在一定程度上防止数据倾斜。

如何设计rowkey 使写入数据时尽量均匀地写到各个 Region 中，起到负载均衡的作用。读取数据时要把一次查询的数据聚集到一个 Region 中，加速查询。

rowkey既想要能够快速检索，就想要内容最好集中到少量的region中，但是一旦集中了，就会产生热点问题，所以，他们是相伴相生。


**字符串类型**

虽然行键在 HBase 中是以 byte[] 字节数组的形式存储的，但是建议在系统开发过程中将其数据类型设置为String类型，保证通用性；如果在开发过程中将 RowKey 规定为其他类型，譬如Long型，那么数据的长度将可能受限于编译环境等所规定的数据长度。

常用的行键字符串有以下几种：

- 纯数字字符串，譬如9559820140512；
- 数字+特殊分隔符，譬如95598-20140512;
- 数字+英文字母，譬如city20140512；
- 数字+英文字母+特殊分隔符，譬如city_20140512。


**有明确的意义**

RowKey 的主要作用是为了进行数据记录的唯一性标示，但是唯一性并不是其全部，具有明确意义的行键对于应用开发、数据检索等都具有特殊意义。

譬如上面的数字字符串9559820140512，其实际意义是这样：95598（电网客服电话）+20140512（日期）。

行键往往由多个值组合而成，而各个值的位置顺序将影响到数据存储和检索效率，所以在设计行键时，需要对日后的业务应用开发有比较深入的了解和前瞻性预测，才能设计出可尽量高效率检索的行键。


**具有有序性**

RowKey 是按照字典序存储，因此，设计 RowKey 时，要充分利用这个排序特点，将经常一起读取的数据存储到一块，将最近可能会被访问的数据放在一块。

举个例子：如果最近写入 HBase 表中的数据是最可能被访问的，可以考虑将时间戳作为RowKey 的一部分，由于是字典序排序，所以可以使用 Long.MAX_VALUE–timestamp作为 RowKey，这样能保证新写入的数据在读取时可以被快速命中。

如果 Rowkey 是按时间戳的方式递增，不要将时间放在二进制码的前面，建议将Rowkey的高位作为散列字段，由程序循环生成，低位放时间字段，这样将提高数据均衡分布在每个 Regionserver 实现负载均衡的几率。

如果没有散列字段，首字段直接是时间信息将产生所有新数据都在一个 RegionServer 上堆积的热点现象，这样在做数据检索的时候负载将会集中在个别 RegionServer，降低查询效率。


**具有定长性**

行键具有有序性的基础便是定长。

譬如20140512080500、20140512083000，这两个日期时间形式的字符串是递增的，不管后面的秒数是多少，我们都将其设置为 14 位数字形式，如果我们把后面的 0 去除了，那么 201405120805 将大于 20140512083，其有序性发生了变更。

##### 解决热点问题

检索habse的记录首先要通过row key来定位数据行。当大量的client访问hbase集群的一个或少数几个节点，造成少数region server的读/写请求过多、负载过大，而其他region server负载却很小，就造成了“热点”现象。

**热点的解决办法**

预分区：预分区的目的让表的数据可以均衡的分散在集群中，而不是默认只有一个region分布在集群的一个节点上。

加盐：这里所说的加盐不是密码学中的加盐，而是在rowkey的前面增加随机数，具体就是给rowkey分配一个随机前缀以使得它和之前的rowkey的开头不同。

哈希：哈希会使同一行永远用一个前缀加盐。哈希也可以使负载分散到整个集群，但是读却是可以预测的。使用确定的哈希可以让客户端重构完整的rowkey，可以使用get操作准确获取某一个行数据。

反转：反转固定长度或者数字格式的rowkey。这样可以使得rowkey中经常改变的部分（最没有意义的部分）放在前面。这样可以有效的随机rowkey，但是牺牲了rowkey的有序性。


#### 内存优化
HBase 操作过程中需要大量的内存开销，毕竟 Table 是可以缓存在内存中的，一般会分配整个可用内存的 70% 给 HBase 的 Java 堆。

但是不建议分配非常大的堆内存，因为 GC 过程持续太久会导致 RegionServer 处于长期不可用状态，一般 16~48G 内存就可以了，如果因为框架占用内存过高导致系统内存不足，框架一样会被系统服务拖死。


#### 基础优化
1. 允许在HDFS的文件中追加内容 hdfs-site.xml、hbase-site.xml 属性：dfs.support.append 解释：开启 HDFS 追加同步，可以优秀的配合 HBase 的数据同步和持久化。默认值为true。

2. 优化 DataNode 允许的最大传输的文件数 hdfs-site.xml 属性：dfs.datanode.max.transfer.threads 解释：HBase 一般都会同一时间操作大量的文件，根据集群的数量和规模以及数据动作，设置为4096或者更高。默认值：4096

3. 优化延迟高的数据操作的等待时间 hdfs-site.xml 属性：dfs.image.transfer.timeout 解释：如果对于某一次数据操作来讲，延迟非常高，socket 需要等待更长的时间，建议把该值设置为更大的值（默认60000毫秒），以确保 socket 不会被 timeout 掉。

4. 优化数据的写入效率 mapred-site.xml 属性： mapreduce.map.output.compress mapreduce.map.output.compress.codec 解释：开启这两个数据可以大大提高文件的写入效率，减少写入时间。第一个属性值修改为true，第二个属性值修改为：org.apache.hadoop.io.compress.GzipCodec或者其他压缩方式。

5. 设置 RPC 监听数量 hbase-site.xml 属性：hbase.regionserver.handler.count 解释：默认值为30，用于指定RPC监听的数量，可以根据客户端的请求数进行调整，读写请求较多时，增加此值。

6. 优化HStore文件大小 hbase-site.xml 属性：hbase.hregion.max.filesize 解释：默认值10737418240（10GB），如果需要运行HBase的MR任务，可以减小此值，因为一个region对应一个map任务，如果单个region过大，会导致map任务执行时间过长。该值的意思就是，如果HFile的大小达到这个数值，则这个region会被切分为两个Hfile。

7. 优化 hbase 客户端缓存 hbase-site.xml 属性：hbase.client.write.buffer 解释：用于指定 HBase 客户端缓存，增大该值可以减少RPC调用次数，但是会消耗更多内存，反之则反之。一般我们需要设定一定的缓存大小，以达到减少 RPC 次数的目的。

8. 指定scan.next扫描HBase所获取的行数 hbase-site.xml 属性：hbase.client.scanner.caching 解释：用于指定scan.next方法获取的默认行数，值越大，消耗内存越大。 默认: 2147483647

9. flush、compact、split机制

当 MemStore 达到阈值，将 Memstore 中的数据 Flush 进 Storefile；

compact 机制则是把 flush 出来的小文件合并成大的 Storefile 文件。

split 则是当 Region 达到阈值，会把过大的 Region 一分为二。

涉及属性：

hbase.hregion.memstore.flush.size：134217728 这个参数的作用是当单个 HRegion 内所有的 Memstore 大小总和超过指定值时，flush 该 HRegion 的所有 memstore。RegionServer 的 flush 是通过将请求添加一个队列，模拟生产消费模型来异步处理的。那这里就有一个问题，当队列来不及消费，产生大量积压请求时，可能会导致内存陡增，最坏的情况是触发OOM。

hbase.regionserver.global.memstore.size：0.4 hbase.regionserver.global.memstore.size.lower.limit：0.38 即：当 MemStore 使用内存总量达到总内存的hbase.regionserver.global.memstore.size指定值时，将会有多个MemStores flush 到文件中，MemStore flush 顺序是按照大小降序执行的，直到刷新到 MemStore 使用内存略小于 lowerLimit。

#### FAQ
##### RIT（Region-In-Transition）

为什么会处于RIT状态才是问题探索的根本，也是解决问题的关键。

四种会触发Region状态变迁的操作以及操作对应的Region状态。其中特定操作行为通常包括assign、unassign、split以及merge等，而很多其他操作都可以拆成unassign和assign，比如move操作实际上是先unassign再assign；

Region状态迁移是如何发生的？

这个过程有点类似于状态机，也是通过事件驱动的。和Region状态一样，HBase还定义了很多事件（具体见EventType类）。



### MapReduce

Hbase 只是一个单纯的数据存储框架，没有任何的分析能力。我们可以让 Hbase 和 MapReduce 结合起来，就扩展出来了数据分析功能。


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
- 基于 HDFS 数据持久化存储的体现形式是 Hfile，存放于 DataNode 中，被 ResionServer 以 region 的形式进行管理。
- 延迟较低，接入在线业务使用：面对大量的企业数据，HBase 可以直线单表大量数据的存储，同时提供了高效的数据访问速度。

#### Hive 和 HBase 整合

整合后的目标:

1. 在 Hive 中创建的表能直接创建保存到 HBase 中。
2. 往 Hive 中的表插入数据，数据会同步更新到 HBase 对应的表中。
3. HBase 对应的列簇值变更，也会在 Hive 中对应的表中变更。

Hive 和 HBase 通信主要是依靠 $HIVE_HOME/lib 目录下的hive-hbase-handler-1.2.2.jar 来实现.

