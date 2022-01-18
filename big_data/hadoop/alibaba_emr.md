## 阿里云E-MapReduce

阿里云E-MapReduce（简称EMR），是运行在阿里云平台上的一种大数据处理的系统解决方案。

### EMR 概述

EMR构建于云服务器ECS上，基于开源的Apache Hadoop和Apache Spark，让您可以方便地使用Hadoop和Spark生态系统中的其他周边系统分析和处理数据。EMR还可以与阿里云其他的云数据存储系统和数据库系统（例如，阿里云OSS和RDS等）进行数据传输。

EMR的SmartData组件是EMR Jindo引擎的主要存储部分，为EMR各个计算引擎提供统一的存储优化、缓存优化、计算缓存加速优化和多个存储功能扩展。


#### EMR 组成

E-MapReduce的核心是集群。E-MapReduce集群是由一个或多个阿里云ECS实例组成的Hadoop、Flink、Druid、ZooKeeper集群。以Hadoop为例，每个ECS 实例上通常都运行了一些daemon进程（例如，NameNode、DataNode、ResouceManager和NodeManager），这些daemon进程共同组成了Hadoop集群。

- Master节点，部署了Hadoop的主节点服务，包括HDFS NameNode、HDFS JournalNode、ZooKeeper、YARN ResourceManager和HBase HMaster等服务，可以根据集群的使用场景，选择高可用集群或非高可用集群。测试环境可以选择非高可用集群，生产环境建议选择高可用集群。高可用集群可以选择2个或3个Master节点，当选择2个Master节点时，HDFS JournalNode和ZooKeeper会部署在Core的emr-worker-1节点。生产环境建议创建高可用集群时选择3个Master节点。
- Core节点，部署了HDFS DataNode和YARN Nodemanager，用于HDFS数据的存储和YARN的计算，不可以弹性伸缩。
- Task节点，部署了YARN NodeManager，用于YARN计算，可以通过弹性伸缩的方式灵活扩容或缩容。
- Gateway集群，部署了Hadoop的客户端文件，您可以通过Gateway提交作业，避免直接登录集群产生的安全和客户端环境隔离问题。您需要先创建Hadoop集群，然后创建Gateway集群关联至Hadoop集群。

#### EMR 产品架构

- 社区开源产品

  	集成Apache社区开源大数据组件，例如Hadoop、Hive和HBase，随着EMR版本更新，开源软件也会相应的升级，详情请参见版本概述下各版本的版本说明。

	注意 已经创建好的EMR集群不支持组件升级。

- EMR开源优化

  	EMR基于开源社区版本的组件，增强了其性能和功能，例如：

	+ Spark中增加了Spark Streaming SQL，性能较开源版本有大幅提升，详情请参见简介。
	+ Delta Lake相较开源版本增加了ZOrder和Data Skipping能力，详情请参见Delta Lake概述。
	
- EMR自研能力

  	为让开源大数据组件和服务更好的运行在阿里云技术设施上，EMR自研了如下组件：

	+ 数据应用平台，提供交互式开发、作业提交、作业调试和工作流一站式数据开发体验，详情请参见EMR Studio概述。
	+ Shuffle Service是EMR在优化计算引擎的Shuffle操作上，推出的扩展组件，详情请参见ESS概述。
	+ SmartData，为EMR各个计算引擎提供统一的存储优化、缓存优化、计算缓存加速优化和多个存储功能扩展，详情请参见SmartData。
	
- 阿里云产品

	EMR衔接了开源大数据生态和阿里云生态。EMR可以部署在阿里云ECS（Elastic Compute Service）和Kubernetes（简称ACK）上；数据可以存储在阿里云OSS上；通过在EMR上创建Data Science集群可以使用及学习机器学习PAI；EMR集成在DataWorks，您可以在DataWorks上使用EMR作为作业计算和数据存储引擎。

#### EMR 配置选型

##### 大数据使用场景

E-MapReduce产品当前主要满足企业的以下大数据场景：

- 批处理场景

	该场景对磁盘吞吐和网络吞吐要求高，处理的数据量也大，但对数据处理的实时性要求不高，您可以选用MapReduce、Pig和Spark组件。该场景对内存要求不高，选型时您需要重点关注作业对CPU和内存的需求，以及Shuffle对网络的需求。

- Ad-Hoc查询

	数据科学家或数据分析师使用即席查询工具检索数据。该场景对查询实时性、磁盘吞吐和网络吞吐要求高，您可以选用E-MapReduce的Impala和Presto组件。该场景对内存要求高，选型时需要考虑数据和并发查询的数量。

- 流式计算、高网络吞吐和计算密集型场景

	您可以选用E-MapReduce的Flink、Spark Streaming和Storm组件。

- 消息队列

	该场景对磁盘吞吐和网络吞吐要求高，并且内存消耗大，存储不依赖于HDFS。您可以选用E-MapReduce的Kafka集群。

- 数据冷备场景

	该场景对计算和磁盘吞吐要求不高，但要求冷备成本低，推荐使用JindoFS将阿里云OSS的归档型和深度归档型作为冷数据存储，以降低存储成本。

##### E-MapReduce 节点

- E-MapReduce节点有主实例（Master）、核心实例（Core）和计算实例（Task）三种实例类型。
- E-MapReduce存储可以采用高效云盘、本地盘、SSD云盘和SSD本地盘。磁盘性能为SSD本地盘 > SSD云盘 > 本地盘 > 高效云盘。
- E-MapReduce底层存储支持OSS（仅标准型OSS）和HDFS。相对于HDFS，OSS的数据可用性更高（99.99999999%），HDFS的数据可用性由云盘或本地盘存储的可靠性来保证。归档数据和深度归档数据需要解冻为标准型存储才能参与EMR引擎计算。
- Master主实例适合通用型或内存型实例，数据直接使用阿里云的云盘来保存，确保了数据的高可靠性。
- Core核心实例
	+ 小数据量（TB级别以下）或者是使用OSS作为主要的数据存储时，推荐使用通用型、计算型或内存型。
	+ 大数据量（10 TB或以上）情况下，推荐使用大数据机型，可以获得极高的性价比。
	+ 注意 当Core核心实例使用本地盘时，HDFS数据存储在本地盘，需要您自行保证数据的可靠性。
- Task计算实例用于补充集群的计算能力，可以使用除大数据型外的所有机型。

存储价格估算如下：

- 本地盘实例存储为0.04 元/GB/月
- OSS标准型存储为0.12 元/GB/月
- OSS归档型存储为0.033 元/GB/月
- OSS深度归档型存储为0.015 元/GB/月
- 高效云盘存储为0.35 元/GB/月
- SSD云盘存储为1.00 元/GB/月

ECS实例类型：

- 通用型 vCPU : Memory = 1 : 4。例如，8核32 GiB，使用云盘作为存储。
- 计算型	vCPU : Memory = 1 : 2。例如，8核16 GiB，使用云盘作为存储，提供了更多的计算资源。
- 内存型	vCPU : Memory = 1 : 8。例如， 8核64 GiB，使用云盘作为存储，提供了更多的内存资源。
- 大数据型 使用本地SATA盘作存储数据，存储性价比高，是大数据量（TB级别的数据量）场景下的推荐机型。
- 本地SSD型 使用本地SSD盘，具有高随机IOPS（Input/Output Operations Per Second）和高吞吐能力。
- 共享型（入门级） 共享CPU的机型，在大计算量的场景下，稳定性不够。入门级学习使用，不推荐企业客户使用。
- GPU 使用GPU的异构机型，可以用来运行机器学习等场景。

**Master节点选型**

Master节点主要部署Hadoop的Master进程。例如，NameNode和ResourceManager等。

生产集群建议打开高可用HA，E-MapReduce的HDFS、YARN、Hive和HBase等组件均已实现HA。生产集群建议在创建集群的硬件配置步骤开启高可用。如果购买时未开启高可用，在后续使用过程中无法开启高可用功能。

Master节点主要用来存储HDFS元数据和组件Log文件，属于计算密集型，对磁盘IO要求不高。HDFS元数据存储在内存中，建议根据文件数量选择16 GB以上内存空间。

当您需要查看集群上服务的运行情况时，您可以通过软件的Web UI来查看。当您需要快速测试或者运行作业时，您可以登录主实例节点，然后通过命令行直接提交作业。

**Core节点选型**

Core节点主要用来存储数据和执行计算，运行DataNode和NodeManager。

HDFS数据量大于60 TB，建议采用本地盘实例（ECS.d1，ECS.d1NE），本地盘的磁盘容量为（CPU核数/2）*5.5TB*实例数量。

例如，购买4台8核D1实例，磁盘容量为8/2*5.5*4 台=88 TB。因为HDFS采用3备份，所以本地盘实例最少购买3台，考虑到数据可靠性和磁盘损坏因素，建议最少购买4台。

HDFS数据量小于60 TB，可以考虑高效云盘和SSD云盘。

**Task节点选型**

Task节点主要用来运行NodeManager。以补充Core节点CPU和内存计算能力的不足，节点并不存储数据，也不运行DataNode。您可以根据CPU和内存需求来估算实例个数。

**GateWay集群**

创建Gateway集群时必须关联到一个已经存在的集群。Gateway集群可以作为一个独立的作业提交点，以便您更好的对关联集群进行操作。

Gateway集群通常是一个独立的集群，由多台相同配置的节点组成，集群上会部署Hadoop（HDFS+YARN）、Hive、Spark和Sqoop等客户端。

未创建Gateway集群时，Hadoop等集群的作业是在本集群的Master或Core节点上提交的，会占用本集群的资源。创建Gateway集群后，您可以通过Gateway集群来提交其关联的集群的作业，这样既不会占用关联集群的资源，又可以提高关联集群Master或Core节点的稳定性，尤其是Master节点。

每一个Gateway集群均支持独立的环境配置。例如，在多个部门共用一个集群的场景下，您可以为这个集群创建多个Gateway集群，以满足不同部门的业务需求。

##### E-MapReduce生命周期

E-MapReduce支持弹性扩展，可以快速的扩容，灵活调整集群节点配置。

##### 可用区选择

为保证效率，您应该部署E-MapReduce与业务系统在同一地域的同一个可用区。

##### 集群容灾

数据容灾

> 在Hadoop分布式文件系统（HDFS）中，每一个文件的数据均是分块存储的，每一个数据块保存有多个副本（默认为3），并且尽量保证这些数据块副本分布在不同的机架之上。一般情况下，HDFS的副本系数是3，存放策略是将一个副本存放在本地机架节点上，一个副本存放在同一个机架的另一个节点上，最后一个副本放在不同机架的节点上。
>
> HDFS会定期扫描数据副本，如果扫描到有数据副本丢失，则会快速复制这些数据以保证数据副本的数量。如果扫描到节点丢失，则节点上的所有数据也会快速复制恢复。在阿里云上，如果使用的是云盘技术，则每一个云盘在后台都会对应三个数据副本，当其中任一个出现问题时，副本数据都会自动进行切换并恢复，以保证数据的可靠性。
> 
> Hadoop HDFS是一个经历了长时间考验且具有高可靠性的数据存储系统，已实现了海量数据的高可靠性存储。同时基于云上的特性，您也可以再在OSS等服务上额外备份数据，以达到更高的数据可靠性。

服务容灾

> Hadoop的核心组件都会进行HA部署，即有至少两个节点的服务互备，例如YARN、HDFS、Hive Server和Hive Meta。在任何一时刻，任一服务节点故障时，当前的服务节点都会自动进行切换，以保证服务不受影响。


#### 使用限制

在使用EMR时，所有操作都需要在EMR控制台上执行，通常不建议您在ECS控制台上进行操作，某些非产品预期的操作可能会导致集群的不稳定甚至集群的不可用。

|操作	|可能的结果|	建议|
|---|---|---|
|禁止删除或者修改etc/hosts目录下的hosts文件|	集群关联不到节点上的服务，导致服务异常。|	增加hosts信息。|
|禁止直接在ECS控制台上修改组件配置文件的参数|	服务重启后，导致修改的参数被覆盖。|	在EMR控制台上修改参数配置。|
|禁止在ECS控制台重新部署ECS实例|	影响EMR服务。	|提交工单处理。|
|禁止在ECS控制台对EMR节点挂载磁盘	|因为EMR无法识别和初始化磁盘，所以会导致磁盘不可用。	|在EMR控制台上扩容数据盘。|
|禁止在ECS控制台对EMR节点卸载磁盘|	因为EMR无法感知到卸载磁盘操作，所以容易导致数据丢失。	|无|
|禁止在ECS控制台直接删除Core节点|	导致数据丢失和在删除节点上的作业执行失败|。	无|
|禁止在ECS控制台直接删除Master节点	|HA集群，删除Master节点，会导致集群HDFS NameNode HA、YARN ResourceManager或HBase HMaster无法正常切换，该情况只能重新购买EMR集群，迁移数据/任务。<br>非HA集群，删除Master节点，会导致集群不可用，无法迁移数据和任务。|无|
|禁止在ECS控制台直接删除Task节点|	执行在删除节点上的作业执行失败。|	无|
|禁止停止Master的MySQL服务（创建集群时，元数据选择集群内置MySQL）|	emr-header-1上的MySQL服务，关联到Hive MetaStore、Oozie和Ranger，如果停止服务，会造成支持的服务无法访问到数据库。	|无|
|禁止修改emr-header-1节点上预装的MySQL root密码（创建集群时，元数据选择集群内置MySQL）|	导致EMR的Hue或Ranger等组件失败。	|无|
|禁止在集群运行中修改ECS节点的安全组	|导致集群节点间网络异常。<br>导致组件不可用。|无|
|禁止在ECS控制台转换计费方式	|导致无法转回原来的计费方式。|	在EMR控制台进行计费方式的转换<br>注意 EMR不支持从包年包月转换为按量付费的计费方式。如果您需要从包年包月转换为按量付费的计费方式，请购买专家服务。|

##### 常见问题处理

磁盘容量不足	

> 因为EMR集群的Master节点不支持磁盘数量的增加，所以您可以在EMR控制台调大单块磁盘的容量，或扩容Core节点。

磁盘容量过剩

> 因为EMR集群不支持磁盘容量缩容，所以您可以重新购买集群。

计算能力不足

> 您可以在EMR控制台上扩容Task节点。

计算能力过剩	

> 根据集群区分如下：
>	针对按量付费集群，您可以在EMR控制台上缩容Task节点。
>	针对包年包月集群，先在Task节点Decommission YARN Nodemanager服务，然后在ECS控制台将对应Task节点的ECS转为按量付费后再释放。

组件版本过低

> 因为EMR集群不支持单组件版本升级，所以您可以重新购买高版本的集群。

转化非HA集群为HA集群

> EMR集群暂不支持非HA集群转为HA集群，建议您重新购买HA集群。

在EMR上部署第三方软件或服务

> 建议您在集群创建时通过引导操作安装第三方软件或服务。
> 
> 如果集群创建后手工安装第三方软件或服务，在扩容时，新扩容节点需重新手工安装第三方软件或服务。






### EMR 使用

#### 集群运维

##### 登录集群

在ECS控制台上为主节点挂载公网，为主节点ECS实例分配固定公网IP或EIP

```shell
ssh root@[主节点公网IP地址]
ssh -i ~/.ssh/ecs.pem root@<主节点公网IP地址>

# 然后可以登录Core节点
su hadoop
ssh emr-worker-1

sudo su - root
# 修改root用户密码
sudo passwd root

env # 查看环境变量

# 登录内置MySQL
mysql -uroot -pEMRroot1234

```

##### 启停服务

YARN 操作账号：hadoop

```shell
# ResourceManager（Master节点）
# 启动ResourceManager
/usr/lib/hadoop-current/sbin/yarn-daemon.sh start resourcemanager
# 停止ResourceManager
/usr/lib/hadoop-current/sbin/yarn-daemon.sh stop resourcemanager

# NodeManager（Core节点）
# 启动NodeManager
/usr/lib/hadoop-current/sbin/yarn-daemon.sh start nodemanager
# 停止NodeManager
/usr/lib/hadoop-current/sbin/yarn-daemon.sh stop nodemanager

# JobHistoryServer（Master节点）
# 启动JobHistoryServer
/usr/lib/hadoop-current/sbin/mr-jobhistory-daemon.sh start historyserver
# 停止JobHistoryServer
/usr/lib/hadoop-current/sbin/mr-jobhistory-daemon.sh stop historyserver

# WebProxyServer（Master节点）
# 启动WebProxyServer
/usr/lib/hadoop-current/sbin/yarn-daemon.sh start proxyserver
# 停止WebProxyServer
/usr/lib/hadoop-current/sbin/yarn-daemon.sh stop proxyserver
```

HDFS 操作账号：hdfs

```shell
# NameNode（Master节点）
# 启动NameNode
/usr/lib/hadoop-current/sbin/hadoop-daemon.sh start namenode
# 停止NameNode
/usr/lib/hadoop-current/sbin/hadoop-daemon.sh stop namenode

# DataNode（Core节点）
# 启动DataNode
/usr/lib/hadoop-current/sbin/hadoop-daemon.sh start datanode
# 停止DataNode
/usr/lib/hadoop-current/sbin/hadoop-daemon.sh stop datanode
```

Hive 操作账号：hadoop

```shell
# MetaStore（Master节点）
# 启动MetaStore，内存可以根据需要扩大。
HADOOP_HEAPSIZE=512 /usr/lib/hive-current/bin/hive --service metastore >/var/log/hive/metastore.log 2>&1 &

# HiveServer2（Master节点）
# 启动HiveServer2
HADOOP_HEAPSIZE=512 /usr/lib/hive-current/bin/hive --service hiveserver2 >/var/log/hive/hiveserver2.log 2>&1 &
```

HBase 操作账号：hdfs

```shell
# 注意 需要选择了HBase服务才能使用如下的方式来启动，否则启动的时候会报错。
# HMaster（Master节点）
# 启动HMaster
/usr/lib/hbase-current/bin/hbase-daemon.sh start master
# 重启HMaster
/usr/lib/hbase-current/bin/hbase-daemon.sh restart master
# 停止HMaster
/usr/lib/hbase-current/bin/hbase-daemon.sh stop master

# HRegionServer（Core节点）
# 启动HRegionServer
/usr/lib/hbase-current/bin/hbase-daemon.sh start regionserver
# 重启HRegionServer
/usr/lib/hbase-current/bin/hbase-daemon.sh restart regionserver
# 停止HRegionServer
/usr/lib/hbase-current/bin/hbase-daemon.sh stop regionserver

# ThriftServer（Master节点）
# 启动ThriftServer
/usr/lib/hbase-current/bin/hbase-daemon.sh start thrift -p 9099 >/var/log/hive/thriftserver.log 2>&1 &
# 停止ThriftServer
/usr/lib/hbase-current/bin/hbase-daemon.sh stop thrift
```

Hue 操作账号：hadoop

```shell
# 启动Hue
su -l root -c "${HUE_HOME}/build/env/bin/supervisor >/dev/null 2>&1 &"
# 停止Hue
ps aux | grep hue     //查找到所的Hue进程。
kill -9 huepid        //终止掉查找到的对应Hue进程。
```

Zeppelin 操作账号：hadoop

```shell
# 启动Zeppelin
# 内存可以根据需要扩大。
su -l root -c "ZEPPELIN_MEM=\"-Xmx512m -Xms512m\" ${ZEPPELIN_HOME}/bin/zeppelin-daemon.sh start"
# 停止Zeppelin
su -l root -c "${ZEPPELIN_HOME}/bin/zeppelin-daemon.sh stop"
```

Presto 操作账号：hdfs

```shell
# PrestoServer（Master节点）
# 启动PrestoServer
/usr/lib/presto-current/bin/launcher --config=/usr/lib/presto-current/etc/coordinator-config.properties start
# 停止PrestoServer
/usr/lib/presto-current/bin/launcher --config=/usr/lib/presto-current/etc/coordinator-config.properties stop

# PrestoServer（Core节点）
# 启动PrestoServer
/usr/lib/presto-current/bin/launcher --config=/usr/lib/presto-current/etc/worker-config.properties start
# 停止PrestoServer
/usr/lib/presto-current/bin/launcher --config=/usr/lib/presto-current/etc/worker-config.properties stop
```

批量操作

当您需要对Core节点做统一操作时，可以通过脚本命令的方式。在EMR集群中，Master和所有Worker节点在hadoop和hdfs账号下是互通的。

例如，可以通过以下命令，对所有Core节点的NodeManage执行停止操作。本示例Core节点数为10。

```shell
for i in `seq 1 10`;do ssh emr-worker-$i /usr/lib/hadoop-current/sbin/yarn-daemon.sh stop nodemanager;done
```

##### 常用文件路径

软件安装目录在/usr/lib/xxx下，例如：

- Hadoop：/usr/lib/hadoop-current
- Spark ：/usr/lib/spark-current
- Hive：/usr/lib/hive-current
- Flink：/usr/lib/flink-current
- Flume：/usr/lib/flume-current

组件日志目录在/mnt/disk1/log/xxx下，例如：

- Yarn ResourceManager日志：Master节点/mnt/disk1/log/hadoop-yarn
- Yarn NodeNanager日志：Slave节点/mnt/disk1/log/hadoop-yarn
- HDFS NameNode日志：Master节点/mnt/disk1/log/hadoop-hdfs
- HDFS DataNode日志：Slave节点/mnt/disk1/log/hadoop-hdfs
- Hive日志：Master节点/mnt/disk1/log/hive
- ESS日志：Master和Worker节点/mnt/disk1/log/ess/

配置文件目录在/etc/ecm/xxx下，例如：

- Hadoop：/etc/ecm/hadoop-conf/
- Spark：/etc/ecm/spark-conf/
- Hive：/etc/ecm/hive-conf/
- Flink：/etc/ecm/flink-conf/
- Flume：/etc/ecm/flume-conf/

数据目录

- JindoFS缓存数据：/mnt/disk\*/bigboot/


##### Web UI

| 软件     | 服务                 | 访问地址                                                  |
| -------- | -------------------- | --------------------------------------------------------- |
| Hadoop   | yarn resourcemanager | masternode1_private_ip:8088,masternode2_private_ip:8088   |
| Hadoop   | jobhistory           | masternode1_private_ip:19888                              |
| Hadoop   | timeline             | server masternode1_private_ip:8188                        |
| Hadoop   | hdfs                 | masternode1_private_ip:50070,masternode2_private_ip:50070 |
| Spark    | spark ui             | masternode1_private_ip:4040                               |
| Spark    | history              | masternode1_private_ip:18080                              |
| Tez      | tez-ui               | masternode1_private_ip:8090/tez-ui2                       |
| Hue      | hue                  | masternode1_private_ip:8888                               |
| Zeppelin | zeppelin             | masternode1_private_ip:8080                               |
| Hbase    | hbase                | masternode1_private_ip:16010                              |
| Presto   | presto               | masternode1_private_ip:9090                               |
| Oozie    | oozie                | masternode1_private_ip:11000                              |
| Ganglia  | ganglia              | masternode1_private_ip:9292/ganglia                       |


#### 集群类型

- Hadoop集群
- Druid集群
- Dataflow-Kafka集群
- Flink集群
- ZooKeeper集群
- Data Science集群
- ClickHouse集群
- Data Development集群

##### Hadoop集群

以EMR-3.29.0版本为例，Hadoop集群服务组件的具体部署信息如下。

| 服务名          | 主实例节点                                                   | 核心实例节点                                               |
| --------------- | ------------------------------------------------------------ | ---------------------------------------------------------- |
| HDFS            | KMS<br>SecondaryNameNode<br>HttpFS<br>HDFS Client<br>NameNode | DataNode<br>HDFS Client                                    |
| YARN            | ResourceManager<br>App Timeline Server<br>JobHistory<br>WebAppProxyServer<br>Yarn Client | Yarn Client<br>NodeManager                                 |
| Hive            | Hive MetaStore<br>HiveServer2<br>Hive Client                 | Hive Client                                                |
| Spark           | Spark Client                                                 | SparkHistory<br>ThriftServer                               |
| Knox            | Knox                                                         | 无                                                         |
| Tez             | Tomcat<br>Tez Client                                         | Tez Client                                                 |
| Ganglia         | Gmond<br>Httpd<br>Gmetad<br>Ganglia Client                   | Gmond<br>Ganglia Client                                    |
| Sqoop           | Sqoop Client                                                 | Sqoop Client                                               |
| Bigboot         | Bigboot Client<br>Bigboot Monitor                            | Bigboot Client<br>Bigboot Monitor                          |
| OpenLDAP        | OpenLDAP                                                     | 无                                                         |
| Hue             | Hue                                                          | 无                                                         |
| SmartData       | Jindo Namespace Service<br>Jindo Storage Service<br>Jindo Client | Jindo Storage Service<br>Jindo Client                      |
| LIVY(可选)      | Livy                                                         | 无                                                         |
| Superset(可选)  | Superset                                                     | 无                                                         |
| Flink(可选)     | FlinkHistoryServer<br>Flink Client                           | Flink Client                                               |
| RANGER(可选)    | RangerPlugin/RangerAdmin<br>RangerUserSync<br>Solr           | RangerPlugin                                               |
| Storm(可选)     | Storm Client<br>UI<br>Nimbus<br>Logviewer                    | Storm Client<br>Supervisor                                 |
| Phoenix(可选)   | Phoenix Client                                               | Phoenix Client                                             |
| Kudu(可选)      | Kudu Master<br>Kudu Client                                   | Kudu Tserver<br>Kudu Master<br>Kudu Client                 |
| HBase(可选)     | HMaster<br>HBase Client<br>ThriftServer                      | HBase Client<br>HRegionServer                              |
| ZooKeeper(可选) | ZooKeeper follower<br>ZooKeeper Client                       | ZooKeeper follower<br>ZooKeeper leader<br>ZooKeeper Client |
| Oozie(可选)     | Oozie                                                        | 无                                                         |
| Presto(可选)    | Presto Client<br>PrestoMaster                                | Presto Client<br>PrestoWorker                              |
| Impala(可选)    | Impala Runtime and Shell<br>Impala Catalog Server<br>Impala StateStore Server | Impala Runtime and Shell<br>Impala Daemon Server           |
| Pig(可选)       | Pig Client                                                   | Pig Client                                                 |
| Zeppelin(可选)  | Zeppelin                                                     | 无                                                         |
| FLUME(可选)     | Flume Agent<br>Flume Client                                  | Flume Agent<br>Flume Client                                |


##### Druid集群

| 服务名         | 主实例节点                                                   | 核心实例节点                                               |
| -------------- | ------------------------------------------------------------ | ---------------------------------------------------------- |
| Druid          | Druid Client<br>Coordinator<br>Overlord<br>Broker<br>Router  | MiddleManager<br>Historical<br>Druid Client                |
| HDFS           | KMS<br>SecondaryNameNode<br>HttpFS<br>HDFS Client<br>NameNode | DataNode<br>HDFS Client                                    |
| Ganglia        | Gmond<br>Httpd<br>Gmetad<br>Ganglia Client                   | Gmond<br>Ganglia Client                                    |
| ZooKeeper      | ZooKeeper follower<br>ZooKeeper Client                       | ZooKeeper follower<br>ZooKeeper leader<br>ZooKeeper Client |
| OpenLDAP       | OpenLDAP                                                     | 无                                                         |
| Bigboot        | Bigboot Client<br>Bigboot Monitor                            | Bigboot Client<br>Bigboot Monitor                          |
| SmartData      | Jindo Namespace Service<br>Jindo Storage Service<br>Jindo Client | Jindo Storage Service<br>Jindo Client                      |
| YARN(可选)     | ResourceManager<br>App Timeline Server<br>JobHistory<br>WebAppProxyServer<br>Yarn Client | Yarn Client<br>NodeManager                                 |
| Superset(可选) | Superset                                                     | 无                                                         |

##### Dataflow-Kafka集群

以EMR-3.29.0版本为例，Dataflow-Kafka集群服务组件的具体部署信息如下。

| 服务名        | 主实例节点                                                   | 核心实例节点                                               |
| ------------- | ------------------------------------------------------------ | ---------------------------------------------------------- |
| Kafka-Manager | Kafka Manager                                                | 无                                                         |
| Kafka         | Kafka Client<br>KafkaMetadataMonitor<br>Kafka Rest Proxy<br>Kafka Broker broker<br>Kafka Schema Registry | Kafka Broker broker<br>Kafka Client                        |
| Ganglia       | Gmond<br>Httpd<br>Gmetad<br>Ganglia Client                   | Gmond<br>Ganglia Client                                    |
| ZooKeeper     | ZooKeeper follower<br>ZooKeeper Client                       | ZooKeeper follower<br>ZooKeeper leader<br>ZooKeeper Client |
| OpenLDAP      | OpenLDAP                                                     | 无                                                         |
| RANGER(可选)  | RangerPlugin/RangerAdmin<br>RangerUserSync<br>Solr           | RangerPlugin                                               |
| Knox(可选)    | Knox                                                         | 无                                                         |

##### Flink集群

以EMR-3.30.0版本为例，Flink集群服务组件的具体部署信息如下。

| 服务名          | 主实例节点                                                   | 核心实例节点                                               |
| --------------- | ------------------------------------------------------------ | ---------------------------------------------------------- |
| HDFS            | KMS<br>SecondaryNameNode<br>HttpFS<br>HDFS Client<br>NameNode | DataNode<br>HDFS Client                                    |
| YARN            | ResourceManager<br>App Timeline Server<br>JobHistory<br>WebAppProxyServer<br>Yarn Client | Yarn Client<br>NodeManager                                 |
| Ganglia         | Gmond<br>Httpd<br>Gmetad<br>Ganglia Client                   | Gmond<br>Ganglia Client                                    |
| ZooKeeper       | ZooKeeper follower<br>ZooKeeper Client                       | ZooKeeper follower<br>ZooKeeper leader<br>ZooKeeper Client |
| Knox            | Knox                                                         | 无                                                         |
| Flink-Vvp       | Flink-Vvp                                                    | 无                                                         |
| OpenLDAP        | OpenLDAP                                                     | 无                                                         |
| PAI-Alink(可选) | Alink                                                        | 无                                                         |

##### ZooKeeper集群

以EMR-3.29.0版本为例，ZooKeeper集群服务组件的具体部署信息如下。

| 服务名    | 主实例节点                                 | 核心实例节点                                               |
| --------- | ------------------------------------------ | ---------------------------------------------------------- |
| Ganglia   | Gmond<br>Httpd<br>Gmetad<br>Ganglia Client | Gmond<br>Ganglia Client                                    |
| ZooKeeper | ZooKeeper follower<br>ZooKeeper Client     | ZooKeeper follower<br>ZooKeeper leader<br>ZooKeeper Client |

##### Data Science集群

以EMR-3.29.1版本为例，Data Science集群服务组件的具体部署信息如下。

| 服务名             | 主实例节点                                                   | 核心实例节点                                               |
| ------------------ | ------------------------------------------------------------ | ---------------------------------------------------------- |
| HDFS               | KMS<br>SecondaryNameNode<br>HttpFS<br>HDFS Client<br>NameNode | DataNode<br>HDFS Client                                    |
| YARN               | ResourceManager<br>App Timeline Server<br>JobHistory<br>WebAppProxyServer<br>Yarn Client | Yarn Client<br>NodeManager                                 |
| ZooKeeper          | ZooKeeper follower<br>ZooKeeper Client                       | ZooKeeper follower<br>ZooKeeper leader<br>ZooKeeper Client |
| Knox               | Knox                                                         | 无                                                         |
| Tensorflow on YARN | TensorFlow-On-YARN-Gateway<br>TensorFlow-On-YARN-History-Server<br>TensorFlow-On-YARN | TensorFlow-On-YARN-Client<br>TensorFlow-On-YARN-Gateway    |
| SmartData          | Jindo Namespace Service<br>Jindo Storage Service<br>Jindo Client | Jindo Storage Service<br>Jindo Client                      |
| Bigboot            | Bigboot Client<br>Bigboot Monitor                            | Bigboot Client<br>Bigboot Monitor                          |
| PAI-EASYREC        | Easyrec                                                      | Easyrec                                                    |
| PAI-EAS            | PAIEAS                                                       | PAIEAS                                                     |
| PAI-Faiss          | Faiss                                                        | Faiss                                                      |
| PAI-Redis          | Redis                                                        | Redis                                                      |
| PAI-Alink          | Alink                                                        | 无                                                         |
| Flink-Vvp          | Flink-Vvp                                                    | 无                                                         |
| OpenLDAP           | OpenLDAP                                                     | 无                                                         |
| Jindo SDK          | Jindo SDK                                                    | Jindo SDK                                                  |
| Zeppelin(可选)     | Zeppelin                                                     | 无                                                         |
| PAI-REC(可选)      | Rec                                                          | 无                                                         |
| AUTOML(可选)       | AUTOML                                                       | AUTOML                                                     |
| TensorFlow(可选)   | TensorFlow                                                   | TensorFlow                                                 |

##### ClickHouse集群

以EMR-3.35.0版本为例，ClickHouse集群服务组件的具体部署信息如下。

| 服务名     | 主实例节点                                 | 核心实例节点                                               |
| ---------- | ------------------------------------------ | ---------------------------------------------------------- |
| Ganglia    | Gmond<br>Httpd<br>Gmetad<br>Ganglia Client | Gmond<br>Ganglia Client                                    |
| ZooKeeper  | ZooKeeper follower<br>ZooKeeper Client     | ZooKeeper follower<br>ZooKeeper leader<br>ZooKeeper Client |
| ClickHouse | ClickHouse Server<br>ClickHouse Client     | ClickHouse Server<br>ClickHouse Client                     |

##### Data Development集群

以EMR-3.33.102版本为例，Data Development集群服务组件的具体部署信息如下。

| 服务名                  | 主实例节点                                               | 核心实例节点                     |
| ----------------------- | -------------------------------------------------------- | -------------------------------- |
| Ganglia                 | Gmond<br>Httpd<br>Gmetad<br>Ganglia Client               | Gmond<br>Ganglia Client          |
| Zeppelin                | ZooKeeper Master                                         | ZooKeeper Worker                 |
| JupyterHub              | JupyterHub                                               | 无                               |
| RabbitMQ                | RabbitMQ                                                 | 无                               |
| Mysql                   | MySQL                                                    | 无                               |
| Data Development Center | Data Development Center                                  | 无                               |
| Airflow                 | Airflow Client<br>Airflow Scheduler<br>Airflow WebServer | Airflow Client<br>Airflow Worker |




#### 作业类型

MR作业，hive作业，hive sql作业，spark作业，spark sql作业，spark streaming作业，spark shell作业，shell作业

sqoop作业，pig作业，Flink作业，Presto SQL作业，Impala SQL作业

##### MapReduce 作业
hadoop jar xxx.jar [MainClass] -D xxx ....

作业内容：/path/to/hadoop-mapreduce-client-jobclient-2.6.0-tests.jar sleep -m 3 -r 3 -mt 100 -rt 100

##### hive 作业
hive [user provided parameters]

作业内容：-f ossref://path/to/uservisits_aggre_hdfs.hive
```hive
USE DEFAULT;
DROP TABLE uservisits;
CREATE EXTERNAL TABLE IF NOT EXISTS uservisits (sourceIP STRING,destURL STRING,visitDate STRING,adRevenue DOUBLE,userAgent STRING,countryCode STRING,languageCode STRING,searchWord STRING,duration INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS SEQUENCEFILE LOCATION '/HiBench/Aggregation/Input/uservisits';
DROP TABLE uservisits_aggre;
CREATE EXTERNAL TABLE IF NOT EXISTS uservisits_aggre (sourceIP STRING, sumAdRevenue DOUBLE) STORED AS SEQUENCEFILE LOCATION '/HiBench/Aggregation/Output/uservisits_aggre';
INSERT OVERWRITE TABLE uservisits_aggre SELECT sourceIP, SUM(adRevenue) FROM uservisits GROUP BY sourceIP;
```

##### hive sql 作业
hive -e {SQL CONTENT}

作业内容：
```sql
-- SQL语句最大不能超过64 KB。
show databases;
show tables;
-- 系统会自动为SELECT语句加上'limit 2000'的限制。
select * from test1;
```

##### pig 作业
pig [user provided parameters]

作业内容：-x mapreduce ossref://emr/checklist/jars/chengtao/pig/script1-hadoop-oss.pig

```pig
 -- Query Phrase Popularity (Hadoop cluster)
 -- This script processes a search query log file from the Excite search engine and finds search phrases that occur with particular high frequency during certain times of the day. 
 -- Register the tutorial JAR file so that the included UDFs can be called in the script.
 REGISTER oss://emr/checklist/jars/chengtao/pig/tutorial.jar;
 -- Use the  PigStorage function to load the excite log file into the “raw” bag as an array of records.
 -- Input: (user,time,query) 
 raw = LOAD 'oss://emr/checklist/data/chengtao/pig/excite.log.bz2' USING PigStorage('\t') AS (user, time, query);
 -- Call the NonURLDetector UDF to remove records if the query field is empty or a URL. 
 clean1 = FILTER raw BY org.apache.pig.tutorial.NonURLDetector(query);
 -- Call the ToLower UDF to change the query field to lowercase. 
 clean2 = FOREACH clean1 GENERATE user, time, org.apache.pig.tutorial.ToLower(query) as query;
 -- Because the log file only contains queries for a single day, we are only interested in the hour.
 -- The excite query log timestamp format is YYMMDDHHMMSS.
 -- Call the ExtractHour UDF to extract the hour (HH) from the time field.
 houred = FOREACH clean2 GENERATE user, org.apache.pig.tutorial.ExtractHour(time) as hour, query;
 -- Call the NGramGenerator UDF to compose the n-grams of the query.
 ngramed1 = FOREACH houred GENERATE user, hour, flatten(org.apache.pig.tutorial.NGramGenerator(query)) as ngram;
 -- Use the  DISTINCT command to get the unique n-grams for all records.
 ngramed2 = DISTINCT ngramed1;
 -- Use the  GROUP command to group records by n-gram and hour. 
 hour_frequency1 = GROUP ngramed2 BY (ngram, hour);
 -- Use the  COUNT function to get the count (occurrences) of each n-gram. 
 hour_frequency2 = FOREACH hour_frequency1 GENERATE flatten($0), COUNT($1) as count;
 -- Use the  GROUP command to group records by n-gram only. 
 -- Each group now corresponds to a distinct n-gram and has the count for each hour.
 uniq_frequency1 = GROUP hour_frequency2 BY group::ngram;
 -- For each group, identify the hour in which this n-gram is used with a particularly high frequency.
 -- Call the ScoreGenerator UDF to calculate a "popularity" score for the n-gram.
 uniq_frequency2 = FOREACH uniq_frequency1 GENERATE flatten($0), flatten(org.apache.pig.tutorial.ScoreGenerator($1));
 -- Use the  FOREACH-GENERATE command to assign names to the fields. 
 uniq_frequency3 = FOREACH uniq_frequency2 GENERATE $1 as hour, $0 as ngram, $2 as score, $3 as count, $4 as mean;
 -- Use the  FILTER command to move all records with a score less than or equal to 2.0.
 filtered_uniq_frequency = FILTER uniq_frequency3 BY score > 2.0;
 -- Use the  ORDER command to sort the remaining records by hour and score. 
 ordered_uniq_frequency = ORDER filtered_uniq_frequency BY hour, score;
 -- Use the  PigStorage function to store the results. 
 -- Output: (hour, n-gram, score, count, average_counts_among_all_hours)
 STORE ordered_uniq_frequency INTO 'oss://emr/checklist/data/chengtao/pig/script1-hadoop-results' USING PigStorage();
```

##### Presto SQL 作业
presto <options> -f {SQL_SCRIPT}

SQL_SCRIPT中保存作业编辑器中填写的SQL语句。如：SELECT * from table1;

默认情况下，Presto查询catalog=hive，schema=default下的数据表，可以通过设置Presto Cli参数来指定不同的Catalog和Schema。Presto SQL作业支持如下两种方式设置Presto Cli参数：

1. 通过环境变量设置<br>
设置密码：如果Presto服务开启了密码认证，可以通过添加名为PRESTO_PASSWORD的环境变量来传入密码。<br>
设置其他参数：可以将参数设置到名为PRESTO_CLI_PARAMS的环境变量中，如PRESTO_CLI_PARAMS="--catalog mysql --schema db1 "。<br>

2. 通过自定义变量<br>
设置密码：在作业自定义变量中添加名为presto.password的变量，即可设置Presto认证密码。<br>
设置其他参数：在作业自定义变量中添加如_presto.xxx的变量，都会被添加到Presto Cli参数列表中，对应的选项为--xxx。<br>

支持如下自定义变量。
```
## 基本参数
* _presto.schema <schema>
* _presto.catalog <catalog>

## 控制/调试参数
* _presto.trace-token <trace token>
* _presto.session <session>...
* _presto.source <source>
* _presto.resource-estimate <resource-estimate>...
* _presto.log-levels-file <log levels file>

## 连接参数
* _presto.server <server>
* _presto.http-proxy <http-proxy>  * ignore-errors
* _presto.socks-proxy <socks-proxy>

## 认证相关参数
* _presto.user <user>
* _presto.password <password>

* _presto.client-info <client-info>
* _presto.client-request-timeout <client request timeout>
* _presto.client-tags <client tags>

* _presto.access-token <access token>
* _presto.truststore-password <truststore password>
* _presto.truststore-path <truststore path>
* _presto.keystore-password <keystore password>
* _presto.keystore-path <keystore path>
* _presto.extra-credential <extra-credential>...

## 高安全相关参数
* _presto.krb5-config-path <krb5 config path>
* _presto.krb5-credential-cache-path <krb5 credential cache path>
* _presto.krb5-disable-remote-service-hostname-canonicalization
* _presto.krb5-keytab-path <krb5 keytab path>
* _presto.krb5-principal <krb5 principal>
* _presto.krb5-remote-service-name <krb5 remote service name>
* _presto.krb5-service-principal-pattern <krb5 remote service principal pattern>
```

##### Impala SQL 作业
impala-shell -f {SQL_CONTENT} [options];

SQL_CONTENT 填写的SQL语句。

options 添加环境变量IMPALA_CLI_PARAMS，例如IMAPAL_CLI_PARAMS="-u hive"。

##### sqoop 作业
sqoop [args]

##### Spark 作业
spark-submit [options] --class [MainClass] xxx.jar args

作业内容： --master yarn-client --driver-memory 7G --executor-memory 5G --executor-cores 1 --num-executors 32 --class com.aliyun.emr.checklist.benchmark.SparkWordCount emr-checklist_2.10-0.1.0.jar oss://emr/checklist/data/wc oss://emr/checklist/data/wc-counts 32

##### Spark Shell 作业
spark-shell

作业内容：
```shell
val count = sc.parallelize(1 to 100).filter { _ =>
  val x = math.random
  val y = math.random
  x*x + y*y < 1
}.count();
println("Pi is roughly ${4.0 * count / 100}")
```

##### Spark Streaming 作业
spark-submit [options] --class [MainClass] xxx.jar args

作业内容：--master yarn-client --driver-memory 7G --executor-memory 5G --executor-cores 1 --num-executors 32 --class com.aliyun.emr.checklist.benchmark.SlsStreaming emr-checklist_2.10-0.1.0.jar <project> <logstore> <accessKey> <secretKey>

##### Spark SQL 作业
spark-sql [options] [cli options] {SQL_CONTENT}        
       
options 添加环境变量SPARK_CLI_PARAMS，例如SPARK_CLI_PARAMS="--executor-memory 1g --executor-cores"

cli options 示例如下：<br>
 -e <quoted-query-string> ：表示运行引号内的SQL查询语句。<br>
-f <filename>：表示运行文件中的SQL语句。<br>

SQL_CONTENT 填写的SQL语句。

##### streaming sql 作业
streaming-sql -f {sql_script}

sql_script中保存着作业编辑器中填写的SQL语句。
```sql

--- 创建SLS数据表。 
CREATE TABLE IF NOT EXISTS ${slsTableName} 
   USING loghub 
   OPTIONS ( 
        sls.project = '${logProjectName}', 
        sls.store = '${logStoreName}', 
        access.key.id = '${accessKeyId}', 
        access.key.secret = '${accessKeySecret}', 
        endpoint = '${endpoint}'
   ); 
--- 导入数据至HDFS。
INSERT INTO 
    ${hdfsTableName} 
SELECT 
    col1, col2 
FROM  ${slsTableName} 
WHERE ${condition}

```

##### Flink 作业

run -m yarn-cluster -yjm 1024 -ytm 2048 ossref://path/to/oss/of/WordCount.jar --input oss://path/to/oss/to/data --output oss://path/to/oss/to/result

**PyFlink作业**

run -m yarn-cluster -yjm 1024 -ytm 2048 -py ossref://path/to/oss/of/word_count.py

#### 作业配置
在作业编辑的过程中，支持在作业参数中设置时间变量通配符。

##### 变量通配符格式
阿里云 E-MapReduce 所支持的变量通配符的格式为${dateexpr-1d}或者${dateexpr-1h}。其中dateexpr表示标准的时间格式表达式，对应的规则如下。

注意 请注意时间格式的大小写。

| 格式 | 描述 |
| ---|--- |
| yyyy | 表示4位的年份。 |
| MM | 表示月份。 |
| dd | 表示天。 |
| HH | 表示24小时制，12小时制使用hh。 |
| mm | 表示分钟。 |
| ss | 表示秒。 |

时间变量可以是包含yyyy年份的任意时间组合，同时支持用加号（+）和减号（-）来分别表示延后和提前。例如，变量${yyyy-MM-dd}表示当前日期，则：

- 后1年的表示方式：${yyyy+1y}或者${yyyy-MM-dd hh:mm:ss+1y}。
- 后3月的表示方式：${yyyyMM+3m}或者${yyyy-MM-dd hh:mm:ss+3m}。
- 前5天的表示方式：${yyyyMMdd-5d}或者${yyyy-MM-dd hh:mm:ss-5d}。


阿里云 E-MapReduce 仅支持小时和天维度的加减，即只支持在dateexpr后面+Nd、-Nd、+Nh、-Nh的形式（dateexpr为时间格式表达式，N为整数）。

时间变量参数必须以yyyy开始，如${yyyy-MM}。如果希望单独获取月份等特定时间区域的值，可以在作业内容中使用如下两个函数提取：

- parseDate(<参数名称>, <时间格式>)：将给定参数转换为Date对象。其中，参数名称为上述配置参数中设置的一个变量名，时间格式为设置该变量时所使用的时间格式。如设置一个变量current_time = ${yyyyMMddHHmmss-1d}，则此处时间格式应设置为yyyyMMddHHmmss。
- formatDate(<Date对象>, <时间格式>)：将给定Date对象转换为给定格式的时间字符串。

函数使用示例：<br>
获取current_time变量的小时字面值：${formatDate(parseDate(current_time, 'yyyyMMddHHmmss'), 'HH')}<br>
获取current_time变量的年字面值：${formatDate(parseDate(current_time, 'yyyyMMddHHmmss'), 'yyyy')}<br>


#### 参数配置

##### HDFS
```hadoop-env.sh
hadoop_secondarynamenode_opts -server -XX:ParallelGCThreads=8 -XX:+UseConcMarkSweepGC -XX:NewRatio=3 -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=100M -XX:CMSInitiatingOccupancyFraction=80 -XX:+UseCMSInitiatingOccupancyOnly -XX:+DisableExplicitGC

yarn_nodemanager_heapsize 1536

hadoop_namenode_heapsize 1792

yarn_resourcemanager_heapsize 2304

hadoop_datanode_opts -Dhadoop.security.logger=ERROR,RFAS $HADOOP_DATANODE_OPTS

hadoop_secondary_namenode_heapsize 1024

hadoop_namenode_opts -server -XX:ParallelGCThreads=8 -XX:+UseConcMarkSweepGC -XX:NewRatio=3 -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=100M -XX:CMSInitiatingOccupancyFraction=80 -XX:+UseCMSInitiatingOccupancyOnly -XX:+DisableExplicitGC

hadoop_datanode_heapsize 1152
```

```hdfs-site.xml
dfs.balancer.address 0.0.0.0:0
dfs.balancer.block-move.timeout 600000
dfs.balancer.kerberos.principal
dfs.balancer.keytab.enabled false
dfs.balancer.keytab.file
dfs.balancer.max-iteration-time 1200000
dfs.balancer.max-no-move-interval 60000

dfs.block.local-path-access.user
dfs.block.scanner.volume.bytes.per.second 1048576
dfs.blockreport.initialDelay 0
dfs.blockreport.intervalMsec 21600000
dfs.blockreport.split.threshold 1000000
dfs.blocksize 134217728

dfs.bytes-per-checksum 512

dfs.cachereport.intervalMsec 10000

dfs.client-write-packet-size 65536
dfs.client.block.write.locateFollowingBlock.initial.delay.ms 400
dfs.client.block.write.locateFollowingBlock.retries 8
dfs.client.block.write.replace-datanode-on-failure.best-effort false
dfs.client.block.write.replace-datanode-on-failure.enable true
dfs.client.block.write.replace-datanode-on-failure.min-replication 0
dfs.client.block.write.replace-datanode-on-failure.policy DEFAULT
dfs.client.block.write.retries 3
dfs.client.cache.drop.behind.reads
dfs.client.cache.drop.behind.writes
dfs.client.cache.readahead
dfs.client.context default
dfs.client.datanode-restart.timeout 30
dfs.client.domain.socket.data.traffic false
dfs.client.failover.connection.retries 0
dfs.client.failover.connection.retries.on.timeouts 0
dfs.client.failover.max.attempts 15
dfs.client.failover.sleep.base.millis 500
dfs.client.failover.sleep.max.millis 15000
dfs.client.file-block-storage-locations.num-threads 10
dfs.client.file-block-storage-locations.timeout.millis 60000
dfs.client.local.interfaces
dfs.client.mmap.cache.size 256
dfs.client.mmap.cache.timeout.ms 3600000
dfs.client.mmap.enabled true
dfs.client.mmap.retry.timeout.ms 300000
dfs.client.read.shortcircuit true
dfs.client.read.shortcircuit.skip.checksum false
dfs.client.read.shortcircuit.streams.cache.expiry.ms 300000
dfs.client.read.shortcircuit.streams.cache.size 256
dfs.client.server-defaults.validity.period.ms 3600000
dfs.client.short.circuit.replica.stale.threshold.ms 1800000
dfs.client.slow.io.warning.threshold.ms 30000
dfs.client.socket.send.buffer.size 0
dfs.client.use.datanode.hostname false
dfs.client.use.legacy.blockreader.local false
dfs.client.write.exclude.nodes.cache.expiry.interval.millis 600000

dfs.data.transfer.protection
dfs.data.transfer.saslproperties.resolver.class

dfs.datanode.available-space-volume-choosing-policy.balanced-space-preference-fraction 0.75f
dfs.datanode.available-space-volume-choosing-policy.balanced-space-threshold 10737418240
dfs.datanode.balance.bandwidthPerSec 104857600
dfs.datanode.balance.max.concurrent.moves 20
dfs.datanode.block-pinning.enabled false
dfs.datanode.block.id.layout.upgrade.threads 12
dfs.datanode.bp-ready.timeout 20
dfs.datanode.cache.revocation.polling.ms 500
dfs.datanode.cache.revocation.timeout.ms 900000

dfs.datanode.data.dir {% set comma = joiner(',') %}{% for idx in range(diskCnt) -%}{% if idx+1 not in faulty -%}{{ comma() }}file:///mnt/disk{{ idx + 1 }}/hdfs{% endif %}{% endfor %}

dfs.datanode.data.dir.perm 755
dfs.datanode.directoryscan.interval 21600
dfs.datanode.directoryscan.threads 1
dfs.datanode.directoryscan.throttle.limit.ms.per.sec 1000
dfs.datanode.drop.cache.behind.reads false
dfs.datanode.drop.cache.behind.writes false
dfs.datanode.du.reserved 8589934592
dfs.datanode.failed.volumes.tolerated 0
dfs.datanode.fsdatasetcache.max.threads.per.volume 4
dfs.datanode.handler.count 30
dfs.datanode.hdfs-blocks-metadata.enabled true
dfs.datanode.imbalance.threshold 10
dfs.datanode.kerberos.principal
dfs.datanode.lifeline.interval.seconds
dfs.datanode.max.locked.memory 0
dfs.datanode.max.transfer.threads 4096
dfs.datanode.metrics.logger.period.seconds 600
dfs.datanode.plugins
dfs.datanode.readahead.bytes 4194304
dfs.datanode.scan.period.hours 504
dfs.datanode.shared.file.descriptor.paths /dev/shm,/tmp
dfs.datanode.slow.io.warning.threshold.ms 300
dfs.datanode.sync.behind.writes false
dfs.datanode.transfer.socket.recv.buffer.size 0
dfs.datanode.transfer.socket.send.buffer.size 0
dfs.datanode.use.datanode.hostname false

dfs.domain.socket.path /var/lib/hadoop-hdfs/dn_socket

dfs.encrypt.data.transfer false
dfs.encrypt.data.transfer.algorithm
dfs.encrypt.data.transfer.cipher.key.bitlength 128
dfs.encrypt.data.transfer.cipher.suites

dfs.ha.automatic-failover.enabled false
dfs.ha.log-roll.period 120
dfs.ha.namenode.id
dfs.ha.namenodes.EXAMPLENAMESERVICE
dfs.ha.tail-edits.period 60
dfs.ha.zkfc.nn.http.timeout.ms 20000

dfs.heartbeat.interval 3

dfs.hosts
dfs.hosts.exclude /etc/ecm/hadoop-conf/dfs.exclude

dfs.http.address 0.0.0.0:50070
dfs.http.client.failover.max.attempts 15
dfs.http.client.failover.sleep.base.millis 500
dfs.http.client.failover.sleep.max.millis 15000
dfs.http.client.retry.max.attempts 10
dfs.http.client.retry.policy.enabled false
dfs.http.client.retry.policy.spec 10000,6,60000,10

dfs.image.compress false
dfs.image.compression.codec org.apache.hadoop.io.compress.DefaultCodec
dfs.image.transfer-bootstrap-standby.bandwidthPerSec 0
dfs.image.transfer.bandwidthPerSec 0
dfs.image.transfer.chunksize 65536
dfs.image.transfer.timeout 60000

dfs.internal.nameservices

dfs.journalnode.kerberos.internal.spnego.principal
dfs.journalnode.kerberos.principal
dfs.journalnode.keytab.file

dfs.lock.suppress.warning.interval 10s

dfs.metrics.percentiles.intervals

dfs.mover.max-no-move-interval 60000

dfs.namenode.accesstime.precision 3600000
dfs.namenode.acls.enabled false
dfs.namenode.audit.log.debug.cmdlist
dfs.namenode.audit.loggers default
dfs.namenode.avoid.read.stale.datanode false
dfs.namenode.avoid.write.stale.datanode false
dfs.namenode.balancer.request.standby true
dfs.namenode.block-placement-policy.default.prefer-local-node true
dfs.namenode.blocks.per.postponedblocks.rescan 10000
dfs.namenode.checkpoint.check.period 60
dfs.namenode.checkpoint.dir file:///mnt/disk1/hdfs/namesecondary
dfs.namenode.checkpoint.edits.dir ${dfs.namenode.checkpoint.dir}
dfs.namenode.checkpoint.max-retries 3
dfs.namenode.checkpoint.period 3600
dfs.namenode.checkpoint.txns 1000000
dfs.namenode.datanode.registration.ip-hostname-check false
dfs.namenode.decommission.blocks.per.interval 500000
dfs.namenode.decommission.interval 30
dfs.namenode.decommission.max.concurrent.tracked.nodes 100
dfs.namenode.delegation.key.update-interval 86400000
dfs.namenode.delegation.token.max-lifetime 604800000
dfs.namenode.delegation.token.renew-interval 86400000
dfs.namenode.edekcacheloader.initial.delay.ms 3000
dfs.namenode.edekcacheloader.interval.ms 1000
dfs.namenode.edit.log.autoroll.check.interval.ms 300000
dfs.namenode.edit.log.autoroll.multiplier.threshold 2.0
dfs.namenode.edits.asynclogging true
dfs.namenode.edits.dir file:///mnt/disk1/hdfs/edits
dfs.namenode.edits.noeditlogchannelflush false
dfs.namenode.enable.retrycache true
dfs.namenode.fs-limits.max-xattr-size 16384
dfs.namenode.fs-limits.max-xattrs-per-inode 32
dfs.namenode.fslock.fair true
dfs.namenode.full.block.report.lease.length.ms 300000
dfs.namenode.handler.count 50
dfs.namenode.hosts.provider.classname org.apache.hadoop.hdfs.server.blockmanagement.HostFileManager
dfs.namenode.http-address 50070
dfs.namenode.http-bind-host 0.0.0.0
dfs.namenode.https-bind-host 0.0.0.0
dfs.namenode.inotify.max.events.per.rpc 1000
dfs.namenode.invalidate.work.pct.per.iteration 0.32f
dfs.namenode.kerberos.internal.spnego.principal ${dfs.web.authentication.kerberos.principal}
dfs.namenode.kerberos.principal
dfs.namenode.kerberos.principal.pattern *
dfs.namenode.keytab.file
dfs.namenode.lease-recheck-interval-ms 2000
dfs.namenode.legacy-oiv-image.dir
dfs.namenode.lifeline.handler.count
dfs.namenode.lifeline.handler.ratio 0.10
dfs.namenode.list.cache.directives.num.responses 100
dfs.namenode.list.cache.pools.num.responses 100
dfs.namenode.list.encryption.zones.num.responses 100
dfs.namenode.list.openfiles.num.responses 1000
dfs.namenode.lock.detailed-metrics.enabled false
dfs.namenode.max-lock-hold-to-release-lease-ms 25
dfs.namenode.max.extra.edits.segments.retained 10000
dfs.namenode.max.full.block.report.leases 6
dfs.namenode.max.objects 0
dfs.namenode.metrics.logger.period.seconds 600
dfs.namenode.name.dir file:///mnt/disk1/hdfs/name
dfs.namenode.num.checkpoints.retained 2
dfs.namenode.num.extra.edits.retained 1000000
dfs.namenode.path.based.cache.block.map.allocation.percent 0.25
dfs.namenode.path.based.cache.refresh.interval.ms 30000
dfs.namenode.path.based.cache.retry.interval.ms 30000
dfs.namenode.plugins
dfs.namenode.quota.init-threads 4
dfs.namenode.read-lock-reporting-threshold-ms 5000
dfs.namenode.reject-unresolved-dn-topology-mapping false
dfs.namenode.replication.interval 3
dfs.namenode.replication.max-streams 100
dfs.namenode.replication.max-streams-hard-limit 100
dfs.namenode.replication.min 1
dfs.namenode.replication.work.multiplier.per.iteration 100
dfs.namenode.resource.check.interval 5000
dfs.namenode.resource.checked.volumes dfs.datanode.keytab.file
dfs.namenode.resource.checked.volumes.minimum 1
dfs.namenode.resource.du.reserved 1073741824
dfs.namenode.retrycache.expirytime.millis 600000
dfs.namenode.retrycache.heap.percent 0.03f
dfs.namenode.rpc-bind-host 0.0.0.0
dfs.namenode.safemode.extension 30000
dfs.namenode.safemode.min.datanodes 0
dfs.namenode.safemode.replication.min
dfs.namenode.safemode.threshold-pct 0.999f
dfs.namenode.service.handler.count 30
dfs.namenode.servicerpc-bind-host 0.0.0.0
dfs.namenode.stale.datanode.interval 30000
dfs.namenode.startup.delay.block.deletion.sec 0
dfs.namenode.support.allow.format true
dfs.namenode.top.enabled true
dfs.namenode.top.num.users 10
dfs.namenode.top.window.num.buckets 10
dfs.namenode.top.windows.minutes 1,5,25
dfs.namenode.upgrade.domain.factor ${dfs.replication}
dfs.namenode.write-lock-reporting-threshold-ms 5000
dfs.namenode.write.stale.datanode.ratio 0.5f
dfs.namenode.xattrs.enabled true

dfs.nameservice.id
dfs.nameservices

dfs.permissions.enabled false
dfs.permissions.superusergroup hadoop

dfs.reformat.disabled false

dfs.replication 2
dfs.replication.max 512

dfs.secondary.namenode.kerberos.internal.spnego.principal ${dfs.web.authentication.kerberos.principal}

dfs.short.circuit.shared.memory.watcher.interrupt.check.ms 60000

dfs.storage.policy.enabled true

dfs.stream-buffer-size 4096

dfs.support.append true

dfs.trustedchannel.resolver.class

dfs.user.home.dir.prefix /user

dfs.web.authentication.kerberos.keytab
dfs.web.authentication.kerberos.principal

dfs.webhdfs.enabled false
dfs.webhdfs.rest-csrf.browser-useragents-regex ^Mozilla.*,^Opera.*
dfs.webhdfs.rest-csrf.custom-header X-XSRF-HEADER
dfs.webhdfs.rest-csrf.enabled false
dfs.webhdfs.rest-csrf.methods-to-ignore GET,OPTIONS,HEAD,TRACE
dfs.webhdfs.socket.connect-timeout 60s
dfs.webhdfs.socket.read-timeout 60s
dfs.webhdfs.ugi.expire.after.access 600000
dfs.webhdfs.use.ipc.callq true
dfs.webhdfs.user.provider.user.pattern ^[A-Za-z_][A-Za-z0-9._-]*[$]?$

dfs.xframe.enabled true
dfs.xframe.value SAMEORIGIN

fs.oss.buffer.dirs {% set comma = joiner(',') %}{% for idx in range(diskCnt) -%}{% if idx+1 not in faulty -%}{{ comma() }}file:///mnt/disk{{ idx + 1 }}/data{% endif %}{% endfor %}

hadoop.fuse.connection.timeout 300
hadoop.fuse.timer.period 5

hadoop.hdfs.configuration.version 1

hadoop.user.group.metrics.percentiles.intervals

httpfs.buffer.size 4096

mapreduce.job.acl-view-job *

nfs.allow.insecure.ports true
nfs.dump.dir /tmp/.hdfs-nfs
nfs.kerberos.principal
nfs.keytab.file
nfs.mountd.port 4242
nfs.rtmax 1048576
nfs.server.port 2049
nfs.wtmax 1048576
```

```core-site.xml
file.blocksize 67108864
file.replication 1

fs.defaultFS hdfs://emr-header-1.cluster-245192:9000
fs.df.interval 60000
fs.du.interval 600000
fs.permissions.umask-mode 026
fs.trash.checkpoint.interval 30
fs.trash.interval 1440

ha.failover-controller.new-active.rpc-timeout.ms 60000
ha.health-monitor.check-interval.ms 1000
ha.zookeeper.parent-znode /hadoop-ha
ha.zookeeper.session-timeout.ms 60000

hadoop.caller.context.enabled false
hadoop.home /usr/lib/hadoop
hadoop.http.authentication.simple.anonymous.allowed false

hadoop.proxyuser.flowagent.groups *
hadoop.proxyuser.flowagent.hosts *
hadoop.proxyuser.hadoop.groups *
hadoop.proxyuser.hadoop.hosts *
hadoop.proxyuser.hbase.groups *
hadoop.proxyuser.hbase.hosts *
hadoop.proxyuser.hdfs.groups *
hadoop.proxyuser.hdfs.hosts *
hadoop.proxyuser.hue.groups *
hadoop.proxyuser.hue.hosts *
hadoop.proxyuser.knox.groups *
hadoop.proxyuser.knox.hosts *
hadoop.proxyuser.livy.groups *
hadoop.proxyuser.livy.hosts *
hadoop.proxyuser.oozie.groups *
hadoop.proxyuser.oozie.hosts *
hadoop.proxyuser.presto.groups *
hadoop.proxyuser.presto.hosts *

hadoop.registry.zk.connection.timeout.ms 15000
hadoop.registry.zk.quorum localhost:2181
hadoop.registry.zk.session.timeout.ms 60000

hadoop.security.auth_to_local RULE:[1:$1] RULE:[2:$1] DEFAULT
hadoop.security.authentication.use.has false

hadoop.tmp.dir /mnt/disk1/hadoop/tmp
hadoop.util.hash.type murmur

io.bytes.per.checksum 512

io.compression.codec.lzo.class com.hadoop.compression.lzo.LzoCodec

io.compression.codecs com.hadoop.compression.lzo.LzoCodec,com.hadoop.compression.lzo.LzopCodec,org.apache.hadoop.io.compress.DefaultCodec,org.apache.hadoop.io.compress.GzipCodec,org.apache.hadoop.io.compress.BZip2Codec,org.apache.hadoop.io.compress.DeflateCodec,org.apache.hadoop.io.compress.SnappyCodec,org.apache.hadoop.io.compress.Lz4Codec

io.file.buffer.size 4096

io.mapfile.bloom.size 1048576
io.seqfile.compress.blocksize 1000000
io.seqfile.local.dir ${hadoop.tmp.dir}/io/local

io.serializations org.apache.hadoop.io.serializer.WritableSerialization,org.apache.hadoop.io.serializer.avro.AvroSpecificSerialization,org.apache.hadoop.io.serializer.avro.AvroReflectSerialization

ipc.client.connect.max.retries 10
ipc.client.connect.max.retries.on.timeouts 45
ipc.client.connect.retry.interval 1000
ipc.client.connect.timeout 20000
ipc.client.connection.maxidletime 10000
ipc.client.idlethreshold 4000
ipc.client.kill.max 10
```

##### YARN
```yarn-env.sh
yarn_resourcemanager_opts
yarn_proxy_heapsize 512
yarn_nodemanager_heapsize 1536
yarn_nodemanager_opts
yarn_resourcemanager_heapsize 2304
yarn_proxyserver_opts
yarn_timelineserver_opts
yarn_timelineserver_heapsize 512

```
```yarn-site.xml
am.liveness-monitor.expiry-interval-ms 600000

yarn.acl.enable false
yarn.admin.acl has
yarn.am.liveness-monitor.expiry-interval-ms 600000
yarn.app.mapreduce.am.labels CORE

yarn.application.classpath $HADOOP_CONF_DIR,$HADOOP_COMMON_HOME/share/hadoop/common/*,$HADOOP_COMMON_HOME/share/hadoop/common/lib/*,$HADOOP_HDFS_HOME/share/hadoop/hdfs/*,$HADOOP_HDFS_HOME/share/hadoop/hdfs/lib/*,$HADOOP_YARN_HOME/share/hadoop/yarn/*,$HADOOP_YARN_HOME/share/hadoop/yarn/lib/*,/opt/apps/extra-jars/*,$HADOOP_HOME/share/hadoop/tools/lib/*

yarn.client.application-client-protocol.poll-interval-ms 200
yarn.client.failover-proxy-provider org.apache.hadoop.yarn.client.ConfiguredRMFailoverProxyProvider

yarn.dispatcher.drain-events.timeout 300000
yarn.dispatcher.exit-on-error true

yarn.fail-fast false
yarn.label.enabled true

yarn.log-aggregation-enable true
yarn.log-aggregation.retain-seconds 604800
yarn.log.server.url http://emr-header-1.cluster-245192:19888/jobhistory/logs

yarn.nm.liveness-monitor.expiry-interval-ms 600000

yarn.nodemanager.aux-services mapreduce_shuffle,spark_shuffle
yarn.nodemanager.aux-services.spark_shuffle.class org.apache.spark.network.yarn.YarnShuffleService
yarn.nodemanager.bind-host 0.0.0.0
yarn.nodemanager.container-executor.class org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor
yarn.nodemanager.container-manager.thread-count 20
yarn.nodemanager.container-metrics.enable false
yarn.nodemanager.container-monitor.interval-ms 3000
yarn.nodemanager.delete.debug-delay-sec 0
yarn.nodemanager.delete.thread-count 4
yarn.nodemanager.disk-health-checker.max-disk-utilization-per-disk-percentage 90.0
yarn.nodemanager.disk-health-checker.min-free-space-per-disk-mb 0
yarn.nodemanager.disk-health-checker.min-healthy-disks 0.25
yarn.nodemanager.labels MASTER

yarn.nodemanager.local-dirs {% set comma = joiner(',') %}{% for idx in range(diskCnt) -%}{% if idx+1 not in faulty -%}{{ comma() }}file:///mnt/disk{{ idx + 1 }}/yarn{% endif %}{% endfor %}

yarn.nodemanager.localizer.client.thread-count 5
yarn.nodemanager.localizer.fetch.thread-count 4

yarn.nodemanager.log-dirs {% set comma = joiner(',') %}{% for idx in range(diskCnt) -%}{% if idx+1 not in faulty -%}{{ comma() }}file:///mnt/disk{{ idx + 1 }}/log/hadoop-yarn/containers{% endif %}{% endfor %}

yarn.nodemanager.process-kill-wait.ms 2000
yarn.nodemanager.remote-app-log-dir hdfs://emr-header-1.cluster-245192:9000/tmp/logs
yarn.nodemanager.resource.cpu-vcores 8
yarn.nodemanager.resource.memory-mb 11584
yarn.nodemanager.sleep-delay-before-sigkill.ms 250
yarn.nodemanager.vmem-check-enabled false
yarn.nodemanager.vmem-pmem-ratio 5000

yarn.resourcemanager.address emr-header-1.cluster-245192:8032
yarn.resourcemanager.am.max-attempts 2
yarn.resourcemanager.amlauncher.thread-count 50
yarn.resourcemanager.bind-host 0.0.0.0
yarn.resourcemanager.client.thread-count 50
yarn.resourcemanager.connect.max-wait.ms 900000
yarn.resourcemanager.connect.retry-interval.ms 30000
yarn.resourcemanager.container.liveness-monitor.interval-ms 600000
yarn.resourcemanager.ha.automatic-failover.embedded true
yarn.resourcemanager.ha.automatic-failover.enabled true
yarn.resourcemanager.hostname 0.0.0.0
yarn.resourcemanager.max-completed-applications 10000
yarn.resourcemanager.nodemanager-connect-retries 10
yarn.resourcemanager.nodemanagers.heartbeat-interval-ms 1000
yarn.resourcemanager.nodes.exclude-path /etc/ecm/hadoop-conf/yarn.exclude
yarn.resourcemanager.proxy-user-privileges.enabled false
yarn.resourcemanager.recovery.enabled false
yarn.resourcemanager.resource-tracker.address emr-header-1.cluster-245192:8025
yarn.resourcemanager.resource-tracker.client.thread-count 64
yarn.resourcemanager.scheduler.address emr-header-1.cluster-245192:8030
yarn.resourcemanager.scheduler.class org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler
yarn.resourcemanager.scheduler.client.thread-count 50
yarn.resourcemanager.store.class org.apache.hadoop.yarn.server.resourcemanager.recovery.ZKRMStateStore
yarn.resourcemanager.system-metrics-publisher.enabled true
yarn.resourcemanager.webapp.address emr-header-1.cluster-245192:8088
yarn.resourcemanager.zk-timeout-ms 60000

yarn.scheduler.fair.allocation.file /etc/ecm/hadoop-conf/fair-scheduler.xml
yarn.scheduler.fair.allow-undeclared-pools true
yarn.scheduler.fair.assignmultiple false
yarn.scheduler.fair.dynamic.max.assign true
yarn.scheduler.fair.locality.threshold.node -1.0
yarn.scheduler.fair.locality.threshold.rack -1.0
yarn.scheduler.fair.max.assign -1
yarn.scheduler.fair.preemption false
yarn.scheduler.fair.preemption.cluster-utilization-threshold 0.8f
yarn.scheduler.fair.sizebasedweight false
yarn.scheduler.fair.update-interval-ms 500
yarn.scheduler.fair.user-as-default-queue false
yarn.scheduler.increment-allocation-mb 1024
yarn.scheduler.increment-allocation-vcores 1
yarn.scheduler.maximum-allocation-mb 11584
yarn.scheduler.maximum-allocation-vcores 32
yarn.scheduler.minimum-allocation-mb 32

yarn.timeline-service.bind-host 0.0.0.0
yarn.timeline-service.enabled true
yarn.timeline-service.hostname emr-header-1.cluster-245192
yarn.timeline-service.http-cross-origin.enabled true
yarn.timeline-service.store-class org.apache.hadoop.yarn.server.timeline.RollingLevelDBTimelineStore

yarn.web-proxy.address emr-header-1.cluster-245192:20888
```

```mapred-env.sh
jobhistory_heapsize 512

hadoop_job_historyserver_opts -javaagent:/var/lib/ecm-agent/data/jmxetric-1.0.8.jar=host=localhost,port=8649,mode=unicast,wireformat31x=true,process=YARN_JobHistory,config=/var/lib/ecm-agent/data/jmxetric.xml -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=128M -Xloggc:${YARN_LOG_DIR}/jobhistory-gc.log

```

```mapred-site.xml
map.sort.class org.apache.hadoop.util.QuickSort

mapred.local.dir {% set comma = joiner(',') %}{% for idx in range(diskCnt) -%}{% if idx+1 not in faulty -%}{{ comma() }}file:///mnt/disk{{ idx + 1 }}/mapred/local{% endif %}{% endfor %}

mapreduce.am.max-attempts 2

mapreduce.application.classpath $HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*,$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*,/usr/lib/hadoop-lzo/lib/*

mapreduce.cluster.acls.enabled false
mapreduce.cluster.local.dir {% set comma = joiner(',') %}{% for idx in range(diskCnt) -%}{% if idx+1 not in faulty -%}{{ comma() }}file:///mnt/disk{{ idx + 1 }}/mapred/local{% endif %}{% endfor %}

mapreduce.cluster.temp.dir ${hadoop.tmp.dir}/mapred/temp
mapreduce.framework.name yarn

mapreduce.job.acl-modify-job
mapreduce.job.acl-view-job
mapreduce.job.classloader false
mapreduce.job.counters.max 1000
mapreduce.job.jvm.numtasks 20
mapreduce.job.log4j-properties-file
mapreduce.job.maps 16
mapreduce.job.queuename default
mapreduce.job.reducer.preempt.delay.sec 0
mapreduce.job.reduces 7
mapreduce.job.running.map.limit 0
mapreduce.job.running.reduce.limit 0
mapreduce.job.tags
mapreduce.job.userlog.retain.hours 48

mapreduce.jobhistory.address emr-header-1.cluster-245192:10020
mapreduce.jobhistory.admin.acl *
mapreduce.jobhistory.admin.address emr-header-1.cluster-245192:10033
mapreduce.jobhistory.http.policy HTTP_ONLY
mapreduce.jobhistory.recovery.enable false
mapreduce.jobhistory.recovery.store.class org.apache.hadoop.mapreduce.v2.hs.HistoryServerFileSystemStateStoreService
mapreduce.jobhistory.recovery.store.fs.uri ${hadoop.tmp.dir}/mapred/history/recoverystore
mapreduce.jobhistory.store.class
mapreduce.jobhistory.webapp.address emr-header-1.cluster-245192:19888
mapreduce.jobtracker.addressemr-header-1.cluster-245192:8021
mapreduce.jobtracker.http.address emr-header-1.cluster-245192:50030
mapreduce.jobtracker.jobhistory.location
mapreduce.jobtracker.restart.recover false
mapreduce.jobtracker.taskscheduler org.apache.hadoop.mapred.JobQueueTaskScheduler

mapreduce.map.cpu.vcores 1
mapreduce.map.java.opts -Xmx1158m -XX:ParallelGCThreads=2 -XX:CICompilerCount=2
mapreduce.map.log.level INFO
mapreduce.map.memory.mb 1448
mapreduce.map.output.compress true
mapreduce.map.output.compress.codec org.apache.hadoop.io.compress.DefaultCodec
mapreduce.map.sort.spill.percent 0.8
mapreduce.map.speculative true

mapreduce.output.fileoutputformat.compress false
mapreduce.output.fileoutputformat.compress.codec org.apache.hadoop.io.compress.DefaultCodec
mapreduce.output.fileoutputformat.compress.type BLOCK
mapreduce.outputcommitter.class com.aliyun.emr.fs.oss.commit.JindoOssCommitter

mapreduce.reduce.cpu.vcores 1
mapreduce.reduce.java.opts -Xmx2316m -XX:ParallelGCThreads=2 -XX:CICompilerCount=2
mapreduce.reduce.log.level INFO
mapreduce.reduce.memory.mb 2896
mapreduce.reduce.shuffle.parallelcopies 20
mapreduce.reduce.speculative true

mapreduce.shuffle.manage.os.cache false
mapreduce.shuffle.max.connections 0
mapreduce.shuffle.max.threads 0
mapreduce.shuffle.port 13562
mapreduce.shuffle.ssl.enabled false
mapreduce.shuffle.transfer.buffer.size 131072
mapreduce.shuffle.transferTo.allowed

mapreduce.task.io.sort.factor 48
mapreduce.task.io.sort.mb 200
mapreduce.task.timeout 600000

mapreduce.tasktracker.group
mapreduce.tasktracker.http.address emr-header-1.cluster-245192:50060
mapreduce.tasktracker.http.threads 60
mapreduce.tasktracker.map.tasks.maximum 1
mapreduce.tasktracker.reduce.tasks.maximum 1
mapreduce.tasktracker.taskcontroller org.apache.hadoop.mapred.DefaultTaskController

yarn.app.mapreduce.am.admin.user.env
yarn.app.mapreduce.am.command-opts -Xmx2316m
yarn.app.mapreduce.am.env
yarn.app.mapreduce.am.jhs.backup-dir file:///mnt/disk1/log/hadoop-mapreduce/history
yarn.app.mapreduce.am.jhs.backup.enabled true
yarn.app.mapreduce.am.job.task.listener.thread-count 60
yarn.app.mapreduce.am.resource.cpu-vcores 1
yarn.app.mapreduce.am.resource.mb 2896
yarn.app.mapreduce.am.staging-dir /tmp/hadoop-yarn/staging
yarn.app.mapreduce.client.job.max-retries 0
```

```xml capacity-scheduler
<configuration>
  <property>
    <name>yarn.scheduler.capacity.maximum-applications</name>
    <value>10000</value>
    <description>Maximum number of applications that can be pending and running.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.maximum-am-resource-percent</name>
    <value>0.25</value>
    <description>Maximum percent of resources in the cluster which can be used to run application masters i.e. controls number of concurrent running applications.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.resource-calculator</name>
    <value>org.apache.hadoop.yarn.util.resource.DefaultResourceCalculator</value>
    <description>The ResourceCalculator implementation to be used to compare Resources in the scheduler.The default i.e. DefaultResourceCalculator only uses Memory while DominantResourceCalculator uses dominant-resource to compare multi-dimensional resources such as Memory, CPU etc.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.queues</name>
    <value>default</value>
    <description>The queues at the this level (root is the root queue).</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.default.capacity</name>
    <value>100</value>
    <description>Default queue target capacity.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.default.user-limit-factor</name>
    <value>1</value>
    <description>Default queue user limit a percentage from 0.0 to 1.0.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.default.maximum-capacity</name>
    <value>100</value>
    <description>The maximum capacity of the default queue.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.default.state</name>
    <value>RUNNING</value>
    <description>The state of the default queue. State can be one of RUNNING or STOPPED.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.default.acl_submit_applications</name>
    <value>*</value>
    <description>The ACL of who can submit jobs to the default queue.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.default.acl_administer_queue</name>
    <value>*</value>
    <description>The ACL of who can administer jobs on the default queue.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.node-locality-delay</name>
    <value>-1</value>
    <description>Number of missed scheduling opportunities after which the CapacityScheduler attempts to schedule rack-local containers. Typically this should be set to number of nodes in the cluster.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.queue-mappings</name>
    <value></value>
    <description>A list of mappings that will be used to assign jobs to queues. The syntax for this list is [u|g]:[name]:[queue_name][,next mapping]* Typically this list will be used to map users to queues,for example, u:%user:%user maps all users to queues with the same name as the user.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.queue-mappings-override.enable</name>
    <value>false</value>
    <description>If a queue mapping is present, will it override the value specified by the user? This can be used by administrators to place jobs in queues that are different than the one specified by the user. The default is false.</description>
  </property>
</configuration>
```

```xml fair-scheduler
<allocations>
  <queue name="root">
    <minResources>10000 mb,10 vcores</minResources>
    <maxRunningApps>50</maxRunningApps>
    <maxAMShare>0.5f</maxAMShare>
    <weight>2.0</weight>
    <schedulingPolicy>fair</schedulingPolicy>
    <aclSubmitApps>*</aclSubmitApps>
    <aclAdministerApps>*</aclAdministerApps>
    <allowPreemptionFrom>true</allowPreemptionFrom>
    <queue name="default">
      <aclSubmitApps>*</aclSubmitApps>
      <minResources>10000 mb,10vcores</minResources>
    </queue>
  </queue>
  <userMaxAppsDefault>50</userMaxAppsDefault>
  <queueMaxAMShareDefault>0.5</queueMaxAMShareDefault>
  <queueMaxAppsDefault>50</queueMaxAppsDefault>
  <defaultQueueSchedulingPolicy>fair</defaultQueueSchedulingPolicy>
</allocations>
```

##### HIVE

```hive-env
HIVE_METASTORE_OPTS -javaagent:/var/lib/ecm-agent/data/jmxetric-1.0.8.jar=host=localhost,port=8649,mode=unicast,wireformat31x=true,process=HIVE_HiveMetaStore,config=/var/lib/ecm-agent/data/jmxetric.xml -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=128M -Xloggc:/var/log/hive/metastore-gc.log

HIVE_SERVER2_HEAPSIZE 512
HIVE_SERVER2_OPTS -javaagent:/var/lib/ecm-agent/data/jmxetric-1.0.8.jar=host=localhost,port=8649,mode=unicast,wireformat31x=true,process=HIVE_HiveServer2,config=/var/lib/ecm-agent/data/jmxetric.xml -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=128M -Xloggc:/var/log/hive/hiveserver2-gc.log

HIVE_AUX_JARS_PATH /opt/apps/hive-delta,/opt/apps/hive-hudi
HIVE_METASTORE_HEAPSIZE 512

```

```hive-site
dlf.catalog.accessKeyId
dlf.catalog.accessKeySecret

fs.jfs.cache.hive-fast-move false

hive.auto.convert.join true
hive.auto.convert.sortmerge.join true

hive.aux.jars.path

hive.blobstore.optimizations.enabled true
hive.blobstore.supported.schemes oss,s3,s3a,s3n
hive.blobstore.use.blobstore.as.scratchdir false

hive.cbo.enable true
hive.compactor.initiator.on false
hive.compactor.worker.threads 0
hive.convert.join.bucket.mapjoin.tez false
hive.downloaded.resources.dir /tmp/${hive.session.id}_resources

hive.exec.compress.output false
hive.exec.dynamic.partition true
hive.exec.dynamic.partition.mode nonstrict
hive.exec.max.created.files 100000
hive.exec.max.dynamic.partitions 1000
hive.exec.max.dynamic.partitions.pernode 100
hive.exec.mode.local.auto false
hive.exec.mode.local.auto.input.files.max 4
hive.exec.mode.local.auto.inputbytes.max 134217728
hive.exec.parallel true
hive.exec.parallel.thread.number 8
hive.exec.post.hooks com.aliyun.emr.meta.hive.hook.LineageLoggerHook,com.aliyun.emr.table.hive.HivePostHook
hive.exec.reducers.bytes.per.reducer 256000000
hive.exec.reducers.max 127
hive.exec.scratchdir /tmp/hive

hive.execution.engine mr

hive.fetch.task.conversion minimal
hive.fetch.task.conversion.threshold 268435456

hive.groupby.skewindata false
hive.ignore.mapjoin.hint true
hive.imetastoreclient.factory.class
hive.jar.path

hive.jindotable.native.enabled false
hive.jindotable.parquet.useEnd true
hive.jobname.length 50

hive.map.aggr true
hive.map.aggr.hash.force.flush.memory.threshold 0.9
hive.map.aggr.hash.min.reduction 0.5
hive.map.aggr.hash.percentmemory 0.5

hive.mapjoin.followby.map.aggr.hash.percentmemory 0.3
hive.mapjoin.hybridgrace.hashtable false
hive.mapjoin.smalltable.filesize 25000000

hive.mapred.reduce.tasks.speculative.execution true

hive.merge.mapfiles true
hive.merge.mapredfiles false
hive.merge.size.per.task 256000000
hive.merge.smallfiles.avgsize 64000000
hive.merge.sparkfiles false
hive.merge.tezfiles true

hive.metastore.client.socket.timeout 600s
hive.metastore.delta.compatible.mode.enabled true
hive.metastore.schema.verification false
hive.metastore.uris thrift://emr-header-1.cluster-245192:9083
hive.metastore.warehouse.dir /user/hive/warehouse

hive.optimize.dynamic.partition.hashjoin true
hive.optimize.skewjoin false

hive.security.metastore.authenticator.manager org.apache.hadoop.hive.ql.security.HadoopDefaultMetastoreAuthenticator
hive.security.metastore.authorization.manager org.apache.hadoop.hive.ql.security.authorization.DefaultHiveMetastoreAuthorizationProvider

hive.skewjoin.key 100000
hive.skewjoin.mapjoin.map.tasks 10000
hive.skewjoin.mapjoin.min.split 33554432

hive.stats.autogather true
hive.stats.column.autogather false
hive.stats.fetch.column.stats true

hive.strict.checks.cartesian.product false
hive.support.concurrency false

hive.tez.auto.reducer.parallelism true
hive.tez.container.size 2896
hive.tez.cpu.vcores -1
hive.tez.java.opts -XX:ParallelGCThreads=2 -XX:CICompilerCount=2

hive.txn.manager org.apache.hadoop.hive.ql.lockmgr.DummyTxnManager

hive.vectorized.adaptor.usage.mode chosen
hive.vectorized.execution.enabled true
hive.vectorized.execution.reduce.enabled true

hive.warehouse.subdir.inherit.perms false
```

```hivemetastore-site
hive.metastore.pre.event.listeners com.aliyun.emr.meta.hive.listener.MetaStorePreAuditListener
allow.console.modify.meta.db true
hive.metastore.event.listeners com.aliyun.emr.meta.hive.listener.MetaStoreListener
javax.jdo.option.ConnectionUserName root
hive.service.metrics.file.frequency 30s
javax.jdo.option.ConnectionDriverName com.mysql.jdbc.Driver
javax.jdo.option.ConnectionPassword •••••••••••
hive.metastore.server.max.threads 1000
javax.jdo.option.ConnectionURL jdbc:mysql://emr-header-1/hivemeta?createDatabaseIfNotExist=true&characterEncoding=UTF-8
hive.metastore.metrics.enabled true
hive.service.metrics.file.location /tmp/hivemetastore_metric.json
hive.metastore.server.min.threads 200

```

```hiveserver2-site
fs.jfs.cache.hive-fast-move false
hive.service.metrics.file.frequency 30000
hive.server2.metrics.enabled true
hive.server2.session.check.interval 1h
hive.server2.idle.operation.timeout 6h
hive.security.authorization.sqlstd.confwhitelist.append tez.*|spark.*|mapred.*|mapreduce.*|ALISA.*|SKYNET.*|QUERY_TIMEOUT_S
hive.server2.logging.operation.enabled true
hive.server2.idle.session.timeout 6h
hive.service.metrics.file.location /tmp/hiveserver2_metric.json
hive.server2.enable.impersonation true

```

```hplsql-site
hplsql.conn.tdconn com.teradata.jdbc.TeraDriver;jdbc:teradata://localhost/database=dbname,logmech=ldap;user;password
hplsql.temp.tables native
hplsql.onerror exception
hplsql.conn.init.hive2conn set mapred.job.queue.name=default;     set hive.execution.engine=mr;     use default;
hplsql.conn.hive2conn org.apache.hive.jdbc.HiveDriver;jdbc:hive2://emr-header-1:10000;hive;hive
hplsql.conn.default hive2conn
hplsql.temp.tables.location /tmp/plhql
hplsql.conn.mysqlconn com.mysql.jdbc.Driver;jdbc:mysql://emr-header-1/test;root;root
hplsql.conn.init.hiveconn set mapred.job.queue.name=default;     set hive.execution.engine=mr;     use default;
hplsql.conn.db2conn com.ibm.db2.jcc.DB2Driver;jdbc:db2://localhost:50001/dbname;user;password
hplsql.temp.tables.schema
hplsql.conn.convert.hiveconn true
hplsql.insert.values native
hplsql.conn.convert.hive2conn true
hplsql.dual.table default.dual
hplsql.conn.hive1conn org.apache.hadoop.hive.jdbc.HiveDriver;jdbc:hive://
hplsql.conn.hiveconn org.apache.hive.jdbc.HiveDriver;jdbc:hive2://
```

##### ZOOKEEPER

```zookeeper-env
zookeeper_heap_size 1024

```

```zoo.cfg
admin_serverAddress DEFAULT
maxSessionTimeout 360000
syncLimit 30
zookeeper_hosts emr-header-1,emr-worker-1,emr-worker-2
clientPortAddress 0.0.0.0
admin_enableServer true
server.2 emr-worker-1:2888:3888
server.1 emr-header-1:2888:3888
admin_serverPort 28080
initLimit 10
tickTime 2000
clientPort 2181
autopurge_snapRetainCount 3
server.3 emr-worker-2:2888:3888
autopurge_purgeInterval 1
zk_data_dirs /mnt/disk1/zookeeper
maxClientCnxns 60

```

##### HBASE

```hbase-env.sh
hbase_thrift_opts $HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=10103
hbase_regionserver_opts -Xms1536m -Xmx1536m -Xmn256m -verbose:gc -XX:+PrintGCDetails -XX:SurvivorRatio=2 -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=85 -Xloggc:$HBASE_LOG_DIR/gc-regionserver.log -XX:PermSize=64m $HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=10102
hbase_master_opts -Xms128m -Xmx128m -Xmn64m -verbose:gc -XX:+PrintGCDetails -XX:SurvivorRatio=2 -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=85 -Xloggc:$HBASE_LOG_DIR/gc-hmaster.log -XX:PermSize=64m $HBASE_JMX_BASE -Dcom.sun.management.jmxremote.port=10101
hbase_opts
hbase_jmx_base -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false
hbase_security_opts 
```

```hbase-site.xml
hbase.balancer.period 300000
hbase.bulkload.staging.dir ${hbase.fs.tmp.dir}
hbase.cells.scanned.per.heartbeat.check 10000
hbase.cluster.distributed true
hbase.column.max.version 1
hbase.config.read.zookeeper.config false
hbase.coordinated.state.manager.class org.apache.hadoop.hbase.coordination.ZkCoordinatedStateManager

hbase.coprocessor.abortonerror true
hbase.coprocessor.enabled true
hbase.coprocessor.master.classes
hbase.coprocessor.region.classes
hbase.coprocessor.user.enabled true

hbase.data.umask 000
hbase.data.umask.enable false

hbase.dfs.client.read.shortcircuit.buffer.size 131072
hbase.dynamic.jars.dir ${hbase.rootdir}/lib
hbase.fs.tmp.dir /user/${user.name}/hbase-staging

hbase.hregion.majorcompaction 864000000
hbase.hregion.majorcompaction.jitter 0.50
hbase.hregion.max.filesize 8589934592
hbase.hregion.memstore.block.multiplier 24
hbase.hregion.memstore.chunkpool.initialsize 1
hbase.hregion.memstore.chunkpool.maxsize 0.1
hbase.hregion.memstore.flush.size 134217728
hbase.hregion.memstore.mslab.enabled true
hbase.hregion.percolumnfamilyflush.size.lower.bound 16777216
hbase.hregion.preclose.flush.size 5242880

hbase.hstore.blockingStoreFiles 50
hbase.hstore.blockingWaitTime 3000
hbase.hstore.bytes.per.checksum 16384
hbase.hstore.checksum.algorithm CRC32
hbase.hstore.compaction.kv.max 10
hbase.hstore.compaction.max 10
hbase.hstore.compaction.max.size 2147483648
hbase.hstore.compaction.min 3
hbase.hstore.compaction.min.size 33554432
hbase.hstore.compactionThreshold 3
hbase.hstore.flusher.count 2
hbase.hstore.time.to.purge.deletes 0
hbase.hstore.useExploringCompation true

hbase.ipc.server.callqueue.handler.factor 0.1
hbase.ipc.server.callqueue.read.ratio 0
hbase.ipc.server.callqueue.scan.ratio 0

hbase.lease.recovery.dfs.timeout 64000
hbase.lease.recovery.timeout 900000

hbase.local.dir ${hbase.tmp.dir}/local/

hbase.master.catalog.timeout 600000
hbase.master.distributed.log.replay false
hbase.master.hfilecleaner.plugins org.apache.hadoop.hbase.master.cleaner.TimeToLiveHFileCleaner
hbase.master.info.bindAddress 0.0.0.0
hbase.master.info.port 16010
hbase.master.infoserver.redirect true
hbase.master.loadbalancer.class org.apache.hadoop.hbase.master.balancer.StochasticLoadBalancer
hbase.master.logcleaner.plugins org.apache.hadoop.hbase.master.cleaner.TimeToLiveLogCleaner
hbase.master.logcleaner.ttl 600000
hbase.master.port 16000

hbase.metrics.exposeOperationTimes true
hbase.metrics.showTableName true

hbase.online.schema.update.enable true

hbase.procedure.master.classes null
hbase.procedure.regionserver.classes

hbase.regions.slop 0.2

hbase.regionserver.catalog.timeout 600000
hbase.regionserver.checksum.verify true
hbase.regionserver.dns.interface default
hbase.regionserver.dns.nameserver default
hbase.regionserver.global.memstore.lowerLimit 0.3
hbase.regionserver.global.memstore.size 0.35
hbase.regionserver.handler.abort.on.error.percent 0.5
hbase.regionserver.handler.count 100
hbase.regionserver.hlog.blocksize 268435456
hbase.regionserver.hlog.reader.impl org.apache.hadoop.hbase.regionserver.wal.ProtobufLogReader
hbase.regionserver.hlog.splitlog.writer.threads 3
hbase.regionserver.hlog.writer.impl org.apache.hadoop.hbase.regionserver.wal.ProtobufLogWriter
hbase.regionserver.info.bindAddress 0.0.0.0
hbase.regionserver.info.port 16030
hbase.regionserver.info.port.auto false
hbase.regionserver.logroll.errors.tolerated 2
hbase.regionserver.logroll.period 3600000
hbase.regionserver.maxlogs 32
hbase.regionserver.msginterval 3000
hbase.regionserver.optionalcacheflushinterval 3600000
hbase.regionserver.port 16020
hbase.regionserver.region.split.policy org.apache.hadoop.hbase.regionserver.IncreasingToUpperBoundRegionSplitPolicy
hbase.regionserver.regionSplitLimit 1000
hbase.regionserver.storefile.refresh.period 0
hbase.regionserver.thread.compaction.large 1
hbase.regionserver.thread.compaction.small 1
hbase.regionserver.thread.compaction.throttle 268435456
hbase.regionserver.thrift.compact false
hbase.regionserver.thrift.framed false
hbase.regionserver.thrift.framed.max_frame_size_in_mb 2

hbase.replication false

hbase.rest.filter.classes org.apache.hadoop.hbase.rest.filter.GzipFilter
hbase.rest.port 8080
hbase.rest.readonly false
hbase.rest.support.proxyuser false
hbase.rest.threads.max 100
hbase.rest.threads.min 2

hbase.rootdir hdfs://emr-header-1.cluster-245192:9000/hbase
hbase.rootdir.perms 700

hbase.rpc.shortoperation.timeout 10000
hbase.rpc.timeout 60000

hbase.rs.cacheblocksonwrite false

hbase.server.compactchecker.interval.multiplier 1000
hbase.server.hostname.useip true
hbase.server.scanner.max.result.size 104857600
hbase.server.thread.wakefrequency 10000
hbase.server.versionfile.writeattempts 3

hbase.snapshot.enabled true
hbase.snapshot.restore.failsafe.name hbase-failsafe-{snapshot.name}-{restore.timestamp}
hbase.snapshot.restore.take.failsafe.snapshot true

hbase.status.listener.class org.apache.hadoop.hbase.client.ClusterStatusListener$MulticastListener
hbase.status.multicast.address.ip 226.1.1.3
hbase.status.multicast.address.port 16100
hbase.status.published false
hbase.status.publisher.class org.apache.hadoop.hbase.master.ClusterStatusPublisher$MulticastPublisher

hbase.storescanner.parallel.seek.enable false
hbase.storescanner.parallel.seek.threads 10

hbase.table.lock.enable true
hbase.table.max.rowsize 1073741824

hbase.thrift.htablepool.size.max 1000
hbase.thrift.maxQueuedRequests 1000
hbase.thrift.maxWorkerThreads 1000
hbase.thrift.minWorkerThreads 16

hbase.tmp.dir ${java.io.tmpdir}/hbase-${user.name}

hbase.zookeeper.dns.interface default
hbase.zookeeper.dns.nameserver default
hbase.zookeeper.leaderport 3888
hbase.zookeeper.peerport 2888
hbase.zookeeper.property.clientPort 2181
hbase.zookeeper.property.dataDir /mnt/disk1/hbase/zk-data/zookeeper
hbase.zookeeper.property.initLimit 10
hbase.zookeeper.property.maxClientCnxns 300
hbase.zookeeper.property.syncLimit 5
hbase.zookeeper.quorum emr-worker-2.cluster-245192,emr-header-1.cluster-245192,emr-worker-1.cluster-245192
hbase.zookeeper.useMulti true

hfile.block.bloom.cacheonwrite false
hfile.block.cache.size 0.4
hfile.block.index.cacheonwrite false
hfile.index.block.max.size 131072

io.storefile.bloom.block.size 131072
master_hostname emr-header-1

replication.sleep.before.failover 5000
replication.source.nb.capacity 2000
replication.source.ratio 1
replication.source.size.capacity 2097152

zookeeper.session.timeout 180000
zookeeper.znode.acl.parent acl
zookeeper.znode.parent /hbase
zookeeper.znode.rootserver root-region-server
```

#### Hive
##### 管理元数据

``` hivemetastore-site.xml
javax.jdo.option.ConnectionURL // 对应数据库地址
javax.jdo.option.ConnectionUserName // 对应数据库用户名
javax.jdo.option.ConnectionPassword //对应数据库密码
```

```shell
# mysqldump -t DATABASENAME -h HOST -P PORT -u USERNAME -p PASSWORD > /tmp/metastore.sql
mysqldump -t hivemeta -h localhost -P 3306 -u root -pEMRroot1234 > /tmp/metastore.sql
```

##### 统一元数据
EMR-2.4.0之前版本，所有集群采用的是集群本地的MySQL数据库作为Hive元数据库；EMR-2.4.0及后续版本，E-MapReduce支持统一的高可靠的Hive元数据库。

E-MapReduce后台RDS统一管理元数据的方式，仅限小容量的用户使用。对于大容量场景，建议您自建RDS作为统一元数据。默认限制为：

- 总容量：200MiB。
- 小时query数量限制：720000/h。
- 小时update数量限制：144000/h。

统一的元数据管理，可以实现：

- 持久化的元数据存储。

	支持统一元数据之前，元数据都是在集群内部的MySQL数据库，元数据会随着集群的释放而丢失，特别是EMR提供了灵活按量模式，集群可以按需创建用完就释放。如果您需要保留现有的元数据信息，必须登录集群手动将元数据信息导出。

	支持统一元数据之后，释放集群不会清理元数据信息。所以，在任何时候删除OSS上或者集群HDFS上数据（包括释放集群操作）的时候，需要先确认该数据对应的元数据已经删除（即要删掉数据对应的表和数据库），否则元数据库中可能出现一些脏数据。

- 计算存储分离。

	EMR上可以支持将数据存放在阿里云OSS中，在大数据量的情况下将数据存储在OSS上会大大降低使用的成本，EMR集群主要用来作为计算资源，在计算完成之后可以随时释放，数据在OSS上，同时也不用再考虑元数据迁移的问题。

- 数据共享。

	使用统一的元数据库，如果您的所有数据都存放在OSS之上，则不需要做任何元数据的迁移和重建，所有集群都是可以直接访问数据，这样每个EMR集群可以做不同的业务，但是可以很方便地实现数据的共享。


##### 切换元数据存储类型

通过修改Hive参数的方式，切换Hive MetaStore的存储方式。

切换为MySQL（包括集群内置MySQL、统一meta数据库和独立RDS MySQL）：
设置hive.imetastoreclient.factory.class为org.apache.hadoop.hive.ql.metadata.SessionHiveMetaStoreClientFactory。

切换为数据湖元数据：
设置hive.imetastoreclient.factory.class为com.aliyun.datalake.metastore.hive2.DlfMetaStoreClientFactory。

##### 配置独立RDS

建议选择MySQL的5.7版本；系列选择高可用版。

RDS MySQL实例须与E-MapReduce的实例处于同一个安全组，以便RDS与E-MapReduce可以通过内网地址互通。

1. 在RDS中创建一个database，名称为hivemeta，同时创建一个用户，把hivemeta的读写权限赋给这个用户。
2. 导出统一元数据库的内容（只导出数据，不用导表结构）。为保证数据的一致性，在Hive服务页面停止Hive的MetaStore服务。
3. 集群Master节点上的/usr/local/emr/emr-agent/run/meta_db_info.json，把里面的use_local_meta_db设置为false，meta数据库的链接地址、用户名和密码换成RDS的信息。
	+ 对于无此文件的集群，直接忽略此步骤。
	+ 如果是HA集群，两个Master节点都需要进行操作。

4. 在Hive配置页面，把元数据库的链接地址、用户名和密码换成新RDS的信息。如果是老版本集群，修改$HIVE_CONF_DIR/hive-site.xml中对应的配置为需要连接的数据库。
5. 在一台Master节点上根据您集群的Hive版本初始化Schema。
```shell
# 如果Hive是2.3.x版本时，请执行以下命令进行初始化。
# 执行以下命令，进入mysql目录。
cd /usr/lib/hive-current/scripts/metastore/upgrade/mysql/
# 执行以下命令，登录MySQL数据库。
mysql -h {RDS数据库内网或外网地址} -u{RDS用户名} -p{RDS密码}
# 执行以下命令，进行初始化。
use {RDS数据库名称};
source /usr/lib/hive-current/scripts/metastore/upgrade/mysql/hive-schema-2.3.0.mysql.sql;
# 说明 {RDS数据库名称}为步骤1中创建的数据库，例如hivemeta。


# 其它Hive版本时，执行以下命令进行初始化。
# 执行以下命令，进入bin目录。
cd /usr/lib/hive-current/bin
# 执行以下命令，登录MySQL数据库。
./schematool -initSchema -dbType mysql
# 也可以通过以下命令行登录MySQL。
mysql -h {rds的url} -u {rds的用户名} -p
# 登录后，把之前导出来的Meta数据导入RDS
source /tmp/metastore.sql
```

#### FAQ

已增加了内存或CPU，为什么YARN上的内存或CPU没有增加？

> 因为YARN上的资源是由每个NodeManager的资源相加得到的总值，每个NodeManager的值是固定的，所以您可以通过修改配置并重启NodeManager，来影响YARN的总体资源，修改组件参数详情请参见管理组件参数。
> 
> 修改配置如下：
> 内存：yarn.nodemanager.resource.memory-mb
> CPU：yarn.nodemanager.resource.cpu-vcores

YARN上还有剩余资源，为什么任务一直显示accepted？

> 任务在YARN上运行时会先启动一个ApplicationMaster，由这个Master来申请运行数据的资源，但是有一个参数会限制Master占用YARN资源的百分比，默认是0.25（25%）。如果您的作业都是消耗资源比较小的任务，建议可以修改yarn.scheduler.capacity.maximum-am-resource-percent的值，调整到0.5\~0.8之间，修改参数后无需重启服务，您可以直接在节点上执行yarn rmadmin -refreshQueues命令。


Worker节点和Header/Gateway节点提交作业的区别是什么？

> 在数据开发的作业编辑页面，单击右上角的作业设置，在作业设置页面的高级设置页签，您可以在模式区域，选择在Worker节点提交或者在Header/Gateway节点提交。
>
> 在Worker节点提交：不可以指定机器提交，会先启动一个名为Launcher的任务，再来启动和监控您实际的任务，即需要用到两个ApplicationMaster的资源，通常这两个任务的ApplicationId是连续的。
> 
> 在Header/Gateway节点提交：可以指定机器提交，仅启动实际的任务，但是如果任务太多，会对Header/Gateway节点造成一定的压力，如果机器内存不足，任务无法启动。

如果Hive元数据信息中包含中文信息，例如列注释和分区名等，该如何处理？

```shell
# 您可以在对应RDS数据库中逐条依次执行如下命令修改相应字段为UTF-8格式。
# 执行以下命令，修改COMMENT列的数据类型。
alter table COLUMNS_V2 modify column COMMENT varchar(256) character set utf8;
# 执行以下命令，修改表TABLE_PARAMS中PARAM_VALUE列的数据类型。
alter table TABLE_PARAMS modify column PARAM_VALUE varchar(4000) character set utf8;
# 执行以下命令，修改表PARTITION_PARAMS中PARAM_VALUE列的数据类型。
alter table PARTITION_PARAMS modify column PARAM_VALUE varchar(4000) character set utf8;
# 执行以下命令，修改PKEY_COMMENT列的数据类型。
alter table PARTITION_KEYS modify column PKEY_COMMENT varchar(4000) character set utf8;
# 执行以下命令，修改表INDEX_PARAMS中PARAM_VALUE列的数据类型。
alter table INDEX_PARAMS modify column PARAM_VALUE varchar(4000) character set utf8;
```



