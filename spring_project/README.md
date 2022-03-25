## Spring Project

Spring 使每个人都可以更快、更轻松、更安全地进行 Java 编程。Spring 对速度、简单性和生产力的关注使其成为世界上最受欢迎的 Java框架。

https://github.com/spring-projects

https://spring.io/projects/spring-boot

### 概述
#### 起源

要谈Spring的历史，就要先谈J2EE。J2EE应用程序的广泛实现是在1999年和2000年开始的，它的出现带来了诸如事务管理之类的核心中间层概念的标准化，但是在实践中并没有获得绝对的成功，因为开发效率，开发难度和实际的性能都令人失望。

曾经使用过EJB开发JAVA EE应用的人，一定知道，在EJB开始的学习和应用非常的艰苦，很多东西都不能一下子就很容易的理解。EJB要严格地实现各种不同类型的接口，类似的或者重复的代码大量存在。而配置也是复杂和单调，同样使用JNDI进行对象查找的代码也是单调而枯燥。虽然有一些开发工作随着xdoclet的出现，而有所缓解，但是学习EJB的高昂代价，和极低的开发效率，极高的资源消耗，都造成了EJB的使用困难。而Spring出现的初衷就是为了解决类似的这些问题。

Spring的一个最大的目的就是使JAVA EE开发更加容易。同时，Spring之所以与Struts、Hibernate等单层框架不同，是因为Spring致力于提供一个以统一的、高效的方式构造整个应用，并且可以将单层框架以最佳的组合揉和在一起建立一个连贯的体系。可以说Spring是一个提供了更完善开发环境的一个框架，可以为POJO(Plain Ordinary Java Object)对象提供企业级的服务。

Spring的形成，最初来自Rod Jahnson所著的一本很有影响力的书籍《Expert One-on-One J2EE Design and Development》，就是在这本书中第一次出现了Spring的一些核心思想，该书出版于2002年。另外一本书《Expert One-on-One J2EE Development without EJB》，更进一步阐述了在不使用EJB开发JAVA EE企业级应用的一些设计思想和具体的做法。

##### Spring的初衷

1. JAVA EE开发应该更加简单。
2. 使用接口而不是使用类，是更好的编程习惯。Spring 将使用接口的复杂度几乎降低到了零。
3. 为JavaBean提供了一个更好的应用配置框架。
4. 更多地强调面向对象的设计，而不是现行的技术如JAVA EE。
5. 尽量减少不必要的异常捕捉。
6. 使应用程序更加容易测试。

##### Spring的目标

1. 可以令人方便愉快的使用Spring。
2. 应用程序代码并不依赖于Spring APIs。
3. Spring不和现有的解决方案竞争，而是致力于将它们融合在一起。

##### Spring的基本组成

1. 最完善的轻量级核心框架。
2. 通用的事务管理抽象层。
3. JDBC抽象层。
4. 集成了Toplink, Hibernate, JDO, and iBATIS SQL Maps。
5. AOP功能。
6. 灵活的MVC Web应用框架。


#### 特点
Spring 灵活的库受到世界各地开发人员的信赖。Spring 每天为数百万最终用户提供愉快的体验——无论是流媒体电视，网上购物，或无数其他创新解决方案。Spring 还得到了所有科技巨头的贡献，包括阿里巴巴、亚马逊、谷歌、微软等。

Spring 灵活而全面的扩展集和第三方库让开发人员可以构建几乎所有可以想象的应用程序。Spring Framework 的核心是控制反转(Inversion of Control，IoC) 和依赖注入 (Dependency Injection，DI)特性为一系列广泛的特性和功能奠定了基础。无论您是为 Web 构建安全的、反应性的、基于云的微服务，还是为企业构建复杂的流数据流，Spring 都有提供帮助的工具。

Spring Boot 改变您处理 Java 编程任务的方式，从根本上简化您的体验。Spring Boot 结合了应用程序上下文和自动配置的嵌入式 Web 服务器等必需品，使微服务发展一事无成。为了更快，您可以将 Spring Boot 与 Spring Cloud 丰富的支持库、服务器、模式和模板相结合，将整个基于微服务的架构安全地部署到云，在创纪录的时间内。

我们的工程师非常关心性能。使用 Spring，您会注意到默认情况下快速启动、快速关闭和优化执行。越来越多的 Spring 项目也支持反应性（非阻塞）编程模型，以提高效率。开发人员的生产力是 Spring 的超能力。Spring Boot 可帮助开发人员轻松构建应用程序，并且比其他竞争范式少得多。嵌入式 Web 服务器、自动配置和“胖罐子”可帮助您快速入门，以及诸如Spring DevTools 中的 LiveReload意味着开发人员可以比以往更快地迭代。您甚至可以在几秒钟内启动一个新的 Spring 项目，Spring Initializr 位于start.spring.io.

Spring 在快速、负责任地处理安全问题方面有着良好的记录。Spring 提交者与安全专家合作修补和测试任何报告的漏洞。还密切监视第三方依赖项，并定期发布更新以帮助尽可能保证您的数据和应用程序的安全。此外，构建安全的、反应性的、基于云的微服务，还是为企业构建复杂的流数据流，Spring Security 使您可以更轻松地与行业标准安全方案集成，并提供默认情况下安全的值得信赖的解决方案。

Spring 社区是巨大的、全球性的、多样化的，涵盖所有年龄和能力的人，从完全的初学者到经验丰富的专业人士。无论您身在何处，都可以找到所需的支持和资源，助您更上一层楼：快速入门，指南和教程，视频，聚会，支持，甚至正式的培训和认证。

### 分支

- Spring Boot
- Spring Framework
- Spring Data
- Spring Cloud
- Spring Cloud Data Flow
- Spring Security
- Spring GraphQL
- Spring Session
- Spring Integration
- Spring HATEOAS
- Spring REST Docs
- Spring Batch
- Spring AMQP
- Spring CredHub
- Spring Flo
- Spring for Apache Kafka
- Spring LDAP
- Spring Roo
- Spring Shell
- Spring Statemachine
- Spring Vault
- Spring Web Flow
- Spring Web Services


#### Spring Framework


##### Request


@PathVariable 获取路径参数。即url/{id}这种形式。
@RequestParam 获取查询参数。即url?name=这种形式。

@RequestBody

无注解

##### POJO
POJO的名称有多种，pure old java object 、plain ordinary java object 等。按照 Martin Fowler 的解释是“Plain Old Java Object”，从字面上翻译为“纯洁老式的java对象”，但大家都使用“简单java对象”来称呼它。

POJO的内在含义是指那些没有从任何类继承、也没有实现任何接口，更没有被其它框架侵入的java对象。

POCO的概念是从java的POJO借用而来，而两者的含义是一致的，不同的仅仅是使用的语言不一样。所以POCO的解释就是“Plain Old C# Object”。

POJO的意义就在于它的简单而灵活性，因为它的简单和灵活，使得POJO能够任意扩展，从而胜任多个场合，也就让一个模型贯穿多个层成为现实。

POJO让开发者可专注于业务逻辑和脱离框架的单元测试。除此之外，由于POJO并不须要继承框架的类或实现其接口，开发者能够极其灵活地搭建继承结构和建造应用。

先写一个核心POJO，然后实现业务逻辑接口和持久化接口，就成了Domain Model； UI 需要使用时，就实现数据绑定接口，变成VO（View Object）。

**为什么会有POJO**

主要是Java的开发者被EJB的繁杂搞怕了，大家经过反思，又回归“纯洁老式”的JavaBean，即有无参构造函数，每个字段都有getter和setter的java类。


**POJO与PO、VO的区别**

POJO是指简单java对象（Plain Old Java Objects、pure old java object 或者 plain ordinary java object）。POJO是由new创建，由GC回收。

PO是指持久对象（Persistant Object）。持久对象实际上必须对应数据库中的entity。持久对象是insert数据库创建，由数据库delete删除的。基本上持久对象生命周期和数据库密切相关。另外持久对象往往只能存在一个数据库Connection之中，Connnection关闭以后，持久对象就不存在了，而POJO只要不被GC回收，总是存在的。而ORM追求的目标就是要PO在使用上尽量和POJO一致，对于程序员来说，他们可以把PO当做POJO来用，而感觉不到PO的存在。

VO是指值对象或者View对象（Value Object、View Object）。

 
**POJO的扩展**

POJO仅包含最简单的字段属性，没有多余的东西，它本质上就是一个普通的JavaBean。但是在POJO的基础上，能够扩展出不同的对象。

- 为POJO增加了持久化的方法（Insert、Update、Delete……）之后，POJO就变成了PO。
- 为POJO增加了数据绑定功能之后，POJO就变成了View Object，即UI Model。
- 为POJO增加业务逻辑的方法（比如单据审核、转帐……）之后，POJO就变成了Domain Model。
- POJO还可以当作数据传输对象（Data Transfer Object，DTO）使用。

EJB(Enterprise JavaBean): 我认为它是一组”功能”JavaBean的集合。上面说了JavaBean是实现了一种规范的Java对象。这里说EJB是一组JavaBean 的意思是这一组JavaBean组合起来实现了某个企业组的业务逻辑。这里的一组JavaBean不是乱组合的，它们要满足能实现某项业务功能的搭配。

数据访问对象（Data Access Object，DAO）就是一般所说的DAO层，用于连接数据库与外层之间的桥梁，并且持久化数据层对象。

业务对象（Business Object，BO）一般用在业务层，当业务比较复杂，用到比较多的业务对象时，可用BO类组合封装所有的对象一并传递。


#### Spring Boot

##### Spring Start Data JPA

Java Persistence API（JPA）是一项标准技术，可让您将对象映射到关系数据库。spring-boot-starter-data-jpa POM 提供了一个快速起步的方法。它提供了以下关键依赖：

- Hibernate  ——  最受欢迎的 JPA 实现之一。
- Spring Data JPA ——  可以轻松地实现基于 JPA 的资源库。
- Spring ORM  ——  Spring Framework 的核心 ORM 支持


##### MybatisPlus 主键策略

**ASSIGN_ID**

IdType.ASSIGN_ID（雪花算法）策略。使用接口IdentifierGenerator的方法nextId（以实现类为DefaultIdentifierGenerator雪花算法）。该策略使用雪花算法自动生成主键ID，主键类型为长或字符串（分别对应的MySQL的表字段为BIGINT和VARCHAR）。

如果不设置类型值，默认则使用IdType.ASSIGN_ID策略（自3.3.0起）。

雪花算法是Twitter开源的分布式ID生成算法其核心思想就是：使用一个64位的长型的数字作为全局唯一ID。在分布式系统中的应用十分广泛，且ID引入了时间戳，基本上保持自增的。

**ASSIGN_UUID**

IdType.ASSIGN_UUID（排除中划线的UUID）策略。使用接口IdentifierGenerator的方法nextUUID。该策略生成排除中划线的UUID作为主键。主键类型为String，对应MySQL的表分段为VARCHAR（32）。

**AUTO**

IdType.AUTO（数据库ID自增）策略。

对于像MySQL这样的支持主键自动递增的数据库，我们可以使用IdType.AUTO策略。

**INPUT**

IdType.INPUT（插入前自行设置主键值）策略。

（1）针对有序列的数据库：Oracle，SQLServer等，当需要建立一个自增序列时，需要用到序列。

提示：
在Oracle 11g中，设置自增扩，需要先创建序列（SQUENCE）再创建一个触发器（TRIGGER）。
在Oracle 12c中，只需要使用IDENTITY属性就可以了，和MySQL一样简单。
 
（2）Mybatis -Plus已经定义好了常见的数据库主键序列，我们首先只需要在@Configuration类中定义好@Bean：

Mybatis -Plus内置了如下数据库主键序列（如果内置支持不满足你的需求，可实现IKeyGenerator接口来进行扩展）：

DB2KeyGenerator
H2KeyGenerator
KingbaseKeyGenerator
OracleKeyGenerator
PostgreKeyGenerator

```java
@Bean
public OracleKeyGenerator oracleKeyGenerator(){
    return new OracleKeyGenerator();
}
```

（3）然后实体类配置主键Sequence，指定主键策略为IdType.INPUT即可：
提示：支持父类定义@KeySequence子类使用，这样就可以几个表共享一个Sequence

```java
@TableName("TEST_SEQUSER")
@KeySequence("SEQ_TEST")//类注解
public class TestSequser{
  @TableId(value = "ID", type = IdType.INPUT)
  private Long id;

}
```

（4）如果主键是String类型的，也可以使用：

如何使用序列作为主键，但是实体主键类型是字符串开头，表的主键是varchar2，但是需要从序列中取值

实体定义@KeySequence注解clazz指定类型String.class

实体定义主键的类型字符串
注意：oracle的序列返回的是Long类型，如果主键类型是Integer，可能会引起ClassCastException

```java
@KeySequence(value = "SEQ_ORACLE_STRING_KEY", clazz = String.class)
public class YourEntity{
     
    @TableId(value = "ID_STR", type = IdType.INPUT)
    private String idStr;
}
```

**NONE**

IdType.NONE策略，表示未设置主键类型（注解里等于跟随上下文，约等于INPUT）。


#### Spring Data

##### Spring Data JPA

Spring Data JPA 资源库（repository）是接口，您可以定义用于访问数据。JAP 查询是根据您的方法名自动创建。

##### Spring Data JDBC

Spring Data 包含了对 JDBC 资源库的支持，并将自动为 CrudRepository 上的方法生成 SQL。对于更高级的查询，它提供了 @Query 注解。

当 classpath 下存在必要的依赖时，Spring Boot 将自动配置 Spring Data 的 JDBC 资源库。可以通过添加单个 spring-boot-starter-data-jdbc 依赖引入到项目中。如有必要，可通过在应用程序中添加 @EnableJdbcRepositories 注解或 JdbcConfiguration 子类来控制 Spring Data JDBC 的配置。

### spring boot 启动流程

```java
SpringApplication.run(Application.class, args);
```

@SpringBootApplication注解是Spring Boot的核心注解，它其实是一个组合注解。实际上重要的只有三个Annotation：@Configuration + @EnableAutoConfiguration + @ComponentScan。

@Configuration就是JavaConfig形式的Spring Ioc容器的配置，SpringBoot社区推荐使用基于JavaConfig的配置形式。

@ComponentScan对应XML配置中的元素，功能是自动扫描并加载符合条件的组件（比如@Component和@Repository等）或者bean定义，最终将这些bean定义加载到IoC容器中。

可以通过basePackages等属性来细粒度的定制@ComponentScan自动扫描的范围，如果不指定，则默认Spring框架实现会从声明@ComponentScan所在类的package进行扫描。

@EnableAutoConfiguration会根据类路径中的jar依赖为项目进行自动配置，如：添加了spring-boot-starter-web依赖，会自动添加Tomcat和Spring MVC的依赖，Spring Boot会对Tomcat和Spring MVC进行自动配置。

@EnableAutoConfiguration帮助SpringBoot应用将所有符合条件的@Configuration配置都加载到当前SpringBoot创建并使用的IoC容器。借助于Spring框架原有的一个工具类：SpringFactoriesLoader的支持，@EnableAutoConfiguration可以智能的自动配置功效才得以大功告成！

SpringFactoriesLoader属于Spring框架私有的一种扩展方案，其主要功能就是从指定的配置文件META-INF/spring.factories加载配置。

#### 主要流程

1） 如果使用的是SpringApplication的静态run方法，那么，这个方法里面首先要创建一个SpringApplication对象实例，然后调用这个创建好的SpringApplication的实例方法。在SpringApplication实例初始化的时候，它会提前做几件事情：

- 根据classpath里面是否存在某个特征类org.springframework.web.context.ConfigurableWebApplicationContext来决定是否应该创建一个为Web应用使用的ApplicationContext类型。
- 使用SpringFactoriesLoader在应用的classpath中查找并加载所有可用的ApplicationContextInitializer。
- 使用SpringFactoriesLoader在应用的classpath中查找并加载所有可用的ApplicationListener。
- 推断并设置main方法的定义类。

2） SpringApplication实例初始化完成并且完成设置后，就开始执行run方法的逻辑了，方法执行伊始，首先遍历执行所有通过SpringFactoriesLoader可以查找到并加载的SpringApplicationRunListener。调用它们的started()方法。

3） 创建并配置当前Spring Boot应用将要使用的Environment（包括配置要使用的PropertySource以及Profile）。

4） 遍历调用所有SpringApplicationRunListener的environmentPrepared()的方法。

5） 如果SpringApplication的showBanner属性被设置为true，则打印banner。

6） 根据用户是否明确设置了applicationContextClass类型以及初始化阶段的推断结果，决定该为当前SpringBoot应用创建什么类型的ApplicationContext并创建完成，然后根据条件决定是否添加ShutdownHook，决定是否使用自定义的BeanNameGenerator，决定是否使用自定义的ResourceLoader，当然，最重要的，将之前准备好的Environment设置给创建好的ApplicationContext使用。

7） ApplicationContext创建好之后，SpringApplication会再次借助Spring-FactoriesLoader，查找并加载classpath中所有可用的ApplicationContext-Initializer，然后遍历调用这些ApplicationContextInitializer的initialize（applicationContext）方法来对已经创建好的ApplicationContext进行进一步的处理。

8） 遍历调用所有SpringApplicationRunListener的contextPrepared()方法。

9） 最核心的一步，将之前通过@EnableAutoConfiguration获取的所有配置以及其他形式的IoC容器配置加载到已经准备完毕的ApplicationContext。

10） 遍历调用所有SpringApplicationRunListener的contextLoaded()方法。

11） 调用ApplicationContext的refresh()方法，完成IoC容器可用的最后一道工序。

12） 查找当前ApplicationContext中是否注册有CommandLineRunner，如果有，则遍历执行它们。

13） 正常情况下，遍历执行SpringApplicationRunListener的finished()方法、（如果整个过程出现异常，则依然调用所有SpringApplicationRunListener的finished()方法，只不过这种情况下会将异常信息一并传入处理）
