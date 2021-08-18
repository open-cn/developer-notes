## Impala

Impala 是用于处理存储在 Hadoop 集群中的大量数据的 MPP（大规模并行处理）SQL 查询引擎。 它是一个用 C++ 和 Java 编写的开源软件。 与其他 Hadoop 的 SQL 引擎相比，它提供了高性能和低延迟。

Impala通过使用标准组件（如 HDFS，HBase，Metastore，YARN 和 Sentry）将传统分析数据库的 SQL 支持和多用户性能与 Apache Hadoop 的可扩展性和灵活性相结合。

- 使用 Impala，与其他 SQL 引擎（如 Hive）相比，用户可以使用 SQL 查询以更快的方式与 HDFS 或 HBase 进行通信。
- Impala 可以读取 Hadoop 使用的几乎所有文件格式，如 Parquet，Avro，RCFile。

Impala 将相同的元数据，SQL 语法（Hive SQL），ODBC 驱动程序和用户界面（Hue Beeswax）用作 Apache Hive，为面向批量或实时查询提供熟悉且统一的平台。与 Apache Hive 不同，Impala 不基于MapReduce算法。它实现了一个基于守护进程的分布式架构，它负责在同一台机器上运行的查询执行的所有方面。因此，它减少了使用 MapReduce 的延迟，这使 Impala 比 Apache Hive 快。


### Impala 的优点
- 使用 impala，您可以使用传统的 SQL 知识以极快的速度处理存储在 HDFS 中的数据。
- 由于在数据驻留（在 Hadoop 集群上）时执行数据处理，因此在使用 Impala 时，不需要对存储在 Hadoop 上的数据进行数据转换和数据移动。
- 使用 Impala，您可以访问存储在 HDFS，HBase 和 Amazon s3 中的数据，而无需了解 Java（MapReduce 作业）。您可以使用 SQL 查询的基本概念访问它们。
- 为了在业务工具中写入查询，数据必须经历复杂的提取变换负载（ETL）周期。但是，使用 Impala，此过程缩短了。加载和重组的耗时阶段通过新技术克服，如探索性数据分析和数据发现，使过程更快。
- Impala 正在率先使用 Parquet 文件格式，这是一种针对数据仓库场景中典型的大规模查询进行优化的柱状存储布局。


### Impala 的功能
- Impala 可以根据 Apache 许可证作为开源免费提供。
- Impala 支持内存中数据处理，即，它访问/分析存储在 Hadoop 数据节点上的数据，而无需数据移动。
- 您可以使用 Impala 使用类 SQL 查询访问数据。
- 与其他 SQL 引擎相比，Impala 为 HDFS 中的数据提供了更快的访问。
- 使用 Impala，您可以将数据存储在存储系统中，如 HDFS，Apache HBase 和 Amazon s3。
- 您可以将 Impala 与业务智能工具（如 Tableau，Pentaho，Micro 策略和缩放数据）集成。
- Impala 支持各种文件格式，如LZO，序列文件，Avro，RCFile 和 Parquet。
- Impala 使用 Apache Hive 的元数据，ODBC 驱动程序和 SQL 语法。


### 关系数据库和 Impala
Impala 使用类似于 SQL 和 HiveQL 的 Query 语言。 下表描述了 SQL 和 Impala 查询语言之间的一些关键差异。

| Impala                                      | 关系型数据库                                     |
| ------------------------------------------- | ------------------------------------------------ |
| Impala使用类似于HiveQL的类似SQL的查询语言。 | 关系数据库使用SQL语言。                          |
| 在Impala中，您无法更新或删除单个记录。      | 在关系数据库中，可以更新或删除单个记录。         |
| Impala不支持事务。                          | 关系数据库支持事务。                             |
| Impala不支持索引。                          | 关系数据库支持索引。                             |
| Impala存储和管理大量数据（PB）。            | 与Impala相比，关系数据库处理的数据量较少（TB）。 |

### Hive，Hbase 和 Impala
虽然 Cloudera Impala 使用与 Hive 相同的查询语言，元数据和用户界面，但在某些方面它与 Hive 和 HBase 不同。 下表介绍了 HBase，Hive 和 Impala 之间的比较分析。

| HBase                                                        | Hive                                                         | Impala                                             |
| ------------------------------------------------------------ | ------------------------------------------------------------ | -------------------------------------------------- |
| HBase是基于Apache Hadoop的宽列存储数据库。 它使用BigTable的概念。 | Hive是一个数据仓库软件。 使用它，我们可以访问和管理基于Hadoop的大型分布式数据集。 | Impala是一个管理，分析存储在Hadoop上的数据的工具。 |
| HBase的数据模型是宽列存储。                                  | Hive遵循关系模型。                                           | Impala遵循关系模型。                               |
| HBase是使用Java语言开发的。                                  | Hive是使用Java语言开发的。                                   | Impala是使用C ++开发的。                           |
| HBase的数据模型是无模式的。                                  | Hive的数据模型是基于模式的。                                 | Impala的数据模型是基于模式的。                     |
| HBase提供Java，RESTful和Thrift API。                         | Hive提供JDBC，ODBC，Thrift API。                             | Impala提供JDBC和ODBC API。                         |
| 支持C，C＃，C ++，Groovy，Java PHP，Python和Scala等编程语言。 | 支持C ++，Java，PHP和Python等编程语言。                      | Impala支持所有支持JDBC / ODBC的语言。              |
| HBase提供对触发器的支持。                                    | Hive不提供任何触发器支持。                                   | Impala不提供对触发器的任何支持。                   |

所有这三个数据库

- 是 NOSQL 数据库。
- 可用作开源。
- 支持服务器端脚本。
- 按照 ACID 属性，如 Durability 和 Concurrency。
- 使用分片进行分区。

### Impala 的缺点
- Impala 不提供任何对序列化和反序列化的支持。
- Impala 只能读取文本文件，而不能读取自定义二进制文件。
- 每当新的记录/文件被添加到 HDFS 中的数据目录时，该表需要被刷新。

