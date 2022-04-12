## kafka

Kafka 是为了解决 Linkedln 数据管道问题应运而生的。 它的设计目的是提供一个高性能的悄息系统，可以处理多种数据类型，并能够实时提供纯净且结构化的用户活动数据和系统度量指标。

Linkedln 的开发团队由 Jay Kreps 领导。 Jay Kreps 是 Linkedln 的首席工程师，之前负责分布式键值存储系统 Voldemort 的开发。

2010 年底，Kafka 作为开源项目在 GitHub 上发布。 2011 年 7 月，因为倍受开源社区的关注，它成为 Apache 软件基金会的孵化器项目。

现在，Kafka 被很多组织用在一些大型的数据管道上，Kafka 已经成为大数据管道的不二之选。

Kafka 是一个作家的名字，由于 Jay Kreps 比较喜欢这个作家，并且觉着这个名字比较酷，所以才命名为 kafka。因此，名字和应用本身基本没有太多联系。

官方下载地址: http://kafka.apache.org/downloads

0.7.x, 0.8.0, 0.8.1.X, 0.8.2.X, 0.9.0.X, 0.10.0.X, 0.10.1.X, 0.10.2.X, 0.11.0.X, 1.0.X, 1.1.X, 2.0.X, 2.1.X, 2.2.X, 2.3.X, 2.4.X, 2.5.X, 2.6.X, 2.7.X, 2.8.X 3.0.x.

### 消息队列

点对点模式（一对一，消费者主动拉取数据，消息收到后消息清除） 点对点模型通常是一个基于拉取或者轮询的消息传送模型，这种模型从队列中请求信息，而不是将消息推送到客户端。这个模型的特点是发送到队列的消息被一个且只有一个接收者接收处理，即使有多个消息监听者也是如此。

发布/订阅模式（一对多，数据生产后，推送给所有订阅者） 发布订阅模型则是一个基于推送的消息传送模型。发布订阅模型可以有多种不同的订阅者，临时订阅者只在主动监听主题时才接收消息，而持久订阅者则监听主题的所有消息，即使当前订阅者不可用，处于离线状态。

#### 为什么需要消息队列
1. 解耦：允许你独立的扩展或修改两边的处理过程，只要确保它们遵守同样的接口约束。
2. 冗余：消息队列把数据进行持久化直到它们已经被完全处理，通过这一方式规避了数据丢失风险。许多消息队列所采用的"插入-获取-删除"范式中，在把一个消息从队列中删除之前，需要你的处理系统明确的指出该消息已经被处理完毕，从而确保你的数据被安全的保存直到你使用完毕。
3. 扩展性：因为消息队列解耦了你的处理过程，所以增大消息入队和处理的频率是很容易的，只要另外增加处理过程即可。
4. 灵活性 & 峰值处理能力：在访问量剧增的情况下，应用仍然需要继续发挥作用，但是这样的突发流量并不常见。如果为以能处理这类峰值访问为标准来投入资源随时待命无疑是巨大的浪费。使用消息队列能够使关键组件顶住突发的访问压力，而不会因为突发的超负荷的请求而完全崩溃。
5. 可恢复性：系统的一部分组件失效时，不会影响到整个系统。消息队列降低了进程间的耦合度，所以即使一个处理消息的进程挂掉，加入队列中的消息仍然可以在系统恢复后被处理。
6. 顺序保证：在大多使用场景下，数据处理的顺序都很重要。大部分消息队列本来就是排序的，并且能保证数据会按照特定的顺序来处理。（Kafka保证一个Partition内的消息的有序性）
7. 缓冲：有助于控制和优化数据流经过系统的速度，解决生产消息和消费消息的处理速度不一致的情况。
8. 异步通信：很多时候，用户不想也不需要立即处理消息。消息队列提供了异步处理机制，允许用户把一个消息放入队列，但并不立即处理它。想向队列中放入多少消息就放多少，然后在需要的时候再去处理它们。


### Kafka 架构

#### 角色说明

##### Broker
一台 kafka 服务器就是一个 broker。一个集群由多个broker组成。一个 broker 可以容纳多个 topic；

broker 其实就是在 Hadoop 集群中的节点的概念。

broker 接收来自生产者的消息，为消息设置偏移量，并提交消息到磁盘保存。

broker 为消费者提供服务，对读取分区的请求作出响应，返回给消费者曾经生产者已经提交到磁盘上的消息。

##### Producer
消息生产者，就是向 kafka broker 发消息的客户端；

##### Consumer
消息消费者，从 kafka broker 读取消息的客户端；

##### Topic
Kaflca 的悄息通过 Topic 进行分类。 主题就好比数据库的表，或者文件系统里的文件夹。

生产者向 broker 发送消息的时候要指定一个 Topic，消费者读取消息的时候也得指定一个具体的 Topic。

##### Partition
为了实现扩展性，一个非常大的 topic 可以分布到多个 broker（即服务器）上，一个topic 可以分为多个 partition。

消息以追加的方式写入 partition，后以先先出的顺序读取。

每个 partition 是一个有序的队列。partition 中的每条消息都会被分配一个有序的id（offset）。kafka 只保证按一个 partition 中的顺序将消息发给 consumer，不保证一个 topic 的整体（多个partition间）的顺序；

##### Consumer Group
一个 Consumer Group 是多个 consumer 的组合，作为一个整体存在。

这是 kafka 用来实现一个 topic 消息的广播（发给所有的 consumer ）和 单播（发给任意一个 consumer）的手段。

同一个消费者组内的消费者读取消息的时候，不会读取同一个分区内的消息。

但是组与组之间不受任何影响。

##### Offset
偏移量。

kafka 的存储文件都是按照 offset.kafka 来命名

用 offset 做名字的好处是方便查找。例如你想找位于 2049 的位置，只要找到2048.kafka 的文件即可。

当然the first offset就是00000000000.kafka。

##### 关于 zookeeper
Kafka 使用 Zookeeper 保存集群的元数据信息和消费者信息，来保证集群的可用性。

Kafka 集群中只能有一个 leader，其他都是 follower，这都需要 Zookeeper 来保证。

### 配置
```
##每一个broker在集群中的唯一标示，要求是正数。在改变IP地址，不改变broker.id的话不会影响consumers
broker.id =1

##kafka数据的存放地址，多个地址的话用逗号分割 /tmp/kafka-logs-1，/tmp/kafka-logs-2
log.dirs = /tmp/kafka-logs

##提供给客户端响应的端口
port =6667

##消息体的最大大小，单位是字节
message.max.bytes =1000000

## broker 处理消息的最大线程数，一般情况下不需要去修改
num.network.threads =3

## broker处理磁盘IO 的线程数，数值应该大于你的硬盘数
num.io.threads =8

## 一些后台任务处理的线程数，例如过期消息文件的删除等，一般情况下不需要去做修改
background.threads =4

## 等待IO线程处理的请求队列最大数，若是等待IO的请求超过这个数值，那么会停止接受外部消息，算是一种自我保护机制
queued.max.requests =500

##broker的主机地址，若是设置了，那么会绑定到这个地址上，若是没有，会绑定到所有的接口上，并将其中之一发送到ZK，一般不设置
host.name
 
## 打广告的地址，若是设置的话，会提供给producers，consumers，其他broker连接，具体如何使用还未深究
advertised.host.name

## 广告地址端口，必须不同于port中的设置
advertised.port

## socket的发送缓冲区，socket的调优参数SO_SNDBUFF
socket.send.buffer.bytes =100*1024

## socket的接受缓冲区，socket的调优参数SO_RCVBUFF
socket.receive.buffer.bytes =100*1024

## socket请求的最大数值，防止serverOOM，message.max.bytes必然要小于socket.request.max.bytes，会被topic创建时的指定参数覆盖
socket.request.max.bytes =100*1024*1024
 
## topic的分区是以一堆segment文件存储的，这个控制每个segment的大小，会被topic创建时的指定参数覆盖
log.segment.bytes =1024*1024*1024

## 这个参数会在日志segment没有达到log.segment.bytes设置的大小，也会强制新建一个segment 会被 topic创建时的指定参数覆盖
log.roll.hours =24*7

## 日志清理策略 选择有：delete和compact 主要针对过期数据的处理，或是日志文件达到限制的额度，会被 topic创建时的指定参数覆盖
log.cleanup.policy = delete

## 数据存储的最大时间 超过这个时间 会根据log.cleanup.policy设置的策略处理数据，也就是消费端能够多久去消费数据
## log.retention.bytes和log.retention.minutes任意一个达到要求，都会执行删除，会被topic创建时的指定参数覆盖
log.retention.minutes=7days

指定日志每隔多久检查看是否可以被删除，默认1分钟
log.cleanup.interval.mins=1

## topic每个分区的最大文件大小，一个topic的大小限制 = 分区数*log.retention.bytes 。-1没有大小限制
## log.retention.bytes和log.retention.minutes任意一个达到要求，都会执行删除，会被topic创建时的指定参数覆盖
log.retention.bytes=-1

## 文件大小检查的周期时间，是否处罚 log.cleanup.policy中设置的策略
log.retention.check.interval.ms=5minutes

## 是否开启日志压缩
log.cleaner.enable=false

## 日志压缩运行的线程数
log.cleaner.threads =1

## 日志压缩时候处理的最大大小
log.cleaner.io.max.bytes.per.second=None

## 日志压缩去重时候的缓存空间，在空间允许的情况下，越大越好
log.cleaner.dedupe.buffer.size=500*1024*1024

## 日志清理时候用到的IO块大小 一般不需要修改
log.cleaner.io.buffer.size=512*1024

## 日志清理中hash表的扩大因子 一般不需要修改
log.cleaner.io.buffer.load.factor =0.9

## 检查是否处罚日志清理的间隔
log.cleaner.backoff.ms =15000

## 日志清理的频率控制，越大意味着更高效的清理，同时会存在一些空间上的浪费，会被topic创建时的指定参数覆盖
log.cleaner.min.cleanable.ratio=0.5

## 对于压缩的日志保留的最长时间，也是客户端消费消息的最长时间，同log.retention.minutes的区别在于一个控制未压缩数据，一个控制压缩后的数据。会被topic创建时的指定参数覆盖
log.cleaner.delete.retention.ms =1day

## 对于segment日志的索引文件大小限制，会被topic创建时的指定参数覆盖
log.index.size.max.bytes =10*1024*1024

## 当执行一个fetch操作后，需要一定的空间来扫描最近的offset大小，设置越大，代表扫描速度越快，但是也更好内存，一般情况下不需要搭理这个参数
log.index.interval.bytes =4096

## log文件"sync"到磁盘之前累积的消息条数
## 因为磁盘IO操作是一个慢操作，但又是一个"数据可靠性"的必要手段
## 所以此参数的设置，需要在"数据可靠性"与"性能"之间做必要的权衡.
## 如果此值过大，将会导致每次"fsync"的时间较长(IO阻塞)
## 如果此值过小，将会导致"fsync"的次数较多，这也意味着整体的client请求有一定的延迟.
## 物理server故障，将会导致没有fsync的消息丢失.
log.flush.interval.messages=None

## 检查是否需要固化到硬盘的时间间隔
log.flush.scheduler.interval.ms =3000

## 仅仅通过interval来控制消息的磁盘写入时机，是不足的.
## 此参数用于控制"fsync"的时间间隔，如果消息量始终没有达到阀值，但是离上一次磁盘同步的时间间隔
## 达到阀值，也将触发.
log.flush.interval.ms = None

## 文件在索引中清除后保留的时间 一般不需要去修改
log.delete.delay.ms =60000

## 控制上次固化硬盘的时间点，以便于数据恢复 一般不需要去修改
log.flush.offset.checkpoint.interval.ms =60000

## 是否允许自动创建topic，若是false，就需要通过命令创建topic
auto.create.topics.enable =true

## 一个topic，默认分区的replication个数，不得大于集群中broker的个数
default.replication.factor =1

## 每个topic的分区个数，若是在topic创建时候没有指定的话 会被topic创建时的指定参数覆盖
num.partitions =1

实例 --replication-factor3--partitions1--topic replicated-topic ：名称replicated-topic有一个分区，分区被复制到三个broker上。

## partition leader与replicas之间通讯时，socket的超时时间
controller.socket.timeout.ms =30000
 
## partition leader与replicas数据同步时，消息的队列尺寸
controller.message.queue.size=10
 
## replicas响应partition leader的最长等待时间，若是超过这个时间，就将replicas列入ISR(in-sync replicas)，并认为它是死的，不会再加入管理中
replica.lag.time.max.ms =10000
 
## 如果follower落后与leader太多，将会认为此follower[或者说partition relicas]已经失效
## 通常，在follower与leader通讯时，因为网络延迟或者链接断开，总会导致replicas中消息同步滞后
## 如果消息之后太多，leader将认为此follower网络延迟较大或者消息吞吐能力有限，将会把此replicas迁移到其他follower中。
## 在broker数量较少，或者网络不足的环境中，建议提高此值。
replica.lag.max.messages =4000
 
##follower与leader之间的socket超时时间
replica.socket.timeout.ms=30*1000
 
## leader复制时候的socket缓存大小
replica.socket.receive.buffer.bytes=64*1024
 
## replicas每次获取数据的最大大小
replica.fetch.max.bytes =1024*1024
 
## replicas同leader之间通信的最大等待时间，失败了会重试
replica.fetch.wait.max.ms =500
 
## fetch的最小数据尺寸，如果leader中尚未同步的数据不足此值，将会阻塞，直到满足条件
replica.fetch.min.bytes =1
 
## leader 进行复制的线程数，增大这个数值会增加follower的IO
num.replica.fetchers=1
 
## 每个replica检查是否将最高水位进行固化的频率
replica.high.watermark.checkpoint.interval.ms =5000
 
## 是否允许控制器关闭broker，若是设置为true，会关闭所有在这个broker上的leader，并转移到其他broker
controlled.shutdown.enable =false
 
## 控制器关闭的尝试次数
controlled.shutdown.max.retries =3
 
## 每次关闭尝试的时间间隔
controlled.shutdown.retry.backoff.ms =5000
 
## 是否自动平衡broker之间的分配策略
auto.leader.rebalance.enable =false
 
## leader的不平衡比例，若是超过这个数值，会对分区进行重新的平衡
leader.imbalance.per.broker.percentage =10
 
## 检查leader是否不平衡的时间间隔
leader.imbalance.check.interval.seconds =300
 
## 客户端保留offset信息的最大空间大小
offset.metadata.max.bytes
 
## zookeeper集群的地址，可以是多个，多个之间用逗号分割 hostname1:port1,hostname2:port2,hostname3:port3
zookeeper.connect = localhost:2181
 
## ZooKeeper的最大超时时间，就是心跳的间隔，若是没有反映，那么认为已经死了，不易过大
zookeeper.session.timeout.ms=6000
 
## ZooKeeper的连接超时时间
zookeeper.connection.timeout.ms =6000
 
## ZooKeeper集群中leader和follower之间的同步实际那
zookeeper.sync.time.ms =2000

## Consumer归属的组ID，broker是根据group.id来判断是队列模式还是发布订阅模式，非常重要
group.id

## 消费者的ID，若是没有设置的话，会自增
consumer.id

## 一个用于跟踪调查的ID，最好同group.id相同
client.id = group id value

## 对于zookeeper集群的指定，可以是多个 hostname1:port1,hostname2:port2,hostname3:port3 必须和broker使用同样的zk配置
zookeeper.connect=localhost:2182

## zookeeper的心跳超时时间，查过这个时间就认为是dead消费者
zookeeper.session.timeout.ms =6000

## zookeeper的等待连接时间
zookeeper.connection.timeout.ms =6000

## zookeeper的follower同leader的同步时间
zookeeper.sync.time.ms =2000

## 当zookeeper中没有初始的offset时候的处理方式 。smallest ：重置为最小值 largest:重置为最大值 anythingelse：抛出异常
auto.offset.reset = largest

## socket的超时时间，实际的超时时间是：max.fetch.wait + socket.timeout.ms.
socket.timeout.ms=30*1000

## socket的接受缓存空间大小
socket.receive.buffer.bytes=64*1024

##从每个分区获取的消息大小限制
fetch.message.max.bytes =1024*1024

## 是否在消费消息后将offset同步到zookeeper，当Consumer失败后就能从zookeeper获取最新的offset
auto.commit.enable =true

## 自动提交的时间间隔
auto.commit.interval.ms =60*1000

## 用来处理消费消息的块，每个块可以等同于fetch.message.max.bytes中数值
queued.max.message.chunks =10

## 当有新的consumer加入到group时，将会reblance，此后将会有partitions的消费端迁移到新的consumer上，如果一个consumer获得了某个partition的消费权限，那么它将会向zk注册"Partition Owner registry"节点信息，但是有可能此时旧的consumer尚没有释放此节点。
## 此值用于控制，注册节点的重试次数。
rebalance.max.retries =4

## 每次再平衡的时间间隔
rebalance.backoff.ms =2000

## 每次重新选举leader的时间
refresh.leader.backoff.ms

## server发送到消费端的最小数据，若是不满足这个数值则会等待，知道满足数值要求
fetch.min.bytes =1

## 若是不满足最小大小(fetch.min.bytes)的话，等待消费端请求的最长等待时间
fetch.wait.max.ms =100

## 指定时间内没有消息到达就抛出异常，一般不需要改
consumer.timeout.ms = -1

## 消费者获取消息元信息(topics, partitions and replicas)的地址，配置格式是：host1:port1,host2:port2，也可以在外面设置一个vip
metadata.broker.list

## 消息的确认模式
## 0：不保证消息的到达确认，只管发送，低延迟但是会出现消息的丢失，在某个server失败的情况下，有点像TCP。
## 1：发送消息，并会等待leader 收到确认后，一定的可靠性。
## -1：发送消息，等待leader收到确认，并进行复制操作后，才返回，最高的可靠性。
request.required.acks =0
 
## 消息发送的最长等待时间
request.timeout.ms =10000

## socket的缓存大小
send.buffer.bytes=100*1024

## key的序列化方式，若是没有设置，同serializer.class
key.serializer.class

## 分区的策略，默认是取模
partitioner.class=kafka.producer.DefaultPartitioner

## 消息的压缩模式，默认是none，可以有gzip和snappy
compression.codec = none

## 可以针对默写特定的topic进行压缩
compressed.topics=null

## 消息发送失败后的重试次数
message.send.max.retries =3

## 每次失败后的间隔时间
retry.backoff.ms =100

## 生产者定时更新topic元信息的时间间隔，若是设置为0，那么会在每个消息发送后都去更新数据
topic.metadata.refresh.interval.ms =600*1000

## 用户随意指定，但是不能重复，主要用于跟踪记录消息
client.id=""

## 生产者的类型 async:异步执行消息的发送 sync：同步执行消息的发送
producer.type=sync

## 异步模式下，那么就会在设置的时间缓存消息，并一次性发送
queue.buffering.max.ms =5000

## 异步的模式下 最长等待的消息数
queue.buffering.max.messages =10000

## 异步模式下，进入队列的等待时间 若是设置为0，那么要么进入队列，要么直接抛弃
queue.enqueue.timeout.ms = -1

## 异步模式下，每次发送的最大消息数，前提是触发了queue.buffering.max.messages或是queue.buffering.max.ms的限制
batch.num.messages=200

## 消息体的系列化处理类，转化为字节流进行传输
serializer.class= kafka.serializer.DefaultEncoder
```
#### 配置的修改

其中一部分配置是可以被每个topic自身的配置所代替。

```shell
# 新增配置
bin/kafka-topics.sh --zookeeper localhost:2181--create --topic my-topic --partitions1--replication-factor1--config max.message.bytes=64000--config flush.messages=1

# 修改配置
bin/kafka-topics.sh --zookeeper localhost:2181--alter --topic my-topic --config max.message.bytes=128000

# 删除配置 
bin/kafka-topics.sh --zookeeper localhost:2181--alter --topic my-topic --deleteConfig max.message.bytes
```

### 使用

```bash
# Download the latest Kafka release and extract it:
$ tar -xzf kafka_2.13-3.0.0.tgz
$ cd kafka_2.13-3.0.0

# NOTE: Your local environment must have Java 8+ installed.

# Start the ZooKeeper service
# Note: Soon, ZooKeeper will no longer be required by Apache Kafka.
$ bin/zookeeper-server-start.sh config/zookeeper.properties

# Start the Kafka broker service
$ bin/kafka-server-start.sh config/server.properties

$ bin/kafka-topics.sh --create --topic quickstart-events --bootstrap-server localhost:9092

$ bin/kafka-topics.sh --describe --topic quickstart-events --bootstrap-server localhost:9092
Topic:quickstart-events  PartitionCount:1    ReplicationFactor:1 Configs:
    Topic: quickstart-events Partition: 0    Leader: 0   Replicas: 0 Isr: 0

$ bin/kafka-console-producer.sh --topic quickstart-events --bootstrap-server localhost:9092
This is my first event
This is my second event

$ bin/kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092
This is my first event
This is my second event

```







