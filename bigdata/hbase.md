## HBase



HBase并不快，只是当数据量很大的时候它慢的不明显

HBase是Hadoop Database的简称，是建立在Hadoop文件系统之上的分布式面向列的数据库，为横向发展类型数据库，提供快速随机访问海量结构化数据，它是Hadoop生态系统，提供对数据的随机实时读/写访问，是Hadoop文件系统的一部分，利用了Hadoop的文件系统(HDFS)提供的容错能力。

HBase是分布式、面向列族的开源数据库，HDFS为HBase提供可靠的底层数据存储服务，MapReduce为HBase提供高性能的计算能力，Zookeeper为HBase提供稳定服务和Failover机制，可以说,HBase是一个通过大量廉价的机器解决海量数据的高速存储和读取的分布式数据库解决方案。

Hbase是一种NoSQL数据库，非常适用于海量明细数据（十亿、百亿）的随机实时查询，如交易清单、轨迹行为等。








### OLTP和OLAP
数据处理大致可以分成两大类：联机事务处理OLTP（on-line transaction processing）、联机分析处理OLAP（On-Line Analytical Processing）。

OLTP是传统的关系型数据库的主要应用，主要是基本的、日常的事务处理，例如银行交易。

面向行的数据库适用于联机事务处理(OLTP)，这样的数据库被设计为小数目的行和列。



OLAP是数据仓库系统的主要应用，支持复杂的分析操作，侧重决策支持，并且提供直观易懂的查询结果。


面向列的数据库适用于在线分析处理(OLAP)，可以设计为巨大表。


#### 名词概念

##### 1. Rowkey的概念
Rowkey的概念和mysql中的主键是完全一样的，Hbase使用Rowkey来唯一的区分某一行的数据。Hbase只支持3种查询方式： - 1、基于Rowkey的单行查询 - 2、基于Rowkey的范围扫描 - 3、全表扫描

因此，Rowkey对Hbase的性能影响非常大，Rowkey的设计就显得尤为的重要。设计的时候要兼顾基于Rowkey的单行查询也要兼顾Rowkey的范围扫描。

rowkey 行键可以是任意字符串(最大长度是64KB，实际应用中长度一般为 10-100bytes)，最好是16。在HBase 内部，rowkey 保存为字节数组。HBase会对表中的数据按照 rowkey 排序 (字典顺序)

##### 2. Column的概念
列，可理解成MySQL列。

##### 3. ColumnFamily的概念
Hbase通过列族划分数据的存储，列族可以包含任意多的列，实现灵活的数据存取。列族是由一个一个的列组成（任意多）。

Hbase表的创建的时候就必须指定列族。就像关系型数据库创建的时候必须指定具体的列是一样的。

Hbase的列族不是越多越好，官方推荐的是列族最好小于或者等于3。我们使用的场景一般是1个列族。









### Hive
Hive是一个构建在Hadoop基础之上的数据仓库，主要解决分布式存储的大数据处理和计算问题，Hive提供了类SQL语句，叫HiveQL

通过它可以使用SQL查询存放在HDFS上的数据，sql语句最终被转化为Map/Reduce任务运行，但是Hive不能够进行交互查询——它只能够在Haoop上批量的执行Map/Reduce任务。

Hive适合用来对一段时间内的数据进行分析查询，例如，用来计算趋势或者网站的日志。Hive不应该用来进行实时的查询。因为它需要很长时间才可以返回结果。

Hive诞生于FaceBook，它最初就是为方便FaceBook的数据分析人员而建立的。FaceBook的数据分析人员大多了解SQL的写法，但是如果要用MapReduce来实现同样的分析效果比如多表关联，其学习和开发成本都非常高。所以FaceBook的牛人们就开发了一个组件可以将SQL语句转换为MapReduce，极大的方便了这些数据分析人员。

在大数据架构中，Hive和HBase是协作关系，Hive方便地提供了Hive QL的接口来简化MapReduce的使用， 而HBase提供了低延迟的数据库访问。如果两者结合，可以利用MapReduce的优势针对HBase存储的大量内容进行离线的计算和分析。

