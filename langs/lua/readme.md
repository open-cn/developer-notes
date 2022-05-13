## lua

### 概述
Lua 是一种轻量小巧的脚本语言，用标准C语言编写并以源代码形式开放，其设计目的是为了嵌入应用程序中，从而为应用程序提供灵活的扩展和定制功能。

Lua 是巴西里约热内卢天主教大学（Pontifical Catholic University of Rio de Janeiro）里的一个研究小组于 1993 年开发的，该小组成员有：Roberto Ierusalimschy、Waldemar Celes 和 Luiz Henrique de Figueiredo。

#### 设计目的

其设计目的是为了嵌入应用程序中，从而为应用程序提供灵活的扩展和定制功能。

#### Lua 特性

- 轻量级: 它用标准C语言编写并以源代码形式开放，编译后仅仅一百余K，可以很方便的嵌入别的程序里。
- 可扩展: Lua提供了非常易于使用的扩展接口和机制：由宿主语言(通常是C或C++)提供这些功能，Lua可以使用它们，就像是本来就内置的功能一样。

其它特性:

- 支持面向过程(procedure-oriented)编程和函数式编程(functional programming)；
- 自动内存管理；只提供了一种通用类型的表（table），用它可以实现数组，哈希表，集合，对象；
- 语言内置模式匹配；闭包(closure)；函数也可以看做一个值；提供多线程（协同进程，并非操作系统所支持的线程）支持；
- 通过闭包和table可以很方便地支持面向对象编程所需要的一些关键机制，比如数据抽象，虚函数，继承和重载等。

#### Lua 应用场景

- 游戏开发
- 独立应用脚本
- Web 应用脚本
- 扩展和数据库插件如：MySQL Proxy 和 MySQL WorkBench
- 安全系统，如入侵检测系统

### 基础使用

#### Lua 环境安装

##### Linux 系统上安装
Linux & Mac上安装 Lua 安装非常简单，只需要下载源码包并在终端解压编译即可。
```shell
curl -R -O http://www.lua.org/ftp/lua-5.3.0.tar.gz
tar zxf lua-5.3.0.tar.gz
cd lua-5.3.0
make linux test
make install
```

##### Mac OS X 系统上安装
```shell
curl -R -O http://www.lua.org/ftp/lua-5.3.0.tar.gz
tar zxf lua-5.3.0.tar.gz
cd lua-5.3.0
make macosx test
make install
```

##### Window 系统上安装 Lua

window下你可以使用一个叫"SciTE"的IDE环境来执行lua程序，下载地址为：

Github 下载地址：https://github.com/rjpcomputing/luaforwindows/releases

#### 运行

```shell
lua -i # 进入交互模式
lua hello.lua # 运行脚本
```

#### 语法

Lua 标示符用于定义一个变量，函数或者其他用户定义的项。标示符以一个字母 A 到 Z 或 a 到 z 或下划线 _ 开头后加上零个或多个字母，下划线，数字（0 到 9）。最好不要使用下划线加大写字母的标示符，因为Lua的保留字也是这样的。Lua 不允许使用特殊字符如 @, $, 和 % 来定义标示符。 Lua 是一个区分大小写的编程语言。

Lua 是动态类型语言，变量不要类型定义，只需要为变量赋值。 值可以存储在变量中，作为参数传递或结果返回。

Lua 中有 8 个基本类型分别为：nil、boolean、number、string、userdata、function、thread 和 table。

在 Lua 中，函数是被看作是"第一类值（First-Class Value）"，函数可以存在变量里。

在 Lua 里，最主要的线程是协同程序（coroutine）。它跟线程（thread）差不多，拥有自己独立的栈、局部变量和指令指针，可以跟其他协同程序共享全局变量和其他大部分东西。

线程跟协程的区别：线程可以同时多个运行，而协程任意时刻只能运行一个，并且处于运行状态的协程只有被挂起（suspend）时才会暂停。

userdata 是一种用户自定义数据，用于表示一种由应用程序或 C/C++ 语言库所创建的类型，可以将任意 C/C++ 的任意数据类型的数据（通常是 struct 和 指针）存储到 Lua 变量中调用。

Lua 中的表（table）其实是一个"关联数组"（associative arrays），数组的索引可以是数字或者是字符串。

Lua 中的变量全是全局变量，无论语句块或是函数里，除非用 local 显式声明为局部变量，变量默认值均为nil。

```lua
--单行注释
--[[
多行注释1
多行注释2
...
--]]

print(type("Hello world"))      --> string
print(type(10.4*3))             --> number
print(type(print))              --> function
print(type(type))               --> function
print(type(true))               --> boolean
print(type(nil))                --> nil
print(type(type(X)))            --> string

print(type({}))                --> table

tbl = {"apple", "pear", "orange", "grape"}
for k, v in pairs(tbl) do
    print(k .. " : " .. v)      --> 字符串连接用..
end
--不同于其他语言的数组把 0 作为数组的初始索引，在 Lua 里表的默认初始索引一般以 1 开始。

tbl["key"]="value"
tbl[2]=2
tbl["3"]="3"
for k, v in pairs(tbl) do
    print(k .. " : " .. v)
end

x, y = y, x                     -- swap 'x' for 'y'
a[i], a[j] = a[j], a[i]         -- swap 'a[i]' for 'a[j]'
--当变量个数和值的个数不一致时，Lua会一直以变量个数为基础采取以下策略：
--
--a. 变量个数 > 值的个数             按变量个数补足nil
--b. 变量个数 < 值的个数             多余的值会被忽略

a, b = f()

t[i]
t.i                 -- 当索引为字符串类型时的一种简化写法
gettable_event(t,i) -- 采用索引访问本质上是一个类似这样的函数调用

for var= exp1,exp2,exp3 do --var从exp1变化到exp2，step为exp3递增。不指定exp3默认为1。
	...
end

repeat:
 line = io.read()
until line~=""
print(line)

while( true )
do
   print("循环将永远执行下去")
end

-- 控制结构的条件表达式结果可以是任何值，Lua认为false和nil为假，true和非nil为真。
if(0)
then
    print("0 为 true")
end

-- 支持break，但不支持continue。支持goto。

-- 函数定义
optional_function_scope function function_name( argument1, argument2, argument3..., argumentn)
    function_body
    return result_params_comma_separated
end
--[[
optional_function_scope: 该参数是可选的制定函数是全局函数还是局部函数，未设置该参数默认为全局函数，如果你需要设置函数为局部函数需要使用关键字 local。
function_name: 指定函数名称。
argument1, argument2, argument3..., argumentn: 函数参数，多个参数以逗号隔开，函数也可以不带参数。
function_body: 函数体，函数中需要执行的代码语句块。
result_params_comma_separated: 函数返回值，Lua语言函数可以返回多个值，每个值以逗号隔开。
--]]

-- Lua 函数可以接受可变数目的参数，和 C 语言类似，在函数参数列表中使用三点 ... 表示函数有可变的参数。
function add(...)  
local s = 0  
	for i, v in ipairs{...} do   --> {...} 表示一个由所有变长参数构成的数组  
    	s = s + v  
	end  
	return s  
end
print(add(3,4,5,6,7))  --->25

function f(...)
    a = select(3,...)  -->从第三个位置开始，变量 a 对应右边变量列表的第一个参数
    print (a)
    print (select(3,...)) -->打印所有列表参数
end
f(0,1,2,3,4,5)

do  
    function foo(...)  
        for i = 1, select('#', ...) do  -->select('#', ...)获取参数总数
            local arg = select(i, ...); -->读取参数，arg 对应的是右边变量列表的第一个参数
            print("arg", arg);  
        end  
    end  
 
    foo(1, 2, 3, 4);  
end

#'123' -- #一元运算符，返回字符串或表的长度

string1 = "Lua"
print("\"字符串 1 是\"",string1)
string2 = 'runoob.com'
print("字符串 2 是",string2)
string3 = [["Lua 教程"]]
print("字符串 3 是",string3)
-->"字符串 1 是"    Lua
-->字符串 2 是    runoob.com
-->字符串 3 是    "Lua 教程"

```

模块类似于一个封装库，从 Lua 5.1 开始，Lua 加入了标准的模块管理机制，可以把一些公用的代码放在一个文件里，以 API 接口的形式在其他地方调用，有利于代码的重用和降低代码耦合度。

```lua module.lua
-- 定义一个名为 module 的模块
module = {}
 
-- 定义一个常量
module.constant = "这是一个常量"
 
-- 定义一个函数
function module.func1()
    io.write("这是一个公有函数！\n")
end
 
local function func2()
    print("这是一个私有函数！")
end
 
function module.func3()
    func2()
end
 
return module
```

Lua提供了一个名为require的函数用来加载模块。

```lua
require("<模块名>")
require "<模块名>"
```

Lua和C是很容易结合的，使用 C 为 Lua 写包。

与Lua中写包不同，C包在使用以前必须首先加载并连接，在大多数系统中最容易的实现方式是通过动态连接库机制。

Lua在一个叫loadlib的函数内提供了所有的动态连接的功能。这个函数有两个参数:库的绝对路径和初始化函数。
```lua
local path = "/usr/local/lua/lib/libluasocket.so"
-- 或者 path = "C:\\windows\\luasocket.dll"，这是 Window 平台下
local f = loadlib(path, "luaopen_socket")

local f = assert(loadlib(path, "luaopen_socket"))
f()  -- 真正打开库
```
loadlib 函数加载指定的库并且连接到 Lua，然而它并不打开库（也就是说没有调用初始化函数），反之他返回初始化函数作为 Lua 的一个函数，这样就可以直接在Lua中调用他。

如果加载动态库或者查找初始化函数时出错，loadlib 将返回 nil 和错误信息。

一般情况下我们期望二进制的发布库包含一个与前面代码段相似的 stub 文件，安装二进制库的时候可以随便放在某个目录，只需要修改 stub 文件对应二进制库的实际路径即可。

将 stub 文件所在的目录加入到 LUA_PATH，这样设定后就可以使用 require 函数加载 C 库了。



