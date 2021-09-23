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






