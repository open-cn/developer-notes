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


#### Hive
##### 管理元数据

javax.jdo.option.ConnectionURL

javax.jdo.option.ConnectionUserName

javax.jdo.option.ConnectionPassword

```shell
mysqldump -t DATABASENAME -h HOST -P PORT -u USERNAME -p PASSWORD > /tmp/metastore.sql
```

集群Master节点上的/usr/local/emr/emr-agent/run/meta_db_info.json，把里面的use_local_meta_db设置为false，meta数据库的链接地址、用户名和密码换成RDS的信息。

##### 切换元数据存储类型

通过修改Hive参数的方式，切换Hive MetaStore的存储方式。

切换为MySQL（包括集群内置MySQL、统一meta数据库和独立RDS MySQL）：
设置hive.imetastoreclient.factory.class为org.apache.hadoop.hive.ql.metadata.SessionHiveMetaStoreClientFactory。

切换为数据湖元数据：
设置hive.imetastoreclient.factory.class为com.aliyun.datalake.metastore.hive2.DlfMetaStoreClientFactory。

##### 配置独立RDS

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



