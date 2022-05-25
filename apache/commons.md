## Apache commons

Apache Commons 是一个 Apache 项目，专注于可重用 Java 组件的所有方面。

The Apache Commons project is composed of three parts:

- The Commons Proper - A repository of reusable Java components.
- The Commons Sandbox - A workspace for Java component development.
- The Commons Dormant - A repository of components that are currently inactive.

http://commons.apache.org

#### Apache Commons Proper
Commons Proper 致力于一个主要目标：创建和维护可重用的 Java 组件。

| Component                            | Description                                                  | Latest Version | Release Date |
| ------------------------------------ | ------------------------------------------------------------ | -------------- | ------------ |
| BCEL                                 | Byte Code Engineering Library - analyze, create, and manipulate Java class files | 6.5.0          | 2020-06-05   |
| BeanUtils                            | Easy-to-use wrappers around the Java reflection and introspection APIs. | 1.9.4          | 2019-08-13   |
| BSF                                  | Bean Scripting Framework - interface to scripting languages, including JSR-223 | 3.1            | 2010-06-24   |
| Chain                                | Chain of Responsibility pattern implemention.                | 1.2            | 2008-06-02   |
| CLI                                  | Command Line arguments parser.                               | 1.5.0          | 2021-10-27   |
| Codec                                | General encoding/decoding algorithms (for example phonetic, base64, URL). | 1.15           | 2020-09-01   |
| Collections                          | Extends or augments the Java Collections Framework.          | 4.4            | 2019-07-05   |
| Compress                             | Defines an API for working with tar, zip and bzip2 files.    | 1.21           | 2021-07-12   |
| Configuration                        | Reading of configuration/preferences files in various formats. | 2.7            | 2020-03-11   |
| Crypto                               | A cryptographic library optimized with AES-NI wrapping Openssl or JCE algorithm implementations. | 1.1.0          | 2020-08-28   |
| CSV                                  | Component for reading and writing comma separated value files. | 1.8            | 2020-02-01   |
| Daemon                               | Alternative invocation mechanism for unix-daemon-like java code. | 1.2.4          | 2021-01-21   |
| DBCP                                 | Database connection pooling services.                        | 2.8.0          | 2020-09-21   |
| DbUtils                              | JDBC helper library.                                         | 1.7            | 2017-07-20   |
| Digester                             | XML-to-Java-object mapping utility.                          | 3.2            | 2011-12-13   |
| Email                                | Library for sending e-mail from Java.                        | 1.5            | 2017-08-01   |
| Exec                                 | API for dealing with external process execution and environment management in Java. | 1.3            | 2014-11-06   |
| FileUpload                           | File upload capability for your servlets and web applications. | 1.4            | 2019-01-16   |
| Functor                              | A functor is a function that can be manipulated as an object, or an object representing a single, generic function. | 1.0            | 2011-??-??   |
| Geometry                             | Space and coordinates.                                       | 1.0-beta1      | 2020-07-19   |
| Imaging (previously called Sanselan) | A pure-Java image library.                                   | 1.0-alpha2     | 2020-08-01   |
| IO                                   | Collection of I/O utilities.                                 | 2.11.0         | 2021-07-13   |
| JCI                                  | Java Compiler Interface                                      | 1.1            | 2013-10-14   |
| JCS                                  | Java Caching System                                          | 3.0            | 2020-08-16   |
| Jelly                                | XML based scripting and processing engine.                   | 1.0.1          | 2017-09-25   |
| Jexl                                 | Expression language which extends the Expression Language of the JSTL. | 3.2            | 2021-06-07   |
| JXPath                               | Utilities for manipulating Java Beans using the XPath syntax. | 1.3            | 2008-08-14   |
| Lang                                 | Provides extra functionality for classes in java.lang.       | 3.12.0         | 2021-02-26   |
| Logging                              | Wrapper around a variety of logging API implementations.     | 1.2            | 2014-07-11   |
| Math                                 | Lightweight, self-contained mathematics and statistics components. | 3.5            | 2015-04-17   |
| Net                                  | Collection of network utilities and protocol implementations. | 3.8.0          | 2020-02-13   |
| Numbers                              | Number types (complex, quaternion, fraction) and utilities (arrays, combinatorics). | 1.0-beta1      | 2020-04-08   |
| OGNL                                 | An Object-Graph Navigation Language                          | 4.0            | 2013-??-??   |
| Pool                                 | Generic object pooling component.                            | 2.10.0         | 2021-06-01   |
| Proxy                                | Library for creating dynamic proxies.                        | 1.0            | 2008-02-28   |
| RDF                                  | Common implementation of RDF 1.1 that could be implemented by systems on the JVM. | 0.5.0          | 2017-12-23   |
| RNG                                  | Implementations of random numbers generators.                | 1.3            | 2019-11-11   |
| SCXML                                | An implementation of the State Chart XML specification aimed at creating and maintaining a Java SCXML engine.It is capable of executing a state machine defined using a SCXML document, and abstracts out the environment interfaces. | 0.9            | 2008-12-01   |
| Statistics                           | Statistics.                                                  | 1.0-beta1      | 2020-04-30   |
| Text                                 | Apache Commons Text is a library focused on algorithms working on strings. | 1.9            | 2020-07-21   |
| Validator                            | Framework to define validators and validation rules in an xml file. | 1.7            | 2020-08-07   |
| VFS                                  | Virtual File System component for treating files, FTP, SMB, ZIP and such like as a single logical file system. | 2.8.0          | 2021-03-06   |
| Weaver                               | Provides an easy way to enhance (weave) compiled bytecode.   | 2.0            | 2018-09-07   |

##### BeanUtils
Commons-BeanUtils 提供对 Java 反射和自省API的包装

##### Betwixt
Betwixt提供将 JavaBean 映射至 XML 文档，以及相反映射的服务.

##### Chain
Chain 提供实现组织复杂的处理流程的“责任链模式”.

##### CLI
CLI 提供针对命令行参数，选项，选项组，强制选项等的简单API.

##### Codec
Codec 包含一些通用的编码解码算法。包括一些语音编码器， Hex, Base64, 以及URL encoder.

##### Collections
Commons-Collections 提供一个类包来扩展和增加标准的 Java Collection框架

##### Compress
Defines an API for working with tar, zip and bzip2 files.

##### Configuration
Commons-Configuration 工具对各种各式的配置和参考文件提供读取帮助.

##### Daemon
一种 unix-daemon-like java 代码的替代机制

##### DBCP
Commons-DBCP 提供数据库连接池服务

##### DbUtils
DbUtils 是一个 JDBC helper 类库，完成数据库任务的简单的资源清除代码.

##### Digester
Commons-Digester 是一个 XML-Java对象的映射工具，用于解析 XML配置文件.

##### Discovery
Commons-Discovery 提供工具来定位资源 (包括类) ，通过使用各种模式来映射服务/引用名称和资源名称。.

##### EL
Commons-EL 提供在JSP2.0规范中定义的EL表达式的解释器.

##### FileUpload
FileUpload 使得在你可以在应用和Servlet中容易的加入强大和高性能的文件上传能力

##### HttpClient
Commons-HttpClient 提供了可以工作于HTTP协议客户端的一个框架.

##### IO
IO 是一个 I/O 工具集

##### Jelly
Jelly是一个基于 XML 的脚本和处理引擎。 Jelly 借鉴了 JSP 定指标签，Velocity, Cocoon和Xdoclet中的脚本引擎的许多优点。Jelly 可以用在命令行， Ant 或者 Servlet之中。

##### Jexl
Jexl是一个表达式语言，通过借鉴来自于Velocity的经验扩展了JSTL定义的表达式语言。.

##### JXPath
Commons-JXPath 提供了使用Xpath语法操纵符合Java类命名规范的 JavaBeans的工具。也支持 maps, DOM 和其他对象模型。.

##### Lang
Commons-Lang 提供了许多许多通用的工具类集，提供了一些java.lang中类的扩展功能

##### Latka
Commons-Latka 是一个HTTP 功能测试包，用于自动化的QA,验收和衰减测试.

##### Launcher
Launcher 组件是一个交叉平台的Java 应用载入器。 Commons-launcher 消除了需要批处理或者Shell脚本来载入Java 类。.原始的 Java 类来自于Jakarta Tomcat 4.0 项目

##### Logging
Commons-Logging 是一个各种 logging API实现的包裹类.

##### Math
Math 是一个轻量的，自包含的数学和统计组件，解决了许多非常通用但没有及时出现在Java标准语言中的实践问题.

##### Modeler
Commons-Modeler 提供了建模兼容JMX规范的 Mbean的机制.

##### Net
Net 是一个网络工具集，基于 NetComponents 代码，包括 FTP 客户端等等。

##### Pool
Commons-Pool 提供了通用对象池接口，一个用于创建模块化对象池的工具包，以及通常的对象池实现.

##### Primitives
Commons-Primitives提供了一个更小，更快和更易使用的对Java基本类型的支持。当前主要是针对基本类型的 collection。.

##### Validator
The commons-validator提供了一个简单的，可扩展的框架来在一个XML文件中定义校验器 (校验方法)和校验规则。支持校验规则的和错误消息的国际化。

#### Apache Commons Sandbox
一个对所有 Apache 提交者开放的工作区。这是一个尝试新想法并准备纳入项目的 Commons 部分或另一个 Apache 项目的地方。用户可以自由试验在沙箱中开发的组件。

#### Apache Commons Dormant

这些是被视为不活跃的 Commons 组件，因为它们最近几乎没有看到开发活动。

如果您想使用这些组件中的任何一个，您必须自己构建它们。最好假设这些组件不会在不久的将来发布。
