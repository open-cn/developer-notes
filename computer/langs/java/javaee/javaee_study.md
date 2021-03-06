
1、应用框架（遥望先贤，拜读大师作品，学习源码精髓，拓展程序员编码视野）
SpringBoot
根据条件初始化bean              读取配置信息               Spring Event          Spring Aware
@ConditionalOnbean            @Configuration           ApplicationListener
@ConditionalOnClass           @PropertySource          ApplicationEvent
@ConditionalOnMissingbean     @ComponentScan           定义config启动
@ConditionalOnJava            @Value

多线程                         计划任务                  文件上传
TaskExecutor                  @EnableScheduline
ThreadPoolExecutor                  @Scheduled
@EnableAsync


SpringCloud
服务发现                        服务提供者                服务消费者             熔断器
Eureka                                                 Ribbon                Hystrix
Consul                                                 Feign                 Hystrix Dashboard
                                                                             Turbine

配置中心                       Docker
Spring Cloud Config           Docker构建微服务
                              Docker介绍
                              Docker安装
                              Docker常用命令
                              Docker使用仓库


tbschedule
tbschedule分布式调度使用       调度任务                  调度参数解析              调度策略


Spring
MVC                           AOP                     事务处理                 FactoryBean
原理介绍                       AOP原理                 声明式事务                接口类的实例化
Controller调用                java动态代理             事务的传播属性            FactoryBean的初始化
参数绑定                       Cglib代理               事务的实现方式
MessageConverter              AOP的坑                 spring的连接处理
展示优化

Spring源码解读


持久层
mybatis                       代码分层             Mybatis源码解读
搭建                                              手动实现Mybatis    Transaction
分页实现                                           ohnl             resultHandler
代码生成                                           sqlsource        executor
自定义语句的实现                                    cache            SQLSession
                                                  DataSource



2、工程化管理专题（工欲善其事必先利其器，高效编码从熟练使用工具开始）
maven
Maven打包                      Jar依赖                 Jar冲突解决               Jar发布


NEXUS
搭建                           上传                    仓库管理


jenkins
自动化发布                      自动化执行


GIT
冲突的解决                      提交过滤                GIT常用命令               GIT协同开发
GitHub介绍                     搭建本地仓库

代码审查
Sonar                         单元测试



3、高并发架构与分布式技术（架构师绊脚石技术，高级工程师瓶颈技术， I must get！！！）
NIO、Netty
和Android联合，实时推送         和前端联合，webSocket,IM聊天         netty原理


分布式RPC
Zookeeper基本原理              Zookeeper Client API              Zookeeper典型应用场景
数据模型                       create(path,data,flags)           数据发布与订阅(配置中心)
重要概念                       delete(path,version)              负载均衡
Zookeeper特性                  exist(path,watch)                  命令服务
                              getData(path,watch)


缓存
Redis                         mongoDB                           Memcached
Redis原理剖析                  mongodb原理                        缓存并发
Redis主从模式                  动态查询                           缓存漂移
Redis客户端                    索引
Redis持久化                    mongodb客户端Robomongo
                              mongodb常用命令


消息中间件activeMQ
JMS规范                       activeMQ
点对点模型                     跨平台
发布订阅模型                   支持JMS规范
                             消息持久化
                             支持Ajax访问
                             activeMQ监控
                             java操作activeMQ实例演练


多线程
线程安全                      线程池                    ExecuteThreadPool           NIO
                                                                                  NETTY


SSO
session跨域场景               spring-session           sso框架


高并发分流技术
Lvs                          Apache                   Nginx
                                                      Nginx模块工作原理       worker进程
                                                      master进程             负载均衡设置
                                                      Nginx进程模型           Nginx配置详解
                                                      Handlers(处理器模块)    动静分离配置
                                                      Filters(过滤器模块)     其他配置
                                                      Proxies(代理类模块)


数据库水平切分技巧
分库及DB路由                  分表                      MySQL集群实战
单点集群(Group)               分表规则
负载均衡策略(LB)               分表增删改查
读写分离


4、618电商项目实战（空谈误国，实干兴邦，摆脱纸上谈兵，在实战中成长）
商品详情页
剖析一线电商商品详情页亿级PV应对策略
动静分离、缓存更新、服务降级、限流、CDN加速


商品搜索
基于Lucene的全文搜索、采用solr高性能企业级搜索应用服务器
索引结构、索引更新策略、分词算法、搜索命中率提升、订单实时统计


交易模块
添加购物车、提交订单、秒杀等核心功能
订单可靠性保证：避免重复订单、避免漏单、要能够有补单功能
缓存设计、缓存击穿、缓存雪崩的出现场景以及解决方案
mongodb、kafka、zookeeper、分布式调度
解决大型互联网千万级别访问量，大并发的承受压力


会员模块
用户详情、用户感兴趣的商铺展示、用户收藏等核心功能
会员登录采用SSO单点登录框架、分布式会话、撞库防范机制
用户感兴趣的商铺采用用户画像技术


用户画像
大型电商用户行为分析，用户粘性提高与营销转化提升的利器
数据维度：用户登录、商品浏览、添加购物车、下单、商品评论、收藏
数据无侵入式埋点、logstash 海量日志采集与传输、HDFS存储、HIVE大数据分析



5、性能优化（高手分水岭，高手进阶必经之路）
JVM优化
JVM原理剖析               JVM内存大小设置              垃圾回收器选择       JVM服务参数调优实战
                         每个线程栈大小               串行收集器
                         设置JVM最大堆内存            并行收集器(吞吐量优先)
                         设置年轻代大小               并发收集器(吞吐量优先)
                         设置持久代大小


JAVA程序性能优化
避免在循环条件中使用复杂表达式                   使用'System.arrayCopy()'代替通过循环复制数组
避免不需要的instanceof操作                     避免不必要的造型操作
使用移位操作代替'A*B'


数据库优化
MySQL优化                                     Oracle优化
选取最适用的字段属性                            执行计划分析
使用连接(JOIN)来代替子查询(Sub-Queries)         Oracle访问数据的存取方法
使用联合(UNION)来代替手动创建的临时表            表之间的连接
使用索引
优化的查询语句



6搜索引擎专题（技多不压身，做一名全面的程序员）
Lucene
Lucene组成及原理          构建索引             Lucene过程分析        高级搜索
扩展应用                  管理及性能调优


Solr
建立索引                  文本分析              多语言搜索            分组&合并域
Solr云


ElasticSearch
ES搜索                   索引&映射             分布式CRUD           索引管理
结构化搜索
全文搜索
分布式搜索

分片                     搜索优化



7大数据专题
Hadoop
Hdfs                    MapReduce             Yarn


HBase
表设计                   协处理器               过滤器               监控及优化
Phoenix                 二级索引


ElasticSearch
基本概念及原理            数据倾斜                Hive优化            HiveServer2 & Beeline
内表     索引
外表     分区表
桶



