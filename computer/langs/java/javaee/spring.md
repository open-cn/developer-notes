## Spring

### 概述

Spring 是 Java EE 编程领域的一款轻量级的开源框架，由被称为“Spring 之父”的 Rod Johnson 于 2002 年提出并创立，它的目标就是要简化 Java 企业级应用程序的开发难度和周期。

Spring 自诞生以来备受青睐，一直被广大开发人员作为 Java 企业级应用程序开发的首选。时至今日，Spring 俨然成为了 Java EE 代名词，成为了构建 Java EE 应用的事实标准。

#### 起源

早期的 J2EE（Java EE 平台）推崇以 EJB 为核心的开发方式，但这种开发方式在实际的开发过程中存在种种弊端，例如使用复杂、代码臃肿、代码侵入性强、开发周期长、移植难度大等。

Rod Johnson 在其 2002 年编著的畅销书《Expert One-on-One J2EE Design and Development》中，针对 EJB 各种臃肿的结构进行了逐一的分析和否定，并分别以更加简洁的方式进行了替换。

在这本书中，Rod Johnson 通过一个包含 3 万行代码的附件，展示了如何在不使用 EJB 的情况下构建一个高质量、可扩展的 Java 应用程序。在这个附件中，Rod Johnson 编写了上万行基础结构代码，其中包含了许多可重用的 Java 接口和类，例如 ApplicationContext、BeanFactory 等。这些类的根包被命名为 com.interface21，含义为：这是提供给 21 世纪的一个参考。

这本书影响甚远，后来 Rod Johnson 将 com.interface21 的代码开源，并把这个新框架并命名为“Spring”，含义为：Spring 像一缕春风一样，扫平传统 J2EE 的寒冬。

- 2003 年 2 月，Spring 0.9 版本发布，它采用了 Apache 2.0 开源协议；
- 2004 年 4 月，Spring 1.0 版本正式发布。


#### 概念

##### 广义的 Spring

广义上的 Spring 泛指以 Spring Framework 为核心的 Spring 技术栈。

经过十多年的发展，Spring 已经不再是一个单纯的应用框架，而是逐渐发展成为一个由多个不同子项目（模块）组成的成熟技术，例如 Spring Framework、Spring MVC、SpringBoot、Spring Cloud、Spring Data、Spring Security 等，其中 Spring Framework 是其他子项目的基础。

这些子项目涵盖了从企业级应用开发到云计算等各方面的内容，能够帮助开发人员解决软件发展过程中不断产生的各种实际问题，给开发人员带来了更好的开发体验。

- Spring Data：Spring 提供的数据访问模块，对 JDBC 和 ORM 提供了很好的支持。通过它，开发人员可以使用一种相对统一的方式，来访问位于不同类型数据库中的数据。
- Spring Batch：一款专门针对企业级系统中的日常批处理任务的轻量级框架，能够帮助开发人员方便的开发出健壮、高效的批处理应用程序。
- Spring Security：前身为 Acegi，是 Spring 中较成熟的子模块之一。它是一款可以定制化的身份验证和访问控制框架。
- Spring Mobile：是对 Spring MVC 的扩展，用来简化移动端 Web 应用的开发。
- Spring Boot：是 Spring 团队提供的全新框架，它为 Spring 以及第三方库一些开箱即用的配置，可以简化 Spring 应用的搭建及开发过程。
- Spring Cloud：一款基于 Spring Boot 实现的微服务框架。它并不是某一门技术，而是一系列微服务解决方案或框架的有序集合。它将市面上成熟的、经过验证的微服务框架整合起来，并通过 Spring Boot 的思想进行再封装，屏蔽调其中复杂的配置和实现原理，最终为开发人员提供了一套简单易懂、易部署和易维护的分布式系统开发工具包。


##### 狭义的 Spring

狭义的 Spring 特指 Spring Framework，通常我们将它称为 Spring 框架。Spring 框架是一个分层的、面向切面的 Java 应用程序的一站式轻量级解决方案，它是 Spring 技术栈的核心和基础，是为了解决企业级应用开发的复杂性而创建的。

Spring 有两个核心部分： IoC 和 AOP。
- IOC：Inverse of Control 的简写，译为“控制反转”，指把创建对象过程交给 Spring 进行管理。
- AOP：Aspect Oriented Programming 的简写，译为“面向切面编程”。

#### 特点

Spring 是一种基于 Bean 的编程技术，它深刻地改变着 Java 开发世界。Spring 使用简单、基本的 Java Bean 来完成以前只有 EJB 才能完成的工作，使得很多复杂的代码变得优雅和简洁，避免了 EJB 臃肿、低效的开发模式，极大的方便项目的后期维护、升级和扩展。

在实际开发中，服务器端应用程序通常采用三层体系架构，分别为表现层（web）、业务逻辑层（service）、持久层（dao）。

Spring 致力于 Java EE 应用各层的解决方案，对每一层都提供了技术支持：
- 在表现层提供了对 Spring MVC、Struts2 等框架的整合；
- 在业务逻辑层提供了管理事务和记录日志的功能；
- 在持久层还可以整合 MyBatis、Hibernate 和 JdbcTemplate 等技术，对数据库进行访问。

这充分地体现了 Spring 是一个全面的解决方案，对于那些已经有较好解决方案的领域，Spring 绝不做重复的事情。

从设计上看，Spring 框架给予了 Java 程序员更高的自由度，对业界的常见问题也提供了良好的解决方案，因此在开源社区受到了广泛的欢迎，并且被大部分公司作为 Java 项目开发的首选框架。

Spring 框架具有以下几个特点：
- 方便解耦，简化开发：Spring 就是一个大工厂，可以将所有对象的创建和依赖关系的维护交给 Spring 管理。
- 方便集成各种优秀框架：Spring 不排斥各种优秀的开源框架，其内部提供了对各种优秀框架（如 Struts2、Hibernate、MyBatis 等）的直接支持。
- 降低 Java EE API 的使用难度：Spring 对 Java EE 开发中非常难用的一些 API（JDBC、JavaMail、远程调用等）都提供了封装，使这些 API 应用的难度大大降低。
- 方便程序的测试：Spring 支持 JUnit4，可以通过注解方便地测试 Spring 程序。
- AOP 编程的支持：Spring 提供面向切面编程，可以方便地实现对程序进行权限拦截和运行监控等功能。
- 声明式事务的支持：只需要通过配置就可以完成对事务的管理，而无须手动编程。


### 体系结构

Spring 框架基本涵盖了企业级应用开发的各个方面，它包含了 20 多个不同的模块。
```
spring-aop      spring-context-indexer  spring-instrument  spring-orm    spring-web
spring-aspects  spring-context-support  spring-jcl         spring-oxm    spring-webflux
spring-beans    spring-core             spring-jdbc        spring-r2dbc  spring-webmvc
spring-context  spring-expression       spring-jms         spring-test   spring-websocket
spring-messaging   spring-tx  
```

1. Data Access/Integration（数据访问／集成）:数据访问／集成层包括 JDBC、ORM、OXM、JMS 和 Transactions 模块。
	+ JDBC 模块：提供了一个 JBDC 的样例模板，使用这些模板能消除传统冗长的 JDBC 编码还有必须的事务控制，而且能享受到 Spring 管理事务的好处。
	+ ORM 模块：提供与流行的“对象-关系”映射框架无缝集成的 API，包括 JPA、JDO、Hibernate 和 MyBatis 等。而且还可以使用 Spring 事务管理，无需额外控制事务。
	+ OXM 模块：提供了一个支持 Object /XML 映射的抽象层实现，如 JAXB、Castor、XMLBeans、JiBX 和 XStream。将 Java 对象映射成 XML 数据，或者将XML 数据映射成 Java 对象。
	+ JMS 模块：指 Java 消息服务，提供一套 “消息生产者、消息消费者”模板用于更加简单的使用 JMS，JMS 用于用于在两个应用程序之间，或分布式系统中发送消息，进行异步通信。
	+ Transactions 事务模块：支持编程和声明式事务管理。
2. Web 模块：Spring 的 Web 层包括 Web、Servlet、WebSocket 和 Portlet 组件。
	+ Web 模块：提供了基本的 Web 开发集成特性，例如多文件上传功能、使用的 Servlet 监听器的 IOC 容器初始化以及 Web 应用上下文。
	+ Servlet 模块：提供了一个 Spring MVC Web 框架实现。Spring MVC 框架提供了基于注解的请求资源注入、更简单的数据绑定、数据验证等及一套非常易用的 JSP 标签，完全无缝与 Spring 其他技术协作。
	+ WebSocket 模块：提供了简单的接口，用户只要实现响应的接口就可以快速的搭建 WebSocket Server，从而实现双向通讯。
	+ Portlet 模块：提供了在 Portlet 环境中使用 MVC 实现，类似 Web-Servlet 模块的功能。
3. Core Container（Spring 的核心容器）:是其他模块建立的基础，由 Beans 模块、Core 核心模块、Context 上下文模块和 SpEL 表达式语言模块组成，没有这些核心容器，也不可能有 AOP、Web 等上层的功能。
	+ Beans 模块：提供了框架的基础部分，包括控制反转和依赖注入。
	+ Core 核心模块：封装了 Spring 框架的底层部分，包括资源访问、类型转换及一些常用工具类。
	+ Context 上下文模块：建立在 Core 和 Beans 模块的基础之上，集成 Beans 模块功能并添加资源绑定、数据验证、国际化、Java EE 支持、容器生命周期、事件传播等。ApplicationContext 接口是上下文模块的焦点。
	+ SpEL 模块：提供了强大的表达式语言支持，支持访问和修改属性值，方法调用，支持访问及修改数组、容器和索引器，命名变量，支持算数和逻辑运算，支持从 Spring 容器获取 Bean，它也支持列表投影、选择和一般的列表聚合等。
4. AOP、Aspects、Instrumentation 和 Messaging：在 Core Container 之上是 AOP、Aspects 等模块。
	+ AOP 模块：提供了面向切面编程实现，提供比如日志记录、权限控制、性能统计等通用功能和业务逻辑分离的技术，并且能动态的把这些功能添加到需要的代码中，这样各司其职，降低业务逻辑和通用功能的耦合。
	+ Aspects 模块：提供与 AspectJ 的集成，是一个功能强大且成熟的面向切面编程（AOP）框架。
	+ Instrumentation 模块：提供了类工具的支持和类加载器的实现，可以在特定的应用服务器中使用。
	+ messaging 模块：Spring 4.0 以后新增了消息（Spring-messaging）模块，该模块提供了对消息传递体系结构和协议的支持。
5. Test 模块
	+ Test 模块：Spring 支持 Junit 和 TestNG 测试框架，而且还额外提供了一些基于 Spring 的测试功能，比如在测试 Web 框架时，模拟 Http 请求的功能。


### IOC

IOC不是一门技术，而是一种设计思想，是一个重要的面向对象编程法则，能够指导我们如何设计出松耦合、更优良的程序。Spring 通过 IoC 容器来管理所有 Java 对象的实例化和初始化，控制对象与对象之间的依赖关系。我们将由 IoC 容器管理的 Java 对象称为 Spring Bean，它与使用关键字 new 创建的 Java 对象没有任何区别。IoC 容器是 Spring 框架中最重要的核心组件之一，它贯穿了 Spring 从诞生到成长的整个过程。

IoC 带来的最大改变不是代码层面的，而是从思想层面上发生了“主从换位”的改变。原本调用者是主动的一方，它想要使用什么资源就会主动出击，自己创建；但在 Spring 应用中，IoC 容器掌握着主动权，调用者则变成了被动的一方，被动的等待 IoC 容器创建它所需要的对象（Bean）。这个过程在职责层面发生了控制权的反转，把原本调用者通过代码实现的对象的创建，反转给 IoC 容器来帮忙实现，因此我们将这个过程称为 Spring 的“控制反转”。

#### 依赖注入

依赖注入（Denpendency Injection，简写为 DI）是 Martin Fowler 在 2004 年在对“控制反转”进行解释时提出的。Martin Fowler 认为“控制反转”一词很晦涩，无法让人很直接的理解“到底是哪里反转了”，因此他建议使用“依赖注入”来代替“控制反转”。

在面向对象中，对象和对象之间是存在一种叫做“依赖”的关系。简单来说，依赖关系就是在一个对象中需要用到另外一个对象，即对象中存在一个属性，该属性是另外一个类的对象。

我们知道，控制反转核心思想就是由 Spring 负责对象的创建。在对象创建过程中，Spring 会自动根据依赖关系，将它依赖的对象注入到当前对象中，这就是所谓的“依赖注入”。

依赖注入本质上是 Spring Bean 属性注入的一种，只不过这个属性是一个对象属性而已。

#### 工作原理

在 Java 软件开发过程中，系统中的各个对象之间、各个模块之间、软件系统和硬件系统之间，或多或少都存在一定的耦合关系。

若一个系统的耦合度过高，那么就会造成难以维护的问题，但完全没有耦合的代码几乎无法完成任何工作，这是由于几乎所有的功能都需要代码之间相互协作、相互依赖才能完成。因此我们在程序设计时，所秉承的思想一般都是在不影响系统功能的前提下，最大限度的降低耦合度。

IoC 底层通过工厂模式、Java 的反射机制、XML 解析等技术，将代码的耦合度降低到最低限度，其主要步骤如下：
- 在配置文件（例如 Bean.xml）中，对各个对象以及它们之间的依赖关系进行配置；
- 我们可以把 IoC 容器当做一个工厂，这个工厂的产品就是 Spring Bean；
- 容器启动时会加载并解析这些配置文件，得到对象的基本信息以及它们之间的依赖关系；
- IoC 利用 Java 的反射机制，根据类名生成相应的对象（即 Spring Bean），并根据依赖关系将这个对象注入到依赖它的对象中。

由于对象的基本信息、对象之间的依赖关系都是在配置文件中定义的，并没有在代码中紧密耦合，因此即使对象发生改变，我们也只需要在配置文件中进行修改即可，而无须对 Java 代码进行修改，这就是 Spring IoC 实现解耦的原理。

#### IoC 容器
IoC 思想基于 IoC 容器实现的，IoC 容器底层其实就是一个 Bean 工厂。Spring 框架为我们提供了两种不同类型 IoC 容器，它们分别是 BeanFactory 和 ApplicationContext。

##### BeanFactory
BeanFactory 是 IoC 容器的基本实现，也是 Spring 提供的最简单的 IoC 容器，它提供了 IoC 容器最基本的功能，由 org.springframework.beans.factory.BeanFactory 接口定义。

BeanFactory 采用懒加载（lazy-load）机制，容器在加载配置文件时并不会立刻创建 Java 对象，只有程序中获取（使用）这个对对象时才会创建。

注意：BeanFactory 是 Spring 内部使用接口，通常情况下不提供给开发人员使用。 

##### ApplicationContext
ApplicationContext 是 BeanFactory 接口的子接口，是对 BeanFactory 的扩展。ApplicationContext 在 BeanFactory 的基础上增加了许多企业级的功能，例如 AOP（面向切面编程）、国际化、事务支持等。

ApplicationContext 接口有两个常用的实现类，具体如下：
- ClassPathXmlApplicationContext：加载类路径 ClassPath 下指定的 XML 配置文件，并完成 ApplicationContext 的实例化工作。	
- FileSystemXmlApplicationContext：加载指定的文件系统路径中指定的 XML 配置文件，并完成 ApplicationContext 的实例化工作。

#### Bean

由 Spring IoC 容器管理的对象称为 Bean，Bean 根据 Spring 配置文件中的信息创建。

我们可以把 Spring IoC 容器看作是一个大工厂，Bean 相当于工厂的产品。如果希望这个大工厂生产和管理 Bean，就需要告诉容器需要哪些 Bean，以哪种方式装配。

Spring 配置文件支持两种格式，即 XML 文件格式和 Properties 文件格式。
- Properties 配置文件主要以 key-value 键值对的形式存在，只能赋值，不能进行其他操作，适用于简单的属性配置。
- XML 配置文件采用树形结构，结构清晰，相较于 Properties 文件更加灵活。但是 XML 配置比较繁琐，适用于大型的复杂的项目。

通常情况下，Spring 的配置文件都是使用 XML 格式的。XML 配置文件的根元素是 <beans>，该元素包含了多个子元素 <bean>。每一个 <bean> 元素都定义了一个 Bean，并描述了该 Bean 是如何被装配到 Spring 容器中的。

在 XML 配置的<beans> 元素中可以包含多个属性或子元素，常用的属性或子元素如下所示：
- id：Bean 的唯一标识符，Spring IoC 容器对 Bean 的配置和管理都通过该属性完成。id 的值必须以字母开始，可以使用字母、数字、下划线等符号。
- name：该属性表示 Bean 的名称，我们可以通过 name 属性为同一个 Bean 同时指定多个名称，每个名称之间用逗号或分号隔开。Spring 容器可以通过 name 属性配置和管理容器中的 Bean。
- class：该属性指定了 Bean 的具体实现类，它必须是一个完整的类名，即类的全限定名。
- scope：表示 Bean 的作用域，属性值可以为 singleton（单例）、prototype（原型）、request、session 和 global Session。默认值是 singleton。
- constructor-arg：<bean> 元素的子元素，我们可以通过该元素，将构造参数传入，以实现 Bean 的实例化。该元素的 index 属性指定构造参数的序号（从 0 开始），type 属性指定构造参数的类型。
- property：<bean>元素的子元素，用于调用 Bean 实例中的 setter 方法对属性进行赋值，从而完成属性的注入。该元素的 name 属性用于指定 Bean 实例中相应的属性名。
- ref：<property> 和 <constructor-arg> 等元素的子元索，用于指定对某个 Bean 实例的引用，即 <bean> 元素中的 id 或 name 属性。
- value：<property> 和 <constractor-arg> 等元素的子元素，用于直接指定一个常量值。
- list：用于封装 List 或数组类型的属性注入。
- set：用于封装 Set 类型的属性注入。
- map：用于封装 Map 类型的属性注入。
- entry： <map> 元素的子元素，用于设置一个键值对。其 key 属性指定字符串类型的键值，ref 或 value 子元素指定其值。
- init-method：容器加载 Bean 时调用该方法，类似于 Servlet 中的 init() 方法
- destroy-method：容器删除 Bean 时调用该方法，类似于 Servlet 中的 destroy() 方法。该方法只在 scope=singleton 时有效
- lazy-init：懒加载，值为 true，容器在首次请求时才会创建 Bean 实例；值为 false，容器在启动时创建 Bean 实例。该方法只在 scope=singleton 时有效。

##### Bean属性注入

所谓 Bean 属性注入，简单点说就是将属性注入到 Bean 中的过程，而这属性既可以普通属性，也可以是一个对象（Bean）。

Spring 主要通过以下 2 种方式实现属性注入：
- 构造函数注入
	+ 在 Bean 中添加一个有参构造函数，构造函数内的每一个参数代表一个需要注入的属性；
	+ 在 Spring 的 XML 配置文件中，通过 <beans> 及其子元素 <bean> 对 Bean 进行定义；
	+ 在 <bean> 元素内使用 <constructor-arg> 元素，对构造函数内的属性进行赋值，Bean 的构造函数内有多少参数，就需要使用多少个 <constructor-arg> 元素。
- setter 注入（又称设值注入）：在 Spring 实例化 Bean 的过程中，IoC 容器首先会调用默认的构造方法（无参构造方法）实例化 Bean（Java 对象），然后通过 Java 的反射机制调用这个 Bean 的 setXxx() 方法，将属性值注入到 Bean 中。
	+ 在 Bean 中提供一个默认的无参构造函数（在没有其他带参构造函数的情况下，可省略），并为所有需要注入的属性提供一个 setXxx() 方法；
	+ 在 Spring 的 XML 配置文件中，使用 <beans> 及其子元素 <bean> 对 Bean 进行定义；
	+ 在 <bean> 元素内使用  <property> 元素对各个属性进行赋值。

**短命名空间注入**

我们在通过构造函数或 setter 方法进行属性注入时，通常是在 <bean> 元素中嵌套 <property> 和 <constructor-arg> 元素来实现的。这种方式虽然结构清晰，但书写较繁琐。

Spring 框架提供了 2 种短命名空间，可以简化 Spring 的 XML 配置，如下表。

p 命名空间：<bean> 元素中嵌套的 <property> 元素。是 setter 方式属性注入的一种快捷实现方式。
c 命名空间：<bean> 元素中嵌套的 <constructor> 元素。是构造函数属性注入的一种快捷实现方式。

##### 注入内部Bean

将定义在 <bean> 元素的 <property> 或 <constructor-arg> 元素内部的 Bean，称为“内部 Bean”。

> 注意：内部 Bean 都是匿名的，不需要指定 id 和 name 的。即使制定了，IoC 容器也不会将它作为区分 Bean 的标识符，反而会无视 Bean 的 Scope 标签。因此内部 Bean 几乎总是匿名的，且总会随着外部的 Bean 创建。内部 Bean 是无法被注入到它所在的 Bean 以外的任何其他 Bean 的。

##### Bean继承

在 Spring 中，Bean 和 Bean 之间也存在继承关系。Spring Bean 的定义中可以包含很多配置信息，例如构造方法参数、属性值。子 Bean 既可以继承父 Bean 的配置数据，也可以根据需要重写或添加属于自己的配置信息。

在 Spring XML 配置中，通过子 Bean 的 parent 属性来指定需要继承的父 Bean，配置格式如下。
```xml
<!--父Bean-->
<bean id="parentBean" class="xxx.xxxx.xxx.ParentBean" >
    <property name="xxx" value="xxx"></property>
    <property name="xxx" value="xxx"></property>
</bean> 
<!--子Bean--> 
<bean id="childBean" class="xxx.xxx.xxx.ChildBean" parent="parentBean"></bean>
```

如果一个父 Bean 的 abstract 属性值为 true，则表明这个 Bean 是抽象的。抽象的父 Bean 只能作为模板被子 Bean 继承，它不能实例化，也不能被其他 Bean 引用，更不能在代码中根据 id 调用 getBean() 方法获取，否则就会返回错误。

在父 Bean 的定义中，既可以指定 class 属性，也可以不指定 class 属性。如果父 Bean 定义没有明确地指定 class 属性，那么这个父 Bean 的 abstract 属性就必须为 true。

##### Bean自动装配

Spring 把 Bean 与 Bean 之间建立依赖关系的行为称为“装配”。Spring 的 IOC 容器虽然功能强大，但它本身不过只是一个空壳而已，它自己并不能独自完成装配工作。需要我们主动将 Bean 放进去，并告诉它 Bean 和 Bean 之间的依赖关系，它才能按照我们的要求完成装配工作。

在 XML 配置中，通过 <constructor-arg>和 <property> 中的 ref 属性，可以手动维护 Bean 与 Bean 之间的依赖关系。但随着应用的不断发展，容器中包含的 Bean 会越来越多，Bean 和 Bean 之间的依赖关系也越来越复杂，这就使得我们所编写的 XML 配置也越来越复杂，越来越繁琐。为了解决这一问题，Spring 框架还为我们提供了“自动装配”功能。

Spring 框架式默认不支持自动装配的，要想使用自动装配，则需要对 Spring XML 配置文件中 <bean> 元素的 autowire 属性进行设置。

```xml
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
   http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
    <!--部门 Dept 的 Bean 定义-->
    <bean id="dept" class="com.example.c.Dept"></bean>
   
    <!--雇员 Employee 的 Bean 定义，通过 autowire 属性设置自动装配的规则-->
    <bean id="employee" class="com.example.c.Employee" autowire="byName">
    </bean>
</beans>
```

Spring 共提供了 5 中自动装配规则，它们分别与 autowire 属性的 5 个取值对应，具体说明如下：
- byName：按名称自动装配。Spring 会根据的 Java 类中对象属性的名称，在整个应用的上下文 ApplicationContext（IoC 容器）中查找。若某个 Bean 的 id 或 name 属性值与这个对象属性的名称相同，则获取这个 Bean，并与当前的 Java 类 Bean 建立关联关系。
- byType：按类型自动装配。Spring 会根据 Java 类中的对象属性的类型，在整个应用的上下文 ApplicationContext（IoC 容器）中查找。若某个 Bean 的 class 属性值与这个对象属性的类型相匹配，则获取这个 Bean，并与当前的 Java 类的 Bean 建立关联关系。
- constructor：与 byType 模式相似，不同之处在与它应用于构造器参数（依赖项），如果在容器中没有找到与构造器参数类型一致的 Bean，那么将抛出异常。其实就是根据构造器参数的数据类型，进行 byType 模式的自动装配。
- default：表示默认采用上一级元素 <beans> 设置的自动装配规则（default-autowire）进行装配。
- no：默认值，表示不使用自动装配，Bean 的依赖关系必须通过 <constructor-arg>和 <property> 元素的 ref 属性来定义。

Spring 的自动装配功能让 Spring 容器依据选定的装配规则，为指定的 Bean 从应用的上下文（AppplicationContext 容器）中查找它所依赖的 Bean，并自动建立 Bean 之间的依赖关系。这一过程是在完全不使用任何 <constructor-arg>和 <property> 元素 ref 属性的情况下进行的。

Spring 的自动装配功能能够有效地简化 Spring 应用的 XML 配置，因此在配置数量相当多时采用自动装配降低工作量。

##### Bean作用域

默认情况下，所有的 Spring Bean 都是单例的，也就是说在整个 Spring 应用中， Bean 的实例只有一个。

我们可以在 <bean> 元素中添加 scope 属性来配置 Spring Bean 的作用范围。例如，如果每次获取 Bean 时，都需要一个新的 Bean 实例，那么应该将 Bean 的 scope 属性定义为 prototype，如果 Spring 需要每次都返回一个相同的 Bean 实例，则应将 Bean 的 scope 属性定义为 singleton。

Spring 5 共提供了 6 种 scope 作用域：
- singleton：默认值，单例模式，表示在 Spring 容器中只有一个 Bean 实例。
- prototype：原型模式，表示每次通过 Spring 容器获取 Bean 时，容器都会创建一个新的 Bean 实例。
- request：每次 HTTP 请求，容器都会创建一个 Bean 实例。该作用域只在当前 HTTP Request 内有效。
- session：同一个 HTTP Session 共享一个 Bean 实例，不同的 Session 使用不同的 Bean 实例。该作用域仅在当前 HTTP Session 内有效。
- application：同一个 Web 应用共享一个 Bean 实例，该作用域在当前 ServletContext 内有效。与 singleton 类似，但 singleton 表示每个 IoC 容器中仅有一个 Bean 实例，而一个 Web 应用中可能会存在多个 IoC 容器，但一个 Web 应用只会有一个 ServletContext，也可以说 application 才是 Web 应用中货真价实的单例模式。
- websocket：websocket 的作用域是 WebSocket ，即在整个 WebSocket 中有效。

除了 singleton 和 prototype 可以直接在常规的 Spring IoC 容器（例如 ClassPathXmlApplicationContext）中使用外，剩下的都只能在基于 Web 的 ApplicationContext 实现（例如 XmlWebApplicationContext）中才能使用，否则就会抛出一个 IllegalStateException 的异常。

##### Bean生命周期

在传统的 Java 应用中，Bean 的生命周期很简单，使用 Java 关键字 new 进行 Bean 的实例化后，这个 Bean 就可以使用了。一旦这个 Bean 长期不被使用，Java 自动进行垃圾回收。

相比之下，Spring 中 Bean 的生命周期较复杂，大致可以分为以下 5 个阶段：
- Bean 的实例化
- Bean 属性赋值
- Bean 的初始化
- Bean 的使用
- Bean 的销毁

Spring 根据 Bean 的作用域来选择 Bean 的管理方式：
- 对于 singleton 作用域的 Bean 来说，Spring IoC 容器能够精确地控制 Bean 何时被创建、何时初始化完成以及何时被销毁；
- 对于 prototype 作用域的 Bean 来说，Spring IoC 容器只负责创建，然后就将 Bean 的实例交给客户端代码管理，Spring IoC 容器将不再跟踪其生命周期。

Bean 的生命周期回调方法主要有两种：
- 初始化回调方法：在 Spring Bean 被初始化后调用，执行一些自定义的回调操作。
- 销毁回调方法：在 Spring Bean 被销毁前调用，执行一些自定义的回调操作。

可以通过 3 种方式自定义 Bean 的生命周期回调方法：
- 通过接口实现
- 通过 XML 配置实现
- 使用注解实现

如果一个 Bean 中有多种生命周期回调方法时，优先级顺序为：注解 > 接口 > XML 配置。

**执行过程**

- Spring 启动，查找并加载需要被 Spring 管理的 Bean，对 Bean 进行实例化。
- 对 Bean 进行属性注入。
- 如果 Bean 实现了 BeanNameAware 接口，则 Spring 调用 Bean 的 setBeanName() 方法传入当前 Bean 的 id 值。
- 如果 Bean 实现了 BeanFactoryAware 接口，则 Spring 调用 setBeanFactory() 方法传入当前工厂实例的引用。
- 如果 Bean 实现了 ApplicationContextAware 接口，则 Spring 调用 setApplicationContext() 方法传入当前 ApplicationContext 实例的引用。
- 如果 Bean 实现了 BeanPostProcessor 接口，则 Spring 调用该接口的预初始化方法 postProcessBeforeInitialzation() 对 Bean 进行加工操作，此处非常重要，Spring 的 AOP 就是利用它实现的。
- 如果 Bean 实现了 InitializingBean 接口，则 Spring 将调用 afterPropertiesSet() 方法。
- 如果在配置文件中通过 init-method 属性指定了初始化方法，则调用该初始化方法。
- 如果 BeanPostProcessor 和 Bean 关联，则 Spring 将调用该接口的初始化方法 postProcessAfterInitialization()。此时，Bean 已经可以被应用系统使用了。
- 如果在 <bean> 中指定了该 Bean 的作用域为 singleton，则将该 Bean 放入 Spring IoC 的缓存池中，触发 Spring 对该 Bean 的生命周期管理；如果在 <bean> 中指定了该 Bean 的作用域为 prototype，则将该 Bean 交给调用者，调用者管理该 Bean 的生命周期，Spring 不再管理该 Bean。
- 如果 Bean 实现了 DisposableBean 接口，则 Spring 会调用 destory() 方法销毁 Bean；如果在配置文件中通过 destory-method 属性指定了 Bean 的销毁方法，则 Spring 将调用该方法对 Bean 进行销毁。

BeanPostProcessor 接口也被称为后置处理器，通过该接口可以自定义调用初始化前后执行的操作方法。

### AOP

应用中往往存在一些非业务的通用功能，例如日志管理、权限管理、事务管理、异常管理等。这些通用功能虽然与应用的业务无关，但几乎所有的业务模块都会使用到它们，因此这些通用功能代码就只能横向散布式地嵌入到多个不同的业务模块之中。这无疑会产生大量重复性代码，不利于各个模块的复用。

将这些重复性代码封装成为公共函数，然后在业务模块中显式的调用，也能减少重复性代码。但是这样做增加了业务代码与公共函数的耦合性，任何对于公共函数的修改都会对所有与之相关的业务代码造成影响。

AOP 用来封装多个类的公共行为，将那些与业务无关，却为业务模块所共同调用的逻辑封装起来，减少系统的重复代码，降低模块间的耦合度。另外，AOP 还解决一些系统层面上的问题，比如日志、事务、权限等。

#### AOP 联盟
为了更好的应用 AOP 技术，技术专家们成立了 AOP 联盟（AOP Alliance）。AOP 联盟定义了一套用于规范 AOP 实现的底层 API，通过这些统一的底层 API，使得各个AOP 框架及工具产品之间可以相互移植。这些 API 主要以标准接口的形式提供，是 AOP 编程思想所要解决各种问题的最高抽象。所有的 AOP 框架都应该是对这些 AOP 接口规范的具体实现，因此通常我们也将 AOP 框架称作 AOP 实现。

目前最流行的 AOP 实现（框架）主要有两个，分别为 Spring AOP 和 AspectJ。

- Spring AOP 使用纯 Java 实现，不需要专门的编译过程和类加载器，在运行期间通过代理方式向目标类植入增强的代码。Spring AOP 支持 2 种代理方式，分别是基于接口的 JDK 动态代理和基于继承的 CGLIB 动态代理。
	+ JDK 动态代理	Spring AOP 默认的动态代理方式，若目标对象实现了若干接口，Spring 使用 JDK 的 java.lang.reflect.Proxy 类进行代理。
	+ CGLIB 动态代理	若目标对象没有实现任何接口，Spring 则使用 CGLIB 库生成目标对象的子类，以实现对目标对象的代理。
	+ 由于被标记为 final 的方法是无法进行覆盖的，因此这类方法不管是通过 JDK 动态代理机制还是 CGLIB 动态代理机制都是无法完成代理的。
- AspectJ 是一个基于 Java 语言的 AOP 框架，从 Spring 2.0 开始，Spring AOP 引入了对 AspectJ 的支持。AspectJ 扩展了 Java 语言，提供了一个专门的编译器，在编译时提供横向代码的植入。

#### AOP 术语
- Joinpoint（连接点）：AOP 的核心概念，指的是程序执行期间明确定义的一个点，例如方法的调用、类初始化、对象实例化等。在 Spring 中，连接点则指可以被动态代理拦截目标类的方法。
- Pointcut（切入点）：又称切点，指要对哪些 Joinpoint 进行拦截，即被拦截的连接点。
- Advice（通知）：指拦截到 Joinpoint 之后要执行的代码，即对切入点增强的内容。
	+ before（前置通知）：通知方法在目标方法调用之前执行
	+ after（后置通知）：通知方法在目标方法返回或异常后调用
	+ after-returning（返回后通知）：通知方法会在目标方法返回后调用
	+ after-throwing（抛出异常后通知）：通知方法会在目标方法抛出异常后调用
	+ around（环绕通知）：通知方法会将目标方法封装起来
- Target（目标）：指代理的目标对象，通常也被称为被通知（advised）对象。
- Weaving（织入）：指把增强代码应用到目标对象上，生成代理对象的过程。
- Proxy（代理）：指生成的代理对象。
- Aspect（切面）：切面是切入点（Pointcut）和通知（Advice）的结合。

#### AOP 的类型

##### 动态 AOP

动态 AOP 的织入过程是在运行时动态执行的。其中最具代表性的动态 AOP 实现就是 Spring AOP，它会为所有被通知的对象创建代理对象，并通过代理对象对被原对象进行增强。

相较于静态 AOP 而言，动态 AOP 的性能通常较差，但随着技术的不断发展，它的性能也在不断的稳步提升。

动态 AOP 的优点是它可以轻松地对应用程序的所有切面进行修改，而无须对主程序代码进行重新编译。

##### 静态 AOP

静态 AOP 是通过修改应用程序的实际 Java 字节码，根据需要修改和扩展程序代码来实现织入过程的。最具代表性的静态 AOP 实现是 AspectJ。

相较于动态 AOP 来说，性能较好。但它也有一个明显的缺点，那就是对切面的任何修改都需要重新编译整个应用程序。

#### Spring AOP

Spring AOP 是 Spring 提供的一种简化版的 AOP 组件。Spring AOP 只支持一种连接点类型：方法调用。Spring AOP 这样设计的原因是为了让 Spring 更易于访问。

方法调用连接点是迄今为止最有用的连接点，通过它可以实现日常编程中绝大多数与 AOP 相关的有用的功能。如果需要使用其他类型的连接点（例如成员变量连接点），可以将 Spring AOP 与其他的 AOP 实现一起使用，最常见的组合就是 Spring AOP + ApectJ。 

Spring AOP 为 Advice 接口提供了 6 个子接口：
- 前置通知`org.springframework.aop.MethodBeforeAdvice`：在目标方法执行前实施增强。
- 后置通知`org.springframework.aop.AfterReturningAdvice`：在目标方法执行后实施增强。
- 后置返回通知`org.springframework.aop.AfterReturningAdvice`：在目标方法执行完成，并返回一个返回值后实施增强。
- 环绕通知`org.aopalliance.intercept.MethodInterceptor`：在目标方法执行前后实施增强。
- 异常通知`org.springframework.aop.ThrowsAdvice`：在方法抛出异常后实施增强。
- 引入通知`org.springframework.aop.IntroductionInterceptor`：在目标类中添加一些新的方法和属性。

在 Spring AOP 中，切面可以分为三类：一般切面、切点切面和引介切面：
- 一般切面`org.springframework.aop.Advisor`：Spring AOP 默认的切面类型。
	+ 由于 Advisor 接口仅包含一个 Advice（通知）类型的属性，而没有定义 PointCut（切入点），因此它表示一个不带切点的简单切面。
	+ Spring AOP 基于 org.springframework.aop.framework.ProxyFactoryBean 类，根据目标对象的类型（是否实现了接口）自动选择使用 JDK 动态代理或 CGLIB 动态代理机制，为目标对象（Target Bean）生成对应的代理对象（Proxy Bean）。
	+ 这样的切面会对目标对象（Target）中的所有方法进行拦截并织入增强代码。这个切面太过宽泛，一般不会直接使用。
- 切点切面`org.springframework.aop.PointcutAdvisor`：表示带切点的切面，该接口在 Advisor 的基础上还维护了一个 PointCut（切点）类型的属性。
	+ 通过包名、类名、方法名等信息更加灵活的定义切面中的切入点，提供更具有适用性的切面。
- 引介切面`org.springframework.aop.IntroductionAdvisor`：是对应引介增强的特殊的切面。
	+ 引介切面应用于类层面上，适用 ClassFilter 进行定义。

一般切面中 ProxyFactoryBean 的常用属性如下所示：
- target：需要代理的目标对象（Bean）。
- proxyInterfaces：代理需要实现的接口。如果需要实现多个接口，可以通过 <list> 元素进行赋值。
- proxyTargetClass：针对类的代理。默认值为 false，表示使用 JDK 动态代理；取值为 true，表示使用 CGlib 动态代理。
- interceptorNames：拦截器的名字。取值既可以是拦截器、也可以是 Advice（通知）类型的 Bean，还可以是切面（Advisor）的 Bean。
- singleton：返回的代理对象是否为单例模式。默认值为 true。
- optimize：是否对创建的代理进行优化（只适用于CGLIB）。

在实际开发中，一个项目中往往包含非常多的 Bean，Spring 为我们提供了自动代理机制。Spring 提供的自动代理方案，都是基于后处理 Bean 实现的，即在 Bean 创建的过程中完成增强，并将目标对象替换为自动生成的代理对象。通过 Spring 的自动代理，我们在程序中直接拿到的 Bean 就已经是 Spring 自动生成的代理对象了。

Spring 为我们提供了 3 种自动代理方案：
- BeanNameAutoProxyCreator：根据 Bean 名称创建代理对象。
- DefaultAdvisorAutoProxyCreator：根据 Advisor 本身包含信息创建代理对象。
- AnnotationAwareAspectJAutoProxyCreator：基于 Bean 中的 AspectJ 注解进行自动代理对象。

Spring 提供了多个切点切面的实现，其中常用实现类如如下：
- NameMatchMethodPointcutAdvisor：指定 Advice 所要应用到的目标方法名称，例如 hello* 代表所有以 hello 开头的所有方法。
- RegExpMethodPointcutAdvisor：使用正则表达式来定义切点（PointCut），RegExpMethodPointcutAdvisor 包含一个 pattern 属性，该属性使用正则表达式描述需要拦截的方法。

##### AspectJ

Spring AOP 仅支持执行公共（public）非静态方法的调用作为连接点，如果我们需要向受保护的（protected）或私有的（private）的方法进行增强，此时就需要使用功能更加全面的 AOP 框架来实现，其中使用最多的就是 AspectJ。AspectJ 支持通过 Spring 配置 AspectJ 切面，它是 Spring AOP 的完美补充。

Spring 提供了基于 XML 的 AOP 支持，并提供了一个名为“aop”的命名空间，该命名空间提供了一个 <aop:config> 元素。
- 在 Spring 配置中，所有的切面信息（切面、切点、通知）都必须定义在 <aop:config> 元素中；
- 在 Spring 配置中，可以使用多个 <aop:config>。
- 每一个 <aop:config> 元素内可以包含 3 个子元素： pointcut、advisor 和 aspect ，这些子元素必须按照这个顺序进行声明。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:aop="http://www.springframework.org/schema/aop"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
    http://www.springframework.org/schema/aop
    http://www.springframework.org/schema/aop/spring-aop-3.0.xsd ">
    <aop:config>
    	<!-- 定义切面 -->
    	<aop:aspect id="myAspect" ref="aBean">
    		<!-- 前置通知 -->
 		   <aop:before pointcut-ref="myPointCut" method="..."/>
		    <!-- 后置通知 -->
		    <aop:after-returning pointcut-ref="myPointCut" method="..."/>
		    <!-- 环绕通知 -->
		    <aop:around pointcut-ref="myPointCut" method="..."/>
		    <!-- 异常通知 -->
		    <aop:after-throwing pointcut-ref="myPointCut" method="..."/>
		    <!-- 最终通知 -->
		    <aop:after pointcut-ref="myPointCut" method="..."/>
    	</aop:aspect>
    	<!-- 定义切入点 -->
    	<aop:pointcut id="myPointCut"
        expression="execution(* com.example.service.*.*(..))"/>
	</aop:config>
</beans>
```

execution 的语法格式格式为：
`execution([权限修饰符] [返回值类型] [类的完全限定名] [方法名称]([参数列表]) `

其中：
- 返回值类型、方法名、参数列表是必须配置的选项，而其它参数则为可选配置项。
- 返回值类型：`*`表示可以为任何返回值。如果返回值为对象，则需指定全路径的类名。
- 类的完全限定名：指定包名 + 类名。
- 方法名：`*`代表所有方法，`set*` 代表以 set 开头的所有方法。
- 参数列表：`(..)`代表所有参数；`(*)`代表只有一个参数，参数类型为任意类型；`(*,String)`代表有两个参数，第一个参数可以为任何值，第二个为 String 类型的值。

AspectJ 框架为 AOP 开发提供了一套 @AspectJ 注解。它允许我们直接在 Java 类中通过注解的方式对切面（Aspect）、切入点（Pointcut）和增强（Advice）进行定义，Spring 框架可以根据这些注解生成 AOP 代理。可以在 Java 配置类（标注了 @Configuration 注解的类）中，使用 @EnableAspectJAutoProxy 和 @ComponentScan 注解启用 @AspectJ 注解支持。

或者在 Spring 的 XML 配置文件中，添加以下内容启用 @AspectJ 注解支持。
```xml
<!-- 开启注解扫描 -->
<context:component-scan base-package="com.example.c"></context:component-scan>
<!--开启AspectJ 自动代理-->
<aop:aspectj-autoproxy></aop:aspectj-autoproxy>
```

- @Aspect	用于定义一个切面。
- @Pointcut	用于定义一个切入点。
- @Before	用于定义前置通知，相当于 BeforeAdvice。
- @AfterReturning	用于定义后置通知，相当于 AfterReturningAdvice。
- @Around	用于定义环绕通知，相当于 MethodInterceptor。
- @AfterThrowing	用于定义抛出通知，相当于 ThrowAdvice。
- @After	用于定义最终通知，不管是否异常，该通知都会执行。
- @DeclareParents	用于定义引介通知，相当于 IntroductionInterceptor。


### Spring JdbcTemplate

JDBC 是 Java 提供的一种用于执行 SQL 语句的 API，可以对多种关系型数据库（例如 MySQL、Oracle 等）进行访问。但在实际的企业级应用开发中，使用 JDBC API 对数据库进行操作十分繁琐，需要对每一步都做到“步步把控，处处关心”，例如需要手动控制数据库连接的开启，异常处理、事务处理、最后还要手动关闭连接释放资源等等。

Spring 提供了一个 Spring JDBC 模块，它对 JDBC API 进行了封装，其的主要目的降低 JDBC API 的使用难度，以一种更直接、更简洁的方式使用 JDBC API。使用 Spring JDBC，开发人员只需要定义必要的参数、指定需要执行的 SQL 语句，即可轻松的进行 JDBC 编程，对数据库进行访问。

至于驱动的加载、数据库连接的开启与关闭、SQL 语句的创建与执行、异常处理以及事务处理等繁杂乏味的工作，则都是由 Spring JDBC 完成的。这样就可以使开发人员从繁琐的 JDBC API 中解脱出来，有更多的精力专注于业务的开发。

Spring JDBC 提供了多个实用的数据库访问工具，以简化 JDBC 的开发，其中使用最多就是 JdbcTemplate。JdbcTemplate 是 Spring JDBC 核心包（core）中的核心类，它可以通过配置文件、注解、Java 配置类等形式获取数据库的相关信息，实现了对 JDBC 开发过程中的驱动加载、连接的开启和关闭、SQL 语句的创建与执行、异常处理、事务处理、数据类型转换等操作的封装。我们只要对其传入SQL 语句和必要的参数即可轻松进行 JDBC 编程。

JdbcTemplate 的全限定命名为 org.springframework.jdbc.core.JdbcTemplate，它提供了大量的查询和更新数据库的方法：
- public int update(String sql)	用于执行新增、更新、删除等语句；
	+ sql：需要执行的 SQL 语句；
	+ args 表示需要传入到 SQL 语句中的参数。
- public int update(String sql,Object... args)
- public void execute(String sql)	可以执行任意 SQL，一般用于执行 DDL 语句；
	+ sql：需要执行的 SQL 语句；
	+ action 表示执行完 SQL 语句后，要调用的函数。
- public T execute(String sql, PreparedStatementCallback action)
- public <T> List<T> query(String sql, RowMapper<T> rowMapper, @Nullable Object... args) 用于执行查询语句；
	+ sql：需要执行的 SQL 语句；
	+ rowMapper：用于确定返回的集合（List）的类型；
	+ args：表示需要传入到 SQL 语句的参数。
- public <T> T queryForObject(String sql, RowMapper<T> rowMapper, @Nullable Object... args)
- public int[] batchUpdate(String sql, List<Object[]> batchArgs, final int[] argTypes) 	用于批量执行新增、更新、删除等语句；
	+ sql：需要执行的 SQL 语句；
	+ argTypes：需要注入的 SQL 参数的 JDBC 类型；
	+ batchArgs：表示需要传入到 SQL 语句的参数。
	

### Spring Transaction

事务（Transaction）是基于关系型数据库（RDBMS）的企业应用的重要组成部分。

事务允许我们将几个或一组操作组合成一个要么全部成功、要么全部失败的工作单元。如果事务中的所有的操作都执行成功，那自然万事大吉。但如果事务中的任何一个操作失败，那么事务中所有的操作都会被回滚，已经执行成功操作也会被完全清除干净，就好像什么事都没有发生一样。

Spring 支持以下 2 种事务管理方式：
- 编程式事务管理：编程式事务管理是通过编写代码实现的事务管理。
	+ 这种方式能够在代码中精确地定义事务的边界，我们可以根据需求规定事务从哪里开始，到哪里结束。
	+ 事务规则与业务代码耦合度高，难以维护。
- 声明式事务管理：Spring 声明式事务管理在底层采用了 AOP 技术。
	+ 其最大的优点在于无须通过编程的方式管理事务，只需要在配置文件中进行相关的规则声明，就可以将事务规则应用到业务逻辑中。
	+ 易用性高，对业务代码没有侵入性，耦合度低，易于维护。

Spring 为不同的持久化框架或平台提供了不同的事务管理器（PlatformTransactionManager）接口实现：
- `org.springframework.jdbc.datasource.DataSourceTransactionManager`：使用 Spring JDBC 或 iBatis 进行持久化数据时使用。
- `org.springframework.orm.hibernate3.HibernateTransactionManager`：使用 Hibernate 3.0 及以上版本进行持久化数据时使用。
- `org.springframework.orm.jpa.JpaTransactionManager`：使用 JPA 进行持久化时使用。
- `org.springframework.jdo.JdoTransactionManager`：当持久化机制是 Jdo 时使用。
- `org.springframework.transaction.jta.JtaTransactionManager`：使用 JTA 来实现事务管理，在一个事务跨越多个不同的资源（即分布式事务）使用该实现。	

Spring 将 XML 配置中的事务信息封装到对象 TransactionDefinition 中，然后通过事务管理器的 getTransaction() 方法获得事务的状态（TransactionStatus），并对事务进行下一步的操作。
```java
public interface TransactionDefinition {
    int getPropagationBehavior(); // 获取事务的传播行为
    int getIsolationLevel(); // 获取事务的隔离级别
    String getName(); // 获取事务的名称
    int getTimeout(); // 获取事务的超时时间
    boolean isReadOnly(); // 获取事务是否只读
}
```

Spring 中提供了以下隔离级别，我们可以根据自身的需求自行选择合适的隔离级别。
- ISOLATION_DEFAULT：使用后端数据库默认的隔离级别。
- ISOLATION_READ_UNCOMMITTED：允许读取尚未提交的更改，可能导致脏读、幻读和不可重复读。
- ISOLATION_READ_COMMITTED：Oracle 默认级别，允许读取已提交的并发事务，防止脏读，可能出现幻读和不可重复读。
- ISOLATION_REPEATABLE_READ：MySQL 默认级别，多次读取相同字段的结果是一致的，防止脏读和不可重复读，可能出现幻读。
- ISOLATION_SERIALIZABLE：完全服从 ACID 的隔离级别，防止脏读、不可重复读和幻读。

在理想情况下，事务之间是完全隔离的，不会出现脏读、幻读和不可重复读问题。但完全的事务隔离会导致性能问题，而且并不是所有的应用都需要事务的完全隔离，因此有时应用程序在事务隔离上也有一定的灵活性。

事务传播行为（propagation behavior）指的是，当一个事务方法被另一个事务方法调用时，这个事务方法应该如何运行。事务方法指的是能让数据库表数据发生改变的方法，例如新增数据、删除数据、修改数据的方法。

Spring 提供了以下 7 种不同的事务传播行为：
- PROPAGATION_MANDATORY：支持当前事务，如果不存在当前事务，则引发异常。
- PROPAGATION_NESTED：如果当前事务存在，则在嵌套事务中执行。
- PROPAGATION_NEVER：不支持当前事务，如果当前事务存在，则引发异常。
- PROPAGATION_NOT_SUPPORTED：不支持当前事务，始终以非事务方式执行。
- PROPAGATION_REQUIRED：默认传播行为，如果存在当前事务，则当前方法就在当前事务中运行，如果不存在，则创建一个新的事务，并在这个新建的事务中运行。
- PROPAGATION_REQUIRES_NEW：创建新事务，如果已经存在事务则暂停当前事务。
- PROPAGATION_SUPPORTS：支持当前事务，如果不存在事务，则以非事务方式执行。


TransactionStatus 接口提供了一些简单的方法，来控制事务的执行、查询事务的状态，接口定义如下。
```java
public interface TransactionStatus extends SavepointManager {
    boolean isNewTransaction(); // 获取是否是新事务
    boolean hasSavepoint(); // 获取是否存在保存点
    void setRollbackOnly(); // 设置事务回滚
    boolean isRollbackOnly(); // 获取事务是否回滚
    boolean isCompleted(); // 获取事务是否完成
}
```

### Spring SpEL

Spring Expression Language（简称 SpEL）是一种功能强大的表达式语言，支持运行时查询和操作对象图。表达式语言一般是用最简单的形式完成最主要的工作，以此减少工作量。

Java 有许多可用的表达式语言，例如 JSP EL，OGNL，MVEL 和 JBoss EL，SpEL 语法类似于 JSP EL，功能类似于 Struts2 中的 OGNL，能在运行时构建复杂表达式、存取对象图属性、调用对象方法等，并且能与 Spring 功能完美整合，如 SpEL 可以用来配置 Bean 定义。

SpEL 并不与 Spring 直接相关，可以被独立使用。SpEL 表达式的创建是为了向 Spring 社区提供一种受良好支持的表达式语言，该语言适用于 Spring 家族中的所有产品。也就是说，SpEL 是一种与技术无关的 API，可以集成其它表达式语言。

SpEL 提供了以下接口和类：
- Expression interface：该接口负责评估表达式字符串。
- ExpressionParser interface：该接口负责解析字符串。
- EvaluationContext interface：该接口负责定义上下文环境。

SpEL 支持如下表达式：
1. 基本表达式
	+ 字面量表达式、关系、逻辑与算术运算表达式、字符串连接及截取表达式、三目运算表达式、正则表达式、括号优先级表达式；
2. 类相关表达式
	+ 类类型表达式、类实例化、instanceof 表达式、变量定义及引用、赋值表达式、自定义函数、对象属性存取及安全导航表达式、对象方法调用、Bean 引用；
3. 集合相关表达式
	+ 内联 List、内联数组、集合、字典访问、列表、字典、数组修改、集合投影、集合选择；不支持多维内联数组初始化；不支持内联字典定义；
4. 其他表达式
	+ 模板表达式。

注：SpEL 表达式中的关键字不区分大小写。

#### SpEL对Bean定义的支持

SpEL 表达式可以与 XML 或基于注解的配置元数据一起使用，SpEL 表达式以#{开头，以}结尾，如#{'Hello'}。
```xml
<!-- 使用以下表达式来设置属性或构造函数的参数值。 -->
<bean id="number" class="com.example.Number">
    <property name="randomNumber" value="#{T(java.lang.Math).random() * 100.0}"/>
</bean>
<!-- 通过名称引用其它 Bean 属性。 -->
<bean id="shapeGuess" class="com.example.ShapeGuess">
    <property name="shapSeed" value="#{number.randomNumber}"/>
</bean>
```
```java
// @Value 注解可以放在字段、方法、以及构造函数参数上，以指定默认值。

public static class FieldValueTestBean
    @value("#{ systemProperties[ 'user.region'] }")
    private String defaultLocale;
    public void setDefaultLocale (String defaultLocale) {
        this.defaultLocale = defaultLocale;
    }
    public string getDefaultLocale() {
        return this.defaultLocale;
    }
}
```

### Spring整合日志框架Log4j2

对于一款软件而言，日志记录都是十分重要的。它不仅能够监控程序的运行情况，周期性的记录到文件中，还能够跟踪程序中代码的运行轨迹，向文件或控制台打印代码的调试信息。当程序出现错误时，日志记录可以帮助开发人员及时定位问题，因此对开发人员来说，日志记录更是尤为重要。

Spring 5 框架自带了通用的日志封装，但依然可以整合其他的日志框架对日志进行记录，其中最广为人知的就是大名鼎鼎的 Log4j。

#### Log4j

Log4j 是 Apache 提供的一款开源的强有力的 Java 日志记录工具。它可以通过配置文件灵活、细致地控制日志的生成过程，例如日志级别、日志的输出类型、日志的输出方式以及输出格式等。

Log4j 共有两个大版本，如下所示：
- Log4j 1.x 1999 年至 2015 年：即我们常说的 Log4j，它于 1999 年首次发布，就迅速成为有史以来最常用的日志框架。
	+ 2015 年 8 月 5 日，Apache Logging Services 宣布 Log4j 1.x 生命周期结束，其代码库不再发布更新，并鼓励用户升级到 Log4j 2.x。
- Log4j 2.x	2014 年至今：即 Log4j2，2014 年 Log4j 2.x 作为 Log4j 1.x 的替代品发布。

Log4j 2.x 是对 Log4j 1.x 的重大升级，它完全重写了 Log4j 的日志实现，比 Log4j 1.x 效率更高、更可靠且更易于开发和维护。此外，Log4j 2.x 还对 Logback 进行了许多改进，修复了 Logback 架构中的一些固有问题。

特别注意：由于 Log4j2 在 2021 年 12 月 10 日被曝存在远程代码执行漏洞，所有 Apache Log4j 2.x <= 2.14.1 版本均受到影响。随后，Log4j2 官方对此漏洞进行了了修复。

#### Spring 整合 Log4j2

Spring 5 是基于 Java 8 实现的，其自身作了不少的优化，将许多不建议使用的类和方法从代码库中删除，其中就包括了 Log4jConfigListener（Spring 加载 Log4j  配置的监听器）。因此从 Spring 5 开始就不在支持对 Log4j 的整合，而更加推荐我们通过 Log4j2 进行日志记录。

```
log4j-api-2.17.1.jar
log4j-core-2.17.1.jar
log4j-slf4j18-impl-2.17.1.jar 绑定到 SLF4J 的配置器

log4j-slf4j-impl-x.x.x.jar 应该与 SLF4J 1.7.x 版本或更早版本一起使用。
log4j-slf4j18-impl-x.x.x.jar 应该与 SLF4J 1.8.x 版本或更高版本一起使用。
```

