## sqoop

Sqoop 项目开始于 2009 年，最早是作为 Hadoop 的一个第三方模块存在，后来为了让使用者能够快速部署，也为了让开发人员能够更快速的迭代开发，Sqoop 独立成为一个 Apache 项目。

Sqoop存在两个版本，版本号分别是1.4.x和1.99.x，通常被称为Sqoop1和Sqoop2。Sqoop2在架构和实现上，对于Sqoop1做了比较大幅度的改进，因此两个版本之间是不兼容的。

请注意，1.99.x 与1.4.x 不兼容，且功能不完整，它并不打算用于生产部署。

Sqoop 是一款开源的工具，主要用于在 Hadoop(Hive) 与传统的数据库( mysql、postgresql... )间进行数据的传递。可以将一个关系型数据库（例如 ： MySQL, Oracle, Postgres 等）中的数据导进到 Hadoop 的 HDFS 中，也可以将 HDFS 的数据导进到关系型数据库中。

本质就是迁移数据

迁移的方式：就是把 sqoop 的迁移命令转换成 MapReduce 程序。

MapReduce 中主要是对 InputFormat 和 OutputFormat 进行定制。

由于 Sqoop 只是一个工具, 所以不需要分发到其他设备上。

sqoop 一般和哪些组件打交道：HDFS， MapReduce， YARN， ZooKeeper， Hive， HBase， MySQL

sqoop list-databases --connect jdbc:mysql://hadoop101:3306/ --username root --password aaa

虽然 Sqoop 能够实现对关系型数据的全量同步，但在很多业务场景下，由于数据量非常非常大，每天全量同步，对于 Hadoop 的压力较大，因此要慎用。

Change Data Caputre (CDC)方案在实际中应用场景广泛，包括：

- 异地机房同步：公网由于带宽有限，因此需要严格的控制传输流量；
- 数据实时备份：类似于Mysql的Master/Slave模式；
- 业务缓存刷新：缓存系统通过增量数据，获得数据库更新信息，进而刷新缓存；
- 数据全库迁移：在历史数据迁移完成前，先获取新增数据并提供给系统使用；
- 搜索索引构建：例如倒排索引、拆分异构索引等；
- 增量业务逻辑：很多业务逻辑只需要用到增量数据即可。


### 增量数据
在生产环境中，系统可能会定期从与业务相关的关系型数据库向Hadoop导入数据，导入数仓后进行后续离线分析。故我们此时不可能再将所有数据重新导一遍，此时我们就需要增量数据导入这一模式了。

增量数据导入分两种，一是基于递增列的增量数据导入（Append方式）。二是基于时间列的增量数据导入（LastModified方式），增量导入使用到的核心参数主要是：

–check-column 用来指定一些列，这些列在增量导入时用来检查这些数据是否作为增量数据进行导入，和关系型数据库中的自增字段及时间戳类似。

注意:这些被指定的列的类型不能使任意字符类型，如char、varchar等类型都是不可以的，同时–check-column可以去指定多个列。

–incremental 用来指定增量导入的模式，两种模式分别为Append和Lastmodified

–last-value 指定上一次导入中检查列指定字段最大值

##### Append 增量导入

–incremental append
–check-column 递增列（int）
–last-value 阈值（int）

##### lastModify 增量导入

–incremental lastmodified
–check-column 递增列（时间字符串）
–last-value 阈值（时间字符串）
--merge-key 合并列

此方式要求原有表中有time字段，它能指定一个时间戳，让Sqoop把该时间戳之后的数据导入至Hadoop。因为后续员工薪资可能状态会变化，变化后time字段时间戳也会变化，此时Sqoop依然会将相同状态更改后的员工信息导入HDFS，因此为导致数据重复。



















