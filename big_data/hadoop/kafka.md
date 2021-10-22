## kafka

Kafka 是为了解决 Linkedln 数据管道问题应运而生的。 它的设计目的是提供一个高性能的悄息系统，可以处理多种数据类型，并能够实时提供纯净且结构化的用户活动数据和系统度量指标。

Linkedln 的开发团队由 Jay Kreps 领导。 Jay Kreps 是 Linkedln 的首席工程师，之前负责分布式键值存储系统 Voldemort 的开发。

2010 年底，Kafka 作为开源项目在 GitHub 上发布。 2011 年 7 月，因为倍受开源社区的关注，它成为 Apache 软件基金会的孵化器项目。

现在， Kafka 被很多组织用在一些大型的数据管道上，Kafka 已经成为大数据管道的不二之选。

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







