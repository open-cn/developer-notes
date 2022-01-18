## MapReduce

### 概述
Mapreduce是一个分布式运算程序的编程框架，是用户开发“基于hadoop的数据分析应用”的核心框架；

Mapreduce核心功能是将用户编写的业务逻辑代码和自带默认组件整合成一个完整的分布式运算程序，并发运行在一个hadoop集群上。

### MapReduce 原理

一个完整的mapreduce程序在分布式运行时有三类实例进程：

1. MrAppMaster：负责整个程序的过程调度及状态协调。
2. MapTask：负责map阶段的整个数据处理流程。
3. ReduceTask：负责reduce阶段的整个数据处理流程。

Hadoop将输入数据划分为等长的小数据块(默认为64MB)的过程叫做分片，并为每个分片构建一个Mappper任务，并由Mapper任务执行用户自定义的函数处理分片中的数据，mapper就是将这些数据中包含我们感兴趣或要处理的数据构成一个以键值存储的数据集。最后发送到Reduce函数。Reduce合并Mapper传递过来的键值数据，对数据进行排序和按照用户自定义函数进行计算，最后将输出写入到本地节点，再流式同步到其它节点。

由于分片处理，当数据量越大拥有的分片数量就越多，处理每个分片所需要的时间少于处理整个输入的时间，所以如果在同一个机架上并行处理每个分片，并且分片数据比较少，那整个处理过程将获得更好的负载均衡。但如果由于硬件故障或任务运行失败，hadoop会将任务重新分配到其它可能不在同一个机架或数据中心的节点运行，这会导致机架或数据中心之间的网络传输，从而降低Mapper的处理效率。所以同等比率数据，本地化处理效率比较占优势。

由于数据合并操作可能涉及不同机架上的节点间传递数据到合并的节点，所以网络带宽经常会遭遇到瓶颈和莫名其妙的延迟，为了更好的监控和避免这些意外发生，2.x版本增强了在处理过程中reporter功能，开发时善用这个功能，能避免和及时发现一些问题发生。

#### MapReduce 开发
旧API在程序包名org.apache.hadoop.mapred下；新API在包名org.apache.hadoop.mapreduce下。

MapReduce程序开发分成三个阶段：Mapper，Reducer，Driver(提交运行mr程序的客户端)

1. Mapper阶段
	1. 用户自定义的Mapper要继承自己的父类org.apache.hadoop.mapreduce.Mapper;
	2. Mapper的输入数据是KV对的形式（KV的类型可自定义）
	3. Mapper中的业务逻辑写在map()方法中
	4. Mapper的输出数据是KV对的形式（KV的类型可自定义）
	5. map()方法（maptask进程）对每一个<K,V>调用一次
2. Reducer阶段
	1. 用户自定义的Reducer要继承自己的父类org.apache.hadoop.mapreduce.Reducer;
	2. Reducer的输入数据类型对应Mapper的输出数据类型，也是KV
	3. Reducer的业务逻辑写在reduce()方法中
	4. Reducetask进程对每一组相同k的<k,v>组调用一次reduce()方法
3. Driver阶段
	1. 整个程序需要一个Drvier来进行提交，提交的是一个描述了各种必要信息的job对象

MapReduceBase是个虚拟类，为几种方法提供默认的无操作实现，在特殊的应用程序中可能需要覆盖其中的一些方法，目的是增强程序的扩展能力。

##### map 任务开发
用户根据业务需求实现其中三个方法：map() setup() cleanup() 
```java
public static class TokenizerMapper 
   extends Mapper<Object, Text, Text, IntWritable>{

	private final static IntWritable one = new IntWritable(1);
	private Text word = new Text();
  
	public void map(Object key, Text value, Context context
                ) throws IOException, InterruptedException {
  		StringTokenizer itr = new StringTokenizer(value.toString());
  		while (itr.hasMoreTokens()) {
    	word.set(itr.nextToken());
    	context.write(word, one);
	}
}
```

##### reduce 任务开发
用户根据业务需求实现其中三个方法: reduce() setup() cleanup()

```java
public static class IntSumReducer 
   extends Reducer<Text,IntWritable,Text,IntWritable> {
	private IntWritable result = new IntWritable();

	public void reduce(Text key, Iterable<IntWritable> values, Context context
                   ) throws IOException, InterruptedException {
		int sum = 0;
		for (IntWritable val : values) {
		sum += val.get();
		}
		result.set(sum);
		context.write(key, result);
	}
}
```

##### Job 提交
```java
  public static void main(String[] args) throws Exception {
	Configuration conf = new Configuration();
	String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
	if (otherArgs.length < 2) {
	  System.err.println("Usage: wordcount <in> [<in>...] <out>");
	  System.exit(2);
	}
	Job job = Job.getInstance(conf, "word count");
	job.setJarByClass(WordCount.class);
	job.setMapperClass(TokenizerMapper.class);
	job.setCombinerClass(IntSumReducer.class);
	job.setReducerClass(IntSumReducer.class);
	job.setOutputKeyClass(Text.class);
	job.setOutputValueClass(IntWritable.class);
	for (int i = 0; i < otherArgs.length - 1; ++i) {
	  FileInputFormat.addInputPath(job, new Path(otherArgs[i]));
	}
	FileOutputFormat.setOutputPath(job,
	  new Path(otherArgs[otherArgs.length - 1]));
	System.exit(job.waitForCompletion(true) ? 0 : 1);
}
```

最终的MapReduce要打包成jar包在命令行调用，需要传递必要的输入参数，再通过JobConf设置job名称，setJarByClass表示在运行的hadoop环境中通过类名找到和调用jar文件(通过HADOOP_CLASSPATH或运行时设置jar)；setMapperClass设置用于处理的Mapper类；setReducerClass设置用于处理的Reduce类；再通过FileInputFormat抽象类的静态方法设置输入输出路径；如果结果输出格式和默认格式不同，则需要通过setOutputKeyClass和setOutputValueClass定义，最后通过JobClient运行job。

##### MapReduce 任务执行
```shell
hadoop jar ./share/hadoop/mapreduce/hadoop-mapreduce-examples-2.10.1.jar wordcount input out
```

##### MapReduce 运行方式

**本地运行**

1. pc环境：
	1. 将Hadoop安装本地解压
	2. 配置Hadoop的环境变量
		- 添加%HADOOP_HOME%
		- 修改%PATH% 添加%HADOOP_HOME%/bin;%HADOOP_HOME%/sbin
	3. 在解压的Hadoop的bin目录下 添加winutils.exe工具
2. Java工程
	1. jdk一定要使用自己的jdk、不要使用eclipse自带
	2. 根目录（src目录下），不要添加任何MapReduce的配置文件 hdfs-site.xml yarn-site.xml core-site.xml mapred-site.xml
	3. 在代码当中，通过conf.set方式来进行指定。conf.set("fs.defaultFS", "hdfs://node21:8020");
	4. 修改Hadoop源码
3. 右键run执行

**集群运行**

Java工程

1. 根目录（src目录下），添加Hadoop的配置文件 hdfs-site.xml yarn-site.xml core-site.xml mapred-site.xml
2. 在代码当中，指定jar包的位置，config.set("mapred.jar", "D:\\MR\\wc.jar");
3. 修改Hadoop源码
4. 将工程打jar包
5. 右键run执行

或

1. 根目录（src目录下），添加Hadoop的配置文件 hdfs-site.xml yarn-site.xml core-site.xml mapred-site.xml
2. 将工程打jar包
3. 手动将jar包上传到集群当中
4. 通过hadoop命令来运行。hadoop jar jar位置 mr代码入口 （例如：hadoop jar /usr/wc.jar com.sxt.mr.WcJob）

HBase运行：

在代码当中指定HBase所使用的ZooKeeper集群。

注意：如果hbase搭建的是伪分布式，那么对应的ZooKeeper就是那台伪分布式的服务器
```java
conf.set("hbase.zookeeper.quorum", "node21,node22,node23");

System.setProperty("HADOOP_USER_NAME", "root");
```

#### MapReduce 运行流程
1. 待处理文本：在MapReduce程序读取文件的输入目录上存放相应的文件。
2. 客户端程序在submit()方法执行前，获取待处理的数据信息，然后根据集群中参数的配置形成一个任务分配规划。
3. 提交切片信息：客户端提交job.split、jar包、job.xml等文件给yarn，yarn中的resourcemanager启动MRAppMaster。
4. MRAppMaster启动后根据本次job的描述信息，计算出需要的maptask实例数量，然后向集群申请机器启动相应数量的maptask进程。
5. maptask用指定的RecordReader和inputformat来读取数据，形成输入KV对。
6. maptask将输入KV对传递给客户定义的map()方法，做逻辑运算。
7. map()运算完毕后将KV对收集到maptask缓存。
8. maptask缓存中的KV对按照K分区排序后不断写到磁盘文件（HashPartitioner 分区、Key.compareTo排序、Combiner合并）。
9. 溢出到文件（分区且区内有序）。
10. Merge 归并排序
11. 合并
12. MRAppMaster监控到所有maptask进程任务完成之后，会根据客户指定的参数启动相应数量的reducetask进程，并告知reducetask进程要处理的数据分区。
13. Reducetask进程启动之后，根据MRAppMaster告知的待处理数据所在位置，从若干台maptask运行所在机器上获取到若干个maptask输出结果文件，并在本地进行重新归并排序，然后按照相同key的KV为一个组，调用客户定义的reduce()方法进行逻辑运算。
11. Reducetask运算完毕后，用指定的RecordWriter和outputformat将结果数据输出到外部存储。

**基础组件**

1. 数据源：HDFS文件系统
2. 数据读取组件：RecordReader、InputFormat，默认LineRecordReader、TextInputFormat
3. 第一个阶段Mapper：映射 提取核心信息形成Key-Value
4. 第二个阶段Reducer：汇总、聚合、合并 按照业务逻辑把一组Key-Value合并成另外一组Key-Value
5. 数据输出组件：RecordWriter、OutputFormat，默认LineRecordWriter、TextOutputFormat
6. 数据目的地：标准输出、文件系统、数据库

**数据混洗Shuffle三大组件**

1. Partitioner分区器：默认是HashPartitioner哈希散列
2. Sorter排序器：Comparable排序，默认字典排序。只能对key排序，不能对value排序。
3. Combiner局部合并：可以不用设置。减少Shuffle阶段的数量，减轻reducer工作阶段的压力。用来提高执行效率。

**其他组件**

1. GroupComparator 分组组件
2. Writable 接口 序列化组件
3. WritableComparable 既序列化，也指定排序规则

#### Job提交底层实现

```java
// hadoop rel/release-2.10.1
waitForCompletion()
submit();
// 1建立连接
connect();
// 1）创建提交job的代理客户端
new Cluster(getConfiguration());
// （1）判断是本地yarn还是远程，并初始化submitClient
initialize(jobTrackAddr, conf);
new YARNRunner(conf);
new ResourceMgrDelegate(new YarnConfiguration(conf))；
YarnClient.createYarnClient();
client.start();
rmClient = ClientRMProxy.createRMProxy();
newProxyInstance(conf, protocol, instance, retryPolicy);
// client.RMProxy: Connecting to ResourceManager at /0.0.0.0:8032

// 2 提交job
submitter.submitJobInternal(Job.this, cluster)
// 1）创建给集群提交数据的Stag路径
Path jobStagingArea = JobSubmissionFiles.getStagingDir(cluster, conf);
// 2）获取jobid ，并创建job路径
JobID jobId = submitClient.getNewJobID();
rmClient.getNewApplication(request);
response.setApplicationId(getNewApplicationId());
// org.apache.hadoop.yarn.server.resourcemanager.ClientRMService: Allocated new applicationId: 1
// 3）拷贝jar包到集群
copyAndConfigureFiles(job, submitJobDir);
rUploader.uploadFiles(job, jobSubmitDir);
// 4）计算切片，生成切片规划文件
writeSplits(job, submitJobDir);
maps = writeNewSplits(job, jobSubmitDir);
InputFormat<?, ?> input = ReflectionUtils.newInstance(job.getInputFormatClass(), conf);
// 默认 TextInputFormat
conf.getClass(INPUT_FORMAT_CLASS_ATTR, TextInputFormat.class);
input.getSplits(job);
listStatus(job);
// input.FileInputFormat: Total input files to process : 8
// mapreduce.JobSubmitter: number of splits:8

// 5）向Stag路径写xml配置文件
writeConf(conf, submitJobFile);
conf.writeXml(out);

printTokens(jobId, job.getCredentials());
// mapreduce.JobSubmitter: Submitting tokens for job:

// 6）提交job，返回提交状态
status = submitClient.submitJob(jobId, submitJobDir.toString(), job.getCredentials());
ApplicationSubmissionContext appContext =
	createApplicationSubmissionContext(conf, jobSubmitDir, ts);
setupLocalResources(jobConf, jobSubmitDir);
createApplicationResource();
// Setup security tokens
ts.writeTokenStorageToStream(dob);
setupAMCommand(jobConf);
ContainerLaunchContext amContainer = setupContainerLaunchContextForAM(
        jobConf, localResources, securityTokens, vargs);
MRApps.setupDistributedCache(jobConf, localResources);
lrb.createLocalResources(localResources);
ContainerLaunchContext.newInstance(localResources, environment,
        vargsFinal, null, securityTokens, acls);
List<ResourceRequest> amResourceRequests = generateResourceRequests();

resMgrDelegate.submitApplication(appContext);
client.submitApplication(appContext);
rmClient.submitApplication(request);
ApplicationClientProtocolPBClientImpl.this.submitApplication();
proxy.submitApplication(null, requestProto);
real.submitApplication(request);
//  org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Start request for container_1637633166384_0001_01_000001 by user liuxy


rmAppManager.submitApplication(submissionContext, System.currentTimeMillis(), user);
RMAppImpl application = createAndPopulateNewRMApp();
scheduler.checkAndGetApplicationPriority();
// org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Application 'application_1637633166384_0001' is submitted without priority hence considering default queue/cluster priority: 0
// org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Priority '0' is acceptable in queue : default for application: application_1637633166384_0001
// org.apache.hadoop.yarn.server.resourcemanager.ClientRMService: Application with id 1 submitted by user liuxy

RMAppNewlySavingTransition.this.transition();
// org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: Storing application with id application_1637633166384_0001
StoreAppTransition.this.transition();
// org.apache.hadoop.yarn.server.resourcemanager.recovery.RMStateStore: Storing info for app: application_1637633166384_0001

handleStoreEvent();
// org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: application_1637633166384_0001 State change from NEW to NEW_SAVING on event = START
// org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: application_1637633166384_0001 State change from NEW_SAVING to SUBMITTED on event = APP_NEW_SAVED
// org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: application_1637633166384_0001 State change from SUBMITTED to ACCEPTED on event = APP_ACCEPTED

// impl.YarnClientImpl: Submitted application application_1637542788396_0002


addResourcesFileToConf();
// resource.ResourceUtils: Unable to find 'resource-types.xml'.
addMandatoryResources();
// resource.ResourceUtils: Adding resource type - name = memory-mb, units = Mi, type = COUNTABLE
// resource.ResourceUtils: Adding resource type - name = vcores, units = , type = COUNTABLE
ApplicationClientProtocolPBServiceImpl.this.submitApplication();


2021-11-23 10:06:27,316 INFO org.apache.hadoop.yarn.server.resourcemanager.ClientRMService: Allocated new applicationId: 1
2021-11-23 10:06:29,211 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Application 'application_1637633166384_0001' is submitted without priority hence considering default queue/cluster priority: 0
2021-11-23 10:06:29,211 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Priority '0' is acceptable in queue : default for application: application_1637633166384_0001
2021-11-23 10:06:29,232 INFO org.apache.hadoop.yarn.server.resourcemanager.ClientRMService: Application with id 1 submitted by user liuxy
2021-11-23 10:06:29,232 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: Storing application with id application_1637633166384_0001
2021-11-23 10:06:29,235 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    IP=127.0.0.1    OPERATION=Submit Application Request    TARGET=ClientRMService  RESULT=SUCCESS  APPID=application_1637633166384_0001    CALLERCONTEXT=CLI       QUEUENAME=default
2021-11-23 10:06:29,241 INFO org.apache.hadoop.yarn.server.resourcemanager.recovery.RMStateStore: Storing info for app: application_1637633166384_0001
2021-11-23 10:06:29,241 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: application_1637633166384_0001 State change from NEW to NEW_SAVING on event = START
2021-11-23 10:06:29,242 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: application_1637633166384_0001 State change from NEW_SAVING to SUBMITTED on event = APP_NEW_SAVED
2021-11-23 10:06:29,245 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: Application added - appId: application_1637633166384_0001 user: liuxy leaf-queue of parent: root #applications: 1
2021-11-23 10:06:29,245 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Accepted application application_1637633166384_0001 from user: liuxy, in queue: default
2021-11-23 10:06:29,255 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: application_1637633166384_0001 State change from SUBMITTED to ACCEPTED on event = APP_ACCEPTED
2021-11-23 10:06:29,281 INFO org.apache.hadoop.yarn.server.resourcemanager.ApplicationMasterService: Registering app attempt : appattempt_1637633166384_0001_000001
2021-11-23 10:06:29,282 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.attempt.RMAppAttemptImpl: appattempt_1637633166384_0001_000001 State change from NEW to SUBMITTED on event = START
2021-11-23 10:06:29,299 WARN org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.LeafQueue: maximum-am-resource-percent is insufficient to start a single application in queue, it is likely set too low. skipping enforcement to allow at least one application to start
2021-11-23 10:06:29,299 WARN org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.LeafQueue: maximum-am-resource-percent is insufficient to start a single application in queue for user, it is likely set too low. skipping enforcement to allow at least one application to start
2021-11-23 10:06:29,302 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.LeafQueue: Application application_1637633166384_0001 from user: liuxy activated in queue: default
2021-11-23 10:06:29,302 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.LeafQueue: Application added - appId: application_1637633166384_0001 user: liuxy, leaf-queue: default #user-pending-applications: 0 #user-active-applications: 1 #queue-pending-applications: 0 #queue-active-applications: 1
2021-11-23 10:06:29,302 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Added Application Attempt appattempt_1637633166384_0001_000001 to scheduler from user liuxy in queue default
2021-11-23 10:06:29,311 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.attempt.RMAppAttemptImpl: appattempt_1637633166384_0001_000001 State change from SUBMITTED to SCHEDULED on event = ATTEMPT_ADDED
2021-11-23 10:06:29,400 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.allocator.AbstractContainerAllocator: assignedContainer application attempt=appattempt_1637633166384_0001_000001 container=null queue=default clusterResource=<memory:8192, vCores:8> type=OFF_SWITCH requestedPartition=
2021-11-23 10:06:29,404 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000001 Container Transitioned from NEW to ALLOCATED
2021-11-23 10:06:29,405 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Allocated Container        TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000001      RESOURCE=<memory:2048, vCores:1>        QUEUENAME=default
2021-11-23 10:06:29,406 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: assignedContainer queue=root usedCapacity=0.25 absoluteUsedCapacity=0.25 used=<memory:2048, vCores:1> cluster=<memory:8192, vCores:8>
2021-11-23 10:06:29,406 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Allocation proposal accepted
2021-11-23 10:06:29,428 INFO org.apache.hadoop.yarn.server.resourcemanager.security.NMTokenSecretManagerInRM: Sending NMToken for nodeId : LAPTOP-GCQQL01V.localdomain:35723 for container : container_1637633166384_0001_01_000001
2021-11-23 10:06:29,439 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000001 Container Transitioned from ALLOCATED to ACQUIRED
2021-11-23 10:06:29,440 INFO org.apache.hadoop.yarn.server.resourcemanager.security.NMTokenSecretManagerInRM: Clear node set for appattempt_1637633166384_0001_000001
2021-11-23 10:06:29,441 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.attempt.RMAppAttemptImpl: Storing attempt: AppId: application_1637633166384_0001 AttemptId: appattempt_1637633166384_0001_000001 MasterContainer: Container: [ContainerId: container_1637633166384_0001_01_000001, AllocationRequestId: 0, Version: 0, NodeId: LAPTOP-GCQQL01V.localdomain:35723, NodeHttpAddress: LAPTOP-GCQQL01V.localdomain:8042, Resource: <memory:2048, vCores:1>, Priority: 0, Token: Token { kind: ContainerToken, service: 127.0.1.1:35723 }, ExecutionType: GUARANTEED, ]
2021-11-23 10:06:29,454 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.attempt.RMAppAttemptImpl: appattempt_1637633166384_0001_000001 State change from SCHEDULED to ALLOCATED_SAVING on event = CONTAINER_ALLOCATED
2021-11-23 10:06:29,457 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.attempt.RMAppAttemptImpl: appattempt_1637633166384_0001_000001 State change from ALLOCATED_SAVING to ALLOCATED on event = ATTEMPT_NEW_SAVED
2021-11-23 10:06:29,460 INFO org.apache.hadoop.yarn.server.resourcemanager.amlauncher.AMLauncher: Launching masterappattempt_1637633166384_0001_000001
2021-11-23 10:06:29,512 INFO org.apache.hadoop.yarn.server.resourcemanager.amlauncher.AMLauncher: Setting up container Container: [ContainerId: container_1637633166384_0001_01_000001, AllocationRequestId: 0, Version: 0, NodeId: LAPTOP-GCQQL01V.localdomain:35723, NodeHttpAddress: LAPTOP-GCQQL01V.localdomain:8042, Resource: <memory:2048, vCores:1>, Priority: 0, Token: Token { kind: ContainerToken, service: 127.0.1.1:35723 }, ExecutionType: GUARANTEED, ] for AM appattempt_1637633166384_0001_000001
2021-11-23 10:06:29,514 INFO org.apache.hadoop.yarn.server.resourcemanager.security.AMRMTokenSecretManager: Create AMRMToken for ApplicationAttempt: appattempt_1637633166384_0001_000001
2021-11-23 10:06:29,517 INFO org.apache.hadoop.yarn.server.resourcemanager.security.AMRMTokenSecretManager: Creating password for appattempt_1637633166384_0001_000001
2021-11-23 10:06:29,779 INFO org.apache.hadoop.yarn.server.resourcemanager.amlauncher.AMLauncher: Done launching container Container: [ContainerId: container_1637633166384_0001_01_000001, AllocationRequestId: 0, Version: 0, NodeId: LAPTOP-GCQQL01V.localdomain:35723, NodeHttpAddress: LAPTOP-GCQQL01V.localdomain:8042, Resource: <memory:2048, vCores:1>, Priority: 0, Token: Token { kind: ContainerToken, service: 127.0.1.1:35723 }, ExecutionType: GUARANTEED, ] for AM appattempt_1637633166384_0001_000001
2021-11-23 10:06:29,779 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.attempt.RMAppAttemptImpl: appattempt_1637633166384_0001_000001 State change from ALLOCATED to LAUNCHED on event = LAUNCHED
2021-11-23 10:06:29,780 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: update the launch time for applicationId: application_1637633166384_0001, attemptId: appattempt_1637633166384_0001_000001launchTime: 1637633189779
2021-11-23 10:06:29,780 INFO org.apache.hadoop.yarn.server.resourcemanager.recovery.RMStateStore: Updating info for app: application_1637633166384_0001
2021-11-23 10:06:30,389 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000001 Container Transitioned from ACQUIRED to RUNNING
2021-11-23 10:06:34,211 INFO SecurityLogger.org.apache.hadoop.ipc.Server: Auth successful for appattempt_1637633166384_0001_000001 (auth:SIMPLE)
2021-11-23 10:06:34,229 INFO org.apache.hadoop.yarn.server.resourcemanager.DefaultAMSProcessor: AM registration appattempt_1637633166384_0001_000001
2021-11-23 10:06:34,230 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    IP=127.0.0.1    OPERATION=Register App Master   TARGET=ApplicationMasterService RESULT=SUCCESS  APPID=application_1637633166384_0001    APPATTEMPTID=appattempt_1637633166384_0001_000001
2021-11-23 10:06:34,230 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.attempt.RMAppAttemptImpl: appattempt_1637633166384_0001_000001 State change from LAUNCHED to RUNNING on event = REGISTERED
2021-11-23 10:06:34,230 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: application_1637633166384_0001 State change from ACCEPTED to RUNNING on event = ATTEMPT_REGISTERED
2021-11-23 10:06:35,406 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.allocator.AbstractContainerAllocator: assignedContainer application attempt=appattempt_1637633166384_0001_000001 container=null queue=default clusterResource=<memory:8192, vCores:8> type=NODE_LOCAL requestedPartition=
2021-11-23 10:06:35,407 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000002 Container Transitioned from NEW to ALLOCATED
2021-11-23 10:06:35,407 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Allocated Container        TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000002      RESOURCE=<memory:1024, vCores:1>        QUEUENAME=default
2021-11-23 10:06:35,407 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: assignedContainer queue=root usedCapacity=0.375 absoluteUsedCapacity=0.375 used=<memory:3072, vCores:2> cluster=<memory:8192, vCores:8>
2021-11-23 10:06:35,408 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Allocation proposal accepted
2021-11-23 10:06:35,408 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.allocator.AbstractContainerAllocator: assignedContainer application attempt=appattempt_1637633166384_0001_000001 container=null queue=default clusterResource=<memory:8192, vCores:8> type=NODE_LOCAL requestedPartition=
2021-11-23 10:06:35,408 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000003 Container Transitioned from NEW to ALLOCATED
2021-11-23 10:06:35,409 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Allocated Container        TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000003      RESOURCE=<memory:1024, vCores:1>        QUEUENAME=default
2021-11-23 10:06:35,409 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: assignedContainer queue=root usedCapacity=0.5 absoluteUsedCapacity=0.5 used=<memory:4096, vCores:3> cluster=<memory:8192, vCores:8>
2021-11-23 10:06:35,409 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Allocation proposal accepted
2021-11-23 10:06:35,409 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.allocator.AbstractContainerAllocator: assignedContainer application attempt=appattempt_1637633166384_0001_000001 container=null queue=default clusterResource=<memory:8192, vCores:8> type=NODE_LOCAL requestedPartition=
2021-11-23 10:06:35,409 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000004 Container Transitioned from NEW to ALLOCATED
2021-11-23 10:06:35,410 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Allocated Container        TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000004      RESOURCE=<memory:1024, vCores:1>        QUEUENAME=default
2021-11-23 10:06:35,410 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: assignedContainer queue=root usedCapacity=0.625 absoluteUsedCapacity=0.625 used=<memory:5120, vCores:4> cluster=<memory:8192, vCores:8>
2021-11-23 10:06:35,410 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Allocation proposal accepted
2021-11-23 10:06:35,410 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.allocator.AbstractContainerAllocator: assignedContainer application attempt=appattempt_1637633166384_0001_000001 container=null queue=default clusterResource=<memory:8192, vCores:8> type=NODE_LOCAL requestedPartition=
2021-11-23 10:06:35,411 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000005 Container Transitioned from NEW to ALLOCATED
2021-11-23 10:06:35,411 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Allocated Container        TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000005      RESOURCE=<memory:1024, vCores:1>        QUEUENAME=default
2021-11-23 10:06:35,411 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: assignedContainer queue=root usedCapacity=0.75 absoluteUsedCapacity=0.75 used=<memory:6144, vCores:5> cluster=<memory:8192, vCores:8>
2021-11-23 10:06:35,411 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Allocation proposal accepted
2021-11-23 10:06:35,412 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.allocator.AbstractContainerAllocator: assignedContainer application attempt=appattempt_1637633166384_0001_000001 container=null queue=default clusterResource=<memory:8192, vCores:8> type=NODE_LOCAL requestedPartition=
2021-11-23 10:06:35,412 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000006 Container Transitioned from NEW to ALLOCATED
2021-11-23 10:06:35,412 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Allocated Container        TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000006      RESOURCE=<memory:1024, vCores:1>        QUEUENAME=default
2021-11-23 10:06:35,412 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: assignedContainer queue=root usedCapacity=0.875 absoluteUsedCapacity=0.875 used=<memory:7168, vCores:6> cluster=<memory:8192, vCores:8>
2021-11-23 10:06:35,412 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Allocation proposal accepted
2021-11-23 10:06:35,413 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.allocator.AbstractContainerAllocator: assignedContainer application attempt=appattempt_1637633166384_0001_000001 container=null queue=default clusterResource=<memory:8192, vCores:8> type=NODE_LOCAL requestedPartition=
2021-11-23 10:06:35,413 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000007 Container Transitioned from NEW to ALLOCATED
2021-11-23 10:06:35,413 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Allocated Container        TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000007      RESOURCE=<memory:1024, vCores:1>        QUEUENAME=default
2021-11-23 10:06:35,413 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: assignedContainer queue=root usedCapacity=1.0 absoluteUsedCapacity=1.0 used=<memory:8192, vCores:7> cluster=<memory:8192, vCores:8>
2021-11-23 10:06:35,413 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Allocation proposal accepted
2021-11-23 10:06:36,304 INFO org.apache.hadoop.yarn.server.resourcemanager.security.NMTokenSecretManagerInRM: Sending NMToken for nodeId : LAPTOP-GCQQL01V.localdomain:35723 for container : container_1637633166384_0001_01_000002
2021-11-23 10:06:36,305 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000002 Container Transitioned from ALLOCATED to ACQUIRED
2021-11-23 10:06:36,307 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000003 Container Transitioned from ALLOCATED to ACQUIRED
2021-11-23 10:06:36,311 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000004 Container Transitioned from ALLOCATED to ACQUIRED
2021-11-23 10:06:36,315 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000005 Container Transitioned from ALLOCATED to ACQUIRED
2021-11-23 10:06:36,317 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000006 Container Transitioned from ALLOCATED to ACQUIRED
2021-11-23 10:06:36,318 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000007 Container Transitioned from ALLOCATED to ACQUIRED
2021-11-23 10:06:37,414 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000002 Container Transitioned from ACQUIRED to RUNNING
2021-11-23 10:06:37,415 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000003 Container Transitioned from ACQUIRED to RUNNING
2021-11-23 10:06:37,416 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000004 Container Transitioned from ACQUIRED to RUNNING
2021-11-23 10:06:37,416 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000005 Container Transitioned from ACQUIRED to RUNNING
2021-11-23 10:06:37,417 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000006 Container Transitioned from ACQUIRED to RUNNING
2021-11-23 10:06:37,418 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000007 Container Transitioned from ACQUIRED to RUNNING
2021-11-23 10:06:43,535 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000007 Container Transitioned from RUNNING to COMPLETED
2021-11-23 10:06:43,535 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Released Container TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000007      RESOURCE=<memory:1024, vCores:1>
        QUEUENAME=default
2021-11-23 10:06:43,537 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.allocator.AbstractContainerAllocator: assignedContainer application attempt=appattempt_1637633166384_0001_000001 container=null queue=default clusterResource=<memory:8192, vCores:8> type=NODE_LOCAL requestedPartition=
2021-11-23 10:06:43,537 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000008 Container Transitioned from NEW to ALLOCATED

2021-11-23 10:06:43,537 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Allocated Container        TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000008      RESOURCE=<memory:1024, vCores:1>        QUEUENAME=default
2021-11-23 10:06:43,537 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: assignedContainer queue=root usedCapacity=1.0 absoluteUsedCapacity=1.0 used=<memory:8192, vCores:7> cluster=<memory:8192, vCores:8>
2021-11-23 10:06:43,537 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Allocation proposal accepted
2021-11-23 10:06:43,569 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000002 Container Transitioned from RUNNING to COMPLETED
2021-11-23 10:06:43,569 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Released Container TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000002      RESOURCE=<memory:1024, vCores:1>
        QUEUENAME=default
2021-11-23 10:06:43,570 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.allocator.AbstractContainerAllocator: assignedContainer application attempt=appattempt_1637633166384_0001_000001 container=null queue=default clusterResource=<memory:8192, vCores:8> type=NODE_LOCAL requestedPartition=
2021-11-23 10:06:43,572 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000009 Container Transitioned from NEW to ALLOCATED
2021-11-23 10:06:43,572 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Allocated Container        TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000009      RESOURCE=<memory:1024, vCores:1>        QUEUENAME=default
2021-11-23 10:06:43,572 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: assignedContainer queue=root usedCapacity=1.0 absoluteUsedCapacity=1.0 used=<memory:8192, vCores:7> cluster=<memory:8192, vCores:8>
2021-11-23 10:06:43,572 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Allocation proposal accepted
2021-11-23 10:06:43,590 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000003 Container Transitioned from RUNNING to COMPLETED
2021-11-23 10:06:43,590 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Released Container TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000003      RESOURCE=<memory:1024, vCores:1>
        QUEUENAME=default
2021-11-23 10:06:43,676 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000006 Container Transitioned from RUNNING to COMPLETED
2021-11-23 10:06:43,676 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Released Container TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000006      RESOURCE=<memory:1024, vCores:1>
        QUEUENAME=default
2021-11-23 10:06:43,698 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000005 Container Transitioned from RUNNING to COMPLETED
2021-11-23 10:06:43,698 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Released Container TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000005      RESOURCE=<memory:1024, vCores:1>
        QUEUENAME=default
2021-11-23 10:06:43,740 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000004 Container Transitioned from RUNNING to COMPLETED
2021-11-23 10:06:43,741 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Released Container TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000004      RESOURCE=<memory:1024, vCores:1>
        QUEUENAME=default

2021-11-23 10:06:44,415 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000008 Container Transitioned from ALLOCATED to ACQUIRED
2021-11-23 10:06:44,417 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000009 Container Transitioned from ALLOCATED to ACQUIRED
2021-11-23 10:06:44,745 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000008 Container Transitioned from ACQUIRED to RUNNING
2021-11-23 10:06:44,745 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000009 Container Transitioned from ACQUIRED to RUNNING
2021-11-23 10:06:44,746 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.allocator.AbstractContainerAllocator: assignedContainer application attempt=appattempt_1637633166384_0001_000001 container=null queue=default clusterResource=<memory:8192, vCores:8> type=OFF_SWITCH requestedPartition=
2021-11-23 10:06:44,747 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000010 Container Transitioned from NEW to ALLOCATED
2021-11-23 10:06:44,747 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Allocated Container        TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000010      RESOURCE=<memory:1024, vCores:1>        QUEUENAME=default
2021-11-23 10:06:44,747 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: assignedContainer queue=root usedCapacity=0.625 absoluteUsedCapacity=0.625 used=<memory:5120, vCores:4> cluster=<memory:8192, vCores:8>
2021-11-23 10:06:44,747 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Allocation proposal accepted
2021-11-23 10:06:45,433 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.AppSchedulingInfo: checking for deactivate of application :application_1637633166384_0001
2021-11-23 10:06:45,436 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000010 Container Transitioned from ALLOCATED to ACQUIRED
2021-11-23 10:06:45,752 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000010 Container Transitioned from ACQUIRED to RUNNING
2021-11-23 10:06:46,447 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.AppSchedulingInfo: checking for deactivate of application :application_1637633166384_0001
2021-11-23 10:06:48,353 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000008 Container Transitioned from RUNNING to COMPLETED
2021-11-23 10:06:48,353 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Released Container TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000008      RESOURCE=<memory:1024, vCores:1>
        QUEUENAME=default
2021-11-23 10:06:48,412 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000009 Container Transitioned from RUNNING to COMPLETED
2021-11-23 10:06:48,412 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Released Container TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000009      RESOURCE=<memory:1024, vCores:1>
        QUEUENAME=default
2021-11-23 10:06:49,175 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000010 Container Transitioned from RUNNING to COMPLETED
2021-11-23 10:06:49,175 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Released Container TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000010      RESOURCE=<memory:1024, vCores:1>
        QUEUENAME=default

2021-11-23 10:06:50,209 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.attempt.RMAppAttemptImpl: Updating application attempt appattempt_1637633166384_0001_000001 with final state: FINISHING, and exit status: -1000
2021-11-23 10:06:50,210 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.attempt.RMAppAttemptImpl: appattempt_1637633166384_0001_000001 State change from RUNNING to FINAL_SAVING on event = UNREGISTERED
2021-11-23 10:06:50,210 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: Updating application application_1637633166384_0001 with final state: FINISHING
2021-11-23 10:06:50,210 INFO org.apache.hadoop.yarn.server.resourcemanager.recovery.RMStateStore: Updating info for app: application_1637633166384_0001
2021-11-23 10:06:50,210 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: application_1637633166384_0001 State change from RUNNING to FINAL_SAVING on event = ATTEMPT_UNREGISTERED
2021-11-23 10:06:50,210 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.attempt.RMAppAttemptImpl: appattempt_1637633166384_0001_000001 State change from FINAL_SAVING to FINISHING on event = ATTEMPT_UPDATE_SAVED
2021-11-23 10:06:50,211 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: application_1637633166384_0001 State change from FINAL_SAVING to FINISHING on event = APP_UPDATE_SAVED
2021-11-23 10:06:51,212 INFO org.apache.hadoop.yarn.server.resourcemanager.ApplicationMasterService: application_1637633166384_0001 unregistered successfully.
2021-11-23 10:06:56,703 INFO org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.RMContainerImpl: container_1637633166384_0001_01_000001 Container Transitioned from RUNNING to COMPLETED
2021-11-23 10:06:56,704 INFO org.apache.hadoop.yarn.server.resourcemanager.ApplicationMasterService: Unregistering app attempt : appattempt_1637633166384_0001_000001
2021-11-23 10:06:56,704 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=AM Released Container TARGET=SchedulerApp     RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000001      RESOURCE=<memory:2048, vCores:1>
        QUEUENAME=default
2021-11-23 10:06:56,705 INFO org.apache.hadoop.yarn.server.resourcemanager.security.AMRMTokenSecretManager: Application finished, removing password for appattempt_1637633166384_0001_000001
2021-11-23 10:06:56,705 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.attempt.RMAppAttemptImpl: appattempt_1637633166384_0001_000001 State change from FINISHING to FINISHED on event = CONTAINER_FINISHED
2021-11-23 10:06:56,708 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppImpl: application_1637633166384_0001 State change from FINISHING to FINISHED on event = ATTEMPT_FINISHED
2021-11-23 10:06:56,708 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Application Attempt appattempt_1637633166384_0001_000001 is done. finalState=FINISHED
2021-11-23 10:06:56,708 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.AppSchedulingInfo: Application application_1637633166384_0001 requests cleared
2021-11-23 10:06:56,708 INFO org.apache.hadoop.yarn.server.resourcemanager.amlauncher.AMLauncher: Cleaning master appattempt_1637633166384_0001_000001
2021-11-23 10:06:56,709 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.LeafQueue: Application removed - appId: application_1637633166384_0001 user: liuxy queue: default #user-pending-applications: 0 #user-active-applications: 0 #queue-pending-applications: 0 #queue-active-applications: 0
2021-11-23 10:06:56,709 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: Application removed - appId: application_1637633166384_0001 user: liuxy leaf-queue of parent: root #applications: 0
2021-11-23 10:06:56,710 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAuditLogger: USER=liuxy    OPERATION=Application Finished - Succeeded      TARGET=RMAppManager     RESULT=SUCCESS  APPID=application_1637633166384_0001
2021-11-23 10:06:56,714 INFO org.apache.hadoop.yarn.server.resourcemanager.RMAppManager$ApplicationSummary: appId=application_1637633166384_0001,name=grep-search,user=liuxy,queue=default,state=FINISHED,trackingUrl=http://LAPTOP-GCQQL01V.localdomain:8088/proxy/application_1637633166384_0001/,appMasterHost=LAPTOP-GCQQL01V.localdomain,submitTime=1637633189105,startTime=1637633189231,launchTime=1637633189779,finishTime=1637633210210,finalStatus=SUCCEEDED,memorySeconds=120884,vcoreSeconds=87,preemptedMemorySeconds=0,preemptedVcoreSeconds=0,preemptedAMContainers=0,preemptedNonAMContainers=0,preemptedResources=<memory:0\, vCores:0>,applicationType=MAPREDUCE,resourceSeconds=120884 MB-seconds\, 87 vcore-seconds,preemptedResourceSeconds=0 MB-seconds\, 0 vcore-seconds,applicationTags=,applicationNodeLabel=,diagnostics=,totalAllocatedContainers=10
```

submitClient当前有两个实现：LocalJobRunner和YARNRunner。

#### 输入数据接口：InputFormat

InputFormat 常见的接口实现类包括：TextInputFormat、KeyValueTextInputFormat、NLineInputFormat、CombineTextInputFormat和自定义InputFormat等。

默认使用的实现类是：TextInputFormat。一次读一行文本，然后将该行的起始偏移量作为key，行内容作为value返回。键是LongWritable 类型，存储该行在整个文件中的字节偏移量。 值是这行的内容，不包括任何行终止符（换行符合回车符），它被打包成一个 Text 对象。

KeyValueTextInputFormat每一行均为一条记录， 被分隔符（缺省是tab（\t））分割为key（Text）,value（Text）。可以通过mapreduce.input.keyvaluelinerecordreader.key.value,separator属性（或者旧版本 API 中的 key.value.separator.in.input.line）来设定分隔符。 它的默认值是一个制表符。

NLineInputFormat通过 TextInputFormat 和 KeyValueTextInputFormat，每个 Mapper 收到的输入行数不同。行数取决于输入分片的大小和行的长度。 如果希望 Mapper 收到固定行数的输入，需要将 NLineInputFormat 作为 InputFormat。与 TextInputFormat 一样， 键是文件中行的字节偏移量，值是行本身。N 是每个 Mapper 收到的输入行数。N 设置为1（默认值）时，每个 Mapper 正好收到一行输入。 mapreduce.input.lineinputformat.linespermap 属性（在旧版本 API 中的 mapred.line.input.format.linespermap 属性）实现 N 值的设定。

CombineTextInputFormat可以把多个小文件合并成一个切片处理，提高处理效率。

##### 获取切片信息API
```java
// 根据文件类型获取切片信息
FileSplit inputSplit = (FileSplit) context.getInputSplit();
// 获取切片的文件名称
String name = inputSplit.getPath().getName();
```

##### FileInputFormat

FileInputFormat中默认的切片机制

1. 简单地按照文件的内容长度进行切片
2. 切片大小，默认等于block大小
3. 切片时不考虑数据集整体，而是逐个针对每一个文件单独切片

FileInputFormat切片大小的参数配置

在FileInputFormat中，计算切片大小的逻辑：Math.max(minSize, Math.min(maxSize, blockSize));

切片主要由这几个值来运算决定

mapreduce.input.fileinputformat.split.minsize=1 默认值为1

mapreduce.input.fileinputformat.split.maxsize= Long.MAXValue 默认值Long.MAXValue

因此，默认情况下，切片大小=blocksize。

maxsize（切片最大值）：参数如果调得比blocksize小，则会让切片变小，而且就等于配置的这个参数的值。

minsize（切片最小值）：参数调的比blockSize大，则可以让切片变得比blocksize还大。

**FileInputFormat.this.getSplits(job)**

1. 找到数据存储的目录。
2. 开始遍历处理（规划切片）目录下的每一个文件
3. 遍历第一个文件ss.txt
	1. 获取文件大小fs.sizeOf(ss.txt);
	2. 计算切片大小computeSliteSize(Math.max(minSize,Math.min(maxSize,blocksize)))=blocksize=128M
	3. 默认情况下，切片大小=blocksize
	4. 开始切，形成第1个切片：ss.txt—0:128M 第2个切片ss.txt—128:256M 第3个切片ss.txt—256M:300M（每次切片时，都要判断切完剩下的部分是否大于块的1.1倍，不大于1.1倍就划分一块切片）
	5. 将切片信息写到一个切片规划文件中
	6. 整个切片的核心过程在getSplit()方法中完成。
	7. 数据切片只是在逻辑上对输入数据进行分片，并不会再磁盘上将其切分成分片进行存储。InputSplit只记录了分片的元数据信息，比如起始位置、长度以及所在的节点列表等。
	8. 注意：block是HDFS上物理上存储的存储的数据，切片是对数据逻辑上的划分。
4. 提交切片规划文件到yarn上，yarn上的MrAppMaster就可以根据切片规划文件计算开启maptask个数。

##### CombineTextInputFormat

关于大量小文件的优化策略

1. 默认情况下TextInputformat对任务的切片机制是按文件规划切片，不管文件多小，都会是一个单独的切片，都会交给一个maptask，这样如果有大量小文件，就会产生大量的maptask，处理效率极其低下。
2. 优化策略
	1. 最好的办法，在数据处理系统的最前端（预处理/采集），将小文件先合并成大文件，再上传到HDFS做后续分析。
	2. 补救措施：如果已经是大量小文件在HDFS中了，可以使用另一种InputFormat来做切片（CombineFileInputFormat），它的切片逻辑跟TextFileInputFormat不同：它可以将多个小文件从逻辑上规划到一个切片中，这样，多个小文件就可以交给一个maptask。
	3. 优先满足最小切片大小，不超过最大切片大小
3. 具体实现步骤
	```java
	// 举例：0.5m+1m+0.3m+5m=2m + 4.8m=2m + 4m + 0.8m
	// 如果不设置InputFormat，它默认用的是TextInputFormat.class
	job.setInputFormatClass(CombineTextInputFormat.class)
	CombineTextInputFormat.setMaxInputSplitSize(job, 4194304);// 4m
	CombineTextInputFormat.setMinInputSplitSize(job, 2097152);// 2m
	```

#### MapTask 机制
1. Read阶段：MapTask通过用户编写的RecordReader，从输入InputSplit中解析出一个个key/value。
2. Map阶段：该节点主要是将解析出的key/value交给用户编写map()函数处理，并产生一系列新的key/value。
3. Collect收集阶段：在用户编写map()函数中，当数据处理完成后，一般会调用OutputCollector.collect()输出结果。在该函数内部，它会将生成的key/value分区（调用Partitioner），并写入一个环形内存缓冲区中。
4. Spill阶段：即“溢写”，当环形缓冲区满后，MapReduce会将数据写到本地磁盘上，生成一个临时文件。需要注意的是，将数据写入本地磁盘之前，先要对数据进行一次本地排序，并在必要时对数据进行合并、压缩等操作。
	1. 利用快速排序算法对缓存区内的数据进行排序，排序方式是，先按照分区编号partition进行排序，然后按照key进行排序。这样，经过排序后，数据以分区为单位聚集在一起，且同一分区内所有数据按照key有序。
	2. 按照分区编号由小到大依次将每个分区中的数据写入任务工作目录下的临时文件output/spillN.out（N表示当前溢写次数）中。如果用户设置了Combiner，则写入文件之前，对每个分区中的数据进行一次聚集操作。
	3. 将分区数据的元信息写到内存索引数据结构SpillRecord中，其中每个分区的元信息包括在临时文件中的偏移量、压缩前数据大小和压缩后数据大小。如果当前内存索引大小超过1MB，则将内存索引写到文件output/spillN.out.index中。
5. Combine阶段：当所有数据处理完成后，MapTask对所有临时文件进行一次合并，以确保最终只会生成一个数据文件。当所有数据处理完后，MapTask会将所有临时文件合并成一个大文件，并保存到文件output/file.out中，同时生成相应的索引文件output/file.out.index。在进行文件合并过程中，MapTask以分区为单位进行合并。对于某个分区，它将采用多轮递归合并的方式。每轮合并io.sort.factor（默认100）个文件，并将产生的文件重新加入待合并列表中，对文件排序后，重复以上过程，直到最终得到一个大文件。让每个MapTask最终只生成一个数据文件，可避免同时打开大量文件和同时读取大量小文件产生的随机读取带来的开销。

##### MapTask 并行度
maptask的并行度决定map阶段的任务处理并发度，进而影响到整个job的处理速度。那么，mapTask并行任务是否越多越好呢？

1. 一个job的map阶段MapTask并行度（个数），由客户端提交job时的切片个数决定。
2. 每一个split切片分配一个mapTask实例处理
3. 默认情况下，切片大小等于blocksize
4. 切片时不考虑数据集整体，而是逐个针对每一个文件切片

如果硬件配置为 2\*12core + 64G，恰当的 map 并行度是大约每个节点 20-100 个 map，最好每个 map 的执行时间至少一分钟。

1. 如果 job 的每个 map 或者 reduce task 的运行时间都只有 30-40 秒钟，那么就减少该 job 的 map 或者 reduce 数，每一个 task(map\|reduce)的 setup 和加入到调度器中进行调度，这个中间的过程可能都要花费几秒钟，所以如果每个 task 都非常快就跑完了，就会在 task 的开 始和结束的时候浪费太多的时间。

配置 task 的 JVM 重用可以改善该问题：

mapred.job.reuse.jvm.num.tasks，默认是 1，表示一个 JVM 上最多可以顺序执行的 task 数目（属于同一个 Job）是 1。也就是说一个 task 启一个 JVM。这个值可以在 mapred-site.xml 中进行更改，当设置成多个，就意味着这多个 task 运行在同一个 JVM 上，但不是同时执行， 是排队顺序执行。

2. 如果 input 的文件非常的大，比如 1TB，可以考虑将 hdfs 上的每个 blocksize 设大，比如 设成 256MB 或者 512MB。

##### Shuffle 机制
MapReduce 中，mapper 阶段处理的数据如何传递给 reducer 阶段，是 MapReduce 框架中最关键的一个流程，这个流程就叫 Shuffle。

Shuffle: 数据混洗 ——（核心机制：数据分区，排序，局部聚合，缓存，拉取，再合并排序）。

具体来说：就是将 MapTask 输出的处理结果数据，按照 Partitioner 组件制定的规则分发 给 ReduceTask，并在分发的过程中，对数据按 key 进行了分区和排序

Mapreduce确保每个reducer的输入都是按键排序的。系统执行排序的过程（即将map输出作为输入传给reducer）称为shuffle。

**具体shuffle过程**

1. maptask收集我们的map()方法输出的kv对，放到内存缓冲区中
2. 从内存缓冲区不断溢出本地磁盘文件，可能会溢出多个文件
3. 多个溢出文件会被合并成大的溢出文件
4. 在溢出过程中，及合并的过程中，都要调用partitioner进行分区和针对key进行排序
5. reducetask根据自己的分区号，去各个maptask机器上取相应的结果分区数据
6. reducetask会取到同一个分区的来自不同maptask的结果文件，reducetask会将这些文件再进行合并（归并排序）
7. 合并成大文件后，shuffle的过程也就结束了，后面进入reducetask的逻辑运算过程（从文件中取出一个一个的键值对group，调用用户自定义的reduce()方法）

Shuffle中的缓冲区大小会影响到mapreduce程序的执行效率，原则上说，缓冲区越大，磁盘io的次数越少，执行速度就越快。

缓冲区的大小可以通过参数调整，参数：io.sort.mb  默认100M

##### Partitioner分区

有默认实现 HashPartitioner，根据key的哈希值对numReduces取模来返回一个分区号；key.hashCode()&Integer.MAXVALUE % numReduces。

如果业务上有特别的需求，可以自定义分区。使用自定义分区需要在job驱动中，设置自定义partitioner和相应数量的reduce task：`job.setPartitionerClass(CustomPartitioner.class);job.setNumReduceTasks(5);`

- 如果reduceTask的数量> getPartition的结果数，则会多产生几个空的输出文件part-r-000xx；
- 如果reduceTask的数量< getPartition的结果数，则有一部分分区数据无处安放，会Exception；
- 如果reduceTask的数量=1，则不管mapTask端输出多少个分区文件，最终结果都交给这一个reduceTask，最终也就只会产生一个结果文件 part-r-00000；

##### Comparable排序

当我们用自定义的对象作为key来输出时，就必须要实现WritableComparable接口，重写其中的compareTo()方法。

部分排序：对最终输出的没一个文件进行内部排序。

全排序：对所有数据进行排序，通常只有一个Reduce。

二次排序：排序的条件有两个。 

##### Combiner合并

Combiner合并可以提高程序执行效率，减少io传输。但是使用时必须不能影响原有的业务处理结果。

1. combiner是MR程序中Mapper和Reducer之外的一种组件。
2. combiner组件的父类就是Reducer。
3. combiner和reducer的区别在于运行的位置：
	+ Combiner是在每一个maptask所在的节点运行
	+ Reducer是接收全局所有Mapper的输出结果；
4. combiner的意义就是对每一个maptask的输出进行局部汇总，以减小网络传输量。
5. combiner能够应用的前提是不能影响最终的业务逻辑，而且，combiner的输出kv应该跟reducer的输入kv类型要对应起来。
6. 自定义combiner继承Reducer，重写reduce方法.在job驱动类中设置：`job.setCombinerClass(WordcountCombiner.class);`

#### reduce端分组：Groupingcomparator

reduceTask拿到输入数据（一个partition的所有数据）后，首先需要对数据进行分组，其分组的默认原则是key相同，然后对每一组kv数据调用一次reduce()方法，并且将这一组kv中的第一个kv的key作为参数传给reduce的key，将这一组数据的value的迭代器传给reduce()的values参数。

利用上述这个机制，我们可以实现一个高效的分组取最大值的逻辑。

自定义一个bean对象用来封装我们的数据，然后改写其compareTo方法产生倒序排序的效果。然后自定义一个Groupingcomparator，将bean对象的分组逻辑改成按照我们的业务分组id来分组（比如订单号）。这样，我们要取的最大值就是reduce()方法中传进来key。

#### ReduceTask 机制
1. Copy阶段：ReduceTask从各个MapTask上远程拷贝一片数据，并针对某一片数据，如果其大小超过一定阈值，则写到磁盘上，否则直接放到内存中。
2. Merge阶段：在远程拷贝数据的同时，ReduceTask启动了两个后台线程对内存和磁盘上的文件进行合并，以防止内存使用过多或磁盘上文件过多。
3. Sort阶段：按照MapReduce语义，用户编写reduce()函数输入数据是按key进行聚集的一组数据。为了将key相同的数据聚在一起，Hadoop采用了基于排序的策略。由于各个MapTask已经实现对自己的处理结果进行了局部排序，因此，ReduceTask只需对所有数据进行一次归并排序即可。
4. Reduce阶段：reduce()函数将计算结果写到HDFS上。

##### ReduceTask 并行度
reducetask的并行度同样影响整个job的执行并发度和执行效率，但与maptask的并发数由切片数决定不同，Reducetask数量的决定是可以直接手动设置：

```java
//默认值是1，手动设置为4
job.setNumReduceTasks(4);
```

注意

1. reducetask=0 ，表示没有reduce阶段，输出文件个数和map个数一致。
2. reducetask默认值就是1，所以输出文件个数为一个。
3. 如果数据分布不均匀，就有可能在reduce阶段产生数据倾斜
4. reducetask数量并不是任意设置，还要考虑业务逻辑需求，有些情况下，需要计算全局汇总结果，就只能有1个reducetask。
5. 具体多少个reducetask，需要根据集群性能而定。
6. 如果分区数不是1，但是reducetask为1，是否执行分区过程。答案是：不执行分区过程。因为在maptask的源码中，执行分区的前提是先判断reduceNum个数是否大于1。不大于1肯定不执行。


#### 输出数据接口：OutputFormat

OutputFormat 常见的接口实现类包括：TextOutputFormat、SequenceFileOutputFormat和自定义OutputFormat等。

默认实现类是TextOutputFormat，将每一个KV对向目标文本文件中输出为一行。它的键和值可以是任意类型，因为TextOutputFormat调用toString()方法把它们转换为字符串。

SequenceFileOutputFormat将它的输出写为一个顺序文件。如果输出需要作为后续MapReduce任务的输入，这便是一种好的输出格式，因为它的格式紧凑，很容易被压缩。

#### MapReduce 特点
##### 优点
1. MapReduce 易于编程。它简单的实现一些接口，就可以完成一个分布式程序，这个分布式程序可以分布到大量廉价的 PC 机器运行。也就是说你写一个分布式程序，跟写一个简单的串行程序是一模一样的。 就是因为这个特点使得 MapReduce 编程变得非常流行。
2. 良好的扩展性。当你的计算资源不能得到满足的时候，你可以通过简单的增加机器来扩展它的计算能力。
3. 高容错性。MapReduce 设计的初衷就是使程序能够部署在廉价的 PC 机器上，这就要求它具有很高的容错性。比如其中一台机器挂了，它可以把上面的计算任务转移到另外一个节点上面上运行，不至于这个任务运行失败，而且这个过程不需要人工参与，而完全是由 Hadoop 内部完成的。
4. 适合 PB 级以上海量数据的离线处理。这里加红字体离线处理，说明它适合离线处理而不适合在线处理。比如像毫秒级别的返回一个结果，MapReduce 很难做到。

##### 缺点
MapReduce不擅长做实时计算、流式计算、DAG（有向图）计算。

1. 实时计算。MapReduce 无法像 Mysql 一样，在毫秒或者秒级内返回结果。
2. 流式计算。流式计算的输入数据时动态的，而 MapReduce 的输入数据集是静态的，不能动态变化。这是因为 MapReduce 自身的设计特点决定了数据源必须是静态的。
3. DAG（有向图）计算。多个应用程序存在依赖关系，后一个应用程序的输入为前一个的输出。在这种情况下，MapReduce 并不是不能做，而是使用后，每个MapReduce 作业的输出结果都会写入到磁盘，会造成大量的磁盘IO，导致性能非常的低下。

##### MapReduce 跑的慢的原因
MapReduce 优化方法主要从六个方面考虑：数据输入、Map 阶段、Reduce 阶段、IO 传输、数据倾斜问题和常用的调优参数。

### MapReduce 应用

#### 计数器应用
Hadoop为每个作业维护若干内置计数器，以描述多项指标。例如，某些计数器记录已处理的字节数和记录数，使用户可监控已处理的输入数据量和已产生的输出数据量。

```java
//（1）采用枚举的方式统计计数
enum MyCounter{MALFORORMED,NORMAL}
// 对枚举定义的自定义计数器加1
context.getCounter(MyCounter.MALFORORMED).increment(1); 
//（2）采用计数器组、计数器名称的方式统计
context.getCounter("counterGroup", "countera").increment(1); // 组名和计数器名称随便起，但最好有意义。
//（3）计数结果在程序运行后的控制台上查看。
```

#### Join多种应用
##### Reduce join

1）原理：

Map端的主要工作：为来自不同表(文件)的key/value对打标签以区别不同来源的记录。然后用连接字段作为key，其余部分和新加的标志作为value，最后进行输出。

reduce端的主要工作：在reduce端以连接字段作为key的分组已经完成，我们只需要在每一个分组当中将那些来源于不同文件的记录(在map阶段已经打标志)分开，最后进行合并就ok了

2）该方法的缺点

这里主要分析一下reduce join的一些不足。之所以会存在reduce join这种方式，是因为整体数据被分割了，每个map task只处理一部分数据而不能够获取到所有需要的join字段，因此我们可以充分利用mapreduce框架的特性，让他按照join key进行分区，将所有join key相同的记录集中起来进行处理，所以reduce join这种方式就出现了。

这种方式的缺点很明显就是会造成map和reduce端也就是shuffle阶段出现大量的数据传输，效率很低。

##### Map join

1）使用场景：一张表十分小、一张表很大。

2）使用方法：

在提交作业的时候先将小表文件放到该作业的DistributedCache中，然后从DistributeCache中取出该小表进行join (比如放到Hash Map等等容器中)。然后扫描大表，看大表中的每条记录的join key/value值是否能够在内存中找到相同join key的记录，如果有则直接输出结果。

##### Distributedcache分布式缓存

1. 数据倾斜原因

	如果是多张表的操作都是在reduce阶段完成，reduce端的处理压力太大，map节点的运算负载则很低，资源利用率不高，且在reduce阶段极易产生数据倾斜。

2. 解决方案

	在map端缓存多张表，提前处理业务逻辑，这样增加map端业务，减少reduce端数据的压力，尽可能的减少数据倾斜。

3. 具体办法：采用distributedcache
	1. 在mapper的setup阶段，将文件读取到缓存集合中
	2. 在驱动函数中加载缓存。
		job.addCacheFile(new URI("file:/e:/mapjoincache/pd.txt"));// 缓存普通文件到task运行节点

#### 数据清洗
在运行核心业务Mapreduce程序之前，往往要先对数据进行清洗，清理掉不符合用户要求的数据。清理的过程往往只需要运行mapper程序，不需要运行reduce程序。

### 最佳实践

#### FAQ

1. 增大MapReduce作业内存，在YARN服务的配置页面，调大mapreduce.map.java.opts或mapreduce.reduce.java.opts的值。

4. 在MR作业中使用本地共享库

```xml
<property>  
    <name>mapred.child.java.opts</name>  
    <value>-Xmx1024m -Djava.library.path=/usr/local/share/</value>  
    </property>  
    <property>  
    <name>mapreduce.admin.user.env</name>  
    <value>LD_LIBRARY_PATH=$HADOOP_COMMON_HOME/lib/native:/usr/local/lib</value>  
</property>
```


