一节：struts2、spring、hibernate框架官方下载地址说明

分别去网上下载这3个开源框架，下载地址： 
Struts2:http://struts.apache.org/2.2.3/index.html 
hibernate3:http://sourceforge.net/projects/hibernate/files/hibernate3/ 
spring3:http://www.springsource.org/download 


二节：struts2、spring、hibernate框架需要的包及详细说明

通过这个过程，了解SSH框架所需要的jar包，以及它们的各自用途。下面是我引入的最小jar包的列表： 
Struts2   9个 
1.struts2-core-2.2.3.jar struts的核心jar包。 
2.freemarker-2.3.16.jar Freemarker是struts2默认的模版语言 
3.commons-logging-1.1.1.jar Apache  Commons包中的一个，包含了日志功能，必须使用的jar包 
4.ognl-3.0.1.jar Struts2默认的表达式语言OGNL:对象图形化导航语言 
5.xwork-core-2.2.3.jar Struts2核心包，毕竟struts2很大部分是来webwork
6.commons-io-2.0.1.jar 封装了一些输入输出流的常用操作 
7.commons-fileupload-1.2.2.jar 用来实现文件上传 
8. struts2-json-plugin-2.2.3.jar JSON 插件提供了一个 "json" 结果类型来把 action 序列化成 JSON 
9. struts2-spring-plugin-2.1.6.jar 使struts2能集成到spring中 

Spring框架 13个 
1.org.springframework.aop.jar 包含在应用中使用Spring的AOP特性时所需的类 
2.org.springframework.beans.jar 所有应用都要用到的，它包含访问配置文件、创建和管理bean以及进行Inversion of Control / Dependency Injection（IoC/DI）操作相关的所有类。 
3.org.springframework.context.support.jar 包含支持缓存Cache（ehcache）、JCA、JMX、邮件服务（Java Mail、COS Mail）、任务计划Scheduling（Timer、Quartz）方面的类。 
4.org.springframework.context.jar 为Spring核心提供了大量扩展。可以找到使用Spring ApplicationContext特性时所需的全部类，JDNI所需的全部类，UI方面的用来与模板（Templating）引擎如 Velocity、FreeMarker、 JasperReports集成的类，以及校验Validation方面的相关类。 
5.org.springframework.core.jar 包含Spring框架基本的核心工具类，Spring其它组件要都要使用到这个包里的类，是其它组件的基本核心。 
6.org.springframework.expression.jar Spring表达式语言 
7.org.springframework.jdbc.jar 包含对Spring对JDBC数据访问进行封装的所有类。 
8.org.springframework.jms.jar 提供了对JMS 1.0.2/1.1的支持类。 
9.org.springframework.orm.jar 包含Spring对DAO特性集进行了扩展，使其支持 iBATIS、JDO、OJB、TopLink，因为Hibernate已经独立成包了，现在不包含在这个包里了。这个jar文件里大部分的类都要依赖spring-dao.jar里的类，用这个包时你需要同时包含spring-dao.jar包。 
10.org.springframework.transaction.jar 为JDBC、Hibernate、JDO、JPA等提供的一致的声明式和编程式事务管理。 
11.org.springframework.web.struts.jar Struts框架支持，可以更方便更容易的集成Struts框架。 
12.org.springframework.web.jar 包含Web应用开发时，用到Spring框架时所需的核心类，包括自动载入WebApplicationContext特性的类、Struts与JSF集成类、文件上传的支持类、Filter类和大量工具辅助类。 
13.org.springframework.asm.jar Spring独立的asm程序, Spring2.5.6的时候需要asmJar 包,3.0开始提供他自己独立的asmJar 

Hibernate3框架10个 

1.hibernate3.jar 这个是hibernate3.0的核心jar包，必须的，呵呵，没的选，像我们常用的Session,Query,Transaction都位于这个jar文件中，必要。
2.cglib-2.1.3.jar CGLIB库，Hibernate用它来实现PO字节码的动态生成，非常核心的库，必要。
3.asm.jar      ASM字节码库 如果使用“cglib”则必要，必要 
4.asm-attrs.jar     ASM字节码库 如果使用“cglib”则必要，必要 
5.ehcache.jar      EHCache缓存 如果没有其它缓存，则必要，必要 
6.antlr.jar     语言转换工,Hibernate利用它实现 HQL 到 SQL。 ANother Tool for Language Recognition是一个工具，必要
7.jta.jar JTA规范，当Hibernate使用JTA的时候需要，不过AppServer都会带上，所以也是多余的。但是为了测试方便建议还是带上。必要 
8.commons-collections.jar ApacheCommons包中的一个，包含了一些Apache开发的集合类，功能比java.util.*强大。必要 
9.dom4j 是一个Java的XMLAPI，类似于jdom，用来读写XML文件的。Hibernate用它来读写配置文件。必要 
10.C3P0.jar  C3P0数据库连接池提供数据库连接池 


其他4个 
1. com.springsource.javax.mail-1.4.0.jar Java email组建，提供email的常用方法 
2. mysql-connector-java-5.0.8-bin.jar mysql数据库驱动 
3. commons-lang-2.3.jar Apache Commons包中的一个，包含了一些数据类型工具类，是java.lang.*的扩展。必须使用的jar包http://commons.apache.org/lang/ 
4. log4j-1.2.15.jar 提供日志功能http://logging.apache.org/log4j/ 

单元测试和其他
junit-4.10.jar
xercesImpl-2.8.1.jar   ---这里用到Base64编码(可以不引入)



三节：ssh框架相关配置文件说明

配置SSH开发框架 

1）引入struts+spring+hibernate所需要的包，包列表在最小jar表格中有说明。 


2）在web.xml中加入如下代码令服务器自动加载Spring 
<!-- 令服务器自动加载Spring -->
<listener>  
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>  
</listener>  
<context-param>  
        <param-name>contextConfigLocation</param-name>  
        <param-value>classpath*:applicationContext.xml</param-value>  
</context-param> 

3）整合struts2 
    (1).Spring与struts的整合，就是将struts的action类交给spring进行管理。需要导入所需要的jar包。Struts2-spring-plugin.jar 
    (2).配置web.xml文件，在web.xml文件中添加下面的代码 

在Struts 2中，Struts框架是通过Filter启动的
  <!-- 配置Struts2 核心 Filter -->
  <filter>
      <filter-name>struts2</filter-name>
      <filter-class>
          org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter
      </filter-class>
  </filter>
  <filter>  
        <filter-name>struts-cleanup</filter-name>  
        <filter-class>org.apache.struts2.dispatcher.ActionContextCleanUp</filter-class>  
    </filter>  
    <filter-mapping>  
        <filter-name>struts-cleanup</filter-name>  
        <url-pattern>/*</url-pattern>  
    </filter-mapping>  
    <filter>  
        <filter-name>encodingFilter</filter-name>  
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>  
        <init-param>  
            <param-name>encoding</param-name>  
            <param-value>UTF-8</param-value>  
        </init-param>  
    </filter>  
  <filter-mapping>
      <filter-name>struts2</filter-name>
      <url-pattern>/*</url-pattern>
  </filter-mapping>
  <filter-mapping>  
        <filter-name>encodingFilter</filter-name>  
        <url-pattern>*.action</url-pattern>  
    </filter-mapping>  
    <filter-mapping>  
        <filter-name>encodingFilter</filter-name>  
        <url-pattern>*.jsp</url-pattern>  
    </filter-mapping>  
在StrutsPrepareAndExecuteFilter的init()方法中将会读取类路径下默认的配置文件struts.xml完成初始化操作。
　　注意：struts 2 读取到 struts.xml的内容后，以javabean形式存放在内存中，以后Struts 2对用户的每一次请求处理将使用内存中的数据。
　　Filter 过滤器是用户请求和处理程序之间的一层处理程序。它可以对用户请求和处理程序响应的类容进行处理，通常用于权限、编码转换等场合。

 (3). spring管理struts2的action，以userLoginAction为例。 
















