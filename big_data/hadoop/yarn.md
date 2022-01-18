## YARN

### 概述
YARN是一个分布式的资源管理系统。YARN是Hadoop系统的核心组件，主要功能包括负责在Hadoop集群中的资源管理，负责对任务进行调度运行以及监控。

EMR集群中的YARN优势如下：

- 高可用集群可以自动开启YARN HA部署。
- 便捷的运维。
  例如，支持通过控制台的方式进行节点扩容，NodeMananger下线和滚动重启等操作。

- 支持监控报警。
  可以对各项指标进行监控和智能报警。

- 弹性伸缩支持优雅下线功能。
  可以在一段时间内等待用户任务执行结束后再下线，而不是直接下线NodeManager导致大量任务重新计算。

#### YARN 组件

YARN组件信息如下：

- ResourceManager(RM)：负责集群的资源管理与调度，为运行在YARN上的各种类型任务分配资源。
  非HA集群部署在EMR的Master节点上，HA集群部署在EMR的多个Master节点上，保证了高可用性。
  ResourceManager 在整个集群中就只有一个,其主要负责和客户端进行通信，为每个节点进行资源的调度以及分配，与 AppMaster 一起进行资源的分配。

- NodeMananger(NM)：负责节点的资源管理、监控和任务运行。
  部署在EMR的Core或Task节点上。
  YARN 中每个节点都存在一个 NodeManager，其主要对容器中的资源进行监控，处理来自 AppMaster 和 ResourceManager 的命令

- ApplicationMaster：负责应用程序相关事务。
  ApplicationMaster 管理在 YARN 中运行的每个应用程序实例。还负责协调来自 ResourceManager 的资源，并通过 NodeManager 监视容器的执行和资源的使用（CPU、内存等的资源分配）。

- Container：Container 是 YARN 中的资源抽象，它包含了很多纬度，如内存、CPU、网络等。
  Resource Manager 为 AppMaster 返回的资源便是用Container 表示的。YARN 会为每个任务分配一个 Container，且该任务只能使用该Container中描述的资源

- YARN Client：负责提交任务。
  部署在EMR的Master、Core和Task节点上。

- JobHistory：解析MapReduce任务的指标，并展示任务执行情况。
- App Timeline Server：收集任务的指标，并展示任务执行情况。
- WebAppProxyServer：负责任务链接跳转，降低基于Web的攻击。

##### ResourceManager 启动流程

ResourceManager STARTUP
```java
2021-08-31 08:22:14,668 INFO org.apache.hadoop.yarn.server.resourcemanager.ResourceManager: STARTUP_MSG:
/************************************************************
STARTUP_MSG: Starting ResourceManager
STARTUP_MSG:   host = LAPTOP-GCQQL01V/127.0.1.1
STARTUP_MSG:   args = []
STARTUP_MSG:   version = 2.10.1
STARTUP_MSG:   classpath = /usr/local/hadoop...
STARTUP_MSG:   build = https://github.com/apache/hadoop -r 1827467c9a56f133025f28557bfc2c562d78e816; compiled by 'centos' on 2020-09-14T13:17Z
STARTUP_MSG:   java = 1.8.0_292
************************************************************/
2021-08-13 16:36:46,965 INFO org.apache.hadoop.yarn.server.resourcemanager.ResourceManager: registered UNIX signal handlers for [TERM, HUP, INT]
2021-08-13 16:36:47,147 INFO org.apache.hadoop.conf.Configuration: found resource core-site.xml at file:/usr/local/hadoop-2.10.1/etc/hadoop/core-site.xml
2021-08-13 16:36:47,159 INFO org.apache.hadoop.security.Groups: clearing userToGroupsMap cache
2021-08-13 16:36:47,193 INFO org.apache.hadoop.conf.Configuration: resource-types.xml not found
2021-08-13 16:36:47,194 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Unable to find 'resource-types.xml'.
2021-08-13 16:36:47,198 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Adding resource type - name = memory-mb, units = Mi, type = COUNTABLE
2021-08-13 16:36:47,198 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Adding resource type - name = vcores, units = , type = COUNTABLE
2021-08-13 16:36:47,217 INFO org.apache.hadoop.conf.Configuration: found resource yarn-site.xml at file:/usr/local/hadoop-2.10.1/etc/hadoop/yarn-site.xml
2021-08-13 16:36:47,228 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.resourcemanager.RMFatalEventType for class org.apache.hadoop.yarn.server.resourcemanager.ResourceManager$RMFatalEventDispatcher
2021-08-13 16:36:47,264 INFO org.apache.hadoop.yarn.server.resourcemanager.security.NMTokenSecretManagerInRM: NMTokenKeyRollingInterval: 86400000ms and NMTokenKeyActivationDelay: 900000ms
2021-08-13 16:36:47,267 INFO org.apache.hadoop.yarn.server.resourcemanager.security.RMContainerTokenSecretManager: ContainerTokenKeyRollingInterval: 86400000ms and ContainerTokenKeyActivationDelay: 900000ms
2021-08-13 16:36:47,271 INFO org.apache.hadoop.yarn.server.resourcemanager.security.AMRMTokenSecretManager: AMRMTokenKeyRollingInterval: 86400000ms and AMRMTokenKeyActivationDelay: 900000 ms
2021-08-13 16:36:47,293 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.resourcemanager.recovery.RMStateStoreEventType for class org.apache.hadoop.yarn.server.resourcemanager.recovery.RMStateStore$ForwardingEventHandler
2021-08-13 16:36:47,297 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.resourcemanager.NodesListManagerEventType for class org.apache.hadoop.yarn.server.resourcemanager.NodesListManager
2021-08-13 16:36:47,297 INFO org.apache.hadoop.yarn.server.resourcemanager.ResourceManager: Using Scheduler: org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler
2021-08-13 16:36:47,317 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.resourcemanager.scheduler.event.SchedulerEventType for class org.apache.hadoop.yarn.event.EventDispatcher
2021-08-13 16:36:47,317 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.resourcemanager.rmapp.RMAppEventType for class org.apache.hadoop.yarn.server.resourcemanager.ResourceManager$ApplicationEventDispatcher
2021-08-13 16:36:47,318 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.resourcemanager.rmapp.attempt.RMAppAttemptEventType for class org.apache.hadoop.yarn.server.resourcemanager.ResourceManager$ApplicationAttemptEventDispatcher
2021-08-13 16:36:47,318 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.resourcemanager.rmnode.RMNodeEventType for class org.apache.hadoop.yarn.server.resourcemanager.ResourceManager$NodeEventDispatcher
2021-08-13 16:36:47,351 INFO org.apache.hadoop.metrics2.impl.MetricsConfig: loaded properties from hadoop-metrics2.properties
2021-08-13 16:36:47,439 INFO org.apache.hadoop.metrics2.impl.MetricsSystemImpl: Scheduled Metric snapshot period at 10 second(s).
2021-08-13 16:36:47,439 INFO org.apache.hadoop.metrics2.impl.MetricsSystemImpl: ResourceManager metrics system started
2021-08-13 16:36:47,450 INFO org.apache.hadoop.yarn.security.YarnAuthorizationProvider: org.apache.hadoop.yarn.security.ConfiguredYarnAuthorizer is instantiated.
2021-08-13 16:36:47,452 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.resourcemanager.RMAppManagerEventType for class org.apache.hadoop.yarn.server.resourcemanager.RMAppManager
2021-08-13 16:36:47,458 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.resourcemanager.amlauncher.AMLauncherEventType for class org.apache.hadoop.yarn.server.resourcemanager.amlauncher.ApplicationMasterLauncher
2021-08-13 16:36:47,459 INFO org.apache.hadoop.yarn.server.resourcemanager.RMNMInfo: Registered RMNMInfo MBean
2021-08-13 16:36:47,459 INFO org.apache.hadoop.yarn.server.resourcemanager.rmapp.monitor.RMAppLifetimeMonitor: Application lifelime monitor interval set to 3000 ms.
2021-08-13 16:36:47,463 INFO org.apache.hadoop.util.HostsFileReader: Refreshing hosts (include/exclude) list
2021-08-13 16:36:47,467 INFO org.apache.hadoop.conf.Configuration: found resource capacity-scheduler.xml at file:/usr/local/hadoop-2.10.1/etc/hadoop/capacity-scheduler.xml
2021-08-13 16:36:47,475 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.AbstractYarnScheduler: Minimum allocation = <memory:1024, vCores:1>
2021-08-13 16:36:47,476 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.AbstractYarnScheduler: Maximum allocation = <memory:8192, vCores:4>
2021-08-13 16:36:47,507 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Adding resource type - name = memory-mb, units = Mi, type = COUNTABLE
2021-08-13 16:36:47,507 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Adding resource type - name = vcores, units = , type = COUNTABLE
2021-08-13 16:36:47,507 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacitySchedulerConfiguration: max alloc mb per queue for root is undefined
2021-08-13 16:36:47,507 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacitySchedulerConfiguration: max alloc vcore per queue for root is undefined
2021-08-13 16:36:47,518 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: root, capacity=1.0, absoluteCapacity=1.0, maxCapacity=1.0, absoluteMaxCapacity=1.0, state=RUNNING, acls=SUBMIT_APP:*ADMINISTER_QUEUE:*, labels=*,
, reservationsContinueLooking=true, orderingPolicy=utilization, priority=0
2021-08-13 16:36:47,518 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.ParentQueue: Initialized parent-queue root name=root, fullname=root
2021-08-13 16:36:47,531 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Adding resource type - name = memory-mb, units = Mi, type = COUNTABLE
2021-08-13 16:36:47,531 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Adding resource type - name = vcores, units = , type = COUNTABLE
2021-08-13 16:36:47,531 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacitySchedulerConfiguration: max alloc mb per queue for root.default is undefined
2021-08-13 16:36:47,531 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacitySchedulerConfiguration: max alloc vcore per queue for root.default is undefined
2021-08-13 16:36:47,534 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.LeafQueue: Initializing default
capacity = 1.0 [= (float) configuredCapacity / 100 ]
absoluteCapacity = 1.0 [= parentAbsoluteCapacity * capacity ]
maxCapacity = 1.0 [= configuredMaxCapacity ]
absoluteMaxCapacity = 1.0 [= 1.0 maximumCapacity undefined, (parentAbsoluteMaxCapacity * maximumCapacity) / 100 otherwise ]
userLimit = 100 [= configuredUserLimit ]
userLimitFactor = 1.0 [= configuredUserLimitFactor ]
maxApplications = 10000 [= configuredMaximumSystemApplicationsPerQueue or (int)(configuredMaximumSystemApplications * absoluteCapacity)]
maxApplicationsPerUser = 10000 [= (int)(maxApplications * (userLimit / 100.0f) * userLimitFactor) ]
usedCapacity = 0.0 [= usedResourcesMemory / (clusterResourceMemory * absoluteCapacity)]
absoluteUsedCapacity = 0.0 [= usedResourcesMemory / clusterResourceMemory]
maxAMResourcePerQueuePercent = 0.1 [= configuredMaximumAMResourcePercent ]
minimumAllocationFactor = 0.875 [= (float)(maximumAllocationMemory - minimumAllocationMemory) / maximumAllocationMemory ]
maximumAllocation = <memory:8192, vCores:4> [= configuredMaxAllocation ]
numContainers = 0 [= currentNumContainers ]
state = RUNNING [= configuredState ]
acls = SUBMIT_APP:*ADMINISTER_QUEUE:* [= configuredAcls ]
nodeLocalityDelay = 40
rackLocalityAdditionalDelay = -1
labels=*,
reservationsContinueLooking = true
preemptionDisabled = true
defaultAppPriorityPerQueue = 0
priority = 0
maxLifetime = -1 seconds
defaultLifetime = -1 seconds
2021-08-13 16:36:47,535 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacitySchedulerQueueManager: Initialized queue: default: capacity=1.0, absoluteCapacity=1.0, usedResources=<memory:0, vCores:0>, usedCapacity=0.0, absoluteUsedCapacity=0.0, numApps=0, numContainers=0
2021-08-13 16:36:47,535 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacitySchedulerQueueManager: Initialized queue: root: numChildQueue= 1, capacity=1.0, absoluteCapacity=1.0, usedResources=<memory:0, vCores:0>usedCapacity=0.0, numApps=0, numContainers=0
2021-08-13 16:36:47,536 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacitySchedulerQueueManager: Initialized root queue root: numChildQueue= 1, capacity=1.0, absoluteCapacity=1.0, usedResources=<memory:0, vCores:0>usedCapacity=0.0, numApps=0, numContainers=0
2021-08-13 16:36:47,537 INFO org.apache.hadoop.yarn.server.resourcemanager.placement.UserGroupMappingPlacementRule: Initialized queue mappings, override: false
2021-08-13 16:36:47,537 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.WorkflowPriorityMappingsManager: Initialized workflow priority mappings, override: false
2021-08-13 16:36:47,537 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler: Initialized CapacityScheduler with calculator=class org.apache.hadoop.yarn.util.resource.DefaultResourceCalculator, minimumAllocation=<<memory:1024, vCores:1>>, maximumAllocation=<<memory:8192, vCores:4>>, asynchronousScheduling=false, asyncScheduleInterval=5ms
2021-08-13 16:36:47,539 INFO org.apache.hadoop.conf.Configuration: dynamic-resources.xml not found
2021-08-13 16:36:47,541 INFO org.apache.hadoop.yarn.server.resourcemanager.AMSProcessingChain: Initializing AMS Processing chain. Root Processor=[org.apache.hadoop.yarn.server.resourcemanager.DefaultAMSProcessor].
2021-08-13 16:36:47,545 INFO org.apache.hadoop.yarn.server.resourcemanager.ResourceManager: TimelineServicePublisher is not configured
2021-08-13 16:36:47,592 INFO org.mortbay.log: Logging to org.slf4j.impl.Log4jLoggerAdapter(org.mortbay.log) via org.mortbay.log.Slf4jLog
2021-08-13 16:36:47,597 INFO org.apache.hadoop.security.authentication.server.AuthenticationFilter: Unable to initialize FileSignerSecretProvider, falling back to use random secrets.
2021-08-13 16:36:47,602 INFO org.apache.hadoop.http.HttpRequestLog: Http request log for http.requests.resourcemanager is not defined
2021-08-13 16:36:47,607 INFO org.apache.hadoop.http.HttpServer2: Added global filter 'safety' (class=org.apache.hadoop.http.HttpServer2$QuotingInputFilter)
2021-08-13 16:36:47,609 INFO org.apache.hadoop.http.HttpServer2: Added filter RMAuthenticationFilter (class=org.apache.hadoop.yarn.server.security.http.RMAuthenticationFilter) to context cluster
2021-08-13 16:36:47,610 INFO org.apache.hadoop.http.HttpServer2: Added filter RMAuthenticationFilter (class=org.apache.hadoop.yarn.server.security.http.RMAuthenticationFilter) to context static
2021-08-13 16:36:47,610 INFO org.apache.hadoop.http.HttpServer2: Added filter RMAuthenticationFilter (class=org.apache.hadoop.yarn.server.security.http.RMAuthenticationFilter) to context logs
2021-08-13 16:36:47,610 INFO org.apache.hadoop.http.HttpServer2: Added filter static_user_filter (class=org.apache.hadoop.http.lib.StaticUserWebFilter$StaticUserFilter) to context cluster
2021-08-13 16:36:47,610 INFO org.apache.hadoop.http.HttpServer2: Added filter static_user_filter (class=org.apache.hadoop.http.lib.StaticUserWebFilter$StaticUserFilter) to context static
2021-08-13 16:36:47,610 INFO org.apache.hadoop.http.HttpServer2: Added filter static_user_filter (class=org.apache.hadoop.http.lib.StaticUserWebFilter$StaticUserFilter) to context logs
2021-08-13 16:36:47,613 INFO org.apache.hadoop.http.HttpServer2: adding path spec: /cluster/\*
2021-08-13 16:36:47,613 INFO org.apache.hadoop.http.HttpServer2: adding path spec: /ws/\*
2021-08-13 16:36:47,868 INFO org.apache.hadoop.yarn.webapp.WebApps: Registered webapp guice modules
2021-08-13 16:36:47,880 INFO org.apache.hadoop.http.HttpServer2: Jetty bound to port 8088
2021-08-13 16:36:47,880 INFO org.mortbay.log: jetty-6.1.26
2021-08-13 16:36:47,983 INFO org.mortbay.log: Extract jar:file:/usr/local/hadoop-2.10.1/share/hadoop/yarn/hadoop-yarn-common-2.10.1.jar!/webapps/cluster to /tmp/Jetty_0_0_0_0_8088_cluster____u0rgz3/webapp
2021-08-13 16:36:48,093 INFO org.apache.hadoop.security.token.delegation.AbstractDelegationTokenSecretManager: Updating the current master key for generating delegation tokens
2021-08-13 16:36:48,094 INFO org.apache.hadoop.security.token.delegation.AbstractDelegationTokenSecretManager: Starting expired delegation token remover thread, tokenRemoverScanInterval=60 min(s)
2021-08-13 16:36:48,094 INFO org.apache.hadoop.security.token.delegation.AbstractDelegationTokenSecretManager: Updating the current master key for generating delegation tokens
2021-08-13 16:36:48,705 INFO org.mortbay.log: Started HttpServer2$SelectChannelConnectorWithSafeStartup@0.0.0.0:8088
2021-08-13 16:36:48,705 INFO org.apache.hadoop.yarn.webapp.WebApps: Web app cluster started at 8088
2021-08-13 16:36:48,741 INFO org.apache.hadoop.ipc.CallQueueManager: Using callQueue: class java.util.concurrent.LinkedBlockingQueue queueCapacity: 100 scheduler: class org.apache.hadoop.ipc.DefaultRpcScheduler
2021-08-13 16:36:48,749 INFO org.apache.hadoop.ipc.Server: Starting Socket Reader #1 for port 8033
2021-08-13 16:36:48,861 INFO org.apache.hadoop.yarn.factories.impl.pb.RpcServerFactoryPBImpl: Adding protocol org.apache.hadoop.yarn.server.api.ResourceManagerAdministrationProtocolPB to the server
2021-08-13 16:36:48,862 INFO org.apache.hadoop.ipc.Server: IPC Server Responder: starting
2021-08-13 16:36:48,862 INFO org.apache.hadoop.ipc.Server: IPC Server listener on 8033: starting
2021-08-13 16:36:48,862 INFO org.apache.hadoop.yarn.server.resourcemanager.ResourceManager: Transitioning to active state
2021-08-13 16:36:48,873 INFO org.apache.hadoop.yarn.server.resourcemanager.recovery.RMStateStore: Updating AMRMToken
2021-08-13 16:36:48,873 INFO org.apache.hadoop.yarn.server.resourcemanager.security.RMContainerTokenSecretManager: Rolling master-key for container-tokens
2021-08-13 16:36:48,873 INFO org.apache.hadoop.yarn.server.resourcemanager.security.NMTokenSecretManagerInRM: Rolling master-key for nm-tokens
2021-08-13 16:36:48,873 INFO org.apache.hadoop.security.token.delegation.AbstractDelegationTokenSecretManager: Updating the current master key for generating delegation tokens
2021-08-13 16:36:48,873 INFO org.apache.hadoop.yarn.server.resourcemanager.security.RMDelegationTokenSecretManager: storing master key with keyID 1
2021-08-13 16:36:48,873 INFO org.apache.hadoop.yarn.server.resourcemanager.recovery.RMStateStore: Storing RMDTMasterKey.
2021-08-13 16:36:48,874 INFO org.apache.hadoop.security.token.delegation.AbstractDelegationTokenSecretManager: Starting expired delegation token remover thread, tokenRemoverScanInterval=60 min(s)
2021-08-13 16:36:48,874 INFO org.apache.hadoop.security.token.delegation.AbstractDelegationTokenSecretManager: Updating the current master key for generating delegation tokens
2021-08-13 16:36:48,873 INFO org.apache.hadoop.yarn.server.resourcemanager.security.RMDelegationTokenSecretManager: storing master key with keyID 1
2021-08-13 16:36:48,873 INFO org.apache.hadoop.yarn.server.resourcemanager.recovery.RMStateStore: Storing RMDTMasterKey.
2021-08-13 16:36:48,874 INFO org.apache.hadoop.security.token.delegation.AbstractDelegationTokenSecretManager: Starting expired delegation token remover thread, tokenRemoverScanInterval=60 min(s)
2021-08-13 16:36:48,874 INFO org.apache.hadoop.security.token.delegation.AbstractDelegationTokenSecretManager: Updating the current master key for generating delegation tokens
2021-08-13 16:36:48,874 INFO org.apache.hadoop.yarn.server.resourcemanager.security.RMDelegationTokenSecretManager: storing master key with keyID 2
2021-08-13 16:36:48,874 INFO org.apache.hadoop.yarn.server.resourcemanager.recovery.RMStateStore: Storing RMDTMasterKey.
2021-08-13 16:36:48,876 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.nodelabels.event.NodeLabelsStoreEventType for class org.apache.hadoop.yarn.nodelabels.CommonNodeLabelsManager$ForwardingEventHandler
2021-08-13 16:36:48,884 INFO org.apache.hadoop.ipc.CallQueueManager: Using callQueue: class java.util.concurrent.LinkedBlockingQueue queueCapacity: 5000 scheduler: class org.apache.hadoop.ipc.DefaultRpcScheduler
2021-08-13 16:36:48,885 INFO org.apache.hadoop.ipc.Server: Starting Socket Reader #1 for port 8031
2021-08-13 16:36:48,888 INFO org.apache.hadoop.yarn.factories.impl.pb.RpcServerFactoryPBImpl: Adding protocol org.apache.hadoop.yarn.server.api.ResourceTrackerPB to the server
2021-08-13 16:36:48,888 INFO org.apache.hadoop.ipc.Server: IPC Server Responder: starting
2021-08-13 16:36:48,888 INFO org.apache.hadoop.ipc.Server: IPC Server listener on 8031: starting
2021-08-13 16:36:48,914 INFO org.apache.hadoop.util.JvmPauseMonitor: Starting JVM pause monitor
2021-08-13 16:36:48,921 INFO org.apache.hadoop.ipc.CallQueueManager: Using callQueue: class java.util.concurrent.LinkedBlockingQueue queueCapacity: 5000 scheduler: class org.apache.hadoop.ipc.DefaultRpcScheduler
2021-08-13 16:36:48,925 INFO org.apache.hadoop.ipc.Server: Starting Socket Reader #1 for port 8030
2021-08-13 16:36:48,934 INFO org.apache.hadoop.yarn.factories.impl.pb.RpcServerFactoryPBImpl: Adding protocol org.apache.hadoop.yarn.api.ApplicationMasterProtocolPB to the server
2021-08-13 16:36:48,935 INFO org.apache.hadoop.ipc.Server: IPC Server Responder: starting
2021-08-13 16:36:48,935 INFO org.apache.hadoop.ipc.Server: IPC Server listener on 8030: starting
2021-08-13 16:36:48,984 INFO org.apache.hadoop.ipc.CallQueueManager: Using callQueue: class java.util.concurrent.LinkedBlockingQueue queueCapacity: 5000 scheduler: class org.apache.hadoop.ipc.DefaultRpcScheduler
2021-08-13 16:36:48,985 INFO org.apache.hadoop.ipc.Server: Starting Socket Reader #1 for port 8032
2021-08-13 16:36:48,987 INFO org.apache.hadoop.yarn.factories.impl.pb.RpcServerFactoryPBImpl: Adding protocol org.apache.hadoop.yarn.api.ApplicationClientProtocolPB to the server
2021-08-13 16:36:48,988 INFO org.apache.hadoop.ipc.Server: IPC Server Responder: starting
2021-08-13 16:36:48,988 INFO org.apache.hadoop.ipc.Server: IPC Server listener on 8032: starting
2021-08-13 16:36:48,998 INFO org.apache.hadoop.yarn.server.resourcemanager.ResourceManager: Transitioned to active state

// scheduler
2021-11-23 10:16:04,371 INFO org.apache.hadoop.yarn.server.resourcemanager.scheduler.AbstractYarnScheduler: Release request cache is cleaned up

// pause
2021-11-23 11:31:54,002 INFO org.apache.hadoop.util.JvmPauseMonitor: Detected pause in JVM or host machine (eg GC): pause of approximately 1975ms
No GCs detected
```

##### ResourceManager 关闭流程

ResourceManager SHUTDOWN
```java
2021-08-13 16:37:31,955 ERROR org.apache.hadoop.yarn.server.resourcemanager.ResourceManager: RECEIVED SIGNAL 15: SIGTERM
2021-08-13 16:37:31,958 ERROR org.apache.hadoop.security.token.delegation.AbstractDelegationTokenSecretManager: ExpiredTokenRemover received java.lang.InterruptedException: sleep interrupted
2021-08-13 16:37:31,959 INFO org.mortbay.log: Stopped HttpServer2$SelectChannelConnectorWithSafeStartup@0.0.0.0:8088
2021-08-13 16:37:32,060 INFO org.apache.hadoop.ipc.Server: Stopping server on 8032
2021-08-13 16:37:32,063 INFO org.apache.hadoop.ipc.Server: Stopping IPC Server listener on 8032
2021-08-13 16:37:32,063 INFO org.apache.hadoop.ipc.Server: Stopping IPC Server Responder
2021-08-13 16:37:32,064 INFO org.apache.hadoop.ipc.Server: Stopping server on 8033
2021-08-13 16:37:32,066 INFO org.apache.hadoop.ipc.Server: Stopping IPC Server listener on 8033
2021-08-13 16:37:32,068 INFO org.apache.hadoop.ipc.Server: Stopping IPC Server Responder
2021-08-13 16:37:32,069 INFO org.apache.hadoop.yarn.server.resourcemanager.ResourceManager: Transitioning to standby state
2021-08-13 16:37:32,069 WARN org.apache.hadoop.yarn.server.resourcemanager.amlauncher.ApplicationMasterLauncher: org.apache.hadoop.yarn.server.resourcemanager.amlauncher.ApplicationMasterLauncher$LauncherThread interrupted. Returning.
2021-08-13 16:37:32,069 INFO org.apache.hadoop.ipc.Server: Stopping server on 8030
2021-08-13 16:37:32,071 INFO org.apache.hadoop.ipc.Server: Stopping IPC Server listener on 8030
2021-08-13 16:37:32,072 INFO org.apache.hadoop.ipc.Server: Stopping IPC Server Responder
2021-08-13 16:37:32,072 INFO org.apache.hadoop.ipc.Server: Stopping server on 8031
2021-08-13 16:37:32,077 INFO org.apache.hadoop.ipc.Server: Stopping IPC Server listener on 8031
2021-08-13 16:37:32,078 INFO org.apache.hadoop.ipc.Server: Stopping IPC Server Responder
2021-08-13 16:37:32,078 INFO org.apache.hadoop.yarn.util.AbstractLivelinessMonitor: NMLivelinessMonitor thread interrupted
2021-08-13 16:37:32,078 ERROR org.apache.hadoop.yarn.event.EventDispatcher: Returning, interrupted : java.lang.InterruptedException
2021-08-13 16:37:32,082 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: AsyncDispatcher is draining to stop, ignoring any new events.
2021-08-13 16:37:32,082 INFO org.apache.hadoop.yarn.util.AbstractLivelinessMonitor: org.apache.hadoop.yarn.server.resourcemanager.rmapp.monitor.RMAppLifetimeMonitor thread interrupted
2021-08-13 16:37:32,082 INFO org.apache.hadoop.yarn.util.AbstractLivelinessMonitor: AMLivelinessMonitor thread interrupted
2021-08-13 16:37:32,083 ERROR org.apache.hadoop.security.token.delegation.AbstractDelegationTokenSecretManager: ExpiredTokenRemover received java.lang.InterruptedException: sleep interrupted
2021-08-13 16:37:32,083 INFO org.apache.hadoop.yarn.util.AbstractLivelinessMonitor: AMLivelinessMonitor thread interrupted
2021-08-13 16:37:32,082 INFO org.apache.hadoop.yarn.util.AbstractLivelinessMonitor: org.apache.hadoop.yarn.server.resourcemanager.rmcontainer.ContainerAllocationExpirer thread interrupted
2021-08-13 16:37:32,083 INFO org.apache.hadoop.metrics2.impl.MetricsSystemImpl: Stopping ResourceManager metrics system...
2021-08-13 16:37:32,085 INFO org.apache.hadoop.metrics2.impl.MetricsSystemImpl: ResourceManager metrics system stopped.
2021-08-13 16:37:32,085 INFO org.apache.hadoop.metrics2.impl.MetricsSystemImpl: ResourceManager metrics system shutdown complete.
2021-08-13 16:37:32,085 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: AsyncDispatcher is draining to stop, ignoring any new events.
2021-08-13 16:37:32,089 INFO org.apache.hadoop.yarn.server.resourcemanager.ResourceManager: Transitioned to standby state
2021-08-13 16:37:32,090 INFO org.apache.hadoop.yarn.server.resourcemanager.ResourceManager: SHUTDOWN_MSG:
/************************************************************
SHUTDOWN_MSG: Shutting down ResourceManager at LAPTOP-GCQQL01V/127.0.1.1
************************************************************/
```

##### NodeManager 启动流程

NodeManager STARTUP
```java
2021-10-22 16:38:09,140 INFO org.apache.hadoop.yarn.server.nodemanager.NodeManager: STARTUP_MSG:
/************************************************************
STARTUP_MSG: Starting NodeManager
STARTUP_MSG:   host = LAPTOP-GCQQL01V/127.0.1.1
STARTUP_MSG:   args = []
STARTUP_MSG:   version = 2.10.1
STARTUP_MSG:   classpath = /usr/local/hadoop...
STARTUP_MSG:   build = https://github.com/apache/hadoop -r 1827467c9a56f133025f28557bfc2c562d78e816; compiled by 'centos' on 2020-09-14T13:17Z
STARTUP_MSG:   java = 1.8.0_292
************************************************************/
2021-10-22 16:38:09,149 INFO org.apache.hadoop.yarn.server.nodemanager.NodeManager: registered UNIX signal handlers for [TERM, HUP, INT]
2021-10-22 16:38:09,605 INFO org.apache.hadoop.yarn.server.nodemanager.NodeManager: Node Manager health check script is not available or doesn't have execute permission, so not starting the node health script runner.
2021-10-22 16:38:09,659 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerEventType for class org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl$ContainerEventDispatcher
2021-10-22 16:38:09,660 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationEventType for class org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl$ApplicationEventDispatcher
2021-10-22 16:38:09,661 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.event.LocalizationEventType for class org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl$LocalizationEventHandlerWrapper
2021-10-22 16:38:09,661 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServicesEventType for class org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices
2021-10-22 16:38:09,661 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorEventType for class org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl
2021-10-22 16:38:09,662 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainersLauncherEventType for class org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainersLauncher
2021-10-22 16:38:09,662 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.nodemanager.containermanager.scheduler.ContainerSchedulerEventType for class org.apache.hadoop.yarn.server.nodemanager.containermanager.scheduler.ContainerScheduler
2021-10-22 16:38:09,681 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.nodemanager.ContainerManagerEventType for class org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl
2021-10-22 16:38:09,681 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.nodemanager.NodeManagerEventType for class org.apache.hadoop.yarn.server.nodemanager.NodeManager
2021-10-22 16:38:09,708 INFO org.apache.hadoop.metrics2.impl.MetricsConfig: loaded properties from hadoop-metrics2.properties
2021-10-22 16:38:09,792 INFO org.apache.hadoop.metrics2.impl.MetricsSystemImpl: Scheduled Metric snapshot period at 10 second(s).
2021-10-22 16:38:09,792 INFO org.apache.hadoop.metrics2.impl.MetricsSystemImpl: NodeManager metrics system started
2021-10-22 16:38:09,814 INFO org.apache.hadoop.yarn.server.nodemanager.DirectoryCollection: Disk Validator: yarn.nodemanager.disk-validator is loaded.
2021-10-22 16:38:09,827 INFO org.apache.hadoop.yarn.server.nodemanager.DirectoryCollection: Disk Validator: yarn.nodemanager.disk-validator is loaded.
2021-10-22 16:38:09,868 INFO org.apache.hadoop.yarn.server.nodemanager.NodeResourceMonitorImpl:  Using ResourceCalculatorPlugin : org.apache.hadoop.yarn.util.ResourceCalculatorPlugin@6c4906d3
2021-10-22 16:38:09,870 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.nodemanager.containermanager.loghandler.event.LogHandlerEventType for class org.apache.hadoop.yarn.server.nodemanager.containermanager.loghandler.NonAggregatingLogHandler
2021-10-22 16:38:09,873 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.sharedcache.SharedCacheUploadEventType for class org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.sharedcache.SharedCacheUploadService
2021-10-22 16:38:09,873 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: AMRMProxyService is disabled
2021-10-22 16:38:09,873 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.ResourceLocalizationService: per directory file limit = 8192
2021-10-22 16:38:09,903 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.ResourceLocalizationService: Disk Validator: yarn.nodemanager.disk-validator is loaded.
2021-10-22 16:38:09,909 INFO org.apache.hadoop.yarn.event.AsyncDispatcher: Registering class org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.event.LocalizerEventType for class org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.ResourceLocalizationService$LocalizerTracker
2021-10-22 16:38:09,948 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Adding auxiliary service mapreduce_shuffle, "mapreduce_shuffle"
2021-10-22 16:38:09,984 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl:  Using ResourceCalculatorPlugin : org.apache.hadoop.yarn.util.ResourceCalculatorPlugin@2ad48653
2021-10-22 16:38:09,984 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl:  Using ResourceCalculatorProcessTree : null
2021-10-22 16:38:09,986 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Physical memory check enabled: true
2021-10-22 16:38:09,986 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Virtual memory check enabled: true
2021-10-22 16:38:09,986 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: ContainersMonitor enabled: true
2021-10-22 16:38:09,991 WARN org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: NodeManager configured with 8 G physical memory allocated to containers, which is more than 80% of the total physical memory available (5.8 G). Thrashing might happen.
2021-10-22 16:38:09,991 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Not a recoverable state store. Nothing to recover.
2021-10-22 16:38:10,012 INFO org.apache.hadoop.conf.Configuration: resource-types.xml not found
2021-10-22 16:38:10,012 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Unable to find 'resource-types.xml'.
2021-10-22 16:38:10,017 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Adding resource type - name = memory-mb, units = Mi, type = COUNTABLE
2021-10-22 16:38:10,017 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Adding resource type - name = vcores, units = , type = COUNTABLE
2021-10-22 16:38:10,018 INFO org.apache.hadoop.conf.Configuration: node-resources.xml not found
2021-10-22 16:38:10,018 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Unable to find 'node-resources.xml'.
2021-10-22 16:38:10,019 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Adding resource type - name = memory-mb, units = Mi, type = COUNTABLE
2021-10-22 16:38:10,019 INFO org.apache.hadoop.yarn.util.resource.ResourceUtils: Adding resource type - name = vcores, units = , type = COUNTABLE
2021-10-22 16:38:10,020 INFO org.apache.hadoop.yarn.server.nodemanager.NodeStatusUpdaterImpl: Nodemanager resources is set to: <memory:8192, vCores:8>
2021-10-22 16:38:10,025 INFO org.apache.hadoop.yarn.server.nodemanager.NodeStatusUpdaterImpl: Initialized nodemanager with : physical-memory=8192 virtual-memory=17204 virtual-cores=8
2021-10-22 16:38:10,069 INFO org.apache.hadoop.ipc.CallQueueManager: Using callQueue: class java.util.concurrent.LinkedBlockingQueue queueCapacity: 2000 scheduler: class org.apache.hadoop.ipc.DefaultRpcScheduler
2021-10-22 16:38:10,084 INFO org.apache.hadoop.ipc.Server: Starting Socket Reader #1 for port 0
2021-10-22 16:38:10,232 INFO org.apache.hadoop.yarn.factories.impl.pb.RpcServerFactoryPBImpl: Adding protocol org.apache.hadoop.yarn.api.ContainerManagementProtocolPB to the server
2021-10-22 16:38:10,233 INFO org.apache.hadoop.ipc.Server: IPC Server Responder: starting
2021-10-22 16:38:10,233 INFO org.apache.hadoop.ipc.Server: IPC Server listener on 0: starting
2021-10-22 16:38:10,254 INFO org.apache.hadoop.yarn.server.nodemanager.security.NMContainerTokenSecretManager: Updating node address : LAPTOP-GCQQL01V.localdomain:40585
2021-10-22 16:38:10,261 INFO org.apache.hadoop.ipc.CallQueueManager: Using callQueue: class java.util.concurrent.LinkedBlockingQueue queueCapacity: 500 scheduler: class org.apache.hadoop.ipc.DefaultRpcScheduler
2021-10-22 16:38:10,261 INFO org.apache.hadoop.ipc.Server: Starting Socket Reader #1 for port 8040
2021-10-22 16:38:10,268 INFO org.apache.hadoop.yarn.factories.impl.pb.RpcServerFactoryPBImpl: Adding protocol org.apache.hadoop.yarn.server.nodemanager.api.LocalizationProtocolPB to the server
2021-10-22 16:38:10,268 INFO org.apache.hadoop.ipc.Server: IPC Server Responder: starting
2021-10-22 16:38:10,268 INFO org.apache.hadoop.ipc.Server: IPC Server listener on 8040: starting
2021-10-22 16:38:10,269 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.ResourceLocalizationService: Localizer started on port 8040
2021-10-22 16:38:10,299 INFO org.apache.hadoop.mapred.IndexCache: IndexCache created with max memory = 10485760
2021-10-22 16:38:10,309 INFO org.apache.hadoop.mapred.ShuffleHandler: mapreduce_shuffle listening on port 13562
2021-10-22 16:38:10,311 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: ContainerManager started at LAPTOP-GCQQL01V/127.0.1.1:40585
2021-10-22 16:38:10,311 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: ContainerManager bound to 0.0.0.0/0.0.0.0:0
2021-10-22 16:38:10,314 INFO org.apache.hadoop.yarn.server.nodemanager.webapp.WebServer: Instantiating NMWebApp at 0.0.0.0:8042
2021-10-22 16:38:10,359 INFO org.mortbay.log: Logging to org.slf4j.impl.Log4jLoggerAdapter(org.mortbay.log) via org.mortbay.log.Slf4jLog
2021-10-22 16:38:10,365 INFO org.apache.hadoop.security.authentication.server.AuthenticationFilter: Unable to initialize FileSignerSecretProvider, falling back to use random secrets.
2021-10-22 16:38:10,369 WARN org.apache.hadoop.http.HttpRequestLog: Jetty request log can only be enabled using Log4j
2021-10-22 16:38:10,375 INFO org.apache.hadoop.http.HttpServer2: Added global filter 'safety' (class=org.apache.hadoop.http.HttpServer2$QuotingInputFilter)
2021-10-22 16:38:10,377 INFO org.apache.hadoop.http.HttpServer2: Added filter static_user_filter (class=org.apache.hadoop.http.lib.StaticUserWebFilter$StaticUserFilter) to context node
2021-10-22 16:38:10,377 INFO org.apache.hadoop.http.HttpServer2: Added filter static_user_filter (class=org.apache.hadoop.http.lib.StaticUserWebFilter$StaticUserFilter) to context logs
2021-10-22 16:38:10,377 INFO org.apache.hadoop.http.HttpServer2: Added filter static_user_filter (class=org.apache.hadoop.http.lib.StaticUserWebFilter$StaticUserFilter) to context static
2021-10-22 16:38:10,378 INFO org.apache.hadoop.http.HttpServer2: Added filter authentication (class=org.apache.hadoop.security.authentication.server.AuthenticationFilter) to context node
2021-10-22 16:38:10,378 INFO org.apache.hadoop.http.HttpServer2: Added filter authentication (class=org.apache.hadoop.security.authentication.server.AuthenticationFilter) to context logs
2021-10-22 16:38:10,378 INFO org.apache.hadoop.http.HttpServer2: Added filter authentication (class=org.apache.hadoop.security.authentication.server.AuthenticationFilter) to context static
2021-10-22 16:38:10,383 INFO org.apache.hadoop.http.HttpServer2: adding path spec: /node/\*
2021-10-22 16:38:10,383 INFO org.apache.hadoop.http.HttpServer2: adding path spec: /ws/\*
2021-10-22 16:38:10,694 INFO org.apache.hadoop.yarn.webapp.WebApps: Registered webapp guice modules
2021-10-22 16:38:10,696 INFO org.apache.hadoop.http.HttpServer2: Jetty bound to port 8042
2021-10-22 16:38:10,696 INFO org.mortbay.log: jetty-6.1.26
2021-10-22 16:38:10,759 INFO org.mortbay.log: Extract jar:file:/usr/local/hadoop-2.10.1/share/hadoop/yarn/hadoop-yarn-common-2.10.1.jar!/webapps/node to /tmp/Jetty_0_0_0_0_8042_node____19tj0x/webapp
2021-10-22 16:38:11,796 INFO org.mortbay.log: Started HttpServer2$SelectChannelConnectorWithSafeStartup@0.0.0.0:8042
2021-10-22 16:38:11,796 INFO org.apache.hadoop.yarn.webapp.WebApps: Web app node started at 8042
2021-10-22 16:38:11,798 INFO org.apache.hadoop.yarn.server.nodemanager.NodeStatusUpdaterImpl: Node ID assigned is : LAPTOP-GCQQL01V.localdomain:40585
2021-10-22 16:38:11,800 INFO org.apache.hadoop.util.JvmPauseMonitor: Starting JVM pause monitor
2021-10-22 16:38:11,813 INFO org.apache.hadoop.yarn.client.RMProxy: Connecting to ResourceManager at hadoop101/127.0.0.1:8031
2021-10-22 16:38:11,891 INFO org.apache.hadoop.yarn.server.nodemanager.NodeStatusUpdaterImpl: Sending out 0 NM container statuses: []
2021-10-22 16:38:11,905 INFO org.apache.hadoop.yarn.server.nodemanager.NodeStatusUpdaterImpl: Registering with RM using containers :[]
2021-10-22 16:38:12,378 INFO org.apache.hadoop.yarn.server.nodemanager.security.NMContainerTokenSecretManager: Rolling master-key for container-tokens, got key with id -372929122
2021-10-22 16:38:12,380 INFO org.apache.hadoop.yarn.server.nodemanager.security.NMTokenSecretManagerInNM: Rolling master-key for container-tokens, got key with id -1234646392
2021-10-22 16:38:12,380 INFO org.apache.hadoop.yarn.server.nodemanager.NodeStatusUpdaterImpl: Registered with ResourceManager as LAPTOP-GCQQL01V.localdomain:40585 with total resource of <memory:8192, vCores:8>

// 10分钟清理一次
2021-10-22 16:48:10,259 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.ResourceLocalizationService: Cache Size Before Clean: 0, Total Deleted: 0, Public Deleted: 0, Private Deleted: 0
2021-11-23 10:16:10,445 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.ResourceLocalizationService: Cache Size Before Clean: 0, Total Deleted: 0, Public Deleted: 0, Private Deleted: 0
2021-11-23 10:26:10,443 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.ResourceLocalizationService: Cache Size Before Clean: 0, Total Deleted: 0, Public Deleted: 0, Private Deleted: 0

// pause
2021-11-23 11:31:53,998 INFO org.apache.hadoop.util.JvmPauseMonitor: Detected pause in JVM or host machine (eg GC): pause of approximately 2054ms
No GCs detected
```

##### NodeManager 关闭流程

NodeManager SHUTDOWN
```java
2021-10-22 16:52:19,723 ERROR org.apache.hadoop.yarn.server.nodemanager.NodeManager: RECEIVED SIGNAL 15: SIGTERM
2021-10-22 16:52:19,735 INFO org.apache.hadoop.yarn.server.nodemanager.NodeStatusUpdaterImpl: Successfully Unregistered the Node LAPTOP-GCQQL01V.localdomain:40585 with ResourceManager.
2021-10-22 16:52:19,748 INFO org.mortbay.log: Stopped HttpServer2$SelectChannelConnectorWithSafeStartup@0.0.0.0:8042
2021-10-22 16:52:19,849 INFO org.apache.hadoop.ipc.Server: Stopping server on 40585
2021-10-22 16:52:19,851 INFO org.apache.hadoop.ipc.Server: Stopping IPC Server listener on 0
2021-10-22 16:52:19,851 INFO org.apache.hadoop.ipc.Server: Stopping IPC Server Responder
2021-10-22 16:52:19,852 WARN org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl is interrupted. Exiting.
2021-10-22 16:52:19,861 INFO org.apache.hadoop.ipc.Server: Stopping server on 8040
2021-10-22 16:52:19,861 INFO org.apache.hadoop.ipc.Server: Stopping IPC Server listener on 8040
2021-10-22 16:52:19,862 INFO org.apache.hadoop.ipc.Server: Stopping IPC Server Responder
2021-10-22 16:52:19,862 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.ResourceLocalizationService: Public cache exiting
2021-10-22 16:52:19,862 WARN org.apache.hadoop.yarn.server.nodemanager.NodeResourceMonitorImpl: org.apache.hadoop.yarn.server.nodemanager.NodeResourceMonitorImpl is interrupted. Exiting.
2021-10-22 16:52:19,863 INFO org.apache.hadoop.metrics2.impl.MetricsSystemImpl: Stopping NodeManager metrics system...
2021-10-22 16:52:19,864 INFO org.apache.hadoop.metrics2.impl.MetricsSystemImpl: NodeManager metrics system stopped.
2021-10-22 16:52:19,864 INFO org.apache.hadoop.metrics2.impl.MetricsSystemImpl: NodeManager metrics system shutdown complete.
2021-10-22 16:52:19,864 INFO org.apache.hadoop.yarn.server.nodemanager.NodeManager: SHUTDOWN_MSG:
/************************************************************
SHUTDOWN_MSG: Shutting down NodeManager at LAPTOP-GCQQL01V/127.0.1.1
************************************************************/
```

#### YARN 运行机制

1. 客户端程序向 ResourceManager 提交应用并请求一个 ApplicationMaster 实例；
1. ResourceManager 找到一个可以运行一个 Container 的 NodeManager，并在这个 Container 中启动 ApplicationMaster 实例；
1. ApplicationMaster 向 ResourceManager 进行注册，注册之后客户端就可以查询 ResourceManager 获得自己 ApplicationMaster 的详细信息，以后就可以和自己的 ApplicationMaster 直接交互了（这个时候，客户端主动和 ApplicationMaster 交流，应用先向 ApplicationMaster 发送一个满足自己需求的资源请求）；
1. 在平常的操作过程中，ApplicationMaster 根据 resource-request协议 向 ResourceManager 发送 resource-request请求；
1. 当 Container 被成功分配后，ApplicationMaster 通过向 NodeManager 发送 container-launch-specification信息 来启动Container，container-launch-specification信息包含了能够让Container 和 ApplicationMaster 交流所需要的资料；
1. 应用程序的代码以 task 形式在启动的 Container 中运行，并把运行的进度、状态等信息通过 application-specific协议 发送给ApplicationMaster；
1. 在应用程序运行期间，提交应用的客户端主动和 ApplicationMaster 交流获得应用的运行状态、进度更新等信息，交流协议也是 application-specific协议；
1. 一旦应用程序执行完成并且所有相关工作也已经完成，ApplicationMaster 向 ResourceManager 取消注册然后关闭，用到所有的 Container 也归还给系统。

##### 客户端提交流程

run on yarn

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
21/11/23 17:14:15 INFO client.RMProxy: Connecting to ResourceManager at /0.0.0.0:8032

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
21/11/23 17:14:16 INFO input.FileInputFormat: Total input files to process : 8
21/11/23 17:14:16 INFO mapreduce.JobSubmitter: number of splits:8

// 5）向Stag路径写xml配置文件
writeConf(conf, submitJobFile);
conf.writeXml(out);

printTokens(jobId, job.getCredentials());
21/11/23 17:14:16 INFO mapreduce.JobSubmitter: Submitting tokens for job: job_1637633166384_0002

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
ApplicationClientProtocolPBServiceImpl.this.submitApplication();
real.submitApplication(request);
ClientRMService.submitApplication();
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

21/11/23 17:14:17 INFO impl.YarnClientImpl: Submitted application application_1637633166384_0002

addResourcesFileToConf();
LocalConfigurationProvider.this.getConfigurationInputStream(conf, resourceFile);
bootstrapConf.getConfResourceAsInputStream(name);
21/11/23 17:14:17 INFO conf.Configuration: resource-types.xml not found
21/11/23 17:14:17 INFO resource.ResourceUtils: Unable to find 'resource-types.xml'.
addMandatoryResources();
21/11/23 17:14:17 INFO resource.ResourceUtils: Adding resource type - name = memory-mb, units = Mi, type = COUNTABLE
21/11/23 17:14:17 INFO resource.ResourceUtils: Adding resource type - name = vcores, units = , type = COUNTABLE



21/11/23 17:14:17 INFO mapreduce.Job: The url to track the job: http://LAPTOP-GCQQL01V.localdomain:8088/proxy/application_1637633166384_0002/
monitorAndPrintJob();
21/11/23 17:14:17 INFO mapreduce.Job: Running job: job_1637633166384_0002
21/11/23 17:14:23 INFO mapreduce.Job: Job job_1637633166384_0002 running in uber mode : false
21/11/23 17:14:23 INFO mapreduce.Job:  map 0% reduce 0%
21/11/23 17:14:32 INFO mapreduce.Job:  map 75% reduce 0%
21/11/23 17:14:36 INFO mapreduce.Job:  map 100% reduce 0%
21/11/23 17:14:37 INFO mapreduce.Job:  map 100% reduce 100%
21/11/23 17:14:39 INFO mapreduce.Job: Job job_1637633166384_0002 completed successfully

Counters counters = getCounters();
cluster.getClient().getJobCounters(getJobID());
21/11/23 17:14:39 INFO mapreduce.Job: Counters: 49
        File System Counters
                FILE: Number of bytes read=25
                FILE: Number of bytes written=1879993
                FILE: Number of read operations=0
                FILE: Number of large read operations=0
                FILE: Number of write operations=0
                HDFS: Number of bytes read=32285
                HDFS: Number of bytes written=111
                HDFS: Number of read operations=27
                HDFS: Number of large read operations=0
                HDFS: Number of write operations=2
        Job Counters
                Launched map tasks=8
                Launched reduce tasks=1
                Data-local map tasks=8
                Total time spent by all maps in occupied slots (ms)=43758
                Total time spent by all reduces in occupied slots (ms)=3009
                Total time spent by all map tasks (ms)=43758
                Total time spent by all reduce tasks (ms)=3009
                Total vcore-milliseconds taken by all map tasks=43758
                Total vcore-milliseconds taken by all reduce tasks=3009
                Total megabyte-milliseconds taken by all map tasks=44808192
                Total megabyte-milliseconds taken by all reduce tasks=3081216
        Map-Reduce Framework
                Map input records=864
                Map output records=1
                Map output bytes=17
                Map output materialized bytes=67
                Input split bytes=949
                Combine input records=1
                Combine output records=1
                Reduce input groups=1
                Reduce shuffle bytes=67
                Reduce input records=1
                Reduce output records=1
                Spilled Records=2
                Shuffled Maps =8
                Failed Shuffles=0
                Merged Map outputs=8
                GC time elapsed (ms)=2285
                CPU time spent (ms)=5620
                Physical memory (bytes) snapshot=2664464384
                Virtual memory (bytes) snapshot=17079242752
                Total committed heap usage (bytes)=1739063296
        Shuffle Errors
                BAD_ID=0
                CONNECTION=0
                IO_ERROR=0
                WRONG_LENGTH=0
                WRONG_MAP=0
                WRONG_REDUCE=0
        File Input Format Counters
                Bytes Read=31336
        File Output Format Counters
                Bytes Written=111
```

##### ResourceManager 流程

```java
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



##### NodeManager 流程

##### 作业提交

RunJar 进程会向集群提交 job，Resource Manager 会为本次 job 提供一个 jobID，还会返回本次作业提交的资源路径 staging-dir。接着，客户端将资源（包括Jar包，配置文件）提交到 HDFS 中，最后，通过调ResourceManager 的 submitApplication 方法来提交作业

##### 作业初始化

提交完成之后，ResourceManager 会将本次作业添加到一个任务队列中，然后将这些任务分配给各个 NodeManager 中，并且为每个 NodeManager 创建一个的资源容器。创建完成之后，ResourceManager 会在容器内启动 AppMaster 进程，启动完成之后在 ResourceManager 中进行注册，这样就保持了ResourceManager 和 AppMaster 的通信。

##### 任务分配

由创建的 AppMaster 去分配在哪些 NameNode 上运行 map 和 reduce 程序，运行 map 和 reduce 的程序会从 HDFS 中获取相关的资源再执行 map 和reduce 程序，这个进程为 YarnChild。

任务完成之后，AppMaster向 ResourceManager 注销自己，ResourceManager 会回收相关的资源


```java
2021-11-23 10:06:29,627 INFO SecurityLogger.org.apache.hadoop.ipc.Server: Auth successful for appattempt_1637633166384_0001_000001 (auth:SIMPLE)
2021-11-23 10:06:29,715 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Start request for container_1637633166384_0001_01_000001 by user liuxy
2021-11-23 10:06:29,755 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Creating a new application reference for app application_1637633166384_0001
2021-11-23 10:06:29,762 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Application application_1637633166384_0001 transitioned from NEW to INITING
2021-11-23 10:06:29,763 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Adding container_1637633166384_0001_01_000001 to application application_1637633166384_0001
2021-11-23 10:06:29,763 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        IP=127.0.0.1    OPERATION=Start Container Request
       TARGET=ContainerManageImpl      RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000001
2021-11-23 10:06:30,230 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Application application_1637633166384_0001 transitioned from INITING to RUNNING
2021-11-23 10:06:30,234 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000001 transitioned from NEW to LOCALIZING
2021-11-23 10:06:30,235 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_INIT for appId application_1637633166384_0001
2021-11-23 10:06:30,246 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.ResourceLocalizationService: Created localizer for container_1637633166384_0001_01_000001
2021-11-23 10:06:30,270 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.ResourceLocalizationService: Writing credentials to the nmPrivate file /opt/hadoop/tmp/nm-local-dir/nmPrivate/container_1637633166384_0001_01_00000117d4a8b6968.tokens
2021-11-23 10:06:30,272 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Initializing user liuxy
2021-11-23 10:06:30,290 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Copying from /opt/hadoop/tmp/nm-local-dir/nmPrivate/container_1637633166384_0001_01_00000117d4a8b6968.tokens to /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000001.tokens
2021-11-23 10:06:30,290 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Localizer CWD set to /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001 = file:/opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001
2021-11-23 10:06:30,301 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.localizer.ContainerLocalizer: Disk Validator: yarn.nodemanager.disk-validator is loaded.
2021-11-23 10:06:30,621 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000001 transitioned from LOCALIZING to SCHEDULED
2021-11-23 10:06:30,622 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.scheduler.ContainerScheduler: Starting container [container_1637633166384_0001_01_000001]
2021-11-23 10:06:30,647 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000001 transitioned from SCHEDULED to RUNNING
2021-11-23 10:06:30,648 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Starting resource-monitoring for container_1637633166384_0001_01_000001
2021-11-23 10:06:30,651 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: launchContainer: [bash, /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000001/default_container_executor.sh]
2021-11-23 10:06:31,506 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: container_1637633166384_0001_01_000001's ip = 127.0.1.1, and hostname = LAPTOP-GCQQL01V
2021-11-23 10:06:31,511 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Skipping monitoring container container_1637633166384_0001_01_000001 since CPU usage is not yet available.
2021-11-23 10:06:36,530 INFO SecurityLogger.org.apache.hadoop.ipc.Server: Auth successful for appattempt_1637633166384_0001_000001 (auth:SIMPLE)
2021-11-23 10:06:36,533 INFO SecurityLogger.org.apache.hadoop.ipc.Server: Auth successful for appattempt_1637633166384_0001_000001 (auth:SIMPLE)
2021-11-23 10:06:36,535 INFO SecurityLogger.org.apache.hadoop.ipc.Server: Auth successful for appattempt_1637633166384_0001_000001 (auth:SIMPLE)
2021-11-23 10:06:36,537 INFO SecurityLogger.org.apache.hadoop.ipc.Server: Auth successful for appattempt_1637633166384_0001_000001 (auth:SIMPLE)
2021-11-23 10:06:36,539 INFO SecurityLogger.org.apache.hadoop.ipc.Server: Auth successful for appattempt_1637633166384_0001_000001 (auth:SIMPLE)
2021-11-23 10:06:36,548 INFO SecurityLogger.org.apache.hadoop.ipc.Server: Auth successful for appattempt_1637633166384_0001_000001 (auth:SIMPLE)
2021-11-23 10:06:36,566 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Start request for container_1637633166384_0001_01_000005 by user liuxy
2021-11-23 10:06:36,568 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        IP=127.0.0.1    OPERATION=Start Container Request
       TARGET=ContainerManageImpl      RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000005
2021-11-23 10:06:36,568 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Adding container_1637633166384_0001_01_000005 to application application_1637633166384_0001
2021-11-23 10:06:36,571 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000005 transitioned from NEW to LOCALIZING
2021-11-23 10:06:36,571 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_INIT for appId application_1637633166384_0001
2021-11-23 10:06:36,571 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event APPLICATION_INIT for appId application_1637633166384_0001
2021-11-23 10:06:36,571 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got APPLICATION_INIT for service mapreduce_shuffle
2021-11-23 10:06:36,572 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Start request for container_1637633166384_0001_01_000004 by user liuxy


2021-11-23 10:06:36,574 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        IP=127.0.0.1    OPERATION=Start Container Request
       TARGET=ContainerManageImpl      RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000004
2021-11-23 10:06:36,577 INFO org.apache.hadoop.mapred.ShuffleHandler: Added token for job_1637633166384_0001
2021-11-23 10:06:36,577 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Start request for container_1637633166384_0001_01_000003 by user liuxy
2021-11-23 10:06:36,577 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Adding container_1637633166384_0001_01_000004 to application application_1637633166384_0001
2021-11-23 10:06:36,578 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000005 transitioned from LOCALIZING to SCHEDULED
2021-11-23 10:06:36,579 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000004 transitioned from NEW to LOCALIZING
2021-11-23 10:06:36,579 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.scheduler.ContainerScheduler: Starting container [container_1637633166384_0001_01_000005]
2021-11-23 10:06:36,580 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_INIT for appId application_1637633166384_0001
2021-11-23 10:06:36,580 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event APPLICATION_INIT for appId application_1637633166384_0001
2021-11-23 10:06:36,580 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got APPLICATION_INIT for service mapreduce_shuffle
2021-11-23 10:06:36,580 INFO org.apache.hadoop.mapred.ShuffleHandler: Added token for job_1637633166384_0001
2021-11-23 10:06:36,581 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        IP=127.0.0.1    OPERATION=Start Container Request
       TARGET=ContainerManageImpl      RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000003
2021-11-23 10:06:36,583 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Start request for container_1637633166384_0001_01_000006 by user liuxy
2021-11-23 10:06:36,585 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        IP=127.0.0.1    OPERATION=Start Container Request
       TARGET=ContainerManageImpl      RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000006
2021-11-23 10:06:36,587 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Start request for container_1637633166384_0001_01_000007 by user liuxy
2021-11-23 10:06:36,598 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000004 transitioned from LOCALIZING to SCHEDULED
2021-11-23 10:06:36,598 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Adding container_1637633166384_0001_01_000003 to application application_1637633166384_0001
2021-11-23 10:06:36,598 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Adding container_1637633166384_0001_01_000006 to application application_1637633166384_0001
2021-11-23 10:06:36,598 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.scheduler.ContainerScheduler: Starting container [container_1637633166384_0001_01_000004]
2021-11-23 10:06:36,600 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000003 transitioned from NEW to LOCALIZING
2021-11-23 10:06:36,600 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        IP=127.0.0.1    OPERATION=Start Container Request
       TARGET=ContainerManageImpl      RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000007
2021-11-23 10:06:36,601 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000006 transitioned from NEW to LOCALIZING
2021-11-23 10:06:36,603 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_INIT for appId application_1637633166384_0001
2021-11-23 10:06:36,603 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event APPLICATION_INIT for appId application_1637633166384_0001
2021-11-23 10:06:36,603 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got APPLICATION_INIT for service mapreduce_shuffle
2021-11-23 10:06:36,603 INFO org.apache.hadoop.mapred.ShuffleHandler: Added token for job_1637633166384_0001
2021-11-23 10:06:36,603 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Start request for container_1637633166384_0001_01_000002 by user liuxy
2021-11-23 10:06:36,603 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Adding container_1637633166384_0001_01_000007 to application application_1637633166384_0001
2021-11-23 10:06:36,603 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_INIT for appId application_1637633166384_0001
2021-11-23 10:06:36,603 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event APPLICATION_INIT for appId application_1637633166384_0001
2021-11-23 10:06:36,603 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got APPLICATION_INIT for service mapreduce_shuffle
2021-11-23 10:06:36,604 INFO org.apache.hadoop.mapred.ShuffleHandler: Added token for job_1637633166384_0001
2021-11-23 10:06:36,604 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000003 transitioned from LOCALIZING to SCHEDULED
2021-11-23 10:06:36,606 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000007 transitioned from NEW to LOCALIZING
2021-11-23 10:06:36,607 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000006 transitioned from LOCALIZING to SCHEDULED
2021-11-23 10:06:36,607 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.scheduler.ContainerScheduler: Starting container [container_1637633166384_0001_01_000003]
2021-11-23 10:06:36,607 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        IP=127.0.0.1    OPERATION=Start Container Request
       TARGET=ContainerManageImpl      RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000002
2021-11-23 10:06:36,607 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_INIT for appId application_1637633166384_0001
2021-11-23 10:06:36,607 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event APPLICATION_INIT for appId application_1637633166384_0001
2021-11-23 10:06:36,608 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got APPLICATION_INIT for service mapreduce_shuffle
2021-11-23 10:06:36,608 INFO org.apache.hadoop.mapred.ShuffleHandler: Added token for job_1637633166384_0001
2021-11-23 10:06:36,608 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.scheduler.ContainerScheduler: Starting container [container_1637633166384_0001_01_000006]
2021-11-23 10:06:36,608 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Adding container_1637633166384_0001_01_000002 to application application_1637633166384_0001
2021-11-23 10:06:36,610 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000007 transitioned from LOCALIZING to SCHEDULED
2021-11-23 10:06:36,613 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000002 transitioned from NEW to LOCALIZING
2021-11-23 10:06:36,613 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.scheduler.ContainerScheduler: Starting container [container_1637633166384_0001_01_000007]
2021-11-23 10:06:36,615 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_INIT for appId application_1637633166384_0001
2021-11-23 10:06:36,615 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event APPLICATION_INIT for appId application_1637633166384_0001
2021-11-23 10:06:36,615 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got APPLICATION_INIT for service mapreduce_shuffle
2021-11-23 10:06:36,616 INFO org.apache.hadoop.mapred.ShuffleHandler: Added token for job_1637633166384_0001
2021-11-23 10:06:36,617 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000002 transitioned from LOCALIZING to SCHEDULED
2021-11-23 10:06:36,617 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.scheduler.ContainerScheduler: Starting container [container_1637633166384_0001_01_000002]
2021-11-23 10:06:36,626 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000005 transitioned from SCHEDULED to RUNNING
2021-11-23 10:06:36,626 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Starting resource-monitoring for container_1637633166384_0001_01_000005
2021-11-23 10:06:36,631 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000004 transitioned from SCHEDULED to RUNNING
2021-11-23 10:06:36,631 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Starting resource-monitoring for container_1637633166384_0001_01_000004
2021-11-23 10:06:36,632 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: launchContainer: [bash, /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000005/default_container_executor.sh]
2021-11-23 10:06:36,633 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000003 transitioned from SCHEDULED to RUNNING
2021-11-23 10:06:36,633 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Starting resource-monitoring for container_1637633166384_0001_01_000003
2021-11-23 10:06:36,634 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000006 transitioned from SCHEDULED to RUNNING
2021-11-23 10:06:36,634 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Starting resource-monitoring for container_1637633166384_0001_01_000006
2021-11-23 10:06:36,639 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: launchContainer: [bash, /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000004/default_container_executor.sh]
2021-11-23 10:06:36,639 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000007 transitioned from SCHEDULED to RUNNING
2021-11-23 10:06:36,639 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000002 transitioned from SCHEDULED to RUNNING
2021-11-23 10:06:36,639 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Starting resource-monitoring for container_1637633166384_0001_01_000007
2021-11-23 10:06:36,639 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Starting resource-monitoring for container_1637633166384_0001_01_000002

2021-11-23 10:06:36,641 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: launchContainer: [bash, /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000003/default_container_executor.sh]
2021-11-23 10:06:36,641 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: launchContainer: [bash, /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000006/default_container_executor.sh]
2021-11-23 10:06:36,643 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: launchContainer: [bash, /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000007/default_container_executor.sh]
2021-11-23 10:06:36,644 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: launchContainer: [bash, /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000002/default_container_executor.sh]
2021-11-23 10:06:37,520 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: container_1637633166384_0001_01_000007's ip = 127.0.1.1, and hostname = LAPTOP-GCQQL01V
2021-11-23 10:06:37,599 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Skipping monitoring container container_1637633166384_0001_01_000007 since CPU usage is not yet available.
2021-11-23 10:06:37,600 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: container_1637633166384_0001_01_000006's ip = 127.0.1.1, and hostname = LAPTOP-GCQQL01V
2021-11-23 10:06:37,606 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Skipping monitoring container container_1637633166384_0001_01_000006 since CPU usage is not yet available.
2021-11-23 10:06:37,619 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: container_1637633166384_0001_01_000005's ip = 127.0.1.1, and hostname = LAPTOP-GCQQL01V
2021-11-23 10:06:37,619 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: container_1637633166384_0001_01_000005's ip = 127.0.1.1, and hostname = LAPTOP-GCQQL01V
2021-11-23 10:06:37,635 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Skipping monitoring container container_1637633166384_0001_01_000005 since CPU usage is not yet available.
2021-11-23 10:06:37,636 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: container_1637633166384_0001_01_000004's ip = 127.0.1.1, and hostname = LAPTOP-GCQQL01V
2021-11-23 10:06:37,645 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Skipping monitoring container container_1637633166384_0001_01_000004 since CPU usage is not yet available.
2021-11-23 10:06:37,652 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: container_1637633166384_0001_01_000003's ip = 127.0.1.1, and hostname = LAPTOP-GCQQL01V
2021-11-23 10:06:37,657 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Skipping monitoring container container_1637633166384_0001_01_000003 since CPU usage is not yet available.
2021-11-23 10:06:37,661 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: container_1637633166384_0001_01_000002's ip = 127.0.1.1, and hostname = LAPTOP-GCQQL01V
2021-11-23 10:06:37,667 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Skipping monitoring container container_1637633166384_0001_01_000002 since CPU usage is not yet available.
2021-11-23 10:06:43,507 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Container container_1637633166384_0001_01_000007 succeeded
2021-11-23 10:06:43,508 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000007 transitioned from RUNNING to EXITED_WITH_SUCCESS
2021-11-23 10:06:43,508 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Cleaning up container container_1637633166384_0001_01_000007
2021-11-23 10:06:43,525 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting absolute path : /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000007
2021-11-23 10:06:43,526 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        OPERATION=Container Finished - Succeeded        TARGET=ContainerImpl    RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000007
2021-11-23 10:06:43,529 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000007 transitioned from EXITED_WITH_SUCCESS to DONE
2021-11-23 10:06:43,529 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Removing container_1637633166384_0001_01_000007 from application application_1637633166384_0001
2021-11-23 10:06:43,529 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Stopping resource-monitoring for container_1637633166384_0001_01_000007
2021-11-23 10:06:43,530 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.logaggregation.AppLogAggregatorImpl: Considering container container_1637633166384_0001_01_000007 for log-aggregation
2021-11-23 10:06:43,530 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_STOP for appId application_1637633166384_0001
2021-11-23 10:06:43,544 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Container container_1637633166384_0001_01_000002 succeeded
2021-11-23 10:06:43,545 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000002 transitioned from RUNNING to EXITED_WITH_SUCCESS
2021-11-23 10:06:43,545 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Cleaning up container container_1637633166384_0001_01_000002
2021-11-23 10:06:43,551 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Container container_1637633166384_0001_01_000003 succeeded
2021-11-23 10:06:43,563 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting absolute path : /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000002
2021-11-23 10:06:43,563 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000003 transitioned from RUNNING to EXITED_WITH_SUCCESS

2021-11-23 10:06:43,563 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        OPERATION=Container Finished - Succeeded        TARGET=ContainerImpl    RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000002
2021-11-23 10:06:43,564 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000002 transitioned from EXITED_WITH_SUCCESS to DONE
2021-11-23 10:06:43,564 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Cleaning up container container_1637633166384_0001_01_000003
2021-11-23 10:06:43,583 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting absolute path : /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000003
2021-11-23 10:06:43,584 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Removing container_1637633166384_0001_01_000002 from application application_1637633166384_0001
2021-11-23 10:06:43,584 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Stopping resource-monitoring for container_1637633166384_0001_01_000002
2021-11-23 10:06:43,584 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.logaggregation.AppLogAggregatorImpl: Considering container container_1637633166384_0001_01_000002 for log-aggregation
2021-11-23 10:06:43,584 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_STOP for appId application_1637633166384_0001
2021-11-23 10:06:43,584 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        OPERATION=Container Finished - Succeeded        TARGET=ContainerImpl    RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000003
2021-11-23 10:06:43,585 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000003 transitioned from EXITED_WITH_SUCCESS to DONE
2021-11-23 10:06:43,585 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Removing container_1637633166384_0001_01_000003 from application application_1637633166384_0001
2021-11-23 10:06:43,585 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Stopping resource-monitoring for container_1637633166384_0001_01_000003
2021-11-23 10:06:43,585 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.logaggregation.AppLogAggregatorImpl: Considering container container_1637633166384_0001_01_000003 for log-aggregation
2021-11-23 10:06:43,585 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_STOP for appId application_1637633166384_0001
2021-11-23 10:06:43,642 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Container container_1637633166384_0001_01_000006 succeeded
2021-11-23 10:06:43,643 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000006 transitioned from RUNNING to EXITED_WITH_SUCCESS
2021-11-23 10:06:43,643 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Cleaning up container container_1637633166384_0001_01_000006
2021-11-23 10:06:43,666 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Container container_1637633166384_0001_01_000005 succeeded
2021-11-23 10:06:43,669 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting absolute path : /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000006
2021-11-23 10:06:43,669 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000005 transitioned from RUNNING to EXITED_WITH_SUCCESS
021-11-23 10:06:43,670 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        OPERATION=Container Finished - Succeeded        TARGET=ContainerImpl    RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000006
2021-11-23 10:06:43,670 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000006 transitioned from EXITED_WITH_SUCCESS to DONE
2021-11-23 10:06:43,671 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Cleaning up container container_1637633166384_0001_01_000005
2021-11-23 10:06:43,690 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting absolute path : /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000005
2021-11-23 10:06:43,690 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Removing container_1637633166384_0001_01_000006 from application application_1637633166384_0001
2021-11-23 10:06:43,691 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Stopping resource-monitoring for container_1637633166384_0001_01_000006
2021-11-23 10:06:43,691 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.logaggregation.AppLogAggregatorImpl: Considering container container_1637633166384_0001_01_000006 for log-aggregation
2021-11-23 10:06:43,691 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_STOP for appId application_1637633166384_0001
2021-11-23 10:06:43,691 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        OPERATION=Container Finished - Succeeded        TARGET=ContainerImpl    RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000005
2021-11-23 10:06:43,692 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000005 transitioned from EXITED_WITH_SUCCESS to DONE
2021-11-23 10:06:43,692 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Removing container_1637633166384_0001_01_000005 from application application_1637633166384_0001
2021-11-23 10:06:43,692 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Stopping resource-monitoring for container_1637633166384_0001_01_000005
2021-11-23 10:06:43,692 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.logaggregation.AppLogAggregatorImpl: Considering container container_1637633166384_0001_01_000005 for log-aggregation
2021-11-23 10:06:43,693 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_STOP for appId application_1637633166384_0001
2021-11-23 10:06:43,716 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Container container_1637633166384_0001_01_000004 succeeded
2021-11-23 10:06:43,716 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000004 transitioned from RUNNING to EXITED_WITH_SUCCESS
2021-11-23 10:06:43,716 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Cleaning up container container_1637633166384_0001_01_000004
2021-11-23 10:06:43,734 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting absolute path : /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000004

2021-11-23 10:06:43,735 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        OPERATION=Container Finished - Succeeded        TARGET=ContainerImpl    RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000004
2021-11-23 10:06:43,736 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000004 transitioned from EXITED_WITH_SUCCESS to DONE
2021-11-23 10:06:43,736 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Removing container_1637633166384_0001_01_000004 from application application_1637633166384_0001
2021-11-23 10:06:43,736 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Stopping resource-monitoring for container_1637633166384_0001_01_000004
2021-11-23 10:06:43,736 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.logaggregation.AppLogAggregatorImpl: Considering container container_1637633166384_0001_01_000004 for log-aggregation
2021-11-23 10:06:43,736 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_STOP for appId application_1637633166384_0001
2021-11-23 10:06:44,440 INFO SecurityLogger.org.apache.hadoop.ipc.Server: Auth successful for appattempt_1637633166384_0001_000001 (auth:SIMPLE)
2021-11-23 10:06:44,445 INFO SecurityLogger.org.apache.hadoop.ipc.Server: Auth successful for appattempt_1637633166384_0001_000001 (auth:SIMPLE)
2021-11-23 10:06:44,453 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Start request for container_1637633166384_0001_01_000009 by user liuxy
2021-11-23 10:06:44,456 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        IP=127.0.0.1    OPERATION=Start Container Request
       TARGET=ContainerManageImpl      RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000009
2021-11-23 10:06:44,456 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Adding container_1637633166384_0001_01_000009 to application application_1637633166384_0001
2021-11-23 10:06:44,457 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000009 transitioned from NEW to LOCALIZING
2021-11-23 10:06:44,458 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_INIT for appId application_1637633166384_0001
2021-11-23 10:06:44,458 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event APPLICATION_INIT for appId application_1637633166384_0001
2021-11-23 10:06:44,458 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got APPLICATION_INIT for service mapreduce_shuffle
2021-11-23 10:06:44,459 INFO org.apache.hadoop.mapred.ShuffleHandler: Added token for job_1637633166384_0001
2021-11-23 10:06:44,459 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000009 transitioned from LOCALIZING to SCHEDULED
2021-11-23 10:06:44,459 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Start request for container_1637633166384_0001_01_000008 by user liuxy
2021-11-23 10:06:44,459 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.scheduler.ContainerScheduler: Starting container [container_1637633166384_0001_01_000009]
2021-11-23 10:06:44,462 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        IP=127.0.0.1    OPERATION=Start Container Request
       TARGET=ContainerManageImpl      RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000008
2021-11-23 10:06:44,462 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Adding container_1637633166384_0001_01_000008 to application application_1637633166384_0001
2021-11-23 10:06:44,464 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000008 transitioned from NEW to LOCALIZING
2021-11-23 10:06:44,464 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_INIT for appId application_1637633166384_0001
2021-11-23 10:06:44,464 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event APPLICATION_INIT for appId application_1637633166384_0001
2021-11-23 10:06:44,464 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got APPLICATION_INIT for service mapreduce_shuffle
2021-11-23 10:06:44,464 INFO org.apache.hadoop.mapred.ShuffleHandler: Added token for job_1637633166384_0001
2021-11-23 10:06:44,465 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000008 transitioned from LOCALIZING to SCHEDULED
2021-11-23 10:06:44,465 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.scheduler.ContainerScheduler: Starting container [container_1637633166384_0001_01_000008]
2021-11-23 10:06:44,480 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000009 transitioned from SCHEDULED to RUNNING
2021-11-23 10:06:44,480 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Starting resource-monitoring for container_1637633166384_0001_01_000009
2021-11-23 10:06:44,483 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: launchContainer: [bash, /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000009/default_container_executor.sh]
2021-11-23 10:06:44,487 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000008 transitioned from SCHEDULED to RUNNING
2021-11-23 10:06:44,487 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Starting resource-monitoring for container_1637633166384_0001_01_000008
2021-11-23 10:06:44,492 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: launchContainer: [bash, /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000008/default_container_executor.sh]
2021-11-23 10:06:45,460 INFO SecurityLogger.org.apache.hadoop.ipc.Server: Auth successful for appattempt_1637633166384_0001_000001 (auth:SIMPLE)
2021-11-23 10:06:45,481 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Start request for container_1637633166384_0001_01_000010 by user liuxy
2021-11-23 10:06:45,484 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        IP=127.0.0.1    OPERATION=Start Container Request
       TARGET=ContainerManageImpl      RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000010
2021-11-23 10:06:45,484 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Adding container_1637633166384_0001_01_000010 to application application_1637633166384_0001
2021-11-23 10:06:45,487 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000010 transitioned from NEW to LOCALIZING
2021-11-23 10:06:45,487 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_INIT for appId application_1637633166384_0001
2021-11-23 10:06:45,487 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event APPLICATION_INIT for appId application_1637633166384_0001
2021-11-23 10:06:45,487 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got APPLICATION_INIT for service mapreduce_shuffle
2021-11-23 10:06:45,488 INFO org.apache.hadoop.mapred.ShuffleHandler: Added token for job_1637633166384_0001
2021-11-23 10:06:45,488 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000010 transitioned from LOCALIZING to SCHEDULED
2021-11-23 10:06:45,488 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.scheduler.ContainerScheduler: Starting container [container_1637633166384_0001_01_000010]
2021-11-23 10:06:45,512 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000010 transitioned from SCHEDULED to RUNNING
2021-11-23 10:06:45,512 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Starting resource-monitoring for container_1637633166384_0001_01_000010
2021-11-23 10:06:45,517 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: launchContainer: [bash, /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000010/default_container_executor.sh]
2021-11-23 10:06:45,750 INFO org.apache.hadoop.yarn.server.nodemanager.NodeStatusUpdaterImpl: Removed completed containers from NM context: [container_1637633166384_0001_01_000007, container_1637633166384_0001_01_000006, container_1637633166384_0001_01_000005, container_1637633166384_0001_01_000004, container_1637633166384_0001_01_000003, container_1637633166384_0001_01_000002]
2021-11-23 10:06:46,877 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: container_1637633166384_0001_01_000010's ip = 127.0.1.1, and hostname = LAPTOP-GCQQL01V
2021-11-23 10:06:46,880 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Skipping monitoring container container_1637633166384_0001_01_000010 since CPU usage is not yet available.
2021-11-23 10:06:46,881 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: container_1637633166384_0001_01_000009's ip = 127.0.1.1, and hostname = LAPTOP-GCQQL01V
2021-11-23 10:06:46,885 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Skipping monitoring container container_1637633166384_0001_01_000009 since CPU usage is not yet available.
2021-11-23 10:06:46,886 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: container_1637633166384_0001_01_000008's ip = 127.0.1.1, and hostname = LAPTOP-GCQQL01V
2021-11-23 10:06:46,889 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Skipping monitoring container container_1637633166384_0001_01_000008 since CPU usage is not yet available.
2021-11-23 10:06:48,328 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Container container_1637633166384_0001_01_000008 succeeded
2021-11-23 10:06:48,328 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000008 transitioned from RUNNING to EXITED_WITH_SUCCESS
2021-11-23 10:06:48,328 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Cleaning up container container_1637633166384_0001_01_000008
2021-11-23 10:06:48,348 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting absolute path : /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000008

2021-11-23 10:06:48,348 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        OPERATION=Container Finished - Succeeded        TARGET=ContainerImpl    RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000008
2021-11-23 10:06:48,349 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000008 transitioned from EXITED_WITH_SUCCESS to DONE
2021-11-23 10:06:48,349 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Removing container_1637633166384_0001_01_000008 from application application_1637633166384_0001
2021-11-23 10:06:48,349 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Stopping resource-monitoring for container_1637633166384_0001_01_000008
2021-11-23 10:06:48,349 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.logaggregation.AppLogAggregatorImpl: Considering container container_1637633166384_0001_01_000008 for log-aggregation
2021-11-23 10:06:48,349 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_STOP for appId application_1637633166384_0001
2021-11-23 10:06:48,387 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Container container_1637633166384_0001_01_000009 succeeded
2021-11-23 10:06:48,388 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000009 transitioned from RUNNING to EXITED_WITH_SUCCESS
2021-11-23 10:06:48,388 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Cleaning up container container_1637633166384_0001_01_000009
2021-11-23 10:06:48,408 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting absolute path : /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000009

2021-11-23 10:06:48,408 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        OPERATION=Container Finished - Succeeded        TARGET=ContainerImpl    RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000009
2021-11-23 10:06:48,409 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000009 transitioned from EXITED_WITH_SUCCESS to DONE
2021-11-23 10:06:48,409 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Removing container_1637633166384_0001_01_000009 from application application_1637633166384_0001
2021-11-23 10:06:48,409 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Stopping resource-monitoring for container_1637633166384_0001_01_000009
2021-11-23 10:06:48,410 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.logaggregation.AppLogAggregatorImpl: Considering container container_1637633166384_0001_01_000009 for log-aggregation
2021-11-23 10:06:48,410 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_STOP for appId application_1637633166384_0001
2021-11-23 10:06:49,158 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Container container_1637633166384_0001_01_000010 succeeded
2021-11-23 10:06:49,158 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000010 transitioned from RUNNING to EXITED_WITH_SUCCESS
2021-11-23 10:06:49,158 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Cleaning up container container_1637633166384_0001_01_000010
2021-11-23 10:06:49,171 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting absolute path : /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000010
2021-11-23 10:06:49,171 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        OPERATION=Container Finished - Succeeded        TARGET=ContainerImpl    RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000010
2021-11-23 10:06:49,171 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000010 transitioned from EXITED_WITH_SUCCESS to DONE
2021-11-23 10:06:49,171 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Removing container_1637633166384_0001_01_000010 from application application_1637633166384_0001
2021-11-23 10:06:49,172 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Stopping resource-monitoring for container_1637633166384_0001_01_000010
2021-11-23 10:06:49,172 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.logaggregation.AppLogAggregatorImpl: Considering container container_1637633166384_0001_01_000010 for log-aggregation
2021-11-23 10:06:49,172 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_STOP for appId application_1637633166384_0001
2021-11-23 10:06:50,178 INFO org.apache.hadoop.yarn.server.nodemanager.NodeStatusUpdaterImpl: Removed completed containers from NM context: [container_1637633166384_0001_01_000009, container_1637633166384_0001_01_000008]
2021-11-23 10:06:56,681 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Container container_1637633166384_0001_01_000001 succeeded
2021-11-23 10:06:56,682 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000001 transitioned from RUNNING to EXITED_WITH_SUCCESS
2021-11-23 10:06:56,682 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.launcher.ContainerLaunch: Cleaning up container container_1637633166384_0001_01_000001
2021-11-23 10:06:56,698 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting absolute path : /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001/container_1637633166384_0001_01_000001
2021-11-23 10:06:56,699 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        OPERATION=Container Finished - Succeeded        TARGET=ContainerImpl    RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000001
2021-11-23 10:06:56,699 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.container.ContainerImpl: Container container_1637633166384_0001_01_000001 transitioned from EXITED_WITH_SUCCESS to DONE
2021-11-23 10:06:56,700 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Removing container_1637633166384_0001_01_000001 from application application_1637633166384_0001
2021-11-23 10:06:56,700 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.monitor.ContainersMonitorImpl: Stopping resource-monitoring for container_1637633166384_0001_01_000001
2021-11-23 10:06:56,700 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.logaggregation.AppLogAggregatorImpl: Considering container container_1637633166384_0001_01_000001 for log-aggregation
2021-11-23 10:06:56,700 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event CONTAINER_STOP for appId application_1637633166384_0001
2021-11-23 10:06:56,721 INFO SecurityLogger.org.apache.hadoop.ipc.Server: Auth successful for appattempt_1637633166384_0001_000001 (auth:SIMPLE)
2021-11-23 10:06:56,731 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.ContainerManagerImpl: Stopping container with container Id: container_1637633166384_0001_01_000001
2021-11-23 10:06:56,732 INFO org.apache.hadoop.yarn.server.nodemanager.NMAuditLogger: USER=liuxy        IP=127.0.0.1    OPERATION=Stop Container Request
        TARGET=ContainerManageImpl      RESULT=SUCCESS  APPID=application_1637633166384_0001    CONTAINERID=container_1637633166384_0001_01_000001
2021-11-23 10:06:57,705 INFO org.apache.hadoop.yarn.server.nodemanager.NodeStatusUpdaterImpl: Removed completed containers from NM context: [container_1637633166384_0001_01_000010, container_1637633166384_0001_01_000001]
2021-11-23 10:06:57,708 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Application application_1637633166384_0001 transitioned from RUNNING to APPLICATION_RESOURCES_CLEANINGUP
2021-11-23 10:06:57,708 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting absolute path : /opt/hadoop/tmp/nm-local-dir/usercache/liuxy/appcache/application_1637633166384_0001
2021-11-23 10:06:57,708 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.AuxServices: Got event APPLICATION_STOP for appId application_1637633166384_0001
2021-11-23 10:06:57,709 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.application.ApplicationImpl: Application application_1637633166384_0001 transitioned from APPLICATION_RESOURCES_CLEANINGUP to FINISHED
2021-11-23 10:06:57,709 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.logaggregation.AppLogAggregatorImpl: Application just finished : application_1637633166384_0001


2021-11-23 10:06:57,752 INFO org.apache.hadoop.yarn.server.nodemanager.containermanager.logaggregation.AppLogAggregatorImpl: Uploading logs for container container_1637633166384_0001_01_000010. Current good log dirs are /usr/local/hadoop-2.10.1/logs/userlogs

Uploading logs for container container_1637633166384_0001_01_0000010. 
Uploading logs for container container_1637633166384_0001_01_000009. 
Uploading logs for container container_1637633166384_0001_01_000008. 
Uploading logs for container container_1637633166384_0001_01_000007. 
Uploading logs for container container_1637633166384_0001_01_000006. 
Uploading logs for container container_1637633166384_0001_01_000005. 
Uploading logs for container container_1637633166384_0001_01_000004. 
Uploading logs for container container_1637633166384_0001_01_000003. 
Uploading logs for container container_1637633166384_0001_01_000002. 
Uploading logs for container container_1637633166384_0001_01_000001. 


2021-11-23 10:06:57,759 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting path : 
/usr/local/hadoop-2.10.1/logs/userlogs/application_1637633166384_0001/container_1637633166384_0001_01_000001/prelaunch.err

container_1637633166384_0001_01_000001/prelaunch.err
container_1637633166384_0001_01_000001/prelaunch.out
container_1637633166384_0001_01_000001/stderr
container_1637633166384_0001_01_000001/stdout
container_1637633166384_0001_01_000001/syslog
container_1637633166384_0001_01_000002/prelaunch.err
container_1637633166384_0001_01_000002/prelaunch.out
container_1637633166384_0001_01_000002/stderr
container_1637633166384_0001_01_000002/stdout
container_1637633166384_0001_01_000002/syslog
container_1637633166384_0001_01_000003/prelaunch.err
container_1637633166384_0001_01_000003/prelaunch.out
container_1637633166384_0001_01_000003/stderr
container_1637633166384_0001_01_000003/stdout
container_1637633166384_0001_01_000003/syslog
container_1637633166384_0001_01_000004/prelaunch.err
container_1637633166384_0001_01_000004/prelaunch.out
container_1637633166384_0001_01_000004/stderr
container_1637633166384_0001_01_000004/stdout
container_1637633166384_0001_01_000004/syslog
container_1637633166384_0001_01_000005/prelaunch.err
container_1637633166384_0001_01_000005/prelaunch.out
container_1637633166384_0001_01_000005/stderr
container_1637633166384_0001_01_000005/stdout
container_1637633166384_0001_01_000005/syslog
container_1637633166384_0001_01_000006/prelaunch.err
container_1637633166384_0001_01_000006/prelaunch.out
container_1637633166384_0001_01_000006/stderr
container_1637633166384_0001_01_000006/stdout
container_1637633166384_0001_01_000006/syslog
container_1637633166384_0001_01_000007/prelaunch.err
container_1637633166384_0001_01_000007/prelaunch.out
container_1637633166384_0001_01_000007/stderr
container_1637633166384_0001_01_000007/stdout
container_1637633166384_0001_01_000007/syslog
container_1637633166384_0001_01_000008/prelaunch.err
container_1637633166384_0001_01_000008/prelaunch.out
container_1637633166384_0001_01_000008/stderr
container_1637633166384_0001_01_000008/stdout
container_1637633166384_0001_01_000008/syslog
container_1637633166384_0001_01_000009/prelaunch.err
container_1637633166384_0001_01_000009/prelaunch.out
container_1637633166384_0001_01_000009/stderr
container_1637633166384_0001_01_000009/stdout
container_1637633166384_0001_01_000009/syslog
container_1637633166384_0001_01_000010/prelaunch.err
container_1637633166384_0001_01_000010/prelaunch.out
container_1637633166384_0001_01_000010/stderr
container_1637633166384_0001_01_000010/stdout
container_1637633166384_0001_01_000010/syslog
container_1637633166384_0001_01_000010/syslog.shuffle

2021-11-23 10:06:57,759 INFO org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor: Deleting path : 
/usr/local/hadoop-2.10.1/logs/userlogs/application_1637633166384_0001

```

##### Yarn内存分配与管理

主要涉及到ResourceManage(RM)、ApplicationMatser(AM)、NodeManager(NM)

**ResourceManage(RM)的内存资源配置**

配置的是资源调度相关

RM1：yarn.scheduler.minimum-allocation-mb分配给AM单个容器可申请的最小内存

RM2：yarn.scheduler.maximum-allocation-mb分配给AM单个容器可申请的最大内存

注：minimum-allocation-mb最小值可以计算一个节点最大Container数量，一旦设置，不可动态改变

**NodeManager (NM)的内存资源配置**

配置的是硬件资源相关

NM1：yarn.nodemanager.resource.memory-mb节点最大可用内存

注： RM1、RM2的值均不能大于NM1的值，NM1可以计算节点最大Container数量，max(Container)=NM1/RM2，一旦设置，不可动态改变

**ApplicationMatser (AM)的内存配置**

配置的是任务相关

AM1：mapreduce.map.memory.mb 分配给map Container的内存大小

AM2：mapreduce.reduce.memory.mb 分配给reduce Container的内存大小

这两个值应该在RM1和RM2这两个值之间

AM2的值最好为AM1的两倍，这两个值可以在启动时改变

AM3：mapreduce.map.java.opts 运行map任务的jvm参数，如-Xmx，-Xms等选项

AM4：mapreduce.reduce.java.opts 运行reduce任务的jvm参数，如-Xmx，-Xms等选项

注：这两个值应该在AM1和AM2之间

**YARN内存最小限制和规整**

yarn.scheduler.minimum-allocation-mb

单个任务可申请的最少物理内存量，默认是1024（MB），如果一个任务申请的物理内存量少于该值，则该对应的值改为这个数

yarn.scheduler.increment-allocation-mb

内存规整化单位，默认是1024（MB），这意味着，如果一个Container请求资源是1.5GB，则将被调度器规整化为ceiling(1.5 GB / 1GB) * 1G=2GB


### YARN WEB UI

#### Cluster overview

- Cluster ID: 集群ID
- ResourceManager state: 集群ResourceManager的运行状态（STARTED表示正在运行）
- ResourceManager HA state: 只是表示ResourceManager的高可用接口正常，不表示ResourceManager已经是高可用了
- ResourceManager HA zookeeper connection state: 表示ResourceManager的高可不可用
- ResourceManager RMStateStore: 集群ResourceManager的状态保存和还原接口类
- ResourceManager started on: 集群ResourceManager的启动时间
- ResourceManager version: 集群ResourceManager的版本
- Hadoop version: 集群hadoop的版本

##### Cluster Metrics
- Apps Submitted：应用作业的提交个数。
- Apps Pending：在所有队列总等待执行的作业个数。
- Apps Running：正在运行的作业个数。
- Apps Completed：已经运行完成的作业个数。
- Containers Running：当前正在运行的容器个数。

- Memory Used：集群中所有任务所耗用的内存。
- Memory Total：yarn所能占用的最大内存(所有NodeManager管理的内存总和)。
- Memory Reserved：预留内存，防止部分应用因为需要等待少部分内存而无限期等待情况。

- VCores Used：正在运行作业所耗用的总vCPU。
- VCores Total：yarn所能占用的最大vCPU。
- VCores Reserved：预留。

##### Cluster Nodes Metrics
- Active Nodes：当前集群存活的节点个数，（其实就是NodeManager的个数）。
- Decommissioning Nodes：集群退役中的节点个数。
- Decommissioned Nodes：集群退役的节点个数。
- Lost Nodes：集群丢失的节点个数。
- Unhealthy Nodes：集群运行状况不良的节点个数。
- Rebooted Nodes：集群重启的节点个数。
- Shutdown Nodes：集群关闭的节点个数。

##### Scheduler Metrics
- Scheduler Type：集群使用的调度器类型(Apache默认Capacity，CDH默认是Fair)。
- Scheduling Resource Type：调度器资源类型。
- Minimum Allocation：一个作业的最小内存和最低vcpu数量。
- Maximum Allocation：一个作业的最大内存和最高vcpu数量。
- Maximum Cluster Application Priority：。

#### Nodes of the cluster
- Node Labels：节点标签，通过对节点打标签我们可以控制任务运行在特定的标签节点上。
- Rack：节点机器所在的机架。
- Node State：节点状态信息，Running表示运行正常。
- Node Address： NodeManager的ip地址和访问端口。
- Node HTTP Address：NodeManager的web应用HTTP访问地址(可以点进去查看该节点的信息)。
- Last health-update：节点最近心跳时间。
- Health-report：心跳报告的存储路径。
- Containers：节点内正在运行的Containers个数。
- Mem Used：节点已用内存。
- Mem Avail：节点可用内存。
- VCores Used：节点已用的vCPU数量。
- VCores Avail：节点可用的vCPU数量。
- Version：版本信息。

#### Node labels of the cluster
- Label Name：标签名
- Label Type：标签类型
- Num Of Active NMs：运行的NodeManage实例数量。
- Total Resource：内存和vCPU总资源。

#### NodeManager information
- Total Vmem allocated for Containers 55.24 TB 表示这个NodeManager管理的虚拟内存的大小，由yarn.nodemanager.vmem-pmem-ratio设置。
- Vmem enforcement enabled  false
- Total Pmem allocated for Container  11.31 GB 表示这个NodeManager管理的物理内存的大小。
- Pmem enforcement enabled  true
- Total VCores allocated for Containers 8
- NodeHealthyStatus true
- LastNodeHealthTime  Thu Nov 18 16:22:23 CST 2021
- NodeHealthReport  
- NodeManager started on  Wed Nov 03 11:14:21 CST 2021
- NodeManager Version:  2.8.5 from 4f022434ca5dbbbe671356c88edc6bda870fe80f by root source checksum a616fa5ffd7d69e81794b24b615ccd23 on 2021-07-15T08:04Z
- Hadoop Version: 2.8.5 from 4f022434ca5dbbbe671356c88edc6bda870fe80f by root source checksum ca9bc8fd8c5a7fd7356a541b68ca3c on 2021-07-15T08:02Z

#### Scheduler Application Queues

- Queue State: 队列运行状态，Running表示正常运行
- Used Capacity: 已使用资源占队列配置值的百分比
- Configured Capacity: 100.0%
- Configured Max Capacity: 配置该队列最大可使用capacity
- Absolute Used Capacity: 已使用资源占集群的百分比
- Absolute Configured Capacity: 100.0% queue 至少可以使用系统资源占集群的百分比
- Absolute Configured Max Capacity: 100.0% queue 最多可以使用系统资源占集群的百分比
- Used Resources: 已使用的memory和vCPU数
- Configured Max Application Master Limit：50.0
- Max Application Master Resources: 该queue使用的最大的内存和core
- Used Application Master Resources: 该queue已经被使用的内存和core
- Max Application Master Resources Per User:每个user最多可以使用该queue的最大内存和core
- Num Schedulable Applications: 正在被调度的app应用个数
- Num Non-Schedulable Applications: 没有被调度的app应用个数
- Num Containers: 已启用的container容器数量
- Max Applications: 最大可运行的应用数量（处于pending和running状态的）
- Max Applications Per User: 每个user最多可以运行的应用数量
- Configured Minimum User Limit Percent: 每个user最多可以使用队列资源的百分比
- Configured User Limit Factor: 队列中的用户允许占用队列值的多少，默认值是0.0\~1。如果将值设置为1，它代表：最大可以占用整个队列资源，如果将值设置为2，它代表：允许队列所占资源增长到最多为队列容量的两倍。
- Accessible Node Labels: 标记节点
- Ordering Policy:  FifoOrderingPolicy
- Preemption: 多用户是否抢占队列
- Intra-queue Preemption: disabled
- Default Node Label Expression:  <DEFAULT_PARTITION>
- Default Application Priority: 0


#### Applications

在实际工作中NEW、NEW_SAVING、SUBMITTED这三个用到的概率还是非常低的，而ACCEPTED、RUNNING、FINISHED、FAILE、KILLED这五个那是经常使用的。

- ACCEPTED：接受状态，已经被队列（queue）接受，但是还没有开始执行。如果生产中有任务一直停留在这个状态，那就可能是队列资源是不充足。
- RUNNING：运行状态，表示集群资源正在计算
- FINISHED：完成状态，表示任务运行完成，但运行的任务也可能失败。
- FAILE：失败状态，表示任务运行失败
- KILLED：被杀死状态，这个一般都是人为强制kill的。

**Application 列表**

- ID：当前应用的ID
- User：提交应用的用户
- Name：作业内容（sql语句）
- Application Type：计算引擎类型（mapreduce、tez、spark）
- Queue：应用所提交的队列
- Application Priority：
- Start Time：应用执行的开始时间
- Finish Time：应用执行完成时间
- State：当前应用的状态
- FinalStatus：当前应用的最终状态
- Running Containers：
- Allocated CPU VCores：
- Allocated Memory MB：
- % of Queue：
- % of Cluster：
- Progress：运行时候显示的进度条
- Tracking UI：历史追踪连接(点进去能够显示当前应用的详细信息)
- Blacklisted Nodes：黑名单节点

**Application Overview**

- User: anonymous 用户名
- Name: HIVE-ca01928e-78f7-4b0a-bc9c-46b10d7c0b01 应用名称
- Application Type: TEZ 应用类型
- Application Tags:  应用标签
- Application Priority: 0 (Higher Integer value indicates higher priority)
- YarnApplicationState: FINISHED
- Queue:  default 所在队列
- FinalStatus Reported by AM: ENDED
- Started:  Fri Nov 19 09:34:33 +0800 2021
- Elapsed:  29mins, 46sec 任务总耗时
- Tracking URL: History
- Log Aggregation Status: SUCCEEDED
- Diagnostics:  
- Session stats:submittedDAGs=196, successfulDAGs=196, failedDAGs=0, killedDAGs=0
- Unmanaged Application:  false
- Application Node Label expression:  <Not set>
- AM container Node Label expression: <DEFAULT_PARTITION>

**Application Metrics**

- Total Resource Preempted: <memory:0, vCores:0>
- Total Number of Non-AM Containers Preempted:  0
- Total Number of AM Containers Preempted:  0
- Resource Preempted from Current Attempt:  <memory:0, vCores:0>
- Number of Non-AM Containers Preempted from Current Attempt: 0
- Aggregate Resource Allocation:  7351133 MB-seconds, 3010 vcore-seconds
- Aggregate Preempted Resource Allocation:  0 MB-seconds, 0 vcore-seconds

**Application Attempt 列表**

- Attempt ID：appattempt_1635995641146_96871_000001
- Started：Fri Nov 19 09:34:33 +0800 2021
- Node：http://emr-worker-1.cluster-245192:8042
- Logs：链接
- Nodes blacklisted by the app：0
- Nodes blacklisted by the system：0

**Application Attempt Overview**

- Application Attempt State:  FINISHED
- Started:  Fri Nov 19 09:34:33 +0800 2021
- Elapsed:  29mins, 46sec
- AM Container: container_1635995641146_96871_01_000001
- Node: emr-worker-1.cluster-245192:44763
- Tracking URL: History
- Diagnostics Info: 
- Session stats:submittedDAGs=196, successfulDAGs=196, failedDAGs=0, killedDAGs=0
- Nodes blacklisted by the application: -
- Nodes blacklisted by the system:  -

**Total Allocated Containers**

Each table cell represents the number of NodeLocal/RackLocal/OffSwitch containers satisfied by NodeLocal/RackLocal/OffSwitch resource requests.

Node Local Request
Rack Local Request  
Off Switch Request

Num Node Local Containers (satisfied by)  
Num Rack Local Containers (satisfied by)  
Num Off Switch Containers (satisfied by) 

Container ID
Node
Container Exit Status
Logs


##### MapReduce Job
- Job Name: select `(event_time|u...d="3060665fecdd5638"(Stage-1) 任务名，具体sql
- User Name:  anonymous 用户名
- Queue:  default 所在队列
- State:  KILLED
- Uberized: false 表示非Uber运行模式
- Submitted:  Fri Nov 19 09:43:04 CST 2021 任务提交时间
- Started:  Fri Nov 19 09:43:08 CST 2021 任务开始时间
- Finished: Fri Nov 19 09:44:58 CST 2021 任务结束时间
- Elapsed:  1mins, 49sec 任务耗时
- Diagnostics:  Kill job job_1635995641146_96873 received from anonymous (auth:SIMPLE) at 172.16.2.39 Job received Kill while in RUNNING state.

**ApplicationMaster**

- Attempt Number:1 
- Start Time:Fri Nov 19 09:43:05 CST 2021
- Node:emr-worker-1.cluster-245192:8042
- Logs:https://knox.c-ea6d16b4b97d9b7a.cn-hangzhou.emr.aliyuncs.com:8443/gateway/jobhistoryui/jobhistory/logs

Task Type Total Complete
Map 1 0
Reduce  0 0

Attempt Type  Failed  Killed  Successful
Maps  0 1 0
Reduces 0 0 0

**Counters**

Counters：作业计数器，表示mr作业在Input,Map,Shuffle,Reduce,Output等各个阶段的定量数据，我们能够非常直观的看到任务处理的数据量，处理耗时和使用资源，这个非常有利于开发定位问题和后期性能优化

1. File System Counters：文件系统计数器
  + FILE: Number of bytes read：表示一个作业各阶段读取本地文件的数据量
  + FILE: Number of bytes written：表示一个作业各阶段写入本地文件的数据量
  + FILE: Number of large read operations
  + FILE: Number of read operations：表示一个作业内读取本地文件的次数，读取本地文件一般只发生在reduce阶段读取数据操作（如果数据源来自本地那么map阶段会被统计到）
  + FILE: Number of write operations：表示一个作业写入本地文件次数，写入本地文件发生在shuffle阶段，还有reduce拉取数据阶段。
  + HDFS: Number of bytes read：表示一个作业各阶段读取HDFS文件的数据量
  + HDFS: Number of bytes written：表示一个作业各阶段写入HDFS文件的数据量
  + HDFS: Number of large read operations
  + HDFS: Number of read operations：表示一个作业内读取HDFS的次数，读取HDFS操作都是在map阶段，所以读取次数等于所操作表在Hdfs中的文件个数。
  + HDFS: Number of write operations：表示一个作业写入HDFS的次数，写HDFS操作一般只发生在reduce阶段，所以写入次数就等于HDFS 的文件个数。
2. Job Counters：作业计数器
  + Launched map tasks  0 0 1
  + Launched reduce tasks
  + Rack-local map tasks  0 0 1
  + Total megabyte-milliseconds taken by all map tasks  0 0 5,693,536
  + otal megabyte-milliseconds taken by all reduce tasks
  + Total time spent by all map tasks (ms)  0 0 3,932
  + Total time spent by all maps in occupied slots (ms) 0 0 180,872
  + Total time spent by all reduce tasks (ms)
  + Total time spent by all reduces in occupied slots (ms) 
  + Total vcore-milliseconds taken by all map tasks
  + Total vcore-milliseconds taken by all reduce tasks
3. Map-Reduce Framework：MapReduce框架计数器
  + Combine input records Combine阶段输入记录数
  + Combine output records Combine阶段输出记录数
  + CPU time spent (ms) 1,890 0 1,890
  + Failed Shuffles 0 0 0
  + GC time elapsed (ms)  92  0 92
  + Input split bytes 输入分片大小
  + Map input records 输入记录数
  + Map output records 输出记录数
  + Merged Map outputs  合并输出记录数
  + Physical memory (bytes) snapshot 各阶段物理内存使用量
  + Reduce input groups 0 1 1
  + Reduce input records  0 1 1
  + Reduce output records 0 0 0
  + Reduce shuffle bytes  0 27  27
  + Shuffled Maps
  + Spilled Records 溢出到磁盘的记录数
  + Total committed heap usage (bytes)  373,293,056 0 373,293,056
  + Virtual memory (bytes) snapshot 虚拟内存使用量
4. HIVE：hive计数器
  + CREATED_FILES hive 任务结束后创建的文件数
  + DESERIALIZE_ERRORS 序列化错误数
  + RECORDS_IN hive 任务输入量
  + RECORDS_OUT_1_default.xxx 任务结束输出记录数
  + RECORDS_OUT_0 输出记录数
  + RECORDS_OUT_INTERMEDIATE 输出记录数
5. Shuffle Errors：shuffle错误计数器
  + BAD_ID  0 0 0
  + CONNECTION  0 0 0
  + IO_ERROR  0 0 0
  + WRONG_LENGTH  0 0 0
  + WRONG_MAP 0 0 0
  + WRONG_REDUCE  0 0 0
6. File Input Format Counters：文件输入格式的计数器
  + Bytes Read
7. File Output Format Counters：文件输出格式计数器
  + Bytes Written

**Configuration**

任务提交的时候的xml配置文件，里面都是一些相关的参数配置。

**Map Tasks**

- Task Name：task_1635995641146_96873_m_000000
- Task State：FAILED
- Task Start Time：Fri Nov 19 09:43:11 +0800 2021
- Task Finish Time：Fri Nov 19 09:44:58 +0800 2021
- Task Elapsed Time：1mins, 47sec
- Successful Attempt Start Time：N/A
- Successful Attempt Finish Time：N/A
- Successful Attempt Elapsed Time：N/A

**Reduce Tasks**

- Task Name：task_1635995641146_96873_m_000000
- Task State：FAILED
- Task Start Time：Fri Nov 19 09:43:11 +0800 2021
- Task Finish Time：Fri Nov 19 09:44:58 +0800 2021
- Task Elapsed Time：1mins, 47sec
- Successful Attempt Start Time：N/A
- Successful Attempt Shuffle Finish Time
- Successful Attempt Merge Finish Time
- Successful Attempt Finish Time：N/A
- Successful Attempt Elapsed Time Shuffle
- Successful Attempt Elapsed Time Merge
- Successful Attempt Elapsed Time Reduce
- Successful Attempt Elapsed Time：N/A

##### Tez


### YARN 配置

```yarn-env.sh
yarn_resourcemanager_opts
yarn_proxy_heapsize 512
yarn_nodemanager_heapsize 1536
yarn_nodemanager_opts
yarn_resourcemanager_heapsize 2304
yarn_proxyserver_opts
yarn_timelineserver_opts
yarn_timelineserver_heapsize 512

```
```yarn-site.xml
am.liveness-monitor.expiry-interval-ms 600000

yarn.acl.enable false
yarn.admin.acl has
yarn.am.liveness-monitor.expiry-interval-ms 600000
yarn.app.mapreduce.am.labels CORE

yarn.application.classpath $HADOOP_CONF_DIR,$HADOOP_COMMON_HOME/share/hadoop/common/*,$HADOOP_COMMON_HOME/share/hadoop/common/lib/*,$HADOOP_HDFS_HOME/share/hadoop/hdfs/*,$HADOOP_HDFS_HOME/share/hadoop/hdfs/lib/*,$HADOOP_YARN_HOME/share/hadoop/yarn/*,$HADOOP_YARN_HOME/share/hadoop/yarn/lib/*,/opt/apps/extra-jars/*,$HADOOP_HOME/share/hadoop/tools/lib/*

yarn.client.application-client-protocol.poll-interval-ms 200
yarn.client.failover-proxy-provider org.apache.hadoop.yarn.client.ConfiguredRMFailoverProxyProvider

yarn.dispatcher.drain-events.timeout 300000
yarn.dispatcher.exit-on-error true

yarn.fail-fast false
yarn.label.enabled true

yarn.log-aggregation-enable true
yarn.log-aggregation.retain-seconds 604800
yarn.log.server.url http://emr-header-1.cluster-245192:19888/jobhistory/logs

yarn.nm.liveness-monitor.expiry-interval-ms 600000

yarn.nodemanager.aux-services mapreduce_shuffle,spark_shuffle
yarn.nodemanager.aux-services.spark_shuffle.class org.apache.spark.network.yarn.YarnShuffleService
yarn.nodemanager.bind-host 0.0.0.0
yarn.nodemanager.container-executor.class org.apache.hadoop.yarn.server.nodemanager.DefaultContainerExecutor
yarn.nodemanager.container-manager.thread-count 20
yarn.nodemanager.container-metrics.enable false
yarn.nodemanager.container-monitor.interval-ms 3000
yarn.nodemanager.delete.debug-delay-sec 0
yarn.nodemanager.delete.thread-count 4
yarn.nodemanager.disk-health-checker.max-disk-utilization-per-disk-percentage 90.0
yarn.nodemanager.disk-health-checker.min-free-space-per-disk-mb 0
yarn.nodemanager.disk-health-checker.min-healthy-disks 0.25
yarn.nodemanager.labels MASTER

yarn.nodemanager.local-dirs {% set comma = joiner(',') %}{% for idx in range(diskCnt) -%}{% if idx+1 not in faulty -%}{{ comma() }}file:///mnt/disk{{ idx + 1 }}/yarn{% endif %}{% endfor %}

yarn.nodemanager.localizer.client.thread-count 5
yarn.nodemanager.localizer.fetch.thread-count 4

yarn.nodemanager.log-dirs {% set comma = joiner(',') %}{% for idx in range(diskCnt) -%}{% if idx+1 not in faulty -%}{{ comma() }}file:///mnt/disk{{ idx + 1 }}/log/hadoop-yarn/containers{% endif %}{% endfor %}

yarn.nodemanager.process-kill-wait.ms 2000
yarn.nodemanager.remote-app-log-dir hdfs://emr-header-1.cluster-245192:9000/tmp/logs
yarn.nodemanager.resource.cpu-vcores 8
# 集群中某个计算节点分配给nodemanager的最大可用内存，这个最大可用内存不是该节点最大内存，而是该节点最大内存划分出来的给nodemanager使用的内存。
yarn.nodemanager.resource.memory-mb 11584
yarn.nodemanager.sleep-delay-before-sigkill.ms 250
yarn.nodemanager.vmem-check-enabled false
# 虚拟内存的比例，默认是2.1，即每使用1G物理内存，分配2.1的虚拟内存。
yarn.nodemanager.vmem-pmem-ratio 5000

yarn.resourcemanager.address emr-header-1.cluster-245192:8032
yarn.resourcemanager.am.max-attempts 2
yarn.resourcemanager.amlauncher.thread-count 50
yarn.resourcemanager.bind-host 0.0.0.0
yarn.resourcemanager.client.thread-count 50
yarn.resourcemanager.connect.max-wait.ms 900000
yarn.resourcemanager.connect.retry-interval.ms 30000
yarn.resourcemanager.container.liveness-monitor.interval-ms 600000
yarn.resourcemanager.ha.automatic-failover.embedded true
yarn.resourcemanager.ha.automatic-failover.enabled true
yarn.resourcemanager.hostname 0.0.0.0
yarn.resourcemanager.max-completed-applications 10000
yarn.resourcemanager.nodemanager-connect-retries 10
yarn.resourcemanager.nodemanagers.heartbeat-interval-ms 1000
yarn.resourcemanager.nodes.exclude-path /etc/ecm/hadoop-conf/yarn.exclude
yarn.resourcemanager.proxy-user-privileges.enabled false
yarn.resourcemanager.recovery.enabled false
yarn.resourcemanager.resource-tracker.address emr-header-1.cluster-245192:8025
yarn.resourcemanager.resource-tracker.client.thread-count 64
yarn.resourcemanager.scheduler.address emr-header-1.cluster-245192:8030
yarn.resourcemanager.scheduler.class org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler
yarn.resourcemanager.scheduler.client.thread-count 50
yarn.resourcemanager.store.class org.apache.hadoop.yarn.server.resourcemanager.recovery.ZKRMStateStore
yarn.resourcemanager.system-metrics-publisher.enabled true
yarn.resourcemanager.webapp.address emr-header-1.cluster-245192:8088
yarn.resourcemanager.zk-timeout-ms 60000

yarn.scheduler.fair.allocation.file /etc/ecm/hadoop-conf/fair-scheduler.xml
yarn.scheduler.fair.allow-undeclared-pools true
yarn.scheduler.fair.assignmultiple false
yarn.scheduler.fair.dynamic.max.assign true
yarn.scheduler.fair.locality.threshold.node -1.0
yarn.scheduler.fair.locality.threshold.rack -1.0
yarn.scheduler.fair.max.assign -1
yarn.scheduler.fair.preemption false
yarn.scheduler.fair.preemption.cluster-utilization-threshold 0.8f
yarn.scheduler.fair.sizebasedweight false
yarn.scheduler.fair.update-interval-ms 500
yarn.scheduler.fair.user-as-default-queue false
yarn.scheduler.increment-allocation-mb 1024
yarn.scheduler.increment-allocation-vcores 1
# 指定单个容器(container)可申请的最大内存资源，
yarn.scheduler.maximum-allocation-mb 11584
yarn.scheduler.maximum-allocation-vcores 32
# 指定单个容器(container)可申请的最小内存资源，
yarn.scheduler.minimum-allocation-mb 32

yarn.timeline-service.bind-host 0.0.0.0
yarn.timeline-service.enabled true
yarn.timeline-service.hostname emr-header-1.cluster-245192
yarn.timeline-service.http-cross-origin.enabled true
yarn.timeline-service.store-class org.apache.hadoop.yarn.server.timeline.RollingLevelDBTimelineStore

yarn.web-proxy.address emr-header-1.cluster-245192:20888
```

```mapred-env.sh
jobhistory_heapsize 512

hadoop_job_historyserver_opts -javaagent:/var/lib/ecm-agent/data/jmxetric-1.0.8.jar=host=localhost,port=8649,mode=unicast,wireformat31x=true,process=YARN_JobHistory,config=/var/lib/ecm-agent/data/jmxetric.xml -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=128M -Xloggc:${YARN_LOG_DIR}/jobhistory-gc.log

```

```mapred-site.xml
map.sort.class org.apache.hadoop.util.QuickSort

mapred.local.dir {% set comma = joiner(',') %}{% for idx in range(diskCnt) -%}{% if idx+1 not in faulty -%}{{ comma() }}file:///mnt/disk{{ idx + 1 }}/mapred/local{% endif %}{% endfor %}

mapreduce.am.max-attempts 2

mapreduce.application.classpath $HADOOP_MAPRED_HOME/share/hadoop/mapreduce/*,$HADOOP_MAPRED_HOME/share/hadoop/mapreduce/lib/*,/usr/lib/hadoop-lzo/lib/*

mapreduce.cluster.acls.enabled false
mapreduce.cluster.local.dir {% set comma = joiner(',') %}{% for idx in range(diskCnt) -%}{% if idx+1 not in faulty -%}{{ comma() }}file:///mnt/disk{{ idx + 1 }}/mapred/local{% endif %}{% endfor %}

mapreduce.cluster.temp.dir ${hadoop.tmp.dir}/mapred/temp
mapreduce.framework.name yarn

mapreduce.job.acl-modify-job
mapreduce.job.acl-view-job
mapreduce.job.classloader false
mapreduce.job.counters.max 1000
mapreduce.job.jvm.numtasks 20
mapreduce.job.log4j-properties-file
mapreduce.job.maps 16
mapreduce.job.queuename default
mapreduce.job.reducer.preempt.delay.sec 0
mapreduce.job.reduces 7
mapreduce.job.running.map.limit 0
mapreduce.job.running.reduce.limit 0
mapreduce.job.tags
mapreduce.job.userlog.retain.hours 48

# Jobhistory 历史服务器
mapreduce.jobhistory.address emr-header-1.cluster-245192:10020
mapreduce.jobhistory.admin.acl *
mapreduce.jobhistory.admin.address emr-header-1.cluster-245192:10033
mapreduce.jobhistory.http.policy HTTP_ONLY
mapreduce.jobhistory.recovery.enable false
mapreduce.jobhistory.recovery.store.class org.apache.hadoop.mapreduce.v2.hs.HistoryServerFileSystemStateStoreService
mapreduce.jobhistory.recovery.store.fs.uri ${hadoop.tmp.dir}/mapred/history/recoverystore
mapreduce.jobhistory.store.class
mapreduce.jobhistory.webapp.address emr-header-1.cluster-245192:19888
mapreduce.jobtracker.addressemr-header-1.cluster-245192:8021
mapreduce.jobtracker.http.address emr-header-1.cluster-245192:50030
mapreduce.jobtracker.jobhistory.location
mapreduce.jobtracker.restart.recover false
mapreduce.jobtracker.taskscheduler org.apache.hadoop.mapred.JobQueueTaskScheduler

mapreduce.map.cpu.vcores 1
# 在map阶段的yarnchild进程执行jvm参数，必须小于mapreduce.map.memory.mb，取代mapred.child.java.opts
mapreduce.map.java.opts -Xmx1158m -XX:ParallelGCThreads=2 -XX:CICompilerCount=2
mapreduce.map.log.level INFO
# 指定 map 任务时申请的内存
mapreduce.map.memory.mb 1448
mapreduce.map.output.compress true
mapreduce.map.output.compress.codec org.apache.hadoop.io.compress.DefaultCodec
mapreduce.map.sort.spill.percent 0.8
mapreduce.map.speculative true

mapreduce.output.fileoutputformat.compress false
mapreduce.output.fileoutputformat.compress.codec org.apache.hadoop.io.compress.DefaultCodec
mapreduce.output.fileoutputformat.compress.type BLOCK
mapreduce.outputcommitter.class com.aliyun.emr.fs.oss.commit.JindoOssCommitter

mapreduce.reduce.cpu.vcores 1
# 在reduce阶段的yarnchild进程执行jvm参数， 必须小于mapreduce.reduce.memory.mb，取代mapred.child.java.opts
mapreduce.reduce.java.opts -Xmx2316m -XX:ParallelGCThreads=2 -XX:CICompilerCount=2
mapreduce.reduce.log.level INFO
# 指定 reduce 任务时申请的内存
mapreduce.reduce.memory.mb 2896
mapreduce.reduce.shuffle.parallelcopies 20
mapreduce.reduce.speculative true

mapreduce.shuffle.manage.os.cache false
mapreduce.shuffle.max.connections 0
mapreduce.shuffle.max.threads 0
mapreduce.shuffle.port 13562
mapreduce.shuffle.ssl.enabled false
mapreduce.shuffle.transfer.buffer.size 131072
mapreduce.shuffle.transferTo.allowed

mapreduce.task.io.sort.factor 48
mapreduce.task.io.sort.mb 200
mapreduce.task.timeout 600000

mapreduce.tasktracker.group
mapreduce.tasktracker.http.address emr-header-1.cluster-245192:50060
mapreduce.tasktracker.http.threads 60
mapreduce.tasktracker.map.tasks.maximum 1
mapreduce.tasktracker.reduce.tasks.maximum 1
mapreduce.tasktracker.taskcontroller org.apache.hadoop.mapred.DefaultTaskController

yarn.app.mapreduce.am.admin.user.env
yarn.app.mapreduce.am.command-opts -Xmx2316m
yarn.app.mapreduce.am.env
yarn.app.mapreduce.am.jhs.backup-dir file:///mnt/disk1/log/hadoop-mapreduce/history
yarn.app.mapreduce.am.jhs.backup.enabled true
yarn.app.mapreduce.am.job.task.listener.thread-count 60
yarn.app.mapreduce.am.resource.cpu-vcores 1
# 指定appMaster的运行内存，默认是1.5G。必须小于 yarn.scheduler.maximum-allocation-mb。
yarn.app.mapreduce.am.resource.mb 2896
yarn.app.mapreduce.am.staging-dir /tmp/hadoop-yarn/staging
yarn.app.mapreduce.client.job.max-retries 0
```

```xml capacity-scheduler
<configuration>
  <property>
    <name>yarn.scheduler.capacity.maximum-applications</name>
    <value>10000</value>
    <description>Maximum number of applications that can be pending and running.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.maximum-am-resource-percent</name>
    <value>0.25</value>
    <description>Maximum percent of resources in the cluster which can be used to run application masters i.e. controls number of concurrent running applications.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.resource-calculator</name>
    <value>org.apache.hadoop.yarn.util.resource.DefaultResourceCalculator</value>
    <description>The ResourceCalculator implementation to be used to compare Resources in the scheduler.The default i.e. DefaultResourceCalculator only uses Memory while DominantResourceCalculator uses dominant-resource to compare multi-dimensional resources such as Memory, CPU etc.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.queues</name>
    <value>default</value>
    <description>The queues at the this level (root is the root queue).</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.default.capacity</name>
    <value>100</value>
    <description>Default queue target capacity.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.default.user-limit-factor</name>
    <value>1</value>
    <description>Default queue user limit a percentage from 0.0 to 1.0.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.default.maximum-capacity</name>
    <value>100</value>
    <description>The maximum capacity of the default queue.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.default.state</name>
    <value>RUNNING</value>
    <description>The state of the default queue. State can be one of RUNNING or STOPPED.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.default.acl_submit_applications</name>
    <value>*</value>
    <description>The ACL of who can submit jobs to the default queue.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.root.default.acl_administer_queue</name>
    <value>*</value>
    <description>The ACL of who can administer jobs on the default queue.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.node-locality-delay</name>
    <value>-1</value>
    <description>Number of missed scheduling opportunities after which the CapacityScheduler attempts to schedule rack-local containers. Typically this should be set to number of nodes in the cluster.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.queue-mappings</name>
    <value></value>
    <description>A list of mappings that will be used to assign jobs to queues. The syntax for this list is [u|g]:[name]:[queue_name][,next mapping]* Typically this list will be used to map users to queues,for example, u:%user:%user maps all users to queues with the same name as the user.</description>
  </property>
  <property>
    <name>yarn.scheduler.capacity.queue-mappings-override.enable</name>
    <value>false</value>
    <description>If a queue mapping is present, will it override the value specified by the user? This can be used by administrators to place jobs in queues that are different than the one specified by the user. The default is false.</description>
  </property>
</configuration>
```

```xml fair-scheduler
<allocations>
  <queue name="root">
    <minResources>10000 mb,10 vcores</minResources>
    <maxRunningApps>50</maxRunningApps>
    <maxAMShare>0.5f</maxAMShare>
    <weight>2.0</weight>
    <schedulingPolicy>fair</schedulingPolicy>
    <aclSubmitApps>*</aclSubmitApps>
    <aclAdministerApps>*</aclAdministerApps>
    <allowPreemptionFrom>true</allowPreemptionFrom>
    <queue name="default">
      <aclSubmitApps>*</aclSubmitApps>
      <minResources>10000 mb,10vcores</minResources>
    </queue>
  </queue>
  <userMaxAppsDefault>50</userMaxAppsDefault>
  <queueMaxAMShareDefault>0.5</queueMaxAMShareDefault>
  <queueMaxAppsDefault>50</queueMaxAppsDefault>
  <defaultQueueSchedulingPolicy>fair</defaultQueueSchedulingPolicy>
</allocations>
```

### YARN CLI
```shell
start-yarn.sh

yarn-daemon.sh start nodemanager
yarn-daemon.sh start resourcemanager
yarn-daemon.sh stop nodemanager
yarn-daemon.sh stop resourcemanager
```

#### YARN 使用
```shell
yarn --help

yarn application -help
yarn application -list -appStates ALL -appTypes <Types>
yarn application -appId <Application ID>
yarn application -kill <Application ID>
yarn application -status <Application ID>

yarn logs
yarn logs -applicationId <application ID> -containerId  <Container ID>

yarn cluster -h
yarn cluster -lnl
```

``` help
Usage: yarn [--config confdir] [COMMAND | CLASSNAME]
  CLASSNAME                             run the class named CLASSNAME
 or
  where COMMAND is one of:
  resourcemanager                       run the ResourceManager
                                        Use -format-state-store for deleting the RMStateStore.
                                        Use -remove-application-from-state-store <appId> for
                                            removing application from RMStateStore.
  nodemanager                           run a nodemanager on each slave
  timelineserver                        run the timeline server
  rmadmin                               admin tools
  sharedcachemanager                    run the SharedCacheManager daemon
  scmadmin                              SharedCacheManager admin tools
  version                               print the version
  jar <jar>                             run a jar file
  application                           prints application(s)
                                        report/kill application
  applicationattempt                    prints applicationattempt(s)
                                        report
  container                             prints container(s) report
  node                                  prints node report(s)
  queue                                 prints queue information
  logs                                  dump container logs
  classpath                             prints the class path needed to
                                        get the Hadoop jar and the
                                        required libraries
  cluster                               prints cluster information
  daemonlog                             get/set the log level for each
                                        daemon
  top                                   run cluster usage tool

Most commands print help when invoked w/o parameters.


usage: application
 -appId <Application ID>         Specify Application Id to be operated
 -appStates <States>             Works with -list to filter applications
                                 based on input comma-separated list of
                                 application states. The valid application
                                 state can be one of the following:
                                 ALL,NEW,NEW_SAVING,SUBMITTED,ACCEPTED,RUN
                                 NING,FINISHED,FAILED,KILLED
 -appTypes <Types>               Works with -list to filter applications
                                 based on input comma-separated list of
                                 application types.
 -help                           Displays help for all commands.
 -kill <Application ID>          Kills the application. Set of
                                 applications can be provided separated
                                 with space
 -list                           List applications. Supports optional use
                                 of -appTypes to filter applications based
                                 on application type, and -appStates to
                                 filter applications based on application
                                 state.
 -movetoqueue <Application ID>   Moves the application to a different
                                 queue.
 -queue <Queue Name>             Works with the movetoqueue command to
                                 specify which queue to move an
                                 application to.
 -status <Application ID>        Prints the status of the application.
 -updatePriority <Priority>      update priority of an application.
                                 ApplicationId can be passed using 'appId'
                                 option.


usage: yarn logs -applicationId <application ID> [OPTIONS]
general options are:
 -am <AM Containers>             Prints the AM Container logs for this
                                 application. Specify comma-separated
                                 value to get logs for related AM
                                 Container. For example, If we specify -am
                                 1,2, we will get the logs for the first
                                 AM Container as well as the second AM
                                 Container. To get logs for all AM
                                 Containers, use -am ALL. To get logs for
                                 the latest AM Container, use -am -1. By
                                 default, it will only print out syslog.
                                 Work with -logFiles to get other logs
 -appOwner <Application Owner>   AppOwner (assumed to be current user if
                                 not specified)
 -containerId <Container ID>     ContainerId. By default, it will only
                                 print syslog if the application is
                                 runing. Work with -logFiles to get other
                                 logs.
 -help                           Displays help for all commands.
 -logFiles <Log File Name>       Work with -am/-containerId and specify
                                 comma-separated value to get specified
                                 container log files. Use "ALL" to fetch
                                 all the log files for the container.
 -nodeAddress <Node Address>     NodeAddress in the format nodename:port


usage: yarn cluster
 -dnl,--directly-access-node-label-store   This is DEPRECATED, will be
                                           removed in future releases.
                                           Directly access node label
                                           store, with this option, all
                                           node label related operations
                                           will NOT connect RM. Instead,
                                           they will access/modify stored
                                           node labels directly. By
                                           default, it is false (access
                                           via RM). AND PLEASE NOTE: if
                                           you configured
                                           yarn.node-labels.fs-store.root-
                                           dir to a local directory
                                           (instead of NFS or HDFS), this
                                           option will only work when the
                                           command run on the machine
                                           where RM is running. Also, this
                                           option is UNSTABLE, could be
                                           removed in future releases.
 -h,--help                                 Displays help for all commands.
 -lnl,--list-node-labels                   List cluster node-label
                                           collection
```


### YARN 高阶使用

##### YARN 授权

YARN的授权根据授权实体，可以分为服务级别的授权、队列级别的授权。

**服务级别的授权**

- 控制特定用户访问集群服务，例如提交作业。
- 配置在hadoop-policy.xml。
- 服务级别的权限校验在其他权限校验之前（例如，HDFS的permission检查或Yarn提交作业到队列控制）。

说明 通常设置了HDFS permission检查或Yarn队列资源控制，可以不设置服务级别的授权控制，您可以根据自己需求进行相关配置。

**队列级别的授权**

YARN可以通过队列对资源进行授权管理，有Capacity Scheduler和Fair Scheduler两种队列调度。

这里以Capacity Scheduler为例。

队列也有两个级别的授权，一个是提交作业到队列的授权，一个是管理队列的授权。

说明

- 队列的ACL的控制对象为user或group，设置相关参数时，user和group可以同时设置，中间用空格分开，user/group内部可用逗号分开，只有一个空格表示任何人都没有权限。
- 队列ACL继承：如果一个user或group可以向某个队列中提交应用程序，则它可以向它的所有子队列中提交应用程序，同理管理队列的ACL也具有继承性。所以如果要防止某个user或group提交作业到某个队列，则需要设置该队列以及该队列的所有父队列的ACL来限制该user/group的提交作业的权限。

yarn.acl.enable ACL开关，设置为true。
yarn.admin.acl Yarn的管理员设置。例如，可以执行yarn rmadmin/yarn kill等命令时，该值必须配置，否则后续的队列相关的ACL管理员设置无法生效。
如上备注，配置值时可以设置user或group。
user1,user2 group1,group2 #user和group用空格隔开。
  group1,group2 #只有group情况下，必须在最前面加上空格。

EMR集群中需将has配置为admin的ACL权限。

yarn.scheduler.capacity.${queue-name}.acl_submit_applications

设置能够向该队列提交的user或group。

其中${queue-name}为队列的名称，可以是多级队列，注意多级情况下的ACL继承机制。

```xml
#queue-name=root
  <property>
      <name>yarn.scheduler.capacity.root.acl_submit_applications</name>
      <value> </value> #空格表示任何人都无法往root队列提交作业。
  </property>
 #queue-name=root.testqueue
 <property>
   <name>yarn.scheduler.capacity.root.testqueue.acl_submit_applications</name>
      <value>test testgrp</value> #testqueue只允许test用户或testgrp组提交作业。
  </property>
```

yarn.scheduler.capacity.${queue-name}.acl_administer_queue

设置某些user或group管理队列，例如终止队列中作业等。

queue-name可以是多级，注意多级情况下的ACL继承机制。

```xml
#queue-name=root
  <property>
      <name>yarn.scheduler.capacity.root.acl_administer_queue</name>
      <value> </value>
  </property>
 #queue-name=root.testqueue
 <property>
   <name>yarn.scheduler.capacity.root.testqueue.acl_administer_queue</name>
      <value>test testgrp</value>
  </property>
```

**重启YARN服务**

对于Kerberos安全集群已经默认开启ACL，用户可以根据自己需求配置队列的相关ACL权限控制。
对于非Kerberos安全集群根据上述开启ACL并配置好队列的权限控制，重启YARN服务。

**配置示例**

- yarn-site.xml
  yarn.acl.enable true
  yarn.admin.acl  has

- capacity-scheduler.xml
- default队列：禁用default队列，不允许任何用户提交或管理。
- q1队列：只允许test用户提交作业以及管理队列（如 kill）。
- q2队列：只允许foo用户提交作业以及管理队列。

```xml
<configuration>
    <property>
        <name>yarn.scheduler.capacity.maximum-applications</name>
        <value>10000</value>
        <description>Maximum number of applications that can be pending and running.</description>
    </property>
    <property>
        <name>yarn.scheduler.capacity.maximum-am-resource-percent</name>
        <value>0.25</value>
        <description>Maximum percent of resources in the cluster which can be used to run application masters i.e.
            controls number of concurrent running applications.
        </description>
    </property>
    <property>
        <name>yarn.scheduler.capacity.resource-calculator</name>
        <value>org.apache.hadoop.yarn.util.resource.DefaultResourceCalculator</value>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.queues</name>
        <value>default,q1,q2</value>
        <!-- 3个队列-->
        <description>The queues at the this level (root is the root queue).</description>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.default.capacity</name>
        <value>0</value>
        <description>Default queue target capacity.</description>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.default.user-limit-factor</name>
        <value>1</value>
        <description>Default queue user limit a percentage from 0.0 to 1.0.</description>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.default.maximum-capacity</name>
        <value>100</value>
        <description>The maximum capacity of the default queue.</description>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.default.state</name>
        <value>STOPPED</value>
        <!-- default队列状态设置为STOPPED-->
        <description>The state of the default queue. State can be one of RUNNING or STOPPED.</description>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.default.acl_submit_applications</name>
        <value> </value>
        <!-- default队列禁止提交作业-->
        <description>The ACL of who can submit jobs to the default queue.</description>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.default.acl_administer_queue</name>
        <value> </value>
        <!-- 禁止管理default队列-->
        <description>The ACL of who can administer jobs on the default queue.</description>
    </property>
    <property>
        <name>yarn.scheduler.capacity.node-locality-delay</name>
        <value>40</value>
    </property>
    <property>
        <name>yarn.scheduler.capacity.queue-mappings</name>
        <value>u:test:q1,u:foo:q2</value>
        <!-- 队列映射，test用户自动映射到q1队列-->
        <description>A list of mappings that will be used to assign jobs to queues. The syntax for this list is
            [u|g]:[name]:[queue_name][,next mapping]* Typically this list will be used to map users to queues,for
            example, u:%user:%user maps all users to queues with the same name as the user.
        </description>
    </property>
    <property>
        <name>yarn.scheduler.capacity.queue-mappings-override.enable</name>
        <value>true</value>
        <!-- 上述queue-mappings设置的映射，是否覆盖客户端设置的队列参数-->
        <description>If a queue mapping is present, will it override the value specified by the user? This can be used
            by administrators to place jobs in queues that are different than the one specified by the user. The default
            is false.
        </description>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.acl_submit_applications</name>
        <value> </value>
        <!-- ACL继承性，父队列需控制住权限-->
        <description>
            The ACL of who can submit jobs to the root queue.
        </description>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.q1.acl_submit_applications</name>
        <value>test</value>
        <!-- q1只允许test用户提交作业-->
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.q2.acl_submit_applications</name>
        <value>foo</value>
        <!-- q2只允许foo用户提交作业-->
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.q1.maximum-capacity</name>
        <value>100</value>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.q2.maximum-capacity</name>
        <value>100</value>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.q1.capacity</name>
        <value>50</value>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.q2.capacity</name>
        <value>50</value>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.acl_administer_queue</name>
        <value> </value>
        <!-- ACL继承性，父队列需控制住权限-->
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.q1.acl_administer_queue</name>
        <value>test</value>
        <!-- q1队列只允许test用户管理，如kill作业-->
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.q2.acl_administer_queue</name>
        <value>foo</value>
        <!-- q2队列只允许foo用户管理，如kill作业-->
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.q1.state</name>
        <value>RUNNING</value>
    </property>
    <property>
        <name>yarn.scheduler.capacity.root.q2.state</name>
        <value>RUNNING</value>
    </property>
</configuration>
```

##### Capacity Scheduler（容量调度器）

以队列为单位划分资源，每个队列可设定一定比例的资源最低保证和使用上限，同时，每个用户也可设定一定的资源使用上限以防止资源滥用。而当一个队列的资源有剩余时，可暂时将剩余资源共享给其他队列。

Capacity Scheduler主要有以下几个特点：

- 容量保证：管理员可为每个队列设置资源最低保证和资源使用上限，而所有提交到该队列的应用程序共享这些资源
- 灵活性：如果一个队列中的资源有剩余，可以暂时共享给那些需要资源的队列，而一旦该队列有新的应用程序提交，则其他队列释放的资源会归还给该队列
- 多重租赁：支持多用户共享集群和多应用程序同时运行。为防止单个应用程序、用户或队列独占集群中的资源，管理员可为之增加多重约束（比如单个应用程序同时运行的任务数等）
- 安全保证：每个队列有严格的ACL列表规定它的访问用户，每个用户可指定哪些用户允许查看自己应用程序的运行状态或者控制应用程序（比如杀死应用程序）。此外，管理员可指定队列管理员和集群系统管理员
- 动态更新配置文件：管理员可根据需要动态修改各种配置参数，以实现在线集群管理

Capacity Scheduler的功能：

- Capacity Scheduler有自己的配置文件，即存放在conf目录下的capacity-scheduler.xml
- 在Capacity Scheduler的配置文件中，队列queueX的参数Y的配置名称为yarn.scheduler.capacity.queueX.Y
- 资源分配相关参数：
    + capacity：队列的最小资源容量（百分比）。注意，所有队列的容量之和应小于100
    + maximum-capacity：队列的资源使用上限
    + minimum-user-limit-percent：每个用户最低资源保障（百分比）
    + user-limit-factor：每个用户最多可使用的资源量（百分比）
- 限制应用程序数目的相关参数：
    + maximum-applications：集群或者队列中处于等待和运行状态的应用程序数目上限，这是一个强限制项，一旦集群中应用程序数目超过该上限，后续提交的应用程序将被拒绝。默认值为10000。Hadoop允许从集群和队列两个方面该值，其中，集群的总体数目上限可通过参数yarn.scheduler.capacity.maximum-applications设置，默认为10000，而单个队列可通过参数yarn.scheduler.capacity.<queue-path>.maximum-applications设置适合自己的值
    + maximum-am-resource-percent：集群中用于运行应用程序ApplicationMaster的资源比例上限，该参数通常用于限制处于活动状态的应用程序数目。所有队列的ApplicationMaster资源比例上限可通过参数yarn.scheduler.capacity.maximum-am-resource-percent设置，而单个队列可通过参数yarn.scheduler.capacity.<queue-path>.maximum-am-resource-percent设置适合自己的值
- 队列访问权限控制
    + state：队列状态，可以为STOPPED或者RUNNING。如果一个队列处于STOPPED状态，用户不可以将应用程序提交到该队列或者它的子队列中。类似的，如果root队列处于STOPPED状态，则用户不可以向集群提交应用程序，但正在运行的应用程序可以正常运行结束，以便队列可以优雅地退出
    + acl_submit_application：限定哪些用户/用户组可向给定队列中提交应用程序。该属性具有继承性，即如果一个用户可以向某个队列提交应用程序，则它可以向它所有子队列中提交应用程序
    + acl_administer_queue：为队列指定一个管理员，该管理员可控制该队列的所有应用程序，比如杀死任意一个应用程序等。同样，该属性具有继承性，如果一个用户可以向某个队列中提交应用程序，则它可以向它的所有子队列中提交应用程序
- 当管理员需动态修改队列资源配置时，可修改配置文件conf/capacity-scheduler.xml，然后运行“yarn rmadmin -refreshQueues”
- 当前Capacity Scheduler不允许管理员动态减少队列数目，且更新的配置参数值应是合法值，否则会导致配置文件加载失败


##### Fair Scheduler（公平调度器）
在Fair调度器中，我们不需要预先占用一定的系统资源，Fair调度器会为所有运行的job动态的调整系统资源。当第一个大job提交时，只有这一个job在运行，此时它获得了所有集群资源；当第二个小任务提交后，Fair调度器会分配一半资源给这个小任务，让这两个任务公平的共享集群资源。

需要注意的是，在Fair调度器中，从第二个任务提交到获得资源会有一定的延迟，因为它需要等待第一个任务释放占用的Container。小任务执行完成之后也会释放自己占用的资源，大任务又获得了全部的系统资源。最终的效果就是Fair调度器即得到了高的资源利用率又能保证小任务及时完成。

![Capacity Scheduler 和 Fair Scheduler](images/bqjz053dup.jpeg)

##### FIFO Scheduler

FIFO Scheduler把应用按提交的顺序排成一个队列，这是一个先进先出队列，在进行资源分配的时候，先给队列中最头上的应用进行分配资源，待最头上的应用需求满足后再给下一个分配，以此类推。

FIFO Scheduler是最简单也是最容易理解的调度器，也不需要任何配置，但它并不适用于共享集群。大的应用可能会占用所有集群资源，这就导致其它应用被阻塞。在共享集群中，更适合采用Capacity Scheduler或Fair Scheduler，这两个调度器都允许大任务和小任务在提交的同时获得一定的系统资源。


### 最佳实践

#### YRAN 调优

YRAN 调优有三个方面

1. 集群配置，配置各主机
2. YARN配置，配置内存和CPU资源
3. MapReduce配置，为每个map和reduce任务分配最大和最小资源

##### 主节点配置

通用平衡增强型实例规格族g6e的特点如下：

1. 依托第三代神龙架构，将大量虚拟化功能卸载到专用硬件，降低虚拟化开销，提供稳定可预期的超高性能。同时通过芯片快速路径加速手段，完成存储、网络性能以及计算稳定性的数量级提升。
2. 计算：
  + 处理器与内存配比约为1:4
  + 处理器：2.5 GHz主频、3.2 GHz睿频的Intel ® Xeon ® Platinum 8269（Cascade），计算性能稳定
  + 支持开启或关闭超线程配置，ECS实例默认开启超线程配置
3. 存储：
  + I/O优化实例
  + 仅支持ESSD云盘
  + 实例存储I/O性能与计算规格对应（规格越高存储I/O性能越强）
4. 网络：
  + 支持IPv6
  + 超高网络PPS收发包能力，如果需要更高的并发连接能力和网络收发包能力，建议您选用g7ne。
5. 适用场景：
  + 高网络包收发场景，例如视频弹幕、电信业务转发等
  + 各种类型和规模的企业级应用
  + 网站和应用服务器
  + 游戏服务器
  + 中小型数据库系统、缓存、搜索集群
  + 数据分析和计算
  + 计算集群、依赖内存的数据处理


主节点内存和CPU规划：

| 服务组件                 | CPU（cores） | Memory（MB） | 建议和描述                                   |
| ------------------------ | ------------ | ------------ | -------------------------------------------- |
| 操作系统                 | 2            | 8192         | 大多数操作系统最低使用4-8GB                  |
| 其他服务                 | 0            | 0            | 为不属于操作系统的，非作业服务使用           |
| HDFS NameNode            | 1            | 1792         | HDFS NameNode 堆的分配    |
| HDFS SecondaryNameNode   | 1            | 1024         | HDFS SecondaryNameNode 堆的分配   |
| HDFS HttpFS              | 0            |              |    |
| HDFS KMS                 | 0            |              |     |
| YARN JobHistory          | 0            | 512          | 堆的分配 |
| YARN ResourceManager     | 35           | 2304         | YARN ResourceManager 堆的分配                             |
| YARN WebAppProxyServer   | 0            | 512          | 堆的分配 |
| YARN App Timeline Server | 0            | 512          | 堆的分配 |
| Impala Catalog Server    | 0            | 0            | 可选，建议至少分配16GB                       |
| Impala StateStore Server | 0            | 0            | 可选，建议至少分配16GB                       |
| HBase Master             | 0            | 0        | 可选，建议分配内存不超过12-16GB              |
| HBase ThriftServer       | 0            | 0        | 可选，建议分配内存不超过12-16GB              |
| Hive MetaStore           | 0            | 512            | 可选，建议至少1GB                            |
| HiveServer2              | 0            | 512            | 可选，建议至少1GB                            |
| Jindo Namespace Service  | 0            | 0            |                                              |
| Jindo Manager Service    | 0            | 0            |                                              |
| Hue                      | 0            | 0            |                                              |
| Zeppelin                 | 0            | 0            |                                              |
| OpenLDAP                 | 0            | 0            |                                              |
| Knox                     | 0            | 1024            |                                              |
| Superset                 | 0            | 0            |                                              |
| Storm UI                 | 0            | 0            |                                              |
| Storm Nimbus             | 0            | 0            |                                              |
| PrestoMaster             | 0            | 0            |                                              |
| Tez Tomcat               | 0            | 0            |                                              |
| Oozie                    | 0            | 0            |                                              |
| SparkHistory             | 0            | 0            |                                              |
| Spark ThriftServer       | 0            | 0            |                                              |
| Ganglia Httpd            | 0            | 0            |                                              |
| Ganglia Gmetad           | 0            | 0            |                                              |

HDFS 2.5G + YARN 3.5G + Hive 1G + Knox 1G = 8G + 2G

##### 工作节点配置

工作节点内存和CPU规划：

| 服务组件              | CPU（cores） | Memory（MB） | 建议和描述                                   |
| --------------------- | ------------ | ------------ | -------------------------------------------- |
| 操作系统              | 2            | 8192         | 大多数操作系统最低使用4-8GB                  |
| 其他服务              | 0            | 0            | 为不属于操作系统的，非作业服务使用           |
| HDFS DataNode         | 1            | 1152         | HDFS DataNode 堆的分配：默认1GB和1个vcore    |
| YARN NodeManager      | 1            | 1536         | YARN NodeManager 堆的分配：默认1GB和1个vcore |
| Impala Daemon Server  | 0            | 0            | 可选，建议至少分配16GB                       |
| HBase RegionServer    | 0            | 1536         | 可选，建议分配内存不超过12-16GB              |
| Solr Server           | 0            | 0            | 可选，建议至少1GB                            |
| Kudu Server           | 0            | 0            | 可选，建议至少1GB                            |
| Jindo Storage Service | 0            | 0            | 可选，建议至少1GB                            |
| YARN 容器资源          | 35           | 0            |                                              |
| Storm Supervisor      | 0            | 0            |                                              |
| PrestoWorker          | 0            | 0            |                                              |

HDFS 1G + YARN 1.5G + HBase 1.5G = 4G + 2G

##### 全部节点配置

| 服务组件         | CPU（cores） | Memory（MB） | 建议和描述 |
| ---------------- | ------------ | ------------ | ---------- |
| HDFS Client      | 0            | 0            |            |
| DeltaLake        | 0            | 0            |            |
| HUDI             | 0            | 0            |            |
| Flume Client     | 0            | 0            |            |
| Flume Agent      | 0            | 0            |            |
| Storm Client     | 0            | 0            |            |
| Storm Logviewer  | 0            | 0            |            |
| Sqoop Client     | 0            | 0            |            |
| Presto Client    | 0            | 0            |            |
| Phoenix Client   | 0            | 0            |            |
| Tez Client       | 0            | 0            |            |
| Spark Client     | 0            | 0            |            |
| ZooKeeper        | 0            | 1024            |            |
| ZooKeeper Client | 0            | 0            |            |
| Ganglia Client   | 0            | 0            |            |
| Ganglia Gmond    | 0            | 0            |            |
| FlowAgentJobServer    | 0            | 1024            |            |

zk 1G + Flow 1G = 2G

#### FAQ


