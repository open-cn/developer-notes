## Kettle

数据集成及BI分析套件Pentaho的开源ETL组件

市面上常用的ETL工具有很多，比如Sqoop，DataX，Kettle，Talend 等。

### 概述

Kettle最早是一个开源的ETL工具，全称为KDE Extraction, Transportation, Transformation and Loading Environment。

在2006年，Pentaho公司收购了Kettle项目，原Kettle项目发起人Matt Casters加入了Pentaho团队，成为Pentaho套件数据集成架构师；从此，Kettle成为企业级数据集成及商业智能套件Pentaho的主要组成部分，Kettle亦重命名为Pentaho Data Integration。

Pentaho公司于2015年被Hitachi Data Systems收购。（Hitachi Data Systems于2017年改名为Hitachi Vantara）。

Pentaho Data Integration以Java开发，支持跨平台运行，其特性包括：支持100%无编码、拖拽方式开发ETL数据管道；可对接包括传统数据库、文件、大数据平台、接口、流数据等数据源；支持ETL数据管道加入机器学习算法。

Pentaho Data Integration分为商业版与开源版，开源版的截止2021年1月的累计下载量达836万，其中19%来自中国。在中国，一般人仍习惯把Pentaho Data Integration的开源版称为Kettle。

广泛利用内部数据（例如：ERP、CRM、POS、设备数据、日志）以及外部数据（行业数据、宏观经济数据、社交媒体、评论）来对现有业务做各样分析以及对未来做预测，最终以数据驱动业务，已经是任何组织赖以生存的必要手段。然后，要使有价值的数据分析在组织内各层级管理人员的手机、Pad以及大屏呈现之前，数据必须先从各个源头进行抽取（Extract），加载（Load）至数据湖（Data Lake）,然后需要对在大数据存储里（例如: Hadoop，S3，MongoDB）的数据各类加工，包括清洗（Cleanse）、把来自不同来源、不同格式的数据混合（Blend）、转换（Transform），再把数据按照分析需求进行建模（Modeling）和聚合（Aggregation）,或者在数据挖掘之前进行数据预备和特征工程（Data Preparation & Feature Engineering）,最终数据被加载至数据仓库或数据集市中。整个过程比30年前刚出现ETL的概念已经复杂了许多；再加上组织需要处理除了结构化数据（例如：传统关系型数据库），还包括非结构化数据（例如：日志、客户评论、图片），同时，各组织已不满足于T+1的滞后分析而纷纷对数据进行更有价值的实时或近实时数据分析（real-time or near-real-time analysis），导致数据集成（Data Integration）的复杂度大大提高。Pentaho Data Integration平均每半年一次大版本升级，以应对数据集成不断变化的需求。

#### 运行环境
- Pentaho Data Integration服务器端支持：Windows Server，CentOS，RHEL，Ubuntu
- Pentaho Data Integration开发客户端（Spoon）支持：Windows，Ubuntu Desktop，MacOS
- Pentaho User Console（浏览器端）支持：Internet Explorer，Chrome，Firefox，Safari，Edge

#### 版本记录

PDI (Kettle) 主要版本历史

- 2006年6月 PDI 2.3 Kettle被Pentaho收购后第一个版本
- 2007年11月 PDI 3.0 产品整体重新设计，性能提升
- 2009年4月 PDI 3.2 加入新功能、可视化与性能优化
- 2010年6月 PDI 4.0 加入企业级功能，例如：版本管理
- 2013年11月 PDI 5.0 优化大数据支持、转换步骤负载均衡、作业事务性支持、作业断点重启
- 2015年12月 PDI 6.0 Pentaho Data Service，元数据注入（Metadata Injection）,数据血缘追踪
- 2016年11月 PDI 7.0 数据管道可视化、Hadoop安全性支持、Spark支持优化、资源库功能完善、元数据注入功能优化 
- 2017年4月 PDI 7.1 任务下压至Spark集群运行（Adaptive Execution Layer） 
- 2017年11月 PDI 8.0 实时数据对接、AEL优化、大数据格式支持优化
- 2018年6月 PDI 8.3 数据源支持优化：Snowflake, RedShift, Kinesis, HCP等 
- 2020年1月 PDI 9.0 多Hadoop集群支持、大型机（Mainframe）数据对接支持、S3支持优化 
- 2020年10月 PDI 9.1 Google Dataproc支持、数据目录Lumada Data Catalog对接 

### 1


- Transformation (转换) ：完成针对数据的基础转换。
- Job (作业) ：完成整个工作流的控制。

区别：
1) 作业是步骤流，转换是数据流。这是作业和转换最大的区别。
2) 作业的每一个步骤，必须等到前面的步骤都跑完了，后面的步骤才会执行；而转换会一次性把所有控件全部先启动(一个控件对应启动一个线程)，然后数据流会从第一个控件开始，一条记录、一条记录地流向最后的控件;

#### 核心组件
- Spoon.bat/spoon.sh：是一个图形化界面，让我们用图形化的方式开发转换和作业（Windows选择Spoon.bat；Linux选择Spoon.sh）
- Pan.bat/pan.sh：利用Pan可以用命令行的形式执行由Spoon编辑的转换和作业
- Kitchen.bat/kitchen.sh：利用Kitchen可以使用命令调用由Spoon编辑好的Job
- Carte.bat/carte.sh：Carte是一个轻量级的Web容器，用于建立专用、远程的ETL Server


### 最佳实践

#### 调优
1. 调整JVM大小进行性能优化，修改Kettle根目录下的Spoon脚本。
参数参考：
-Xmx2048m：设置JVM最大可用内存为2048M。
-Xms1024m：设置JVM促使内存为1024m。此值可以设置与-Xmx相同，以避免每次垃圾回收完成后JVM重新分配内存。
-Xmn2g：设置年轻代大小为2G。整个JVM内存大小=年轻代大小 + 年老代大小 + 持久代大小。持久代一般固定大小为64m，所以增大年轻代后，将会减小年老代大小。此值对系统性能影响较大，Sun官方推荐配置为整个堆的3/8。
-Xss128k：设置每个线程的堆栈大小。JDK5.0以后每个线程堆栈大小为1M，以前每个线程堆栈大小为256K。更具应用的线程所需内存大小进行调整。在相同物理内存下，减小这个值能生成更多的线程。但是操作系统对一个进程内的线程数还是有限制的，不能无限生成，经验值在3000~5000左右。
2. 调整提交（Commit）记录数大小进行优化，Kettle默认Commit数量为：1000，可以根据数据量大小来设置Commitsize：1000~50000
3. 尽量使用数据库连接池；
4. 尽量提高批处理的commit size；
5. 尽量使用缓存，缓存尽量大一些（主要是文本文件和数据流）；
6. Kettle是Java做的，尽量用大一点的内存参数启动Kettle；
7. 可以使用sql来做的一些操作尽量用sql；Group , merge , stream lookup,split field这些操作都是比较慢的，想办法避免他们.，能用sql就用sql；
8. 插入大量数据的时候尽量把索引删掉；
9. 尽量避免使用update , delete操作，尤其是update,如果可以把update变成先delete, 后insert；
10. 能使用 truncate table 的时候，就不要使用 deleteall row 这种类似sql合理的分区，如果删除操作是基于某一个分区的，就不要使用 delete row 这种方式（不管是deletesql还是delete步骤），直接把分区drop掉，再重新创建；
11. 尽量缩小输入的数据集的大小（增量更新也是为了这个目的）；
12. 尽量使用数据库原生的方式装载文本文件(Oracle的sqlloader，mysql的bulk loader步骤)。
