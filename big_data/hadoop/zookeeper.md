## zookeeper

Apache ZooKeeper是Apache软件基金会的一个软件项目，他为大型分布式计算提供开源的分布式配置服务、同步服务和命名注册。

ZooKeeper曾经是Hadoop的一个子项目，但现在是一个独立的顶级项目。


Zookeeper是针对大型分布式系统的高可靠的协调系统。

Zookeeper是Hadoop的分布式协调服务。

### 为什么需要Zookeeper

开发分布式系统是件很困难的事情，其中的困难主要体现在分布式系统的“部分失败”。

“部分失败”是指信息在网络的两个节点之间传送时候，如果网络出了故障，发送者无法知道接收者是否收到了这个信息，而且这种故障的原因很复杂，接收者可能在出现网络错误之前已经收到了信息，也可能没有收到，又或接收者的进程死掉了。

发送者能够获得真实情况的唯一办法就是重新连接到接收者，询问接收者错误的原因，这就是分布式系统开发里的“部分失败”问题。

Zookeeper就是解决分布式系统“部分失败”的框架。

Zookeeper不是让分布式系统避免“部分失败”问题，而是让分布式系统当碰到部分失败时候，可以正确的处理此类的问题，让分布式系统能正常的运行。


### Zookeeper典型应用场景

主要用来控制集群中的数据，如它管理 Hadoop 集群中的 NameNode，还有 Hbase 中 Master Election、Server 之间状态同步等。

Zoopkeeper 提供了一套很好的分布式集群管理的机制，就是它这种基于层次型的目录树的数据结构，并对树中的节点进行有效管理，从而可以设计出多种多样的分布式的数据管理模型，而不仅仅局限于下面提到的几个常用应用场景。

1. 统一命名服务

    分布式环境下，经常需要对应用/服务进行统一命名，便于识别不同服务。类似于域名与ip 之间对应关系，域名容易记住。

    通过名称来获取资源或服务的地址，提供者等信息按照层次结构组织服务/应用名称可将服务名称以及地址信息写到Zookeeper上，客户端通过Zookeeper获取可用服务列表类。

2. 配置管理

    分布式环境下，配置文件管理和同步是一个常见问题。

    通常情况下一个集群中，所有节点的配置信息是一致的:

    比如Hadoop, 对配置文件修改后，希望能够快速同步到各个节点上配置管理可交由Zookeeper实现。(以前都是我们手动管理, 效率比较低下)

    可将配置信息写入Zookeeper的一个znode上。各个节点监听这个znode。一旦znode中的数据被修改，zookeeper将通知各个节点。

3. 集群管理和Master选举

    Zookeeper 能够很容易的实现集群管理的功能

    如有多台 Server 组成一个服务集群，那么必须要一个“总管”知道当前集群中每台机器的服务状态，一旦有机器不能提供服务，集群中其它集群必须知道，从而做出调整重新分配服务策略。

    同样当增加集群的服务能力时，就会增加一台或多台 Server，同样也必须让“总管”知道。

4. 分布式通知/协调

    ZooKeeper中特有watcher注册与异步通知机制，能够很好的实现分布式环境下不同系统之间的通知与协调，实现对数据变更的实时处理。

    使用方法通常是不同系统都对ZK上同一个znode进行注册，监听znode的变化（包括znode本身内容及子节点的），其中一个系统update了znode，那么另一个系统能够收到通知，并作出相应处理

5. 分布式锁

    分布式锁，这个主要得益于ZooKeeper为我们保证了数据的强一致性.

    如果不同的系统或是同一个系统的不同主机之间共享一个或一组资源，那么访问这些资源的时候，往往需要通过一些互斥手段来防止彼此之间的干扰，以保证一致性，在这种情况下，需要使用分布式锁。

6. 分布式队列

    队列方面，简单地讲有两种，

    一种是常规的先进先出队列，另一种是要等到队列成员聚齐之后的才统一按序执行。

7. 负载均衡

    在分布式系统中，负载均衡是一种普遍的技术。

    ZooKeeper作为一个集群，负责数据的存储以及一系列分布式协调。所有的请求，会通过ZooKeeper通过一些调度策略去协调调度哪一台服务器。

### Zookeeper 的存储结构

1 Znode

在 Zookeeper 中，znode 是一个跟 Unix 文件系统路径相似的节点，可以往这个节点存储 或获取数据。 Zookeeper 底层是一套数据结构。这个存储结构是一个树形结构，其上的每一个节点， 我们称之为“znode” zookeeper 中的数据是按照“树”结构进行存储的。而且 znode 节点还分为 4 中不同的类 型。 每一个 znode 默认能够存储 1MB 的数据（对于记录状态性质的数据来说，够了） 可以使用 zkCli 命令，登录到 zookeeper 上，并通过 ls、create、delete、get、set 等命令 操作这些 znode 节点

2 Znode 节点类型

(1)PERSISTENT 持久化节点: 所谓持久节点，是指在节点创建后，就一直存在，直到 有删除操作来主动清除这个节点。否则不会因为创建该节点的客户端会话失效而消失。

(2)PERSISTENT_SEQUENTIAL 持久顺序节点：这类节点的基本特性和上面的节点类 型是一致的。额外的特性是，在 ZK 中，每个父节点会为他的第一级子节点维护一份时序， 会记录每个子节点创建的先后顺序。基于这个特性，在创建子节点的时候，可以设置这个属 性，那么在创建节点过程中，ZK 会自动为给定节点名加上一个数字后缀，作为新的节点名。 这个数字后缀的范围是整型的最大值。 在创建节点的时候只需要传入节点 “/test_”，这样 之后，zookeeper 自动会给”test_”后面补充数字。

(3)EPHEMERAL 临时节点：和持久节点不同的是，临时节点的生命周期和客户端会 话绑定。也就是说，如果客户端会话失效，那么这个节点就会自动被清除掉。注意，这里提 到的是会话失效，而非连接断开。另外，在临时节点下面不能创建子节点。 这里还要注意一件事，就是当你客户端会话失效后，所产生的节点也不是一下子就消失 了，也要过一段时间，大概是 10 秒以内，可以试一下，本机操作生成节点，在服务器端用 命令来查看当前的节点数目，你会发现客户端已经 stop，但是产生的节点还在。

(4) EPHEMERAL_SEQUENTIAL 临时自动编号节点：此节点是属于临时节点，不过带 有顺序，客户端会话结束节点就消失。

```shell
zkServer.sh status
zkServer.sh start
zkServer.sh stop

zkCli.sh -server emr-header-1.cluster-245192:2181
zkCli.sh -server emr-worker-1.cluster-245192:2181
zkCli.sh -server emr-worker-2.cluster-245192:2181

ZooKeeper -server host:port -client-configuration properties-file cmd args
        addWatch [-m mode] path # optional mode is one of [PERSISTENT, PERSISTENT_RECURSIVE] - default is PERSISTENT_RECURSIVE
        addauth scheme auth
        close
        config [-c] [-w] [-s]
        connect host:port
        create [-s] [-e] [-c] [-t ttl] path [data] [acl]
        delete [-v version] path
        deleteall path [-b batch size]
        delquota [-n|-b|-N|-B] path
        get [-s] [-w] path
        getAcl [-s] path
        getAllChildrenNumber path
        getEphemerals path
        history
        listquota path
        ls [-s] [-w] [-R] path
        printwatches on|off
        quit
        reconfig [-s] [-v version] [[-file path] | [-members serverID=host:port1:port2;port3[,...]*]] | [-add serverId=host:port1:port2;port3[,...]]* [-remove serverId[,...]*]
        redo cmdno
        removewatches path [-c|-d|-a] [-l]
        set [-s] [-v version] path data
        setAcl [-s] [-v version] [-R] path acl
        setquota -n|-b|-N|-B val path
        stat [-w] path
        sync path
        version
        whoami

connect host:port # 连接其他的 ZooKeeper 应用。

ls path # 列表路径下的资源。在 ZooKeeper 控制台客户端中，没有默认列表功能，必须 指定要列表资源的位置。 如： ls / ； ls /path 等。

create [-e] [-s] path data # 创建节点，如：

create /test 123 # 创建一个/test 节点，节点携 带数据信息 123。
create -e /test 123 # 创建一个临时节点/test，携带数据为 123，临时节点只 在当前会话生命周期中有效，会话结束节点自动删除。
create -s /test 123 # 创建一个顺序节点 /test，携带数据123，创建的顺序节点由ZooKeeper自动为节点增加后缀信息，如-/test00000001 等。-e 和-s 参数可以联合使用。

get path # 查看指定节点的数据。 如： get /test。结果如下：

get /test
# 123
# cZxid = 0xd # 创建节点时的事务 ID，由 ZooKeeper 维护。
# ctime = Tue Jun 12 07:45:53 PDT 2018 
# mZxid = 0x1f # 当前节点携带数据最后一次修改的事务 ID。
# mtime = Tue Jun 12 07:52:53 PDT 2018 
# pZxid = 0x21 # 子节点列表最后一次修改的事务 ID。
# cversion = 1 # 节点版本号，当节点的子节点列表发生变化时，版本变更。
# dataVersion = 2 # 数据版本号，当节点携带数据发生变化时，版本变更。 
# aclVersion = 0 ephemeralOwner = 0x0
# 此数据值不是 0x0 时，代表是临时节点 dataLength = 3 
# 节点携带数据长度 numChildren = 1 
# 子节点数量 


set path data [version] # 设置对应位置节点的数据。如： set /test 'test data'。 如果要设 置的数据中有空格，则使用单引号界定数据的范围。每次修改数据后，dataVersion 属性自增。 那么在 set 命令中可以指定 version，version 数据必须与上次查询的值一致，用于保证本次修 改命令执行时，没有其他会话修改此数据。

delete path [version] # 删除指定节点，此命令不能删除有子节点的节点。如：delete /test。 其中 version 参数和 set 命令的 version 含义一致 rmr path - 删除指定结点，包括子节点。

stat /
# cZxid = 0x0
# ctime = Thu Jan 01 08:00:00 CST 1970
# mZxid = 0x0
# mtime = Thu Jan 01 08:00:00 CST 1970
# pZxid = 0xa000d3d06
# cversion = 908056
# dataVersion = 0
# aclVersion = 1
# ephemeralOwner = 0x0
# dataLength = 0
# numChildren = 4

quit # 退出控制台

```

### 最佳实践

#### FAQ

1. Unexpected exception
EndOfStreamException: Unable to read additional data from client, it probably closed the socket: address = 

EndOfStreamException: Unable to read additional data from client sessionid 0x6362257b44e5068d, likely client has closed socket

客户端连接Zookeeper时，配置的超时时长过短。致使Zookeeper还没有读完Consumer的数据，连接就被Consumer断开了。

初始化Zookeeper连接时，将接收超时参数值调整大一些即可（tickTime2000改为10000），默认是毫秒（ms）



