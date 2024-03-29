## Java SE Platform

前身：J2SE，2005年之后更名为JAVA SE
Java 2 Platform, Standard Edition


### Java SE Platform 软件包

#### rt.jar

- com.sun.xxx
- com.oracle.xxx
- sun.xxx

- java.applet 提供创建 applet 所必需的类和 applet 用来与其 applet 上下文通信的类。

- java.awt    包含用于创建用户界面和绘制图形图像的所有类。
- java.awt.color  提供用于颜色空间的类。
- java.awt.datatransfer   提供在应用程序之间和在应用程序内部传输数据的接口和类。
- java.awt.dnd    Drag 和 Drop 是一种直接操作动作，在许多图形用户界面系统中都会遇到它，它提供了一种机制，能够在两个与 GUI 中显示元素逻辑相关的实体之间传输信息。
- java.awt.event  提供处理由 AWT 组件所激发的各类事件的接口和类。
- java.awt.font   提供与字体相关的类和接口。
- java.awt.geom   提供用于在与二维几何形状相关的对象上定义和执行操作的 Java 2D 类。
- java.awt.im 提供输入方法框架所需的类和接口。
- java.awt.im.spi 提供启用可以与 Java 运行时环境一起使用的输入方法开发的接口。
- java.awt.image  提供创建和修改图像的各种类。
- java.awt.image.renderable   提供用于生成与呈现无关的图像的类和接口。
- java.awt.print  为通用的打印 API 提供类和接口。

- java.beans  包含与开发 beans 有关的类，即基于 JavaBeansTM 架构的组件。
- java.beans.beancontext  提供与 bean 上下文有关的类和接口。

- java.io 通过数据流、序列化和文件系统提供系统输入和输出。

- java.lang   提供利用 Java 编程语言进行程序设计的基础类。
- java.lang.annotation    为 Java 编程语言注释设施提供库支持。
- java.lang.instrument    提供允许 Java 编程语言代理检测运行在 JVM 上的程序的服务。
- java.lang.management    提供管理接口，用于监视和管理 Java 虚拟机以及 Java 虚拟机在其上运行的操作系统。
- java.lang.ref   提供了引用对象类，支持在某种程度上与垃圾回收器之间的交互。
- java.lang.reflect   提供类和接口，以获得关于类和对象的反射信息。

- java.math   提供用于执行任意精度整数算法 (BigInteger) 和任意精度小数算法 (BigDecimal) 的类。

- java.net    为实现网络应用程序提供类。

- java.nio    定义作为数据容器的缓冲区，并提供其他 NIO 包的概述。
- java.nio.channels   定义了各种通道，这些通道表示到能够执行 I/O 操作的实体（如文件和套接字）的连接；定义了用于多路复用的、非阻塞 I/O 操作的选择器。
- java.nio.channels.spi   用于 java.nio.channels 包的服务提供者类。
- java.nio.charset    定义用来在字节和 Unicode 字符之间转换的 charset、解码器和编码器。
- java.nio.charset.spi    java.nio.charset 包的服务提供者类。

- java.rmi    提供 RMI 包。
- java.rmi.activation 为 RMI 对象激活提供支持。
- java.rmi.dgc    为 RMI 分布式垃圾回收提供了类和接口。
- java.rmi.registry   提供 RMI 注册表的一个类和两个接口。
- java.rmi.server 提供支持服务器端 RMI 的类和接口。

- java.security   为安全框架提供类和接口。
- java.security.acl   此包中的类和接口已经被 java.security 包中的类取代。
- java.security.cert  提供用于解析和管理证书、证书撤消列表 (CRL) 和证书路径的类和接口。
- java.security.interfaces    提供的接口用于生成 RSA Laboratory Technical Note PKCS#1 中定义的 RSA（Rivest、Shamir 和 Adleman AsymmetricCipher 算法）密钥，以及 NIST 的 FIPS-186 中定义的 DSA（数字签名算法）密钥。
- java.security.spec  提供密钥规范和算法参数规范的类和接口。

- java.sql    提供使用 JavaTM 编程语言访问并处理存储在数据源（通常是一个关系数据库）中的数据的 API。

- java.text   提供以与自然语言无关的方式来处理文本、日期、数字和消息的类和接口。
- java.text.spi   java.text 包中类的服务提供者类。

- java.time   

- java.util   包含 collection 框架、遗留的 collection 类、事件模型、日期和时间设施、国际化和各种实用工具类（字符串标记生成器、随机数生成器和位数组）。
- java.util.concurrent    在并发编程中很常用的实用工具类。
- java.util.concurrent.atomic 类的小工具包，支持在单个变量上解除锁的线程安全编程。
- java.util.concurrent.locks  为锁和等待条件提供一个框架的接口和类，它不同于内置同步和监视器。
- java.util.jar   提供读写 JAR (Java ARchive) 文件格式的类，该格式基于具有可选清单文件的标准 ZIP 文件格式。
- java.util.logging   提供 JavaTM 2 平台核心日志工具的类和接口。
- java.util.prefs 此包允许应用程序存储并获取用户和系统首选项和配置数据。
- java.util.regex 用于匹配字符序列与正则表达式指定模式的类。
- java.util.spi   java.util 包中类的服务提供者类。
- java.util.zip   提供用于读写标准 ZIP 和 GZIP 文件格式的类。


- javax.accessibility 定义了用户界面组件与提供对这些组件进行访问的辅助技术之间的协定。

- javax.activation
- javax.activity  包含解组期间通过 ORB 机制抛出的与 Activity 服务有关的异常。

- javax.annotation
- javax.annotation.processing 用来声明注释处理器并允许注释处理器与注释处理工具环境通信的工具。

- javax.imageio   Java Image I/O API 的主要包。
- javax.imageio.event Java Image I/O API 的一个包，用于在读取和写入图像期间处理事件的同步通知。
- javax.imageio.metadata  用于处理读写元数据的 Java Image I/O API 的包。
- javax.imageio.plugins.bmp   包含供内置 BMP 插件使用的公共类的包。
- javax.imageio.plugins.jpeg  支持内置 JPEG 插件的类。
- javax.imageio.spi   包含用于 reader、writer、transcoder 和流的插件接口以及一个运行时注册表的 Java Image I/O API 包。
- javax.imageio.stream    Java Image I/O API 的一个包，用来处理从文件和流中产生的低级别 I/O。

- javax.jws
- javax.jws.soap

- javax.lang.model    用来为 Java 编程语言建立模型的包的类和层次结构。
- javax.lang.model.element    用于 Java 编程语言的模型元素的接口。
- javax.lang.model.type   用来为 Java 编程语言类型建立模型的接口。
- javax.lang.model.util   用来帮助处理程序元素和类型的实用工具。

- javax.management    提供 Java Management Extensions 的核心类。
- javax.management.loading    提供实现高级动态加载的类。
- javax.management.modelmbean 提供了 ModelMBean 类的定义。
- javax.management.monitor    提供 monitor 类的定义。
- javax.management.openmbean  提供开放数据类型和 Open MBean 描述符类。
- javax.management.relation   提供 Relation Service 的定义。
- javax.management.remote 对 JMX MBean 服务器进行远程访问使用的接口。
- javax.management.remote.rmi RMI 连接器是供 JMX Remote API 使用的一种连接器，后者使用 RMI 将客户端请求传输到远程 MBean 服务器。
- javax.management.timer  提供对 Timer MBean（计时器 MBean）的定义。

- javax.naming    为访问命名服务提供类和接口。
- javax.naming.directory  扩展 javax.naming 包以提供访问目录服务的功能。
- javax.naming.event  在访问命名和目录服务时提供对事件通知的支持。
- javax.naming.ldap   提供对 LDAPv3 扩展操作和控件的支持。
- javax.naming.spi    提供一些方法来动态地插入对通过 javax.naming 和相关包访问命名和目录服务的支持。

- javax.net   提供用于网络应用程序的类。
- javax.net.ssl   提供用于安全套接字包的类。

- javax.print 为 JavaTM Print Service API 提供了主要类和接口。
- javax.print.attribute   提供了描述 JavaTM Print Service 属性的类型以及如何分类这些属性的类和接口。
- javax.print.attribute.standard  包 javax.print.attribute.standard 包括特定打印属性的类。
- javax.print.event   包 javax.print.event 包含事件类和侦听器接口。

- javax.rmi   包含 RMI-IIOP 的用户 API。
- javax.rmi.CORBA 包含用于 RMI-IIOP 的可移植性 API。
- javax.rmi.ssl   通过安全套接字层 (SSL) 或传输层安全 (TLS) 协议提供 RMIClientSocketFactory 和 RMIServerSocketFactory 的实现。

- javax.script    脚本 API 由定义 Java TM Scripting Engines 的接口和类组成，并为它们在 Java 应用程序中的使用提供框架。

- javax.security.auth 此包提供用于进行验证和授权的框架。
- javax.security.auth.callback    此包提供与应用程序进行交互所必需的类，以便检索信息（例如，包括用户名和密码的验证数据）或显示信息（例如，错误和警告消息）。
- javax.security.auth.kerberos    此包包含与 Kerberos 网络验证协议相关的实用工具类。
- javax.security.auth.login   此包提供可插入的验证框架。
- javax.security.auth.spi 此包提供用于实现可插入验证模块的接口。
- javax.security.auth.x500    此包包含应该用来在 Subject 中存储 X500 Principal 和 X500 Private Crendentials 的类。
- javax.security.cert 为公钥证书提供类。
- javax.security.sasl 包含用于支持 SASL 的类和接口。

- javax.smartcardio

- javax.sound.midi    提供用于 MIDI（音乐乐器数字接口）数据的 I/O、序列化和合成的接口和类。
- javax.sound.midi.spi    在提供新的 MIDI 设备、MIDI 文件 reader 和 writer、或音库 reader 时提供服务提供者要实现的接口。
- javax.sound.sampled 提供用于捕获、处理和回放取样的音频数据的接口和类。
- javax.sound.sampled.spi 在提供新音频设备、声音文件 reader 和 writer，或音频格式转换器时，提供将为其创建子类的服务提供者的抽象类。

- javax.sql   为通过 JavaTM 编程语言进行服务器端数据源访问和处理提供 API。
- javax.sql.rowset    JDBC RowSet 实现的标准接口和基类。
- javax.sql.rowset.serial 提供实用工具类，允许 SQL 类型与 Java 编程语言数据类型之间的可序列化映射关系。
- javax.sql.rowset.spi    第三方供应商在其同步提供者的实现中必须使用的标准类和接口。

- javax.swing 提供一组“轻量级”（全部是 Java 语言）组件，尽量让这些组件在所有平台上的工作方式都相同。
- javax.swing.border  提供围绕 Swing 组件绘制特殊边框的类和接口。
- javax.swing.colorchooser    包含供 JColorChooser 组件使用的类和接口。
- javax.swing.event   供 Swing 组件触发的事件使用。
- javax.swing.filechooser 包含 JFileChooser 组件使用的类和接口。
- javax.swing.plaf    提供一个接口和许多抽象类，Swing 用它们来提供自己的可插入外观功能。
- javax.swing.plaf.basic  提供了根据基本外观构建的用户界面对象。
- javax.swing.plaf.metal  提供根据 Java 外观（曾经代称为 Metal）构建的用户界面对象，Java 外观是默认外观。
- javax.swing.plaf.multi  提供了组合两个或多个外观的用户界面对象。
- javax.swing.plaf.synth  Synth 是一个可更换皮肤 (skinnable) 的外观，在其中可委托所有绘制。
- javax.swing.table   提供用于处理 javax.swing.JTable 的类和接口。
- javax.swing.text    提供类 HTMLEditorKit 和创建 HTML 文本编辑器的支持类。
- javax.swing.text.html   提供类 HTMLEditorKit 和创建 HTML 文本编辑器的支持类。
- javax.swing.text.html.parser    提供默认的 HTML 解析器以及支持类。
- javax.swing.text.rtf    提供一个类 (RTFEditorKit)，用于创建富文本格式（Rich-Text-Format）的文本编辑器。
- javax.swing.tree    提供处理 javax.swing.JTree 的类和接口。
- javax.swing.undo    允许开发人员为应用程序（例如文本编辑器）中的撤消/恢复提供支持。

- javax.tools 为能够从程序（例如，编译器）中调用的工具提供接口。

- javax.transaction   包含解组期间通过 ORB 机制抛出的三个异常。
- javax.transaction.xa    提供定义事务管理器和资源管理器之间的协定的 API，它允许事务管理器添加或删除 JTA 事务中的资源对象（由资源管理器驱动程序提供）。

- javax.xml   根据 XML 规范定义核心 XML 常量和功能。
- javax.xml.bind  为包含解组、编组和验证功能的客户端应用程序提供运行时绑定框架。
- javax.xml.bind.annotation   定义将 Java 程序元素定制成 XML 模式映射的注释。
- javax.xml.bind.annotation.adapters  XmlAdapter 及其规范定义的子类允许任意 Java 类与 JAXB 一起使用。
- javax.xml.bind.attachment   此包由基于 MIME 的包处理器实现，该处理器能够解释并创建基于 MIME 的包格式的已优化的二进制数据。
- javax.xml.bind.helpers  仅由 JAXB 提供者用于： 提供某些 javax.xml.bind 接口的部分默认实现。
- javax.xml.bind.util 有用的客户端实用工具类。
- javax.xml.crypto    用于 XML 加密的通用类。
- javax.xml.crypto.dom    javax.xml.crypto 包的特定于 DOM 的类。
- javax.xml.crypto.dsig   用于生成和验证 XML 数字签名的类。
- javax.xml.crypto.dsig.dom   javax.xml.crypto.dsig 包特定于 DOM 的类。
- javax.xml.crypto.dsig.keyinfo   用来解析和处理 KeyInfo 元素和结构的类。
- javax.xml.crypto.dsig.spec  XML 数字签名的参数类。
- javax.xml.datatype  XML/Java 类型映射关系。
- javax.xml.namespace XML 名称空间处理。
- javax.xml.parsers   提供允许处理 XML 文档的类。
- javax.xml.soap  提供用于创建和构建 SOAP 消息的 API。
- javax.xml.stream
- javax.xml.stream.events
- javax.xml.stream.util
- javax.xml.transform 此包定义了用于处理转换指令，以及执行从源到结果的转换的一般 API。
- javax.xml.transform.dom 此包实现特定于 DOM 的转换 API。
- javax.xml.transform.sax 此包实现特定于 SAX2 的转换 API。
- javax.xml.transform.stax    提供特定于 StAX 的转换 API。
- javax.xml.transform.stream  此包实现特定于流和 URI 的转换 API。
- javax.xml.validation    此包提供了用于 XML 文档验证的 API。
- javax.xml.ws    此包包含核心 JAX-WS API。
- javax.xml.ws.handler    该包定义用于消息处理程序的 API。
- javax.xml.ws.handler.soap   该包定义用于 SOAP 消息处理程序的 API。
- javax.xml.ws.http   该包定义特定于 HTTP 绑定的 API。
- javax.xml.ws.soap   该包定义特定于 SOAP 绑定的 API。
- javax.xml.ws.spi    该包定义用于 JAX-WS 2.0 的 SPI。
- javax.xml.xpath 此包提供了用于 XPath 表达式的计算和访问计算环境的 object-model neutral API。


- org.jcp.xml.dsig.internal

- org.ietf.jgss   此包提供一个框架，该框架允许应用程序开发人员通过利用统一的 API 使用一些来自各种基础安全机制（如 Kerberos）的安全服务，如验证、数据完整性和和数据机密性。

- org.omg
- org.omg.CORBA   提供 OMG CORBA API 到 JavaTM 编程语言的映射，包括 ORB 类，如果已实现该类，则程序员可以使用此类作为全功能对象请求代理（Object Request Broker，ORB）。
- org.omg.CORBA_2_3   CORBA_2_3 包定义对 Java[tm] Standard Edition 6 中现有 CORBA 接口所进行的添加。
- org.omg.CORBA_2_3.portable  提供输入和输出值类型的各种方法，并包含 org/omg/CORBA/portable 包的其他更新。
- org.omg.CORBA.DynAnyPackage 提供与 DynAny 接口一起使用的异常（InvalidValue、Invalid、InvalidSeq 和 TypeMismatch）。
- org.omg.CORBA.ORBPackage    提供由 ORB.resolve_initial_references 方法抛出的异常 InvalidName，以及由 ORB 类中的动态 Any 创建方法抛出的异常 InconsistentTypeCode。
- org.omg.CORBA.portable  提供可移植性层，即可以使一个供应商生成的代码运行在另一个供应商 ORB 上的 ORB API 集合。
- org.omg.CORBA.TypeCodePackage   提供用户定义的异常 BadKind 和 Bounds，它们将由 TypeCode 类中的方法抛出。
- org.omg.CosNaming   为 Java IDL 提供命名服务。
- org.omg.CosNaming.NamingContextExtPackage   此包包含以下在 org.omg.CosNaming.NamingContextExt 中使用的类： AddressHelper StringNameHelper URLStringHelper InvalidAddress 包规范 有关 Java[tm] Platform, Standard Edition 6 ORB 遵守的官方规范的受支持部分的明确列表，请参阅 Official Specifications for CORBA support in Java[tm] SE 6。
- org.omg.CosNaming.NamingContextPackage  此包包含 org.omg.CosNaming 包的 Exception 类。
- org.omg.Dynamic 此包包含 OMG Portable Interceptor 规范 http://cgi.omg.org/cgi-bin/doc?ptc/2000-08-06 的第 21.9 小节中指定的 Dynamic 模块。
- org.omg.DynamicAny  提供一些类和接口使得在运行时能够遍历与 any 有关联的数据值，并提取数据值的基本成分。
- org.omg.DynamicAny.DynAnyFactoryPackage 此包包含 DynamicAny 模块的 DynAnyFactory 接口中的类和异常，该模块在 OMG The Common Object Request Broker: Architecture and Specification http://cgi.omg.org/cgi-bin/doc?formal/99-10-07 的第 9.2.2 小节中指定。
- org.omg.DynamicAny.DynAnyPackage    此包包含 DynAny 模块的 DynAnyFactory 接口中的类和异常，该模块在 OMG The Common Object Request Broker: Architecture and Specification http://cgi.omg.org/cgi-bin/doc?formal/99-10-07 的第 9.2 小节中指定。
- org.omg.IOP 此包包含在 OMG 文档 The Common Object Request Broker: Architecture and Specification http://cgi.omg.org/cgi-bin/doc?formal/99-10-07 的 13.6.小节中指定的 IOP 模块。
- org.omg.IOP.CodecFactoryPackage 此包包含 IOP::CodeFactory 接口中指定的异常（作为 Portable Interceptor 规范的一部分）。
- org.omg.IOP.CodecPackage    此包根据 IOP::Codec IDL 接口定义生成。
- org.omg.Messaging   此包包含 OMG Messaging Interceptor 规范 http://cgi.omg.org/cgi-bin/doc?formal/99-10-07 中指定的 Messaging 模块。
- org.omg.PortableInterceptor 提供一个注册 ORB 钩子 (hook) 的机制，通过这些钩子 ORB 服务可以截取执行 ORB 的正常流。
- org.omg.PortableInterceptor.ORBInitInfoPackage  此包包含 OMG Portable Interceptor 规范 http://cgi.omg.org/cgi-bin/doc?ptc/2000-08-06 的第 21.7.2 小节中指定的 PortableInterceptor 模块的 ORBInitInfo 本地接口中的异常和 typedef。
- org.omg.PortableServer  提供一些类和接口，用来生成跨多个供应商 ORB 的可移植应用程序的服务器端。
- org.omg.PortableServer.CurrentPackage   提供各种方法实现，这些实现能够访问调用方法的对象的身份。
- org.omg.PortableServer.POAManagerPackage    封装 POA 关联的处理状态。
- org.omg.PortableServer.POAPackage   允许程序员构造可在不同 ORB 产品间移植的对象实现。
- org.omg.PortableServer.portable 提供一些类和接口，用来生成跨多个供应商 ORB 的可移植应用程序的服务器端。
- org.omg.PortableServer.ServantLocatorPackage    提供定位 servant 的类和接口。
- org.omg.SendingContext  为值类型的编组提供支持。
- org.omg.stub.java.rmi   包含用于 java.rmi 包中出现的 Remote 类型的 RMI-IIOP Stub。

- org.w3c.dom 为文档对象模型 (DOM) 提供接口，该模型是 Java API for XML Processing 的组件 API。
- org.w3c.dom.bootstrap
- org.w3c.dom.events
- org.w3c.dom.ls

- org.xml.sax 此包提供了核心 SAX API。
- org.xml.sax.ext 此包包含适合的 SAX 驱动程序不一定支持的 SAX2 设施的接口。
- org.xml.sax.helpers 此包包含“帮助器”类，其中包括对引导基于 SAX 的应用程序的支持。

- jdk

#### jce.jar

- javax.crypto    为加密操作提供类和接口。
- javax.crypto.interfaces 根据 RSA Laboratories' PKCS #3 的定义，提供 Diffie-Hellman 密钥接口。
- javax.crypto.spec   为密钥规范和算法参数规范提供类和接口。

### sun.misc.Launcher

它是一个java虚拟机的入口。

### sun.misc.Unsafe

Unsafe类在JDK源码中被广泛使用，该类功能很强大，涉及到类加载机制，其实例一般情况是获取不到的，源码中的设计是采用单例模式，不是系统加载初始化就会抛出SecurityException异常。

这个类的提供了一些绕开JVM的更底层功能，基于它的实现可以提高效率。但是，它是一把双刃剑：正如它的名字所预示的那样，它是Unsafe的，它所分配的内存需要手动free（不被GC回收）。如果对Unsafe类理解的不够透彻，就进行使用的话，就等于给自己挖了无形之坑，最为致命。

sun并没有将其开源，也没给出官方的Document。

```java Unsafe类中的核心方法
    //重新分配内存
    public native long reallocateMemory(long address, long bytes);  

    //分配内存  
    public native long allocateMemory(long bytes);  

    //释放内存  
    public native void freeMemory(long address);  

    //在给定的内存块中设置值  
    public native void setMemory(Object o, long offset, long bytes, byte value);  

    //从一个内存块拷贝到另一个内存块  
    public native void copyMemory(Object srcBase, long srcOffset, Object destBase, long destOffset, long bytes);  

    //获取值，不管java的访问限制，其他有类似的getInt，getDouble，getLong，getChar等等  
    public native Object getObject(Object o, long offset);  

    //设置值，不管java的访问限制，其他有类似的putInt,putDouble，putLong，putChar等等  
    public native void putObject(Object o, long offset);  

    //从一个给定的内存地址获取本地指针，如果不是allocateMemory方法的，结果将不确定  
    public native long getAddress(long address);  

    //存储一个本地指针到一个给定的内存地址,如果地址不是allocateMemory方法的，结果将不确定  
    public native void putAddress(long address, long x);  

    //该方法返回给定field的内存地址偏移量，这个值对于给定的filed是唯一的且是固定不变的  
    public native long staticFieldOffset(Field f);  

    //报告一个给定的字段的位置，不管这个字段是private，public还是保护类型，和staticFieldBase结合使用  
    public native long objectFieldOffset(Field f);  

    //获取一个给定字段的位置  
    public native Object staticFieldBase(Field f);  

    //确保给定class被初始化，这往往需要结合基类的静态域（field）  
    public native void ensureClassInitialized(Class c);  

    //可以获取数组第一个元素的偏移地址  
    public native int arrayBaseOffset(Class arrayClass);  

    //可以获取数组的转换因子，也就是数组中元素的增量地址。将arrayBaseOffset与arrayIndexScale配合使用， 可以定位数组中每个元素在内存中的位置  
    public native int arrayIndexScale(Class arrayClass);  

    //获取本机内存的页数，这个值永远都是2的幂次方  
    public native int pageSize();  

    //告诉虚拟机定义了一个没有安全检查的类，默认情况下这个类加载器和保护域来着调用者类  
    public native Class defineClass(String name, byte[] b, int off, int len, ClassLoader loader, ProtectionDomain protectionDomain);  

    //定义一个类，但是不让它知道类加载器和系统字典  
    public native Class defineAnonymousClass(Class hostClass, byte[] data, Object[] cpPatches);  

    //锁定对象，必须是没有被锁的
    public native void monitorEnter(Object o);  

    //解锁对象  
    public native void monitorExit(Object o);  

    //试图锁定对象，返回true或false是否锁定成功，如果锁定，必须用monitorExit解锁  
    public native boolean tryMonitorEnter(Object o);  

    //引发异常，没有通知  
    public native void throwException(Throwable ee);  

    //CAS，如果对象偏移量上的值=期待值，更新为x,返回true.否则false.类似的有compareAndSwapInt,compareAndSwapLong,compareAndSwapBoolean,compareAndSwapChar等等。  
    public final native boolean compareAndSwapObject(Object o, long offset,  Object expected, Object x);  

    // 该方法获取对象中offset偏移地址对应的整型field的值,支持volatile load语义。类似的方法有getIntVolatile，getBooleanVolatile等等  
    public native Object getObjectVolatile(Object o, long offset);   

    //线程调用该方法，线程将一直阻塞直到超时，或者是中断条件出现。  
    public native void park(boolean isAbsolute, long time);  

    //终止挂起的线程，恢复正常.java.util.concurrent包中挂起操作都是在LockSupport类实现的，也正是使用这两个方法
    public native void unpark(Object thread);  

    //获取系统在不同时间系统的负载情况  
    public native int getLoadAverage(double[] loadavg, int nelems);  

    //创建一个类的实例，不需要调用它的构造函数、初使化代码、各种JVM安全检查以及其它的一些底层的东西。即使构造函数是私有，我们也可以通过这个方法创建它的实例,对于单例模式，简直是噩梦。 
    public native Object allocateInstance(Class cls) throws InstantiationException;
```

### Annotation

Java 注解（Annotation）又称 Java 标注，是 JDK5.0 引入的一种注释机制。

Java 语言中的类、方法、变量、参数和包等都可以被标注。和 Javadoc 不同，Java 标注可以通过反射获取标注内容。在编译器生成类文件时，标注可以被嵌入到字节码中。Java 虚拟机可以保留标注内容，在运行时可以获取到标注内容。当然它也支持自定义 Java 标注。

1. 作用在代码的注解

- @Override - 检查该方法是否是重写方法。如果发现其父类，或者是引用的接口中并没有该方法时，会报编译错误。
- @Deprecated - 标记过时方法。如果使用该方法，会报编译警告。
- @SuppressWarnings - 指示编译器去忽略注解中声明的警告。

2. 作用在其他注解的注解(元注解)

- @Retention - 标识这个注解怎么保存，是只在代码中，还是编入class文件中，或者是在运行时可以通过反射访问。
- @Documented - 标记这些注解是否包含在用户文档中。
- @Target - 标记这个注解应该是哪种 Java 成员。
- @Inherited - 标记这个注解是继承于哪个注解类(默认 注解并没有继承于任何子类)
- @SafeVarargs - Java 7 开始支持，忽略任何使用参数为泛型变量的方法或构造函数调用产生的警告。
- @FunctionalInterface - Java 8 开始支持，标识一个匿名函数或函数式接口。
- @Repeatable - Java 8 开始支持，标识某注解可以在同一个声明上使用多次。


java Annotation 的组成中，有 3 个非常重要的主干类。

```java Annotation.java
package java.lang.annotation;
public interface Annotation {

    boolean equals(Object obj);

    int hashCode();

    String toString();

    Class<? extends Annotation> annotationType();
}
```
```java ElementType.java
package java.lang.annotation;

public enum ElementType {
    TYPE,               /* 类、接口（包括注释类型）或枚举声明  */

    FIELD,              /* 字段声明（包括枚举常量）  */

    METHOD,             /* 方法声明  */

    PARAMETER,          /* 参数声明  */

    CONSTRUCTOR,        /* 构造方法声明  */

    LOCAL_VARIABLE,     /* 局部变量声明  */

    ANNOTATION_TYPE,    /* 注释类型声明  */

    PACKAGE             /* 包声明  */
}
```

```java RetentionPolicy.java
package java.lang.annotation;
public enum RetentionPolicy {
    SOURCE,            /* Annotation信息仅存在于编译器处理期间，编译器处理完之后就没有该Annotation信息了  */

    CLASS,             /* 编译器将Annotation存储于类对应的.class文件中。默认行为  */

    RUNTIME            /* 编译器将Annotation存储于class文件中，并且可由JVM读入 */
}
```

### ClassLoader

Java自带三个类加载器并提供自定义加载器:

- Bootstrap ClassLoader 最顶层的加载类，主要加载核心类库，%JRE_HOME%\lib下的rt.jar、resources.jar、charsets.jar和class等。另外需要注意的是可以通过启动jvm时指定-Xbootclasspath和路径来改变Bootstrap ClassLoader的加载目录。sun.boot.class.path。
- Extension ClassLoader 主要负责加载Java的扩展类库，加载目录%JRE_HOME%\lib\ext目录下的jar包和class文件。还可以加载-D java.ext.dirs选项指定的目录。
- Appclass Loader也称为SystemAppClass，加载当前应用的classpath的所有类。java.class.path。
- 自定义的ClassLoader 扩展Java虚拟机获取Class数据的能力，可以加载指定路径下的class文件，一般继承ClassLoader重写findClass()方法即可。一个ClassLoader创建时如果没有指定parent，那么它的parent默认就是AppClassLoader。因为这样就能够保证它能访问系统内置加载器加载成功的class文件。

ClassLoader的层次自顶往下为启动类加载器、扩展类加载器、应用类加载器和自定义类加载器。其中，应用类加载器的双亲为扩展类加载器，扩展类加载器的双亲为启动类加载器。当系统需要使用一个类时，在判断类是否已经被加载时，会先从当前底层类加载器进行判断。当系统需要加载一个类时，会从顶层类开始加载，依次向下尝试，直到成功。

int.class.getClassLoader()为空。int.class是由Bootstrap ClassLoader加载的。它是完全由C++代码实现的，并且在Java中没有对象与之对应，它也是虚拟机的核心组件。Extension ClassLoader和AppClassLoader都有对应的Java对象可供使用。


