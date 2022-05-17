## go

Go 是从2007年末由Robert Griesemer, Rob Pike, Ken Thompson主持开发，后来还加入了Ian Lance Taylor, Russ Cox等人，并最终于2009年11月开源，在2012年早些时候发布了Go 1稳定版本。

现在Go的开发已经是完全开放的，并且拥有一个活跃的社区。

Go 语言最主要的特性：

- 自动垃圾回收
- 更丰富的内置类型
- 函数多返回值
- 错误处理
- 匿名函数和闭包
- 类型和接口
- 并发编程
- 反射
- 语言交互性


### Go 基础语法

Go 标记
Go 程序可以由多个标记组成，可以是关键字，标识符，常量，字符串，符号。

行分隔符
在 Go 程序中，一行代表一个语句结束。每个语句不需要像 C 家族中的其它语言一样以分号 ; 结尾，因为这些工作都将由 Go 编译器自动完成。
如果你打算将多个语句写在同一行，它们则必须使用 ; 人为区分，但在实际开发中不鼓励这种做法。

注释
可以在任何地方使用以 // 开头的单行注释。多行注释也叫块注释，均已以 /* 开头，并以 */ 结尾。

标识符
一个或是多个字母(A~Z和a~z)数字(0~9)、下划线_组成的序列，但是第一个字符必须是字母或下划线而不能是数字。

字符串连接
`fmt.Println("Google" + "Runoob")`

关键字

Go 语言的空格
变量的声明必须使用空格隔开，如：`var age int;`
语句中适当使用空格能让程序更易阅读。

Go 语言数据类型
布尔型 `var b bool = true`
数字类型 整型 int 和浮点型 float32、float64
字符串类型 串固定长度的字符连接起来的字符序列。字符串的字节使用 UTF-8 编码标识 Unicode 文本。
派生类型 指针类型（Pointer） 数组类型 结构化类型(struct) Channel 类型  函数类型 切片类型 接口类型（interface）Map 类型
基于架构的类型，例如：int、uint 和 uintptr。

uintptr 无符号整型，用于存放一个指针


#### Go 语言变量
```go
var v_name = value // 根据值自行判断类型
v_name := value。  // 省略 var 使用 := 此时该符号左边的所有变量，如 v_name， 如果都已经被声明过册产生编译错误。
var identifier type

var b int = 1 // 如果没有初始化，则变量默认为零值。 int 零值为0，bool 零值为false， string 零值为“”

// 多变量声明
// 类型相同多个变量, 非全局变量
var vname1, vname2, vname3 type; vname1, vname2, vname3 = v1, v2, v3
var vname1, vname2, vname3 = v1, v2, v3 // 和 python 很像,不需要显示声明类型，自动推断
vname1, vname2, vname3 := v1, v2, v3 // 出现在 := 左侧的变量不应该是已经被声明过的，否则会导致编译错误

// 这种因式分解关键字的写法一般用于声明全局变量
var (
    vname1 v_type1
    vname2 v_type2
)
```
不带声明格式的只能在函数体中出现

如果你声明了一个局部变量却没有在相同的代码块中使用它，会得到编译错误，但是全局变量是允许声明但不使用。

#### Go 语言常量
```go
const identifier [type] = value
const (
    Unknown = 0
    Female = 1
    Male = 2
)
// 常量可以用len(), cap(), unsafe.Sizeof()函数计算表达式的值。常量表达式中，函数必须是内置函数，否则编译不过

// iota 一个可以被编译器修改的常量。
// iota 在 const关键字出现时将被重置为 0(const 内部的第一行之前)，
// const 中每新增一行常量声明将使 iota 计数一次(iota 可理解为 const 语句块中的行索引)。

const (
    a = iota
    b = iota
    c = iota
)
const (
    a = iota
    b         // 如果不提供初始值，则表示将使用上行的表达式
    c
)
```

在函数外部定义的变量成为全局变量

全局变量和局部变量可以重名

全局变量定义时不能使用自动推到类型

全局变量可以在项目中所有文件进行使用

#### 值类型和引用类型

所有像 int、float、bool 和 string 这些基本类型都属于值类型，使用这些类型的变量直接指向存在内存中的值：

一个引用类型的变量 r1 存储的是 r1 的值所在的内存地址（数字），或内存地址中第一个字所在的位置。
只有三种引用类型：slice(切片)、map(字典)、channel(管道)。

声明数组 `var variable_name [SIZE] variable_type`

初始化数组
```go
var balance = [5]float32{1000.0, 2.0, 3.4, 7.0, 50.0}
var balance = [...]float32{1000.0, 2.0, 3.4, 7.0, 50.0} Go 语言会根据元素的个数来设置数组的大小
```

可以通过 &i 来获取变量 i 的内存地址，例如：0xf840000040（每次的地址都可能不一样）。值类型的变量的值存储在栈中。
这个内存地址为称之为指针，这个指针实际上也被存在另外的某一个字中。

指针变量 * 和地址值 & 的区别：
指针变量保存的是一个地址值，会分配独立的内存来存储一个整型数字。
当变量前面有 * 标识时，才等同于 & 的用法，否则会直接输出一个整型数字。

Go 空指针 当一个指针被定义后没有分配到任何变量时，它的值为 nil。

#### Go 语言运算符

算术运算符
关系运算符
逻辑运算符
位运算符
赋值运算符
其他运算符

注意：Go 没有三目运算符，所以不支持 ?: 形式的条件判断。


#### Go 语言条件语句
if 语句
if...else 语句
if 嵌套语句
switch 语句
select 语句 select 语句类似于 switch 语句，但是select会随机执行一个可运行的case。如果没有case可运行，它将阻塞，直到有case可运行。


#### Go 语言循环语句
for 循环
for 循环嵌套
循环控制语句     break 语句     continue 语句    goto 语句
无限循环        for true  {...}

#### Go 语言结构体
使用 struct 关键字定义
```go
type struct_variable_type struct {
   member definition;
   member definition;
   ...
   member definition;
}
```
访问结构体成员
结构体作为函数参数
结构体指针


#### Go 语言切片(Slice)
Go中提供了一种灵活，功能强悍的内置类型切片("动态数组")，与数组相比切片的长度是不固定的，可以追加元素，在追加时可能使切片的容量增大。
```go
var identifier []type

// 使用make()函数来创建切片:
  var slice1 []type = make([]type, len)
// 也可以简写为
  slice1 := make([]type, len)

make([]T, len, capacity)
// len 是数组的长度并且也是切片的初始长度。
// capacity为可选参数

// 切片初始化
s :=[] int {1,2,3 }

arr := [1,2,3]
s := arr[startIndex:endIndex]
s := arr[:]       // 整个数组即 0:end
```

切片是可索引的，并且可以由 len() 方法获取长度。

切片提供了计算容量的方法 cap() 可以测量切片最长可以达到多少。

空(nil)切片 一个切片在未初始化之前默认为 nil，长度为 0

拷贝切片的 copy 方法

向切片追加新元素的 append 方法


#### Go 语言Map(集合)
```go
/* 声明变量，默认 map 是 nil */
var map_variable map[key_data_type]value_data_type
/* 使用 make 函数 */
map_variable := make(map[key_data_type]value_data_type)
```
delete() 函数用于删除集合的元素, 参数为 map 和其对应的 key。
delete(Map, key)

#### Go 语言范围(Range)
range 关键字用于 for 循环中迭代数组(array)、切片(slice)、通道(channel)或集合(map)的元素。

在数组和切片中它返回元素的索引和索引对应的值，在集合中返回 key-value 对的 key 值。

```go
for i, num := range nums {...}
for k, v := range kvs {...}
for i, c := range "go" {...} // 第二个是字符（Unicode的值）本身
```

#### Go 语言递归函数
#### Go 语言类型转换
`type_name(expression)` 

如：`mean = float32(sum)/float32(count)`



#### Go 语言函数
Go 语言最少有个 main() 函数。

Go 语言函数定义格式如下：
```go
func function_name( [parameter list] ) [return_types] {
   // 函数体
}
```

函数返回多个值

函数参数       值传递        引用传递

函数用法       函数作为另外一个函数的实参       闭包     方法

#### Go 语言接口
```go
/* 定义接口 */
type interface_name interface {
   method_name1 [return_type]
   method_name2 [return_type]
   method_name3 [return_type]
   ...
   method_namen [return_type]
}

/* 定义结构体 */
type struct_name struct {
   /* variables */
}

/* 实现接口方法 */
func (struct_name_variable struct_name) method_name1() [return_type] {
   /* 方法实现 */
}
...
func (struct_name_variable struct_name) method_namen() [return_type] {
   /* 方法实现*/
}
```

#### Go 错误处理
error类型是一个接口类型，这是它的定义：
```go
type error interface {
    Error() string
}
```
```go
func Sqrt(f float64) (float64, error) {
    if f < 0 {
        return 0, errors.New("math: square root of negative number")
    }
    // 实现
}
```

#### Go 并发
goroutine 是轻量级线程，goroutine 的调度是由 Golang 运行时进行管理的。
go 函数名( 参数列表 )

Golang 标准库提供的所有系统调用操作(包括所有的同步 IO 操作)，都会出让 CPU 给其他 goroutine。这让 goroutine 的切换管理不依赖于系统的线程和进程，也不依赖于 CPU 的核心数量，而是交给 Golang 的运行时统一调度。

Golang 的运行时会在逻辑处理器上调度 goroutine 来运行。每个逻辑处理器都与一个操作系统线程绑定。在 Golang 1.5 及以后的版本中，运行时默认会为每个可用的物理处理器分配一个逻辑处理器。

每个逻辑处理器有一个本地运行队列。如果创建一个 goroutine 并准备运行，这个 goroutine 首先会被放到调度器的全局运行队列中。之后，调度器会将全局运行队列中的 goroutine 分配给一个逻辑处理器，并放到这个逻辑处理器的本地运行队列中。本地运行队列中的 goroutine 会一直等待直到被分配的逻辑处理器执行。

有时，正在运行的 goroutine 需要执行一个阻塞的系统调用，如打开一个文件。当这类调用发生时，线程和 goroutine 会从逻辑处理器上分离，该线程会继续阻塞，等待系统调用的返回。与此同时，这个逻辑处理器就失去了用来运行的线程。所以，调度器会创建一个新线程，并将其绑定到该逻辑处理器上。之后，调度器会从本地运行队列里选择另一个 goroutine 来运行。一旦被阻塞的系统调用执行完成并返回，对应的 goroutine 会放回到本地运行队列，而之前的线程会保存好，以便之后可以继续使用。

如果一个 goroutine 需要做一个网络 I/O 调用，流程上会有些不一样。在这种情况下，goroutine 会和逻辑处理器分离，并移到集成了网络轮询器的运行时。一旦该轮询器指示某个网络读或者写操作已经就绪，对应的goroutine 就会重新分配到逻辑处理器上来完成操作。

注意：Golang 运行时默认限制每个程序最多创建 10000 个线程。这个限制值可以通过调用 runtime/debug 包的 SetMaxThreads 方法来更改。如果程序试图使用更多的线程，就会崩溃。


通道（channel）
通道（channel）是用来传递数据的一个数据结构。
通道可用于两个 goroutine 之间通过传递一个指定类型的值来同步运行和通讯。操作符 <- 用于指定通道的方向，发送或接收。如果未指定方向，则为双向通道。

```go
// 声明一个通道
ch := make(chan int)
ch <- sum // 把 sum 发送到通道 ch
v := <-ch  // 从 ch 接收数据，并把值赋给 v

// 通道可以设置缓冲区，通过 make 的第二个参数指定缓冲区大小：
ch := make(chan int, 100)
```

注意：如果通道不带缓冲，发送方会阻塞直到接收方从通道中接收了值。如果通道带缓冲，发送方则会阻塞直到发送的值被拷贝到缓冲区内；如果缓冲区已满，则意味着需要等待直到某个接收方获取到一个值。接收方在有值可以接收之前会一直阻塞。

Go 遍历通道与关闭通道
```go
// range 函数遍历每个从通道接收到的数据，因为 c 在发送完 10 个
// 数据之后就关闭了通道，所以这里我们 range 函数在接收到 10 个数据
// 之后就结束了。如果上面的 c 通道不关闭，那么 range 函数就不
// 会结束，从而在接收第 11 个数据的时候就阻塞了。
for i := range c {
     fmt.Println(i)
}
```

Go 语言的基础结构

包声明
引入包
函数
变量
语句 & 表达式
注释


当标识符（包括常量、变量、类型、函数名、结构字段等等）以一个大写字母开头，如：Group1，那么使用这种形式的标识符的对象就可以被外部包的代码所使用（客户端程序需要先导入这个包），这被称为导出（像面向对象语言中的 public）；
标识符如果以小写字母开头，则对包外是不可见的，但是他们在整个包的内部是可见并且可用的（像面向对象语言中的 protected ）。


注意 { 不能单独放在一行，否则代码在运行时会产生错误



### 环境安装

https://golang.org/dl/ 下载安装包
mac 安装路径默认是/usr/local/go/ 卸载是直接删除此目录 + sudo rm /etc/paths.d/go

brew install go

GOROOT是GO的安装路径

将 ${GOROOT}/bin 目录添加至PATH环境变量


go run hello.go
go build hello.go




