## Zeppelin


Zeppelin是一个基于Web的notebook，提供交互数据分析和可视化。后台支持接入多种数据处理引擎，如spark，hive等。支持多种语言： Scala(Apache Spark)、Python(Apache Spark)、SparkSQL、 Hive、 Markdown、Shell等。

官方支持的执行引擎用一幅图可以清晰描述执行引擎的作用就是执行笔记中的与引擎相对应的代码，不同的引擎也会有不同的配置，引擎的详细说明参考官方文档：

开发者可以通过实现更多的解释器来为Zeppelin添加数据引擎。


下载地址：http://zeppelin.apache.org/download.html

为了快速使用Zeppelin，可下载官方编译好的可执行版本，该版本包括两种类型，完整Interpreter版本，基础Interpreter版，下载基础版本即可，以后如有需要，可对Interpreter进行单独安装。

 解压tar -zxvf zeppelin-0.6.2-bin-netinst.tgz
 启动进程：zeppelin-0.6.2-bin-netinst/bin# ./zeppelin-daemon.sh start
 访问页面：http://localhost:8080
 停止进程：zeppelin-0.6.2-bin-netinst/bin# ./zeppelin-daemon.sh start



```xml zeppelin-site
zeppelin.interpreter.lifecyclemanager.class org.apache.zeppelin.interpreter.lifecycle.TimeoutLifecycleManager
zeppelin.notebook.dir notebook
zeppelin.interpreter.lifecyclemanager.timeout.threshold 86400000
zeppelin.interpreter.dep.mvnRepo https://maven.aliyun.com/repository/public
zeppelin.helium.registry helium
zeppelin.interpreter.include spark,flink,md,sh,python,jdbc,r
zeppelin.server.port 8080
zeppelin.server.addr 0.0.0.0
zeppelin.interpreter.output.limit 10240000
```

```xml zeppelin-env
hadoop_conf_dir /etc/ecm/hadoop-conf
zeppelin_extra_env #!/bin/bash \ # append extra envs below
spark_home /usr/lib/spark-current
use_hadoop true
```





