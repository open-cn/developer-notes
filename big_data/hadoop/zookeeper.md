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

leader节点可以处理事务请求和非事务请求，follower节点只能处理非事务请求，如果follower节点接收到事务请求，会把请求转发给Leader服务器。

#### 分布式一致性算法

帕克索斯（paxos）算法是最重要的分布式一致性算法，很多人都把它称作”分布式一致性协议“的代名词。分布式一致性算法是分布式计算领域的基础性问题，其最基本的功能是为了多个进程之间对某个某些值达成强一致性；进而解决分布式系统的高可用的问题 。

#### CAP理论

在一个分布式系统中，最多只能满足C、A、P中的两个需求：

- C–Consistency: 一致性，同一数据的多个副本是否实时相同
- A–Availability: 可用性，一定时间内，系统返回一个明确的结果，则称为该系统可用
- P–Partition tolerance: 分区容错性，将同一服务分布在多个系统中，从而保证某一个系统宕机，仍然有其他系统提供相同的服务。

BASE理论，BASE是三个单词的缩写：

- Basically Available(基本可用）
- Soft state(软状态）
- Eventually consistent(最终一致性）


一个电商系统往往被拆分成如下几个子系统：商品系统、订单系统、支付系统、积分系统等。整个下单的过程如下：

1) 用户通过商品系统浏览商品，他看中了某一项商品，便点击下单
2) 此时订单系统会生成一条订单
3) 订单创建成功后，支付系统提供支付功能
4) 当支付完成后，由积分系统为该用户增加积分

上述2、3、4需要在一个事务中完成。需要实现分布式事务的支持：
1. CP方式：现在如果要满足事务的强一致性，就必须在订单服务数据库锁定的同时，对库存服务、用户服务数据资源同时锁定。等待三个服务业务全部处理完成，才可以释放资源。此时如果有其他请求想要操作被锁定的资源就会被阻塞，这样就是满足了CP。（这就是强一致性，弱可用）
2. AP方式：三个服务的对应数据库各自独立执行自己的业务，执行本地事务，不要求相互锁定资源。但是这个中间状态下，我们去访问数据库，可能遇到数据不一致的情况，不过我们需要做一些后补措施，保证在经过一段时间后，数据最终满足一致性（这就是高可用，但弱一致: 最终一致性）。

这两种思想，延伸出了很多的分布式事务解决方案：

- XA
- TCC
- 可靠消息最终一致性
- AT

#### ZAB协议

ZAB，Zookeeper Atomic Broadcast 协议是为分布式协调服务ZK专门设计的一种支持崩溃恢复的原子广播协议。在ZK中，主要依赖ZAB协议来实现分布式数据一致性，基于该协议，Zk实现了一种主备模式的系统架构来保持集群中各个副本之间的数据一致性。

ZAB协议包含两种基本模式，分别是：

1. 崩溃恢复
2. 原子广播

当整个集群在启动时，或者当leader节点出现网络中断，崩溃等情况时，ZAB协议就会进入恢复模式并选举产生新的leader，当leader服务器选举出来后，并且集群中有过半的机器和该leader节点完成数据同步后（同步指的是数据同步，用来保证集群中过半的机器能够和leader服务器的数据状态保持一致），ZAB协议就会退出恢复模式。当集群中已经有过半的Follower节点完成了和Leader状态同步以后，那么整个集群就进入了消息广播模式。这个时候，在Leader节点正常工作时，启动一台新的服务器加入到集群，那么这个服务器直接进入数据恢复模式，和leader节点直接进行数据同步，同步完成后，即可正常对外提供非事务请求的处理。

消息广播的过程实际上是一个简化版本的二阶段提交：
1. leader接收到消息请求后，将消息赋予一个全局唯一的64位自增id，叫zxid，通过zxid的大小比较既可以实现因果有序这个特征。
2. leader为每个follower准备了一个FIFO队列，（通过TCP协议来实现，以实现全局有序这个特点）将带有zxid的消息作为一个提案（proposal）分发给所有的follower。
3. 当follower接收到proposal，先把proposal写到磁盘，写入成功以后再向leader返回一个ack。
4. 当leader接收到合法数量（超过半数节点）的ACK后，leader就会像这些follower发送commit命令。同时在本地会执行该消息。
5. 当follower收到消息的commit后，会提交该消息。

leader的投票过程，不需要Observer的ack，也就是Observer不需要参与投票过程，但是observer必须要同步leader的数据，从而在处理请求的时候保证数据的一致性。


ZAB协议的这个基于原子广播协议的消息广播过程，在正常情况下是没有任何问题的，但是一旦Leader节点崩溃，或者由于网络问题导致Leader服务器失去了过半的follower节点，那么就会进入到崩溃恢复状态。在崩溃恢复状态下，zab协议需要做两件事：
1. 选举出新的leader
2. 数据同步

前面说消息广播时，知道zab协议的消息广播机制时简化版的2PC协议，这种协议只需要集群中过半的节点相应提交即可。但是他无法处理leader服务器崩溃带来的数据不一致问题。

如果一个事务Proposal在一台服务器上被处理成功，那么这个事务应该在所有机器上都处理成功，哪怕出现故障。

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

1. Znode
在 Zookeeper 中，znode 是一个跟 Unix 文件系统路径相似的节点，可以往这个节点存储或获取数据。Zookeeper 底层是一套数据结构。这个存储结构是一个树形结构，其上的每一个节点，我们称之为“znode”。zookeeper 中的数据是按照“树”结构进行存储的。而且 znode 节点还分为 4 中不同的类型。每一个 znode 默认能够存储 1MB 的数据（对于记录状态性质的数据来说，够了）可以使用 zkCli 命令，登录到 zookeeper 上，并通过 ls、create、delete、get、set 等命令操作这些 znode 节点。

2. Znode 节点类型
1) PERSISTENT 持久化节点: 所谓持久节点，是指在节点创建后，就一直存在，直到 有删除操作来主动清除这个节点。否则不会因为创建该节点的客户端会话失效而消失。
2) PERSISTENT_SEQUENTIAL 持久顺序节点：这类节点的基本特性和上面的节点类 型是一致的。额外的特性是，在 ZK 中，每个父节点会为他的第一级子节点维护一份时序， 会记录每个子节点创建的先后顺序。基于这个特性，在创建子节点的时候，可以设置这个属 性，那么在创建节点过程中，ZK 会自动为给定节点名加上一个数字后缀，作为新的节点名。 这个数字后缀的范围是整型的最大值。 在创建节点的时候只需要传入节点 “/test_”，这样 之后，zookeeper 自动会给”test_”后面补充数字。
3) EPHEMERAL 临时节点：和持久节点不同的是，临时节点的生命周期和客户端会话绑定。也就是说，如果客户端会话失效，那么这个节点就会自动被清除掉。注意，这里提 到的是会话失效，而非连接断开。另外，在临时节点下面不能创建子节点。这里还要注意一件事，就是当你客户端会话失效后，所产生的节点也不是一下子就消失了，也要过一段时间，大概是 10 秒以内，可以试一下，本机操作生成节点，在服务器端用命令来查看当前的节点数目，你会发现客户端已经 stop，但是产生的节点还在。
4) EPHEMERAL_SEQUENTIAL 临时自动编号节点：此节点是属于临时节点，不过带 有顺序，客户端会话结束节点就消失。

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

#### 非公平锁

当有线程1、2、3并发请求时，让其都在zk上创建一个名为 /lock 的节点。那么同时肯定只能有一个线程创建成功，假设线程1创建成功，那么线程2、3在创建，只会提示该节点已经存在，这样模拟线程1加锁成功，让他执行业务。此时让线程2、3加锁失败，就监听 /lock 这个节点，模拟排队等待锁被释放。

当线程1执行完业务逻辑后，删除 /lock 节点，模拟释放锁。
当 /lock 被删除后，就会被线程2、3监听到，他们就可以重新尝试创建该节点。

#### 公平锁

非公平锁固然能解决问题，但是他有一个缺点就是，如果并发量大，那么同一时刻会有很多连接对同一节点进行监听，但检测到删除事件后，zk需要通知所有的连接，所有连接收到监听后，会同一时间在发生高并发竞争，给性能带来严重损耗。所以大多数场景下我们还是应该用公平锁去实现。

AQS设计公平锁的思路无非三步：

1. 尝试获取锁，如果拿到锁则处理业务逻辑。
2. 如果获取锁失败，则AQS提供了一个CLH队列，那么没有获得锁的线程就被安排到队列去排队等待。
3. 等锁被释放后，从队列中取出一个线程尝试获取锁。

这个过程中，因为队列是先进先出的，所以实现了公平的特性。

1. 有线程来，先入队（在容器节点下加一个临时顺序节点）。
2. 为了公平性，先让队列中第一个排队的去获取锁（获取容器节点中所有子节点进行排序，选出最小的）。
3. 拿到锁，处理业务逻辑，没有拿到锁，就监听自己的前一个节点，通过调用wait()方法让这些线程在等待池中等待。
4. 拿到锁的线程处理完业务逻辑后释放锁（删除自己创建的节点），然后通过notifyAll()方法唤醒所有在等待池中的线程，让他们尝试获取锁，走到第三步。

zk的curator-recipes已经帮我们实现好了这一套逻辑。

```xml
<!-- 引入依赖 -->
<dependency>
    <groupId>org.apache.zookeeper</groupId>
    <artifactId>zookeeper</artifactId>
    <version>3.5.8</version>
</dependency>

<!-- https://mvnrepository.com/artifact/org.apache.curator/curator-recipes -->
<dependency>
    <groupId>org.apache.curator</groupId>
    <artifactId>curator-recipes</artifactId>
    <version>5.0.0</version>
    <exclusions>
        <exclusion>
            <groupId>org.apache.zookeeper</groupId>
            <artifactId>zookeeper</artifactId>
        </exclusion>
    </exclusions>
</dependency>
```

#### FAQ

1. Unexpected exception
EndOfStreamException: Unable to read additional data from client, it probably closed the socket: address = 

EndOfStreamException: Unable to read additional data from client sessionid 0x6362257b44e5068d, likely client has closed socket

客户端连接Zookeeper时，配置的超时时长过短。致使Zookeeper还没有读完Consumer的数据，连接就被Consumer断开了。

初始化Zookeeper连接时，将接收超时参数值调整大一些即可（tickTime2000改为10000），默认是毫秒（ms）



