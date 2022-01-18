## hive

Apache Hive 是一种数据仓库，可以非常方便的使用 SQL 去读、写、管理存储在分布式式系统的大数据。用户可以使用一个命令行工具和 JDBC 去连接到 Hive。

Hive 表面是使用 SQL 像在数据库中查询数据一样从 HDFS 查询数据。本质是，Hive 把 SQL 转换成 MapReduce 程序去执行相应的操作，并返回结果。

由Facebook开源，最初用于解决海量结构化的日志数据统计问题。

Hive定义了一种类SQL查询语言：HQL（类似SQL但不完全相同）。

### 概述

Hive 的设计初衷是：

- 对于大量的数据，使得数据汇总，查询和分析更加简单。
- 它提供 SQL，允许用户更加简单的进行查询，汇总和数据分析。
- 对用户的复杂需求，Hive 的 SQL 允许用户来集成自己的功能，做定制化的查询。例如使用自定义函数(User Defined Functions，UDFs)

Hive 产生背景：

- MapReduce编程的不便性。
- HDFS上的文件缺少Schema(表名，名称，ID等，为数据库对象的集合)。


### 架构

Hive 通过给用户提供的一系列交互接口，接收到用户的指令(SQL)，使用自己的Driver，结合元数据(MetaStore)，将这些指令翻译成MapReduce，提交到Hadoop中执行，最后，将执行返回的结果输出到用户交互接口。

主要分 4 部分:

1. 用户接口：Client<br>
    CLI（hive shell）、JDBC/ODBC(java访问hive)、WEB UI（浏览器访问hive）
2. 元数据：Metastore<br>
    元数据包括：表名、表所属的数据库（默认是default）、表的拥有者、列/分区字段、表的类型（是否是外部表）、表的数据所在目录等；<br>
    默认存储在自带的derby数据库中，推荐使用MySQL存储Metastore
3. 驱动器：Driver
    1. 解析器（SQL Parser）：将SQL字符串转换成抽象语法树AST，这一步一般都用第三方工具库完成，比如antlr；对AST进行语法分析，比如表是否存在、字段是否存在、SQL语义是否有误。 
    2. 编译器（Physical Plan）：将AST编译生成逻辑执行计划。
    3. 优化器（Query Optimizer）：对逻辑执行计划进行优化。
    4. 执行器（Execution）：把逻辑执行计划转换成可以运行的物理计划。对于Hive来说，就是MR/Spark/Tez。
4. Hadoop<br>
    使用 HDFS 进行存储，使用 MapReduce 进行计算。

![hive 架构](images/hive0.png)

#### HiveService2

#### CLI

```java
CliDriver.main();
return executeDriver(ss, conf, oproc);
cli.processLine(line, true);
processCmd(command);
processFile(cmd_1);

ShellCmdExecutor executor = new ShellCmdExecutor(shell_cmd, ss.out, ss.err);
executor.execute();
Process executor = Runtime.getRuntime().exec(cmd);
executor.waitFor();

processLocalCmd(cmd, proc, ss);
CommandProcessor.run(cmd);
```

Driver 处理流程
```java
Driver.run(cmd);
CommandProcessorResponse cpr = runInternal(command, alreadyCompiled);
driverRunHook.preDriverRun(hookContext);

compileInternal(command, true);
ASTNode tree = ParseUtils.parse(command, ctx);

BaseSemanticAnalyzer sem = SemanticAnalyzerFactory.get(queryState, tree);

sem.analyze(tree, ctx);
analyzeInternal(ast);
PlanUtils.addInputsForView(pCtx);

transformations.add(new HiveOpConverterPostProc());

transformations.add(new Generator());

pCtx = t.transform(pCtx);

TableAccessAnalyzer tableAccessAnalyzer = new TableAccessAnalyzer(pCtx);

setTableAccessInfo(tableAccessAnalyzer.analyzeTableAccess());

Optimizer optm = new Optimizer();

optm.setPctx(pCtx);

optm.initialize(conf);

pCtx = optm.optimize();

TaskCompiler compiler = TaskCompilerFactory.getCompiler(conf, pCtx);

compiler.init(queryState, console, db);

compiler.compile(pCtx, rootTasks, inputs, outputs);
optimizeOperatorPlan(pCtx, inputs, outputs);

FetchWork fetch = new FetchWork(loadFileDesc.getSourcePath(), resultTab, outerQueryLimit);

fetch.setHiveServerQuery(isHiveServerQuery);

fetch.setSource(pCtx.getFetchSource());

fetch.setSink(pCtx.getFetchSink());

generateTaskTree(rootTasks, pCtx, mvTask, inputs, outputs);
new GenMRTableScan1();
new GenMRRedSink1();
new GenMRRedSink2();
new GenMRFileSink1();
new GenMRUnion1();
new GenMRRedSink3();
MapJoinFactory.getTableScanMapJoin();
new GenMROperator();
DefaultRuleDispatcher.dispatch();
proc.process(nd, ndStack, procCtx, nodeOutputs);
GenMapRedUtils.initPlan(op, ctx);
GenMapRedUtils.splitPlan(op, ctx);

optimizeTaskPlan(rootTasks, pCtx, ctx);
PhysicalOptimizer physicalOptimizer = new PhysicalOptimizer(
    physicalContext, conf);
physicalOptimizer.optimize();
decideExecMode(rootTasks, ctx, globalLimitCtx);

enforceScanLimits(pCtx, origFetchTask);


sem.validate();

plan = new QueryPlan(queryStr, sem, perfLogger.getStartTime(PerfLogger.DRIVER_RUN), queryId,
    queryState.getHiveOperation(), schema);

plan.getFetchTask().initialize(queryState, plan, null, ctx.getOpContext());
work.initializeForFetch(opContext);

fetch = new FetchOperator(work, job, source, getVirtualColumns(source));

source.initialize(conf, new ObjectInspector[]{fetch.getOutputObjectInspector()});

ExecMapper.setDone(false);


ret = execute(true);

plan.setStarted();

// Query ID = hadoop_20211119135115_dec65e7d-3986-4bdd-b5be-d91fea6bf342
// Total jobs = 1

DriverContext driverCxt = new DriverContext(ctx);

driverCxt.prepare(plan);

task = driverCxt.getRunnable(maxthreads);

TaskRunner runner = launchTask(task, queryId, noName, jobname, jobs, driverCxt);
// Launching Job 1 out of 1
tsk.initialize(queryState, plan, cxt, ctx.getOpContext());

TaskRunner tskRun = new TaskRunner(tsk, tskRes);

tskRun.start();
tsk.executeTask();

// 省略各种task执行

TaskRunner tskRun = driverCxt.pollFinished();

hookContext.addCompleteTask(tskRun);

driverCxt.finished(tskRun);

releasePlan(plan);
plan.setDone();

Map<String, MapRedStats> stats = SessionState.get().getMapRedStats();
// MapReduce Jobs Launched:
// Stage-Stage-1: Map: 1  Reduce: 1   Cumulative CPU: 6.69 sec   HDFS Read: 2569 HDFS Write: 105 SUCCESS
// Total MapReduce CPU Time Spent: 6 seconds 690 msec

// OK


driverRunHook.postDriverRun(hookContext);
```

SerializationUtilities.serializePlan(plan, out);
executor = Runtime.getRuntime().exec(cmdLine, env, new File(workDir));

MapRedTask 执行流程
```java
MapRedTask.this.execute();
setNumberOfReducers();
// Number of reduce tasks determined at compile time: 1
// 
// In order to change the average load for a reducer (in bytes):
//   set hive.exec.reducers.bytes.per.reducer=<number>
// In order to limit the maximum number of reducers:
//   set hive.exec.reducers.max=<number>
// In order to set a constant number of reducers:
//   set mapreduce.job.reduces=<number>

inputSummary = Utilities.getInputSummary(driverContext.getCtx(), work.getMapWork(), null);
int numExecutors = getMaxExecutorsForInputListing(ctx.getConf(), pathNeedProcess.size());

double samplePercentage = Utilities.getHighestSamplePercentage(work.getMapWork());

totalInputFileSize = Utilities.getTotalInputFileSize(inputSummary, work.getMapWork(), samplePercentage);

totalInputNumFiles = Utilities.getTotalInputNumFiles(inputSummary, work.getMapWork(), samplePercentage);

int ret = super.execute(driverContext);
MapWork mWork = work.getMapWork();

ReduceWork rWork = work.getReduceWork();

HiveFileFormatUtils.prepareJobOutput(job);

job.setOutputFormat(HiveOutputFormatImpl.class);

job.setMapperClass(ExecMapper.class);

job.setMapOutputKeyClass(HiveKey.class);

job.setMapOutputValueClass(BytesWritable.class);

job.setPartitionerClass(JavaUtils.loadClass(partitioner));

propagateSplitSettings(job, mWork);

job.setReducerClass(ExecReducer.class);

setInputAttributes(job);

job.setInputFormat(JavaUtils.loadClass(inpFormat));

job.setOutputKeyClass(Text.class);

job.setOutputValueClass(Text.class);

Utilities.setInputPaths(job, inputPaths);

Utilities.setMapRedWork(job, work, ctx.getMRTmpPath());

handleSampling(ctx, mWork, job);

jc = new JobClient(job);

Throttle.checkJobTracker(job, LOG);

// 提交 job 类似于shell的hadoop jar
rj = jc.submitJob(job);

returnVal = jobExecHelper.progress(rj, jc, ctx);
runningJobs.add(rj);

jobInfo(rj);
// Starting Job = job_1635995641146_96916, Tracking URL = http://emr-header-1.cluster-245192:20888/proxy/application_1635995641146_96916/
// Kill Command = /usr/lib/hadoop-current/bin/hadoop job  -kill job_1635995641146_96916

MapRedStats mapRedStats = progress(th);
while (!rj.isComplete()) {
    // Hadoop job information for Stage-3: number of mappers: 1; number of reducers: 1
    updateCounters(ctrs, rj);
    if (mapProgress == lastMapProgress && reduceProgress == lastReduceProgress &&
      System.currentTimeMillis() < reportTime + maxReportInterval) {
        continue;
    }
    // 2021-11-19 13:53:33,524 Stage-3 map = 0%,  reduce = 0%, Cumulative CPU 59.0 sec
    // 2021-11-21 14:39:24,663 Stage-1 map = 100%,  reduce = 100%, Cumulative CPU 6.69 sec
    // MapReduce Total cumulative CPU time: 6 seconds 690 msec
}


Counters ctrs = th.getCounters();

updateCounters(ctrs, rj);


computeReducerTimeStatsPerJob(rj);

String statusMesg = getJobEndMsg(rj.getID());
// Ended Job = job_1635995641146_97403
```

##### Beeline
Hive 0.11引入，作为Hive JDBC Client访问HiveServer2，解决了CLI并发访问问题。

JDBC的本质是一个HiveServer2的Thrift Client，只不过对用户暴露了JDBC接口。

#### Driver
对输入的sql字符串进行解析，转化程抽象语法树，再转化成逻辑计划Logicl Plan，然后使用优化工具对逻辑计划进行优化，最终生成物理计划Phsical plan（序列化反序列化，UDF函数），交给Execution执行引擎，提交到MapReduce上执行（输入和输出可以是本地的也可以是HDFS/Hbase）。

##### 流程

1. Parser：Antlr 定义 SQL 的语法规则，完成 SQL 词法，语法解析，将 SQL 转化为抽象语法树 AST Tree；会进行语法校验，AST本质还是字符串。
2. Analyzer：语法解析，遍历 AST Tree，抽象出查询的基本组成单元 QueryBlock。
    1. AST Tree生成后由于其复杂度依旧较高，不便于翻译为mapreduce程序，需要进行进一步抽象和结构化，形成QueryBlock。
    2. QueryBlock是一条SQL最基本的组成单元，包括三个部分：输入源，计算过程，输出。简单来讲一个QueryBlock就是一个子查询。
    3. QueryBlock的生成过程为一个递归过程，先序遍历 AST Tree ，遇到不同的 Token 节点(理解为特殊标记)，保存到相应的属性中。
3. Logicl Plan：逻辑执行计划解析，遍历 QueryBlock，翻译为执行操作树 OperatorTree。
    1. 基本的操作符包括：TableScanOperator，SelectOperator，FilterOperator，JoinOperator，GroupByOperator，ReduceSinkOperator
    2. Operator在Map Reduce阶段之间的数据传递都是一个流式的过程。每一个Operator对一行数据完成操作后之后将数据传递给childOperator计算。
    3. 由于Join/GroupBy/OrderBy均需要在Reduce阶段完成，所以在生成相应操作的Operator之前都会先生成一个ReduceSinkOperator，将字段组合并序列化为Reduce Key/value, Partition Key。
4. Logical optimizer:进行逻辑执行计划优化，进行 OperatorTree 变换，合并 Operator，达到减少 MapReduce Job，减少数据传输及 shuffle 数据量。
    1. 逻辑查询优化可以大致分为以下几类：投影修剪，推导传递谓词，谓词下推，将Select-Select，Filter-Filter合并为单个操作，多路 Join，查询重写以适应某些列值的Join倾斜。
5. Phsical plan：物理执行计划解析，遍历 OperatorTree，翻译为 MapReduce Job。
    1. 对输出表生成MoveTask
    2. 从OperatorTree的其中一个根节点向下深度优先遍历
    3. ReduceSinkOperator标示Map/Reduce的界限，多个Job间的界限
    4. 遍历其他根节点，遇过JoinOperator合并MapReduceTask
    5. 生成StatTask更新元数据
    6. 剪断Map与Reduce间的Operator的关系
6. Phsical Optimizer：进行物理执行计划优化，进行 MapReduce 任务的变换，生成优化后的tasktree，该任务即是集群上的执行的作业。
    1. 物理优化可以大致分为以下几类：
        1. 分区修剪(Partition Pruning)
        1. 基于分区和桶的扫描修剪(Scan pruning)
        1. 如果查询基于抽样，则扫描修剪
        1. 在某些情况下，在 map 端应用 Group By
        1. 在 mapper 上执行 Join
        1. 优化 Union，使Union只在 map 端执行
        1. 在多路 Join 中，根据用户提示决定最后流哪个表
        1. 删除不必要的 ReduceSinkOperators
        1. 对于带有Limit子句的查询，减少需要为该表扫描的文件数
        1. 对于带有Limit子句的查询，通过限制 ReduceSinkOperator 生成的内容来限制来自 mapper 的输出
        1. 减少用户提交的SQL查询所需的Tez作业数量
        1. 如果是简单的提取查询，避免使用MapReduce作业
        1. 对于带有聚合的简单获取查询，执行不带 MapReduce 任务的聚合
        1. 重写 Group By 查询使用索引表代替原来的表
        1. 当表扫描之上的谓词是相等谓词且谓词中的列具有索引时，使用索引扫描

解析器Parser：将SQL语句生成AST语法树。

编译器Compiler：对不同的查询块和查询表达式进行语义分析，并最终借助表和从 metastore 查找的分区元数据来生成执行计划。生成DAG形式的Job链，成为逻辑计划。

优化器：只提供了基于规则的优化

- 列过滤：去除查询中不需要的列。
- 行过滤：Where条件判断等在TableScan阶段就进行过滤，利用Partition信息，只读取符合条件的Partition。
- 谓词下推：减少后面的数据量。
- Join方式
    + Map端join： 调整Join顺序，确保以大表作为驱动表，小表载入所有mapper内存中
    + shuffle join：按照hash函数，将两张表的数据发送给join
    + 对于数据分布不均衡的表Group by时，为避免数据集中到少数的reducer上，分成两个map-reduce阶段。第一个阶段先用Distinct列进行shuffle，然后在reduce端部分聚合，减小数据规模，第二个map-reduce阶段再按group-by列聚合。
    + sort merge join：排序，按照顺序切割数据，相同的范围发送给相同的节点(运行前在后台创建立两张排序表，或者建表的时候指定)
    + 在map端用hash进行部分聚合，减小reduce端数据处理规模。

执行引擎：执行引擎Execution Engine将DAG转换为MR任务。执行引擎会顺序执行其中所有的Job，如果Job不存在依赖关系，采用并发的方式进行执行。

- 执行引擎负责提交 COMPILER 阶段编译好的执行计划到不同的平台上。
- Hive 底层支持多种不同的执行引擎：MapReduce、Tez、Spark。

如果是 map/reduce 作业，该计划包括 map operator trees 和一个  reduce operator tree，执行引擎将会把这些作业发送给 MapReduce ：

##### explain执行计划
HIVE提供了EXPLAIN命令来展示一个sql的执行计划，这个执行计划对于我们了解底层原理，hive 调优，排查数据倾斜等很有帮助。

使用语法如下：
`EXPLAIN [EXTENDED|CBO|AST|DEPENDENCY|AUTHORIZATION|LOCKS|VECTORIZATION|ANALYZE] query`

- EXTENDED：加上 extended 可以输出有关计划的额外信息。这通常是物理信息，例如文件名。这些额外信息对我们用处不大。
- CBO：输出由Calcite优化器生成的计划。CBO 从 hive 4.0.0 版本开始支持。
- AST：输出查询的抽象语法树。AST 在hive 2.1.0 版本删除了，存在bug，转储AST可能会导致OOM错误，将在4.0.0版本修复。
- DEPENDENCY：dependency在EXPLAIN语句中使用会产生有关计划中输入的额外信息。它显示了输入的各种属性。
- AUTHORIZATION：显示所有的实体需要被授权执行（如果存在）的查询和授权失败。
- LOCKS：这对于了解系统将获得哪些锁以运行指定的查询很有用。LOCKS 从 hive 3.2.0 开始支持。
- VECTORIZATION：将详细信息添加到EXPLAIN输出中，以显示为什么未对Map和Reduce进行矢量化。从 Hive 2.3.0 开始支持。
- ANALYZE：用实际的行数注释计划。从 Hive 2.2.0 开始支持。

一个HIVE查询被转换为一个由一个或多个stage组成的序列（有向无环图DAG）。这些stage可以是MapReduce stage，也可以是负责元数据存储的stage，也可以是负责文件系统的操作（比如移动和重命名）的stage。

stage dependencies： 各个stage之间的依赖性
stage plan： 各个stage的执行计划

- Map Reduce
    + Map Operator Tree： MAP端的执行计划树
        * TableScan 表扫描操作，常见的属性：
            - alias： 表名称
            - Statistics： 表统计信息，包含表中数据条数，数据大小等
            - Filter Operator、Select Operator、[Group By Operator、]Reduce Output Operator
    + Reduce Operator Tree： Reduce端的执行计划树
        - Group By Operator、File Output Operator
- Alter Table Operator:
- Pre Insert operator:
- Insert operator:
- Select Operator： 选取操作，常见的属性 ：
    + expressions：需要的字段名称及字段类型
    + outputColumnNames：输出的列名称
    + Statistics：表统计信息，包含表中数据条数，数据大小等
- Group By Operator：分组聚合操作，常见的属性：
    + aggregations：显示聚合函数信息
    + mode：聚合模式，值有 hash：随机聚合，就是hash partition；partial：局部聚合；final：最终聚合
    + keys：分组的字段，如果没有分组，则没有此字段
    + outputColumnNames：聚合之后输出列名
    + Statistics： 表统计信息，包含分组聚合之后的数据条数，数据大小等
- Reduce Output Operator：输出到reduce操作，常见属性：
    + sort order：值为空 不排序；值为 + 正序排序，值为 - 倒序排序；值为 +- 排序的列为两列，第一列为正序，第二列为倒序
    + Filter Operator：过滤操作，常见的属性：
    + predicate：过滤条件，如sql语句中的where id>=1，则此处显示(id >= 1)
- Map Join Operator：join 操作，常见的属性：
    + condition map：join方式 ，如Inner Join 0 to 1 Left Outer Join0 to 2
    + keys: join 的条件字段
    + outputColumnNames： join 完成之后输出的字段
    + Statistics： join 完成之后生成的数据条数，大小等
- File Output Operator：文件输出操作，常见的属性：
    + compressed：是否压缩
    + table：表的信息，包含输入输出文件格式化方式，序列化方式等
- Fetch Operator 客户端获取数据操作，常见的属性：
    + limit，值为 -1 表示不限制条数，其他值为限制的条数

#### Metastore

Metadata即元数据。元数据包含用Hive创建的database、table、表的字段等元信息。元数据存储在关系型数据库中。如hive内置的Derby、第三方如MySQL等。

MetaStore：存储和管理Hive的元数据，使用关系数据库来保存元数据信息。

Metastore即元数据服务，是Hive用来管理库表元数据的一个服务。有了它上层的服务不用再跟裸的文件数据打交道，而是可以基于结构化的库表信息构建计算框架。

Derby（内置）：Derby只接受一个Hive的会话访问；
Mysql：Hive跑在Hadoop之上的，Mysql进行主备（定时同步操作）；

通过metastore服务将Hive的元数据暴露出去，而不是需要通过对Hive元数据库mysql的访问才能拿到Hive的元数据信息，metastore服务实际上就是一种thrift服务，通过它用户可以获取到Hive元数据，并且通过thrift获取元数据的方式，屏蔽了数据库访问需要驱动，url，用户名，密码等细节。

##### Metastore 配置

1、内嵌模式

内嵌模式使用的是内嵌的Derby数据库来存储元数据，也不需要额外起Metastore服务。数据库和Metastore服务都嵌入在主Hive Server进程中。这个是默认的，配置简单，但是一次只能一个客户端连接，适用于用来测试，不适用于生产环境。


优点：配置简单，解压hive安装包 bin/hive 启动即可使用。

缺点：不同路径启动hive，每一个hive拥有一套自己的元数据，无法共享。

2、本地模式

本地模式采用外部数据库来存储元数据，目前支持的数据库有：MySQL、Postgres、Oracle、MS SQL Server。本文介绍的是MySQL。

本地模式不需要单独起metastore服务，用的是跟Hive在同一个进程里的metastore服务。也就是说当启动一个hive服务时，其内部会启动一个metastore服务。Hive根据 hive.metastore.uris 参数值来判断，如果为空，则为本地模式。


缺点：每启动一次hive服务，都内置启动了一个metastore，在hive-site.xml中暴露的数据库的连接信息。

优点：配置较简单，本地模式下hive的配置中指定mysql的相关信息即可。

3、远程模式

远程模式下，需要单独起metastore服务，然后每个客户端都在配置文件里配置连接到该metastore服务。

远程模式的metastore服务和hive运行在不同的进程里。

#### 优缺点

优点

- 操作使用 HiveQL(非常类似于 SQL)语法，对开发人员来说比较简单，容易上手，提供快速开发的能力。
- 基于 Hadoop 构建，所以非常适合处理大批量的数据，并且这些数据的处理对实时性的要求不高。
- 使用 Hive 避免了写 MapReduce，降低了开发人员的学习成本，和开发难度。
- Hive 支持用户自定义函数，用户可以根据自己的实际需求来自己定义相应的功能函数。

总结: 使用 HiveQL 语言，来处理对延迟没有要求的大量数据。 比如:网络访问日志的分析。

缺点

- Hive 的 HiveQL 表达能力有限
    + 迭代算法无法表达
    + 数据挖掘方面不擅长
- 由于 Hadoop 通常有较高的延迟并且在作业和调度的时候需要大量的开销，所以 Hive 的执行效率相对较低。
    + 不适合要求延迟比较的场景。 比如为了处理在线事务。
    + Hive 自动生成的 MapReduce 作业通常情况下并不智能，不能满足复杂场景。
    + Hive 调优比较困难，粒度比较粗。


#### Hive 和数据库比较

由于 Hive 采用了类似SQL 的查询语言 HQL(Hive Query Language)，因此很容易将 Hive 理解为数据库。其实从结构上来看，Hive 和数据库除了拥有类似的查询语言，再无类似之处。本文将从多个方面来阐述 Hive 和数据库的差异。数据库可以用在 Online 的应用中，但是 Hive 是为数据仓库而设计的，清楚这一点，有助于从应用角度理解 Hive 的特性。

- 查询语言

    由于SQL被广泛的应用在数据仓库中，因此，专门针对Hive的特性设计了类SQL的查询语言HQL。熟悉SQL开发的开发者可以很方便的使用Hive进行开发。

- 数据存储位置

    Hive 是建立在 Hadoop 之上的，所有 Hive 的数据都是存储在 HDFS 中的。而数据库则可以将数据保存在块设备或者本地文件系统中。

- 数据更新

    由于Hive是针对数据仓库应用设计的，而数据仓库的内容是读多写少的。因此，Hive中不建议对数据的改写，所有的数据都是在加载的时候确定好的。而数据库中的数据通常是需要经常进行修改的，因此可以使用 INSERT INTO … VALUES 添加数据，使用 UPDATE … SET修改数据。

- 索引

    Hive在加载数据的过程中不会对数据进行任何处理，甚至不会对数据进行扫描，因此也没有对数据中的某些Key建立索引。

    Hive要访问数据中满足条件的特定值时，需要暴力扫描整个数据，因此访问延迟较高。

    由于 MapReduce 的引入， Hive 可以并行访问数据，因此即使没有索引，对于大数据量的访问，Hive 仍然可以体现出优势。

    数据库中，通常会针对一个或者几个列建立索引，因此对于少量的特定条件的数据的访问，数据库可以有很高的效率，较低的延迟。由于数据的访问延迟较高，决定了 Hive 不适合在线数据查询。

- 执行

    Hive中大多数查询的执行是通过 Hadoop 提供的 MapReduce 来实现的。而数据库通常有自己的执行引擎。

- 执行延迟

    Hive 在查询数据的时候，由于没有索引，需要扫描整个表，因此延迟较高。

    另外一个导致 Hive 执行延迟高的因素是 MapReduce框架。由于MapReduce 本身具有较高的延迟，因此在利用MapReduce 执行Hive查询时，也会有较高的延迟。

    相对的，数据库的执行延迟较低。当然，这个低是有条件的，即数据规模较小，当数据规模大到超过数据库的处理能力的时候，Hive的并行计算显然能体现出优势。

- 可扩展性

    由于 Hive 是建立在Hadoop之上的，因此Hive的可扩展性是和Hadoop的可扩展性是一致的（世界上最大的Hadoop 集群在 Yahoo!，2009年的规模在4000 台节点左右）。而数据库由于 ACID 语义的严格限制，扩展行非常有限。目前最先进的并行数据库 Oracle 在理论上的扩展能力也只有100台左右。

- 数据规模

    由于Hive建立在集群上并可以利用MapReduce进行并行计算，因此可以支持很大规模的数据；对应的，数据库可以支持的数据规模较小。


### hive 配置

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

### 使用

#### hive 启动流程

```java
/************************************************************
STARTUP_MSG: Starting HiveServer2
STARTUP_MSG:   host = Test-Env-003/172.18.248.187
STARTUP_MSG:   args = []
STARTUP_MSG:   version = 2.3.8
STARTUP_MSG:   classpath = /usr/local/hive/conf:/usr/local/hive/lib/*:/usr/local/hbase/lib/*
```

#### 启动hive
运行 Hive 前必须先启动 Hadoop 的 HDFS 和 Yarn

hive相对于 Hadoop 集群来说仅仅是个客户端，所以不用分发其他设备上使用。

- 运行 Hive CLI(Command Line Interface) 。如果已经把 Hive 的下的/bin配置到了 PATH 中，那么可以直接运行 hive 进入。
- 开启一个 hiveserver2 服务器，然后使用 beeline 客户端连接。

```shell
hiveserver2 &

beeline
# 然后输入
!connect jdbc:hive2://hadoop101:10000
# 然后根据提示输入用户名和密码

# 查看配置
set hive.input.format

# 修改配置
set hive.input.format=org.apache.hadoop.hive.ql.io.CombineHiveInputFormat
```

#### 数据类型

##### 基本数据类型

string 就是在传统数据库中的varchar类型. 该类型是一个可变的字符串. 不过不能声明他的上限. 理论上可以存储2GB字节.

| hive 类型                 | java类型 | 长度                                              | 例子    |
| ------------------------- | -------- | ------------------------------------------------- | ------- |
| TINYINT                   | byte     | 1byte 有符号整数                                  | 20      |
| SMALINT                   | short    | 2byte 有符号整数                                  | 20      |
| INT                       | int      | 4byte 有符号整数                                  | 20      |
| BIGINT                    | long     | 8byte 有符号整数                                  | 20      |
| BOOLEAN                   | boolean  | 布尔类型                                          | true    |
| FLOAT                     | float    | 单精度浮点数                                      | 3.14159 |
| DOUBLE                    | double   | 双精度浮点数                                      | 3.14159 |
| STRING                    | string   | 字符，可以指定字符集，可以使用单引号或双引号         |         |
| BINARY                    | byte[]   | 字节数组(Note: Available in Hive 0.8.0 and later) |         |
| TIMESTAMP                 |          | 时间类型(Note: Available in Hive 0.8.0 and later) |         |
| DECIMAL                   |BigDecimal| (Note: Available in Hive 0.11.0 and later)       |         |
| DECIMAL(precision, scale) |BigDecimal| (Note: Available in Hive 0.13.0 and later)        |         |
| DATE                      |          | (Note: Available in Hive 0.12.0 and later)        |         |
| VARCHAR                   | string   | (Note: Available in Hive 0.12.0 and later)        |         |
| CHAR                      | string   | (Note: Available in Hive 0.13.0 and later)        |         |

##### 复杂数据类型
Hive 有 4 中复杂类型：

1. arrays: ARRAY<data_type>

    数组是一组具有相同类型和名称的变量的集合。这些变量称为数组的元素，每个数组元素都有一个编号，编号从零开始。例如，数组值为[‘John’, ‘Doe’]，那么第2个元素可以通过数组名[1]进行引用。

2. maps: MAP<primitive_type, data_type>

    MAP 是一组键-值对元组集合，使用数组表示法可以访问数据。例如，如果某个列的数据类型是MAP，其中键->值对是’first’->’John’和’last’->’Doe’，那么可以通过字段名[‘last’]获取最后一个元素。

3. structs: STRUCT<col_name : data_type [COMMENT col_comment], ...>

    和c语言中的struct类似，都可以通过“点”符号访问元素内容。例如，如果某个列的数据类型是 STRUCT{first STRING, last STRING},那么第1个元素可以通过: 字段.first来引用。

4. union: UNIONTYPE<data_type, data_type, ...>

    联合型. 这种类型到目前支持还不完全. 建议不要使用。

复杂类型允许任意深层次的嵌套。

##### 类型的转换
Hive 的原子数据类型是可以进行隐式转换的，类似于 Java 的类型转换，例如某表达式使用 INT 类型，TINYINT 会自动转换为 INT 类型，但是Hive 不会进行反向转化
，

例如，某表达式使用 TINYINT 类型，INT 不会自动转换为 TINYINT 类型，它会返回错误，除非使用 CAST 操作。

1. 隐式类型转换规则如下：

    1. 任何整数类型都可以隐式地转换为一个范围更广的类型，如TINYINT可以转换成INT，INT可以转换成BIGINT。
    2. 所有整数类型、FLOAT和STRING类型都可以隐式地转换成DOUBLE。
    3. TINYINT、SMALLINT、INT都可以转换为FLOAT。
    4. BOOLEAN类型不可以转换为任何其它的类型。

2. 可以使用CAST操作显示进行数据类型转换 例如CAST('1' AS INT)将把字符串'1' 转换成整数1；如果强制类型转换失败，如执行CAST('X' AS INT)，表达式返回空值 NULL。

#### DDL 数据定义
DDL(Data Definition Language)是涉及到创建数据、创建表、创建视图等一系列的数据定义动作。不涉及到对数据本身的操作。

在 Hive中，主要有两种 DDL：数据库级别和表级别。

Hive 中的数据库的概念本质上仅仅是表的一个目录或者命名空间而已。然而，对于具有很多组或者用户的的大集群来说，这是很有用的，因为可以避免命名冲突。如果用户没有显示的指定数据库，那么将会使用默认的数据库default。

默认数据库位置: /user/hive/warehouse/xxx.db

```sql
show databases;
show databases like 'db.*'; 

create database if not exists db_test comment 'this is test db' location '/hive/db/db_test';
show create database db_test; -- 显示数据库DDL信息

describe database db_test;
desc database default; -- 显示数据库信息
desc database extended default; -- 显示数据库详细信息

use db_test;

# 创建表
create table test_tb (col_name data_type);
# 复制表结构
create table tb_test like select * from tb_test0;
# 复制表结构以及数据
create table tb_test as select * from tb_test0;

# 修改表
ALTER TABLE test1 RENAME TO test2;
ALTER TABLE employee CHANGE name ename String; 
ALTER TABLE employee CHANGE salary salary double;
ALTER TABLE employee ADD COLUMNS (dept STRING COMMENT 'Department name'); 
ALTER TABLE table_name add columns( dept string COMMENT '') CASCADE；

desc test_tb; -- 显示数据表信息



# 默认情况下是不允许直接删除一个有表的数据库的：
# 1、 先把表删干净，再删库
# 2、删库时在后面加上cascade，表示级联删除此数据库下的所有表
drop database if exists db_test cascade; 
```

##### 内部表和外部表
Hive 的表在逻辑上有两部分组成:

1. 存储的数据。真实的存储的数据在 Hive 中都是以文件的形式存在，这个其他的普通的关系型数据库有差别。Hive 的数据一般存储在 HDFS 中。
2. 表示表中数据的元数据。Hive 把元数据存储在通常的数据库中。比如默认情况我们所有表的元数据都是存储在 derby 数据库中。也可以不用 derby，整合成大家都比较熟悉的 MySql 数据库。

**内部表**

Hive 的数据存储在 HDFS 系统中，如果创建表的时候，Hive 把数据迁移到数据仓库中(/user/hive/warehouse)中，这种表我们把它称为内部表或者管理表、托管表。

Hive 默认情况创的表都是内部表。

当向内部表加载数据(load)的时候，数据会迁移到数据仓库中(这里指的是从 HDFS 加载数据才会迁移，从本地文件不会)。

当删除表(drop)的时候，表的元数据和实际存储的数据都会被删除，所以数据彻底会消失。

内部表使用简单，但是不方便的地方是不能与其他应用程序共享数据。

**外部表**

创建表的时候加入关键字 external，这样创建的表就是外部表。

事实上，在创建外部表的时候，Hive 甚至就不检查这个数据是否存在。这是一个非常有用的特性，因为这意味着你可以把创建数据推迟到创建表之后。

删除外部表的时候，Hive 只会删除表的元数据，并不会删除数据。

**内部表和外部表的互换**

```sql
alter table dept set tblproperties('EXTERNAL'='FALSE'); -- 把 dept.txt 变成内部表
alter table stu set tblproperties('EXTERNAL'='TRUE'); -- 把 stu变成外部表
```


##### 分区表
Hive 把表组织成分区(partition)。这个是根据分区列的值对表进行粗略划分的机制。使用分区可以加快数据切片(slice)的查询速度。

分区表要创建表的时候就要指定好分区。每个分区对应 HDFS 文件系统中的一个文件夹。每个分区其实就是表目录下的子目录。

比如，查看日志文件比较大，我们只想看某一个的日志，普通的表需要挨个查询，如果按照日期分区后，则只需要在相应的分区中查询就可以了，大大提高了查询的速度。

**创建分区表**
```sql
create table dept_partition(
    deptno int, dname string, loc string
)
partitioned by (year string)
row format delimited fields 
terminated by '\t';
```
partitioned by (year string) 就表示在创建分区。year 就表示分区列。注意: 分区列不能是表中的字段，否则会抛出异常。

**向分区表中导入数据**
```sql
load data local inpath '/opt/module/datas/dept1.txt' into table dept_partition partition(year='201709');
```
注意: 导入数据的一定要指定导入到哪个分区。

**查询分区表中的数据**
```sql
select * from dept_partition where year="201709"; -- 使用 where子句从分区表中查询数据
show partitions dept_partition; -- 可以查看有哪些分区
```
注意:如果对不是分区表使用 show partitions 命令会抛出异常。

**增加分区**
```sql
alter table dept_partition add partition(month='201706') ; -- 增加单个分区
alter table dept_partition add partition(month='201705') partition(month='201704'); -- 同时增加多个分区:
```

**删除分区**
```sql
alter table dept_partition drop partition (month='201704'); -- 删除单个分区:
alter table dept_partition drop partition (month='201705'), partition (month='201706'); -- 同时删除多个分区:
```

**创建二级分区**
```sql
create table dept_partition2(
    deptno int, dname string, loc string
)
partitioned by (month string, day string)
row format delimited fields terminated by '\t';

-- 加载数据到分区
load data local inpath '/opt/module/datas/dept.txt' into table
 default.dept_partition2 partition(month='201709', day='13');

-- 使用where子句查询分区数据
select * from dept_partition2 where month='201709' and day='13'

-- 查询二级分区数
show partitions dept_partition2 partition(month='201709')


```

**分区表和数据产生关联**

根据情况不同有 3 种方式:

1. 上传数据后修复

    手动创建分区目录，后面直接通过 hdoop fs ... 的方式把数据上传到分区目录，则需要修复一下即可。

    msck repair table dept_partition2;

2. 上传数据后添加分区

    手动创建分区目录，后面直接通过 hdoop fs ... 的方式把数据上传到分区目录，则根据手动创建的目录，再执行添加分区的命令就可以了。

    alter table dept_partition2 add partition(month='201709', day='11');

3. 上传数据后load数据到分区
    手动创建分区目录，则再执行 load 命令也可以。

    load data local inpath '/opt/module/datas/dept.txt' into table dept_partition2 partition(month='201709',day='10');


##### 分桶表
分桶表是通过对数据进行Hash，放到不同文件存储，方便抽样和join查询。分桶表主要是将内部表、外部表和分区表进一步组织，可以指定表的某些列通过Hash算法进一步分解成不同的文件存储。创建分桶表是需要使用关键字clustered by并指定分桶的个数。

```sql
#创建分桶表buk_table根据id分桶，放入3个桶中
create table buk_table(id string,name string) clustered by(id) into 3 buckets ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';
#加载数据，将inner_table中数据加载到buk_table;
insert into buk_table select * from inner_table;
#桶中数据抽样：select * from table_name tablesample(bucket X out of Y on field);
# X表示从哪个桶中开始抽取，Y表示相隔多少个桶再次抽取
select * from buk_table tablesample(bucket 1 out of 1 on id);
```

##### 元数据表

1. 存储Hive版本的元数据表(VERSION)：如果该表出现问题，根本进入不了Hive-Cli。比如该表不存在，当启动Hive-Cli时候，就会报错”Table ‘hive.version’ doesn’t exist”。

| 表字段          | 说明     | 示例数据          |
| --------------- | -------- | ----------------- |
| VER_ID          | ID主键   | 1                 |
| SCHEMA_VERSION  | Hive版本 | 1.1.0             |
| VERSION_COMMENT | 版本说明 | Set  by MetaStore |

2. Hive数据库相关的元数据表(DBS、DATABASE_PARAMS)

DBS表存储Hive中所有数据库的基本信息。

| 表字段          | 说明               | 示例数据                                |
| --------------- | ------------------ | --------------------------------------- |
| DB_ID           | 数据库ID           | 1                                       |
| DESC            | 数据库描述         | Default  Hive database                  |
| DB_LOCATION_URI | 数据HDFS路径       | hdfs://193.168.1.75:9000/test-warehouse |
| NAME            | 数据库名           | default                                 |
| OWNER_NAME      | 数据库所有者用户名 | public                                  |
| OWNER_TYPE      | 所有者角色         | ROLE                                    |

DATABASE_PARAMS表存储数据库的相关参数，在CREATE DATABASE时候用WITH DBPROPERTIES(property_name=property_value, …)指定的参数。

| 表字段      | 说明     | 示例数据  |
| ----------- | -------- | --------- |
| DB_ID       | 数据库ID | 1         |
| PARAM_KEY   | 参数名   | createdby |
| PARAM_VALUE | 参数值   | root      |

DBS和DATABASE_PARAMS这两张表通过DB_ID字段关联。

3. Hive表和视图相关的元数据表

主要有TBLS、TABLE_PARAMS、TBL_PRIVS，这三张表通过TBL_ID关联。

TBLS:该表中存储Hive表，视图，索引表的基本信息

| 表字段             | 说明              | 示例数据                   |
| ------------------ | ----------------- | -------------------------- |
| TBL_ID             | 表ID              | 21                         |
| CREATE_TIME        | 创建时间          | 1447675704                 |
| DB_ID              | 数据库ID          | 1                          |
| LAST_ACCESS_TIME   | 上次访问时间      | 1447675704                 |
| OWNER              | 所有者            | root                       |
| RETENTION          | 保留字段          | 0                          |
| SD_ID              | 序列化配置信息    | 41，对应SDS表中的SD_ID     |
| TBL_NAME           | 表名              | ex_detail_ufdr_30streaming |
| TBL_TYPE           | 表类型            | EXTERNAL_TABLE             |
| VIEW_EXPANDED_TEXT | 视图的详细HQL语句 |                            |
| VIEW_ORIGINAL_TEXT | 视图的原始HQL语句 |                            |

TABLE_PARAMS:该表存储表/视图的属性信息


| 表字段      | 说明   | 示例数据                     |
| ----------- | ------ | ---------------------------- |
| TBL_ID      | 表ID   | 1                            |
| PARAM_KEY   | 属性名 | totalSize，numRows，EXTERNAL |
| PARAM_VALUE | 属性值 | 970107336、21231028、TRUE    |

TBL_PRIVS：该表存储表/视图的授权信息

| 表字段         | 说明           | 示例数据               |
| -------------- | -------------- | ---------------------- |
| TBL_GRANT_ID   | 授权ID         | 1                      |
| CREATE_TIME    | 授权时间       | 1436320455             |
| GRANT_OPTION   |               | 0                      |
| GRANTOR        | 授权执行用户   | root                   |
| GRANTOR_TYPE   | 授权者类型     | USER                   |
| PRINCIPAL_NAME | 被授权用户     | username               |
| PRINCIPAL_TYPE | 被授权用户类型 | USER                   |
| TBL_PRIV       | 权限           | Select、Alter          |
| TBL_ID         | 表ID           | 21，对应TBLS表的TBL_ID |

4. Hive文件存储信息相关的元数据表

主要涉及SDS、SD_PARAMS、SERDES、SERDE_PARAMS，由于HDFS支持的文件格式很多，而建Hive表时候也可以指定各种文件格式，Hive在将HQL解析成MapReduce时候，需要知道去哪里，使用哪种格式去读写HDFS文件，而这些信息就保存在这几张表中。

SDS:该表保存文件存储的基本信息，如INPUT_FORMAT、OUTPUT_FORMAT、是否压缩等。TBLS表中的SD_ID与该表关联，可以获取Hive表的存储信息。

| 表字段                    | 说明             | 示例数据                                                   |
| ------------------------- | ---------------- | ---------------------------------------------------------- |
| SD_ID                     | 存储信息ID       | 41                                                         |
| CD_ID                     | 字段信息ID       | 21，对应CDS表                                              |
| INPUT_FORMAT              | 文件输入格式     | org.apache.hadoop.mapred.TextInputFormat                   |
| IS_COMPRESSED             | 是否压缩         | 0                                                          |
| IS_STOREDASSUBDIRECTORIES | 是否以子目录存储 | 0                                                          |
| LOCATION                  | HDFS路径         | hdfs://193.168.1.75:9000/detail_ufdr_streaming_test        |
| NUM_BUCKETS               | 分桶数量         | 0                                                          |
| OUTPUT_FORMAT             | 文件输出格式     | org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat |
| SERDE_ID                  | 序列化类ID       | 41，对应SERDES表                                           |

SD_PARAMS: 该表存储Hive存储的属性信息，在创建表时候使用STORED BY ‘storage.handler.class.name’ [WITH SERDEPROPERTIES (…)指定。

| 表字段      | 说明       | 示例数据 |
| ----------- | ---------- | -------- |
| SD_ID       | 存储配置ID | 41       |
| PARAM_KEY   | 存储属性名 |          |
| PARAM_VALUE | 存储属性值 |          |

SERDES:该表存储序列化使用的类信息

| 表字段   | 说明           | 示例数据                                           |
| -------- | -------------- | -------------------------------------------------- |
| SERDE_ID | 序列化类配置ID | 41                                                 |
| NAME     | 序列化类别名   | NULL                                               |
| SLIB     | 序列化类       | org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe |

SERDE_PARAMS:该表存储序列化的一些属性、格式信息，比如:行、列分隔符

| 表字段      | 说明           | 示例数据    |
| ----------- | -------------- | ----------- |
| SERDE_I     | 序列化类配置ID | 41          |
| PARAM_KEY   | 属性名         | field.delim |
| PARAM_VALUE | 属性值         | \|          |

5. Hive表字段相关的元数据表

主要涉及COLUMNS_V2

COLUMNS_V2：该表存储表对应的字段信息

| 表字段      | 说明       | 示例数据          |
| ----------- | ---------- | ----------------- |
| CD_I        | 字段信息ID | 21                |
| COMMENT     | 字段注释   | NULL              |
| COLUMN_NAME | 字段名     | air_port_duration |
| TYPE_NAME   | 字段类型   | bigint            |
| INTEGER_IDX | 字段顺序   | 119               |

6. Hive表分分区相关的元数据表

主要涉及PARTITIONS、PARTITION_KEYS、PARTITION_KEY_VALS、PARTITION_PARAMS

PARTITIONS:该表存储表分区的基本信息

| 表字段           | 说明             | 示例数据              |
| ---------------- | ---------------- | --------------------- |
| PART_ID          | 分区ID           | 21                    |
| CREATE_TIME      | 分区创建时间     | 1450861405            |
| LAST_ACCESS_TIME | 最后一次访问时间 | 0                     |
| PART_NAME        | 分区名           | hour=15/last_msisdn=0 |
| SD_ID            | 分区存储ID       | 43                    |
| TBL_ID           | 表ID             | 22                    |
| LINK_TARGET_ID   |                  | NULL                  |

PARTITION_KEYS:该表存储分区的字段信息

| 表字段       | 说明         | 示例数据 |
| ------------ | ------------ | -------- |
| TBL_ID       | 表ID         | 22       |
| PKEY_COMMENT | 分区字段说明 | NULL     |
| PKEY_NAME    | 分区字段名   | hour     |
| PKEY_TYPE    | 分区字段类型 | int      |
| INTEGER_IDX  | 分区字段顺序 | 0        |

PARTITION_KEY_VALS:该表存储分区字段值

| 表字段       | 说明           | 示例数据 |
| ------------ | -------------- | -------- |
| PART_ID      | 分区ID         | 21       |
| PART_KEY_VAL | 分区字段值     | 0        |
| INTEGER_IDX  | 分区字段值顺序 | 1        |

PARTITION_PARAMS:该表存储分区的属性信息

| 表字段      | 说明       | 示例数据          |
| ----------- | ---------- | ----------------- |
| PART_ID     | 分区ID     | 21                |
| PARAM_KEY   | 分区属性名 | numFiles，numRows |
| PARAM_VALUE | 分区属性值 | 1，502195         |

7. 其他不常用的元数据表

DB_PRIVS：数据库权限信息表。通过GRANT语句对数据库授权后，将会在这里存储。

IDXS：索引表，存储Hive索引相关的元数据

INDEX_PARAMS：索引相关的属性信息

TBL_COL_STATS：表字段的统计信息。使用ANALYZE语句对表字段分析后记录在这里

TBL_COL_PRIVS：表字段的授权信息

PART_PRIVS：分区的授权信息

PART_COL_PRIVS：分区字段的权限信息

PART_COL_STATS：分区字段的统计信息

FUNCS：用户注册的函数信息

FUNC_RU：用户注册函数的资源信息

#### DML 数据操作

DML(Data Manipulation Language)执行的是对表中的数据增删改的操作。

##### 数据导入

**向表中装载文件**

Hive 处理的数据多是以文件的方式存在的。所以 Hive 最常见的就是把数据导入到数据库中。

语法:
```shell
LOAD DATA [LOCAL] INPATH 'filepath' [OVERWRITE] INTO TABLE tablename
 [PARTITION (partcol1=val1, partcol2=val2 ...)]
```
说明:

- load data 表示加载数据。
- local 表示从本地文件系统导入数据。如果不加local表示从 HDFS 文件系统导入数据。
- filepath 用引号括起来，表示要加载的数据的路径。
- overwrite 表示覆盖表中已有数据，不加参数表示追加数据到表中。
- partition 上传到指定分区。


**把查询结果插入到表中**
```sql
-- 创建一张分区表
create table student_1(id int, name string) 
partitioned by(year string) 
row format delimited 
fields terminated by '\t';

-- 插入一条数据
insert into table student_1 partition(year='2018') values(1, "lili");

-- 查询刚才的那条数据，并插入到新的分区中
insert overwrite table student_1 partition(year='2019') 
select id, name 
from student_1 
where year='2018';

-- 多插入模式
from student
insert overwrite table student partition(month='201707')
    select id, name where month='201709'
insert overwrite table student partition(month='201706')
    select id, name where month='201709';
```

**As Select**

指创建表的同时插入查询到的结果
```sql
create table if not exists student3
as select id, name from student;
```

**创建表时通过 location 指定数据路径**

1. 创建表，并指定路径
```sql
create table if not exists student_3(
    id int, name string
)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/student_3';
```

2. 上传数据到 HDFS 上/user/hive/warehouse/student_3
```shell
hadoop fs -put /opt/module/datas/students.txt /user/hive/warehouse/student_3;
```


##### 数据导出
**hive 命令导出**

```shell
# insert 将查询的结果导出到本地
insert overwrite local directory '/opt/module/datas/exports/' select * from student_3;

# 将查询的结果格式化导出到本地
insert overwrite local directory '/opt/module/datas/export/student_3'
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t'
select * from student_3;

# 将查询的结果导出到HDFS上(没有local)
insert overwrite directory '/user/atguigu/student_3'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' 
select * from student_3;

# export 导出到 HDFS 上
export table default.student to '/user/hive/warehouse/export/student';
```

**Hadoop 命令导出**

Hive 的表在 HDFS 上的表现就是文件。如果数据文件的格式正好是我们想要的格式，那么直接从 HDFS 上 copy 下面就可以了。

所以可以通过 Hadoop 命令直接从 HDFS 下载到本地
``` shell
hadoop fs -get /user/hive/warehouse/student_3
/opt/module/datas/export/student_3.txt;
```

##### 清空表中的数据
```sql
truncate table student_3;
```

#### 内置函数和自定义函数

常用内置函数主要分类:

- 数学函数
- 结合函数
- 类型转换函数
- 日期函数
- 条件函数
- 字符串函数
- 数据掩盖函数
- 其他函数
- UDAF函数(聚集函数) 多进一出
- UDTF函数(表生成函数) 一进多出

自定义函数分 3 种：

- 自定义 UDFs
- UDAF(User-Defined Aggregation Function) 聚集函数，多进一出 类似于：count/max/min
- UDTF(User-Defined Table-Generating Functions) 一进多出 lateral view explore()

步骤:

1. 继承org.apache.hadoop.hive.ql.UDF
2. 需要实现evaluate函数；evaluate函数支持重载；
3. 在hive的命令行窗口创建函数
    1. 添加jar add jar linux_jar_path
    2. 创建function， create [temporary] function [dbname.]function_name AS class_name;
4. 在hive的命令行窗口删除函数 Drop [temporary] function [if exists] [dbname.]function_name;


#### 文件存储格式和压缩格式

表的文件存储格式尽量采用Parquet或ORC，不仅降低存储量，还优化了查询，压缩，表关联等性能。

- TextFile：默认使用
    + 行存储，每一行都是一条记录，每行都以换行符"\n"结尾。
    + 默认是不压缩，但可以使用GZip和BZip等压缩方式，部分压缩算法压缩后不支持split。
    + 该类型的格式可以识别在hdfs上的普通文件格式（如txt、csv），因此该模式常用语仓库数据接入和导出层。
    + 无法区分数据类型，各个字段都被认为是文本，但需要指定列分隔符和行分隔符。
- SequenceFile
    + 二进制文件，以<key,value>的形式序列化到文件中。
    + 行存储。
    + 支持三种压缩格式：None、Record、Block。Record压缩率最高，一般用Block。
    + 和Hadoop API的MapFile是相互兼容的。
    + 缺点是由于该种模式是在textfile基础上加了些其他信息，故该类格式的大小要大于textfile，现阶段基本上不用。
- RCFile
    + 数据按行分块，每块按照列存储。 
    + 相对来说，RCFile对于提升任务执行性能提升不大，但是能节省一些存储空间。可以使用升级版的ORC格式。
- ORCFile：效率比RCFile高
    + 数据按行分块，每块按照列存储。
    + Hive提供的新格式，属于RCFile的升级版，性能有大幅度提升，而且数据可以压缩存储，压缩快，快速列存取。
    + ORC File会基于列创建索引，当查询的时候会很快，现阶段主要使用的文件格式。
- Parquet File
    + 列式存储。
    + Parquet对于大型查询的类型是高效的。对于扫描特定表格中的特定列查询，Parquet特别有用。
    + Parquet一般使用Snappy、Gzip压缩，默认是Snappy。

### 最佳实践

#### 数据倾斜

Hive 在执行 MapReduce 任务时经常会碰到数据倾斜的问题，表现为一个或者几个 reduce 节点运行很慢，延长了整个任务完成的时间，这是由于某些 key 的条数比其他 key 多很多，这些 Key 所在的reduce节点所处理的数据量比其他节点就大很多，从而导致某几个节点迟迟运行不完。

那么经常有哪些情况会产生数据倾斜呢，又该如何解决，这里梳理了几种最常见的数据倾斜场景。

##### 小表与大表JOIN

小表与大表Join时容易发生数据倾斜，表现为小表的数据量比较少但key却比较集中，导致分发到某一个或几个reduce上的数据比其他reduce多很多，造成数据倾斜。

优化方法：使用Map Join将小表装入内存，在map端完成join操作，这样就避免了reduce操作。有两种方法可以执行Map Join：

(1) 通过hint指定小表做MapJoin

 select /*+ MAPJOIN(time_dim) */ count(*) from store_sales join time_dim on ss_sold_time_sk = t_time_sk;

(2) 通过配置参数自动做MapJoin

核心参数：

| 参数名称                         | 默认值   | 说明                                            |
| -------------------------------- | -------- | ----------------------------------------------- |
| hive.auto.convert.join           | false    | 是否将common join（reduce端join）转换成map join |
| hive.mapjoin.smalltable.filesize | 25000000 | 判断为小表的输入文件大小阈值，默认25M           |

因此，巧用MapJoin可以有效解决小表关联大表场景下的数据倾斜。


##### 大表与大表JOIN

大表与大表Join时，当其中一张表的NULL值（或其他值）比较多时，容易导致这些相同值在reduce阶段集中在某一个或几个reduce上，发生数据倾斜问题。

优化方法：

(1) 将NULL值提取出来最后合并，这一部分只有map操作；非NULL值的数据分散到不同reduce上，不会出现某个reduce任务数据加工时间过长的情况，整体效率提升明显。但这种方法由于有两次Table Scan会导致map增多。

```sql
SELECT a.user_Id,a.username,b.customer_id FROM user_info a 
LEFT JOIN customer_info b ON a.user_id = b.user_id where a.user_id IS NOT NULL
UNION ALL SELECT a.user_Id,a.username,NULL FROM user_info a WHERE a.user_id IS NULL
```

(2) 在Join时直接把NULL值打散成随机值来作为reduce的key值，不会出现某个reduce任务数据加工时间过长的情况，整体效率提升明显。这种方法解释计划只有一次map，效率一般优于第一种方法。

```sql
SELECT a.user_id,a.username,b.customer_id FROM user_info a
LEFT JOIN customer_info b
 ON
  CASE WHEN
   a.user_id IS NULL
  THEN
   CONCAT ('dp_hive', RAND())
  ELSE
   a.user_id
  END = b.user_id;
```

##### GROUP BY 操作

Hive做group by查询，当遇到group by字段的某些值特别多的时候，会将相同值拉到同一个reduce任务进行聚合，也容易发生数据倾斜。

优化方法：

(1) 开启Map端聚合

参数设置：

| 参数名称                           | 默认值            | 说明                          |
| ---------------------------------- | ----------------- | ----------------------------- |
| hive.map.aggr                      | true（Hive 0.3+） | 是否开启Map端聚合             |
| hive.groupby.mapaggr.checkinterval | 100000            | 在Map端进行聚合操作的条目数目 |

(2) 有数据倾斜时进行负载均衡

参数设置：

| 参数名称                | 默认值 | 说明                                   |
| ----------------------- | ------ | -------------------------------------- |
| hive.groupby.skewindata | false  | 当GROUP BY有数据倾斜时是否进行负载均衡 |

当设定 hive.groupby.skewindata 为 true 时，生成的查询计划会有两个 MapReduce 任务。在第一个 MapReduce 中，map 的输出结果集合会随机分布到 reduce 中， 每个 reduce 做部分聚合操作，这样处理之后，相同的 Group By Key 有可能分发到不同的 reduce 中，从而达到负载均衡的目的。在第二个 MapReduce 任务再根据第一步中处理的数据按照Group By Key 分布到 reduce 中，（这一步中相同的 key 在同一个 reduce 中），最终生成聚合操作结果。

##### COUNT(DISTINCT) 操作

当在数据量比较大的情况下，由于 COUNT DISTINCT 操作是用一个 reduce 任务来完成，这一个 reduce 需要处理的数据量太大，就会导致整个 job 很难完成，这也可以归纳为一种数据倾斜。

优化方法：将 COUNT DISTINCT 使用先 GROUP BY 再 COUNT 的方式替换。例如：
```sql
select count(id) from (select id from bigtable group by id) a
```
因此，count distinct的优化本质上也是转成group by操作。

#### Hive on MR 调优
Hive on MR 调优主要从三个层面进行，分别是基于MapReduce优化、Hive架构层优化和HiveQL层优化。

##### MapReduce调优

如果能够根据情况对shuffle过程进行调优，对于提供MapReduce性能很有帮助。一个通用的原则是给shuffle过程分配尽可能大的内存，当然你需要确保map和reduce有足够的内存来运行业务逻辑。因此在实现Mapper和Reducer时，应该尽量减少内存的使用，例如避免在Map中不断地叠加。

运行map和reduce任务的JVM，内存通过mapred.child.java.opts属性来设置，尽可能设大内存。容器的内存大小通过mapreduce.map.memory.mb和mapreduce.reduce.memory.mb来设置，默认都是1024M。

1. 在map阶段主要包括：数据的读取、map处理以及写出操作(排序和合并/sort&merge)，其中可以针对spill文件输出数量、Combiner的merge过程和数据压缩进行优化，避免写入多个spill文件可能达到最好的性能，一个spill文件是最好的。通过估计map的输出大小，设置合理的mapreduce.task.io.sort.\*属性，使得spill文件数量最小。例如尽可能调大mapreduce.task.io.sort.mb。其次增加combine阶段以及对输出进行压缩设置进行mapper调优。

    (1)合理设置map数。

    在执行map函数之前会先将HDFS上文件进行分片，得到的分片做为map函数的输入，所以map数量取决于map的输入分片(inputsplit)，一个输入分片对应于一个map task，输入分片由三个参数决定：

    ```
    参数名 默认值 备注
    dfs.block.size 128M HDFS上数据块的大小
    mapreduce.min.split.size 0 最小分片数
    mapreduce.max.split.size 256M 最大分片数
    ```

    公式：分片大小=max(mapreduce.min.split.size,min(dfs.block.size, mapreduce.max.split.size)),默认情况下分片大小和dfs.block.size是一致的，即一个HDFS数据块对应一个输入分片，对应一个map task。这时候一个map task中只处理一台机器上的一个数据块，不需要将数据跨网络传输，提高了数据处理速度。

    (2)spill文件输出数量

    ```sql
    --用于mapper输出排序的内存大小，调大的话，会减少磁盘spill的次数，此时如果内存足够的话，一般都会显著提升性能
    mapreduce.task.io.sort.mb（default：100）
    --开始spill的缓冲池阀值，默认0.80，spill一般会在Buffer空间大小的80%开始进行spill
    mapreduce.map.sort.spill.percent（default：0.80）
    ```

    (3)combine(排序和合并/sort&merge)

    ```sql
    --运行combiner的最低文件数，与reduce共用；调大来减少merge的次数，从而减少磁盘的操作；
    mapreduce.task.io.sort.factor（default：10）
    --spill的文件数默认情况下由三个的时候就要进行combine操作，最终减少磁盘数据；
    min.num.spill.for.combine 默认是3
    ```

    (4)压缩设置

    ```sql
    --设置为true进行压缩，数据会被压缩写入磁盘，，压缩一般可以10倍的减少IO操作
    mapreduce.map.output.compress（default：false）
    --压缩算法，推荐使用SnappyCodec；
    mapreduce.map.output.compress.codec（default：org.apache.hadoop.io.compress.DefaultCodec）
    ```

2. reduce调优

   在reduce端，如果能够让所有数据都保存在内存中，可以达到最佳的性能。通常情况下，内存都保留给reduce函数，但是如果reduce函数对内存需求不是很高，将mapreduce.reduce.merge.inmem.threshold（触发合并的map输出文件数）设为0，mapreduce.reduce.input.buffer.percent（用于保存map输出文件的堆内存比例）设为1.0，可以达到很好的性能提升。在2008年的TB级别数据排序性能测试中，Hadoop就是通过将reduce的中间数据都保存在内存中胜利的。

   (1)对mapper端输出数据的获取

   ```sql
   --mr程序reducer copy数据的线程数。当map很多并且完成的比较快的job的情况下调大，有利于reduce更快的获取属于自己部分的数据
   mapreduce.reduce.shuffle.parallelcopies 默认5
   ```

   (2)数据合并(sort&merge)

   ```sql
   --reduce复制map数据的时候指定的内存堆大小百分比，适当的增加该值可以减少map数据的磁盘溢出，能够提高系统能。
   mapreduce.reduce.shuffle.input.buffer.percent 默认0.70；
   --reduce进行shuffle的时候，用于启动合并输出和磁盘溢写的过程的阀值。
   --如果允许，适当增大其比例能够减少磁盘溢写次数，提高系统性能。同mapreduce.reduce.shuffle.input.buffer.percent一起使用。
   mapreduce.reduce.shuffle.merge.percent 默认0.66；
   ```

   (3)reduce处理以及写出操作

   ```sql
   --reduce函数开始运行时，内存中的map输出所占的堆内存比例不得高于这个值，默认情况内存都用于reduce函数，也就是map输出都写入到磁盘
   set mapreduce.reduce.input.buffer.percent 默认0.0;
   --开始spill的map输出文件数阈值，小于等于0表示没有阈值，此时只由缓冲池比例来控制
   set mapreduce.reduce.merge.inmem.threshold 默认1000;
   --服务于reduce提取结果的线程数量
   mapreduce.shuffle.max.threads 默认0；
   --修改reducer的个数，可以通过job.setNumReduceTasks方法来进行更改。
   mapreduce.job.reduces 默认为1;
   ```

   (4)合理设置reduce数

   reduce数决定参数

   ```
   参数名 默认值 备注
   hive.exec.reducers.bytes.per.reducer 1G 一个reduce数据量的大小
   hive.exec.reducers.max 999 hive 最大的个数
   mapred.reduce.tasks -1 reduce task 的个数,-1 是根据hive.exec.reducers.bytes.per.reducer 自动调整
   ```

   所以可以用set mapred.reduce.tasks手动调整reduce task个数。

##### Hive架构层优化

1. 不执行mapreduce

   (1)hive从HDFS读取数据，有两种方式：启用mapreduce读取、Fetch直接抓取。

   (2)hive.fetch.task.conversion参数设置成more，可以在 select、where、limit 时启用直接抓取方式，能明显提升查询速度。
   `set hive.fetch.task.conversion=more`

2. 本地执行mapreduce

   hive在集群上查询时，默认是在集群上N台机器上运行，需要多个机器进行协调运行，这个方式很好地解决了大数据量的查询问题。但是当hive查询处理的数据量比较小时，其实没有必要启动分布式模式去执行，因为以分布式方式执行就涉及到跨网络传输、多节点协调等，并且消耗资源。这个时间可以只使用本地模式来执行mapreduce job，只在一台机器上执行，速度会很快。`set mapreduce.framework.name=local`

3. JVM重用

   因为hive语句最终要转换为一系列的mapreduce job的，而每一个mapreduce job是由一系列的map task和Reduce task组成的，默认情况下，mapreduce中一个map task或者一个Reduce task就会启动一个JVM进程，一个task执行完毕后，JVM进程就退出。这样如果任务花费时间很短，又要多次启动JVM的情况下，JVM的启动时间会变成一个比较大的消耗，这个时候，就可以通过重用JVM来解决。这个设置就是制定一个jvm进程在运行多次任务之后再退出，这样一来，节约了很多的JVM的启动时间。

   ```sql
   --JVM重用特别是对于小文件场景或者task特别多的场景
   set mapred.job.reuse.jvm.num.tasks=10; 
   
   --启动JVM虚拟机时，传递给虚拟机的启动参数，表示这个 Java 程序可以使用的最大堆内存数，一旦超过这个大小，JVM 就会抛出 Out of Memory 异常，并终止进程。
   --设置的是 Container 的内存上限，这个参数由 NodeManager 读取并进行控制，当 Container 的内存大小超过了这个参数值，NodeManager 会负责 kill 掉 Container。
   --mapreduce.map.java.opts一定要小于mapreduce.map.memory.mb。
   mapreduce.map.java.opts 默认 -Xmx200m；
   mapreduce.map.memory.mb
   --同上
   mapreduce.reduce.java.opts；
   mapreduce.map.java.opts；
   
   --是否启动map阶段的推测执行，其实一般情况设置为false比较好。可通过方法job.setMapSpeculativeExecution来设置。
   mapreduce.map.speculative 默认为true;
   --是否需要启动reduce阶段的推测执行，其实一般情况设置为fase比较好。可通过方法job.setReduceSpeculativeExecution来设置。
   mapreduce.reduce.speculative 默认为true;
   ```

4. 并行化

    一个hive sql语句可能会转为多个mapreduce job，每一个job就是一个stage，这些 job 顺序执行，这个在hue的运行日志中也可以看到。但是有时候这些任务之间并不是是相互依赖的，如果集群资源允许的话，可以让多个并不相互依赖stage并发执行，这样就节约了时间，提高了执行速度，但是如果集群资源匮乏时，启用并行化反倒是会导致各个job相互抢占资源而导致整体执行性能的下降。

   ```sql
   --开启任务并行执行
    set hive.exec.parallel=true;
   --同一个sql允许并行任务的最大线程数 
   set hive.exec.parallel.thread.number 默认为8;
   ```

##### HiveQL调优

1. 利用分区表优化

    分区表是在某一个或者某几个维度上对数据进行分类存储，一个分区对应于一个目录。在这中的存储方式，当查询时，如果筛选条件里有分区字段，那么hive只需要遍历对应分区目录下的文件即可，不用全局遍历数据，使得处理的数据量大大减少，提高查询效率。
    当一个hive表的查询大多数情况下，会根据某一个字段进行筛选时，那么非常适合创建为分区表。

2. 利用桶表优化

    就是指定桶的个数后，存储数据时，根据某一个字段进行哈希后，确定存储再哪个桶里，这样做的目的和分区表类似，也是使得筛选时不用全局遍历所有的数据，只需要遍历所在桶就可以了。

    ```
    hive.optimize.bucketmapJOIN=true;
    hive.input.format=org.apache.hadoop.hive.ql.io.bucketizedhiveInputFormat; 
    hive.optimize.bucketmapjoin=true; 
    hive.optimize.bucketmapjoin.sortedmerge=true;
    ```

3. 对于整个sql的优化

    (1)where 条件优化

    where只在map端阶段执行，不会在reduce阶段执行，尽早地过滤数据，减少每个阶段的数据量,对于分区表要加分区，同时只选择需要使用到的字段。

    (2)join优化

    1. 优先过滤后再join，最大限度地减少参与join的数据量。

    2. 遵守小表join大表原则，原因是join操作的reduce阶段，位于join左边的表内容会被加载进内存，将条目少的表放在左边，可以有效减少发生内存溢出的几率。join中执行顺序是从做到右生成job，应该保证连续查询中的表的大小从左到右是依次增加的。

    3. join on条件相同的放入一个job。hive中，当多个表进行join时，如果join on的条件相同，那么他们会合并为一个mapreduce job，所以利用这个特性，可以将相同的join on的放入一个job来节省执行时间。

       ```sql
       select pt.page_id,count(t.url) PV 
       from rpt_page_type pt 
       join (select url_page_id,url from trackinfo where ds='2016-10-11' ) t on pt.page_id=t.url_page_id 
       join (select page_id from rpt_page_kpi_new where ds='2016-10-11' ) r on t.url_page_id=r.page_id group by pt.page_id;
       ```

    4. Common/shuffle/Reduce JOIN
        发生在reduce 阶段， 适用于大表 连接 大表(默认的方式)

    5. Map JOIN
        连接发生在map阶段 ，适用于小表 连接 大表，大表的数据从文件中读取，小表的数据存放在内存中（hive中已经自动进行了优化，自动判断小表，然后进行缓存）

       ```sql
       set hive.auto.convert.join=true; 
       ```

    6. SMB JOIN,Sort -Merge -Bucket Join 对大表连接大表的优化，用桶表的概念来进行优化。在一个桶内发送生笛卡尔积连接（需要是两个桶表进行join）

       ```sql
       set hive.auto.convert.sortmerge.join=true; 
       set hive.optimize.bucketmapjoin = true; 
       set hive.optimize.bucketmapjoin.sortedmerge = true; 
       set hive.auto.convert.sortmerge.join.noconditionaltask=true;
       ```

    (3) Group By数据倾斜优化

    Group By很容易导致数据倾斜问题，因为实际业务中，通常是数据集中在某些点上，这也符合常见的2/8原则，这样会造成对数据分组后，某一些分组上数据量非常大，而其他的分组上数据量很小，而在mapreduce程序中，同一个分组的数据会分配到同一个reduce操作上去，导致某一些reduce压力很大，其他的reduce压力很小，这就是数据倾斜，整个job 执行时间取决于那个执行最慢的那个reduce。

    解决这个问题的方法是配置一个参数：set hive.groupby.skewindata=true。 当选项设定为true，生成的查询计划会有两个MR job。第一个MR job 中，map的输出结果会随机分布到Reduce中，每个Reduce做部分聚合操作，并输出结果，这样处理的结果是相同的Group By Key有可能被分发到不同的Reduce中，从而达到负载均衡的目的；第二个MR job再根据预处理的数据结果按照Group By Key分布到Reduce中（这个过程可以保证相同的GroupBy Key被分布到同一个Reduce中），最后完成最终的聚合操作。

    (4) Order By 优化

    因为order by只能是在一个reduce进程中进行的，所以如果对一个大数据集进行order by，会导致一个reduce进程中处理的数据相当大，造成查询执行超级缓慢。

    (5)mapjoin
    
    mapjoin是将join双方比较小的表直接分发到各个map进程的内存中，在map进程中进行join操作，这样就省掉了reduce步骤，提高了速度。
    
    但慎重使用mapjoin,一般行数小于2000行，大小小于1M(扩容后可以适当放大)的表才能使用,小表要注意放在join的左边。否则会引起磁盘和内存的大量消耗。 
    
    (6) 桶表mapjoin
    
    当两个分桶表join时，如果join on的是分桶字段，小表的分桶数时大表的倍数时，可以启用map join来提高效率。启用桶表mapjoin要启用hive.optimize.bucketmapjoin参数。

    (7) 消灭子查询内的 group by 、 COUNT(DISTINCT)，MAX，MIN。 可以减少job的数量。
   
    (8) 不要使用count (distinct cloumn) ,改使用子查询。
   
    (9) 如果union all的部分个数大于2，或者每个union部分数据量大，应该拆成多个insert into 语句，这样会提升执行的速度。尽量不要使用union （union 去掉重复的记录）而是使用 union all 然后在用group by 去重。
   
    (10) 中间临时表使用orc、parquet等列式存储格式。
   
    (11) Join字段显示类型转换。
   
    (12) 单个SQL所起的JOB个数尽量控制在5个以下。


#### Hive on MR OOM

Hive 中出现 OOM 的异常原因大致分为以下几种：

1. Map 阶段 OOM：发生 OOM 的几率很小，除非你程序的逻辑不正常，亦或是程序写的不高效，产生垃圾太多。
2. Reduce 阶段 OOM：
    1. data skew 数据倾斜是引发这个的一个原因。 key 分布不均匀，导致某一个 reduce 所处理的数据超过预期，导致 jvm 频繁 GC。
    2. value 对象过多或者过大：某个 reduce 中的 value 堆积的对象过多，导致 jvm 频繁 GC。
    
    解决办法：

    1. 增加 reduce 个数，set mapred.reduce.tasks=300。
    2. 在 hive-site.xml 中设置，或者在 hive shell 里设置 set mapred.child.java.opts = -Xmx512m 或者只设置 reduce 的最大 heap 为 2G，并设置垃圾回收器的类型为并行标记回收器，这样可以显著减少 GC 停顿，但是稍微耗费 CPU。set mapred.reduce.child.java.opts=-Xmx2g -XX:+UseConcMarkSweepGC;
    3. 使用 map join 代替 common join. 可以 set hive.auto.convert.join = true
    4. 设置 hive.optimize.skewjoin = true 来解决数据倾斜问题

3. Driver 提交 Job 阶段 OOM：job 产生的执行计划的条目太多，比如扫描的分区过多，上到4k-6k个分区的时候，并且是好几张表的分区都很多时，这时做join。

    究其原因，是因为序列化时，会将这些分区，即 hdfs 文件路径，封装为 Path 对象，这样，如果对象太多了，而且 Driver 启动的时候设置的 heap size 太小，则会导致在 Driver 内序列化这些 MapRedWork 时，生成的对象太多，导致频繁 GC，则会引发如下异常:
    ```java
    java.lang.OutOfMemoryError: GC overhead limit exceeded
    at sun.nio.cs.UTF_8.newEncoder(UTF_8.java:53)
    at java.beans.XMLEncoder.createString(XMLEncoder.java:572)
    ```

	解决办法：

    1. 减少分区数量，将历史数据做成一张整合表，做成增量数据表，这样分区就很少了。
    2. 调大 Hive CLI Driver 的 heap size, 默认是 256MB，调节成 512MB或者更大。具体做法是在 bin/hive bin/hive-config 里可以找到启动 CLI 的 JVM OPTIONS。设置 export HADOOP_HEAPSIZE=512

#### Hive on tez

#### FAQ
##### return code 2 from org.apache.hadoop.hive.ql.exec.mr.MapRedTask

```java
java.lang.OutOfMemoryError: Java heap space
```

In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>


### FAQ

8. 设置HiveServer2的认证方式为LDAP？
```hiveserver2-site
hive.server2.authentication LDAP
hive.server2.authentication.ldap.url ldap://${emr-header-1-hostname}:10389
hive.server2.authentication.ldap.baseDN ou=people,o=emr
```
在E-MapReduce集群中，OpenLDAP组件是LDAP的服务，默认用于管理Knox的用户账号，HiveServer2的LDAP认证方式可以复用Knox的账号体系。



### hive 结合 hbase

Hive 和 Hbase 在大数据架构中处在不同位置，Hive 是一个构建在 Hadoop 基础之上的数据仓库，Hbase 是一种 NoSQL 数据库，非常适用于海量明细数据的随机实时查询，在大数据架构中，Hive 和 HBase 是协作关系如果两者结合，可以利用MapReduce的优势针对HBase存储的大量内容进行离线的计算和分析。

Hive 与 HBase 利用两者本身对外的 API 来实现整合，主要是靠 HBaseStorageHandler 进行通信，利用 HBaseStorageHandler，Hive 可以获取到 Hive 表对应的 HBase 表名，列簇以及列，InputFormat 和 OutputFormat 类，创建和删除 HBase 表等。

Hive 访问 HBase 中表数据，实质上是通过 MapReduce 读取 HBase 表数据，其实现是在 MR 中，使用 HiveHBaseTableInputFormat 完成对 HBase 表的切分，获取 RecordReader 对象来读取数据。

对 HBase 表的切分原则是一个 Region 切分成一个 Split，即表中有多少个 Regions，MR 中就有多少个 Map；

读取 HBase 表数据都是通过构建 Scanner，对表进行全表扫描，如果有过滤条件，则转化为 Filter。当过滤条件为 rowkey 时，则转化为对 rowkey 的过滤；

Scanner 通过 RPC 调用 RegionServer 的 next()来获取数据；

在使用 Hive over HBase，对 HBase 中的表做统计分析时候，需要特别注意以下几个方面：

1. 对 HBase 表进行预分配 Region，根据表的数据量估算出一个合理的 Region 数；
2. rowkey 设计上需要注意，尽量使 rowkey 均匀分布在预分配的 N 个 Region 上；
3. 通过 set hbase.client.scanner.caching 设置合理的扫描器缓存；
4. 关闭 mapreduce 的推测执行：<br>
    set mapred.map.tasks.speculative.execution = false;<br>
    set mapred.reduce.tasks.speculative.execution = false;<br>

#### 配置

HIVE_HOME 和 HBASE_HOME 都进行配置.

检查 Hive 自带的 hive-hbase-handler-xxx.jar 文件是否兼容已安装的 HBase 版本。

要连接到 Zookeeper 的话，打开hive-site.xml 文件，添加如下配置:
```xml
<!-- zookeeper 地址-->
<property>
    <name>hive.zookeeper.quorum</name>
    <value>hadoop201,hadoop202,hadoop203</value>
    <description>The list of ZooKeeper servers to talk to. This is only needed for read/write locks.</description>
</property>
<!-- zookeeper 端口号 -->
<property>
    <name>hive.zookeeper.client.port</name>
    <value>2181</value>
    <description>The port of ZooKeeper servers to talk to. This is only needed for read/write locks.</description>
</property>
```

```sql
-- 在 Hive 中创建表同时关联 HBase
CREATE TABLE hive_hbase_emp_table(
    empno int,
    ename string,
    job string,
    mgr int,
    hiredate string,
    sal double,
    comm double,
    deptno int
)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,info:ename,info:job,info:mgr,info:hiredate,info:sal,info:comm,info:deptno")
TBLPROPERTIES ("hbase.table.name" = "hbase_emp_table");
```

#### Hive over HBase 和 Hive over HDFS 性能比较

查询性能比较
query1:
select count(1) from on_hdfs;
select count(1) from on_hbase;

query2(根据key过滤)
select * from on_hdfs
where key = '13400000064_1388056783_460095106148962';
select * from on_hbase
where key = '13400000064_1388056783_460095106148962′;

query3(根据value过滤)
select * from on_hdfs where value = ‘XXX';
select * from on_hbase where value = ‘XXX';

 

on_hdfs (20万记录，150M，TextFile on HDFS)
on_hbase(20万记录，160M，HFile on HDFS)

on_hdfs (2500万记录，2.7G，TextFile on HDFS)
on_hbase(2500万记录，3G，HFile on HDFS)


对于全表扫描，hive_on_hbase查询时候如果不设置catching，性能远远不及hive_on_hdfs；

根据rowkey过滤，hive_on_hbase性能上略好于hive_on_hdfs，特别是数据量大的时候；

设置了caching之后，尽管比不设caching好很多，但还是略逊于hive_on_hdfs；

### Hive 结合 phoenix

https://repo1.maven.org/maven2/org/apache/phoenix/phoenix-hive/

