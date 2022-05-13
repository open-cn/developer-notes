## Nutch

官方网站：https://nutch.apache.org/

### 概述

Nutch 是一个开源Java实现的搜索引擎。它提供了我们运行自己的搜索引擎所需的全部工具，包括全文搜索和Web爬虫。

Nutch分为两个版本，1.x和2.x。两个版本的主要区别在于底层的存储不同。1.x版本是基于Hadoop架构的，底层存储使用的是HDFS，而2.x通过使用Apache Gora，使得Nutch可以访问HBase、Accumulo、Cassandra、MySQL、DataFileAvroStore、AvroStore等NoSQL。

Nutch是基于Lucene的。Lucene为Nutch提供了文本索引和搜索的API。

#### 目标

Nutch 致力于让每个人能很容易，同时花费很少就可以配置世界一流的Web搜索引擎。为了完成这一宏伟的目标，Nutch必须能够做到：

- 每个月取几十亿网页
- 为这些网页维护一个索引
- 对索引文件进行每秒上千次的搜索
- 提供高质量的搜索结果

#### 组成

爬虫crawler和查询searcher。

Crawler主要用于从网络上抓取网页并为这些网页建立索引。

Searcher主要利用这些索引检索用户的查找关键词来产生查找结果。

两者之间的接口是索引，所以除去索引部分，两者之间的耦合度很低。

Crawler和Searcher两部分尽量分开的目的主要是为了使两部分可以分布式配置在硬件平台上，例如将Crawler和Searcher分别放在两个主机上，这样可以提升性能。
