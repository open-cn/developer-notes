## JAVA

1. Java SE Platform
	+ 前身：J2SE（Java 2 Platform, Standard Edition），2005年之后更名为JAVA SE
2. Java ME Platform
	+ 前身：J2ME（Java 2 Platform, Micro Edition），2005年之后更名为JAVA ME
3. Java EE Platform
	+ 前身：J2EE（Java 2 Platform, Enterprise Edition），2005年之后更名为JAVA EE

### 概述

Sun公司   后被Oracle收购

java学习顺序：javase->sql->jdbc
	->html，javascript，jquery，ajax，css->servlet->jsp//学到这里也可以
	->struts2[简化web开发]，类似有jsf->hibernate->spring-->ejb3.0-->web service

跨平台：jvm屏蔽了操作系统之间的差异，而java源程序编译产生的是字节码文件(x.class)。字节码可以直接在jvm上运行。

### JVM

1. 方法区：class类信息，常量池（static 常量和 static 变量），编译后的代码（字节码）等。
1. 堆：初始化的对象，成员变量（那种非 static 的变量），所有的对象实例和数组都要在堆上分配。
  - 堆里面分为新生代和老生代（java8 取消了永久代，采用了 Metaspace）
  - 新生代包含 Eden 区和 Survivor 区，survivor 区里面分为 from 和 to 区
  - 内存回收时，如果用的是复制算法，从 from 复制到 to，当经过一次或者多次 GC 之后，存活下来的对象会被移动到老年区，当 JVM 内存不够用的时候，会触发 Full GC，清理 JVM 老年区。当新生区满了之后会触发 YGC，先把存活的对象放到其中一个 Survice 区，然后进行垃圾清理。因为如果仅仅清理需要删除的对象，这样会导致内存碎片，因此一般会把 Eden 进行完全的清理，然后整理内存。那么下次 GC 的时候，就会使用下一个 Survive，这样循环使用。
  - 如果有特别大的对象，新生代放不下，就会使用老年代的担保，直接放到老年代里面。因为 JVM 认为，一般大对象的存活时间一般比较久远。
1. 栈：栈的结构是栈帧组成的，调用一个方法就压入一帧，帧上面存储局部变量表，操作数栈，方法出口等信息，局部变量表存放的是 8大基础类型加上一个引用类型，所以还是一个指向地址的指针。
1. 本地方法栈：主要为 Native 方法服务。
1. 程序计数器：记录当前线程执行的行号。

#### 堆

#### GC 的两种判定方法

引用计数法：指的是如果某个地方引用了这个对象就+1，如果失效了就-1，当为 0 就会回收但是 JVM没有用这种方式，因为无法判定相互循环引用（A 引用 B，B 引用 A） 的情况。

引用链法：通过一种 GC ROOT 的对象（方法区中静态变量引用的对象等-static 变量）来判断，如果有一条链能够到达 GCROOT 就说明，不能到达 GC ROOT 就说明可以回收。


有时候也成为永久代，在该区内很少发生垃圾回收，但是并不代表不发生 GC，在这里进行的 GC 主要是对方法区里的常量池和对类型的卸载

方法区主要用来存储已被虚拟机加载的类的信息、常量、静态变量和即时编译器编译后的代码等数据。

该区域是被线程共享的。

方法区里有一个运行时常量池，用于存放静态编译产生的字面量和符号引用。该常量池具有动态性，也就是说常量并不一定是编译时确定，运行时生成的常量也会存在这个常量池中。

虚拟机栈:

虚拟机栈也就是我们平常所称的栈内存，它为 java 方法服务，每个方法在执行的时候都会创建一个栈帧，用于存储局部变量表、操作数栈、动态链接和方法出口等信息。

虚拟机栈是线程私有的，它的生命周期与线程相同。

局部变量表里存储的是基本数据类型、returnAddress类型（指向一条字节码指令的地址）和对象引用，这个对象引用有可能是指向对象起始地址的一个指针，也有可能是代表对象的句柄或者与对象相关联的位置。局部变量所需的内存空间在编译器间确定。

操作数栈的作用主要用来存储运算结果以及运算的操作数，它不同于局部变量表通过索引来访问，而是压栈和出栈的方式。

每个栈帧都包含一个指向运行时常量池中该栈帧所属方法的引用，持有这个引用是为了支持方法调用过程中的动态连接.动态链接就是将常量池中的符号引用在运行期转化为直接引用。

本地方法栈：

本地方法栈和虚拟机栈类似，只不过本地方法栈为 Native 方法服务。

堆
java 堆是所有线程所共享的一块内存，在虚拟机启动时创建，几乎所有的对象实例都在这里创建，因此该区域经常发生垃圾回收操作。

程序计数器

内存空间小，字节码解释器工作时通过改变这个计数值可以选取下一条需要执行的字节码，指令，分支、循环、跳转、异常处理和线程恢复等功能都需要依赖这个计数器完成。该内存区域是唯一一个 java 虚拟机规范没有规定任何 OOM 情况的区域。

7.如和判断一个对象是否存活?(或者 GC 对象的判定方法）
判断一个对象是否存活有两种方法:
1.引用计数法

所谓引用计数法就是给每一个对象设置一个引用计数器，每当有一个地方引用这个对象时，就将计数器加一，引用失效时，计数器就减一。当一个对象的引用计数器为零时，说明此对象没有被引用，也就是“死对象”,将会被垃圾回收.
引用计数法有一个缺陷就是无法解决循环引用问题，也就是说当对象 A 引用对象 B，对象B 又引用者对象 A，那么此时 A,B 对象的引用计数器都不为零，也就造成无法完成垃圾回收，所以主流的虚拟机都没有采用这种算法。

2.可达性算法(引用链法)

该算法的思想是：从一个被称为 GC Roots的对象开始向下搜索，如果一个对象到 GCRoots 没有任何引用链相连时，则说明此对象不可用。
在 java 中可以作为 GC Roots 的对象有以下几种:

- 虚拟机栈中引用的对象
- 方法区类静态属性引用的对象
- 方法区常量池引用的对象
- 本地方法栈 JNI 引用的对象
虽然这些算法可以判定一个对象是否能被回收，但是当满足上述条件时，一个对象比不一定会被回收。当一个对象不可达 GC Root 时，这个对象并不会立马被回收，而是出于一个死缓的阶段，若要被真正的回收需要经历两次标记。

如果对象在可达性分析中没有与 GC Root 的引用链，那么此时就会被第一次标记并且进行一次筛选，筛选的条件是是否有必要执行 finalize()方法。当对象没有覆盖 finalize()方法或者已被虚拟机调用过，那么就认为是没必要的。

如果该对象有必要执行 finalize()方法，那么这个对象将会放在一个称为 F-Queue 的对队列中，虚拟机会触发一个 Finalize()线程去执行，此线程是低优先级的，并且虚拟机不会承诺一直等待它运行完，这是因为如果 finalize()执行缓慢或者发生了死锁，那么就会造成 FQueue 队列一直等待，造成了内存回收系统的崩溃。GC 对处于 F-Queue 中的对象进行第二次被标记，这时，该对象将被移除”即将回收”集合，等待回收。

8.java 中垃圾收集的方法有哪些?
标记-清除: 这是垃圾收集算法中最基础的，根据名字就可以知道，它的思想就是标记哪些要被回收的对象，然后统一回收。这种方法很简单，但是会有两个主要问题：
1.效率不高，标记和清除的效率都很低；
2.会产生大量不连续的内存碎片，导致以后程序在分配较大的对象时，由于没有充足的连续内存而提前触发一次 GC 动作。

复制算法: 为了解决效率问题，复制算法将可用内存按容量划分为相等的两部分，然后每次只使用其中的一块，当一块内存用完时，就将还存活的对象复制到第二块内存上，然后一次性清楚完第一块内存，再将第二块上的对象复制到第一块。但是这种方式，内存的代价太高，每次基本上都要浪费一般的内存。

于是将该算法进行了改进，内存区域不再是按照 1：1 去划分，而是将内存划分为8:1:1 三部分，较大那份内存交 Eden 区，其余是两块较小的内存区叫 Survior 区。

每次都会优先使用 Eden 区，若 Eden 区满，就将对象复制到第二块内存区上，然后清除 Eden 区，如果此时存活的对象太多，以至于 Survivor 不够时，会将这些对象通过分配担保机制复制到老年代中。(java 堆又分为新生代和老年代)

标记-整理：该算法主要是为了解决标记-清除，产生大量内存碎片的问题；当对象存活率较高时，也解决了复制算法的效率问题。它的不同之处就是在清除对象的时候现将可回收对象移动到一端，然后清除掉端边界以外的对象，这样就不会产生内存碎片了。

分代收集：现在的虚拟机垃圾收集大多采用这种方式，它根据对象的生存周期，将堆分为新生代和老年代。在新生代中，由于对象生存期短，每次回收都会有大量对象死去，那么这时就采用复制算法。老年代里的对象存活率较高，没有额外的空间进行分配担保，所以可以使用标记-整理或者 标记-清除。

9.什么是类加载器，类加载器有哪些?
实现通过类的权限定名获取该类的二进制字节流的代码块叫做类加载器。

主要有一下四种类加载器:

启动类加载器(Bootstrap ClassLoader)用来加载 java 核心类库，无法被 java 程序直接引用。
扩展类加载器(extensions class loader):它用来加载 Java 的扩展库。Java虚拟机的实现会提供一个扩展库目录。该类加载器在此目录里面查找并加载 Java 类。
系统类加载器（system class loader）：它根据 Java 应用的类路径（CLASSPATH） 来加载 Java类。一般来说，Java应用的类都是由它来完成加载的。可以通过ClassLoader.getSystemClassLoader()来获取它。
用户自定义类加载器，通过继承 java.lang.ClassLoader 类的方式实现。
10. 类加载器双亲委派模型机制？
当一个类收到了类加载请求时，不会自己先去加载这个类，而是将其委派给父类，由父类去加载，如果此时父类不能加载，反馈给子类，由子类去完成类的加载。

11.什么情况下会发生栈内存溢出？
1、栈是线程私有的，栈的生命周期和线程一样，每个方法在执行的时候就会创建一个栈帧，它包含局部变量表、操作数栈、动态链接、方法出口等信息，局部变量表又包括基本数据类型和对象的引用；
2、当线程请求的栈深度超过了虚拟机允许的最大深度时，会抛出StackOverFlowError异常，方法递归调用肯可能会出现该问题；
3、调整参数-xss去调整jvm栈的大小

12.怎么打破双亲委派模型？
自定义类加载器，继承ClassLoader类，重写loadClass方法和findClass方法；

13.强引用、软应用、弱引用、虚引用的区别？
强引用：强引用是我们使用最广泛的引用，如果一个对象具有强引用，那么垃圾回收期绝对不会回收它，当内存空间不足时，垃圾回收器宁愿抛出OutOfMemoryError，也不会回收具有强引用的对象；我们可以通过显示的将强引用对象置为null，让gc认为该对象不存在引用，从而来回收它；

软引用：软应用是用来描述一些有用但不是必须的对象，在java中用SoftReference来表示，当一个对象只有软应用时，只有当内存不足时，才会回收它；
软引用可以和引用队列联合使用，如果软引用所引用的对象被垃圾回收器所回收了，虚拟机会把这个软引用加入到与之对应的引用队列中；

弱引用：弱引用是用来描述一些可有可无的对象，在java中用WeakReference来表示，在垃圾回收时，一旦发现一个对象只具有软引用的时候，无论当前内存空间是否充足，都会回收掉该对象；
弱引用可以和引用队列联合使用，如果弱引用所引用的对象被垃圾回收了，虚拟机会将该对象的引用加入到与之关联的引用队列中；

虚引用：虚引用就是一种可有可无的引用，无法用来表示对象的生命周期，任何时候都可能被回收，虚引用主要使用来跟踪对象被垃圾回收的活动，虚引用和软引用与弱引用的区别在于：虚引用必须和引用队列联合使用；在进行垃圾回收的时候，如果发现一个对象只有虚引用，那么就会将这个对象的引用加入到与之关联的引用队列中，程序可以通过发现一个引用队列中是否已经加入了虚引用，来了解被引用的对象是否需要被进行垃圾回收；

#### JVM内存模型优点

- 内置基于内存的并发模型：多线程机制
- 同步锁Synchronization
- 大量线程安全型库包支持
- 基于内存的并发机制，粒度灵活控制，灵活度高于数据库锁。
- 多核并行计算模型
- 基于线程的异步模型。

#### JVM性能的人为问题

- 关键原因是：没有正确处理好对象的生命周期。
- 需要从需求中找出存在自然边界的业务对象，将其对应落实到内存中，成为内存模型In-memory Domain Model。
- 有大小边界限制的内存是缓存，没有永远使用不完的内存，缓存=“有边界的”内存。
- 缓存是Domain Model对象缓存，不同于传统意义上数据库缓存的定义。
- 分布式缓存可以提高巨量数据处理计算能力。

#### Java内存种类
- 栈（Stack）内存：存取速度快，数据可多线程间共享。存在栈中的数据大小与生存期必须确定
- 堆（Heap）内存：大小动态变化，对象的生命周期不必事先告诉编译器JVM。

两种内存使用

- Stack栈内存
	+ 基本数据类型，Java 指令代码，常量 
	+ 对象实例的引用 对象的方法代码
- Heap堆内存
	+ 对象实例的属性数据和数组。堆内存由Java虚拟机的自动垃圾回收器来管理。

对象如何保存在内存中？

- 对象的属性Attribute Property
	+ 属性值作为数据，保存在数据区heap 中，包括属性的类型Classtype和对象本身的类型
- 方法method
	+ 方法本身是指令的操作码，保存在stack中。 
	+ 方法内部变量作为指令的操作数也是在Stack中， 
	+ 包括基本类型和其他对象的引用。
- 对象实例在heap 中分配好内存以后，需要在stack中保存一个4字节的heap内存地址，用来定位该对象实例在heap 中的位置，便于找到该对象实例。

静态属性和方法的特点

- 静态属性和方法都是保存在Stack中，
- Stack内存是共享的，其他线程都可以访问静态属性实际是全局变量。
- 静态方法在Stack，就无法访问Heap中的数据。静态方法无法访问普通对象中数据。
- 静态属性意味着全局变量，生命周期和JVM一致。JVM属于技术边界，静态只能用于技术边界内工具性质使用，不能用作业务。

#### 内存管理：垃圾回收机制

- 每一种垃圾收集的算法（引用计数、复制、标记-清除和标记-整理等）在特定条件下都有其优点和缺点。
- 当有很多对象成为垃圾时，复制可以做得很好，但是复制许多生命周期长的对象时它就变得很糟（要反复复制它们）。
- 标记-整理适合生命周期长对象可以做得很好（只复制一次），但是不适合短生命的对象。
- Sun JVM 1.2 及以后版本使用的技术称为 分代垃圾收集（generational garbage collection），它结合了这两种技术以结合二者的长处。


#### JVM性能优化
- 内存微调优化
	+ 内存分配：
		* 新生代 Eden和survior 旧生代内存大小分配。 
		* 内存越大，吞吐量越大，但是需要内存整理的时间就越长，响应时间有延迟。
	+ 垃圾回收机制
		* 垃圾回收启动整个应用都暂停，暂停时间造成响应时间有延迟。
	+ 内存微调目标
		* 在延迟性(响应时间)和吞吐量上取得一个平衡。
		* 内存大小影响吞吐量和延迟性。需要在内存大小和响应时间之间取得一个平衡。
		* 垃圾回收机制是延迟的最大问题。目标尽量不启动，少启动。
- 锁争夺微调:
	+ 多线程 不变性 单写原则 Actor Disrupotor
- CPU使用率微调
- I/O 微调

#### 内存模型

##### 新生代Eden内存分配
- 新生代(New Generation )：Eden + 1 Survivor。所有新创建的对象在Eden。
- 当Eden满了，启动Stop-The-World的GC，或为minor gc，采取数次复制Copy-Collection到Survivor。
- 经过几次收集，寿命不断延长的对象从Survivor 进入老生代，也称为进入保有Tenuring，类似普通缓存LRU算法。

##### survivor设计要旨
- 足够大到能容纳所有请求响应中涉及的对象数据。
- 每个survivor空间也要足够大到能够容纳活跃的请求对象和保有对象。
- Survivor大小决定了保有Tenuring阀值，阀值如果能大到容纳所有常住对象，那么保有迁移过程就越快。

##### 老生代Old
- 老生代的gc称为major gc，就是通常说的full gc。
- 采用标记-整理算法。由于老年区域比较大，而且通常对象生命周期都比较长，标记-整理需要一定时间。所以这部分的gc时间比较长。
- minor gc可能引发full gc。当eden＋from space的空间大于老生代的剩余空间时，会引发full gc。这是悲观算法，要确保eden＋from space的对象如果都存活，必须有足够的老生代空间存放这些对象。
- 这些都根据情况调整启动JVM的设置。
- 使用 Adaptive让JVM自动划分新生代和老生代。

##### Permanent Generation 永久代
- 该区域比较稳定，主要用于存放classloader信息，比如类信息和method信息。
- 缺省是64M ，如果你的代码量很大，容易出现OutOfMemoryError: PermGen space。
- 2G以上内存设置MaxPermSize为160M
- -XX:PermSize=128m -XX:MaxPermSize=160m

##### 降低Full GC发生概率
- 为了降低Full GC发生概率，如果降低了老生代大小，那么OutOfMemoryError发生，Full GC概率反而会上升。
- 如果为了降低Full GC，增加老生代大小，执行时间可能会被延长。
- 必须寻找合适大小的老生代。
- 避免大的对象迁移到老生代。
- 减少迁移到老生代的对象数目

##### java.lang.OutOfMemoryError
1) 在高负荷的情况下的却需要很大的内存，因此可以通过修改JVM参数来增加Java Heap Memory。
2) 应用程序使用对象或者资源没有释放，导致内存消耗持续增加，关键采取OO封装边界方式，树立对象都有生命周期的基本习惯。
3) 再一种也可能是对于第三方开源项目中资源释放了解不够导致使用以后资源没有释放（例如JDBC的ResultSet等）。

##### JVM参数
- -Xms, -Xmx—定义JVM的heap大小最小和最大值。
- -XX:NewSize— 定义年轻态的最小大小，Eden越大越好，但是越大响应有延迟。
	+ -Xmx2G -Xms1G -XX:NewSIze=512M (OldGen at least 1G)
	+ -Xmx3G -Xms1G -XX:NewSize=512M (OldGen at least 2G)
	+ Xmx4G -Xms2G -XX:NewSize=1G (OldGen at least 2.5G)
	+ -Xmx6G -Xms3G -XX:NewSize=2G (OldGen at least 3.5G)
	+ -Xmx8G -Xms4G -XX:NewSize=3G (OldGen at least 4.5G)

参数调整示意
```shell
JAVA_OPTS="$JAVA_OPTS -server -Xss1280K -Xms1664m -Xmx1664m -XX:MaxPermSize=128m -XX:SurvivorRatio=16 -XX:NewSize=1280m -XX:MaxNewSize=1280m -XX:+DisableExplicitGC -XX:GCTimeRatio=2 -XX:ParallelGCThreads=4 -XX:+UseParNewGC -XX:MaxGCPauseMillis=2000 -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=80 -XX:+CMSClassUnloadingEnabled
```

##### Survivor大小
1. NewSize / ( SurvivorRatio + 2）
1. 如果SurvivorRatio =16， NewSize =1280m，那么S大小是70M。
1. 太小，溢出的复制Collection进入老生代。
1. 太大，闲置无用 浪费内存。
1. 使用XX:+PrintTenuringDistribution 和-XX:+PrintGCDetails, -XX:+PrintHeapAtGC观察：
1. 与-XX:+UseAdaptiveSizePolicy 冲突


##### 垃圾回收机制启动
垃圾回收机制不会频繁启动，因为机制一旦启动，造成应用程序停顿。
机制一般内存剩余5%左右启动，所以有现象：启动服务器，内存不断消耗，有多大内存消耗多大。

问题：如果服务器程序频繁触及5%底线，机制频繁启动，造成服务器慢..甚至死机。
根源：应用程序无限制频繁大量创建对象，消耗内存。

##### 控制垃圾回收
1. 带CMS参数的都是和并发回收相关的
1. -XX:+UseParNewGC，对新生代采用多线程并行回收。
1. CMSInitiatingOccupancyFraction=90说明年老代到90%满的时候开始执行对年老代的并发垃圾回收（CMS）
1. 用jmap和jstack查看

##### 串行、并行回收的区别

新生代 高吞吐量：
-XX:+UseSerialGC
-XX:+UseParallelGC
-XX:+UseParNewGC

老生代 低暂停：
-XX:+UseParallelOldGC
-XX:+UseConcMarkSweepGC

相同点：GC时都暂停一切。

不同点：一个线程和多个线程同时GC

##### 并行和CMS（Concurrent-Mark-Sweep）区别

CMS步骤：
- initial mark
- concurrent marking
- remark
- concurrent sweeping

区别：CMS一个线程，并行多个线程
CMS只是在1 3阶段暂停，而并行全部暂停。

##### Parallel GC 和 CMS GC

- 压实compaction是移除内存碎片，也就是移除已经分配的内存之间的空白空间。
- 在Parallel GC中，无论Full GC是否执行，压实总是被执行，会花费更多时间，不过在执行完Full GC后，内存也许再被使用时，会分配得快些，能够顺序分配了。
- CMS GC 并不执行压实，所以更快，碎片太多，没有空间放置大的需要连续空间的对象，“Concurrent mode failure”会发生。

##### 并行和CMS配置

-XX:UserParNewGC 适合于
 新生代 (multiple GC threads)
-XX:+UseConcMarkSweepGC 适合于
 老生代 (one GC thread, freezes the JVM only during the initial mark and remark phases) 
 -XX:InitiatingOccupancyFraction 80是表示CMS是在老生代接近满80%启动，如CPU空闲，可设定点一些。
 -XX:+CMSIncrementalMode 用于CMS，不会让处理器Hold住整个并发phases 。



### Java 内存模型（JMM）

我们常说的JVM内存模式指的是JVM的内存分区；而Java内存模式是一种虚拟机规范。

Java虚拟机规范中定义了Java内存模型（Java Memory Model，JMM），用于屏蔽掉各种硬件和操作系统的内存访问差异，以实现让Java程序在各种平台下都能达到一致的并发效果，JMM规范了Java虚拟机与计算机内存是如何协同工作的：规定了一个线程如何和何时可以看到由其他线程修改过后的共享变量的值，以及在必须时如何同步的访问共享变量。

原始的Java内存模型存在一些不足，因此Java内存模型在Java1.5时被重新修订。这个版本的Java内存模型在Java8中仍然在使用。

Java内存模型（不仅仅是JVM内存分区）：调用栈和本地变量存放在线程栈上，对象存放在堆上。

- 一个本地变量可能是原始类型，在这种情况下，它总是“呆在”线程栈上。
- 一个本地变量也可能是指向一个对象的一个引用。在这种情况下，引用（这个本地变量）存放在线程栈上，但是对象本身存放在堆上。
- 一个对象可能包含方法，这些方法可能包含本地变量。这些本地变量仍然存放在线程栈上，即使这些方法所属的对象存放在堆上。
- 一个对象的成员变量可能随着这个对象自身存放在堆上。不管这个成员变量是原始类型还是引用类型。
- 静态成员变量跟随着类定义一起也存放在堆上。
- 存放在堆上的对象可以被所有持有对这个对象引用的线程访问。当一个线程可以访问一个对象时，它也可以访问这个对象的成员变量。如果两个线程同时调用同一个对象上的同一个方法，它们将会都访问这个对象的成员变量，但是每一个线程都拥有这个成员变量的私有拷贝。

#### 硬件内存架构
现代硬件内存模型与Java内存模型有一些不同，理解内存模型架构以及Java内存模型如何与它协同工作也是非常重要的。

1. 多CPU：一个现代计算机通常由两个或者多个CPU。其中一些CPU还有多核。从这一点可以看出，在一个有两个或者多个CPU的现代计算机上同时运行多个线程是可能的。每个CPU在某一时刻运行一个线程是没有问题的。这意味着，如果你的Java程序是多线程的，在你的Java程序中每个CPU上一个线程可能同时（并发）执行。
2. CPU寄存器：每个CPU都包含一系列的寄存器，它们是CPU内内存的基础。CPU在寄存器上执行操作的速度远大于在主存上执行的速度。这是因为CPU访问寄存器的速度远大于主存。
3. 高速缓存cache：由于计算机的存储设备与处理器的运算速度之间有着几个数量级的差距，所以现代计算机系统都不得不加入一层读写速度尽可能接近处理器运算速度的高速缓存（Cache）来作为内存与处理器之间的缓冲：将运算需要使用到的数据复制到缓存中，让运算能快速进行，当运算结束后再从缓存同步回内存之中，这样处理器就无须等待缓慢的内存读写了。CPU访问缓存层的速度快于访问主存的速度，但通常比访问内部寄存器的速度还要慢一点。每个CPU可能有一个CPU缓存层，一些CPU还有多层缓存。在某一时刻，一个或者多个缓存行（cache lines）可能被读到缓存，一个或者多个缓存行可能再被刷新回主存。
4. 内存：一个计算机还包含一个主存。所有的CPU都可以访问主存。主存通常比CPU中的缓存大得多。
5. 运作原理：通常情况下，当一个CPU需要读取主存时，它会将主存的部分读到CPU缓存中。它甚至可能将缓存中的部分内容读到它的内部寄存器中，然后在寄存器中执行操作。当CPU需要将结果写回到主存中去时，它会将内部寄存器的值刷新到缓存中，然后在某个时间点将值刷新回主存。

一些问题：（多线程环境下尤其）

1. 缓存一致性问题：在多处理器系统中，每个处理器都有自己的高速缓存，而它们又共享同一主内存（MainMemory）。基于高速缓存的存储交互很好地解决了处理器与内存的速度矛盾，但是也引入了新的问题：缓存一致性（CacheCoherence）。当多个处理器的运算任务都涉及同一块主内存区域时，将可能导致各自的缓存数据不一致的情况，如果真的发生这种情况，那同步回到主内存时以谁的缓存数据为准呢？为了解决一致性的问题，需要各个处理器访问缓存时都遵循一些协议，在读写时要根据协议来进行操作，这类协议有MSI、MESI（IllinoisProtocol）、MOSI、Synapse、Firefly及DragonProtocol，等等：
2. 指令重排序问题：为了使得处理器内部的运算单元能尽量被充分利用，处理器可能会对输入代码进行乱序执行（Out-Of-Order Execution）优化，处理器会在计算之后将乱序执行的结果重组，保证该结果与顺序执行的结果是一致的，但并不保证程序中各个语句计算的先后顺序与输入代码中的顺序一致。因此，如果存在一个计算任务依赖另一个计算任务的中间结果，那么其顺序性并不能靠代码的先后顺序来保证。与处理器的乱序执行优化类似，Java虚拟机的即时编译器中也有类似的指令重排序（Instruction Reorder）优化

Java内存模型与硬件内存架构之间存在差异。硬件内存架构没有区分线程栈和堆。对于硬件，所有的线程栈和堆都分布在主内存中。部分线程栈和堆可能有时候会出现在CPU缓存中和CPU内部的寄存器中。

从抽象的角度来看，JMM定义了线程和主内存之间的抽象关系：

- 线程之间的共享变量存储在主内存（Main Memory）中
- 每个线程都有一个私有的本地内存（Local Memory），本地内存是JMM的一个抽象概念，并不真实存在，它涵盖了缓存、写缓冲区、寄存器以及其他的硬件和编译器优化。本地内存中存储了该线程以读/写共享变量的拷贝副本。
- 从更低的层次来说，主内存就是硬件的内存，而为了获取更好的运行速度，虚拟机及硬件系统可能会让工作内存优先存储于寄存器和高速缓存中。
- Java内存模型中的线程的工作内存（working memory）是cpu的寄存器和高速缓存的抽象描述。而JVM的静态内存储模型（JVM内存模型）只是一种对内存的物理划分而已，它只局限在内存，而且只局限在JVM的内存。

##### JMM模型下的线程间通信
线程间通信必须要经过主内存。

关于主内存与工作内存之间的具体交互协议，即一个变量如何从主内存拷贝到工作内存、如何从工作内存同步到主内存之间的实现细节，Java内存模型定义了以下八种操作来完成：

1. lock（锁定）：作用于主内存的变量，把一个变量标识为一条线程独占状态。
1. unlock（解锁）：作用于主内存变量，把一个处于锁定状态的变量释放出来，释放后的变量才可以被其他线程锁定。
1. read（读取）：作用于主内存变量，把一个变量值从主内存传输到线程的工作内存中，以便随后的load动作使用
1. load（载入）：作用于工作内存的变量，它把read操作从主内存中得到的变量值放入工作内存的变量副本中。
1. use（使用）：作用于工作内存的变量，把工作内存中的一个变量值传递给执行引擎，每当虚拟机遇到一个需要使用变量的值的字节码指令时将会执行这个操作。
1. assign（赋值）：作用于工作内存的变量，它把一个从执行引擎接收到的值赋值给工作内存的变量，每当虚拟机遇到一个给变量赋值的字节码指令时执行这个操作。
1. store（存储）：作用于工作内存的变量，把工作内存中的一个变量的值传送到主内存中，以便随后的write的操作。
1. write（写入）：作用于主内存的变量，它把store操作从工作内存中一个变量的值传送到主内存的变量中。

Java内存模型还规定了在执行上述八种基本操作时，必须满足如下规则：

- 如果要把一个变量从主内存中复制到工作内存，就需要按顺寻地执行read和load操作， 如果把变量从工作内存中同步回主内存中，就要按顺序地执行store和write操作。但Java内存模型只要求上述操作必须按顺序执行，而没有保证必须是连续执行。
- 不允许read和load、store和write操作之一单独出现
- 不允许一个线程丢弃它的最近assign的操作，即变量在工作内存中改变了之后必须同步到主内存中。
- 不允许一个线程无原因地（没有发生过任何assign操作）把数据从工作内存同步回主内存中。
- 一个新的变量只能在主内存中诞生，不允许在工作内存中直接使用一个未被初始化（load或assign）的变量。即就是对一个变量实施use和store操作之前，必须先执行过了assign和load操作。
- 一个变量在同一时刻只允许一条线程对其进行lock操作，但lock操作可以被同一条线程重复执行多次，多次执行lock后，只有执行相同次数的unlock操作，变量才会被解锁。lock和unlock必须成对出现
- 如果对一个变量执行lock操作，将会清空工作内存中此变量的值，在执行引擎使用这个变量前需要重新执行load或assign操作初始化变量的值
- 如果一个变量事先没有被lock操作锁定，则不允许对它执行unlock操作；也不允许去unlock一个被其他线程锁定的变量。
- 对一个变量执行unlock操作之前，必须先把此变量同步到主内存中（执行store和write操作）。

##### Java内存模型解决的问题

当对象和变量被存放在计算机中各种不同的内存区域中时，就可能会出现一些具体的问题。Java内存模型建立所围绕的问题：在多线程并发过程中，如何处理多线程读同步问题与可见性（多线程缓存与指令重排序）、多线程写同步问题与原子性（多线程竞争race condition）。

1. 多线程读同步与可见性

> 可见性（共享对象可见性）：线程对共享变量修改的可见性。当一个线程修改了共享变量的值，其他线程能够立刻得知这个修改

线程缓存导致的可见性问题：

> 如果两个或者更多的线程在没有正确的使用volatile声明或者同步的情况下共享一个对象，一个线程更新这个共享对象可能对其它线程来说是不可见的：共享对象被初始化在主存中。跑在CPU上的一个线程将这个共享对象读到CPU缓存中，然后修改了这个对象。只要CPU缓存没有被刷新会主存，对象修改后的版本对跑在其它CPU上的线程都是不可见的。这种方式可能导致每个线程拥有这个共享对象的私有拷贝，每个拷贝停留在不同的CPU缓存中。

解决这个内存可见性问题你可以使用：

> 1. Java中的volatile关键字：volatile关键字可以保证直接从主存中读取一个变量，如果这个变量被修改后，总是会被写回到主存中去。Java内存模型是通过在变量修改后将新值同步回主内存，在变量读取前从主内存刷新变量值这种依赖主内存作为传递媒介的方式来实现可见性的，无论是普通变量还是volatile变量都是如此，普通变量与volatile变量的区别是：volatile的特殊规则保证了新值能立即同步到主内存，以及每个线程在每次使用volatile变量前都立即从主内存刷新。因此我们可以说volatile保证了多线程操作时变量的可见性，而普通变量则不能保证这一点。
> 2. Java中的synchronized关键字：同步快的可见性是由“如果对一个变量执行lock操作，将会清空工作内存中此变量的值，在执行引擎使用这个变量前需要重新执行load或assign操作初始化变量的值”、“对一个变量执行unlock操作之前，必须先把此变量同步回主内存中（执行store和write操作）”这两条规则获得的。
> 3. Java中的final关键字：final关键字的可见性是指，被final修饰的字段在构造器中一旦被初始化完成，并且构造器没有把“this”的引用传递出去（this引用逃逸是一件很危险的事情，其他线程有可能通过这个引用访问到“初始化了一半”的对象），那么在其他线程就能看见final字段的值（无须同步）

重排序导致的可见性问题：

> Java程序中天然的有序性可以总结为一句话：如果在本地线程内观察，所有操作都是有序的（“线程内表现为串行”(Within-Thread As-If-Serial Semantics)）；如果在一个线程中观察另一个线程，所有操作都是无序的（“指令重排序”现象和“线程工作内存与主内存同步延迟”现象）。
>
> Java语言提供了volatile和synchronized两个关键字来保证线程之间操作的有序性：
>
> 1. volatile关键字本身就包含了禁止指令重排序的语义
> 2. synchronized则是由“一个变量在同一个时刻只允许一条线程对其进行lock操作”这条规则获得的，这个规则决定了持有同一个锁的两个同步块只能串行地进入

指令序列的重排序：

> 1) 编译器优化的重排序。编译器在不改变单线程程序语义的前提下，可以重新安排语句的执行顺序。
> 2) 指令级并行的重排序。现代处理器采用了指令级并行技术（Instruction-LevelParallelism，ILP）来将多条指令重叠执行。如果不存在数据依赖性，处理器可以改变语句对应机器指令的执行顺序。
> 3) 内存系统的重排序。由于处理器使用缓存和读/写缓冲区，这使得加载和存储操作看上去可能是在乱序执行。

每个处理器上的写缓冲区，仅仅对它所在的处理器可见。这会导致处理器执行内存操作的顺序可能会与内存实际的操作执行顺序不一致。由于现代的处理器都会使用写缓冲区，因此现代的处理器都会允许对写-读操作进行重排序：

数据依赖：

编译器和处理器在重排序时，会遵守数据依赖性，编译器和处理器不会改变存在数据依赖关系的两个操作的执行顺序。（这里所说的数据依赖性仅针对单个处理器中执行的指令序列和单个线程中执行的操作，不同处理器之间和不同线程之间的数据依赖性不被编译器和处理器考虑）


指令重排序对内存可见性的影响：

当1和2之间没有数据依赖关系时，1和2之间就可能被重排序（3和4类似）。这样的结果就是：读线程B执行4时，不一定能看到写线程A在执行1时对共享变量的修改。

as-if-serial语义：

不管怎么重排序（编译器和处理器为了提高并行度），（单线程）程序的执行结果不能被改变。（编译器、runtime和处理器都必须遵守as-if-serial语义）

happens before：

从JDK 5开始，Java使用新的JSR-133内存模型，JSR-133使用happens-before的概念来阐述操作之间的内存可见性：在JMM中，如果一个操作执行的结果需要对另一个操作可见（两个操作既可以是在一个线程之内，也可以是在不同线程之间），那么这两个操作之间必须要存在happens-before关系：

> 1. 程序顺序规则：一个线程中的每个操作，happens-before于该线程中的任意后续操作。
> 1. 监视器锁规则：对一个锁的解锁，happens-before于随后对这个锁的加锁。
> 1. volatile变量规则：对一个volatile域的写，happens-before于任意后续对这个volatile域的读。
> 1. 传递性：如果A happens-before B，且B happens-before C，那么A happens-before C。
> 1. 一个happens-before规则对应于一个或多个编译器和处理器重排序规则

内存屏障禁止特定类型的处理器重排序：

重排序可能会导致多线程程序出现内存可见性问题。对于处理器重排序，JMM的处理器重排序规则会要求Java编译器在生成指令序列时，插入特定类型的内存屏障（Memory Barriers，Intel称之为Memory Fence）指令，通过内存屏障指令来禁止特定类型的处理器重排序。通过禁止特定类型的编译器重排序和处理器重排序，为程序员提供一致的内存可见性保证。

为了保证内存可见性，Java编译器在生成指令序列的适当位置会插入内存屏障指令来禁止特定类型的处理器重排序。

StoreLoad Barriers是一个“全能型”的屏障，它同时具有其他3个屏障的效果。现代的多处理器大多支持该屏障（其他类型的屏障不一定被所有处理器支持）。执行该屏障开销会很昂贵，因为当前处理器通常要把写缓冲区中的数据全部刷新到内存中（Buffer Fully Flush）。

2. 多线程写同步与原子性

多线程竞争（Race Conditions）问题：当读，写和检查共享变量时出现race conditions。

如果两个或者更多的线程共享一个对象，多个线程在这个共享对象上更新变量，就有可能发生race conditions。

解决这个问题可以使用Java同步块。一个同步块可以保证在同一时刻仅有一个线程可以进入代码的临界区。同步块还可以保证代码块中所有被访问的变量将会从主存中读入，当线程退出同步代码块时，所有被更新的变量都会被刷新回主存中去，不管这个变量是否被声明为volatile。

使用原子性保证多线程写同步问题：

原子性：指一个操作是按原子的方式执行的。要么该操作不被执行；要么以原子方式执行，即执行过程中不会被其它线程中断。

实现原子性：

由Java内存模型来直接保证的原子性变量操作包括read、load、assign、use、store、write，我们大致可以认为基本数据类型变量、引用类型变量、声明为volatile的任何类型变量的访问读写是具备原子性的（long和double的非原子性协定：对于64位的数据，如long和double，Java内存模型规范允许虚拟机将没有被volatile修饰的64位数据的读写操作划分为两次32位的操作来进行，即允许虚拟机实现选择可以不保证64位数据类型的load、store、read和write这四个操作的原子性，即如果有多个线程共享一个并未声明为volatile的long或double类型的变量，并且同时对它们进行读取和修改操作，那么某些线程可能会读取到一个既非原值，也不是其他线程修改值的代表了“半个变量”的数值。但由于目前各种平台下的商用虚拟机几乎都选择把64位数据的读写操作作为原子操作来对待，因此在编写代码时一般也不需要将用到的long和double变量专门声明为volatile）。这些类型变量的读、写天然具有原子性，但类似于 “基本变量++” / “volatile++” 这种复合操作并没有原子性。
如果应用场景需要一个更大范围的原子性保证，需要使用同步块技术。Java内存模型提供了lock和unlock操作来满足这种需求。虚拟机提供了字节码指令monitorenter和monitorexist来隐式地使用这两个操作，这两个字节码指令反映到Java代码中就是同步快——synchronized关键字。


##### JMM对特殊Java语义的特殊规则支持

- volatile（保证内存可见性：Lock前缀的指令、内存屏障禁止重排序）
- synchronized（保证内存可见性和操作原子性：互斥锁；锁优化）

### 入门

#### 搭建环境

1. 下载JDK：选择所在系统对应的平台  window  linux  dos macOS
	bin 工具集 javac、java、jar、javadoc
	include 本地（native）开发的头文件（C .h）jre java运行环境 src java的一些源码 lib 库文件*.jar
	JDK包含编译器、工具集和运行环境
2. 配置环境变量(java命令不依赖、javac依赖path、环境变量结尾不能是分号)
	//java_home=C:\Program Files\Java\jdk1.7.0_40【jdk安装目录】 和其他软件约定的一个变量名 （tomcat，jboss weblogic）
	//path=%path%;%java_home%\bin:window搜索可行程序的目录，此环境变量一般已经存在 system32
3. 编译javac java源文件
4. 运行java class文件名

#### HelloWorld

javac -d e:\HelloWorld.java

改错：认真看错误提示信息，如果有多个错误先修改第一个错误
       
理解，写代码

在一个源程序文件中可以定义多个类，也可以定义多个主函数，如果要执行那个类中的主函数，直接在java命令后面跟类名。

原则：在一个源程序文件中只定义一个类。

包命名原则：把公司的域名倒过来。http://www.gemptc.com com.gemptc。com.baidu.+工程名或者人名...

类全名：包名+类名
    
jvm启动时把java.lang包中的所有类加载到内存
        
classpath:jvm搜索字节码文件的路径
	
classpath=f:\
java com.gemptc.HelloWorld

编码相关：把.java文件另存为存为gbk，用记事本打开复制、或者另存gbk覆盖，或者在IDE中设置。

workspace:不要用中文，也不要有空格
project【java project】-->写类-->写代码

文档注释 dos命令提取 javadoc

java documentation:training

javadoc 生成帮助文档

javadoc 源程序文件名

api:java内置工具类

#### Java 标识符

标识符：字符、数字、下划线_，美元符$
String package;
int public;
int age;
int i;
String name;
String a;

java标识符规范      java语言使用unicode标准字符集 严格区分大小写

java所有关键字全部是小写:     for  if关键字 所以For，If是合法标识符 

关键字不是合法标识符

命名约定：
1. 类或接口名 单词首字母全部大写
2. 字段、方法和对象第一个单词首字母小写，其他单词首字母大写
3. 常量全部字母大写 并非必须的    final+数据类型+常量大写
4. java包全部字母小写

#### Java 变量

变量的意义：程序运行必须先把软件加载到内存，申请和释放

变量的分类：
1. 局部变量 方法内部定义
2. 成员变量(全局):属性 实例变量  类的内部方法的外部    局部变量可与成员变量重名，此时成员变量在此方法中暂时失效(this.x即可使用)

变量三要素：分配存储空间的大小（数据类型）、变量名、变量的作用域

变量的作用域(生命周期)：
1. 属性的作用域从定义位置开始，一直到这个类结束;
2. 局部变量作用域从定义位置开始，到这个方法结束

```java
   public void m(){
   		//错误
   	    int i = 20;
		{
			int i = 10;
		}
   }
  public void m(){
   		//正确
		{
			int i = 10;
		}
		 int i = 20;
   
  }
```

#### Java 数据类型

基本数据类型为整型6种、布尔、字符共8种，不含String。（一个字节分配8个二进制位）

- 整数 整型数据存储时使用连续空间
	+ byte     1字节 -128~127   约定：10000000表示-128
	+ short    2字节
	+ int      4字节
	+ long     8字节
- 实数 浮点型整数和小数是分开存储的
	+ float    4字节
	+ double   8字节                    	
> 注意：浮点类型是一个近似值，不可“==”判断俩个数值或变量相等，要用差的绝对值	Math.abs(a-b)<=0.000001
- 布尔类型
- 字符类型  2字节 只存储unicode编码的字符（一个字符2个字节）   转义字符查表    \\反斜杠   \r回车  \t制表符 \n换行  \b退格
- 引用数据类型	类、接口、数组（String类其实是char型数组）

基本数据类型可隐式转换的
- byte short char->int->long->float->double 反向即是强制转换
- byte short char 这三种数据类型互相不进行数据转换    char和int转换联系到unicode编码使用强转即可

逻辑运算符 "短路与"&&与&    "短路或"||与|的区别
> 注意：&、|操作符两边不是布尔类型时为位运算符。

3.14  double 8b
123   int    4b
true  false
'a'    'b'
"abcdef"
012=10

#### Java 控制语句

break:可以用在循环中，可以用在switch。continue:只能用在循环中。

跳出外层循环体：
1. 给外层循环起名；
2. 设置标志位。

```java
int a = 10;
switch(a){
}

boolean  flag = true;
while(flag){
		//循环体
}

// 看别人程序，一步一步执行
do...while

for
// 第一步
// 第二步
...

while(...){
	    if(..){
	       ....
	       continue;//没有必要
	   }else if(...){
	   	....
	   	continue;
	   }else{
	   	....
	   	continue;
	   }
}
```

#### Java 数组

数组：一次定义一批变量，并且能有规律的使用这些变量
```java
int age1;
int age2;
...
```

声明`int[] a;`或者`int a[];`是一样的。

#### Java 类

类：
属性：每个对象，属性的取值是不一样的：height、weight、age、name...
方法：每个对象，方法是只有一份：speak、run...

小李：对象：178cm、80kg、20、"xiaoli"
小王：对象：175cm、70kg、21、"xiao王"speak、run...

交通工具：speed、volumn、vendor...       increaseSpeed、run
对象1：speed：200码、volumn：7、vendor：奥迪
对象2：speed：100码、volumn：5、vendor：一汽
对象3：speed：150码、volumn：5、vendor：上海大众

方法的调用
1. 必须写在类中 
2. 形式参数传值 实例参数必 须与形参一致：类型，个数，顺序。 注意:代码中小数如1.1默认double型 若是float要写成1.1f
3. 返回值 返回值类型

方法参数都是值传递。值传递的原则：基本类型传递的是该数据值本身，引用类型传递的是对象的引用。

Transient修饰类成员表示此成员不会被实例化。

类的产生过程:
- 引用、声明:1.静态的 成员变量、代码块、方法自上而下依次执行
- 创建类1.非静态代码块2.构造方法 3.非静态成员变量和方法;

JAVA类首次装入时，会对静态成员变量或方法进行一次初始化，但方法不被调用是不会执行的，静态成员变量和静态初始化块级别相同，非静态成员变量和非静态初始化块级别相同。先初始化父类的静态代码--->初始化子类的静态代码-->初始化父类的非静态代码块和属性--->初始化父类构造函数--->初始化子类非静态代码块和属性--->初始化子类构造函数

声明	new实例化

static: 修饰内部类、类成员(方法、变量、代码块)

(类成员)静态字段、属性和静态方法不需要创建实例就可以使用。

注意：
- 在静态成员函数中只能直接调用其它的静态成员函数或引用静态属性，否则编译错误。
- 静态成员函数中也不能使用this或者super，因为它们是和类的对象相关联的。

类的静态属性是所有实例共有的。

类中static方法在第一次调用时加载，类中static成员按在类中出现的顺序加载：首先依次被初始化，再依次被赋值。

native+方法表示该要用另外一种依赖平台的编程语言实现，不存在被子类实现

final+变量\方法\类表示不可更改(没有默认值)\覆写\不可被继承(C#sealed)。但final+修饰对象仅表示对象引用不能改变，对象本身属性可以更改。内部类要访问局变量，必须定义成final类型。

抽象类和接口与修饰符private并不是一定排斥，而abstract关键字与static和final排斥。

public 修饰类或者接口时，规则一样 只限用于类名或者接口名与java文件名相同的情况。

抽象类含至少一个抽象方法，没有方法体{...}   注意:{无代码}是空实现不是抽象方法

接口中定义的方法都是抽象方法;  定义的字段都是常量  

接口中定义的方法默认且必须是public abstract(都可省略)修饰 其他修饰java编译器不认可

接口中定义的字段默认且必须是public static final(都可省略)修饰

##### 内部类

内部类的构造方法不用public修饰 无意义   

唯一的好处是方便地访问外部类的私有属性   直接调用属性和方法----->>> 遇到同名变量则 外部类.this.成员   遵循静态与非静态规则

某个类继承内部类时1. extends 外部类.内部类 2.构造方法带参(外部类 对象) 且方法体使用 该对象.super()

成员内部类的对象实例化操作必须在外部类或者外部类的非静态方法中实现   且new操作符之前只能是:外部类对象.new                   内部类class文件名:外部类名$内部类名        可以修饰符修饰类 访问权限和类成员相同  
局部内部类 方法中定义，要使该方法的参数被内部类访问 参数前需加final修饰  若存此类已有同名变量 测试无法访问方法参数final          内部类class文件名:外部类名+$序号+内部类名
匿名内部类 不依赖外部类对象  必须继承某个类或者实现某个接口                                                                              
静态内部类 不依赖外部类对象、也不可以使用外部类的非静态成员 很少用 其中定义主方法便于测试  static+成员内部类(外部类不能static修饰) 

成员内部类不可以有类变量。（为什么？）依赖外部类对象，与类变量（静态属性、方法）由类名直接调用矛盾，但是常量可以。

注：同一个java文件中最外层未用public修饰的类，不是内部类，是一个正常类，只是不能用public修饰。

#### Java 面向对象

面向对象：封装、继承、多态。

封装：把数据封装到类中的，外部不用直接调用 容易数据混乱(直接赋值 有数据溢出或者类型异常的风险)

编译时多态，方法重载(overload)：
1. 在同一个类中
1. 方法名相同
2. 参数类型不同、参数个数不同、参数次序不同

不是方法重载：
```java
    m(int a);
    m(int b);
```

是方法重载：
```java
    m(int a,float f);
    m(float f,int a);
    
    m(int a,float f,double d);
    m(float f,int a);
    
    m(String s);
    m(int a);
```

##### 继承

`extends class implements interface`

1. 子类中定义的成员变量和父类非私人成员变量和方法相同时，则父类中的该成员不能被继承。
2. 构造方法:public+类名(){}	4修饰符都可以	没有返回值也不需要void

实例化子类时，子类若未显式调用父类构造则默认调用父类无参构造，父类若无则编译报错。
编译时类中无构造则系统会默认添加无参构造，若有定义则不添加。

super:指向父类的对象引用
1. 当子类重写了父类的方法，在重写的方法中调用父类方法
2. 调用父类的构造方法：必须写在子类的构造方法第一行`super(...);`
3. 当子类的属性和父类中的属性相同时，引用父类的属性`super.name`

this:指向本类对象的引用
1. `this(...)`
2. `this.name`

super()表示调用父类的构造方法 this()用于调用本类的构造方法。 注意:必须在构造体第一行、构造方法不可以递归
调用父类方法或者属性关键字super(C#base)  

运行时多态，方法覆盖、重写(override)：
1. 必须要有继承
1. 方法名相同
2. 参数和返回值类型也相同
3. 方法的权限不能比父类的方法权限更严格
4. 子类方法抛出的异常不能比父类方法抛出的异常范围大

##### 多态

(编译时多态)方法的重载
(运行时多态)把子类对象当做父类对象来看,如果子类重写了父类中的某个方法，通过父类对象的引用调用这个方法时调用子类中的方法
多态的原理是当方法被调用时，无论对象是否被转换为其父类，都只有位于对象继承链最末端的方法实现会被调用。

增加新功能 一定要继承某个类 运用多态

重载(OverLoad)：1.方法名相同 2.参数不同(个数、类型、顺序至少一个不同) 3.同一个类中 注意:方法重载跟返回值类型和修饰符无关
覆盖(重写)Override：1.方法名相同 2.参数和返回值类型也相同 3.方法权限不能比父类的更严格 4.子类抛出异常不能比父类的范围大;

被重写的前提是被继承，而构造方法根本就不能被继承，所以谈不上被重写。另外，静态方法只能形式上重写，并不具备多态，本质上不能重写。


##### 内存

Java 把内存划分两种:
- 栈内存	存放基本类型变量和对象的引用变量  当超过变量作用域后，Java自动释放该变量的内存空间              局部变量驻留在栈上
- 堆内存	存放由 new 创建的对象和数组       堆中分配的内存由java虚拟机的自动垃圾回收器来管理              实例变量和对象驻留在堆上
	+ 常量池  在堆中分配出来的一块存储区域  存放储显式的String常量和基本类型常量(float、int等)。另外，可以存储不经常改变的东西(public static final)。常量池中的数据可以共享。
	+ 静态存储 static的修饰的变量和方法

内存加载
-->>>开始:虚拟机加载主方法所在类，提取类信息到方法区。
-->>>通过保存在方法区的字节码，虚拟机开始执行main方法，main方法入栈。
-->>>由上而下执行main方法的指令

创建子类对象：new 子类()给子类实例对象分配堆空间
-->>>虚拟机首先加载父类到方法区，并在堆中为父类成员变量在子类空间中初始化
1. 装载:通过类的全名产生对应类的二进制数据流，分析并转换为方法区特定的数据结构，创建对应类的java.lang.Class实例  
2. 链接:  
	1. 01分为检测（确保被导入类型的正确性。)
	2. 02准备（为类变量分配内存，并将其初始化为默认值）--->>>父类静态代码  
    3. 03解析（把类型中的符号引用转换成直接引用） 
3. 显式初始化:把类变量(static)初始化为正确初始值。  

-->>>然后加载子类到方法区，为子类的非继承成员变量分配空间并初始化默认值
子类1装载2链接3显式初始化                              ---->>>子类静态代码  
调用父类构造方法
调用子类构造方法
(保存了父类属性和方法的一个引用super,没有实例化父类,然而其中private成员，虽会被初始化在子类父对象中，但对super不可见)


-->>>将子类的实例对象地址赋值给子类的引用变量
返回堆内存中对象的引用

程序结束
main方法执行完毕出栈，主线程消亡，虚拟机实例消亡


##### 面向接口编程

```java
public interface Movable{
	public void run();
}
```

接口与接口之间继承关系:可以多继承`public interface IA extends IB`

类与类之间的关系继承：单继承

类和接口之间是实现关系
```java
  public class CA extends CB implements IA,IB {
}
```  

#### Java 字符串

String:对象池；不可变对象；最终类

字符串编码转换
```java  
  iso8859-1 --->utf-8
  String s = "个会尽快yiol";//   iso8859-1
  //获得s表示的字节数组
  byte [] data = s.getBytes("iso8859-1")
  //重现编码
  String str = new String(data,"utf-8");//utf-8编码
```

String:
 char charAt(int index) 
          返回指定索引处的 char 值。 
 int compareTo(String anotherString) 
          按字典顺序比较两个字符串。 
 int compareToIgnoreCase(String str) 
          按字典顺序比较两个字符串，不考虑大小写。 
 String concat(String str) 
          将指定字符串连接到此字符串的结尾。 
 boolean contains(CharSequence s) 
          当且仅当此字符串包含指定的 char 值序列时，返回 true。 
 boolean endsWith(String suffix) 
          测试此字符串是否以指定的后缀结束。 
 boolean equals(Object anObject) 
          将此字符串与指定的对象比较。 
 boolean equalsIgnoreCase(String anotherString) 
          将此 String 与另一个 String 比较，不考虑大小写。 
 byte[] getBytes(Charset charset) 
          使用给定的 charset 将此 String 编码到 byte 序列，并将结果存储到新的 byte 数组。 
 byte[] getBytes(String charsetName) 
          使用指定的字符集将此 String 编码为 byte 序列，并将结果存储到一个新的 byte 数组中。 
 int hashCode() 
          返回此字符串的哈希码。 
 int indexOf(int ch) 
          返回指定字符在此字符串中第一次出现处的索引。 
 int indexOf(int ch, int fromIndex) 
          返回在此字符串中第一次出现指定字符处的索引，从指定的索引开始搜索。 
 int indexOf(String str) 
          返回指定子字符串在此字符串中第一次出现处的索引。 
 int indexOf(String str, int fromIndex) 
          返回指定子字符串在此字符串中第一次出现处的索引，从指定的索引开始。 
 int lastIndexOf(int ch) 
          返回指定字符在此字符串中最后一次出现处的索引。 
 int lastIndexOf(int ch, int fromIndex) 
          返回指定字符在此字符串中最后一次出现处的索引，从指定的索引处开始进行反向搜索。 
 int lastIndexOf(String str) 
          返回指定子字符串在此字符串中最右边出现处的索引。 
 int lastIndexOf(String str, int fromIndex) 
          返回指定子字符串在此字符串中最后一次出现处的索引，从指定的索引开始反向搜索。 
 int length() 
          返回此字符串的长度。 
 boolean matches(String regex) 
          告知此字符串是否匹配给定的正则表达式。 
 String replace(char oldChar, char newChar) 
          返回一个新的字符串，它是通过用 newChar 替换此字符串中出现的所有 oldChar 得到的。 
 String replace(CharSequence target, CharSequence replacement) 
          使用指定的字面值替换序列替换此字符串所有匹配字面值目标序列的子字符串。 
 String replaceAll(String regex, String replacement) 
          使用给定的 replacement 替换此字符串所有匹配给定的正则表达式的子字符串。 
 String[] split(String regex) 
          根据给定正则表达式的匹配拆分此字符串。 
 String[] split(String regex, int limit) 
          根据匹配给定的正则表达式来拆分此字符串。 
 boolean startsWith(String prefix) 
          测试此字符串是否以指定的前缀开始。 
 boolean startsWith(String prefix, int toffset) 
          测试此字符串从指定索引开始的子字符串是否以指定前缀开始。 
 String substring(int beginIndex) 
          返回一个新的字符串，它是此字符串的一个子字符串。 
 String substring(int beginIndex, int endIndex) 
          返回一个新字符串，它是此字符串的一个子字符串。 
 char[] toCharArray() 
          将此字符串转换为一个新的字符数组。 
 String toLowerCase() 
          使用默认语言环境的规则将此 String 中的所有字符都转换为小写。 
 String toLowerCase(Locale locale) 
          使用给定 Locale 的规则将此 String 中的所有字符都转换为小写。 
 String toString() 
          返回此对象本身（它已经是一个字符串！）。 
 String toUpperCase() 
          使用默认语言环境的规则将此 String 中的所有字符都转换为大写。 
 String toUpperCase(Locale locale) 
          使用给定 Locale 的规则将此 String 中的所有字符都转换为大写。 
 String trim() 
          返回字符串的副本，忽略前导空白和尾部空白。 
static String valueOf(boolean b) 
          返回 boolean 参数的字符串表示形式。 
static String valueOf(char c) 
          返回 char 参数的字符串表示形式。 
static String valueOf(char[] data) 
          返回 char 数组参数的字符串表示形式。 
static String valueOf(char[] data, int offset, int count) 
          返回 char 数组参数的特定子数组的字符串表示形式。 
static String valueOf(double d) 
          返回 double 参数的字符串表示形式。 
static String valueOf(float f) 
          返回 float 参数的字符串表示形式。 
static String valueOf(int i) 
          返回 int 参数的字符串表示形式。 
static String valueOf(long l) 
          返回 long 参数的字符串表示形式。 
static String valueOf(Object obj) 
          返回 Object 参数的字符串表示形式。 
          
```java
  String s = "    abc  d   ";
  String str = s.trim();//"abc d"
```

##### 正则表达式

正则表达式处理字符串、方便匹配数据  字符串拆分、验证和替换功能  查表

#### 单例设计模式

私有化构造方法

Static通常用于Singleton模式开发：

Singleton是一种设计模式，高于语法，可以保证一个类在整个系统中仅有一个对象。

#### Clone机制

存在两种方式
1. Shallow Clone：这种clone只对基本数据类型有效，对对象内的引用变量无效。
2. Deep Clone；对对象所有成员都有效，前提是这些成员都实现了Cloneable接口。

注意：
1. 使用Clone将会抛出异常。
2. 两种方式按自己需求而用，
3. clone有缺省行为super.clone()

#### Java 异常

Throwable
Error         重大的错误 如操作系统 等java代码无法做出更改
Exception     程序员编程疏忽、不受程序员控制(易检验异常) java代码可处理的
	RuntimeException:未检验异常 可以不作异常处理      由程序员控制     除非代码错误，否则不应该出现此类异常
	其他异常:已检验异常 已检验异常  必须异常处理 否则编译通不过

有异常未捕获、程序即终止，捕获后程序即恢复正常。

try{} catch(){}子类异常 catch(){}子类异常 catch(){}父类异常---->捕捉异常由上而下先子类后父类

finally语句必定执行，除非`System.exit(1);`。

注意：finally里若对返回值处理，不会影响基本数据类型的返回值，但影响引用类型的返回值。

```java
//一种写法
try{
	//可能发生异常的代码
}catch(IOException e){
	//异常处理
}catch(SQLException e){
	//异常处理
}

//另外一种写法
try{
	//可能发生异常的代码
}catch(IOException e){
	//异常处理
}catch(SQLException e){
	//异常处理
}finally{
	//最后执行的代码，通常释放资源
}
//第三种写法
try{
	//可能发生异常的代码
}
finally{
	//最后执行的代码，通常释放资源
}
```

##### throw与throws配合使用

throw +异常类对象 用在方法内，表示代码到此处异常了。
throws +异常类 用在方法声明处，抛出此类异常，表示调用此方法需要异常处理。


##### 已检验异常

AclNotFoundException,     Access Control List (ACL) 
BackingStoreException, 
BrokenBarrierException, 
CertificateException, 
ClassNotFoundException, 
CloneNotSupportedException, 
DataFormatException, 
DateParseException, 
DestroyFailedException, 
ExecutionException, 
GeneralSecurityException, 
HttpException, 
IllegalAccessException, 
InstantiationException, 
InterruptedException, 
InvalidPreferencesFormatException, 
InvocationTargetException, 
IOException, 
JSONException, 
LastOwnerException, 
NoSuchFieldException, 
NoSuchMethodException, 
NotOwnerException, 
ParseException, 
ParserConfigurationException, 
PrivilegedActionException, 
SAXException, 
SQLException, 
TimeoutException, 
TooManyListenersException, 
UnsupportedCallbackException, 
URISyntaxException, 
XmlPullParserException 
（以下属于Android里的异常）
AndroidException, 
Surface.OutOfResourcesException, 

##### 未检验异常

AnnotationTypeMismatchException, 
ArithmeticException, (算术运算中，被0除或模除)
ArrayStoreException, (数据存储异常，操作数组时类型不一致)
BufferOverflowException, 
BufferUnderflowException, 
ClassCastException, (类转换异常)
ConcurrentModificationException, 
DOMException, 
EmptyStackException, 
EnumConstantNotPresentException, 
IllegalArgumentException, 
IllegalMonitorStateException, 
IllegalStateException, 
IncompleteAnnotationException, 
IndexOutOfBoundsException, (索引超限）ArrayIndexOutOfBoundsException(数组越界)
MalformedParameterizedTypeException, 
MissingResourceException, 
NegativeArraySizeException, 
NoSuchElementException, 
NullPointerException, (空指针)
ParseException, 
ProviderException, 
RejectedExecutionException, 
SecurityException, 
TypeNotPresentException, 
UndeclaredThrowableException, 
UnsupportedDigestAlgorithmException, 
UnsupportedOperationException, 
（以下属于Android里的异常）
ActivityNotFoundException, 
AndroidRuntimeException, 
GLException, 
InflateException, 
ParcelFormatException, 
ParseException, 
RemoteViews.ActionException, 
Resources.NotFoundException, 
SQLException, 
StaleDataException, 
SurfaceHolder.BadSurfaceTypeException, 
TimeFormatException, 
WindowManager.BadTokenException 

#### Java 事务

事务：一组不可分割的执行单元

```java
    SQLiteDatabase db = helper.getWritableData();
    Transaction tran = db.beginTransaction();
    try{
	    a1 = a1 - 500;
	    //int a = 1 / 0;
	    a2 = a2 + 500;
	    tran.setSuccessfully(true);//设置事务成功
    }finally{
    	 tran.endTransaction();//false:回滚-->a1 = a1 + 500  true:commit
    }
```

#### Java 集合

集合 （约定：xxx是指接口 xxx类 是指类）
Collection  存放对象作为元素  有iterator、size等方法，实现了接口(Iterable<T>)  实现这个接口允许对象成为 "foreach" 语句的目标
-->>>List 大量扩充 内容允许重复，允许对象null    有下标索引（有序），根据索引[从0开始]操作对象
	-->>>ArrayList类	 顺序存储（数组），访问快 增删慢 
	-->>>LinkedList类	链式存储（特殊结构），访问慢 增删快 也是Deque双端队列的实现
	-->>>Vector类，ArrayList类的线程安全版本
-->>>Set  Set无法记住添加顺序（自定义比较器），不允许重复元素（重写Equals和hashCode方法，判断两个对象是否相等用equals不是==）
	-->>>SortedSet 单值排序接口 子类内容可使用比较器排序
		-->>>NavigableSet
			-->>>TreeSet类 有序（二叉树）  要么自然顺序[元素类须实现Compareble接口并覆写compareTo(Object o)方法]要么定制排序[提供一个比较器]
	-->>>HashSet类  散列存放	线程不安全	元素值允许是null  除了Equals相等,两个对象的hashCode方法返回值也要相等 此俩方法需要重写
		-->>>LinkedHashSet类
-->>>Quque 队列接口 子类可以实现队列操作
	-->>>Deque 双端队列可两端访问元素
		-->>>ArrayDeque类 
		-->>>LinkedList类

迭代器(Iterator)    只能单向输出   对collection进行迭代的迭代器  枚举接口Enumeration的取代
-->>>ListIterator   能双向输出

Properties
Collections 集合工具类 封装了对集合的一些操作。


Map集合  一对值 key->vaule  key具有唯一性 无序  允许值对象(value)是null 而且没有个数限制（即可重复）
-->>>SortedMap 一对值的排序接口  子类内容可使用比较器按照key排序
-->>>HashMap类	特殊结构（键值，哈希）数组，线程不安全，增删快 哈希码快速查找 允许key为null但唯一 除了Equals相等，hashCode也要相等
	-->>>LinkedHashMap类 保存记录的插入顺序或访问顺序
	-->>>ConcurrentHashMap类 线程安全
-->>>TreeMap类	key有序（二叉树） 不允许key为null
-->>>Hashtable类  线程安全 哈希码快速查找 不允许key或value为null 除了Equals相等，hashCode也要相等 此俩方法需要重写

在JDK1.7中，HashMap的数据结构还是连续数组+单链表； 在JDK1.8中，就变为了连续数组+单链表<->红黑树的结构。

#### Java IO输入输出流

因为输入输出流已经超越了VM的边界，所以有时可能无法回收资源。

原则：凡是跨出虚拟机边界的资源都要求程序员自己关闭，不要指望垃圾回收。

- 带缓存的流
	+ 空间越大效率越高，典型的空间换时间
	+ 切记flush方法将缓冲区中的内容一次性写入或写出
	+ close()也可以达到相同的效果，因为每次close都会使用flush
- 管道流，也是一种节点流，用来给两个线程交换数据
- 输出流：connect（输入流）

InputStream(字节输入流的抽象类)
-->>>FileInputStream(文件)
-->>>FilterInputStream（过滤流）		过滤流：用于给节点增加功能	过滤流的构造方式是以其他流位参数构造（这样的设计模式称为装饰模式）
	-->>>BufferedInputStream(带缓存)	
	-->>>DateInputStream(数据)		包装现有的OutputStream和写高位优先类型数据	可以编写类型包括字节,16位,32位,64位的整数,32位浮点数,64位双字节字符串,字节串和MUTF-8编码的字符串
-->>>ByteArrayInputStream【内存输入流】
-->>>ObjectInputStream[对象序列化二进制]	过滤流 对象的序列化
-->>>PipedInputStream[管道流]			
-->>>SequenceInputStream[合并流]
-->>>ZipInputStream[压缩流]

Reader(字符输入流的抽象类)
-->>>InputStreamReader(字符流in对象)	字节输入流转换成字符输出流对象
	-->>>FileReader(文件)【缓存区】
-->>>BufferedReader(带缓存)
-->>>


OutputStream(字节输出流的抽象类)
-->>>FileOutputStream(文件)
-->>>FilterOutputStream
	-->>>BufferedOutputStream(带缓存)
	-->>>DateOutputStream(数据)
-->>>ByteArrayOutputStream【内存输出流】
-->>>ObjectOutputStream[对象]
-->>>PipedOutputStream[管道流]
-->>>ZipOutputStream[压缩流]

Writer(字符输出流的抽象类)
-->>>OutputStreamWriter(字节流out对象)	字节输出流转换成字符输入流		常用声明格式:OutputStreamWriter os=new OutputStreamWriter(new FileOutputStream(file));
	-->>>FileWriter(文件)【缓存区】
-->>>BufferedWriter(带缓存的)
-->>>

java.uti.zip压缩输入输出流
ZipInputStream
ZipOutputStream

#### Java 泛型

类型的参数化。不包含基本类型，可以是其包装类。
泛型类 类名 <T1,T2...> 此类的对象（不是类）内部即可认为T是某个固定类使用。
泛型方法 void <T1,T2...> 方法名(T t) 返回值类型、局部变量类型也可以是T，参数则必须有T 入口

#### Java 网络

端口(port)：一台PC中可以有65536个端口，进程通过端口交换数据。连线的时候需要输入IP也需要输入端口信息。计算机通信实际上的主机之间的进程通信，进程的通信就需要在端口进行联系。端口应该用1024以上的端口，以下的端口都已经设定功能。

套接字(socket)的引入：

Ip+Port=Socket（这是个对象的概念。）

Socket为传输层概念，而JSP是对应用层编程。例：

```java
java.net.*;

// Server端定义顺序
ServerSocket(int port)
Socket.accept()；// 阻塞方法，当客户端发出请求是就恢复
// 如果客户端收到请求：
Socket SI=ss.accept()；

// 在client端
Socket s=new Socket(“127.0.0.1”,8000);
```
注意客户端和服务器的Socket为两个不同的socket。

Socket的两个方法：
1. getInputStream()：客户端用
2. getOutputStream() 服务器端用

使用完毕后切记Socket.close()，两个Socket都关，而且不用关内部的流。


##### TCP/IP协议

名称中只有TCP，但是在TCP/IP的传输层同时存在TCP和UDP两个协议。

TCP
-->>>InetAdress
-->>>ServerSocket 单向通信

Tranfer Control Protocol的简称，是一种面向连接的保证可靠传输的协议。通过TCP协议传输，得到的是一个顺序的无差错的数据流。发送方和接收方的成对的两个socket之间必须建立连接，以便在TCP协议的基础上进行通信，当一个socket(通常都是server socket)等待建立连接时，另一个socket可以要求进行连接，一旦这两个socket连接起来，它们就可以进行双向数据传输，双方都可以进行发送或接收操作。

UDP

User Datagram Protocol的简称，是一种无连接的协议，每个数据报都是一个独立的信息，包括完整的源地址或目的地址，它在网络上以任何可能的路径传往目的地，因此能否到达目的地，到达目的地的时间以及内容的正确性都是不能被保证的。

- DatagramSocket（邮递员）：对应数据报的Socket概念，不需要创建两个socket，不可使用输入输出流。
- DatagramPacket（信件）：数据包，是UDP下进行传输数据的单位，数据存放在字节数组中。
- UDP也需要现有Server端，然后再有Client端。
- 两端都是DatagramPacket（相当于电话的概念），需要NEW两个DatagramPacket。

InetAddress:网址
这种信息传输方式相当于传真，信息打包，在接受端准备纸。

模式：
发送端：Server:
```java
DatagramPacket  inDataPacket=new DatagramPacket ((msg,msg.length); InetAdress.getByName(ip),port);
```
接收端：
```java
clientAddress=inDataPack.getAddress();//取得地址
clientPort=inDataPack.getPort();//取得端口号
datagramSocket.send;  //Server
datagramSocket.accept;  //Client
```
URL:在应用层的编程

注意比较：
```
http://Localhost:8080/directory  //查找网络服务器的目录
file://directory                 //查找本地的文件系统
```
java的开发主要以http为基础。

#### Java 反射
反射主要用于工具和框架的开发。

反射是对于类的再抽象；通过字符串来抽象类。

JAVA类的运行：classLoader:加载到虚拟机（vm）。Vm中只能存储对象（动态运行时的概念），.class文件加载到VM上就成为一个对象，同时初始静态成员及静态代码（只执行一次）。

Lang包下有一个类为Class：在反射中使用。此类中的每个对象为VM中的类对象，每个类都对应类类的一个对象（class.class）。例：对于一个Object类，用getClass()得到其类的对象，获得类的对象就相当于获得类的信息，可以调用其下的所有方法，包括类的私有方法。

注意：在反射中没有简单数据类型，所有的编译时类型都是对象。

反射把编译时应该解决的问题留到了运行时。

#### Java 多线程

进程与线程的区别：
1. 进程有独立的进程空间，进程中的数据存放空间（堆空间和栈空间）是独立的。
2. 线程的堆空间是共享的，栈空间是独立的，线程消耗的资源也比进程小，相互之间可以影响的。

线程的生命周期：创建状态时，可通过Thread类的方法设置线程各种属性。如优先级、守护等。

创建线程方式之继承Thread类覆写run方法 建立该子类对象后调用start方法开启线程
创建线程方式之实现Runnable接口覆写run方法 建立该子类对象作为参数传递给Thread类的构造函数，该Thread类对象调用start方法开启线程

Thread子类不共享数据Runnable共享数据
obj.isAlive()线程是否启动
obj.join()强制运行线程，其他线程必须等待此线程完成
Thread.yield()当前线程礼让
obj.interrupt()打断线程

线程池：开启一条线程是非常浪费资源的，因为它涉及到要与操作系统进行交互；因此JDK5之后Java提供了线程池让我们提高性能，线程池里的线程执行完后，并不会死亡，而是再次回到线程池中成为空闲状态，等待下一个对象来使用。

Executors：创建线程池的工厂类。
```java
    // 创建一个可根据需要创建新线程的线程池，但是在以前构造的线程可用时将重用它们
    static ExecutorService newCachedThreadPool()
    // 创建一个可重用固定线程数的线程池，以共享的无界队列方式来运行这些线程
    static ExecutorService newFixedThreadPool(int nThreads)
    // 创建一个可根据需要创建新线程的线程池，但是在以前构造的线程可用时将重用它们，并在需要时使用提供的ThreadFactory创建新线程
    static ExecutorService newCachedThreadPool(ThreadFactory threadFactory)
    // 创建一个可重用固定线程数的线程池，以共享的无界队列方式来运行这些线程，在需要时使用提供的ThreadFactory创建新线程
    static ExecutorService newFixedThreadPool(int nThreads, ThreadFactory threadFactory)
    // 创建一个线程池，它可安排在给定延迟后运行命令或者定期地执行
    static ScheduledExecutorService newScheduledThreadPool(int corePoolSize)
    // 创建一个线程池，它可安排在给定延迟后运行命令或者定期地执行
    static ScheduledExecutorService newScheduledThreadPool(int corePoolSize, ThreadFactory threadFactory)
    //创建一个使用单个worker线程的Executor，以无界队列方式来运行该线程
    public static ExecutorService newSingleThreadExecutor()
```

ExecutorService：线程池管理接口，提供了线程的操作方法。
```java
    // 启动一次顺序关闭，执行以前提交的任务，但不接受新任务
    void shutdown()
    // 试图停止所有正在执行的活动任务，暂停处理正在等待的任务，并返回等待执行的任务列表
    List<Runnable> shutdownNow()
    // 提交一个返回值的任务用于执行，返回一个表示任务的未决结果的 Future
    <T> Future<T> submit(Callable<T> task)
    // 提交一个 Runnable任务用于执行，并返回一个表示该任务的 Future
    Future<?> submit(Runnable task)
    // 提交一个 Runnable任务用于执行，并返回一个表示该任务的 Future
    <T> Future<T> submit(Runnable task, T result)
```

##### 同步代码块
同步方法 的同步监听器其实的是this
同步静态方法的默认同步锁是当前方法所在类的.class对象

同步的实现方式synchronized,wait 与 notify 

#### JDBC

JDBC(java database connectivity) 包java.sql\javax.sql

JDBC 驱动的4种类型
1: JDBC-ODBC桥驱动程序	X
2: Native-API驱动程序	X
3: JDBC-NET通过服务器中间件与数据库通信-----中间件交互
4: 原生协议以及纯Java驱动程序		----直接交互

常用数据库URL地址的写法：
Oracle—jdbc:oracle:thin:@localhost:1521:sid
SqlServer—jdbc:microsoft:sqlserver://localhost:1433; DatabaseName=sid
MySql—jdbc:mysql://localhost:3306/sid
	jdbc:mysql:///sid

ResourceBundle类的作用就是读取资源属性文件（文件名.properties） 国际化
ResourceBundle.getBundle("文件名").getString("feild");

1.通过DriverManager.getConnection("url","user","password")创建连接Connection对象
2.通过此连接创建Statement对象，此对象调用执行sql语句的方法executeQuery("sql语句")，返回结果集ResultSet对象
-->>>executeQuery 用于产生单个结果集的语句，例如 SELECT 语句。
-->>>executeUpdate 用于执行 INSERT、UPDATE 或 DELETE 语句以及 SQLDDL（数据定义语言）语句，例如 CREATE TABLE 和 DROP TABLE
	executeUpdate 的返回值是一个整数，指示受影响的行数（即更新计数）。
	对于CREATE TABLE 或 DROP TABLE 等不操作行的语句，executeUpdate 的返回值总为零。
-->>>execute用于执行返回多个结果集、多个更新计数或二者组合的语句。但多数程序员不会需要该高级功能
...

-->>>Statement对象用于执行不带参数的简单 SQL 语句 建议使用PreparedStatement
	-->>>PreparedStatement对象用于执行带或不带 IN参数的预编译 SQL 语句
		-->>>CallableStatement对象用于执行对数据库已存储过程的调用
3.通过连接对象提交或者回滚
4.关闭Statement对象关闭Connection对象





### 最佳实践

加入支持jar包源码：
1、右击工程-->properties-->builder path-->libraries-->add external jar-->android sdk/extra/v4/support-v4.jar
2、libraries-->edit source-->右边编辑-->浏览到-->android sdk/extra/v4/src
3、右击工程-->properties-->builder path-->order and export-->support-v4移动顶部

Java性能优化技巧 https://www.jdon.com/performance/java-performance.html
