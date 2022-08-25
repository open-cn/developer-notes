## Flink

### 概述

Apache Flink 是一个框架和分布式处理引擎，用于在无边界和有边界数据流上进行有状态的计算。Flink 能在所有常见集群环境中运行，并能以内存速度和任意规模进行计算。

Flink具备7X24小时高可用的SOA（面向服务架构），原因是在实现上 Flink 提供了一致性的 Checkpoint。Checkpoint 是 Flink 实现容错机制的核心，它周期性的记录计算过程中 Operator 的状态，并生成快照持久化存储。当 Flink 作业发生故障崩溃时，可以有选择的从 Checkpoint 中恢复，保证了计算的一致性。

#### 有界、无界数据流

有界数据流（bounded stream）&& 无界数据流（unbounded stream）

任何类型的数据都可以形成一种事件流。信用卡交易、传感器测量、机器日志、网站或移动应用程序上的用户交互记录，所有这些数据都形成一种流。

数据可以被作为*无界*或者*有界*流来处理。

1. 无界流 有定义流的开始，但没有定义流的结束。它们会无休止地产生数据。无界流的数据必须持续处理，即数据被摄取后需要立刻处理。我们不能等到所有数据都到达再处理，因为输入是无限的，在任何时候输入都不会完成。处理无界数据通常要求以特定顺序摄取事件，例如事件发生的顺序，以便能够推断结果的完整性。
2. 有界流 有定义流的开始，也有定义流的结束。有界流可以在摄取所有数据后再进行计算。有界流所有数据可以被排序，所以并不需要有序摄取。有界流处理通常被称为批处理。

Apache Flink 擅长处理无界和有界数据集 精确的时间控制和状态化使得 Flink 的运行时(runtime)能够运行任何处理无界流的应用。有界流则由一些专为固定大小数据集特殊设计的算法和数据结构进行内部处理，产生了出色的性能。

两者区别：

- 无界数据流的数据会随着时间的推移而持续增加，计算持续进行且不存在结束的状态  7x24   实时
- 有界数据流数据大小固定，计算最终会完成并处于结束的状态   离线

##### 流处理系统

包括 Flink 在内的分布式流处理引擎一般采用 DAG 图来表示整个计算逻辑，DAG的每个点都代表一个基本的逻辑单元，即算子Source接入-->transformation网络传输/本地传输在算子间进行发送和处理-->sink发送到外部系统或数据库
         
##### 流数据
从广义上说，所有大数据的生成均可以看作是一连串发生的离散事件。这些离散的事件以时间轴为维度看就形成了一条条事件流/数据流。数据是指由数千个数据源持续生成的数据，流数据通常也以数据记录的形式发送，但相较于离线数据，流数据普遍的规模较小。

在典型的大数据业务场景下数据业务最通用的做法是：选出批处理的技术处理全量数据，采用流式计算处理实时增量数据。

现有批流统一方案：spark、flink、ray引擎融合计算（spark+flink）

推荐流计算神书：Streaming Systems！

无界数据处理过程中最关键的几个问题：

1. 计算什么结果？
2. 在事件时间的哪个地方计算结果？
3. 在处理过程的什么时间点，可以输出结果？
4. 如何更新结果？

##### 流计算的特征

- 时效性高：数据实时采集、实时处理，延时粒度在秒级甚至毫秒级，业务方能够在第一时间拿到经过加工处理后的数据。
- 常驻任务：区别于离线任务的周期调度，流式任务属于常驻进程任务， 一旦启动后就会一直运行，直到人为地终止，因此计算成本会相对比较高。
- 性能要求高：实时计算程序的性能优化占任务开发的很大一部分工作。
- 应用局限性：数据到达时间的不确定性导致实时处理眼离线处理得出来的结果会有一定的差异。

#### 部署应用到任意地方
Apache Flink 是一个分布式系统，它需要计算资源来执行应用程序。Flink 集成了所有常见的集群资源管理器，例如 Hadoop YARN、 Apache Mesos 和 Kubernetes，但同时也可以作为独立集群运行。

Flink 被设计为能够很好地工作在上述每个资源管理器中，这是通过资源管理器特定(resource-manager-specific)的部署模式实现的。Flink 可以采用与当前资源管理器相适应的方式进行交互。

部署 Flink 应用程序时，Flink 会根据应用程序配置的并行性自动标识所需的资源，并从资源管理器请求这些资源。在发生故障的情况下，Flink 通过请求新资源来替换发生故障的容器。提交或控制应用程序的所有通信都是通过 REST 调用进行的，这可以简化 Flink 与各种环境中的集成。

#### 运行任意规模应用
Flink 旨在任意规模上运行有状态流式应用。因此，应用程序被并行化为可能数千个任务，这些任务分布在集群中并发执行。所以应用程序能够充分利用无尽的 CPU、内存、磁盘和网络 IO。而且 Flink 很容易维护非常大的应用程序状态。其异步和增量的检查点算法对处理延迟产生最小的影响，同时保证精确一次状态的一致性。

Flink 用户报告了其生产环境中一些令人印象深刻的扩展性数字

- 处理每天处理数万亿的事件
- 应用维护几TB大小的状态
- 应用在数千个内核上运行

#### 利用内存性能
有状态的 Flink 程序针对本地状态访问进行了优化。任务的状态始终保留在内存中，如果状态大小超过可用内存，则会保存在能高效访问的磁盘数据结构中。任务通过访问本地（通常在内存中）状态来进行所有的计算，从而产生非常低的处理延迟。Flink 通过定期和异步地对本地状态进行持久化存储来保证故障场景下精确一次的状态一致性。

#### Flink 应用

Apache Flink 是一个针对无界和有界数据流进行有状态计算的框架。Flink 自底向上在不同的抽象级别提供了多种 API，并且针对常见的使用场景开发了专用的扩展库。

##### 流处理应用的基本组件
可以由流处理框架构建和执行的应用程序类型是由框架对*流*、*状态*、*时间*的支持程度来决定的。

**流**

显而易见，（数据）流是流处理的基本要素。然而，流也拥有着多种特征。这些特征决定了流如何以及何时被处理。Flink 是一个能够处理任何类型数据流的强大处理框架。

- *有界*和*无界*的数据流：流可以是无界的；也可以是有界的，例如固定大小的数据集。Flink 在无界的数据流处理上拥有诸多功能强大的特性，同时也针对有界的数据流开发了专用的高效算子。
- *实时*和*历史记录*的数据流：所有的数据都是以流的方式产生，但用户通常会使用两种截然不同的方法处理数据。或是在数据生成时进行实时的处理；亦或是先将数据流持久化到存储系统中——例如文件系统或对象存储，然后再进行批处理。Flink 的应用能够同时支持处理实时以及历史记录数据流。

**状态**

只有在每一个单独的事件上进行转换操作的应用才不需要状态，换言之，每一个具有一定复杂度的流处理应用都是有状态的。任何运行基本业务逻辑的流处理应用都需要在一定时间内存储所接收的事件或中间结果，以供后续的某个时间点（例如收到下一个事件或者经过一段特定时间）进行访问并进行后续处理。

应用状态是 Flink 中的一等公民，Flink 提供了许多状态管理相关的特性支持，其中包括：

- 多种状态基础类型：Flink 为多种不同的数据结构提供了相对应的状态基础类型，例如原子值（value），列表（list）以及映射（map）。开发者可以基于处理函数对状态的访问方式，选择最高效、最适合的状态基础类型。
- 插件化的State Backend：State Backend 负责管理应用程序状态，并在需要的时候进行 checkpoint。Flink 支持多种 state backend，可以将状态存在内存或者 RocksDB。RocksDB 是一种高效的嵌入式、持久化键值存储引擎。Flink 也支持插件式的自定义 state backend 进行状态存储。
- 精确一次语义：Flink 的 checkpoint 和故障恢复算法保证了故障发生后应用状态的一致性。因此，Flink 能够在应用程序发生故障时，对应用程序透明，不造成正确性的影响。
- 超大数据量状态：Flink 能够利用其异步以及增量式的 checkpoint 算法，存储数 TB 级别的应用状态。
- 可弹性伸缩的应用：Flink 能够通过在更多或更少的工作节点上对状态进行重新分布，支持有状态应用的分布式的横向伸缩。

**时间**

时间是流处理应用另一个重要的组成部分。因为事件总是在特定时间点发生，所以大多数的事件流都拥有事件本身所固有的时间语义。进一步而言，许多常见的流计算都基于时间语义，例如窗口聚合、会话计算、模式检测和基于时间的 join。流处理的一个重要方面是应用程序如何衡量时间，即区分事件时间（event-time）和处理时间（processing-time）。

Flink 提供了丰富的时间语义支持。

- 事件时间模式：使用事件时间语义的流处理应用根据事件本身自带的时间戳进行结果的计算。因此，无论处理的是历史记录的事件还是实时的事件，事件时间模式的处理总能保证结果的准确性和一致性。
- Watermark 支持：Flink 引入了 watermark 的概念，用以衡量事件时间进展。Watermark 也是一种平衡处理延时和完整性的灵活机制。
- 迟到数据处理：当以带有 watermark 的事件时间模式处理数据流时，在计算完成之后仍会有相关数据到达。这样的事件被称为迟到事件。Flink 提供了多种处理迟到数据的选项，例如将这些数据重定向到旁路输出（side output）或者更新之前完成计算的结果。
- 处理时间模式：除了事件时间模式，Flink 还支持处理时间语义。处理时间模式根据处理引擎的机器时钟触发计算，一般适用于有着严格的低延迟需求，并且能够容忍近似结果的流处理应用。

##### 分层 API

Flink 根据抽象程度分层，提供了三种不同的 API。每一种 API 在简洁性和表达力上有着不同的侧重，并且针对不同的应用场景。

**ProcessFunction**

ProcessFunction 是 Flink 所提供的最具表达力的接口。ProcessFunction 可以处理一或两条输入数据流中的单个事件或者归入一个特定窗口内的多个事件。它提供了对于时间和状态的细粒度控制。开发者可以在其中任意地修改状态，也能够注册定时器用以在未来的某一时刻触发回调函数。因此，你可以利用 ProcessFunction 实现许多有状态的事件驱动应用所需要的基于单个事件的复杂业务逻辑。

下面的代码示例展示了如何在 KeyedStream 上利用 KeyedProcessFunction 对标记为 START 和 END 的事件进行处理。当收到 START 事件时，处理函数会记录其时间戳，并且注册一个时长4小时的计时器。如果在计时器结束之前收到 END 事件，处理函数会计算其与上一个 START 事件的时间间隔，清空状态并将计算结果返回。否则，计时器结束，并清空状态。

```java
/**

 * 将相邻的 keyed START 和 END 事件相匹配并计算两者的时间间隔
 * 输入数据为 Tuple2<String, String> 类型，第一个字段为 key 值， 
 * 第二个字段标记 START 和 END 事件。
    */
public static class StartEndDuration
    extends KeyedProcessFunction<String, Tuple2<String, String>, Tuple2<String, Long>> {

  private ValueState<Long> startTime;

  @Override
  public void open(Configuration conf) {
    // obtain state handle
    startTime = getRuntimeContext()
      .getState(new ValueStateDescriptor<Long>("startTime", Long.class));
  }

  /** Called for each processed event. */
  @Override
  public void processElement(
      Tuple2<String, String> in,
      Context ctx,
      Collector<Tuple2<String, Long>> out) throws Exception {

    switch (in.f1) {
      case "START":
        // set the start time if we receive a start event.
        startTime.update(ctx.timestamp());
        // register a timer in four hours from the start event.
        ctx.timerService()
          .registerEventTimeTimer(ctx.timestamp() + 4 * 60 * 60 * 1000);
        break;
      case "END":
        // emit the duration between start and end event
        Long sTime = startTime.value();
        if (sTime != null) {
          out.collect(Tuple2.of(in.f0, ctx.timestamp() - sTime));
          // clear the state
          startTime.clear();
        }
      default:
        // do nothing
    }
  }

  /** Called when a timer fires. */
  @Override
  public void onTimer(
      long timestamp,
      OnTimerContext ctx,
      Collector<Tuple2<String, Long>> out) {

    // Timeout interval exceeded. Cleaning up the state.
    startTime.clear();
  }
}
```

这个例子充分展现了 KeyedProcessFunction 强大的表达力，也因此是一个实现相当复杂的接口。

**DataStream API**

DataStream API 为许多通用的流处理操作提供了处理原语。这些操作包括窗口、逐条记录的转换操作，在处理事件时进行外部数据库查询等。DataStream API 支持 Java 和 Scala 语言，预先定义了例如map()、reduce()、aggregate() 等函数。你可以通过扩展实现预定义接口或使用 Java、Scala 的 lambda 表达式实现自定义的函数。

下面的代码示例展示了如何捕获会话时间范围内所有的点击流事件，并对每一次会话的点击量进行计数。

```java
// 网站点击 Click 的数据流
DataStream<Click> clicks = ...

DataStream<Tuple2<String, Long>> result = clicks
  // 将网站点击映射为 (userId, 1) 以便计数
  .map(
    // 实现 MapFunction 接口定义函数
    new MapFunction<Click, Tuple2<String, Long>>() {
      @Override
      public Tuple2<String, Long> map(Click click) {
        return Tuple2.of(click.userId, 1L);
      }
    })
  // 以 userId (field 0) 作为 key
  .keyBy(0)
  // 定义 30 分钟超时的会话窗口
  .window(EventTimeSessionWindows.withGap(Time.minutes(30L)))
  // 对每个会话窗口的点击进行计数，使用 lambda 表达式定义 reduce 函数
  .reduce((a, b) -> Tuple2.of(a.f0, a.f1 + b.f1));
```

**SQL & Table API**

Flink 支持两种关系型的 API，Table API 和 SQL。这两个 API 都是批处理和流处理统一的 API，这意味着在无边界的实时数据流和有边界的历史记录数据流上，关系型 API 会以相同的语义执行查询，并产生相同的结果。Table API 和 SQL 借助了 Apache Calcite 来进行查询的解析，校验以及优化。它们可以与 DataStream 和 DataSet API 无缝集成，并支持用户自定义的标量函数，聚合函数以及表值函数。

Flink 的关系型 API 旨在简化数据分析、数据流水线和 ETL 应用的定义。

下面的代码示例展示了如何使用 SQL 语句查询捕获会话时间范围内所有的点击流事件，并对每一次会话的点击量进行计数。此示例与上述 DataStream API 中的示例有着相同的逻辑。

```sql
SELECT userId, COUNT(*)
FROM clicks
GROUP BY SESSION(clicktime, INTERVAL '30' MINUTE), userId
```

##### 库
Flink 具有数个适用于常见数据处理应用场景的扩展库。这些库通常嵌入在 API 中，且并不完全独立于其它 API。它们也因此可以受益于 API 的所有特性，并与其他库集成。

- 复杂事件处理(CEP)：模式检测是事件流处理中的一个非常常见的用例。Flink 的 CEP 库提供了 API，使用户能够以例如正则表达式或状态机的方式指定事件模式。CEP 库与 Flink 的 DataStream API 集成，以便在 DataStream 上评估模式。CEP 库的应用包括网络入侵检测，业务流程监控和欺诈检测。
- DataSet API：DataSet API 是 Flink 用于批处理应用程序的核心 API。DataSet API 所提供的基础算子包括map、reduce、(outer) join、co-group、iterate等。所有算子都有相应的算法和数据结构支持，对内存中的序列化数据进行操作。如果数据大小超过预留内存，则过量数据将存储到磁盘。Flink 的 DataSet API 的数据处理算法借鉴了传统数据库算法的实现，例如混合散列连接（hybrid hash-join）和外部归并排序（external merge-sort）。
- Gelly: Gelly 是一个可扩展的图形处理和分析库。Gelly 是在 DataSet API 之上实现的，并与 DataSet API 集成。因此，它能够受益于其可扩展且健壮的操作符。Gelly 提供了内置算法，如 label propagation、triangle enumeration 和 page rank 算法，也提供了一个简化自定义图算法实现的 Graph API。


#### Flink 运维

Apache Flink 是一个针对无界和有界数据流进行有状态计算的框架。由于许多流应用程序旨在以最短的停机时间连续运行，因此流处理器必须提供出色的故障恢复能力，以及在应用程序运行期间进行监控和维护的工具。

Apache Flink 非常注重流数据处理的可运维性。Flink 具有故障恢复机制和管理监控应用的功能。

##### 7 * 24小时稳定运行

在分布式系统中，服务故障是常有的事，为了保证服务能够7\*24小时稳定运行，像Flink这样的流处理器故障恢复机制是必须要有的。显然这就意味着，它(这类流处理器)不仅要能在服务出现故障时候能够重启服务，而且还要当故障发生时，保证能够持久化服务内部各个组件的当前状态，只有这样才能保证在故障恢复时候，服务能够继续正常运行，好像故障就没有发生过一样。

Flink通过几下多种机制维护应用可持续运行及其一致性:

- 检查点的一致性: Flink的故障恢复机制是通过建立分布式应用服务状态一致性检查点实现的，当有故障产生时，应用服务会重启后，再重新加载上一次成功备份的状态检查点信息。结合可重放的数据源，该特性可保证精确一次（exactly-once）的状态一致性。
- 高效的检查点: 如果一个应用要维护一个TB级的状态信息，对此应用的状态建立检查点服务的资源开销是很高的，为了减小因检查点服务对应用的延迟性（SLAs服务等级协议）的影响，Flink采用异步及增量的方式构建检查点服务。
- 端到端的精确一次: Flink 为某些特定的存储支持了事务型输出的功能，及时在发生故障的情况下，也能够保证精确一次的输出。
- 集成多种集群管理服务: Flink已与多种集群管理服务紧密集成，如 Hadoop YARN, Mesos, 以及 Kubernetes。当集群中某个流程任务失败后，一个新的流程服务会自动启动并替代它继续执行。
- 内置高可用服务: Flink内置了为解决单点故障问题的高可用性服务模块，此模块是基于Apache ZooKeeper 技术实现的，Apache ZooKeeper是一种可靠的、交互式的、分布式协调服务组件。

##### Flink能够更方便地升级、迁移、暂停、恢复应用服务

驱动关键业务服务的流应用是经常需要维护的。比如需要修复系统漏洞，改进功能，或开发新功能。然而升级一个有状态的流应用并不是简单的事情，因为在我们为了升级一个改进后版本而简单停止当前流应用并重启时，我们还不能丢失掉当前流应用的所处于的状态信息。

而Flink的 Savepoint 服务就是为解决升级服务过程中记录流应用状态信息及其相关难题而产生的一种唯一的、强大的组件。一个 Savepoint，就是一个应用服务状态的一致性快照，因此其与checkpoint组件的很相似，但是与checkpoint相比，Savepoint 需要手动触发启动，而且当流应用服务停止时，它并不会自动删除。Savepoint 常被应用于启动一个已含有状态的流服务，并初始化其（备份时）状态。Savepoint 有以下特点：

- 便于升级应用服务版本: Savepoint 常在应用版本升级时使用，当前应用的新版本更新升级时，可以根据上一个版本程序记录的 Savepoint 内的服务状态信息来重启服务。它也可能会使用更早的 Savepoint 还原点来重启服务，以便于修复由于有缺陷的程序版本导致的不正确的程序运行结果。
- 方便集群服务移植: 通过使用 Savepoint，流服务应用可以自由的在不同集群中迁移部署。
- 方便Flink版本升级: 通过使用 Savepoint，可以使应用服务在升级Flink时，更加安全便捷。
- 增加应用并行服务的扩展性: Savepoint 也常在增加或减少应用服务集群的并行度时使用。
- 便于A/B测试及假设分析场景对比结果: 通过把同一应用在使用不同版本的应用程序，基于同一个 Savepoint 还原点启动服务时，可以测试对比2个或多个版本程序的性能及服务质量。
- 暂停和恢复服务: 一个应用服务可以在新建一个 Savepoint 后再停止服务，以便于后面任何时间点再根据这个实时刷新的 Savepoint 还原点进行恢复服务。
- 归档服务: Savepoint 还提供还原点的归档服务，以便于用户能够指定时间点的 Savepoint 的服务数据进行重置应用服务的状态，进行恢复服务。

##### 监控和控制应用服务

如其它应用服务一样，持续运行的流应用服务也需要监控及集成到一些基础设施资源管理服务中，例如一个组件的监控服务及日志服务等。监控服务有助于预测问题并提前做出反应，日志服务提供日志记录能够帮助追踪、调查、分析故障发生的根本原因。最后，便捷易用的访问控制应用服务运行的接口也是Flink的一个重要的亮点特征。

Flink与许多常见的日志记录和监视服务集成得很好，并提供了一个REST API来控制应用服务和查询应用信息。具体表现如下：

- Web UI方式: Flink提供了一个web UI来观察、监视和调试正在运行的应用服务。并且还可以执行或取消组件或任务的执行。
- 日志集成服务:Flink实现了流行的slf4j日志接口，并与日志框架log4j或logback集成。
- 指标服务: Flink提供了一个复杂的度量系统来收集和报告系统和用户定义的度量指标信息。度量信息可以导出到多个报表组件服务，包括 JMX, Ganglia, Graphite, Prometheus, StatsD, Datadog, 和 Slf4j.
- 标准的WEB REST API接口服务: Flink提供多种REST API接口，有提交新应用程序、获取正在运行的应用程序的Savepoint服务信息、取消应用服务等接口。REST API还提供元数据信息和已采集的运行中或完成后的应用服务的指标信息。

#### 有状态函数

 Stateful functions - Event-driven Applications on Apache Flink

有状态函数是一种 API，可简化构建分布式有状态应用程序。它基于具有持久状态的函数，可以通过强一致性保证动态交互。

有状态函数是存在于表示实体的多个实例中的一小段逻辑/代码——类似于actor。函数是通过消息调用的，它们是：

- 有状态的：函数具有嵌入的容错状态，像变量一样在本地访问。
- 虚拟的：与 FaaS 非常相似，函数不保留资源——不活动的函数不消耗 CPU/内存。

**有状态函数应用程序**

应用程序由多个功能模块组成，可以任意交互：

- 恰好一次语义：状态和消息传递相辅相成，提供恰好一次的消息/状态语义。
- 逻辑寻址：函数通过逻辑地址相互发送消息。不需要服务发现。
- 动态和循环消息：消息传递模式不需要预先定义为数据流（动态），也不限于 DAG（循环）。

**为无服务器架构构建的运行时**

有状态函数运行时旨在提供一组类似于无服务器函数特征的属性，但适用于有状态问题。

运行时基于 Apache Flink ®构建，具有以下设计原则：

- 逻辑计算/状态协同定位：消息传递、状态访问/更新和函数调用被紧密地管理在一起。这确保了开箱即用的高级一致性。
- 物理计算/状态分离：函数可以远程执行，消息和状态访问作为调用请求的一部分提供。通过这种方式，可以像无状态流程一样管理功能，并支持快速扩展、滚动升级和其他常见的操作模式。
- 语言独立：函数调用使用简单的基于 HTTP/gRPC 的协议，因此函数可以轻松地以各种语言实现。

这使得在Kubernetes 部署、FaaS 平台或（微）服务后面执行功能成为可能，同时在功能之间提供一致的状态和轻量级消息传递。

##### 主要优势

**动态消息**

API 允许您构建和组合动态地和任意地相互通信的函数。与经典流处理拓扑的非循环性质相比，提供了更大的灵活性。

**一致状态**

函数可以保持本地状态，该状态是持久的并与函数之间的消息传递集成。这为您提供了一次状态访问/更新的效果，并保证了开箱即用的高效消息传递。

**多语言支持**

函数可以用任何可以处理 HTTP 请求或启动 gRPC 服务器的编程语言实现，并初步支持 Python。将为 Go、Javascript 和 Rust 等语言添加更多 SDK。

**不需要数据库**

状态持久性和容错建立在 Apache Flink 强大的分布式快照模型之上。这仅需要一个简单的 blob 存储层（例如 S3、GCS、HDFS）来存储状态快照。

**云原生/生态系统整合**

Stateful Function 的状态和组合方法可以与现代无服务器平台（如 Kubernetes、Knative 和 AWS Lambda）的功能相结合。

**“无状态”操作**

状态访问是函数调用的一部分，因此有状态函数应用程序的行为类似于无状态进程，可以以相同的简单性和优势进行管理，例如快速可扩展性、缩放到零和滚动/零停机升级。

#### Flink 应用场景

Apache Flink 功能强大，支持开发和运行多种不同种类的应用程序。它的主要特性包括：批流一体化、精密的状态管理、事件时间支持以及精确一次的状态一致性保障等。Flink 不仅可以运行在包括 YARN、 Mesos、Kubernetes 在内的多种资源管理框架上，还支持在裸机集群上独立部署。在启用高可用选项的情况下，它不存在单点失效问题。事实证明，Flink 已经可以扩展到数千核心，其状态可以达到 TB 级别，且仍能保持高吞吐、低延迟的特性。世界各地有很多要求严苛的流处理应用都运行在 Flink 之上。

Flink 常见的几类应用：

- 事件驱动型应用
- 数据分析应用
- 数据管道应用

##### 事件驱动型应用

**什么是事件驱动型应用？**

事件驱动型应用是一类具有状态的应用，它从一个或多个事件流提取数据，并根据到来的事件触发计算、状态更新或其他外部动作。

事件驱动型应用是在计算存储分离的传统应用基础上进化而来。在传统架构中，应用需要读写远程事务型数据库。

相反，事件驱动型应用是基于状态化流处理来完成。在该设计中，数据和计算不会分离，应用只需访问本地（内存或磁盘）即可获取数据。系统容错性的实现依赖于定期向远程持久化存储写入 checkpoint。下图描述了传统应用和事件驱动型应用架构的区别。

![传统应用和事件驱动型应用架构的区别](images/usecases-eventdrivenapps.png)


**事件驱动型应用的优势？**

事件驱动型应用无须查询远程数据库，本地数据访问使得它具有更高的吞吐和更低的延迟。而由于定期向远程持久化存储的 checkpoint 工作可以异步、增量式完成，因此对于正常事件处理的影响甚微。事件驱动型应用的优势不仅限于本地数据访问。传统分层架构下，通常多个应用会共享同一个数据库，因而任何对数据库自身的更改（例如：由应用更新或服务扩容导致数据布局发生改变）都需要谨慎协调。反观事件驱动型应用，由于只需考虑自身数据，因此在更改数据表示或服务扩容时所需的协调工作将大大减少。

**Flink 如何支持事件驱动型应用？**

事件驱动型应用会受制于底层流处理系统对时间和状态的把控能力，Flink 诸多优秀特质都是围绕这些方面来设计的。它提供了一系列丰富的状态操作原语，允许以精确一次的一致性语义合并海量规模（TB 级别）的状态数据。此外，Flink 还支持事件时间和自由度极高的定制化窗口逻辑，而且它内置的 ProcessFunction 支持细粒度时间控制，方便实现一些高级业务逻辑。同时，Flink 还拥有一个复杂事件处理（CEP）类库，可以用来检测数据流中的模式。

Flink 中针对事件驱动应用的明星特性当属 savepoint。Savepoint 是一个一致性的状态映像，它可以用来初始化任意状态兼容的应用。在完成一次 savepoint 后，即可放心对应用升级或扩容，还可以启动多个版本的应用来完成 A/B 测试。

**典型的事件驱动型应用实例**

- 反欺诈
- 异常检测
- 基于规则的报警
- 业务流程监控
- （社交网络）Web 应用

##### 数据分析应用

**什么是数据分析应用？**

数据分析任务需要从原始数据中提取有价值的信息和指标。传统的分析方式通常是利用批查询，或将事件记录下来并基于此有限数据集构建应用来完成。为了得到最新数据的分析结果，必须先将它们加入分析数据集并重新执行查询或运行应用，随后将结果写入存储系统或生成报告。

借助一些先进的流处理引擎，还可以实时地进行数据分析。和传统模式下读取有限数据集不同，流式查询或应用会接入实时事件流，并随着事件消费持续产生和更新结果。这些结果数据可能会写入外部数据库系统或以内部状态的形式维护。仪表展示应用可以相应地从外部数据库读取数据或直接查询应用的内部状态。

如下图所示，Apache Flink 同时支持流式及批量分析应用。

![Apache Flink 同时支持流式及批量分析应用](images/usecases-analytics.png)

**流式分析应用的优势？**

和批量分析相比，由于流式分析省掉了周期性的数据导入和查询过程，因此从事件中获取指标的延迟更低。不仅如此，批量查询必须处理那些由定期导入和输入有界性导致的人工数据边界，而流式查询则无须考虑该问题。

另一方面，流式分析会简化应用抽象。批量查询的流水线通常由多个独立部件组成，需要周期性地调度提取数据和执行查询。如此复杂的流水线操作起来并不容易，一旦某个组件出错将会影响流水线的后续步骤。而流式分析应用整体运行在 Flink 之类的高端流处理系统之上，涵盖了从数据接入到连续结果计算的所有步骤，因此可以依赖底层引擎提供的故障恢复机制。

**Flink 如何支持数据分析类应用？**

Flink 为持续流式分析和批量分析都提供了良好的支持。具体而言，它内置了一个符合 ANSI 标准的 SQL 接口，将批、流查询的语义统一起来。无论是在记录事件的静态数据集上还是实时事件流上，相同 SQL 查询都会得到一致的结果。同时 Flink 还支持丰富的用户自定义函数，允许在 SQL 中执行定制化代码。如果还需进一步定制逻辑，可以利用 Flink DataStream API 和 DataSet API 进行更低层次的控制。此外，Flink 的 Gelly 库为基于批量数据集的大规模高性能图分析提供了算法和构建模块支持。

**典型的数据分析应用实例**

- 电信网络质量监控
- 移动应用中的产品更新及实验评估分析
- 消费者技术中的实时数据即席分析
- 大规模图分析

##### 数据管道应用

**什么是数据管道？**

提取-转换-加载（ETL）是一种在存储系统之间进行数据转换和迁移的常用方法。ETL 作业通常会周期性地触发，将数据从事务型数据库拷贝到分析型数据库或数据仓库。

数据管道和 ETL 作业的用途相似，都可以转换、丰富数据，并将其从某个存储系统移动到另一个。但数据管道是以持续流模式运行，而非周期性触发。因此它支持从一个不断生成数据的源头读取记录，并将它们以低延迟移动到终点。例如：数据管道可以用来监控文件系统目录中的新文件，并将其数据写入事件日志；另一个应用可能会将事件流物化到数据库或增量构建和优化查询索引。

下图描述了周期性 ETL 作业和持续数据管道的差异。

![周期性 ETL 作业和持续数据管道的差异](images/usecases-datapipelines.png)

**数据管道的优势？**

和周期性 ETL 作业相比，持续数据管道可以明显降低将数据移动到目的端的延迟。此外，由于它能够持续消费和发送数据，因此用途更广，支持用例更多。

**Flink 如何支持数据管道应用？**

很多常见的数据转换和增强操作可以利用 Flink 的 SQL 接口（或 Table API）及用户自定义函数解决。如果数据管道有更高级的需求，可以选择更通用的 DataStream API 来实现。Flink 为多种数据存储系统（如：Kafka、Kinesis、Elasticsearch、JDBC数据库系统等）内置了连接器。同时它还提供了文件系统的连续型数据源及数据汇，可用来监控目录变化和以时间分区的方式写入文件。

**典型的数据管道应用实例**

- 电子商务中的实时查询索引构建
- 电子商务中的持续 ETL

### Flink 架构
Flink 是一个分布式系统，需要有效分配和管理计算资源才能执行流应用程序。它集成了所有常见的集群资源管理器，例如Hadoop YARN，但也可以设置作为独立集群甚至库运行。

Flink 运行时由两种类型的进程组成：一个 JobManager 和一个或者多个 TaskManager。

Client 不是运行时和程序执行的一部分，而是用于准备数据流并将其发送给 JobManager。之后，客户端可以断开连接（分离模式），或保持连接来接收进程报告（附加模式）。Client 可以作为触发执行 Java/Scala 程序的一部分运行，也可以在命令行进程./bin/flink run ...中运行。

可以通过多种方式启动 JobManager 和 TaskManager：直接在机器上作为standalone 集群启动、在容器中启动、或者通过YARN等资源框架管理并启动。TaskManager 连接到 JobManagers，宣布自己可用，并被分配工作。

| Component                                | Purpose                                                      | Implementations                                              |
| ---------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Flink Client                             | Flink 客户端将批处理或流应用程序编译成数据流图，然后将其提交给 JobManager。 | 命令行界面（Command Line Interface）、REST Endpoint、SQL Client、Python REPL、Scala REPL |
| JobManager                               | 作业管理器（JobManager）是 Flink 的中心工作协调组件的名称。它具有针对不同资源提供者的实现，这些实现在高可用性、资源分配行为和支持的作业提交模式方面有所不同。<br />JobManager 作业提交模式:<br />**Application Mode**: 专门为一个应用程序运行集群。作业的主要方法（或客户端）在 JobManager 上执行。支持在应用程序中多次调用 `execute`/`executeAsync`<br />**Per-Job Mode**: 专门为一项作业运行集群。作业的主要方法（或客户端）仅在集群创建之前运行。<br />**Session Mode**: 一个 JobManager 实例管理共享同一个 TaskManager 集群的多个作业 | Standalone、Kubernetes、YARN、Mesos                          |
| TaskManager                              | 任务管理器（TaskManagers）是实际执行 Flink job 的服务。      |                                                              |
| High Availability Service Provider       | Flink 的 JobManager 可以运行在高可用模式下，这使得 Flink 从 JobManager 故障中恢复。为了更快地进行故障转移，可以启动多个备用 JobManager 作为备份。 | Zookeeper、Kubernetes HA                                     |
| File Storage and Persistency             | 对于 检查点（checkpointing）（流作业的恢复机制），Flink 依赖于外部文件存储系统 |                                                              |
| Resource Provider                        | Flink 可以通过不同的资源提供者框架进行部署，例如 Kubernetes、YARN 或 Mesos。 |                                                              |
| Metrics Storage                          | Flink 组件报告内部指标（metrics），Flink 作业也可以报告额外的、作业（job）特定的的指标。 |                                                              |
| Application-level data sources and sinks | 虽然应用级数据源（sources）和接收器（sinks）在技术上不是 Flink 集群组件部署的一部分，但在规划新的 Flink 生产部署时应该考虑它们。 使用 Flink 托管常用数据可以带来显着的性能优势。 | Apache Kafka、Amazon S3、ElasticSearch、Apache Cassandra     |

#### JobManager
JobManager 具有许多与协调 Flink 应用程序的分布式执行有关的职责：它决定何时调度下一个 task（或一组 task）、对完成的 task 或执行失败做出反应、协调 checkpoint、并且协调从失败中恢复等等。这个进程由三个不同的组件组成：

**ResourceManager**

ResourceManager 负责 Flink 集群中的资源提供、回收、分配 - 它管理 task slots，这是 Flink 集群中资源调度的单位（请参考TaskManagers）。Flink 为不同的环境和资源提供者（例如 YARN、Kubernetes 和 standalone 部署）实现了对应的 ResourceManager。在 standalone 设置中，ResourceManager 只能分配可用 TaskManager 的 slots，而不能自行启动新的 TaskManager。

**Dispatcher**

Dispatcher 提供了一个 REST 接口，用来提交 Flink 应用程序执行，并为每个提交的作业启动一个新的 JobMaster。它还运行 Flink WebUI 用来提供作业执行信息。

**JobMaster**

JobMaster 负责管理单个JobGraph的执行。Flink 集群中可以同时运行多个作业，每个作业都有自己的 JobMaster。

始终至少有一个 JobManager。高可用（HA）设置中可能有多个 JobManager，其中一个始终是 leader，其他的则是 standby（请参考 高可用（HA））。

#### TaskManager
TaskManager（也称为 worker）执行作业流的 task，并且缓存和交换数据流。

必须始终至少有一个 TaskManager。在 TaskManager 中资源调度的最小单位是 task slot。TaskManager 中 task slot 的数量表示并发处理 task 的数量。请注意一个 task slot 中可以执行多个算子。

##### Tasks 和算子链
对于分布式执行，Flink 将算子的 subtasks 链接成 tasks。每个 task 由一个线程执行。将算子链接成 task 是个有用的优化：它减少线程间切换、缓冲的开销，并且减少延迟的同时增加整体吞吐量。链行为是可以配置的。

##### Task Slots 和资源
每个 worker（TaskManager）都是一个 JVM 进程，可以在单独的线程中执行一个或多个 subtask。为了控制一个 TaskManager 中接受多少个 task，就有了所谓的 task slots（至少一个）。

每个 task slot 代表 TaskManager 中资源的固定子集。例如，具有 3 个 slot 的 TaskManager，会将其托管内存 1/3 用于每个 slot。分配资源意味着 subtask 不会与其他作业的 subtask 竞争托管内存，而是具有一定数量的保留托管内存。注意此处没有 CPU 隔离；当前 slot 仅分离 task 的托管内存。

通过调整 task slot 的数量，用户可以定义 subtask 如何互相隔离。每个 TaskManager 有一个 slot，这意味着每个 task 组都在单独的 JVM 中运行（例如，可以在单独的容器中启动）。具有多个 slot 意味着更多 subtask 共享同一 JVM。同一 JVM 中的 task 共享 TCP 连接（通过多路复用）和心跳信息。它们还可以共享数据集和数据结构，从而减少了每个 task 的开销。

默认情况下，Flink 允许 subtask 共享 slot，即便它们是不同的 task 的 subtask，只要是来自于同一作业即可。结果就是一个 slot 可以持有整个作业管道。允许 slot 共享有两个主要优点：

- Flink 集群所需的 task slot 和作业中使用的最大并行度恰好一样。无需计算程序总共包含多少个 task（具有不同并行度）。
- 容易获得更好的资源利用。如果没有 slot 共享，非密集 subtask（source/map()）将阻塞和密集型 subtask（window） 一样多的资源。通过 slot 共享，增加基本并行度，充分利用分配的资源，同时确保繁重的 subtask 在 TaskManager 之间公平分配。

#### 其他

##### 基本模型
逻辑模型  && 物理模型（运行时）

逻辑模型可能有多个并发，实际的分布式流处理引擎更复杂，每个算子都可能有多个实例

假设： A B C三个算子，A source 有两个实例，C有两个实例，B 一个。在逻辑模型中，A和B是C的上游节点。而在对应的物理模型中，C的所有实例和A，B的所有实例之间可能都存在数据交换。

注： 在物理模型中，我们会根据计算逻辑，采用系统自动优化或认为指定的方式将计算工作分布到不同的实例中，只有当算子实例分布到不同进程时，才需要通过网络进行数据传输，而同一进程中的 多个实例之间的数据传输通常不需要经过网络的

Storm&& Flink 构建DAG计算逻辑图区别？

Storm需要在图中添加Spout或Bolt这种算子，并指定算子之前的连接方式
Flink的Api定义更加面向数据本身的处理逻辑：
    将数据抽象成一个无限集，然后定义一组集合上的操作，最后在底层自动构建相应的DAG图
区别：Storm更底层，自由度高 Flink的Api更上层，也更简单

##### Lambda架构

Lambda 架构用定期运行的批处理作业来实现应用程序的持续性，并通过流处理器获得预警。流处理器实时提供近似结果；批处理层最终会对近似结果予以纠正。

批处理架构很难解决乱序事件流问题。
批处理作业的界限不清晰，写死了。
假设需要根据产生数据的时间段（如从用户登录到退出）生成聚合结果，而不是简单地以小时为单位分割数据。


##### Kappa架构

用来解决lambda架构的不足，即更多的开发和运维工作。

lambda架构背景是流处理引擎还不完善，流处理的结果只作为临时的、近似的值提供参考。

Flink流处理引擎出现后，为了解决两套代码的问题，Kappa架构出现。

Kappa架构介绍：
    
- Kappa 架构可以认为是 Lambda 架构的简化版（只要移除 lambda 架构中的批处理部分即可）
- 在 Kappa 架构中，需求修改或历史数据重新处理都通过上游重放完成。
- Kappa 架构最大的问题是流式重新处理历史的吞吐能力会低于批处理，但这个可以通过增加计算资源来弥补。

调研：

flink可以保证计算的准确性，但是有一个前提是数据时准时到达的。
    
卡口过车数据 设备会因为网络延迟迟到几个小时，所以 Kappa架构不适合我们。

建议次日凌晨使用离线计算统计前天数据，替换实时表数据。


#### Flink 通信模型（Akka）

Flink客户端（JobClient）  JobManager（1）  TaskManager（N） 之间通信都是基于Akka actor模型

1. JobClient 从用户处获取到Flink job，提交给JobManager。
2. JobManager 负责这个job的执行：首先分配所需的（slot：CPU，内存）资源，即TaskManagers上要执行的slot
3. 获取到slot后，jobmanager 部署单独的任务到响应的TaskManager上。TaskManager产生一个线程来执行这个任务 
4. 状态改变时（开始计算，结束计算，每一次算子计算），状态会被发送回JobManager。基于这些状态的更新，JobManager将引导着个job执行完成
5. 一旦执行完，结果将会发送回JobClient。

##### JobManager 和 TaskManager

JobManager是核心控制单元，负责整个Flink Job，负责资源分配，任务调度和状态汇报

TaskManager

##### Flink Blob

JobManager-blob服务 ，也是在flink-conf.yaml文件中配置。接收jar包/发送jar包到Taskmanager，传输log文件

##### AM RM

Flink log中的 RM AM 指的是yarn上的一个ResourceManager 和若干个ApplicationMaster  指的是yarn的AM RM 通信
ApplicationMaster管理在yarn上运行的应用程序的每个实例
    同时负责协调来自 ResourceManager 的资源，并通过NodeManager监视容器的执行和资源使用 （CPU、内存等的资源分配）

#### Flink 应用程序执行

Flink 应用程序 是从其 main() 方法产生的一个或多个 Flink 作业的任何用户程序。这些作业的执行可以在本地 JVM（LocalEnvironment）中进行，或具有多台机器的集群的远程设置（RemoteEnvironment）中进行。对于每个程序，ExecutionEnvironment 提供了一些方法来控制作业执行（例如设置并行度）并与外界交互。

Flink 应用程序的作业可以被提交到长期运行的 Flink Session 集群、专用的 Flink Job 集群 或 Flink Application 集群。这些选项之间的差异主要与集群的生命周期和资源隔离保证有关。

##### Flink Session 集群

- 集群生命周期：在 Flink Session 集群中，客户端连接到一个预先存在的、长期运行的集群，该集群可以接受多个作业提交。即使所有作业完成后，集群（和 JobManager）仍将继续运行直到手动停止 session 为止。因此，Flink Session 集群的寿命不受任何 Flink 作业寿命的约束。
- 资源隔离：TaskManager slot 由 ResourceManager 在提交作业时分配，并在作业完成时释放。由于所有作业都共享同一集群，因此在集群资源方面存在一些竞争 — 例如提交工作阶段的网络带宽。此共享设置的局限性在于，如果 TaskManager 崩溃，则在此 TaskManager 上运行 task 的所有作业都将失败；类似的，如果 JobManager 上发生一些致命错误，它将影响集群中正在运行的所有作业。
- 其他注意事项：拥有一个预先存在的集群可以节省大量时间申请资源和启动 TaskManager。有种场景很重要，作业执行时间短并且启动时间长会对端到端的用户体验产生负面的影响 — 就像对简短查询的交互式分析一样，希望作业可以使用现有资源快速执行计算。

##### Flink Job 集群
- 集群生命周期：在 Flink Job 集群中，可用的集群管理器（例如 YARN）用于为每个提交的作业启动一个集群，并且该集群仅可用于该作业。在这里，客户端首先从集群管理器请求资源启动 JobManager，然后将作业提交给在这个进程中运行的 Dispatcher。然后根据作业的资源请求惰性的分配 TaskManager。一旦作业完成，Flink Job 集群将被拆除。
- 资源隔离：JobManager 中的致命错误仅影响在 Flink Job 集群中运行的一个作业。
- 其他注意事项：由于 ResourceManager 必须应用并等待外部资源管理组件来启动 TaskManager 进程和分配资源，因此 Flink Job 集群更适合长期运行、具有高稳定性要求且对较长的启动时间不敏感的大型作业。

Kubernetes 不支持 Flink Job 集群。

##### Flink Application 集群
- 集群生命周期：Flink Application 集群是专用的 Flink 集群，仅从 Flink 应用程序执行作业，并且 main()方法在集群上而不是客户端上运行。提交作业是一个单步骤过程：无需先启动 Flink 集群，然后将作业提交到现有的 session 集群；相反，将应用程序逻辑和依赖打包成一个可执行的作业 JAR 中，并且集群入口（ApplicationClusterEntryPoint）负责调用 main()方法来提取 JobGraph。例如，这允许你像在 Kubernetes 上部署任何其他应用程序一样部署 Flink 应用程序。因此，Flink Application 集群的寿命与 Flink 应用程序的寿命有关。
- 资源隔离：在 Flink Application 集群中，ResourceManager 和 Dispatcher 作用于单个的 Flink 应用程序，相比于 Flink Session 集群，它提供了更好的隔离。

Flink Job 集群可以看做是 Flink Application 集群”客户端运行“的替代方案。

### Flink API
Flink 为流式/批式处理应用程序的开发提供了不同级别的抽象。

- Flink API 最底层的抽象为有状态实时流处理。其抽象实现是 Process Function，并且 Process Function 被 Flink 框架集成到了 DataStream API 中来为我们使用。它允许用户在应用程序中自由地处理来自单流或多流的事件（数据），并提供具有全局一致性和容错保障的状态。此外，用户可以在此层抽象中注册事件时间（event time）和处理时间（processing time）回调方法，从而允许程序可以实现复杂计算。
- Flink API 第二层抽象是 Core APIs。实际上，许多应用程序不需要使用到上述最底层抽象的 API，而是可以使用 Core APIs 进行编程：其中包含 DataStream API（应用于有界/无界数据流场景）和 DataSet API（应用于有界数据集场景）两部分。Core APIs 提供的流式 API（Fluent API）为数据处理提供了通用的模块组件，例如各种形式的用户自定义转换（transformations）、联接（joins）、聚合（aggregations）、窗口（windows）和状态（state）操作等。此层 API 中处理的数据类型在每种编程语言中都有其对应的类。

  Process Function 这类底层抽象和 DataStream API 的相互集成使得用户可以选择使用更底层的抽象 API 来实现自己的需求。DataSet API 还额外提供了一些原语，比如循环/迭代（loop/iteration）操作。

- Flink API 第三层抽象是 Table API。Table API 是以表（Table）为中心的声明式编程（DSL）API，例如在流式数据场景下，它可以表示一张正在动态改变的表。Table API 遵循（扩展）关系模型：即表拥有 schema（类似于关系型数据库中的 schema），并且 Table API 也提供了类似于关系模型中的操作，比如 select、project、join、group-by 和 aggregate 等。Table API 程序是以声明的方式定义应执行的逻辑操作，而不是确切地指定程序应该执行的代码。尽管 Table API 使用起来很简洁并且可以由各种类型的用户自定义函数扩展功能，但还是比 Core API 的表达能力差。此外，Table API 程序在执行之前还会使用优化器中的优化规则对用户编写的表达式进行优化。

  表和 DataStream/DataSet 可以进行无缝切换，Flink 允许用户在编写应用程序时将 Table API 与 DataStream/DataSet API 混合使用。

- Flink API 最顶层抽象是 SQL。这层抽象在语义和程序表达式上都类似于 Table API，但是其程序实现都是 SQL 查询表达式。SQL 抽象与 Table API 抽象之间的关联是非常紧密的，并且 SQL 查询语句可以在 Table API 中定义的表上执行。

#### Flink Demo
```scala
// 第一步：构建环境
val streamEnv = StreamExecutionEnvironment.getExecutionEnvironment
streamEnv.setStreamTimeCharacteristic(TimeCharacteristic.EventTime)

// 第二步：添加数据源
val prop：Properties = new Properties()
prop.setProperty("bootstrap.servers"，kafkaProp.getProperty("bootstrap.servers"))
val consumer010= new FlinkKafkaConsumer010(kafkaProp.getProperty("source.topic")
                 ，new SimpleStringSchema()，prop)
consumer010.setStartFromLatest()
val dataStream = streamEnv.addSource(consumer010)
// 第三步：数据预处理
val outputStream = dataStream
  .map(x=>getRecord(x))
  .filter(！_._1.isEmpty)
  .map(x=>recordProcess(x)) 
// 第四步：设置时间戳和水印
  .assignTimestampsAndWatermarks(new TimestampExtractor(basicProp.getProperty("job.interval").toInt))
// 第五步：数据分组
  .keyBy(0)
// 第六步：指定时间窗口+聚合计算+输出格式
// 横向汇总： 通过打标签，在累加计算多个不同指标
    .timeWindow(Time.seconds(basicProp.getProperty("max.lagged.time").toInt))
    .reduce((v1，v2)=>(v1._1，v1._2，v1._3+v2._3，v1._4+v2._4))  
    .map(x=>toJson(x))
// 纵向汇总： 类似于单词计数和groupBy 
    .timeWindow(Time.minutes(5))
    .sum(1)
    .map(x=>toJson(x))
// 第七步：输出
outputStream.addSink(producer010)
// 第八步：执行flink
env.execute(basicProp.getProperty("application.name"))
```
注：Flink没有类似于Spark中foreach方法，让用户进行迭代的操作。所有对外的输出操作都要利用Sink完成。

#### Flink DataStream API

//1、设置运行环境
StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
    
//2、配置数据源读取数据   
DataStream<String> text = env.readTextFile("input");
    
//3、进行一系列转换
DataStream<Tuple2<String， Integer>> counts = text.flatMap(new Tokenizer()).keyBy(0).sum(1);
    
//4、配置数据汇写出数据
counts.writeAsText("output");
    
//5、提交执行
env.execute("Streaming WordCount");

上面实现一个流式的wordcount，首先需要获得一个StreamExecutionEnvironment对象（构建DAG图的上下文对象）
，基于这个对象，我们可以添加一些算子
1：使用了 Environment 对象中内置的读取文件算子readTextFile获取数据源，获取到DataStream对象，它可以看做是一个无限的数据集
2：调用flatMap将每一条数据记录（文件中的每一行）分解成单词，同时会在底层的DAG图中添加一个flatMap算子
3：得到的是处理过的单词的流，调用keyBy算子将流中的单词分组/分流，然后调用sum算子进行累计
4：计算出的结果形成一个新的流，调用writeAsText算子将结果写到文件中 
5：只有最终调用execute方法时，才会把DAG提供到集群中，接入数据并执行实际的逻辑
  前面调用所有算子并没有实际处理数据，而是在构建表达计算逻辑的DAG图。
注：整个代码实现过程就是一个构建DAG 图的过程，将算子加到DAG 中 输入 处理 输出


Flink DataStream API的核心就是代表流数据的DataStream对象，开发就是对DataStream对象进行操作

##### Rich Function
Rich Function有一个生命周期的概念：

open()方法是rich function的初始化方法，当一个算子例如map或者filter被调用之前open()会被调用
close()方法是生命周期中的最后一个调用的方法，做一些清理工作
getRuntimeContext()方法提供了函数的RuntimeContext的一些信息，例如函数执行的并行度，任务的名字，以及state状态


##### DataStream 操作分类
1：基于单条记录（filter，map） 
2：基于窗口（window）  
3：合并多条流（union，join，connect）  
4：拆分单条流（split）

第一类是对于单条记录的操作。比如筛除掉不符合要求的记录（Filter 操作），或者将每条记录都做一个转换（Map 操作）
第二类是对多条记录的操作。比如说统计一个小时内的订单总成交量。就需要将一个小时内的所有订单记录的成交量加到一起
                         为了支持这种类型的操作，就得通过 Window 将需要的记录关联到一起进行处理
第三类是对多个流进行操作并转换为单个流。比如 多个流可以通过 Union、Join 或 Connect等操作合到一起
                        这些操作合并的逻辑不同，但最终都会产生了一个新的统一的流，从而可以进行一些跨流的操作
第四类DataStream 还支持与合并对称的操作，就是把一个流按一定规则拆分为多个流（Split 操作）            
                        每个流是之前流的一个子集，这样我们就可以对不同的流作不同的处理

##### transformation

flink 常用转换算子：
map，flatMap，filter，keyBy，reduce，fold，aggregations，window，WindowAll，Union，Window join，Split，Select，Project

```scala
dataSource.map(getRecord(_))
  .filter(new FilterFunction[(String， String， String， Long)] {
      override def filter(t： (String， String， String， Long))： Boolean = {
          t._4 match {
              case t._4 if (t._4) > 20 => true
              case t._4 if (t._4) <= 20 => false
          }
      }
  })
  /*上下等同，相当于是源码中类似这样已经实现*/
  .filter(_._4>20)
```

map：数据清洗  简单ETL
flatmap：除了map操作 还可以一对多的输出 

调用filter算子()可以通过重写FilterFunction接口来实现 filter方法

##### 分布式转换算子

Random   随机数据交换由DataStream.shuffle()方法实现，shuffle方法将数据随机的分配到并行的任务中去
Round-Robin  一种负载均衡算法，可以将数据平均分配到并行的任务中去
Rescale  将数据发送到接下来的task slots中的一部分task slots中
Broadcast 将数据复制并发送到所有的并行任务中去
Global 将所有的数据都发送到下游算子的第一个并行任务中去
Custom 自定义

##### Flink 双流关联/转换

算子：coGroup join coflatmap

Join：只输出匹配成功的数据
CoGroup：无论是否匹配都会输出
CoFlatMap：没有匹配操作，只是分别接收两个流的输入

join，coGroup实现代码结构

```scala
val stream1 = ...
val stream2 = ...

stream1.join(stream2)
    .where(_._1).equalTo(_._1) //join的条件stream1中的某个字段和stream2中的字段值相等
    .window(...) // 指定window，stream1和stream2中的数据会进入到该window中。只有该window中的数据才会被后续操作join
    .apply((t1， t2， out： Collector[String]) => {
      out.collect(...) // 捕获到匹配的数据t1和t2，在这里可以进行组装等操作
    })
    .print()
```

##### parallelism && slot

parallelism 并行度 默认1。程序中设置 env.setParallelism(3); 这里设置的是全局的，包含下面执行的每一个算子。为每一个算子单独设置并行度： dataStream.map(new XxxMapFunction).setParallelism(5)  
优先级：算子设置并行度 > env 设置并行度 > 配置文件默认并行度 

eg：如果在代码中设置的是env.setParallelism(5)，flink-conf.yaml文件中默认为1(1.4) 发布上flink-cluster 上会使用5个slot 

slot：作用，是指taskmanager的并发执行能力，简单理解是将CPU和内存分成一个个逻辑单位，即slot。

Slot只对内存隔离，不对CPU隔离 CPU共享 
     
     
##### 数据流分组

keyBy 用于指定数据流是否进行分组
    需要在window函数前指定好，使用keyBy（...）可以将数据流拆分成逻辑分组的数据流
    如果不使用keyBy，你的数据流不是分组的
    分组数据流将你的window计算通过多任务并发执行，每一个逻辑分组流在执行中与其他的逻辑分组流是独立地进行的

在非分组的数据流中，你的原始数据并不会拆分成多个逻辑流并且所有的window逻辑都在一个任务中执行，并发度为1

KeyBy 起始就是对数据进行分区 


#### State 状态

state checkpoint time window 

Flink是有状态的计算！

是计算过程中的数据信息，在容错恢复和checkpoint中有重要作用

流计算在本质上是 增量处理 （Incremental Processing），因此需要不断查询保持状态

同时，为了保持精确一次（Exactly-once）语义，需要数据能写入到状态中

同时持久化存储，能够保证在整个分布式系统运行失败或挂掉的情况下做到Exactly- once


#### Time 时间
事件时间，摄取时间，处理时间
Flink的无限数据流是一个持续的过程，时间是我们判断业务状态是否滞后，数据处理是否及时的依据

Time && Watermark

Time 和 Watermark适用于时间驱动类的窗口 

分布式环境中Time，事件时间（Event-Time），摄取时间（Ingestion-Time），处理时间（Processing-Time）

Event-Time：数据产生的时间
Ingestion-Time：数据进入到flink的时间
Processing-Time：窗口开始计算的时间
    env.setStreamTimeCharacteristic（TimeCharacteristic.ProcessingTime）; 

Watermark： 解决乱序的问题
如何保证基于事件时间的窗口销毁时，flink已经处理完所有数据？
Watermark会携带一个单调递增的时间戳t，watermark（t）表示所有时间戳不大于t的都已经到来
未来小于t的数据不会到来，因此可以放心触发和销毁窗口

##### 迟到的数据 late elements
问题：watermater的时间不好设置 ：要么不正确 要么耗费太大 ，所以在设置watermark(t)之后，还有较小概率接收到时间戳（t）之前的数据，这部分称为 late elements

解决方式：指定允许延迟的最大时间（默认0） 
```scala
DataStream<T> input = ... ;
input
    .keyBy（<key selector>)
    .window（<window assigner>)
    .allowedLateness（<time>)
    .<windowed  transformation>（window function)
```
设置allowedLateness之后，迟到的数据同样可以触发窗口，进行计算

利用Flink的side output机制，我们可以获取到这些迟到的数据

```scala
final OutputTag<T>  lateOutputTag = new OutputTag[T]（"late-data"){};
DataStream<T> input = ... ;

SingleOutputStreamOperator<T> result = input
    .keyBy（<key selector>)
    .window（<window assigner>)
    .allowedLateness（<time>)
    .sideOutPutLateData（lateOutputTag)
    .<windowed  transformation>（window function)

DataStream<T> lateStream = result.getSideOutput（lateOutputTag);
```

设置allowedLateness之后，迟到的数据也可能触发窗口，如果使用的是Session window，可能会对窗口进行合并，产生预期外的行为

##### 流处理如何解释时间？
Time

Timer
定时器，作为window的触发源，分为两类：
    WallTime Timer：按照 正常的现实时间 作为触发源
    LowWatermark Timer：以 低水位 作为触发源 

low watermark ：最低水位

其实就是一个时间戳 ，每一个计算节点都会维护一个时间戳作为watermark
A的低水位值不只和A本身的最旧数据有关，也跟上游的低水位有关。
因此，只要上游还有更旧的数据存在，就会通过低水位机制维护的low watermark告知下游，
下游便会更新它自己的low watermark并且由于lwm timer未触发，因此会进行等待
    只要进入到flink中，当前窗口的 low watermark 一定是flink中所有数据中 属于这个window的最小的
在一定程度上保证数据的完整性和实效性，但是如果有数据比lowwatermark还晚到达仍没有办法解决
    比如：数据在没有进入流系统之前就耽搁了，那low watermark根本不知道
flink为了解决这个问题，还有allow lateness参数（等待时延）
    即Window被low watermark timer触发后，
    还会等待allow lateness时间才开始计算，但这样会损失一定的实时性

join：双流转换成单流
    coGroup+innerjoin

##### 水位线 watermark

水位线是衡量 Event Time 进展的机制，属于数据本身的隐藏属性。即，基于事件时间的数据本身除了事件发生时的时间戳A，还包含一个水位线时间戳B ！！！
，这条水位线用来表示在B时间戳之前的数据都已经到达！！

作用：水印是为了解决乱序问题的，解决乱序问题通常是水印+窗口来实现

watermark如何分配：
    
通常是在接收到source数据后，应该立刻生成水印 或者数据经过简单的map和filter之后 立刻生成watermark

两种生成方式：
    1：AssignerWithPeriodicWatermarks，定时抽取更新（允许定义一个最大延迟，比较常用 在用）
    2：AssignerWithPunctuatedWatermarks，每一次数据进来都会抽取timetamp并生成watermar，
        AssignerWithPunctuatedWatermarks 更精确，但是频繁的更新wartermark会比较影响性能

注：所以不要经常生成时间戳和水印，这样会加大系统的计算负担。水印必须跟窗口一起使用才有效。

source数据接入，map进入到自定义水印类，从EvenTime中抽取出水印时间。当包含隐藏属性的水位线+允许的最大延迟的数据到达时，窗口被触发计算。

上下游顺序： source-->map-->filter-->水印-->keyBy-->window-->reduce--->process-->sink

Flink如何处理乱序？

    watermark + window机制  ：Watermark是用于处理乱序事件的
    window中可以对input进行按照Event Time排序，使得完全按照Event Time发生的顺序去处理数据，以达到处理乱序数据的目的

Flink应该如何设置最大延迟时间？

    根据业务决定，如果延迟时间设置的太小，而数据因为网络传输的造成延迟太久
    就会出现很多单条数据在窗口中被触发，对数据准确性影响很大
当延迟及乱序很严重时，水位（等待时间）越小，被丢弃的可能性越大

#### Window 窗口
Flink 天然支持无限流数据处理的分布式计算框架，使用window将无限流切分成有限流，是处理有限流的核心组件。

数据流是无限的，无界限。 但是可以通过一个有界的范围来处理无界的数据流。

滚动窗口：每个界限计算结果互不影响（不重合） 比如几分钟统计一次

滑动窗口：每个计算窗口统计数据是有重复的  每30s统计过去一分钟的过车数量

简写： .timeWindow(Time.minutes(1), Time.seconds(5)) //一个参数是滚动，两个是滑动+滑动频率  窗口中时间的属性根据env配置决定

Window 中的三个核心组件：WindowAssigner、Trigger 和 Evictor 


Window 中怎么处理乱序数据， 乱序数据是否允许延迟， 以及怎么处理迟到的数据  ？
最后我们梳理了整个 Window 的数据流程， 以及 Window 中怎么保证 Exactly Once 语义  ？


窗口分类： 
    时间驱动timewindow，数据驱动countwindow
相关Api：[] 不强制使用，有默认值

keyed windows
  stream
    .keyBy(...)
    .window(...)
    [.trigger(...)]
    [.evictor(...)]
    [.allowedLateness(...)]
    [.sideOutPutLateData(...)]
    .reduce/aggregate/fold/apply()
    [.getSideOutput(...)]

non-keyed windows
  stream 
    .windowAll(...)
    [.trigger(...)]
    [.evictor(...)]
    [.allowedLateness(...)]
    [.sideOutPutLateData(...)]
    .reduce/aggregate/fold/apply()
    [.getSideOutput(...)]

dataStream ：
对于非KeyedStream，有timeWindowAll、countWindowAll、windowAll操作，其中最主要的是windowAll操作，它的parallelism为1，它需要一个WindowAssigner参数，返回的是AllWindowedStream

TimeWindowAll  不是并行的 所以slot只能用1 个，滚动窗口

KeyedStream： 通过keyBy将DataStream 转换成KeyedStream  对于KeyedStream除了继承了DataStream的window相关操作，它主要用的是timeWindow、countWindow、window操作，其中最主要的是window操作，它也需要一个WindowAssigner参数，返回的是WindowedStream

##### window的触发机制

先按照自然时间将window划分，30s窗口，1分钟分两个0-30，31-60

window的设定跟数据无关，是系统定义好的

1：input的数据，根据自身的Event Time将数据划分到不同的window中

2：如果窗口中有数据，且水印时间>=window_end_time时 触发窗口计算

最终决定触发的规则是数据本身的Event Time所在的window中的window_end_time决定


Flink何时触发window？

    1：Event Time < watermark时间 （对于延迟太久的数据而言）
    2：watermark >=window_end_time（对于无序及正常到达的数据而言）
      在[window_start_time, window_end_time]中有数据存在



##### Window API使用
WindowAssigner（窗口指定器）  Evictor（清除）   Trigger（触发） 

1：Window方法接收的输入是一个WindowAssigner，WindowAssigner负责将每条数据分发到正确的Window中（一条数据有可能会分发到多个窗口中）
几种通用的WindowAssigner：（tumbing window 滚动窗口 无重复 ，sliding window 滑动窗口 有重复，
                            session window 事件窗口，global window 全局窗口）
                            
自定义数据分发策略：新建一个class 继承WindowAssigner

2：Evictor 主要用于做一些数据的自定义操作，可选操作
CountEvictor 保留指定数量的元素
DeltaEvictor 通过执行用户给定的 DeltaFunction 以及预设的 threshold，判断是否删除一个元素
TimeEvictor 设定一个阈值 interval，删除所有不再 max_ts - interval 范围内的元素，其中 max_ts 是窗口内时间戳的最大值

3：Trigger 用来判断一个窗口是否需要被触发，每个 WindowAssigner 都自带一个默认的 Trigger
    允许自定义，继承 Trigger
    onElement() 每次往 window 增加一个元素的时候都会触发
    onEventTime() 当 event-time timer 被触发的时候会调用
    onProcessingTime() 当 processing-time timer 被触发的时候会调用
    onMerge() 对两个 trigger 的 state 进行 merge 操作
    clear() window 销毁的时候被调用
上面的接口中前三个会返回一个 TriggerResult
    CONTINUE 不做任何事情
    FIRE 触发 window
    PURGE 清空整个 window 的元素并销毁窗口
    FIRE_AND_PURGE 触发窗口，然后销毁窗口


flink触发当前窗口计算的前提是下一条数据的时间在当前窗口的结束时间之后


##### Trigger 触发器
触发器是决定某个窗口何时输出的一种机制
    作用跟照相机的快门相同，按下去，就能拿到某个时间点计算结果的快照
通过触发器，能多次看到某个窗口的输出结果。因此可以实现迟到数据（late event）的处理



##### Window 内部实现
每条过车数据进来后，会先由WindowAssigner 分配到对应的window（滚动/滑动..）

当window经过watermark被trigger后，会交给Evictor（如果没有设置 则跳过），然后处理UserFunction（用户处理的逻辑代码）

##### Window中状态存储
Flink 是支持 Exactly Once 处理语义的，那么 Window 中的状态存储和普通的状态存储又有什么不一样的地方呢？
A：从接口上可以认为没有区别，但是每个 Window 会属于不同的 namespace，
而非 Window 场景下，则都属于 VoidNamespace ，最终由 State/Checkpoint 来保证数据的 Exactly Once 语义
简单说：Window 中的的元素同样是通过 State 进行维护！！！ 然后由 Checkpoint 机制保证 Exactly Once 语义
Kafka Connector 也是在 Flink 中使用 Operator State 的一个示例：维护topic 分区和offset的映射到Operator State

##### flink 精确一次优势
Spark Streaming 的端到端 Exactly-once 需要下游支持幂等、上游支持流量重放，

Spark Streaming 这一层做到了 At-least-once，正常情况下数据不重不少，但在程序重启时可能会重发部分数据，为了实现全局的 Exactly-once，在下游做了去重逻辑

通过快照机制，Flink 获得了端到端数据一致性


##### 怎样判断是否是新用户
跟判断是否首次入城车一样，redis 缓存数据库 永不过期  数据流实时对比判断  

Flink 现在大部分开发属于实时汇总 ：  简单算子+业务函数+水印+分组+聚合+json格式输出

source  transformation  sink


#### Flink Sql API
流和动态表（Dynamic Table）的对偶（duality）性。

##### 流式SQL

SQL 声明式语言

批处理实例：
SELECT a.id FROM A a，B b WHERE a.id=b.id;   
    最简单的双流join，找出表A和表B中相同的id

两个经典的Join算法（归并连接 && 哈希连接）：
归并连接算法：拿到两表后，将id由小到大排好序，然后从前往后同时遍历两表
             一旦遇到相等的id就输出一条Join结果（1，排序2，合并及连接）
哈希连接算法：拿到两张表，对数据规模就行一个评估，然后选取较小一张表，以id作为key，以数据行作为value，建立哈希索引。
             接着便利另一张大表，对每一个id值到建立好的哈希索引中查找有没有id相等的数据行，有则Join输出
区别：哈希连接算法中，只需要将较小的一张表加载到内存
      归并连接算法，需要将两张表都加在到内存中
      

流式场景下的持续查询：

持续查询：没有外界干预的情况下，查询会一直输出结果，不会停止
由于数据流本身无穷，所以在上面的查询都是持续查询，每当有新数据的到来，可能都会有新的查询结果产生
    A B两张表双流Join ，表中数据不断增加，当A B存在相同id，才会生成相应的Join结果

问题：传统数据库允许对一张表进行全表扫描，但是流式场景却做不到

原因：1：我们无法确定下一条数据属于表A还是表B 2：流数据具有无尽性，找不到表的边界所以传统的归并连接跟哈希连接算法不适用于流式SQL


#### Flink state管理

按照数据划分和扩张方式：Keyed States   Operator States 

checkpoint：程序指定时间定期生成 ，保留当前时间的算子的状态

savepoint：Savepoint是指允许用户在持久化存储中保存某个checkpoint，以便用户可以暂停自己的任务进行升级。升级完后将任务状态设置为savepoint存储的状态开始恢复运行，保证数据处理的延续性。不管配置什么样flink都会从这个checkpoint恢复，常用于版本升级，保证了数据的延续性。

External Checkpoint：（外部checkpoint）做完一次checkpoint后在制定的目录中多存储一份checkpoint 保留meta数据 双备份 作业失败或取消状态结束时，外部存储的meta数据将保留下来。

##### State 和 checkpoint数据的存储方式
MemoryStateBackend

FsStateBackend

RockDBStateBackend

数据量小存储在 MemoryStateBackend 和 FsStateBackend中

数据量大  存储在RockDBStateBackend 中


##### 状态state和检查点checkpoint

How：最简单的wordcount，给一些word计算他们的count，count输出不断累加的结果，count就是状态批处理对state要求不高：之前的批处理都是将数据分片计算，分片完成后做一个聚合，state要求较少

流处理程序，输入的是一个无限制的数据流，会运行很大一段时间，要求运行几天，几个月都不会宕机，需要对中间的状态数据好好管理。storm采用的将状态数据存储到Hbase（计算时从hbase读，完了在更新到hbase，还需要保证数据一致性）

Flink提供了不同的状态后端机制，用于指定状态的存储方式和位置。

state可能会很大，ali的几T都有

参考：Chandy-Lamport算法
    
Flink是通过检查点的方式来实现 exactly-once 只执行一次，当遇到故障时将系统重置为初始状态

#### Flink savepoint
Savepoints 在持久化存储中保存某个 checkpoint，以便用户可以暂停自己的应用进行升级，并将状态设置为 savepoint 的状态，并继续运行。

该机制利用了 Flink 的 checkpoint 机制创建流应用的快照，并将快照的元数据（meta-data）写入到一个额外的持久化文件系统中。

1：每个算子需要id
手动设置UID
程序自动生成（跟应用结构算子有关）
建议手动给每个算子通过UID（String）分配一个固定的id

2：Savepoint产生的数据将被保
存到配置的文件系统中，如FsStateBackend或者RocksDBStateBackend

触发：
bin/flink savepoint jobId   路径[选，不写读flink-conf.yaml文件]

停止并触发：
bin/flink cancel -s [路径] jobId

3：从savepoint恢复作业：
bin/flink run -s savepointPath [runArgs]

允许不恢复某个算子的状态：
bin/flink run -s savepointPath -n [runArgs]
#默认情况下，系统会尝试恢复savepoint的状态全部映射到用户的流应用
如果代码有修改（删除某个算子），可以通过--allowNonRestoredState（简写-n）恢复状态

4：清除savepoint

bin/flink savepoint -d  savepointPath

查看hdfs上的checkpoint
hdfs dfs -ls /flink
hdfs dfs -ls /flink/checkpoints/
hdfs dfs -ls /flink/savepoint/

##### savepoint实测

生成savepoint： ok

bin/flink  savepoint -yid application_1572866255793_17760 8b08d32f2f0be5c5b6d064576768f20c

查看生成的savepoint：ok

hdfs dfs -ls /flink/savepoint/

取消job，并生成保存点，ok

bin/flink cancel  -yid application_1572866255793_17760 8b08d32f2f0be5c5b6d064576768f20c -savepoint hdfs：///flink/savepoint

启动job：接着保存点运行 ok

bin/flink run -s hdfs：///flink/savepoint/savepoint-8b08d3-c077f4bd59b0  -m yarn-cluster -yn 2 -yjm 1024 -ytm 2048 -yt test/ --class com.xxx.xxx.xxx.Kafka2Phoenix /opt/xxx/xxx/xxx/xxx-1.0.jar

后台运行：

nohup bin/flink run -s hdfs：///flink/savepoint/savepoint-8b08d3-c077f4bd59b0  -m yarn-cluster -yn 2 -yjm 1024 -ytm 2048 -yt test/ --class com.xxx.xxx.xxx.Kafka2Phoenix /opt/xxx/xxx/xxx/xxx-1.0.jar >/opt/xxx/xxx/xxx/xxx-1.0.log &

### Flink CLI
```shell
flink --help
```

./flink <ACTION> [OPTIONS] [ARGUMENTS]

##### flink run
``` 
Action "run" compiles and runs a program.

  Syntax: run [OPTIONS] <jar-file> <arguments>
  "run" action options:
     -c,--class <classname>               Class with the program entry point
                                          ("main()" method). Only needed if the
                                          JAR file does not specify the class in
                                          its manifest.
     -C,--classpath <url>                 Adds a URL to each user code
                                          classloader  on all nodes in the
                                          cluster. The paths must specify a
                                          protocol (e.g. file://) and be
                                          accessible on all nodes (e.g. by means
                                          of a NFS share). You can use this
                                          option multiple times for specifying
                                          more than one URL. The protocol must
                                          be supported by the {@link
                                          java.net.URLClassLoader}.
     -d,--detached                        If present, runs the job in detached
                                          mode
     -n,--allowNonRestoredState           Allow to skip savepoint state that
                                          cannot be restored. You need to allow
                                          this if you removed an operator from
                                          your program that was part of the
                                          program when the savepoint was
                                          triggered.
     -p,--parallelism <parallelism>       The parallelism with which to run the
                                          program. Optional flag to override the
                                          default value specified in the
                                          configuration.
     -py,--python <pythonFile>            Python script with the program entry
                                          point. The dependent resources can be
                                          configured with the `--pyFiles`
                                          option.
     -pyarch,--pyArchives <arg>           Add python archive files for job. The
                                          archive files will be extracted to the
                                          working directory of python UDF
                                          worker. Currently only zip-format is
                                          supported. For each archive file, a
                                          target directory be specified. If the
                                          target directory name is specified,
                                          the archive file will be extracted to
                                          a name can directory with the
                                          specified name. Otherwise, the archive
                                          file will be extracted to a directory
                                          with the same name of the archive
                                          file. The files uploaded via this
                                          option are accessible via relative
                                          path. '#' could be used as the
                                          separator of the archive file path and
                                          the target directory name. Comma (',')
                                          could be used as the separator to
                                          specify multiple archive files. This
                                          option can be used to upload the
                                          virtual environment, the data files
                                          used in Python UDF (e.g.: --pyArchives
                                          file:///tmp/py37.zip,file:///tmp/data.
                                          zip#data --pyExecutable
                                          py37.zip/py37/bin/python). The data
                                          files could be accessed in Python UDF,
                                          e.g.: f = open('data/data.txt', 'r').
     -pyexec,--pyExecutable <arg>         Specify the path of the python
                                          interpreter used to execute the python
                                          UDF worker (e.g.: --pyExecutable
                                          /usr/local/bin/python3). The python
                                          UDF worker depends on Python 3.5+,
                                          Apache Beam (version == 2.23.0), Pip
                                          (version >= 7.1.0) and SetupTools
                                          (version >= 37.0.0). Please ensure
                                          that the specified environment meets
                                          the above requirements.
     -pyfs,--pyFiles <pythonFiles>        Attach custom python files for job.
                                          The standard python resource file
                                          suffixes such as .py/.egg/.zip or
                                          directory are all supported. These
                                          files will be added to the PYTHONPATH
                                          of both the local client and the
                                          remote python UDF worker. Files
                                          suffixed with .zip will be extracted
                                          and added to PYTHONPATH. Comma (',')
                                          could be used as the separator to
                                          specify multiple files (e.g.:
                                          --pyFiles
                                          file:///tmp/myresource.zip,hdfs:///$na
                                          menode_address/myresource2.zip).
     -pym,--pyModule <pythonModule>       Python module with the program entry
                                          point. This option must be used in
                                          conjunction with `--pyFiles`.
     -pyreq,--pyRequirements <arg>        Specify a requirements.txt file which
                                          defines the third-party dependencies.
                                          These dependencies will be installed
                                          and added to the PYTHONPATH of the
                                          python UDF worker. A directory which
                                          contains the installation packages of
                                          these dependencies could be specified
                                          optionally. Use '#' as the separator
                                          if the optional parameter exists
                                          (e.g.: --pyRequirements
                                          file:///tmp/requirements.txt#file:///t
                                          mp/cached_dir).
     -s,--fromSavepoint <savepointPath>   Path to a savepoint to restore the job
                                          from (for example
                                          hdfs:///flink/savepoint-1537).
     -sae,--shutdownOnAttachedExit        If the job is submitted in attached
                                          mode, perform a best-effort cluster
                                          shutdown when the CLI is terminated
                                          abruptly, e.g., in response to a user
                                          interrupt, such as typing Ctrl + C.
  Options for Generic CLI mode:
     -D <property=value>   Allows specifying multiple generic configuration
                           options. The available options can be found at
                           https://ci.apache.org/projects/flink/flink-docs-stabl
                           e/ops/config.html
     -e,--executor <arg>   DEPRECATED: Please use the -t option instead which is
                           also available with the "Application Mode".
                           The name of the executor to be used for executing the
                           given job, which is equivalent to the
                           "execution.target" config option. The currently
                           available executors are: "remote", "local",
                           "kubernetes-session", "yarn-per-job", "yarn-session".
     -t,--target <arg>     The deployment target for the given application,
                           which is equivalent to the "execution.target" config
                           option. For the "run" action the currently available
                           targets are: "remote", "local", "kubernetes-session",
                           "yarn-per-job", "yarn-session". For the
                           "run-application" action the currently available
                           targets are: "kubernetes-application",
                           "yarn-application".

  Options for yarn-cluster mode:
     -d,--detached                        If present, runs the job in detached
                                          mode
     -m,--jobmanager <arg>                Set to yarn-cluster to use YARN
                                          execution mode.
     -yat,--yarnapplicationType <arg>     Set a custom application type for the
                                          application on YARN
     -yD <property=value>                 use value for given property
     -yd,--yarndetached                   If present, runs the job in detached
                                          mode (deprecated; use non-YARN
                                          specific option instead)
     -yh,--yarnhelp                       Help for the Yarn session CLI.
     -yid,--yarnapplicationId <arg>       Attach to running YARN session
     -yj,--yarnjar <arg>                  Path to Flink jar file
     -yjm,--yarnjobManagerMemory <arg>    Memory for JobManager Container with
                                          optional unit (default: MB)
     -ynl,--yarnnodeLabel <arg>           Specify YARN node label for the YARN
                                          application
     -ynm,--yarnname <arg>                Set a custom name for the application
                                          on YARN
     -yq,--yarnquery                      Display available YARN resources
                                          (memory, cores)
     -yqu,--yarnqueue <arg>               Specify YARN queue.
     -ys,--yarnslots <arg>                Number of slots per TaskManager
     -yt,--yarnship <arg>                 Ship files in the specified directory
                                          (t for transfer)
     -ytm,--yarntaskManagerMemory <arg>   Memory per TaskManager Container with
                                          optional unit (default: MB)
     -yz,--yarnzookeeperNamespace <arg>   Namespace to create the Zookeeper
                                          sub-paths for high availability mode
     -z,--zookeeperNamespace <arg>        Namespace to create the Zookeeper
                                          sub-paths for high availability mode

  Options for default mode:
     -D <property=value>             Allows specifying multiple generic
                                     configuration options. The available
                                     options can be found at
                                     https://ci.apache.org/projects/flink/flink-
                                     docs-stable/ops/config.html
     -m,--jobmanager <arg>           Address of the JobManager to which to
                                     connect. Use this flag to connect to a
                                     different JobManager than the one specified
                                     in the configuration. Attention: This
                                     option is respected only if the
                                     high-availability configuration is NONE.
     -z,--zookeeperNamespace <arg>   Namespace to create the Zookeeper sub-paths
                                     for high availability mode
```

##### flink run-application
```
Action "run-application" runs an application in Application Mode.

  Syntax: run-application [OPTIONS] <jar-file> <arguments>
  Options for Generic CLI mode:
     -D <property=value>   Allows specifying multiple generic configuration
                           options. The available options can be found at
                           https://ci.apache.org/projects/flink/flink-docs-stabl
                           e/ops/config.html
     -e,--executor <arg>   DEPRECATED: Please use the -t option instead which is
                           also available with the "Application Mode".
                           The name of the executor to be used for executing the
                           given job, which is equivalent to the
                           "execution.target" config option. The currently
                           available executors are: "remote", "local",
                           "kubernetes-session", "yarn-per-job", "yarn-session".
     -t,--target <arg>     The deployment target for the given application,
                           which is equivalent to the "execution.target" config
                           option. For the "run" action the currently available
                           targets are: "remote", "local", "kubernetes-session",
                           "yarn-per-job", "yarn-session". For the
                           "run-application" action the currently available
                           targets are: "kubernetes-application",
                           "yarn-application".
```

##### flink info
```
Action "info" shows the optimized execution plan of the program (JSON).

  Syntax: info [OPTIONS] <jar-file> <arguments>
  "info" action options:
     -c,--class <classname>           Class with the program entry point
                                      ("main()" method). Only needed if the JAR
                                      file does not specify the class in its
                                      manifest.
     -p,--parallelism <parallelism>   The parallelism with which to run the
                                      program. Optional flag to override the
                                      default value specified in the
                                      configuration.
```

##### flink list
```

Action "list" lists running and scheduled programs.

  Syntax: list [OPTIONS]
  "list" action options:
     -a,--all         Show all programs and their JobIDs
     -r,--running     Show only running programs and their JobIDs
     -s,--scheduled   Show only scheduled programs and their JobIDs
  Options for Generic CLI mode:
     -D <property=value>   Allows specifying multiple generic configuration
                           options. The available options can be found at
                           https://ci.apache.org/projects/flink/flink-docs-stabl
                           e/ops/config.html
     -e,--executor <arg>   DEPRECATED: Please use the -t option instead which is
                           also available with the "Application Mode".
                           The name of the executor to be used for executing the
                           given job, which is equivalent to the
                           "execution.target" config option. The currently
                           available executors are: "remote", "local",
                           "kubernetes-session", "yarn-per-job", "yarn-session".
     -t,--target <arg>     The deployment target for the given application,
                           which is equivalent to the "execution.target" config
                           option. For the "run" action the currently available
                           targets are: "remote", "local", "kubernetes-session",
                           "yarn-per-job", "yarn-session". For the
                           "run-application" action the currently available
                           targets are: "kubernetes-application",
                           "yarn-application".

  Options for yarn-cluster mode:
     -m,--jobmanager <arg>            Set to yarn-cluster to use YARN execution
                                      mode.
     -yid,--yarnapplicationId <arg>   Attach to running YARN session
     -z,--zookeeperNamespace <arg>    Namespace to create the Zookeeper
                                      sub-paths for high availability mode

  Options for default mode:
     -D <property=value>             Allows specifying multiple generic
                                     configuration options. The available
                                     options can be found at
                                     https://ci.apache.org/projects/flink/flink-
                                     docs-stable/ops/config.html
     -m,--jobmanager <arg>           Address of the JobManager to which to
                                     connect. Use this flag to connect to a
                                     different JobManager than the one specified
                                     in the configuration. Attention: This
                                     option is respected only if the
                                     high-availability configuration is NONE.
     -z,--zookeeperNamespace <arg>   Namespace to create the Zookeeper sub-paths
                                     for high availability mode

```

##### flink stop
```
Action "stop" stops a running program with a savepoint (streaming jobs only).

  Syntax: stop [OPTIONS] <Job ID>
  "stop" action options:
     -d,--drain                           Send MAX_WATERMARK before taking the
                                          savepoint and stopping the pipelne.
     -p,--savepointPath <savepointPath>   Path to the savepoint (for example
                                          hdfs:///flink/savepoint-1537). If no
                                          directory is specified, the configured
                                          default will be used
                                          ("state.savepoints.dir").
  Options for Generic CLI mode:
     -D <property=value>   Allows specifying multiple generic configuration
                           options. The available options can be found at
                           https://ci.apache.org/projects/flink/flink-docs-stabl
                           e/ops/config.html
     -e,--executor <arg>   DEPRECATED: Please use the -t option instead which is
                           also available with the "Application Mode".
                           The name of the executor to be used for executing the
                           given job, which is equivalent to the
                           "execution.target" config option. The currently
                           available executors are: "remote", "local",
                           "kubernetes-session", "yarn-per-job", "yarn-session".
     -t,--target <arg>     The deployment target for the given application,
                           which is equivalent to the "execution.target" config
                           option. For the "run" action the currently available
                           targets are: "remote", "local", "kubernetes-session",
                           "yarn-per-job", "yarn-session". For the
                           "run-application" action the currently available
                           targets are: "kubernetes-application",
                           "yarn-application".

  Options for yarn-cluster mode:
     -m,--jobmanager <arg>            Set to yarn-cluster to use YARN execution
                                      mode.
     -yid,--yarnapplicationId <arg>   Attach to running YARN session
     -z,--zookeeperNamespace <arg>    Namespace to create the Zookeeper
                                      sub-paths for high availability mode

  Options for default mode:
     -D <property=value>             Allows specifying multiple generic
                                     configuration options. The available
                                     options can be found at
                                     https://ci.apache.org/projects/flink/flink-
                                     docs-stable/ops/config.html
     -m,--jobmanager <arg>           Address of the JobManager to which to
                                     connect. Use this flag to connect to a
                                     different JobManager than the one specified
                                     in the configuration. Attention: This
                                     option is respected only if the
                                     high-availability configuration is NONE.
     -z,--zookeeperNamespace <arg>   Namespace to create the Zookeeper sub-paths
                                     for high availability mode

```

##### flink cancel
```
Action "cancel" cancels a running program.

  Syntax: cancel [OPTIONS] <Job ID>
  "cancel" action options:
     -s,--withSavepoint <targetDirectory>   **DEPRECATION WARNING**: Cancelling
                                            a job with savepoint is deprecated.
                                            Use "stop" instead.
                                            Trigger savepoint and cancel job.
                                            The target directory is optional. If
                                            no directory is specified, the
                                            configured default directory
                                            (state.savepoints.dir) is used.
  Options for Generic CLI mode:
     -D <property=value>   Allows specifying multiple generic configuration
                           options. The available options can be found at
                           https://ci.apache.org/projects/flink/flink-docs-stabl
                           e/ops/config.html
     -e,--executor <arg>   DEPRECATED: Please use the -t option instead which is
                           also available with the "Application Mode".
                           The name of the executor to be used for executing the
                           given job, which is equivalent to the
                           "execution.target" config option. The currently
                           available executors are: "remote", "local",
                           "kubernetes-session", "yarn-per-job", "yarn-session".
     -t,--target <arg>     The deployment target for the given application,
                           which is equivalent to the "execution.target" config
                           option. For the "run" action the currently available
                           targets are: "remote", "local", "kubernetes-session",
                           "yarn-per-job", "yarn-session". For the
                           "run-application" action the currently available
                           targets are: "kubernetes-application",
                           "yarn-application".

  Options for yarn-cluster mode:
     -m,--jobmanager <arg>            Set to yarn-cluster to use YARN execution
                                      mode.
     -yid,--yarnapplicationId <arg>   Attach to running YARN session
     -z,--zookeeperNamespace <arg>    Namespace to create the Zookeeper
                                      sub-paths for high availability mode

  Options for default mode:
     -D <property=value>             Allows specifying multiple generic
                                     configuration options. The available
                                     options can be found at
                                     https://ci.apache.org/projects/flink/flink-
                                     docs-stable/ops/config.html
     -m,--jobmanager <arg>           Address of the JobManager to which to
                                     connect. Use this flag to connect to a
                                     different JobManager than the one specified
                                     in the configuration. Attention: This
                                     option is respected only if the
                                     high-availability configuration is NONE.
     -z,--zookeeperNamespace <arg>   Namespace to create the Zookeeper sub-paths
                                     for high availability mode

```

##### flink savepoint
```
Action "savepoint" triggers savepoints for a running job or disposes existing ones.

  Syntax: savepoint [OPTIONS] <Job ID> [<target directory>]
  "savepoint" action options:
     -d,--dispose <arg>       Path of savepoint to dispose.
     -j,--jarfile <jarfile>   Flink program JAR file.
  Options for Generic CLI mode:
     -D <property=value>   Allows specifying multiple generic configuration
                           options. The available options can be found at
                           https://ci.apache.org/projects/flink/flink-docs-stabl
                           e/ops/config.html
     -e,--executor <arg>   DEPRECATED: Please use the -t option instead which is
                           also available with the "Application Mode".
                           The name of the executor to be used for executing the
                           given job, which is equivalent to the
                           "execution.target" config option. The currently
                           available executors are: "remote", "local",
                           "kubernetes-session", "yarn-per-job", "yarn-session".
     -t,--target <arg>     The deployment target for the given application,
                           which is equivalent to the "execution.target" config
                           option. For the "run" action the currently available
                           targets are: "remote", "local", "kubernetes-session",
                           "yarn-per-job", "yarn-session". For the
                           "run-application" action the currently available
                           targets are: "kubernetes-application",
                           "yarn-application".

  Options for yarn-cluster mode:
     -m,--jobmanager <arg>            Set to yarn-cluster to use YARN execution
                                      mode.
     -yid,--yarnapplicationId <arg>   Attach to running YARN session
     -z,--zookeeperNamespace <arg>    Namespace to create the Zookeeper
                                      sub-paths for high availability mode

  Options for default mode:
     -D <property=value>             Allows specifying multiple generic
                                     configuration options. The available
                                     options can be found at
                                     https://ci.apache.org/projects/flink/flink-
                                     docs-stable/ops/config.html
     -m,--jobmanager <arg>           Address of the JobManager to which to
                                     connect. Use this flag to connect to a
                                     different JobManager than the one specified
                                     in the configuration. Attention: This
                                     option is respected only if the
                                     high-availability configuration is NONE.
     -z,--zookeeperNamespace <arg>   Namespace to create the Zookeeper sub-paths
                                     for high availability mode
                                     
```

### Flink 部署
Flink 是一个多功能框架，以混搭方式支持许多不同的部署场景。

如果你只是想在本地启动 Flink，建议设置一个 Standalone Cluster。

#### 配置
```yaml conf/flink-conf.yaml
#==============================================================================
# Hosts and Ports
#==============================================================================

# 自动发现功能： Yarn, Mesos, Kubernetes 
# jobmanager.rpc.address: localhost
#jobmanager.rpc.port: 6123
#rest.port: 8081
# rest.address: 0.0.0.0
#rest.bind-port: "8081"
# rest.bind-address: 0.0.0.0
#taskmanager.data.port: 0
# taskmanager.host:
#taskmanager.rpc.port: "0"
#metrics.internal.query-service.port: "0"

#==============================================================================
# Others
#==============================================================================

# 每台机器的可用 CPU 数
taskmanager.numberOfTaskSlots: 1

# 集群中所有 CPU 数
parallelism.default: 1



#==============================================================================
# Jobmanager
#==============================================================================

jobmanager.archive.fs.dir: (none)
jobmanager.execution.attempts-history-size: 16
jobmanager.execution.failover-strategy: "region"
# 'full': Restarts all tasks to recover the job.
# 'region': Restarts all tasks that could be affected by the task failure.
jobmanager.retrieve-taskmanager-hostname: true
jobmanager.rpc.address: (none)
jobmanager.rpc.port: 6123

jobmanager.memory.enable-jvm-direct-memory-limit: false 
jobmanager.memory.flink.size: (none)
jobmanager.memory.heap.size: (none)  
jobmanager.memory.jvm-metaspace.size: 
jobmanager.memory.jvm-overhead.fraction: 0.1
jobmanager.memory.jvm-overhead.max: 1 gb
jobmanager.memory.jvm-overhead.min: 192 mb
jobmanager.memory.off-heap.size: 128 mb
#jobmanager.memory.process.size: (none)
# 每个 JobManager 的可用内存值，单位是 MB
# JobManager (JobMaster / ResourceManager / Dispatcher)
jobmanager.memory.process.size: 1600m

jobstore.cache-size: 52428800
jobstore.expiration-time: 3600
jobstore.max-capacity: 2147483647

blob.client.connect.timeout: 0
blob.client.socket.timeout: 300000
blob.fetch.backlog: 1000
blob.fetch.num-concurrent: 50
blob.fetch.retries: 5
blob.offload.minsize: 1048576
blob.server.port: "0"
blob.service.cleanup.interval: 3600
blob.service.ssl.enabled: true
blob.storage.directory: (none)

resourcemanager.job.timeout: "5 minutes"
resourcemanager.rpc.port: 0
resourcemanager.standalone.start-up-time: -1
resourcemanager.taskmanager-timeout: 30000

slotmanager.number-of-slots.max: 2147483647
slotmanager.redundant-taskmanager-num: 0

#==============================================================================
# TaskManager
#==============================================================================

#taskmanager.memory.flink.size: (none)
#taskmanager.memory.framework.heap.size: 128 mb
#taskmanager.memory.framework.off-heap.size: 128 mb
#taskmanager.memory.jvm-metaspace.size: 256 mb
#taskmanager.memory.jvm-overhead.fraction: 0.1
#taskmanager.memory.jvm-overhead.max: 1 gb
#taskmanager.memory.jvm-overhead.min: 192 mb
#taskmanager.memory.managed.consumer-weights: DATAPROC:70,PYTHON:30
#taskmanager.memory.managed.fraction: 0.4
#taskmanager.memory.managed.size: (none)
#taskmanager.memory.network.fraction: 0.1
#taskmanager.memory.network.max: 1 gb
#taskmanager.memory.network.min: 64 mb
#taskmanager.memory.process.size: (none)
# 每个 TaskManager 的可用内存值，单位是 MB
# TaskManager ()
taskmanager.memory.process.size: 1728m
# taskmanager.memory.flink.size: 1280m
#taskmanager.memory.task.heap.size: (none)
#taskmanager.memory.task.off-heap.size: 0 bytes

task.cancellation.interval: 30000
task.cancellation.timeout: 180000
task.cancellation.timers.timeout: 7500
taskmanager.data.port: 0
taskmanager.data.ssl.enabled: true
taskmanager.debug.memory.log: false
taskmanager.debug.memory.log-interval: 5000
taskmanager.host: (none)
taskmanager.jvm-exit-on-oom: false
taskmanager.memory.segment-size: 32 kb
taskmanager.network.bind-policy: "ip"
# "name" - uses hostname as binding address
# "ip" - uses host's ip address as binding address
taskmanager.numberOfTaskSlots: 1
taskmanager.registration.timeout: 5 min
taskmanager.resource-id: (none)
taskmanager.rpc.port: "0"

taskmanager.network.blocking-shuffle.compression.enabled: false
taskmanager.network.blocking-shuffle.type: "file"
taskmanager.network.detailed-metrics: false
taskmanager.network.memory.buffers-per-channel: 2
taskmanager.network.memory.floating-buffers-per-gate: 8
taskmanager.network.memory.max-buffers-per-channel: 10
taskmanager.network.netty.client.connectTimeoutSec: 120
taskmanager.network.netty.client.numThreads: -1
taskmanager.network.netty.num-arenas: -1
taskmanager.network.netty.sendReceiveBufferSize: 0
taskmanager.network.netty.server.backlog: 0
taskmanager.network.netty.server.numThreads: -1
taskmanager.network.netty.transport: "auto"
taskmanager.network.request-backoff.initial: 100
taskmanager.network.request-backoff.max: 10000
taskmanager.network.retries: 0
taskmanager.network.sort-shuffle.min-buffers: 64
taskmanager.network.sort-shuffle.min-parallelism: 2147483647  

#==============================================================================
# RPC / Akka
#==============================================================================

akka.ask.callstack: true
akka.ask.timeout: "10 s"
akka.client-socket-worker-pool.pool-size-factor: 1.0
akka.client-socket-worker-pool.pool-size-max: 2
akka.client-socket-worker-pool.pool-size-min: 1
akka.fork-join-executor.parallelism-factor: 2.0
akka.fork-join-executor.parallelism-max: 64
akka.fork-join-executor.parallelism-min: 8
akka.framesize: "10485760b"
akka.jvm-exit-on-fatal-error: true
akka.log.lifecycle.events: false
akka.lookup.timeout: "10 s"
akka.retry-gate-closed-for: 50
akka.server-socket-worker-pool.pool-size-factor: 1.0
akka.server-socket-worker-pool.pool-size-max: 2
akka.server-socket-worker-pool.pool-size-min: 1
akka.ssl.enabled: true
akka.startup-timeout: (none)
akka.tcp.timeout: "20 s"
akka.throughput: 15
akka.transport.heartbeat.interval: "1000 s"
akka.transport.heartbeat.pause: "6000 s"
akka.transport.threshold: 300.0

#==============================================================================
# Metrics
#==============================================================================

#metrics.fetcher.update-interval: 10000
#metrics.internal.query-service.port: "0"
#metrics.internal.query-service.thread-priority: 1
#metrics.latency.granularity: "operator"
# Accepted values are:
# single - Track latency without differentiating between sources and subtasks.
# operator - Track latency while differentiating between sources, but not subtasks.
# subtask - Track latency while differentiating between sources and subtasks.

#metrics.latency.history-size: 128
#metrics.latency.interval: 0
#metrics.reporter.<name>.<parameter>: (none)
#metrics.reporter.<name>.class: (none)
metrics.reporter.prom.class: org.apache.flink.metrics.prometheus.PrometheusReporter
#metrics.reporter.<name>.interval: 10 s
#metrics.reporters: (none)
#metrics.scope.delimiter: "."
#metrics.scope.jm: "<host>.jobmanager"
#metrics.scope.jm.job: "<host>.jobmanager.<job_name>"
#metrics.scope.operator: "<host>.taskmanager.<tm_id>.<job_name>.<operator_name>.<subtask_index>"
#metrics.scope.task: "<host>.taskmanager.<tm_id>.<job_name>.<task_name>.<subtask_index>"
#metrics.scope.tm: "<host>.taskmanager.<tm_id>"
#metrics.scope.tm.job: "<host>.taskmanager.<tm_id>.<job_name>"
#metrics.system-resource: false
#metrics.system-resource-probing-interval: 5000

#==============================================================================
# High Availability
#==============================================================================

#high-availability: none
#high-availability.cluster-id: "/default"
#high-availability.storageDir:
#high-availability.jobmanager.port: "0"

# high-availability: zookeeper
# high-availability.storageDir: hdfs:///flink/ha/
# high-availability.zookeeper.quorum: localhost:2181
# high-availability.zookeeper.client.acl: open
# high-availability.zookeeper.path.root: "/flink"
#high-availability.zookeeper.client.connection-timeout: 15000
#high-availability.zookeeper.client.max-retry-attempts: 3
#high-availability.zookeeper.client.retry-wait: 5000
#high-availability.zookeeper.client.session-timeout: 60000
#high-availability.zookeeper.path.checkpoint-counter: "/checkpoint-counter"
#high-availability.zookeeper.path.checkpoints: "/checkpoints"
#high-availability.zookeeper.path.jobgraphs: "/jobgraphs"
#high-availability.zookeeper.path.latch: "/leaderlatch"
#high-availability.zookeeper.path.leader: "/leader"
#high-availability.zookeeper.path.mesos-workers: "/mesos-workers"
#high-availability.zookeeper.path.running-registry: "/running_job_registry/"

#high-availability.kubernetes.leader-election.lease-duration: 15 s
#high-availability.kubernetes.leader-election.renew-deadline: 15 s
#high-availability.kubernetes.leader-election.retry-period: 5 s

#==============================================================================
# Fault tolerance
#==============================================================================

cluster.io-pool.size: (none)
cluster.registration.error-delay: 10000
cluster.registration.initial-timeout: 100
cluster.registration.max-timeout: 30000
cluster.registration.refused-registration-delay: 30000
cluster.services.shutdown-timeout: 30000
heartbeat.interval: 10000
heartbeat.timeout: 50000
jobmanager.execution.failover-strategy: region

# none, off, disable: No restart strategy.
# fixeddelay, fixed-delay: Fixed delay restart strategy.
# failurerate, failure-rate: Failure rate restart strategy.
#restart-strategy: none
restart-strategy.fixed-delay.attempts: 1
restart-strategy.fixed-delay.delay: 1 s
restart-strategy.failure-rate.delay: 1 s
restart-strategy.failure-rate.failure-rate-interval: 1 min
restart-strategy.failure-rate.max-failures-per-interval: 1

#==============================================================================
# Checkpoints and State Backends
#==============================================================================

#state.backend: filesystem # 'jobmanager', 'filesystem', 'rocksdb', or the <class-name-of-factory>.
state.backend: com.alibaba.flink.statebackend.GeminiStateBackendFactory
#state.checkpoints.dir: hdfs://namenode-host:port/flink-checkpoints
state.checkpoints.dir: hdfs://emr-header-1.cluster-247301:9000/flink/flink-checkpoints/
#state.savepoints.dir: hdfs://namenode-host:port/flink-savepoints
#state.backend.incremental: false
#state.backend.local-recovery: false
#state.checkpoints.num-retained: 1
#taskmanager.state.local.root-dirs: 

#state.backend.async: true
#state.backend.fs.memory-threshold: 20 kb
#state.backend.fs.write-buffer-size: 4096
state.backend.fs.checkpointdir: hdfs://emr-header-1.cluster-247301:9000/flink/flink-checkpoints/

#state.backend.rocksdb.memory.fixed-per-slot: (none)
#state.backend.rocksdb.memory.high-prio-pool-ratio: 0.1
#state.backend.rocksdb.memory.managed: true
#state.backend.rocksdb.memory.write-buffer-ratio: 0.5
#state.backend.rocksdb.timer-service.factory: ROCKSDB # [HEAP, ROCKSDB]
#state.backend.rocksdb.checkpoint.transfer.thread.num: 1
#state.backend.rocksdb.localdir: (none)
#state.backend.rocksdb.options-factory: "org.apache.flink.contrib.streaming.state.DefaultConfigurableOptionsFactory"
#state.backend.rocksdb.predefined-options: "DEFAULT"

#state.backend.rocksdb.block.blocksize: (none)
#state.backend.rocksdb.block.cache-size: (none)
#state.backend.rocksdb.compaction.level.max-size-level-base: (none)
#state.backend.rocksdb.compaction.level.target-file-size-base: (none)
#state.backend.rocksdb.compaction.level.use-dynamic-size: (none)
#state.backend.rocksdb.compaction.style: (none) # Possible values: [LEVEL, UNIVERSAL, FIFO]
#state.backend.rocksdb.files.open: (none)
#state.backend.rocksdb.thread.num: (none)
#state.backend.rocksdb.write-batch-size: 2 mb
#state.backend.rocksdb.writebuffer.count: (none)
#state.backend.rocksdb.writebuffer.number-to-merge: (none)
#state.backend.rocksdb.writebuffer.size: (none)

#state.backend.rocksdb.metrics.actual-delayed-write-rate: false
#state.backend.rocksdb.metrics.background-errors: false
#state.backend.rocksdb.metrics.block-cache-capacity: false
#state.backend.rocksdb.metrics.block-cache-pinned-usage: false
#state.backend.rocksdb.metrics.block-cache-usage: false
#state.backend.rocksdb.metrics.column-family-as-variable: false
#state.backend.rocksdb.metrics.compaction-pending: false
#state.backend.rocksdb.metrics.cur-size-active-mem-table: false
#state.backend.rocksdb.metrics.cur-size-all-mem-tables: false
#state.backend.rocksdb.metrics.estimate-live-data-size: false
#state.backend.rocksdb.metrics.estimate-num-keys: false
#state.backend.rocksdb.metrics.estimate-pending-compaction-bytes: false
#state.backend.rocksdb.metrics.estimate-table-readers-mem: false
#state.backend.rocksdb.metrics.is-write-stopped: false
#state.backend.rocksdb.metrics.mem-table-flush-pending: false
#state.backend.rocksdb.metrics.num-deletes-active-mem-table: false
#state.backend.rocksdb.metrics.num-deletes-imm-mem-tables: false
#state.backend.rocksdb.metrics.num-entries-active-mem-table: false
#state.backend.rocksdb.metrics.num-entries-imm-mem-tables: false
#state.backend.rocksdb.metrics.num-immutable-mem-table: false
#state.backend.rocksdb.metrics.num-live-versions: false
#state.backend.rocksdb.metrics.num-running-compactions: false
#state.backend.rocksdb.metrics.num-running-flushes: false
#state.backend.rocksdb.metrics.num-snapshots: false
#state.backend.rocksdb.metrics.size-all-mem-tables: false
#state.backend.rocksdb.metrics.total-sst-files-size: false

#==============================================================================
# Rest & web frontend
#==============================================================================

#rest.port: 8081
# rest.address: 0.0.0.0
# rest.bind-port: 8080-8090
# rest.bind-address: 0.0.0.0

#rest.await-leader-timeout: 30000
#rest.client.max-content-length: 104857600
#rest.connection-timeout: 15000
#rest.idleness-timeout: 300000
#rest.retry.delay: 3000
#rest.retry.max-attempts: 20
#rest.server.max-content-length: 104857600
#rest.server.numThreads: 4
#rest.server.thread-priority: 5

#web.access-control-allow-origin: "*"
#web.backpressure.cleanup-interval: 600000
#web.backpressure.delay-between-samples: 50
#web.backpressure.num-samples: 100
#web.backpressure.refresh-interval: 60000
#web.checkpoints.history: 10
#web.history: 5
#web.log.path: (none)
#web.refresh-interval: 3000
#web.submit.enable: true
#web.timeout: 600000
#web.tmpdir: System.getProperty("java.io.tmpdir")
#web.upload.dir: (none)

#==============================================================================
# Advanced
#==============================================================================

fs.allowed-fallback-filesystems: (none)
fs.default-scheme: (none)
# 临时目录 'LOCAL_DIRS' on Yarn. '_FLINK_TMP_DIR' on Mesos. System.getProperty("java.io.tmpdir") in standalone.
# io.tmp.dirs: /tmp

#classloader.check-leaked-classloader: true
#classloader.fail-on-metaspace-oom-error: true
#classloader.parent-first-patterns.additional: (none)
#classloader.parent-first-patterns.default: "java.;scala.;org.apache.flink.;com.esotericsoftware.kryo;org.apache.hadoop.;javax.annotation.;org.slf4j;org.apache.log4j;org.apache.logging;org.apache.commons.logging;ch.qos.logback;org.xml;javax.xml;org.apache.xerces;org.w3c"
#classloader.resolve-order: "child-first"

# taskmanager.memory.network.fraction: 0.1
# taskmanager.memory.network.min: 64mb
# taskmanager.memory.network.max: 1gb

cluster.processes.halt-on-fatal-error: false

cluster.evenly-spread-out-slots: false
slot.idle.timeout: 50000
slot.request.timeout: 300000
slotmanager.number-of-slots.max: 2147483647

#jmx.server.port: (none)

#==============================================================================
# JVM and Logging Options
#==============================================================================

env.hadoop.conf.dir: (none)
env.hbase.conf.dir: (none)
env.java.opts: (none)
env.java.opts.client: (none)
env.java.opts.historyserver: (none)
env.java.opts.jobmanager: (none)
env.java.opts.taskmanager: (none)
env.log.dir: (none)
env.log.max: 5
env.ssh.opts: (none)
env.yarn.conf.dir: (none)

#==============================================================================
# Flink Cluster Security Configuration
#==============================================================================

#security.kerberos.login.use-ticket-cache: true
# security.kerberos.login.keytab: /path/to/kerberos/keytab
# security.kerberos.login.principal: flink-user
# security.kerberos.login.contexts: Client,KafkaClient

#security.ssl.algorithms: "TLS_RSA_WITH_AES_128_CBC_SHA"

#security.ssl.internal.cert.fingerprint: (none)
#security.ssl.internal.enabled: false
#security.ssl.internal.key-password: (none)
#security.ssl.internal.keystore: (none)
#security.ssl.internal.keystore-password: (none)
#security.ssl.internal.truststore: (none)
#security.ssl.internal.truststore-password: (none)

#security.ssl.internal.close-notify-flush-timeout: -1
#security.ssl.internal.handshake-timeout: -1
#security.ssl.internal.session-cache-size: -1
#security.ssl.internal.session-timeout: -1

#security.ssl.provider: "JDK"
#security.ssl.protocol: "TLSv1.2"

#security.ssl.rest.authentication-enabled: false
#security.ssl.rest.cert.fingerprint: (none)
#security.ssl.rest.enabled: false
#security.ssl.rest.key-password: (none)
#security.ssl.rest.keystore: (none)
#security.ssl.rest.keystore-password: (none)
#security.ssl.rest.truststore: (none)
#security.ssl.rest.truststore-password: (none)

#security.ssl.verify-hostname: true

#==============================================================================
# ZK Security Configuration
#==============================================================================

#zookeeper.sasl.disable: false
# zookeeper.sasl.service-name: zookeeper
# zookeeper.sasl.login-context-name: Client

#==============================================================================
# HistoryServer
#==============================================================================

#jobmanager.archive.fs.dir: hdfs:///completed-jobs/
jobmanager.archive.fs.dir: hdfs://emr-header-1.cluster-247301:9000/flink/flink-jobs/

#historyserver.archive.fs.dir: hdfs:///completed-jobs/
#historyserver.archive.fs.refresh-interval: 10000
#historyserver.archive.clean-expired-jobs: false
#historyserver.archive.retained-jobs: -1

# historyserver.web.address: 0.0.0.0
#historyserver.web.port: 8082
#historyserver.web.refresh-interval: 10000
#historyserver.web.ssl.enabled: false
#historyserver.web.tmpdir: (none)
historyserver.web.tmpdir: /mnt/disk1/flink/history-server/tmp

#==============================================================================
# Queryable State
#==============================================================================

#queryable-state.client.network-threads: 0
#queryable-state.enable: false
#queryable-state.proxy.network-threads: 0
#queryable-state.proxy.ports: "9069"
#queryable-state.proxy.query-threads: 0
#queryable-state.server.network-threads: 0
#queryable-state.server.ports: "9067"
#queryable-state.server.query-threads: 0

```

##### YARN 相关配置
```yaml
external-resource.<resource_name>.yarn.config-key: (none)
yarn.application-attempt-failures-validity-interval: 10000
yarn.application-attempts: (none)
yarn.application-master.port: "0"
yarn.application.id: (none)
yarn.application.name: (none)
yarn.application.node-label: (none)
yarn.application.priority: -1
yarn.application.queue: (none)
yarn.application.type: (none)
yarn.appmaster.vcores: 1
yarn.containers.vcores: -1
yarn.file-replication: -1
yarn.flink-dist-jar: (none)
yarn.heartbeat.container-request-interval: 500
yarn.heartbeat.interval: 5
yarn.per-job-cluster.include-user-jar: "ORDER"
yarn.properties-file.location: (none)
yarn.provided.lib.dirs: (none)
yarn.security.kerberos.additionalFileSystems: (none)
yarn.security.kerberos.localized-keytab-path: "krb5.keytab"
yarn.security.kerberos.ship-local-keytab: true
yarn.ship-archives: (none) # ".tar.gz", ".tar", ".tgz", ".dst", ".jar", ".zip".
yarn.ship-files: (none)
yarn.staging-directory: (none)
yarn.tags: (none)
```

##### K8S 相关配置
```yaml
external-resource.<resource_name>.kubernetes.config-key: (none)
kubernetes.client.io-pool.size: 4
kubernetes.cluster-id: (none)
kubernetes.config.file: (none)
kubernetes.container-start-command-template: "%java% %classpath% %jvmmem% %jvmopts% %logging% %class% %args%"
kubernetes.container.image: # The default value depends on the actually running version. In general it looks like "flink:<FLINK_VERSION>-scala_<SCALA_VERSION>"
kubernetes.container.image.pull-policy: IfNotPresent # Possible values: [IfNotPresent, Always, Never]
kubernetes.container.image.pull-secrets: (none)
kubernetes.context: (none)
kubernetes.entry.path: "/docker-entrypoint.sh"
kubernetes.env.secretKeyRef: (none)
kubernetes.flink.conf.dir: "/opt/flink/conf"
kubernetes.flink.log.dir: "/opt/flink/log"
kubernetes.hadoop.conf.config-map.name: (none)
kubernetes.jobmanager.annotations: (none)
kubernetes.jobmanager.cpu: 1.0
kubernetes.jobmanager.labels: (none)
kubernetes.jobmanager.node-selector: (none)
kubernetes.jobmanager.owner.reference: (none)
kubernetes.jobmanager.service-account: (none)
kubernetes.jobmanager.tolerations: (none)
kubernetes.namespace: "default"
kubernetes.rest-service.annotations: (none)
kubernetes.rest-service.exposed.type: LoadBalancer # Possible values: [ClusterIP, NodePort, LoadBalancer]
kubernetes.secrets: (none)
kubernetes.service-account: "default"
kubernetes.taskmanager.annotations: (none)
kubernetes.taskmanager.cpu: -1.0
kubernetes.taskmanager.labels: (none)
kubernetes.taskmanager.node-selector: (none)
kubernetes.taskmanager.service-account: (none)
kubernetes.taskmanager.tolerations: (none)
kubernetes.transactional-operation.max-retries: 5
```

##### mesos 相关配置
```yaml
mesos.failover-timeout: 604800
mesos.master: (none)
host:port: zk://host1:port1,host2:port2,.../path
# zk://username:password@host1:port1,host2:port2,.../path
# file:///path/to/file
mesos.resourcemanager.artifactserver.port: 0
mesos.resourcemanager.artifactserver.ssl.enabled: true
mesos.resourcemanager.declined-offer-refuse-duration: 5000
mesos.resourcemanager.framework.name: "Flink"
mesos.resourcemanager.framework.principal: (none)
mesos.resourcemanager.framework.role: "*"
mesos.resourcemanager.framework.secret: (none)
mesos.resourcemanager.framework.user: (none)
mesos.resourcemanager.tasks.port-assignments: (none)
mesos.resourcemanager.unused-offer-expiration: 120000

# Mesos TaskManager

mesos.constraints.hard.hostattribute: (none)
mesos.resourcemanager.network.resource.name: "network"
mesos.resourcemanager.tasks.bootstrap-cmd: (none)
mesos.resourcemanager.tasks.container.docker.force-pull-image: false
mesos.resourcemanager.tasks.container.docker.parameters: (none)
mesos.resourcemanager.tasks.container.image.name: (none)
mesos.resourcemanager.tasks.container.type: "mesos"
mesos.resourcemanager.tasks.container.volumes: (none)
mesos.resourcemanager.tasks.cpus: 0.0
mesos.resourcemanager.tasks.disk: 0
mesos.resourcemanager.tasks.gpus: 0
mesos.resourcemanager.tasks.hostname: (none)
mesos.resourcemanager.tasks.network.bandwidth: 0
mesos.resourcemanager.tasks.taskmanager-cmd: "$FLINK_HOME/bin/mesos-taskmanager.sh"  
mesos.resourcemanager.tasks.uris: (none)
```

#### 部署模式

Flink 可以通过以下三种方式之一执行应用程序：应用模式（Application Mode）、单任务模式（Per-Job Mode）、会话模式（Session Mode）。

上述模式的区别在于：

- 集群生命周期和资源隔离保证。
- 应用程序的main()方法是在客户端还是在集群上执行。

在会话模式下，集群生命周期独立于集群上运行的任何作业的生命周期，并且资源在所有作业之间共享。在每个作业方式支付旋转起来为每个提交的作业集群的价格，但这种带有更好的隔离保证的资源不能跨岗位共享。在这种情况下，集群的生命周期与作业的生命周期绑定。最后，Application Mode为每个应用程序创建一个会话集群，并main() 在集群上执行应用程序的方法。

##### 应用模式

在所有其他模式中，应用程序的main()方法在客户端执行。此过程包括在本地下载应用程序的依赖项，执行main()以提取 Flink 的运行时可以理解的应用程序表示（即JobGraph），并将依赖项和JobGraph(s)传送到集群。这使得客户端成为大量资源消耗者，因为它可能需要大量网络带宽来下载依赖项并将二进制文件发送到集群，并且需要 CPU 周期来执行 main(). 当客户端在用户之间共享时，这个问题会更加明显。

基于这个观察，Application Mode为每个提交的应用程序创建一个集群，但这一次，main()应用程序的方法是在 JobManager 上执行的。为每个应用程序创建一个集群可以看作是创建一个仅在特定应用程序的作业之间共享的会话集群，并在应用程序完成时拆除。使用这种架构，应用程序模式提供与Per-Job模式相同的资源隔离和负载平衡保证，但以整个应用程序的粒度。执行main()在 JobManager 上允许节省所需的 CPU 周期，但也节省了本地下载依赖项所需的带宽。此外，它允许更均匀地分布网络负载以下载集群中应用程序的依赖项，因为每个应用程序有一个 JobManager。

注意：在应用模式下，main()在集群上执行，而不是客户端上执行。这可能会对您的代码产生影响，例如，您在环境中使用注册的任何路径都registerCachedFile()必须可由应用程序的 JobManager 访问。

与Per-Job模式相比，Application Mode允许提交由多个作业组成的应用程序。作业执行的顺序不受部署模式的影响，而是受用于启动作业的调用的影响。使用execute()阻塞，建立一个顺序，它将导致“下一个”作业的执行被推迟，直到“这个”作业完成。使用executeAsync()非阻塞，将导致“下一个”作业在“此”作业完成之前开始。

注意：应用模式允许多execute()应用，但在这些情况下不支持高可用性。应用程序模式下的高可用性仅支持单一execute()应用程序。

##### 单任务模式
Per-Job模式旨在提供更好的资源隔离保证，使用可用的资源提供者框架（例如 YARN、Kubernetes）为每个提交的作业启动一个集群。此集群仅可用于该作业。作业完成后，集群将被拆除并清除所有遗留资源（文件等）。这提供了更好的资源隔离，因为行为不当的作业只能降低其自己的 TaskManager。此外，它将簿记负载分散到多个 JobManager 中，因为每个作业有一个。由于这些原因，Per-Job资源分配模型是许多生产原因的首选模式。

##### 会话模式
会话模式假设一个已经在运行的集群并使用该集群的资源来执行任何提交的应用程序。在同一（会话）集群中执行的应用程序使用并因此竞争相同的资源。这样做的好处是您无需为每个提交的作业支付启动完整集群的资源开销。但是，如果其中一个作业行为不当或关闭了 TaskManager，那么在该 TaskManager 上运行的所有作业都将受到故障的影响。除了对导致失败的作业的负面影响之外，这还意味着潜在的大规模恢复过程，所有重新启动的作业同时访问文件系统并使其对其他服务不可用。此外，让单个集群运行多个作业意味着 JobManager 的负载更大，

#### Standalone Cluster

##### 配置

- 默认配置支持启动单节点 Flink 会话集群，无需任何更改。
- Flink 需要 master 和所有 worker 节点设置 JAVA_HOME 环境变量，并指向你的 Java 安装目录。
- 设置 jobmanager.rpc.address 配置项指向 master 节点。
- Flink 目录必须放在所有 worker 节点的相同目录下。你可以使用共享的 NFS 目录，或将 Flink 目录复制到每个 worker 节点上。

```yaml conf/flink-conf.yaml
# 配置JAVA_HOME
env.java.home

jobmanager.rpc.address: localhost
jobmanager.rpc.port: 6123

jobmanager.memory.process.size: 1600m
taskmanager.memory.process.size: 1728m

taskmanager.numberOfTaskSlots: 1

parallelism.default: 1

jobmanager.execution.failover-strategy: region

# io.tmp.dirs: /tmp
# web.upload.dir: /data/flink/jars
```

```bash
bin/start-cluster.sh # 开启 Standalone Cluster
bin/stop-cluster.sh # 关闭 Standalone Cluster

# 添加 JobManager
bin/jobmanager.sh ((start|start-foreground) [host] [webui-port])|stop|stop-all

# 添加 TaskManager
bin/taskmanager.sh start|start-foreground|stop|stop-all

```

##### Enable High-Availability with Standalone
```yaml conf/flink-conf.yaml
high-availability: zookeeper
high-availability.zookeeper.quorum: localhost:2181
high-availability.zookeeper.path.root: /flink
high-availability.cluster-id: /cluster_one # important: customize per cluster
high-availability.storageDir: hdfs:///flink/recovery
```

```txt conf/masters
# jobManagerAddress:webUIPort
localhost:8081
localhost:8082
```

```cfg conf/zoo.cfg
server.0=localhost:2888:3888
```

```bash
# Start ZooKeeper quorum
$ bin/start-zookeeper-quorum.sh
Starting zookeeper daemon on host localhost.

# Start an HA-cluster
$ bin/start-cluster.sh
Starting HA cluster with 2 masters and 1 peers in ZooKeeper quorum.
Starting standalonesession daemon on host localhost.
Starting standalonesession daemon on host localhost.
Starting taskexecutor daemon on host localhost.

# Stop ZooKeeper quorum and cluster:
$ bin/stop-cluster.sh
Stopping taskexecutor daemon (pid: 7647) on localhost.
Stopping standalonesession daemon (pid: 7495) on host localhost.
Stopping standalonesession daemon (pid: 7349) on host localhost.
$ bin/stop-zookeeper-quorum.sh
Stopping zookeeper daemon (pid: 7101) on host localhost.
```

#### Flink On Yarn
Apache Hadoop YARN是一种受许多数据处理框架欢迎的资源提供程序。Flink 服务提交给 YARN 的 ResourceManager，后者在由 YARN NodeManagers 管理的机器上生成容器。Flink 将其 JobManager 和 TaskManager 实例部署到此类容器中。

Flink 可以根据在 JobManager 上运行的作业所需的处理槽数动态分配和取消分配 TaskManager 资源。

flink发布命令并没有指定yarn 怎么就在yarn上运行了？

配置一个容器 yarn-session，再发布一个flink程序会自动找到 JobManager address（如果创建容器的时间和程序发布的时间间隔太久 会抛找不到 jobManager address 的异常）使用 -yid 可以指定 flink 程序发布到 yarn cluster 集群上运行。

flink on yarn  运行方式 1：Session 模式  2：Per-job Cluster 模式 3：Application 模式

##### 配置

```yaml conf/flink-conf.yaml
#==============================================================================
# Common
#==============================================================================


#==============================================================================
# High Availability
#==============================================================================
# high-availability: zookeeper
# high-availability.storageDir: hdfs:///flink/ha/
# high-availability.zookeeper.quorum: localhost:2181
# high-availability.zookeeper.client.acl: open

#==============================================================================
# Fault tolerance and checkpointing
#==============================================================================

#state.backend: filesystem
#state.checkpoints.dir: hdfs://namenode-host:port/flink-checkpoints
#state.savepoints.dir: hdfs://namenode-host:port/flink-savepoints
#state.backend.incremental: false

state.backend.fs.checkpointdir: hdfs://emr-header-1.cluster-247301:9000/flink/flink-checkpoints/
state.backend: com.alibaba.flink.statebackend.GeminiStateBackendFactory

#==============================================================================
# Rest & web frontend
#==============================================================================

#rest.port: 8081
#rest.address: 0.0.0.0
#rest.bind-port: 8080-8090
#rest.bind-address: 0.0.0.0
#web.submit.enable: false

#==============================================================================
# Advanced
#==============================================================================

# 临时目录
# io.tmp.dirs: /tmp
# classloader.resolve-order: child-first
# classloader.resolve-order: parent-first
# taskmanager.memory.network.fraction: 0.1
# taskmanager.memory.network.min: 64mb
# taskmanager.memory.network.max: 1gb
taskmanager.network.memory.max: 1gb
taskmanager.network.memory.fraction: 0.1
taskmanager.network.memory.min: 64mb


#==============================================================================
# Flink Cluster Security Configuration
#==============================================================================

# security.kerberos.login.use-ticket-cache: true
# security.kerberos.login.keytab: /path/to/kerberos/keytab
# security.kerberos.login.principal: flink-user
# security.kerberos.login.contexts: Client,KafkaClient

#==============================================================================
# ZK Security Configuration
#==============================================================================

# zookeeper.sasl.service-name: zookeeper
# zookeeper.sasl.login-context-name: Client

#==============================================================================
# HistoryServer
#==============================================================================

#jobmanager.archive.fs.dir: hdfs:///completed-jobs/
#historyserver.web.address: 0.0.0.0
#historyserver.web.port: 8082
#historyserver.archive.fs.dir: hdfs:///completed-jobs/
#historyserver.archive.fs.refresh-interval: 10000
historyserver.web.tmpdir: /mnt/disk1/flink/history-server/tmp
historyserver.web.port: 8082
historyserver.archive.fs.refresh-interval: 10000

jobmanager.archive.fs.dir: hdfs://emr-header-1.cluster-247301:9000/flink/flink-jobs/

```

##### Session 模式

Seesion模式会根据您设置的资源参数创建一个Flink集群，所有作业都将被提交到这个集群上运行。该集群在作业运行结束之后不会自动释放。

例如，某个作业发生异常，导致一个Task Manager关闭，则其他所有运行在该Task Manager上的作业都会失败。另外由于同一个集群中只有一个Job Manager，随着作业数量的增多，Job Manager的压力会相应增加。

优点：提交作业时，资源分配导致的时间开销相比其他模式较小。

缺点：由于所有作业都运行在该集群中，会存在对资源的竞争以及作业间的相互影响。

根据以上特点，该模式适合部署需要较短启动时间且运行时间相对较短的作业。

```bash
# If HADOOP_CLASSPATH is not set:
#   export HADOOP_CLASSPATH=`hadoop classpath`
nohup bin/yarn-session.sh \
--queue xxxxx \
--container 12 \
--jobManagerMemory 10240 \
--taskManagerMemory 20480 \
--slots 10 \
--ship test/ \
>/opt/xxxxx/flink-cluster/log/yarn-session.log 2>&1 &

nohup bin/flink run \
-yid application_1563070919166_1815 \
-p 6 \
--class com.xxxxx.xxxxx.xxxxx.FakeVehicle \
/opt/xxxxx/xxxxx.jar \
>/opt/xxxxx/log/xxxxx.log 2>&1 &

# (0) export HADOOP_CLASSPATH
export HADOOP_CLASSPATH=`hadoop classpath`

# (1) Start YARN Session
./bin/yarn-session.sh --detached

# (2) You can now access the Flink Web Interface through the URL printed in the last lines of the command output, or through the YARN ResourceManager web UI.

# (3) Submit example job
./bin/flink run ./examples/streaming/TopSpeedWindowing.jar

# List running job on the cluster
./bin/flink list -t yarn-session -Dyarn.application.id=<application_XXXX_YY>

# Cancel running job
# (4) Stop YARN session (replace the application id based on the output of the yarn-session.sh command)
echo "stop" | ./bin/yarn-session.sh -id application_XXXXX_XXX
```

会话模式有两种操作模式：

- 附加模式（默认）：yarn-session.sh客户端将 Flink 集群提交给 YARN，但客户端保持运行，跟踪集群的状态。如果集群失败，客户端将显示错误。如果客户端被终止，它也会通知集群关闭。
- 分离模式（-d或--detached）：yarn-session.sh客户端将Flink集群提交给YARN，然后客户端返回。需要再次调用客户端或 YARN 工具来停止 Flink 集群。

会话模式将创建一个隐藏的 YARN 属性文件/tmp/.yarn-properties-<username>，提交作业时将通过命令行界面获取该文件以进行集群发现。

您也可以在提交 Flink 作业时在命令行界面中手动指定目标 YARN 集群。下面是一个例子：
```bash
./bin/flink run -t yarn-session -Dyarn.application.id=application_XXXX_YY ./examples/streaming/TopSpeedWindowing.jar

# 您可以使用以下命令重新附加到 YARN 会话：
./bin/yarn-session.sh -id application_XXXX_YY
```
除了通过配置通过conf/flink-conf.yaml文件，你也可以通过在提交时任何配置到./bin/yarn-session.sh使用客户端-Dkey=value的参数。

YARN 会话客户端还有一些常用设置的“快捷参数”。它们可以用 列出./bin/yarn-session.sh -h。

```
Usage:
   Required
     -n,--container <arg>   Number of YARN container to allocate (=Number of Task Managers)
   Optional
     -at,--applicationType <arg>     Set a custom application type for the application on YARN
     -D <property=value>             use value for given property
     -d,--detached                   If present, runs the job in detached mode
     -h,--help                       Help for the Yarn session CLI.
     -id,--applicationId <arg>       Attach to running YARN session
     -j,--jar <arg>                  Path to Flink jar file
     -jm,--jobManagerMemory <arg>    Memory for JobManager Container with optional unit (default: MB)
     -m,--jobmanager <arg>           Set to yarn-cluster to use YARN execution mode.
     -nl,--nodeLabel <arg>           Specify YARN node label for the YARN application
     -nm,--name <arg>                Set a custom name for the application on YARN
     -q,--query                      Display available YARN resources (memory, cores)
     -qu,--queue <arg>               Specify YARN queue.
     -s,--slots <arg>                Number of slots per TaskManager
     -t,--ship <arg>                 Ship files in the specified directory (t for transfer)
     -tm,--taskManagerMemory <arg>   Memory per TaskManager Container with optional unit (default: MB)
     -yd,--yarndetached              If present, runs the job in detached mode (deprecated; use non-YARN specific option instead)
     -z,--zookeeperNamespace <arg>   Namespace to create the Zookeeper sub-paths for high availability mode
```

##### Per-job Cluster 模式

当使用Per-Job Cluster模式时，每次提交一个Flink作业，YARN都会为这个作业新启动一个Flink集群，然后运行该作业。当作业运行结束或者被取消时，该作业所属的Flink集群也会被释放。

优点：作业之间资源隔离，一个作业的异常行为不会影响到其他作业。因为每个作业都和一个Job Manager一一对应，因此不会出现一个Job Manager因为运行多个Job而导致负载过高的问题。

缺点：每次运行一个作业都要启动一个专属Flink集群，启动作业的开销更大。

根据以上特点，该模式通常适合运行时间较长的作业。

```bash
# --detached参数，一旦提交被接受，客户端就会停止。
./bin/flink run -t yarn-per-job --detached /usr/lib/flink-current/examples/streaming/TopSpeedWindowing.jar

# List running job on the cluster
./bin/flink list -t yarn-per-job -Dyarn.application.id=<application_XXXX_YY>

# Cancel running job
./bin/flink cancel -t yarn-per-job -Dyarn.application.id=application_XXXX_YY <jobId>
```

##### Application 模式

当使用Application模式时，每次提交一个Flink Application（一个Application包含一个或多个作业），YARN都会为这个Application新启动一个Flink集群。当Application运行结束或者被取消时，该Application所属的Flink集群也会被释放。

该模式与Per-Job模式不同的是，Application对应的JAR包中的main()方法会在集群中的Job Manager中被执行。

如果提交的JAR包中包含多个作业，则这些作业都会在该Application所属的集群中执行。

优点：可以减轻客户端提交作业时的负担。

缺点：每次运行一个Flink Application都要启动一个专属Flink集群，启动Application的时间开销会更大。

```bash
./bin/flink run-application -t yarn-application /usr/lib/flink-current/examples/streaming/TopSpeedWindowing.jar

# List running job on the cluster
./bin/flink list -t yarn-application -Dyarn.application.id=<application_XXXX_YY>

# Cancel running job
./bin/flink cancel -t yarn-application -Dyarn.application.id=application_XXXX_YY <jobId>
```

要释放Application模式的全部潜力，请考虑将其与yarn.provided.lib.dirs配置选项一起使用，并将您的应用程序 jar 预先上传到集群中所有节点都可以访问的位置。在这种情况下，命令可能如下所示：
```bash
./bin/flink run-application -t yarn-application \
  -Dyarn.provided.lib.dirs="hdfs://myhdfs/my-remote-flink-dist-dir" \
  hdfs://myhdfs/jars/my-application.jar
```
由于所需的 Flink jar 和应用程序 jar 将由指定的远程位置获取，而不是由客户端运送到集群，因此上述将允许作业提交更加轻量级。


### Flink 应用

1. 实时智能推荐
2. 复杂事件处理
3. 实时欺诈检测
4. 实时数仓与ETL
5. 流数据分析
6. 实时报表分析
7. 监控平台

实时ETL：实时消费Kafka数据进行清洗、转换、结构化处理用于下游计算处理。
实时数仓：实时化数据计算，仓库模型加工和存储。实时分析业务及用户各类指标，让运营更加实时化。
实时监控：对系统和用户行为进行实时检测和分析，如业务指标实时监控，运维线上稳定性监控，金融风控等。

基于交通卡口数据的实时计算

实时分析： 路段/区域/全市/卡口/进出城/公交专用道流量  
          路段/区域/全市拥堵
          在途车辆归属地分析
          点位高频车分析
实时预警： 套牌车/突变流量/突发拥堵
实时ETL：  实时抽取 卡口过车数据关键字段
          实时抽取 违法尾号限行车辆
          实时更新每辆车车辆轨迹

注：公司数据服务化，都是通过服务的方式对外提供数据
    排行类的数据现在是在查询层phoenix做的
    没有热点数据top10的功能 
    做的是基础数据，5/1分钟/30s算一次，接口拿去做趋势图

改进：在状态中进行排序输出   ListState
eg： ... DataStream-->KeyedStream-->DataStream
    .timeWindow(Time.minutes(1), Time.seconds(5))
    .aggregate(new CountAgg(), new WinResultFunction())
    .keyBy("windowEnd")
    .process(new TopNHotItems(3)) 

#### 实时计算应用场景

在大数据系统中，离线批处理技术可以满足非常多的数据使用场景需求，但是在DT时代，每天面对的信息是瞬息万变的，越来越多的应用场景对 数据的时效性提出更高的要求。数据是价值是具有效性的：一条数据产生的时候，如果不能及时处理并在业务系统中使用，就不能让数据保持最高的'新鲜度'和价值最大化。


##### 实时ETL

实时ETL&数据流的目的是实时的把数据从A点投递到B点。中间可能会加上一些数据清洗和集成的工作，比如实时构建搜索系统的索引，实时数仓中的ETL过程等eg：尾号限行（对违反限行车辆进行初步筛选，再进行汇总）   车辆轨迹（将一辆车一天轨迹拼接成一条，时间列表 点位列表 过车间隔列表）


##### 实时数据分析（实时指标汇总）

数据分析指的是根据业务目标从原始数据中抽取对应信息并整合的过程。比如查看每天卖的最好的十种商品，仓库平均周转时间，文章平均点击率，推送打开率等等。实时数据分析则是上述过程的实时化，一般最终体现为实时报表或实时大屏。eg：30s流量统计 高频车 重点路段/区域  流量/拥堵   在途车辆归属地分析


#### 事件驱动应用（实时预警）

事件驱动应用是对一系列订阅事件进行处理或作出响应的系统。事件驱动应用往往还会依赖内部状态，比如点击欺诈检测，风控系统，运维异常检测系统等当用户的行为触发某些风险控制点时，系统会捕获这个事件，并根据当前行为和用户之前的行为进行分析，决定是否对用户进行风险控制。eg： 套牌车  流量突发预警   路段突发拥堵预警  


### Flink 版本

#### Flink 1.7 版本
在 Flink 1.7.0，我们更关注实现快速数据处理以及以无缝方式为 Flink 社区构建数据密集型应用程序。我们最新版本包括一些令人兴奋的新功能和改进，例如对 Scala 2.12 的支持，Exactly-Once 语义的 S3 文件接收器，复杂事件处理与流SQL的集成.

1. Flink中的Scala 2.12支持

Flink 1.7.0 是第一个完全支持 Scala 2.12 的版本。这可以让用户使用新的 Scala 版本编写 Flink 应用程序以及利用 Scala 2.12 的生态系统。

2. 状态变化

在许多情况下，由于需求的变化，长期运行的 Flink 应用程序会在其生命周期内发生变化。在不丢失当前应用程序进度状态的情况下更改用户状态是应用程序变化的关键要求。Flink 1.7.0 版本中社区添加了状态变化，允许我们灵活地调整长时间运行的应用程序的用户状态模式，同时保持与先前保存点的兼容。通过状态变化，我们可以在状态模式中添加或删除列。当使用 Avro 生成类作为用户状态时，状态模式变化可以开箱即用，这意味着状态模式可以根据 Avro 的规范进行变化。虽然 Avro 类型是 Flink 1.7 中唯一支持模式变化的内置类型，但社区仍在继续致力于在未来的 Flink 版本中进一步扩展对其他类型的支持。

3. Exactly-once语义的S3 StreamingFileSink

Flink 1.6.0 中引入的 StreamingFileSink 现在已经扩展到 S3 文件系统，并保证 Exactly-once 语义。使用此功能允许所有 S3 用户构建写入 S3 的 Exactly-once 语义端到端管道。

4. Streaming SQL中支持MATCH_RECOGNIZE

这是 Apache Flink 1.7.0 的一个重要补充，它为 Flink SQL 提供了 MATCH_RECOGNIZE 标准的初始支持。此功能融合了复杂事件处理（CEP）和SQL，可以轻松地对数据流进行模式匹配，从而实现一整套新的用例。此功能目前处于测试阶段。

5. Streaming SQL中的 Temporal Tables 和 Temporal Joins

Temporal Tables 是 Apache Flink 中的一个新概念，它为表的更改历史记录提供（参数化）视图，可以返回表在任何时间点的内容。例如，我们可以使用具有历史货币汇率的表。随着时间的推移，表会不断发生变化，并增加更新的汇率。Temporal Table 是一种视图，可以返回汇率在任何时间点的实际状态。通过这样的表，可以使用正确的汇率将不同货币的订单流转换为通用货币。

Temporal Joins 允许 Streaming 数据与不断变化/更新的表的内存和计算效率的连接，使用处理时间或事件时间，同时符合ANSI SQL。

流式 SQL 的其他功能除了上面提到的主要功能外，Flink 的 Table＆SQL API 已经扩展到更多用例。以下内置函数被添加到API：TO_BASE64，LOG2，LTRIM，REPEAT，REPLACE，COSH，SINH，TANH。SQL Client 现在支持在环境文件和 CLI 会话中自定义视图。此外，CLI 中还添加了基本的 SQL 语句自动完成功能。社区添加了一个 Elasticsearch 6 table sink，允许存储动态表的更新结果。

6. 版本化REST API


从 Flink 1.7.0 开始，REST API 已经版本化。这保证了 Flink REST API 的稳定性，因此可以在 Flink 中针对稳定的 API开发第三方应用程序。因此，未来的 Flink 升级不需要更改现有的第三方集成。

7. Kafka 2.0 Connector

Apache Flink 1.7.0 继续添加更多的连接器，使其更容易与更多外部系统进行交互。在此版本中，社区添加了 Kafka 2.0 连接器，可以从 Kafka 2.0 读写数据时保证 Exactly-Once 语义。

8. 本地恢复

Apache Flink 1.7.0 通过扩展 Flink 的调度来完成本地恢复功能，以便在恢复时考虑之前的部署位置。如果启用了本地恢复，Flink 将在运行任务的机器上保留一份最新检查点的本地副本。将任务调度到之前的位置，Flink 可以通过从本地磁盘读取检查点状态来最小化恢复状态的网络流量。此功能大大提高了恢复速度。

9. 删除Flink的传统模式

Apache Flink 1.7.0 标志着 Flip-6 工作已经完全完成并且与传统模式达到功能奇偶校验。因此，此版本删除了对传统模式的支持。

#### Flink 1.8 版本

**新特性和改进**

- Schema Evolution Story 最终版
- 基于 TTL 持续清除旧状态
- 使用用户定义的函数和聚合进行 SQL 模式检测
- 符合 RFC 的 CSV 格式
- 新的 KafkaDeserializationSchema，可以直接访问 ConsumerRecord
- FlinkKinesisConsumer 中的分片水印选项
- DynamoDB Streams 的新用户捕获表更改
- 支持用于子任务协调的全局聚合

**重要变化**

- 使用 Flink 捆绑 Hadoop 库的更改：不再发布包含 hadoop 的便捷二进制文件
- FlinkKafkaConsumer 现在将根据主题规范过滤已恢复的分区
- 表 API 的 Maven 依赖更改：之前具有flink-table依赖关系的用户需要将依赖关系从flink-table-planner更新为正确的依赖关系 flink-table-api-，具体取决于是使用 Java 还是 Scala：flink-table-api-java-bridge或者flink-table-api-scala-bridge

1. 使用TTL（生存时间）连续增量清除旧的Key状态

我们在Flink 1.6（FLINK-9510）中为Key状态引入了TTL（生存时间）。此功能允许在访问时清理并使Key状态条目无法访问。另外，在编写保存点/检查点时，现在也将清理状态。Flink 1.8引入了对RocksDB状态后端（FLINK-10471）和堆状态后端（FLINK-10473）的旧条数的连续清理。这意味着旧的条数将（根据TTL设置）不断被清理掉。

2. 恢复保存点时对模式迁移的新支持

使用Flink 1.7.0，我们在使用AvroSerializer时添加了对更改状态模式的支持。使用Flink 1.8.0，我们在TypeSerializers将所有内置迁移到新的序列化器快照抽象方面取得了很大进展，该抽象理论上允许模式迁移。在Flink附带的序列化程序中，我们现在支持PojoSerializer （FLINK-11485）和Java EnumSerializer （FLINK-11334）以及有限情况下的Kryo（FLINK-11323）的模式迁移格式。

3. 保存点兼容性

TraversableSerializer 此序列化程序（FLINK-11539）中的更新，包含Scala的Flink 1.2中的保存点将不再与Flink 1.8兼容。可以通过升级到Flink 1.3和Flink 1.7之间的版本，然后再更新至Flink 1.8来解决此限制。

4. RocksDB版本冲突并切换到FRocksDB（FLINK-10471）

需要切换到名为FRocksDB的RocksDB的自定义构建，因为需要RocksDB中的某些更改来支持使用TTL进行连续状态清理。FRocksDB的已使用版本基于RocksDB的升级版本5.17.2。对于Mac OS X，仅支持OS X版本> =10.13的RocksDB版本5.17.2。

另见：https://github.com/facebook/rocksdb/issues/4862

5. Maven 依赖

使用Flink捆绑Hadoop库的更改（FLINK-11266）

> 包含hadoop的便捷二进制文件不再发布。
>
> 如果部署依赖于flink-shaded-hadoop2包含 flink-dist，则必须从下载页面的可选组件部分手动下载并打包Hadoop jar并将其复制到/lib目录中。另外一种方法，可以通过打包flink-dist和激活 include-hadoopmaven配置文件来构建包含hadoop的Flink分发。
>
> 由于hadoop flink-dist默认不再包含在内，因此指定-DwithoutHadoop何时打包flink-dist将不再影响构建。

6. TaskManager配置（FLINK-11716）

TaskManagers现在默认绑定到主机IP地址而不是主机名。可以通过配置选项控制此行为taskmanager.network.bind-policy。如果你的Flink集群在升级后遇到莫名其妙的连接问题，尝试设置taskmanager.network.bind-policy: name在flink-conf.yaml 返回前的1.8的设置行为。

7. Table API 的变动

直接表构造函数使用的取消预测（FLINK-11447）

> Flink 1.8不赞成Table在Table API中直接使用该类的构造函数。此构造函数以前将用于执行与横向表的连接。你现在应该使用table.joinLateral()或 table.leftOuterJoinLateral()代替。这种更改对于将Table类转换为接口是必要的，这将使Table API在未来更易于维护和更清洁。

引入新的CSV格式符（FLINK-9964）

> 此版本为符合RFC4180的CSV文件引入了新的格式符。新描述符可用作 org.apache.flink.table.descriptors.Csv。
>
> 目前，这只能与Kafka一起使用。旧描述符可org.apache.flink.table.descriptors.OldCsv用于文件系统连接器。

静态生成器方法在TableEnvironment（FLINK-11445）上的弃用

> 为了将API与实际实现分开：TableEnvironment.getTableEnvironment()。
>
> 不推荐使用静态方法。你现在应该使用Batch/StreamTableEnvironment.create()。

表API Maven模块中的更改（FLINK-11064）

> 之前具有flink-table依赖关系的用户需要更新其依赖关系flink-table-planner以及正确的依赖关系flink-table-api-?，具体取决于是使用Java还是Scala：flink-table-api-java-bridge或者flink-table-api-scala-bridge。

更改为外部目录表构建器（FLINK-11522）

> ExternalCatalogTable.builder()不赞成使用ExternalCatalogTableBuilder()。

更改为表API连接器jar的命名（FLINK-11026）

> Kafka/elasticsearch6 sql-jars的命名方案已经更改。在maven术语中，它们不再具有sql-jar限定符，而artifactId现在以前缀为例，flink-sql而不是flink例如flink-sql-connector-kafka。

更改为指定Null的方式（FLINK-11785）

> 现在Table API中的Null需要定义nullof(type)而不是Null(type)。旧方法已被弃用。

8. 连接器变动

引入可直接访问ConsumerRecord的新KafkaDeserializationSchema（FLINK-8354）

> 对于FlinkKafkaConsumers，我们推出了一个新的KafkaDeserializationSchema ，可以直接访问KafkaConsumerRecord。这包含了该 KeyedSerializationSchema功能，该功能已弃用但目前仍可以使用。

FlinkKafkaConsumer现在将根据主题规范过滤恢复的分区（FLINK-10342）

> 从Flink 1.8.0开始，现在FlinkKafkaConsumer总是过滤掉已恢复的分区，这些分区不再与要在还原的执行中订阅的指定主题相关联。此行为在以前的版本中不存在FlinkKafkaConsumer。
>
> 如果您想保留以前的行为。请使用上面的disableFilterRestoredPartitionsWithSubscribedTopics()配置方法FlinkKafkaConsumer。
>
> 考虑这个例子：如果你有一个正在消耗topic的Kafka Consumer A，你做了一个保存点，然后改变你的Kafka消费者而不是从topic消费B，然后从保存点重新启动你的工作。在此更改之前，您的消费者现在将使用这两个主题A，B因为它存储在消费者正在使用topic消费的状态A。通过此更改，您的使用者将仅B在还原后使用topic，因为我们使用配置的topic过滤状态中存储的topic。

**其它接口改变**

1. 从TypeSerializer接口（FLINK-9803）中删除了canEqual（）方法

> 这些canEqual()方法通常用于跨类型层次结构进行适当的相等性检查。在TypeSerializer实际上并不需要这个属性，因此该方法现已删除。

2. 删除CompositeSerializerSnapshot实用程序类（FLINK-11073）

> 该CompositeSerializerSnapshot实用工具类已被删除。
>
> 现在CompositeTypeSerializerSnapshot，你应该使用复合序列化程序的快照，该序列化程序将序列化委派给多个嵌套的序列化程序。有关使用的说明，请参阅CompositeTypeSerializerSnapshot。

#### Flink 1.9 版本
2019年 8月22日，Apache Flink 1.9.0 版本正式发布，这也是阿里内部版本 Blink 合并入 Flink 后的首次版本发布。

此次版本更新带来的重大功能包括批处理作业的批式恢复，以及 Table API 和 SQL 的基于 Blink 的新查询引擎（预览版）。同时，这一版本还推出了 State Processor API，这是社区最迫切需求的功能之一，该 API 使用户能够用 Flink DataSet 作业灵活地读写保存点。此外，Flink 1.9 还包括一个重新设计的 WebUI 和新的 Python Table API （预览版）以及与 Apache Hive 生态系统的集成（预览版）。

**新功能和改进**

- 细粒度批作业恢复 (FLIP-1)
- State Processor API (FLIP-43)
- Stop-with-Savepoint (FLIP-34)
- 重构 Flink WebUI
- 预览新的 Blink SQL 查询处理器
- Table API / SQL 的其他改进
- 预览 Hive 集成 (FLINK-10556)
- 预览新的 Python Table API (FLIP-38)

1. 细粒度批作业恢复 (FLIP-1)

批作业（DataSet、Table API 和 SQL）从 task 失败中恢复的时间被显著缩短了。在 Flink 1.9 之前，批处理作业中的 task 失败是通过取消所有 task 并重新启动整个作业来恢复的，即作业从头开始，所有进度都会废弃。在此版本中，Flink 将中间结果保留在网络 shuffle 的边缘，并使用此数据去恢复那些仅受故障影响的 task。所谓 task 的 “failover regions” （故障区）是指通过 pipelined 方式连接的数据交换方式，定义了 task 受故障影响的边界。

> 要使用这个新的故障策略，需要确保 flink-conf.yaml 中有 jobmanager.execution.failover-strategy: region 的配置。
>
> 注意：1.9 发布包中默认就已经包含了该配置项，不过当从之前版本升级上来时，如果要复用之前的配置的话，需要手动加上该配置。
>
> “Region” 的故障策略也能同时提升 “embarrassingly parallel” 类型的流作业的恢复速度，也就是没有任何像 keyBy() 和 rebalance 的 shuffle 的作业。当这种作业在恢复时，只有受影响的故障区的 task 需要重启。对于其他类型的流作业，故障恢复行为与之前的版本一样。

2. State Processor API (FLIP-43)

直到 Flink 1.9，从外部访问作业的状态仅局限于：Queryable State（可查询状态）实验性功能。此版本中引入了一种新的、强大的类库，基于 DataSet 支持读取、写入、和修改状态快照。在实践上，这意味着：

> Flink 作业的状态可以自主构建了，可以通过读取外部系统的数据（例如外部数据库），然后转换成 savepoint。
>
> Savepoint 中的状态可以使用任意的 Flink 批处理 API 查询（DataSet、Table、SQL）。例如，分析相关的状态模式或检查状态差异以支持应用程序审核或故障排查。
>
> Savepoint 中的状态 schema 可以离线迁移了，而之前的方案只能在访问状态时进行，是一种在线迁移。
>
> Savepoint 中的无效数据可以被识别出来并纠正。
>
> 新的 State Processor API 覆盖了所有类型的快照：savepoint，full checkpoint 和 incremental checkpoint。

3. Stop-with-Savepoint (FLIP-34)

“Cancel-with-savepoint” 是停止、重启、fork、或升级 Flink 作业的一个常用操作。然而，当前的实现并没有保证输出到 exactly-once sink 的外部存储的数据持久化。为了改进停止作业时的端到端语义，Flink 1.9 引入了一种新的 SUSPEND 模式，可以带 savepoint 停止作业，保证了输出数据的一致性。你可以使用 Flink CLI 来 suspend 一个作业：

`bin/flink stop -p [:targetSavepointDirectory] :jobId`

4. 重构 Flink WebUI

社区讨论了现代化 Flink WebUI 的提案，决定采用 Angular 的最新稳定版来重构这个组件。从 Angular 1.x 跃升到了 7.x 。重新设计的 UI 是 1.9.0 的默认版本，不过有一个按钮可以切换到旧版的 WebUI。

5. 新 Blink SQL 查询处理器预览

在 Blink 捐赠给 Apache Flink 之后，社区就致力于为 Table API 和 SQL 集成 Blink 的查询优化器和 runtime。第一步，我们将 flink-table 单模块重构成了多个小模块（FLIP-32）。这对于 Java 和 Scala API 模块、优化器、以及 runtime 模块来说，有了一个更清晰的分层和定义明确的接口。

紧接着，我们扩展了 Blink 的 planner 以实现新的优化器接口，所以现在有两个插件化的查询处理器来执行 Table API 和 SQL：1.9 以前的 Flink 处理器和新的基于 Blink 的处理器。基于 Blink 的查询处理器提供了更好地 SQL 覆盖率（1.9 完整支持 TPC-H，TPC-DS 的支持在下一个版本的计划中）并通过更广泛的查询优化（基于成本的执行计划选择和更多的优化规则）、改进的代码生成机制、和调优过的算子实现来提升批处理查询的性能。除此之外，基于 Blink 的查询处理器还提供了更强大的流处理能力，包括一些社区期待已久的新功能（如维表 Join，TopN，去重）和聚合场景缓解数据倾斜的优化，以及内置更多常用的函数。

注：两个查询处理器之间的语义和功能大部分是一致的，但并未完全对齐。具体请查看发布日志。

不过， Blink 的查询处理器的集成还没有完全完成。因此，1.9 之前的 Flink 处理器仍然是1.9 版本的默认处理器，建议用于生产设置。你可以在创建 TableEnvironment 时通过 EnvironmentSettings 配置启用 Blink 处理器。被选择的处理器必须要在正在执行的 Java 进程的类路径中。对于集群设置，默认两个查询处理器都会自动地加载到类路径中。当从 IDE 中运行一个查询时，需要在项目中显式地增加一个处理器的依赖。

6. Table API / SQL 的其他改进

除了围绕 Blink Planner 令人兴奋的进展外，社区还做了一系列的改进，包括：

- 为 Table API / SQL 的 Java 用户去除 Scala 依赖 （FLIP-32） 作为重构和拆分 flink-table 模块工作的一部分，我们为 Java 和 Scala 创建了两个单独的 API 模块。对于 Scala 用户来说，没有什么改变。不过现在 Java 用户在使用 Table API 和 SQL 时，可以不用引入一堆 Scala 依赖了。
- 重构 Table API / SQL 的类型系统（FLIP-37） 我们实现了一个新的数据类型系统，以便从 Table API 中移除对 Flink TypeInformation 的依赖，并提高其对 SQL 标准的遵从性。不过还在进行中，预计将在下一版本完工，在 Flink 1.9 中，UDF 尚未移植到新的类型系统上。
- Table API 的多行多列转换（FLIP-29） Table API 扩展了一组支持多行和多列、输入和输出的转换的功能。这些转换显著简化了处理逻辑的实现，同样的逻辑使用关系运算符来实现是比较麻烦的。
- 崭新的统一的 Catalog API Catalog 已有的一些接口被重构和（某些）被替换了，从而统一了内部和外部 catalog 的处理。这项工作主要是为了 Hive 集成（见下文）而启动的，不过也改进了 Flink 在管理 catalog 元数据的整体便利性。
- SQL API 中的 DDL 支持 （FLINK-10232） 到目前为止，Flink SQL 已经支持 DML 语句（如 SELECT，INSERT）。但是外部表（table source 和 table sink）必须通过 Java/Scala 代码的方式或配置文件的方式注册。1.9 版本中，我们支持 SQL DDL 语句的方式注册和删除表（CREATE TABLE，DROP TABLE）。然而，我们还没有增加流特定的语法扩展来定义时间戳抽取和 watermark 生成策略等。流式的需求将会在下一版本完整支持。

#### Flink 1.10 版本
重要版本 : Blink 整合完成

作为 Flink 社区迄今为止规模最大的一次版本升级，Flink 1.10 容纳了超过 200 位贡献者对超过 1200 个 issue 的开发实现，包含对 Flink 作业的整体性能及稳定性的显著优化、对原生 Kubernetes 的初步集成（beta 版本）以及对 Python 支持（PyFlink）的重大优化。

Flink 1.10 同时还标志着对 Blink 的整合宣告完成，随着对 Hive 的生产级别集成及对 TPC-DS 的全面覆盖，Flink 在增强流式 SQL 处理能力的同时也具备了成熟的批处理能力。

1. 内存管理及配置优化

Flink 目前的 TaskExecutor 内存模型存在着一些缺陷，导致优化资源利用率比较困难，例如：

> 流和批处理内存占用的配置模型不同；流处理中的 RocksDB state backend 需要依赖用户进行复杂的配置。为了让内存配置变的对于用户更加清晰、直观，Flink 1.10 对 TaskExecutor 的内存模型和配置逻辑进行了较大的改动 （FLIP-49 [7]）。这些改动使得 Flink 能够更好地适配所有部署环境（例如 Kubernetes, Yarn, Mesos），让用户能够更加严格的控制其内存开销。

Managed 内存扩展

> Managed 内存的范围有所扩展，还涵盖了 RocksDB state backend 使用的内存。尽管批处理作业既可以使用堆内内存也可以使用堆外内存，使用 RocksDB state backend 的流处理作业却只能利用堆外内存。因此为了让用户执行流和批处理作业时无需更改集群的配置，我们规定从现在起 managed 内存只能在堆外。

简化 RocksDB 配置

> 此前，配置像 RocksDB 这样的堆外 state backend 需要进行大量的手动调试，例如减小 JVM 堆空间、设置 Flink 使用堆外内存等。现在，Flink 的开箱配置即可支持这一切，且只需要简单地改变 managed 内存的大小即可调整 RocksDB state backend 的内存预算。

另一个重要的优化是，Flink 现在可以限制 RocksDB 的 native 内存占用（FLINK-7289），以避免超过总的内存预算——这对于 Kubernetes 等容器化部署环境尤为重要。关于如何开启、调试该特性，请参考 RocksDB 调试。

注：FLIP-49 改变了集群的资源配置过程，因此从以前的 Flink 版本升级时可能需要对集群配置进行调整。详细的变更日志及调试指南请参考文档。

2. 统一的作业提交逻辑

在此之前，提交作业是由执行环境负责的，且与不同的部署目标（例如 Yarn, Kubernetes, Mesos）紧密相关。这导致用户需要针对不同环境保留多套配置，增加了管理的成本。

在 Flink 1.10 中，作业提交逻辑被抽象到了通用的 Executor 接口（FLIP-73）。新增加的 ExecutorCLI （FLIP-81）引入了为任意执行目标指定配置参数的统一方法。此外，随着引入 JobClient（FLINK-74）负责获取 JobExecutionResult，获取作业执行结果的逻辑也得以与作业提交解耦。

3. 原生 Kubernetes 集成（Beta）

对于想要在容器化环境中尝试 Flink 的用户来说，想要在 Kubernetes 上部署和管理一个 Flink standalone 集群，首先需要对容器、算子及像 kubectl 这样的环境工具有所了解。

在 Flink 1.10 中，我们推出了初步的支持 session 模式的主动 Kubernetes 集成（FLINK-9953）。其中，“主动”指 Flink ResourceManager (K8sResMngr) 原生地与 Kubernetes 通信，像 Flink 在 Yarn 和 Mesos 上一样按需申请 pod。用户可以利用 namespace，在多租户环境中以较少的资源开销启动 Flink。这需要用户提前配置好 RBAC 角色和有足够权限的服务账号。

正如在统一的作业提交逻辑一节中提到的，Flink 1.10 将命令行参数映射到了统一的配置。因此，用户可以参阅 Kubernetes 配置选项，在命令行中使用以下命令向 Kubernetes 提交 Flink 作业。

`./bin/flink run -d -e kubernetes-session -Dkubernetes.cluster-id= examples/streaming/WindowJoin.jar`

4. Table API/SQL: 生产可用的 Hive 集成

Flink 1.9 推出了预览版的 Hive 集成。该版本允许用户使用 SQL DDL 将 Flink 特有的元数据持久化到 Hive Metastore、调用 Hive 中定义的 UDF 以及读、写 Hive 中的表。Flink 1.10 进一步开发和完善了这一特性，带来了全面兼容 Hive 主要版本的生产可用的 Hive 集成。

Batch SQL 原生分区支持

> 此前，Flink 只支持写入未分区的 Hive 表。在 Flink 1.10 中，Flink SQL 扩展支持了 INSERT OVERWRITE 和 PARTITION 的语法（FLIP-63 [18]），允许用户写入 Hive 中的静态和动态分区。

写入静态分区

> `INSERT { INTO | OVERWRITE } TABLE tablename1 [PARTITION (partcol1=val1, partcol2=val2 …)] select_statement1 FROM from_statement;`

写入动态分区

> `INSERT { INTO | OVERWRITE } TABLE tablename1 select_statement1 FROM from_statement;`

对分区表的全面支持，使得用户在读取数据时能够受益于分区剪枝，减少了需要扫描的数据量，从而大幅提升了这些操作的性能。

其他优化

除了分区剪枝，Flink 1.10 的 Hive 集成还引入了许多数据读取方面的优化，例如：

> 投影下推：Flink 采用了投影下推技术，通过在扫描表时忽略不必要的域，最小化 Flink 和 Hive 表之间的数据传输量。这一优化在表的列数较多时尤为有效。
>
> LIMIT 下推：对于包含 LIMIT 语句的查询，Flink 在所有可能的地方限制返回的数据条数，以降低通过网络传输的数据量。读取数据时的 ORC 向量化：为了提高读取 ORC 文件的性能，对于 Hive 2.0.0 及以上版本以及非复合数据类型的列，Flink 现在默认使用原生的 ORC 向量化读取器。
>
> 将可插拔模块作为 Flink 内置对象（Beta）：Flink 1.10 在 Flink table 核心引入了通用的可插拔模块机制，目前主要应用于系统内置函数（FLIP-68 ）。通过模块，用户可以扩展 Flink 的系统对象，例如像使用 Flink 系统函数一样使用 Hive 内置函数。新版本中包含一个预先实现好的 HiveModule，能够支持多个 Hive 版本，当然用户也可以选择编写自己的可插拔模块。

5. 其他 Table API/SQL 优化

SQL DDL 中的 watermark 和计算列

> Flink 1.10 在 SQL DDL 中增加了针对流处理定义时间属性及产生 watermark 的语法扩展（FLIP-66）。这使得用户可以在用 DDL 语句创建的表上进行基于时间的操作（例如窗口）以及定义 watermark 策略。

```sql
CREATE TABLE table_name (
WATERMARK FOR columnName AS <watermark_strategy_expression>
) WITH (
...
)
```

其他 SQL DDL 扩展

> Flink 现在严格区分临时/持久、系统/目录函数（FLIP-57）。这不仅消除了函数引用中的歧义，还带来了确定的函数解析顺序（例如，当存在命名冲突时，比起目录函数、持久函数 Flink 会优先使用系统函数、临时函数）。
>
> 在 FLIP-57 的基础上，我们扩展了 SQL DDL 的语法，支持创建目录函数、临时函数以及临时系统函数（FLIP-79）：

```sql
CREATE [TEMPORARY|TEMPORARY SYSTEM] FUNCTION
[IF NOT EXISTS] [catalog_name.][db_name.]function_name
AS identifier [LANGUAGE JAVA|SCALA]
```

> 关于目前完整的 Flink SQL DDL 支持，请参考最新的文档。

> 注：为了今后正确地处理和保证元对象（表、视图、函数）上的行为一致性，Flink 废弃了 Table API 中的部分对象申明方法，以使留下的方法更加接近标准的 SQL DDL（FLIP-64）。

批处理完整的 TPC-DS 覆盖

> TPC-DS 是广泛使用的业界标准决策支持 benchmark，用于衡量基于 SQL 的数据处理引擎性能。Flink 1.10 端到端地支持所有 TPC-DS 查询（FLINK-11491 [28]），标志着 Flink SQL 引擎已经具备满足现代数据仓库及其他类似的处理需求的能力。

6. PyFlink: 支持原生用户自定义函数（UDF）

作为 Flink 全面支持 Python 的第一步，在之前版本中我们发布了预览版的 PyFlink。在新版本中，我们专注于让用户在 Table API/SQL 中注册并使用自定义函数（UDF，另 UDTF / UDAF 规划中）（FLIP-58）。

如果你对这一特性的底层实现（基于 Apache Beam 的可移植框架）感兴趣，请参考 FLIP-58 的 Architecture 章节以及 FLIP-78。这些数据结构为支持 Pandas 以及今后将 PyFlink 引入到 DataStream API 奠定了基础。

从 Flink 1.10 开始，用户只要执行以下命令就可以轻松地通过 pip 安装 PyFlink：

`pip install apache-flink`

7. 重要变更

- FLINK-10725：Flink 现在可以使用 Java 11 编译和运行。
- FLINK-15495：SQL 客户端现在默认使用 Blink planner，向用户提供最新的特性及优化。Table API 同样计划在下个版本中从旧的 planner 切换到 Blink planner，我们建议用户现在就开始尝试和熟悉 Blink planner。
- FLINK-13025：新的 Elasticsearch sink connector[37] 全面支持 Elasticsearch 7.x 版本。
- FLINK-15115：Kafka 0.8 和 0.9 的 connector 已被标记为废弃并不再主动支持。如果你还在使用这些版本或有其他相关问题，请通过 @dev 邮件列表联系我们。
- FLINK-14516：非基于信用的网络流控制已被移除，同时移除的还有配置项“taskmanager.network.credit.model”。今后，Flink 将总是使用基于信用的网络流控制。
- FLINK-12122：在 Flink 1.5.0 中，FLIP-6[41] 改变了 slot 在 TaskManager 之间的分布方式。要想使用此前的调度策略，既尽可能将负载分散到所有当前可用的 TaskManager，用户可以在 flink-conf.yaml 中设置 “cluster.evenly-spread-out-slots: true”。
- FLINK-11956：s3-hadoop 和 s3-presto 文件系统不再使用类重定位加载方式，而是使用插件方式加载，同时无缝集成所有认证提供者。我们强烈建议其他文件系统也只使用插件加载方式，并将陆续移除重定位加载方式。

Flink 1.9 推出了新的 Web UI，同时保留了原来的 Web UI 以备不时之需。截至目前，我们没有收到关于新的 UI 存在问题的反馈，因此社区投票决定在 Flink 1.10 中移除旧的 Web UI。


#### Flink 1.11 版本

Flink 1.11.0 正式发布。历时近 4 个月，Flink 在生态、易用性、生产可用性、稳定性等方面都进行了增强和改善。

> core engine 引入了 unaligned checkpoints，这是对 Flink 的容错机制的重大更改，该机制可改善在高背压下的检查点性能。
>
> 一个新的 Source API 通过统一批处理和 streaming 执行以及将内部组件（例如事件时间处理、水印生成或空闲检测）卸载到 Flink 来简化（自定义）sources 的实现。
>
> Flink SQL 引入了对变更数据捕获（CDC）的支持，以轻松使用和解释来自 Debezium 之类的工具的数据库变更日志。更新的 FileSystem 连接器还扩展了 Table API/SQL 支持的用例和格式集，从而实现了直接启用从 Kafka 到 Hive 的 streaming 数据传输等方案。
>
> PyFlink 的多项性能优化，包括对矢量化用户定义函数（Pandas UDF）的支持。这改善了与 Pandas 和 NumPy 之类库的互操作性，使 Flink 在数据科学和 ML 工作负载方面更强大。

**重要变化**

- [FLINK-17339] 从 Flink 1.11 开始，Blink planner 是 Table API/SQL中的默认设置。自 Flink 1.10 起，SQL 客户端已经存在这种情况。仍支持旧的 Flink 规划器，但未积极开发。
- [FLINK-5763] Savepoints 现在将其所有状态包含在一个目录中（元数据和程序状态）。这样可以很容易地找出组成 savepoint 状态的文件，并允许用户通过简单地移动目录来重新定位 savepoint。
- [FLINK-16408] 为了减轻对 JVM metaspace 的压力，只要任务分配了至少一个插槽，TaskExecutor就会重用用户代码类加载器。这会稍微改变 Flink 的恢复行为，从而不会重新加载静态字段。
- [FLINK-11086] Flink 现在支持 Hadoop 3.0.0 以上的 Hadoop 版本。请注意，Flink 项目不提供任何更新的flink-shaded-hadoop-x jars。用户需要通过HADOOP_CLASSPATH环境变量（推荐）或 lib/ folder 提供 Hadoop 依赖项。
- [FLINK-16963] Flink 随附的所有MetricReporters均已转换为插件。这些不再应该放在/lib中（可能导致依赖冲突），而应该放在/plugins/< some_directory>中。
- [FLINK-12639] Flink 文档正在做一些返工，因此从 Flink 1.11 开始，内容的导航和组织会有所变化。

1. Table & SQL 支持 Change Data Capture（CDC）

CDC 被广泛使用在复制数据、更新缓存、微服务间同步数据、审计日志等场景，很多公司都在使用开源的 CDC 工具，如 MySQL CDC。通过 Flink 支持在 Table & SQL 中接入和解析 CDC 是一个强需求，在过往的很多讨论中都被提及过，可以帮助用户以实时的方式处理 changelog 流，进一步扩展 Flink 的应用场景，例如把 MySQL 中的数据同步到 PG 或 ElasticSearch 中，低延时的 temporal join 一个 changelog 等。

除了考虑到上面的真实需求，Flink 中定义的“Dynamic Table”概念在流上有两种模型：append 模式和 update 模式。通过 append 模式把流转化为“Dynamic Table”在之前的版本中已经支持，因此在 1.11.0 中进一步支持 update 模式也从概念层面完整的实现了“Dynamic Table”。

为了支持解析和输出 changelog，如何在外部系统和 Flink 系统之间编解码这些更新操作是首要解决的问题。考虑到 source 和 sink 是衔接外部系统的一个桥梁，因此 FLIP-95 在定义全新的 Table source 和 Table sink 接口时解决了这个问题。

在公开的 CDC 调研报告中，Debezium 和 Canal 是用户中最流行使用的 CDC 工具，这两种工具用来同步 changelog 到其它的系统中，如消息队列。据此，FLIP-105 首先支持了 Debezium 和 Canal 这两种格式，而且 Kafka source 也已经可以支持解析上述格式并输出更新事件，在后续的版本中会进一步支持 Avro（Debezium） 和 Protobuf（Canal）。

```sql
CREATE TABLE my_table (  
...) WITH (  
'connector'='...', -- e.g. 'kafka'  
'format'='debezium-json',  
'debezium-json.schema-include'='true' -- default: false (Debezium can be configured to include or exclude the message schema)  
'debezium-json.ignore-parse-errors'='true' -- default: false
);
```

2. Table & SQL 支持 JDBC Catalog

1.11.0 之前，用户如果依赖 Flink 的 source/sink 读写关系型数据库或读取 changelog 时，必须要手动创建对应的 schema。而且当数据库中的 schema 发生变化时，也需要手动更新对应的 Flink 作业以保持一致和类型匹配，任何不匹配都会造成运行时报错使作业失败。用户经常抱怨这个看似冗余且繁琐的流程，体验极差。

实际上对于任何和 Flink 连接的外部系统都可能有类似的上述问题，在 1.11.0 中重点解决了和关系型数据库对接的这个问题。FLIP-93 提供了 JDBC catalog 的基础接口以及 Postgres catalog 的实现，这样方便后续实现与其它类型的关系型数据库的对接。

1.11.0 版本后，用户使用 Flink SQL 时可以自动获取表的 schema 而不再需要输入 DDL。除此之外，任何 schema 不匹配的错误都会在编译阶段提前进行检查报错，避免了之前运行时报错造成的作业失败。这是提升易用性和用户体验的一个典型例子。

3. Hive 实时数仓

从 1.9.0 版本开始 Flink 从生态角度致力于集成 Hive，目标打造批流一体的 Hive 数仓。经过前两个版本的迭代，已经达到了 batch 兼容且生产可用，在 TPC-DS 10T benchmark 下性能达到 Hive 3.0 的 7 倍以上。

1.11.0 在 Hive 生态中重点实现了实时数仓方案，改善了端到端流式 ETL 的用户体验，达到了批流一体 Hive 数仓的目标。同时在兼容性、性能、易用性方面也进一步进行了加强。

在实时数仓的解决方案中，凭借 Flink 的流式处理优势做到实时读写 Hive：

- Hive 写入：FLIP-115 完善扩展了 FileSystem connector 的基础能力和实现，Table/SQL 层的 sink 可以支持各种格式（CSV、Json、Avro、Parquet、ORC），而且支持 Hive table 的所有格式。

- Partition 支持：数据导入 Hive 引入 partition 提交机制来控制可见性，通过sink.partition-commit.trigger 控制 partition 提交的时机，通过 sink.partition-commit.policy.kind 选择提交策略，支持 SUCCESS 文件和 metastore 提交。

- Hive 读取：实时化的流式读取 Hive，通过监控 partition 生成增量读取新 partition，或者监控文件夹内新文件生成来增量读取新文件。在 Hive 可用性方面的提升：

FLIP-123 通过 Hive Dialect 为用户提供语法兼容，这样用户无需在 Flink 和 Hive 的 CLI 之间切换，可以直接迁移 Hive 脚本到 Flink 中执行。

提供 Hive 相关依赖的内置支持，避免用户自己下载所需的相关依赖。现在只需要单独下载一个包，配置 HADOOP_CLASSPATH 就可以运行。

在 Hive 性能方面，1.10.0 中已经支持了 ORC（Hive 2+）的向量化读取，1.11.0 中我们补全了所有版本的 Parquet 和 ORC 向量化支持来提升性能。

4. 全新 Source API

前面也提到过，source 和 sink 是 Flink 对接外部系统的一个桥梁，对于完善生态、可用性及端到端的用户体验是很重要的环节。社区早在一年前就已经规划了 source 端的彻底重构，从 FLIP-27 的 ID 就可以看出是很早的一个 feature。但是由于涉及到很多复杂的内部机制和考虑到各种 source connector 的实现，设计上需要考虑的很全面。从 1.10.0 就开始做 POC 的实现，最终赶上了 1.11.0 版本的发布。

先简要回顾下 source 之前的主要问题：

> 对用户而言，在 Flink 中改造已有的 source 或者重新实现一个生产级的 source connector 不是一件容易的事情，具体体现在没有公共的代码可以复用，而且需要理解很多 Flink 内部细节以及实现具体的 event time 分配、watermark 产出、idleness 监测、线程模型等。

批和流的场景需要实现不同的 source。

> partitions/splits/shards 概念在接口中没有显式表达，比如 split 的发现逻辑和数据消费都耦合在 source function 的实现中，这样在实现 Kafka 或 Kinesis 类型的 source 时增加了复杂性。

在 runtime 执行层，checkpoint 锁被 source function 抢占会带来一系列问题，框架很难进行优化。

FLIP-27 在设计时充分考虑了上述的痛点：

> 首先在 Job Manager 和 Task Manager 中分别引入两种不同的组件 Split Enumerator 和 Source reader，解耦 split 发现和对应的消费处理，同时方便随意组合不同的策略。比如现有的 Kafka connector 中有多种不同的 partition 发现策略和实现耦合在一起，在新的架构下，我们只需要实现一种 source reader，就可以适配多种 split enumerator 的实现来对应不同的 partition 发现策略。
>
> 在新架构下实现的 source connector 可以做到批流统一，唯一的小区别是对批场景的有限输入，split enumerator 会产出固定数量的 split 集合并且每个 split 都是有限数据集；对于流场景的无限输入，split enumerator 要么产出无限多的 split 或者 split 自身是无限数据集。
>
> 复杂的 timestamp assigner 以及 watermark generator 透明的内置在 source reader 模块内运行，对用户来说是无感知的。这样用户如果想实现新的 source connector，一般不再需要重复实现这部分功能。

目前 Flink 已有的 source connector 会在后续的版本中基于新架构来重新实现，legacy source 也会继续维护几个版本保持兼容性，用户也可以按照 release 文档中的说明来尝试体验新 source 的开发。

5. PyFlink 生态

众所周知，Python 语言在机器学习和数据分析领域有着广泛的使用。Flink 从 1.9.0 版本开始发力兼容 Python 生态，Python 和 Flink 合力为 PyFlink，把 Flink 的实时分布式处理能力输出给 Python 用户。前两个版本 PyFlink 已经支持了 Python Table API 和 UDF，在 1.11.0 中扩大对 Python 生态库 Pandas 的支持以及和 SQL DDL/Client 的集成，同时 Python UDF 性能有了极大的提升。

具体来说，之前普通的 Python UDF 每次调用只能处理一条数据，而且在 Java 端和 Python 端都需要序列化/反序列化，开销很大。1.11.0 中 Flink 支持在 Table & SQL 作业中自定义和使用向量化 Python UDF，用户只需要在 UDF 修饰中额外增加一个参数 udf_type=“pandas” 即可。这样带来的好处是：

- 每次调用可以处理 N 条数据。

- 数据格式基于 Apache Arrow，大大降低了 Java、Python 进程之间的序列化/反序列化开销。

- 方便 Python 用户基于 Numpy 和 Pandas 等数据分析领域常用的 Python 库，开发高性能的 Python UDF。

除此之外，1.11.0 中 PyFlink 还支持：

- PyFlink table 和 Pandas DataFrame 之间无缝切换（FLIP-120），增强 Pandas 生态的易用性和兼容性。

- Table & SQL 中可以定义和使用 Python UDTF（FLINK-14500），不再必需 Java/Scala UDTF。

- Cython 优化 Python UDF 的性能（FLIP-121），对比 1.10.0 可以提升 30 倍。

- Python UDF 中用户自定义 metric（FLIP-112），方便监控和调试 UDF 的执行。

6. 生产可用性和稳定性提升

支持 application 模式和 Kubernetes 增强

> 1.11.0 版本前，Flink 主要支持如下两种模式运行：
>
> Session 模式：提前启动一个集群，所有作业都共享这个集群的资源运行。优势是避免每个作业单独启动集群带来的额外开销，缺点是隔离性稍差。如果一个作业把某个 Task Manager（TM）容器搞挂，会导致这个容器内的所有作业都跟着重启。虽然每个作业有自己独立的 Job Manager（JM）来管理，但是这些 JM 都运行在一个进程中，容易带来负载上的瓶颈。
>
> Per-job 模式：为了解决 session 模式隔离性差的问题，每个作业根据资源需求启动独立的集群，每个作业的 JM 也是运行在独立的进程中，负载相对小很多。
>
> 以上两种模式的共同问题是需要在客户端执行用户代码，编译生成对应的 Job Graph 提交到集群运行。在这个过程需要下载相关 jar 包并上传到集群，客户端和网络负载压力容易成为瓶颈，尤其当一个客户端被多个用户共享使用。
>
> 1.11.0 中引入了 application 模式（FLIP-85）来解决上述问题，按照 application 粒度来启动一个集群，属于这个 application 的所有 job 在这个集群中运行。核心是 Job Graph 的生成以及作业的提交不在客户端执行，而是转移到 JM 端执行，这样网络下载上传的负载也会分散到集群中，不再有上述 client 单点上的瓶颈。
>
> 用户可以通过 bin/flink run-application 来使用 application 模式，目前 Yarn 和 Kubernetes（K8s）都已经支持这种模式。Yarn application 会在客户端将运行作业需要的依赖都通过 Yarn Local Resource 传递到 JM。K8s application 允许用户构建包含用户 jar 与依赖的镜像，同时会根据作业自动创建 TM，并在结束后销毁整个集群，相比 session 模式具有更好的隔离性。K8s 不再有严格意义上的 per-job 模式，application 模式相当于 per-job 在集群进行提交作业的实现。
>
> 除了支持 application 模式，Flink 原生 K8s 在 1.11.0 中还完善了很多基础的功能特性（FLINK-14460），以达到生产可用性的标准。例如 Node Selector、Label、Annotation、Toleration 等。为了更方便的与 Hadoop 集成，也支持根据环境变量自动挂载 Hadoop 配置的功能。

Checkpoint & Savepoint 优化

> checkpoint 和 savepoint 机制一直是 Flink 保持先进性的核心竞争力之一，社区在这个领域的改动很谨慎，最近的几个大版本中几乎没有大的功能和架构上的调整。在用户邮件列表中，我们经常能看到用户反馈和抱怨的相关问题：比如 checkpoint 长时间做不出来失败，savepoint 在作业重启后不可用等等。1.11.0 有选择的解决了一些这方面的常见问题，提高生产可用性和稳定性。
>
> 1.11.0 之前， savepoint 中 meta 数据和 state 数据分别保存在两个不同的目录中，这样如果想迁移 state 目录很难识别这种映射关系，也可能导致目录被误删除，对于目录清理也同样有麻烦。1.11.0 把两部分数据整合到一个目录下，这样方便整体转移和复用。另外，之前 meta 引用 state 采用的是绝对路径，这样 state 目录迁移后路径发生变化也不可用，1.11.0 把 state 引用改成了相对路径解决了这个问题（FLINK-5763），这样 savepoint 的管理维护、复用更加灵活方便。
>
> 实际生产环境中，用户经常遭遇 checkpoint 超时失败、长时间不能完成带来的困扰。一旦作业 failover 会造成回放大量的历史数据，作业长时间没有进度，端到端的延迟增加。1.11.0 从不同维度对 checkpoint 的优化和提速做了改进，目标实现分钟甚至秒级的轻量型 checkpoint。
>
> 首先，增加了 Checkpoint Coordinator 通知 task 取消 checkpoint 的机制（FLINK-8871），这样避免 task 端还在执行已经取消的 checkpoint 而对系统带来不必要的压力。同时 task 端放弃已经取消的 checkpoint，可以更快的参与执行 coordinator 新触发的 checkpoint，某种程度上也可以避免新 checkpoint 再次执行超时而失败。这个优化也对后面默认开启 local recovery 提供了便利，task 端可以及时清理失效 checkpoint 的资源。
>
> 在反压场景下，整个数据链路堆积了大量 buffer，导致 checkpoint barrier 排在数据 buffer 后面，不能被 task 及时处理对齐，也就导致了 checkpoint 长时间不能执行。1.11.0 中从两个维度对这个问题进行解决：
>
> 1）尝试减少数据链路中的 buffer 总量（FLINK-16428），这样 checkpoint barrier 可以尽快被处理对齐。
>
> 上游输出端控制单个 sub partition 堆积 buffer 的最大阈值（backlog），避免负载不均场景下单个链路上堆积大量 buffer。在不影响网络吞吐性能的情况下合理修改上下游默认的 buffer 配置。上下游数据传输的基础协议进行了调整，允许单个数据链路可以配置 0 个独占 buffer 而不死锁，这样总的 buffer 数量和作业并发规模解耦。根据实际需求在吞吐性能和 checkpoint 速度两者之间权衡，自定义 buffer 配比。这个优化有一部分工作已经在 1.11.0 中完成，剩余部分会在下个版本继续推进完成。
>
> 2）实现了全新的 unaligned checkpoint 机制（FLIP-76）从根本上解决了反压场景下 checkpoint barrier 对齐的问题。
>
> 实际上这个想法早在 1.10.0 版本之前就开始酝酿设计，由于涉及到很多模块的大改动，实现机制和线程模型也很复杂。我们实现了两种不同方案的原型 POC 进行了测试、性能对比，确定了最终的方案，因此直到 1.11.0 才完成了 MVP 版本，这也是 1.11.0 中执行引擎层唯一的一个重量级 feature。其基本思想可以概括为：
>
> Checkpoint barrier 跨数据 buffer 传输，不在输入输出队列排队等待处理，这样就和算子的计算能力解耦，barrier 在节点之间的传输只有网络延时，可以忽略不计。每个算子多个输入链路之间不需要等待 barrier 对齐来执行 checkpoint，第一个到的 barrier 就可以提前触发 checkpoint，这样可以进一步提速 checkpoint，不会因为个别链路的延迟而影响整体。
>
> 为了和之前 aligned checkpoint 的语义保持一致，所有未被处理的输入输出数据 buffer 都将作为 channel state 在 checkpoint 执行时进行快照持久化，在 failover 时连同 operator state 一同进行恢复。
>
> 换句话说，aligned 机制保证的是 barrier 前面所有数据必须被处理完，状态实时体现到 operator state 中；而 unaligned 机制把 barrier 前面的未处理数据所反映的 operator state 延后到 failover restart 时通过 channel state 回放进行体现，从状态恢复的角度来说最终都是一致的。 注意这里虽然引入了额外的 in-flight buffer 的持久化，但是这个过程实际是在 checkpoint 的异步阶段完成的，同步阶段只是进行了轻量级的 buffer 引用，所以不会过多占用算子的计算时间而影响吞吐性能。
>
> Unaligned checkpoint 在反压严重的场景下可以明显加速 checkpoint 的完成时间，因为它不再依赖于整体的计算吞吐能力，而和系统的存储性能更加相关，相当于计算和存储的解耦。但是它的使用也有一定的局限性，它会增加整体 state 的大小，对存储 IO 带来额外的开销，因此在 IO 已经是瓶颈的场景下就不太适合使用 unaligned checkpoint 机制。
>
> 1.11.0 中 unaligned checkpoint 还没有作为默认模式，需要用户手动配置来开启，并且只在 exactly-once 模式下生效。但目前还不支持 savepoint 模式，因为 savepoint 涉及到作业的 rescale 场景，channel state 目前还不支持 state 拆分，在后面的版本会进一步支持，所以 savepoint 目前还是会使用之前的 aligned 模式，在反压场景下有可能需要很长时间才能完成。

#### Flink 1.12 版本
- 在 DataStream API 上添加了高效的批执行模式的支持。这是批处理和流处理实现真正统一的运行时的一个重要里程碑。

- 实现了基于Kubernetes的高可用性（HA）方案，作为生产环境中，ZooKeeper方案之外的另外一种选择。

- 扩展了 Kafka SQL connector，使其可以在 upsert 模式下工作，并且支持在 SQL DDL 中处理 connector 的 metadata。现在，时态表 Join 可以完全用 SQL 来表示，不再依赖于 Table API 了。

- PyFlink 中添加了对于 DataStream API 的支持，将 PyFlink 扩展到了更复杂的场景，比如需要对状态或者定时器 timer 进行细粒度控制的场景。除此之外，现在原生支持将 PyFlink 作业部署到 Kubernetes上。

1. DataStream API 支持批执行模式

Flink 的核心 API 最初是针对特定的场景设计的，尽管 Table API / SQL 针对流处理和批处理已经实现了统一的 API，但当用户使用较底层的 API 时，仍然需要在批处理（DataSet API）和流处理（DataStream API）这两种不同的 API 之间进行选择。鉴于批处理是流处理的一种特例，将这两种 API 合并成统一的 API，有一些非常明显的好处，比如：

> 可复用性：作业可以在流和批这两种执行模式之间自由地切换，而无需重写任何代码。因此，用户可以复用同一个作业，来处理实时数据和历史数据。
>
> 维护简单：统一的 API 意味着流和批可以共用同一组 connector，维护同一套代码，并能够轻松地实现流批混合执行，例如 backfilling 之类的场景。
>
> 考虑到这些优点，社区已朝着流批统一的 DataStream API 迈出了第一步：支持高效的批处理（FLIP-134）。从长远来看，这意味着 DataSet API 将被弃用（FLIP-131），其功能将被包含在 DataStream API 和 Table API / SQL 中。

有限流上的批处理

> 您已经可以使用 DataStream API 来处理有限流（例如文件）了，但需要注意的是，运行时并不“知道”作业的输入是有限的。为了优化在有限流情况下运行时的执行性能，新的 BATCH 执行模式，对于聚合操作，全部在内存中进行，且使用 sort-based shuffle（FLIP-140）和优化过的调度策略（请参见 Pipelined Region Scheduling 了解更多详细信息）。因此，DataStream API 中的 BATCH 执行模式已经非常接近 Flink 1.12 中 DataSet API 的性能。有关性能的更多详细信息，请查看 FLIP-140。

在 Flink 1.12 中，默认执行模式为 STREAMING，要将作业配置为以 BATCH 模式运行，可以在提交作业的时候，设置参数 execution.runtime-mode：

`$ bin/flink run -Dexecution.runtime-mode=BATCH examples/streaming/WordCount.jar`

或者通过编程的方式:

```java
StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
env.setRuntimeMode(RuntimeMode.BATCH);
```


注意：尽管 DataSet API 尚未被弃用，但我们建议用户优先使用具有 BATCH 执行模式的 DataStream API 来开发新的批作业，并考虑迁移现有的 DataSet 作业。

2. 新的 Data Sink API (Beta)

之前发布的 Flink 版本中，已经支持了 source connector 工作在流批两种模式下，因此在 Flink 1.12 中，社区着重实现了统一的 Data Sink API（FLIP-143）。新的抽象引入了 write/commit 协议和一个更加模块化的接口。Sink 的实现者只需要定义 what 和 how：SinkWriter，用于写数据，并输出需要 commit 的内容（例如，committables）；Committer 和 GlobalCommitter，封装了如何处理 committables。框架会负责 when 和 where：即在什么时间，以及在哪些机器或进程中 commit。

这种模块化的抽象允许为 BATCH 和 STREAMING 两种执行模式，实现不同的运行时策略，以达到仅使用一种 sink 实现，也可以使两种模式都可以高效执行。Flink 1.12 中，提供了统一的 FileSink connector，以替换现有的 StreamingFileSink connector （FLINK-19758）。其它的 connector 也将逐步迁移到新的接口。

3. 基于 Kubernetes 的高可用 (HA) 方案

Flink 可以利用 Kubernetes 提供的内置功能来实现 JobManager 的 failover，而不用依赖 ZooKeeper。为了实现不依赖于 ZooKeeper 的高可用方案，社区在 Flink 1.12（FLIP-144）中实现了基于 Kubernetes 的高可用方案。该方案与 ZooKeeper 方案基于相同的接口，并使用 Kubernetes 的 ConfigMap对象来处理从 JobManager 的故障中恢复所需的所有元数据。关于如何配置高可用的 standalone 或原生 Kubernetes 集群的更多详细信息和示例，请查阅文档。

注意：需要注意的是，这并不意味着 ZooKeeper 将被删除，这只是为 Kubernetes 上的 Flink 用户提供了另外一种选择。

4. 其它功能改进

将现有的 connector 迁移到新的 Data Source API

> 在之前的版本中，Flink 引入了新的 Data Source API（FLIP-27），以允许实现同时适用于有限数据（批）作业和无限数据（流）作业使用的 connector 。在 Flink 1.12 中，社区从 FileSystem connector（FLINK-19161）出发，开始将现有的 source connector 移植到新的接口。
>
> 注意: 新的 source 实现，是完全不同的实现，与旧版本的实现不兼容。

Pipelined Region 调度 (FLIP-119)

> 在之前的版本中，Flink 对于批作业和流作业有两套独立的调度策略。Flink 1.12 版本中，引入了统一的调度策略， 该策略通过识别 blocking 数据传输边，将 ExecutionGraph 分解为多个 pipelined region。这样一来，对于一个 pipelined region 来说，仅当有数据时才调度它，并且仅在所有其所需的资源都被满足时才部署它；同时也可以支持独立地重启失败的 region。对于批作业来说，新策略可显著地提高资源利用率，并消除死锁。

支持 Sort-Merge Shuffle (FLIP-148)

> 为了提高大规模批作业的稳定性、性能和资源利用率，社区引入了 sort-merge shuffle，以替代 Flink 现有的实现。这种方案可以显著减少 shuffle 的时间，并使用较少的文件句柄和文件写缓存（这对于大规模批作业的执行非常重要）。在后续版本中（FLINK-19614），Flink 会进一步优化相关性能。
>
> 注意：该功能是实验性的，在 Flink 1.12 中默认情况下不启用。要启用 sort-merge shuffle，需要在 TaskManager 的网络配置中设置合理的最小并行度。

Flink WebUI 的改进 (FLIP-75)

> 作为对上一个版本中，Flink WebUI 一系列改进的延续，Flink 1.12 在 WebUI 上暴露了 JobManager 内存相关的指标和配置参数（FLIP-104）。对于 TaskManager 的指标页面也进行了更新，为 Managed Memory、Network Memory 和 Metaspace 添加了新的指标，以反映自 Flink 1.10（FLIP-102）开始引入的 TaskManager 内存模型的更改[7]。

5. Table API/SQL 变更

SQL Connectors 中的 Metadata 处理

> 如果可以将某些 source（和 format）的元数据作为额外字段暴露给用户，对于需要将元数据与记录数据一起处理的用户来说很有意义。一个常见的例子是 Kafka，用户可能需要访问 offset、partition 或 topic 信息、读写 kafka 消息中的 key 或 使用消息 metadata中的时间戳进行时间相关的操作。
>
> 在 Flink 1.12 中，Flink SQL 支持了元数据列用来读取和写入每行数据中 connector 或 format 相关的列（FLIP-107）。这些列在 CREATE TABLE 语句中使用 METADATA（保留）关键字来声明。

```sql
CREATE TABLE kafka_table (
id BIGINT,
name STRING,
event_time TIMESTAMP(3) METADATA FROM 'timestamp', -- access Kafka 'timestamp' metadata
headers MAP METADATA -- access Kafka 'headers' metadata
) WITH (
'connector' = 'kafka',
'topic' = 'test-topic',
'format' = 'avro'
);
```

> 在 Flink 1.12 中，已经支持 Kafka 和 Kinesis connector 的元数据，并且 FileSystem connector 上的相关工作也已经在计划中（FLINK-19903）。由于 Kafka record 的结构比较复杂，社区还专门为 Kafka connector 实现了新的属性，以控制如何处理键／值对。关于 Flink SQL 中元数据支持的完整描述，请查看每个 connector 的文档以及 FLIP-107 中描述的用例。

Upsert Kafka Connector

> 在某些场景中，例如读取 compacted topic 或者输出（更新）聚合结果的时候，需要将 Kafka 消息记录的 key 当成主键处理，用来确定一条数据是应该作为插入、删除还是更新记录来处理。为了实现该功能，社区为 Kafka 专门新增了一个 upsert connector（upsert-kafka），该 connector 扩展自现有的 Kafka connector，工作在 upsert 模式（FLIP-149）下。新的 upsert-kafka connector 既可以作为 source 使用，也可以作为 sink 使用，并且提供了与现有的 kafka connector 相同的基本功能和持久性保证，因为两者之间复用了大部分代码。
>
> 要使用 upsert-kafka connector，必须在创建表时定义主键，并为键（key.format）和值（value.format）指定序列化反序列化格式。完整的示例，请查看最新的文档。

SQL 中 支持 Temporal Table Join

> 在之前的版本中，用户需要通过创建时态表函数（temporal table function） 来支持时态表 join（temporal table join） ，而在 Flink 1.12 中，用户可以使用标准的 SQL 语句 FOR SYSTEM_TIME AS OF（SQL：2011）来支持 join。此外，现在任意包含时间列和主键的表，都可以作为时态表，而不仅仅是 append-only 表。这带来了一些新的应用场景，比如将 Kafka compacted topic 或数据库变更日志（来自 Debezium 等）作为时态表。

```sql
CREATE TABLE orders (
    order_id STRING,
    currency STRING,
    amount INT,              
    order_time TIMESTAMP(3),                
    WATERMARK FOR order_time AS order_time - INTERVAL '30' SECOND
) WITH (
  …
);

-- Table backed by a Kafka compacted topic
CREATE TABLE latest_rates ( 
    currency STRING,
    rate DECIMAL(38, 10),
    currency_time TIMESTAMP(3),
    WATERMARK FOR currency_time AS currency_time - INTERVAL ‘5’ SECOND,
    PRIMARY KEY (currency) NOT ENFORCED      
) WITH (
  'connector' = 'upsert-kafka',
  …
);

-- Event-time temporal table join
SELECT 
  o.order_id,
  o.order_time,
  o.amount * r.rate AS amount,
  r.currency
FROM orders AS o, latest_rates FOR SYSTEM_TIME AS OF o.order_time r
ON o.currency = r.currency;
```

> 上面的示例同时也展示了如何在 temporal table join 中使用 Flink 1.12 中新增的 upsert-kafka connector。

使用 Hive 表进行 Temporal Table Join

> 用户也可以将 Hive 表作为时态表来使用，Flink 既支持自动读取 Hive 表的最新分区作为时态表（FLINK-19644），也支持在作业执行时追踪整个 Hive 表的最新版本作为时态表。请参阅文档，了解更多关于如何在 temporal table join 中使用 Hive 表的示例。

Table API/SQL 中的其它改进：

Kinesis Flink SQL Connector (FLINK-18858)

> 从 Flink 1.12 开始，Table API / SQL 原生支持将 Amazon Kinesis Data Streams（KDS）作为 source 和 sink 使用。新的 Kinesis SQL connector 提供了对于增强的Fan-Out（EFO）以及 Sink Partition 的支持。如需了解 Kinesis SQL connector 所有支持的功能、配置选项以及对外暴露的元数据信息，请查看最新的文档。

在 FileSystem/Hive connector 的流式写入中支持小文件合并 (FLINK-19345)

> 很多 bulk format，例如 Parquet，只有当写入的文件比较大时，才比较高效。当 checkpoint 的间隔比较小时，这会成为一个很大的问题，因为会创建大量的小文件。在 Flink 1.12 中，File Sink 增加了小文件合并功能，从而使得即使作业 checkpoint 间隔比较小时，也不会产生大量的文件。要开启小文件合并，可以按照文档[11]中的说明在 FileSystem connector 中设置 auto-compaction = true 属性。

Kafka Connector 支持 Watermark 下推 (FLINK-20041)

> 为了确保使用 Kafka 的作业的结果的正确性，通常来说，最好基于分区来生成 watermark，因为分区内数据的乱序程度通常来说比分区之间数据的乱序程度要低很多。Flink 现在允许将 watermark 策略下推到 Kafka connector 里面，从而支持在 Kafka connector 内部构造基于分区的 watermark[12]。一个 Kafka source 节点最终所产生的 watermark 由该节点所读取的所有分区中的 watermark 的最小值决定，从而使整个系统可以获得更好的（即更接近真实情况）的 watermark。该功能也允许用户配置基于分区的空闲检测策略，以防止空闲分区阻碍整个作业的 event time 增长。

新增的 Formats

利用 Multi-input 算子进行 Join 优化 (FLINK-19621)

> Shuffling 是一个 Flink 作业中最耗时的操作之一。为了消除不必要的序列化反序列化开销、数据 spilling 开销，提升 Table API / SQL 上批作业和流作业的性能， planner 当前会利用上一个版本中已经引入的N元算子（FLIP-92），将由 forward 边所连接的多个算子合并到一个 Task 里执行。

Type Inference for Table API UDAFs (FLIP-65)

> Flink 1.12 完成了从 Flink 1.9 开始的，针对 Table API 上的新的类型系统[2]的工作，并在聚合函数（UDAF）上支持了新的类型系统。从 Flink 1.12 开始，与标量函数和表函数类似，聚合函数也支持了所有的数据类型。

6. PyFlink: Python DataStream API

为了扩展 PyFlink 的可用性，Flink 1.12 提供了对于 Python DataStream API（FLIP-130）的初步支持，该版本支持了无状态类型的操作（例如 Map，FlatMap，Filter，KeyBy 等）。如果需要尝试 Python DataStream API，可以安装PyFlink，然后按照该文档[14]进行操作，文档中描述了如何使用 Python DataStream API 构建一个简单的流应用程序。

```python
from pyflink.common.typeinfo import Types
from pyflink.datastream import MapFunction, StreamExecutionEnvironment
class MyMapFunction(MapFunction):
    def map(self, value):
        return value + 1
env = StreamExecutionEnvironment.get_execution_environment()
data_stream = env.from_collection([1, 2, 3, 4, 5], type_info=Types.INT())
mapped_stream = data_stream.map(MyMapFunction(), output_type=Types.INT())
mapped_stream.print()
env.execute("datastream job")
```

7. PyFlink 中的其它改进

PyFlink Jobs on Kubernetes (FLINK-17480)

> 除了 standalone 部署和 YARN 部署之外，现在也原生支持将 PyFlink 作业部署在 Kubernetes 上。最新的文档中详细描述了如何在 Kubernetes 上启动 session 或 application 集群。

用户自定义聚合函数 (UDAFs)

> 从 Flink 1.12 开始，您可以在 PyFlink 作业中定义和使用 Python UDAF 了（FLIP-139）。普通的 UDF（标量函数）每次只能处理一行数据，而 UDAF（聚合函数）则可以处理多行数据，用于计算多行数据的聚合值。您也可以使用 Pandas UDAF（FLIP-137），来进行向量化计算（通常来说，比普通 Python UDAF 快10倍以上）。
>
> 注意: 普通 Python UDAF，当前仅支持在 group aggregations 以及流模式下使用。如果需要在批模式或者窗口聚合中使用，建议使用 Pandas UDAF。

#### Flink 1.13 版本


#### Flink 1.14 版本


#### Flink 1.15 版本


### 程序调优

##### 反压/背压

back pressure 背压概念：
    当数据流启动时，数据源把一行行/条条数据填到一个类似桶的缓存中（buffer）
    一旦缓存（buffer）满了，桶就顺着流水线流到下游组件（component）中，流处理引擎
    会拿来一个新的空缓存（空桶），源数据不知道这一切，只会不停填桶...
    如果transformation和driver来不及处理这些数据，流处理引擎会启动反压机制，让数据源睡眠/等待
    当流水线又有空余的桶（缓存）后，源数据被唤醒继续往桶里填数据。

背压传播的趋势：
一个任务的back pressure警告（high），则意味着该任务产生数据的速度要高于下游Operator消化的速度
数据沿着job的数据流图向下游流动（如从source到sink），而背压则是沿着相反的方向传播，逆流而上，可以理解为 水流漫上去

flink  反压机制（backpressure）
产生原因：短时负载高峰导致系统接收数据的速率远高于它处理数据的速率
        flink利用自身作为纯数据流引擎的优势来优雅地响应反压问题
Q：Flink 是如何在 Task 之间传输数据的，以及数据流如何实现自然降速？
运行时： 
    operators组件  
        每个operator会消费中间态的流，并在流上进行转换，然后生成新的流
    streams组件

Flink中的反压：
    Flink 使用了高效有界的分布式阻塞队列，就像Java通用的阻塞队列（BlockingQueue）
        Java使用BlockingQueue时：一个较慢的接受者会降低发送者的发送速率，因为一旦队列
        满了（有界队列）发送者会被阻塞
在 Flink 中，这些分布式阻塞队列就是这些逻辑流，而队列容量是通过缓冲池来（LocalBufferPool）实现的
每个生产和被消费的流都会被分配一个缓冲池。
缓冲池管理着一组缓冲（Buffer），缓冲在被消费后可以被回收循环利用。

Flink 如何处理背压？
Flink与持久化的source（例如kafka），能够为你提供即时的背压处理。而无需担心数据丢失。
Flink不需要一个特殊的机制来处理背压。因为Flink中的数据传输相当于已经提供了应对背压的机制。
因此，Flink所获得的最大吞吐量由其pipeline中最慢的部件决定

##### flink内存管理

主流实时计算框架都是基于jvm语言开发的（Java Scala）
为了加快计算，通常都是将数据加载在内存中，由于数据量巨大，对内存造成很大压力

==数据存储==
最简单做法试封装成对象直接存储在List或Map这样的数据结构中（公司从mq中拿到的实时计算生产到的数据通过消费者程序写入到hbase kafka  json  map  list（map） hbase）

引发两个问题？
1：数据规模大时，需要创建的对象非常多（数据加上存储的数据结构，耗费大量内存）
    可能引发OOM
2：源源不断的数据需要被处理，对象持续产生并需要被销毁
    GC压力大
SO：
JVM自带的GC无法满足高效+稳定的流处理，Flink建立一套自己的内存管理体系

Flink将内存分为3个部分（network buffers，Memory Manager pool，Remaining Heap）
每个部分都有不同用途;
1：Network buffers：一些以32KB Byte数组为单位的buffer，主要被网络模块用于数据的网络传输。
    在Flink中主要是基于Netty进行网络传输
2：Memory Manager pool大量以32KB Byte数组为单位的内存池，所有的运行时算法（例如Sort/Shuffle/Join）都从这个内存池申请内存，
       并将序列化后的数据存储其中，结束后释放回内存池
   内存池，由多个MemorySegment组成，每个MemorySegment代表一块连续的内存空间 byte[]数据结构存储  默认32kb

3：Remaining（Free）Heap主要留给UDF中用户自己创建的Java对象，由JVM管理。
    用在UDF中用户自己创建的对象 在UDF中，用户流式的处理数据 并不需要太大内存
    同时flink也不建议在UDF中缓存很多数据


重点：
Flink的主动内存管理避免了令人讨厌的OutOfMemoryErrors杀死JVM并减少垃圾收集开销的问题。
Flink具有高效的数据去/序列化堆栈，有助于对二进制数据进行操作，并使更多数据适合内存。
Flink的DBMS风格的运算符本身在二进制数据上运行，在必要时可以在内存中高性能地转移到磁盘。

##### Flink 压力测试

雅虎15年测试：
Storm 能够承受每秒 40 万事件，但受限于 CPU； 
Flink 则可以达到每秒 300万事件（7.5 倍）但受限于 Kafka 集群和 Flink 集群之间的网络

--------------------------------------
Flink 的执行过程是基于流的，这意味着各个处理阶段有更多的重叠，并且混洗操作是流水线式的，因此磁盘访问操作
更少。相反， MapReduce、Tez和Spark是基于批的，这意味着数据在通过
网络传输之前必须先被写入磁盘。该测试说明，在使用 Flink 时，系统空闲时间和磁盘访问操作更少。

接收器  数据源 

Kafka position也是由Flink自己维护的

理想下  无边际数据流 源源不断来  按照时间窗口 计算  输出

现实情况是： 数据不是按时来的 有延迟

所以划分为事件时间  摄取时间  处理时间

NC市现场部署的flink作业，运行90d了也没出现问题，原因在于flink使用的是自己的内存管理体系
    中间出错挂掉，会自动重连并通过checkpoint检查点机制 重新计算




##### 怎样确定Flink集群所需资源

吞吐量：
估算预期进入流计算系统每秒的记录数（吞吐量），以及每条记录数的大小

不同key的数量以及每个key存储的state大小
key的数量和key所需state的大小，都将会影响Flink应用程序所需的资源。可以通过查看反压状态

状态的更新频率和状态后端的访问模式：
不同的状态后端（RocksDB，java Heap）的访问模式差距很大。RocksDB每次读取和更新会进行序列化
反序列化以及JNI操作，Java Heap不支持增量checkpoint，会导致状态大的场景每次持久化的数据量很大
都会影响Flink作业所需的资源

网络容量
网络容量不仅会受flink内部，也会受到Flink跟正在交互的kafka，hdfs等外部服务
比如启动kafka的replication会增加额外的网络容量

磁盘带宽
如果应用程序依赖 RocksDB Kafka  HDFS

机器数量以及可用的CPU和内存

另外需要提供额外的资源来保证：
当你的 Flink 发生故障时，系统会需要额外的资源来做恢复工作以及从 Kafka topic 或其他消息客户端追上最新的数据


#### DataStream性能调优

A：配置内存
    Flink是依赖内存计算，计算过程中内存不够对Flink的执行效率影响很大。可以通过监控GC
B：设置并行度
    并行度控制任务的数量，影响操作后数据被切分成的块数。调整并行度让任务的数量
    和每个任务处理的数据与机器的处理能力达到最优
    设置合适的parallelism能提高运算效率，太多了和太少了都不行
    
C：配置进程参数
    Flink on YARN模式下，有JobManager和TaskManager两种进程
    JobManager负责任务的调度，以及TaskManager、 RM之间的消息通信
    TaskManager的内存主要用于任务执行、通信
    每个TaskManager每个核同时能跑一个task，所以增加了TaskManager的个数相当于增大了任务的并发度
        --container 12 \    12个taskmanager 每个Container都是一个独立的进程
        --jobManagerMemory 10240 \  
        --taskManagerMemory 20480 \ 每个taskmanager有20G 内存  一共占用20G * 12  
        --slots 10 \    每个taskmanager10核，slot 内存隔离，CPU不隔离
        上述 每个slot的可用资源是2g
        这样的一个公共的yarn-session，可以发布多个flink 任务
每个算子一个slot，flink优化将多个算子的并行度实例进行链式操作，链式操作结束后
得到task，再作为一个调度执行单元，放到一个线程里执行
好处：避免频繁线程切换时，影响吞吐量

优化：保持分配给Job的资源不变的情况下将总Container数量减半
D：设计分区方法 （#####）
    设置分区是为了优化task的切分，在程序编写尽量分区均匀，避免数据倾斜，
    防止某个task的执行时间过长导致整个job执行缓慢
    1：随机分区 ，将元素随机地进行分区
    dataStream.shuffle()
    2：Rebalancing数据重分区
     基于round-robin对元素进行分区，使得每个分区负载均衡，十分有用
     dataStream.rebalance();
    3： Rescaling   以round-robin的形式将元素分区到下游操作的子集中
     dataStream.rescale();
    4：广播  广播每个元素到所有的分区
     dataStream.broadcast();
    5：自定义分区
      可以按照某个特征进行分区，从而优化任务执行
      DataStream<Tuple2<String， Integer>> dataStream = env.fromElements（Tuple2.of（"hello"，1)，
            Tuple2.of（"test"，2)， Tuple2.of（"world"，100));
    // 定义用于分区的key值，返回即属于哪个partition的，该值加1就是对应的子任务的id号
    Partitioner<Tuple2<String， Integer>> strPartitioner = new Partitioner<Tuple2<String，Integer>>() {
        @Override
        public int partition（Tuple2<String， Integer> key， int numPartitions) {
        return （key.f0.length() + key.f1) % numPartitions;
        }
    };
    // 使用Tuple2进行分区的key值
    dataStream.partitionCustom（strPartitioner， new KeySelector<Tuple2<String， Integer>，Tuple2<String， Integer>>() {
        @Override
        public Tuple2<String， Integer> getKey（Tuple2<String， Integer> value) throws Exception {
        return value;
        }
    }).print();
    调用rebalance/shuffle/ 会出现反压现象  实时其他的方式
    
    
配置netty网络
     慎调

总结：
    数据倾斜时：某一部分数据特别大，虽然没有GC，但是task执行时间严重不一致
                需要重新设计key，以更小的粒度的key使得task大小合理化
                修改并行度
                调用rebalance操作，使数据分区均匀
    缓冲区超时设置：
       task在执行过程中存在数据通过网络进行交换
       数据在不同服务器之间传递的缓冲区超时时间可以通过setBufferTimeout进行设置
    设置：
    env.setBufferTimeout（timeoutMillis);
    env.generateSequence（1，10).map（new MyMapper()).setBufferTimeout（timeoutMillis);



#### 程序优化

南昌 全流量计算优化：早晚高峰，数据延迟
     早高峰500-685/s   3w-4w/min
     晚高峰430-550/s   2w5-3w3/min
算子timeWindowAll 不是并行的，执行时是1个slot导致？   业务逻辑计算指标较多！
现在有两种思路：
1   创建yarn-session时，将slot 由10-->1  container12->6（12)   总的由120->6   240G 120G
    单个slot的算力  由 1/10的taskmanager的资源=2G   -->  taskmanager=20G  
    总量 taskmanager 240G + jobmanager 10G   注： 总量需要预留一部分用作恢复  
2   保存现有的yarn-session 
    现在增加到12个，会有6个闲置，数据倾斜
    增加到12slot ，使用重分区（难点） 将数据打散 解决数据倾斜后，仍然会出现反压的现象
    
反压问题是rebalance导致的，全流量计算滞后/数据没来完就被触发输出 是数据早高峰峰值太大导致的滞后/窗口barrier对齐时间太长
最后还是增加延迟时间的方式解决，去掉keyby操作和map对过车时间取余操作

现在解决思路 代码上：减少上游操作，过滤数据

原因是同集群的solr单表50亿条，GC频繁 导致CPU负载高

Solr冷热数据分离：分表  问题解决


### 怎样学习flink

1. 先对flink有宏观视野上理解，看阿里大会整理的文档资料，其中也有可运行的demo。
2. 看各个flink 大V的博客，对架构和原理逐步深入理解（可以微信和google搜索关键词）
3. 英文好，最好是看Apache flink官网文档，既全面又权威（先看前面后看官网，国人帮整理，理解速度会快些）
4. 基于以上3方面理解基础上，自己有相当的技术基础及理解能力 + 毅力恒心 + 热爱程度，可以去啃下源代码。基本问题不大（往下又分2种情况：1.有基础曾经研究并扩展过开源代码；2.无基础 无经验  花费时间就要长些，需要毅力，有人指点会快些。）
5. 提高解决问题的能力。


##### flink知识点
state  checkpoint  time  window  watermark  processFunction
join trigger sideoutput   sink  source   asyncio
table  sql   cep

##### Chandy-Lamport 算法
将流计算看作成一个流式的拓扑，定期在这个拓扑的头部source点开始插入特殊的barriers（栅栏），从上游开始不断向下游广播这个Barriers。每一个节点收到所有的barriers，会将state做一次snapshot（快照）。当每个节点都做完Snapshot之后，整个拓扑就算做完一次checkpoint。接下来不管出现任何故障，都会从最近的checkpoint进行恢复。

Flink用这套算法，保证了强一致性的语义，也是 Flink 区别于其他无状态流计算引擎的核心区别。
    

#### 实时计算的趋势 StreamSQL
实时任务SQL化

阿里的实时计算方案就是Flink SQL   1CU  一天6 RMB

使用sql 开发实时计算程序


##### 源表 && 维表 && 结果表
源表： 流数据分析的源表是指流式数据存储，流式数据存储驱动流数据分析的运行  相当于ods层

事实表&&维表   dwd层

事实表：事实表是数据聚合后依据某个维度生成的结果表，一般很大。

维表：对数据分析时所用的一个量，你可以选择按类别来进行分析，或按区域来分析。 这样的按..分析就构成一个维度。

结果表： 数据统计后的结果        dws层

mysql phoenix 

#### Flink CEP

复杂事件处理，模式匹配

flink 的 CEP 跟 DataStream Api 都是对流式数据处理，有什么区别？

- CEP：更看重流式数据中查找，也就是对源数据不做处理；
- DataStream：更看重对数据的加工和处理，一般不会在数据中查找匹配。


#### 华为大数据平台flink安全模式部署

##### kerberos + flink

3个月证书过期需要重新生成认证证书，同时替换掉原有的文件，flink-conf.yaml文件需要修改配置。旧的yarn-session已经连不上，原有任务还能在上面跑 ，需要使用新的证书发布yarn-session 继而发布任务。





