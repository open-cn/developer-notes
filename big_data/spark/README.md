## Spark

Spark 支持四种运行模式：

- 本地单机模式：所有 Spark 进程都运行在同一个Java虚拟机中。
- 集群单机模式：使用 Spark 自己内置的任务调度框架。
- 基于Mesos
- 基于YARN


```
# For Scala and Java, use run-example:
./bin/run-example SparkPi
# For Python examples, use spark-submit directly:
./bin/spark-submit examples/src/main/python/pi.py
```

### 引入 Spark 初始化 SparkContext

Read-Eval-Print-Loop 交互式 shell  
./bin/spark-shell  进入 scala 的 shell  
./bin/pyspark 进入 Python 的 shell  
在 Spark shell 中，有一个专有的 SparkContext 已经为你创建好。在变量中叫做 sc。你自己创建的 SparkContext 将无法工作。可以用 --master 参数来设置 SparkContext 要连接的集群，用 --jars 来设置需要添加到 classpath 中的 JAR 包，如果有多个 JAR 包使用逗号分割符连接它们。
例如：在一个拥有 4 核的环境上运行 bin/spark-shell，使用：
```
./bin/spark-shell --master local[4]  --jars code.jar(执行 spark-shell --help 获取完整的选项列表)
```

```
import org.apache.spark.sql.SparkSession
val spark = SparkSession
      .builder()
      .appName("Broadcast Test")//你程序的名字，它会显示在 cluster UI 上
      .config("spark.broadcast.blockSize", blockSize)
      .getOrCreate()
val sc = spark.sparkContext
spark.stop()
```

并行集合 (Parallelized collections) 的创建是通过在一个已有的集合(Scala Seq)上调用 SparkContext 的 parallelize 方法实现的。
切片数(slices)表示一个数据集切分的份数。Spark 会在集群上为每一个切片运行一个任务。你可以在集群上为每个 CPU 设置 2-4 个切片(slices)。
正常情况下，Spark 会试着基于你的集群状况自动地设置切片的数目。
```
val data = Array(1, 2, 3, 4, 5)
val distData = sc.parallelize(data,slices)
```
textFile 方法也可以选择第二个可选参数来控制切片(slices)的数目。


Resilient Distributed Dataset(RDD)
RDD 是指能横跨集群所有节点进行并行计算的分区元素集合。
弹性分布式集合 是 Spark 最主要的抽象
RDDs 可以使用 Hadoop InputFormats(例如 HDFS 文件)创建，也可以从其他的 RDDs 转换。
scala> val textFile = sc.textFile("README.md")
textFile: spark.RDD[String] = spark.MappedRDD@2ee9b6e3

如果使用本地文件系统路径，文件必须能在 work 节点上用相同的路径访问到。要么复制文件到所有的 workers，要么使用网络的方式共享文件系统。
所有 Spark 的基于文件的方法，包括 textFile，能很好地支持文件目录，压缩过的文件和通配符。
SparkContext.wholeTextFiles 让你读取一个包含多个小文本文件的文件目录并且返回每一个(filename, content)对。与 textFile 的差异是：它记录的是每个文件中的每一行。
对于 SequenceFiles，可以使用 SparkContext 的 sequenceFile[K, V] 方法创建
对于其他的 Hadoop InputFormats，你可以使用 SparkContext.hadoopRDD 方法，它可以指定任意的 JobConf，输入格式(InputFormat)，key 类型，values 类型。
RDD.saveAsObjectFile 和 SparkContext.objectFile 支持保存一个RDD

RDD 操作

RDD 的 actions 从 RDD 中返回值
textFile.count() 
textFile.first()
collect 返回一个list
reduce countByKey  take(n)

transformations 可以转换成一个新 RDD 并返回它的引用
scala> val linesWithSpark = textFile.filter(line => line.contains("Spark"))
linesWithSpark: spark.RDD[String] = spark.FilteredRDD@7dd4af09
map filter flatMap mapPartitions groupByKey reduceByKey sortByKey join pipe

RDD 持久化
Spark 支持把数据集拉到集群内的内存缓存中。
scala> linesWithSpark.cache()//linesWithSpark.persist()


Spark 的第二个抽象是共享变量(shared variables)
1.广播变量(broadcast variables)
scala> val broadcastVar = sc.broadcast(Array(1, 2, 3))
scala> broadcastVar.value
2.累加器(accumulators)，仅仅只能执行“添加(added)”操作，例如：记数器(counters)和求和(sums)。
scala> val accum = sc.accumulator(0, "My Accumulator")
accum: spark.Accumulator[Int] = 0
scala> accum.value









### Spark Streaming
Spark streaming是Spark核心API的一个扩展，它对实时流式数据的处理具有可扩展性、高吞吐量、可容错性等特点。我们可以从kafka、flume、Twitter、 ZeroMQ、Kinesis等源获取数据，也可以通过由高阶函数map、reduce、join、window等组成的复杂算法计算出数据。

初始化 StreamingContext
import org.apache.spark.streaming._
val ssc = new StreamingContext(sc, Seconds(1))
val conf = new SparkConf().setMaster("local[2]").setAppName("NetworkWordCount")
val ssc = new StreamingContext(conf, Seconds(1))

Spark Streaming支持一个高层的抽象，叫做离散流(discretized stream)或者DStream，它代表连续的数据流。在内部，DStream是由一系列RDDs组成。
Spark Streaming拥有两类数据源
1.基本源（Basic sources）：这些源在StreamingContext API中直接可用。例如文件系统、套接字连接、Akka的actor等。
val lines = ssc.socketTextStream("localhost", 9999)
scc.fileStream[keyClass, valueClass, inputFormatClass](dataDirectory)
scc.textFileStream(dataDirectory)//简单的文本文件 文件流不需要运行一个receiver，所以不需要分配核。
scc.actorStream(actorProps, actor-name)//从Akka actors获取的数据流来创建。
scc.queueStream(queueOfRDDs)//基于RDD队列创建DStreams。每个push到队列的RDD都被当做DStream的批数据，像流一样处理。

2.高级源（Advanced sources）：这些源包括Kafka,Flume,Kinesis,Twitter等等。它们需要通过额外的类来使用。
import org.apache.spark.streaming.twitter._
TwitterUtils.createStream(ssc)
这些高级的源在spark-shell中不能被使用

Receiver
每一个输入流DStream和一个Receiver对象相关联，这个Receiver从源中获取数据，并将数据存入内存中用于处理。
如果分配给应用程序的核的数量少于或者等于输入DStreams或者receivers的数量，系统只能够接收数据而不能处理它们。
当运行在本地，如果你的master URL被设置成了“local”，这样就只有一个核运行任务。这对程序来说是不足的，因为作为receiver的输入DStream将会占用这个核，这样就没有剩余的核来处理数据了。

DStream中的转换（transformation）

DStreams上的输出操作
print foreachRDD

和RDD相似，DStreams也允许开发者持久化流数据到内存中。在DStream上使用persist()方法可以自动地持久化DStream中的RDD到内存中。如果DStream中的数据需要计算多次，这是非常有用的。像reduceByWindow和reduceByKeyAndWindow这种窗口操作、updateStateByKey这种基于状态的操作，持久化是默认的，不需要开发者调用persist()方法。
例如通过网络（如kafka，flume等）获取的输入数据流，默认的持久化策略是复制数据到两个不同的节点以容错。
注意，与RDD不同的是，DStreams默认持久化级别是存储序列化数据到内存中

Checkpointing
1. Metadata checkpointing：保存流计算的定义信息到容错存储系统如HDFS中。这用来恢复应用程序中运行worker的节点的故障。元数据包括
    - Configuration ：创建Spark Streaming应用程序的配置信息
    - DStream operations ：定义Streaming应用程序的操作集合
    - Incomplete batches：操作存在队列中的未完成的批
2. Data checkpointing ：保存生成的RDD到可靠的存储系统中，这在有状态transformation（如结合跨多个批次的数据）中是必须的。在这样一个transformation中，生成的RDD依赖于之前批的RDD，随着时间的推移，这个依赖链的长度会持续增长。在恢复的过程中，为了避免这种无限增长。有状态的transformation的中间RDD将会定时地存储到可靠存储系统中，以截断这个依赖链。

```
ssc.start()             // Start the computation
ssc.awaitTermination()  // Wait for the computation to terminate
```

```
ssc.stop()
```

1. 一旦一个context已经启动，就不能有新的流算子建立或者是添加到context中。
2. 一旦一个context已经停止，它就不能再重新启动
3. 在JVM中，同一时间只能有一个StreamingContext处于活跃状态
4. 在StreamingContext上调用stop()方法，也会关闭SparkContext对象。如果只想仅关闭StreamingContext对象，设置stop()的可选参数为false
5. 一个SparkContext对象可以重复利用去创建多个StreamingContext对象，前提条件是前面的StreamingContext在后面StreamingContext创建之前关闭（不关闭SparkContext）。









### Spark SQL
`./bin/spark-sql # 启动交互式shell`
```sql
quit # 退出
exit # 退出
show databases; # 查看已有的database
use databaseName; # 切换数据库
create database myDatabase; # 创建数据库
show tables; # 查看所有表
show tables 'KHDX'; -- 支持模糊查询，表名包含KHDX


-- 建表
create table tab_test(
name string,
age int,
num1 double,
num2 bigint,
msg varchar(80)    -- 最后一个字段后面不能有','号
)
partitioned by (p_age int,p_name string) -- 分区信息
row format delimited fields terminated by ',' -- 数据中，属性间用逗号分隔
stored as textfile location '/tab/test/tab_test';  -- 保存路径，最后也可带'/'，即写成 '/tab/test/tab_test/'

-- stored as orc ;orc类型的表，手动推数据（txt / csv 文件；无需表头，行尾无需','，数据文件保存为unix utf-8 无bom格式）不行;
-- 可以借助textfile类型的临时表插入数据；插入时，要注意字段顺序对应一致。


-- 指定分区，追加插入;最好不要用 'seletc *  ' 表字段变化时,*指代的内容不一样
insert into table tab_test_orc partition(p_age=10,p_name='lucy') select name,age,num1,num2,msg from tab_test_temp;
-- 指定分区，覆盖插入
insert overwrite table tab_test_orc partition(p_age=10,p_name='lucy') select name,age,num1,num2,msg from tab_test_temp;


desc khdx_hy;   -- 显示表khdx_hy的表结构
desc formatted khdx_hy; -- 格式化表khdx_hy的表结构信息，信息更详细，包括在hdfs的存储位置
show partitions khdx_hy; -- 显示表khdx_hy的分区信息
show create table khdx_hy; -- 查看建表语句
 

-- 修改表结构
alter table myDatabase.nbzz_ckmxz add partition(tjrq='20171231')add partition(tjrq='20180101')  -- 手动给分区表增加2个分区
alter table myDatabase.nbzz_ckmxz drop if exists partition (tjrq='20171231');   -- 手动删除分区表某个分区
alter table myDatabase.nbzz_ckmxz add columns (fh string);     -- 追加字段
alter table myDatabase.nbzz_ckmxz change hydh hydh1 string;          -- 修改字段hydh名称为hydh1，类型为string


drop table myDatabase.nbzz_ckmxz;  -- 删除表
alter table myDatabase.tmp_nbzz_ckmxz rename to myDatabase.nbzz_ckmxz;  -- 重命名表

-- 删表中数据：
truncate table tab_test;   -- 执行后，分区依然存在
truncate table tab_test partition(p_age=10,p_name='Tom'); -- 删除某分区 
 

-- 操作表
select * from myDatabase.khdx_hy order by hydh limit 10;    -- 查询表，显示前10条记录。
truncate table khdx_hy;      -- 清空表数据
insert overwrite table myDatabase.tmp_khdx_hy select * from myDatabase.khdx_hy;  -- 用khdx_hy的数据覆盖tmp_khdx_hy数据;
insert into myDatabase.tmp_khdx_hy select * from myDatabase.khdx_hy;   -- 用khdx_hy的数据追加tmp_khdx_hy数据中，不覆盖原来数据。
load data local inpath '/home/myDatabase/data/org_info.txt' overwrite into table myDatabase.org_info ;  -- 从文件中导入数据到表中
load data local inpath '/home/myDatabase/data/t_ma_fct_etl_acct_liyang_20171231.dat' overwrite into table myDatabase.T_MA_FCT_ETL_ACCT partition(tjrq="20171231");
 -- 从文件导入数据至表的某个分区。
insert overwrite local directory '/home/myDatabase/data/khdx_hy.txt'  row format delimited  fields terminated by '\t' select * FROM myDatabase.KHDX_HY;
 -- 从表khdx_hy导出数据至本地文件khdx_hy.txt


-- 增加分区：
alter table tab_test add if not exists partition(p_age=11,p_name="Tom"); -- 更完善写法

alter table tab_test add partition(p_age=10,p_name='Tom'); -- 需要指定所有的分区，不能只是p_age或p_name;否则org.apache.spark.sql.execution.QueryExecutionException：doesn't contain all (2) partition columns 
show partitions tab_test; -- 查看分区

-- 删除分区
alter table tab_test drop if exists partition(p_age=10); 
-- 删除分区时，可以只指定局部 
alter table tab_test drop partition(p_name='Tom'); 
-- 只执行该条语句,p_age=10分区连同一起被删掉，show partitions 结果为空；hdfs dfs -ls 也看不到 p_age=10的分区

alter table tab_test add partition(p_age=10,p_name='cat'); 
-- 只drop p_name='Tome', p_name='cat' 的分区还存在，show partitions 可以查到


-- 动态分区；动态分区匹配最后选出的字段；只与字段顺序有关系，与名字无关；同时存在静态和动态分区，动态分区必须在静态分区之后
insert into table tab_test(p_age,p_name)
select name,
       age,
       num1,
       num2,
       msg,
       age as pppp_age,  -- 取不取别名都可以;分区需要出现在select出来的字段的最后位置，为了匹配。
       name as p_name   -- 写个对应的别名，看上去好理解一点
from tab_test_temp;
```

DataFrame
```
1.1
val peopleRDD = spark.sparkContext.textFile("examples/src/main/resources/people.txt")
val schemaString = "name age"
import org.apache.spark.sql.types._
val fields = schemaString.split(" ")
      .map(fieldName => StructField(fieldName, StringType, nullable = true))
val schema = StructType(fields)
// Convert records of the RDD (people) to Rows
val rowRDD = peopleRDD
    .map(_.split(","))
    .map(attributes => Row(attributes(0), attributes(1).trim))
// Apply the schema to the RDD
val peopleDF = spark.createDataFrame(rowRDD, schema)
1.2
case class Person(name: String, age: Long)
val peopleDF = spark.sparkContext
      .textFile("examples/src/main/resources/people.txt")
      .map(_.split(","))
      .map(attributes => Person(attributes(0), attributes(1).trim.toInt))
      .toDF()
1.3
val peopleDF = spark.read.format("json").load("examples/src/main/resources/people.json")
1.4
val otherPeopleRDD = spark.sparkContext.makeRDD(
      """{"name":"Yin","address":{"city":"Columbus","state":"Ohio"}}""" :: Nil)
val otherPeopleDF = spark.read.json(otherPeopleRDD)
1.5
val df = spark.read.json("examples/src/main/resources/people.json")
//df: org.apache.spark.sql.DataFrame = [age: bigint, name: string]

2.
df.show()
df.printSchema()
df.select("name").show()
df.select($"name", $"age" + 1).show()
df.filter($"age" > 21).show()
df.groupBy("age").count().show()

3.
df.map(teenager => "Name: " + teenager(0)).show()
df.map(teenager => "Name: " + teenager.getAs[String]("name")).show()
import org.apache.spark.sql.Row
sqlDF.map {case Row(key: Int, value: String) => s"Key: $key, Value: $value"}

4.
implicit val mapEncoder = org.apache.spark.sql.Encoders.kryo[Map[String, Any]]
df.map(teenager => teenager.getValuesMap[Any](List("name", "age"))).collect()

5.
df.createOrReplaceTempView("people")
val sqlDF = spark.sql("SELECT * FROM people")
	sqlDF.show()
6.
df.createGlobalTempView("people")
spark.sql("SELECT * FROM global_temp.people").show()
// Global temporary view is cross-session
spark.newSession().sql("SELECT * FROM global_temp.people").show()
```

Dataset
```
1.1
import spark.implicits._
val caseClassDS = Seq(Person("Andy", 32)).toDS()
	caseClassDS.show()
1.2
case class Person(name: String, age: Long)
val peopleDS = spark.read.json("examples/src/main/resources/people.json").as[Person]
    peopleDS.show()
```

Parquet文件
Parquet是一种柱状(columnar)格式，可以被许多其它的数据处理系统支持。Spark SQL提供支持读和写Parquet文件的功能，这些文件可以自动地保留原始数据的模式。

```
1.1
case class Record(key: Int, value: String)
val df = spark.createDataFrame((1 to 100).map(i => Record(i, s"val_$i")))
import org.apache.spark.sql.SaveMode
df.write.mode(SaveMode.Overwrite).parquet("pair.parquet")

1.2
val usersDF = spark.read.load("examples/src/main/resources/users.parquet")
usersDF.select("name", "favorite_color").write.save("namesAndFavColors.parquet")

1.3
val peopleDF = spark.read.format("json").load("examples/src/main/resources/people.json")
peopleDF.select("name", "age").write.format("parquet").save("namesAndAges.parquet")

2.1
val parquetFile = spark.read.parquet("pair.parquet")
//parquetFile: org.apache.spark.sql.DataFrame = [key: int, value: string]

2.2
val usersDF = spark.read.load("examples/src/main/resources/users.parquet")

2.3
val sqlDF = spark.sql("SELECT * FROM parquet.`examples/src/main/resources/users.parquet`")

3.1
val squaresDF = spark.sparkContext.makeRDD(1 to 5).map(i => (i, i * i)).toDF("value", "square")
    squaresDF.write.parquet("data/test_table/key=1")
val cubesDF = spark.sparkContext.makeRDD(6 to 10).map(i => (i, i * i * i)).toDF("value", "cube")
    cubesDF.write.parquet("data/test_table/key=2")
val mergedDF = spark.read.option("mergeSchema", "true").parquet("data/test_table")
```


Hive
```
sql("CREATE TABLE IF NOT EXISTS src (key INT, value STRING)")
sql("LOAD DATA LOCAL INPATH 'examples/src/main/resources/kv1.txt' INTO TABLE src")

sql("SELECT * FROM src").show()
sql("SELECT COUNT(*) FROM src").show()

val recordsDF = spark.createDataFrame((1 to 100).map(i => Record(i, s"val_$i")))
    recordsDF.createOrReplaceTempView("records")
// Queries can then join DataFrame data with data stored in Hive.
sql("SELECT * FROM records r JOIN src s ON r.key = s.key").show()
```


运行Thrift JDBC/ODBC服务器
```
./sbin/start-thriftserver.sh ./sbin/stop-thriftserver.sh 
./bin/beeline
beeline> !connect jdbc:hive2://localhost:10000
0: jdbc:hive2://localhost:10000> select * from src;
0: jdbc:hive2://localhost:10000> !quit
```
JDBC
```
val jdbcDF = spark.read
      .format("jdbc")
      .option("url", "jdbc:postgresql:dbserver")
      .option("dbtable", "schema.tablename")
      .option("user", "username")
      .option("password", "password")
      .load()

 val connectionProperties = new Properties()
    connectionProperties.put("user", "username")
    connectionProperties.put("password", "password")
    val jdbcDF2 = spark.read
      .jdbc("jdbc:postgresql:dbserver", "schema.tablename", connectionProperties)

jdbcDF.write
      .format("jdbc")
      .option("url", "jdbc:postgresql:dbserver")
      .option("dbtable", "schema.tablename")
      .option("user", "username")
      .option("password", "password")
      .save()

jdbcDF2.write
	.jdbc("jdbc:postgresql:dbserver", "schema.tablename", connectionProperties)
```











GraphLoader
```
import org.apache.spark.graphx.{GraphLoader, PartitionStrategy}
val graph = GraphLoader.edgeListFile(sc, "data/graphx/followers.txt", true)
      .partitionBy(PartitionStrategy.RandomVertexCut)
val triCounts = graph.triangleCount().vertices

val users = sc.textFile("data/graphx/users.txt").map { line =>
      val fields = line.split(",")
      (fields(0).toLong, fields(1))
    }

val triCountByUsername = users.join(triCounts).map { case (id, (username, tc)) =>
      (username, tc)
    }
println(triCountByUsername.collect().mkString("\n"))
```





