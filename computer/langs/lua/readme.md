## lua

### 概述

Lua 是一门强大、快速、轻量的嵌入式脚本语言，用标准C语言编写并以源代码形式开放，MIT 证书。

Lua 是巴西里约热内卢天主教大学（Pontifical Catholic University of Rio de Janeiro）里的一个研究小组于 1993 年开发的，该小组成员有：Roberto Ierusalimschy、Waldemar Celes 和 Luiz Henrique de Figueiredo。

#### 设计目的

其设计目的是为了嵌入应用程序中，从而为应用程序提供灵活的扩展和定制功能。

#### Lua 特性

- 轻量级：它用标准C语言编写并以源代码形式开放，编译后仅仅一百余K，可以很方便的嵌入别的程序里。
- 可扩展：Lua提供了非常易于使用的扩展接口和机制：由宿主语言(通常是C或C++)提供这些功能，Lua可以使用它们，就像是本来就内置的功能一样。

其它特性：

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

#### 基础语法

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
optional_function_scope：该参数是可选的制定函数是全局函数还是局部函数，未设置该参数默认为全局函数，如果你需要设置函数为局部函数需要使用关键字 local。
function_name：指定函数名称。
argument1, argument2, argument3..., argumentn：函数参数，多个参数以逗号隔开，函数也可以不带参数。
function_body：函数体，函数中需要执行的代码语句块。
result_params_comma_separated：函数返回值，Lua语言函数可以返回多个值，每个值以逗号隔开。
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

Lua在一个叫loadlib的函数内提供了所有的动态连接的功能。这个函数有两个参数库的绝对路径和初始化函数。
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

#### 元表

在 Lua table 中我们可以访问对应的 key 来得到 value 值，但是却无法对两个 table 进行操作(比如相加)。因此 Lua 提供了元表(Metatable)，允许我们改变 table 的行为，每个行为关联了对应的元方法。
```lua
setmetatable(table, metatable) -- 对指定 table 设置元表(metatable)，如果元表(metatable)中存在 __metatable 键值，setmetatable 会失败。
getmetatable(table) -- 返回对象的元表(metatable)。

setmetatable({}, {
  __index = function(mytable, key)
    if key == "key2" then
      return "metatablevalue"
    else
      return nil
    end
  end
, __newindex =  function(mytable, key, value)
    rawset(mytable, key, "\""..value.."\"")
  end
, __add = function(mytable, newtable)
    for i = 1, table_maxn(newtable) do
      table.insert(mytable, table_maxn(mytable)+1,newtable[i])
    end
    return mytable
  end
, __call = function(mytable, newtable)
    sum = 0
    for i = 1, table_maxn(mytable) do
        sum = sum + mytable[i]
    end
    for i = 1, table_maxn(newtable) do
        sum = sum + newtable[i]
    end
    return sum
  end
, __tostring = function(mytable)
    sum = 0
    for k, v in pairs(mytable) do
        sum = sum + v
    end
    return "表所有元素的和为 " .. sum
  end
})

--[[
__add   对应的运算符 '+'.
__sub   对应的运算符 '-'.
__mul   对应的运算符 '*'.
__div   对应的运算符 '/'.
__mod   对应的运算符 '%'.
__unm   对应的运算符 '-'.
__concat    对应的运算符 '..'.
__eq    对应的运算符 '=='.
__lt    对应的运算符 '<'.
__le    对应的运算符 '<='.
--]]
```

#### 协同程序

Lua 协同程序(coroutine)与线程比较类似：拥有独立的堆栈，独立的局部变量，独立的指令指针，同时又与其它协同程序共享全局变量和其它大部分东西。

线程与协同程序的主要区别在于，一个具有多个线程的程序可以同时运行几个线程，而协同程序却需要彼此协作的运行。在任一指定时刻只有一个协同程序在运行，并且这个正在运行的协同程序只有在明确的被要求挂起的时候才会被挂起。协同程序有点类似同步的多线程，在等待同一个线程锁的几个线程有点类似协同。

coroutine在底层实现就是一个线程。

```lua
co = coroutine.create(
    function(i)
        print(i);
    end
)
 
coroutine.resume(co, 1)   -- 1
print(coroutine.status(co))  -- dead
 
print("----------")
 
co = coroutine.wrap(
    function(i)
        print(i);
    end
)
 
co(1)
 
print("----------")
 
co2 = coroutine.create(
    function()
        for i=1,10 do
            print(i)
            if i == 3 then
                print(coroutine.status(co2))  --running
                print(coroutine.running()) --thread:XXXXXX
            end
            coroutine.yield()
        end
    end
)
 
coroutine.resume(co2) --1
coroutine.resume(co2) --2
coroutine.resume(co2) --3
 
print(coroutine.status(co2))   -- suspended
print(coroutine.running())
 
print("----------")

function foo (a)
    print("foo 函数输出", a)
    return coroutine.yield(2 * a) -- 返回  2*a 的值
end
 
co = coroutine.create(function (a , b)
    print("第一次协同程序执行输出", a, b) -- co-body 1 10
    local r = foo(a + 1)
     
    print("第二次协同程序执行输出", r)
    local r, s = coroutine.yield(a + b, a - b)  -- a，b的值为第一次调用协同程序时传入
     
    print("第三次协同程序执行输出", r, s)
    return b, "结束协同程序"                   -- b的值为第二次调用协同程序时传入
end)
       
print("main", coroutine.resume(co, 1, 10)) -- true, 4
print("--分割线----")
print("main", coroutine.resume(co, "r")) -- true 11 -9
print("---分割线---")
print("main", coroutine.resume(co, "x", "y")) -- true 10 end
print("---分割线---")
print("main", coroutine.resume(co, "x", "y")) -- cannot resume dead coroutine
print("---分割线---")
```

#### 文件IO

Lua I/O 库用于读取和处理文件。分为简单模式（和C一样）、完全模式。

- 简单模式（simple model）拥有一个当前输入文件和一个当前输出文件，并且提供针对这些文件相关的操作。
- 完全模式（complete model） 使用外部的文件句柄来实现。它以一种面对对象的形式，将所有的文件操作定义为文件句柄的方法。

简单模式在做一些简单的文件操作时较为合适。但是在进行一些高级的文件操作的时候，简单模式就显得力不从心。例如同时读取多个文件这样的操作，使用完全模式则较为合适。

打开文件操作语句如下：
```lua
file = io.open (filename [, mode])

mode 的值有：

r   以只读方式打开文件，该文件必须存在。
w   打开只写文件，若文件存在则文件长度清为0，即该文件内容会消失。若文件不存在则建立该文件。
a   以附加的方式打开只写文件。若文件不存在，则会建立该文件，如果文件存在，写入的数据会被加到文件尾，即文件原先的内容会被保留。（EOF符保留）
r+  以可读写方式打开文件，该文件必须存在。
w+  打开可读写文件，若文件存在则文件长度清为零，即该文件内容会消失。若文件不存在则建立该文件。
a+  与a类似，但此文件可读可写
b   二进制模式，如果文件是二进制文件，可以加上b
+   表示对文件既可以读也可以写
```

```lua
-- 以只读方式打开文件
file = io.open("test.lua", "r")

-- 设置默认输入文件为 test.lua
io.input(file)

-- 输出文件第一行
print(io.read())

-- 关闭打开的文件
io.close(file)

-- 以附加的方式打开只写文件
file = io.open("test.lua", "a")

-- 设置默认输出文件为 test.lua
io.output(file)

-- 在文件最后一行添加 Lua 注释
io.write("--  test.lua 文件末尾注释")

-- 关闭打开的文件
io.close(file)
```

- io.read()：
    + "*n"    读取一个数字并返回它。例：file.read("*n")
    + "*a"    从当前位置读取整个文件。例：file.read("*a")
    + "*l"（默认）    读取下一行，在文件尾 (EOF) 处返回 nil。例：file.read("*l")
    + number  返回一个指定字符个数的字符串，或在 EOF 时返回 nil。例：file.read(5)
- io.tmpfile()：返回一个临时文件句柄，该文件以更新模式打开，程序结束时自动删除。
- io.type(file)：检测obj是否一个可用的文件句柄。
- io.flush()：向文件写入缓冲中的所有数据。
- io.lines(optional file name)：返回一个迭代函数，每次调用将获得文件中的一行内容，当到文件尾时，将返回nil，但不关闭文件。

```lua
-- 以只读方式打开文件
file = io.open("test.lua", "r")

-- 输出文件第一行
print(file:read())

file:seek("end",-25)
print(file:read("*a"))

-- 关闭打开的文件
file:close()

-- 以附加的方式打开只写文件
file = io.open("test.lua", "a")

-- 在文件最后一行添加 Lua 注释
file:write("--test")

-- 关闭打开的文件
file:close()
```

- file:read 同 io.read
- file:seek(optional whence, optional offset)：设置和获取当前文件位置，成功则返回最终的文件位置(按字节)，失败则返回nil加错误信息。不带参数file:seek()则返回当前位置，file:seek("set")则定位到文件头，file:seek("end")则定位到文件尾并返回文件大小。offset默认为0。参数 whence 值可以是：
    + "set": 从文件头开始
    + "cur": 从当前位置开始[默认]
    + "end": 从文件尾开始
- file:flush()：向文件写入缓冲中的所有数据
- io.lines(optional file name)：打开指定的文件filename为读模式并返回一个迭代函数，每次调用将获得文件中的一行内容，当到文件尾时，将返回nil，并自动关闭文件。若不带参数时io.lines() <=> io.input():lines(); 读取默认输入设备的内容，但结束时不关闭文件。

#### 错误处理

可以使用两个函数：assert 和 error 来处理错误。

Lua中处理错误，可以使用函数pcall（protected call）来包装需要执行的代码。pcall以一种"保护模式"来调用第一个参数，因此pcall可以捕获函数执行中的任何错误。

通常在错误发生时，希望落得更多的调试信息，而不只是发生错误的位置。但pcall返回时，它已经销毁了调用桟的部分内容。Lua提供了xpcall函数，xpcall接收第二个参数——一个错误处理函数，当错误发生时，Lua会在调用桟展开（unwind）前调用错误处理函数，于是就可以在这个函数中使用debug库来获取关于错误的额外信息了。debug库提供了两个通用的错误处理函数：debug.debug提供一个Lua提示符，让用户来检查错误的原因；debug.traceback根据调用桟来构建一个扩展的错误消息。

```lua
assert(type(a) == "number", "a 不是一个数字")
-- assert首先检查第一个参数，若没问题，assert不做任何事情；否则，assert以第二个参数作为错误信息抛出。

error (message [, level])
-- Level=1[默认]：为调用error位置(文件+行号)
-- Level=2：指出哪个调用error的函数的函数
-- Level=0：不添加错误位置信息

-- pcall接收一个函数和要传递给后者的参数，并执行，执行结果：有错误、无错误；返回值true或false和errorinfo。
if pcall(function_name, ….) then
    -- 没有错误
else
    -- 一些错误
end

pcall(function(i) print(i) error('error..') end, 33)

xpcall(function(i) print(i) error('error..') end, function() print(debug.debug()) end, 33)
xpcall(function(i) print(i) error('error..') end, function() print(debug.traceback()) end, 33)

function myfunction ()
   n = n/nil
end

function myerrorhandler( err )
   print( "ERROR:", err )
end

status = xpcall( myfunction, myerrorhandler )
print( status)
```

#### 调式

Lua 提供了 debug 库用于提供创建我们自定义调试器的功能。Lua 本身并未有内置的调试器，但很多开发者共享了他们的 Lua 调试器代码。

Lua 中 debug 库包含以下函数：

1. debug()：进入一个用户交互模式，运行用户输入的每个字符串。 使用简单的命令以及其它调试设置，用户可以检阅全局变量和局部变量， 改变变量的值，计算一些表达式，等等。输入一行仅包含 cont 的字符串将结束这个函数， 这样调用者就可以继续向下运行。
2.  getfenv(object)：返回对象的环境变量。
3.  gethook(optional thread)：返回三个表示线程钩子设置的值： 当前钩子函数，当前钩子掩码，当前钩子计数
4.  getinfo ([thread,] f [, what])：返回关于一个函数信息的表。 你可以直接提供该函数， 也可以用一个数字 f 表示该函数。 数字 f 表示运行在指定线程的调用栈对应层次上的函数： 0 层表示当前函数（getinfo 自身）； 1 层表示调用 getinfo 的函数 （除非是尾调用，这种情况不计入栈）；等等。 如果 f 是一个比活动函数数量还大的数字， getinfo 返回 nil。
5.  debug.getlocal ([thread,] f, local)：此函数返回在栈的 f 层处函数的索引为 local 的局部变量 的名字和值。 这个函数不仅用于访问显式定义的局部变量，也包括形参、临时变量等。
6.  getmetatable(value)：把给定索引指向的值的元表压入堆栈。如果索引无效，或是这个值没有元表，函数将返回 0 并且不会向栈上压任何东西。
7.  getregistry()：返回注册表表，这是一个预定义出来的表， 可以用来保存任何 C 代码想保存的 Lua 值。
8.  getupvalue (f, up)：此函数返回函数 f 的第 up 个上值的名字和值。 如果该函数没有那个上值，返回 nil 。以 '(' （开括号）打头的变量名表示没有名字的变量 （去除了调试信息的代码块）。
10. sethook ([thread,] hook, mask [, count])：将一个函数作为钩子函数设入。 字符串 mask 以及数字 count 决定了钩子将在何时调用。 掩码是由下列字符组合成的字符串，每个字符有其含义：
    + 'c'：每当 Lua 调用一个函数时，调用钩子；
    + 'r'：每当 Lua 从一个函数内返回时，调用钩子；
    + 'l'：每当 Lua 进入新的一行时，调用钩子。
11. setlocal ([thread,] level, local, value)：这个函数将 value 赋给 栈上第 level 层函数的第 local 个局部变量。 如果没有那个变量，函数返回 nil 。 如果 level 越界，抛出一个错误。
12. setmetatable (value, table)：将 value 的元表设为 table （可以是 nil）。 返回 value。
13. setupvalue (f, up, value)：这个函数将 value 设为函数 f 的第 up 个上值。 如果函数没有那个上值，返回 nil 否则，返回该上值的名字。
14. traceback ([thread,] [message [, level]])：如果 message 有，且不是字符串或 nil， 函数不做任何处理直接返回 message。 否则，它返回调用栈的栈回溯信息。 字符串可选项 message 被添加在栈回溯信息的开头。 数字可选项 level 指明从栈的哪一层开始回溯 （默认为 1 ，即调用 traceback 的那里）。

#### 垃圾回收

Lua 采用了自动内存管理。这意味着你不用操心新创建的对象需要的内存如何分配出来，也不用考虑在对象不再被使用后怎样释放它们所占用的内存。

Lua 运行了一个垃圾收集器来收集所有死对象（即在 Lua 中不可能再访问到的对象）来完成自动内存管理的工作。 Lua 中所有用到的内存，如：字符串、表、用户数据、函数、线程、 内部结构等，都服从自动管理。

Lua 实现了一个增量标记-扫描收集器。它使用这两个数字来控制垃圾收集循环：垃圾收集器间歇率和垃圾收集器步进倍率。这两个数字都使用百分数为单位（例如：值 100 在内部表示 1 ）。

垃圾收集器间歇率控制着收集器需要在开启新的循环前要等待多久。增大这个值会减少收集器的积极性。当这个值比 100 小的时候，收集器在开启新的循环前不会有等待。设置这个值为 200 就会让收集器等到总内存使用量达到之前的两倍时才开始新的循环。

垃圾收集器步进倍率控制着收集器运作速度相对于内存分配速度的倍率。增大这个值不仅会让收集器更加积极，还会增加每个增量步骤的长度。不要把这个值设得小于 100，那样的话收集器就工作的太慢了以至于永远都干不完一个循环。 默认值是 200，这表示收集器以内存分配的"两倍"速工作。

如果你把步进倍率设为一个非常大的数字（比你的程序可能用到的字节数还大 10%），收集器的行为就像一个 stop-the-world 收集器。 接着你若把间歇率设为 200，收集器的行为就和过去的 Lua 版本一样了：每次 Lua 使用的内存翻倍时，就做一次完整的收集。

Lua 提供了以下函数collectgarbage ([opt [, arg]])用来控制自动内存管理：

- collectgarbage("collect")：做一次完整的垃圾收集循环。通过参数 opt 它提供了一组不同的功能：
- collectgarbage("count")：以 K 字节数为单位返回 Lua 使用的总内存数。 这个值有小数部分，所以只需要乘上 1024 就能得到 Lua 使用的准确字节数（除非溢出）。
- collectgarbage("restart")：重启垃圾收集器的自动运行。
- collectgarbage("setpause")：将 arg 设为收集器的间歇率。 返回间歇率的前一个值。
- collectgarbage("setstepmul")：返回步进倍率的前一个值。
- collectgarbage("step")：单步运行垃圾收集器。 步长"大小"由 arg 控制。 传入 0 时，收集器步进（不可分割的）一步。 传入非 0 值， 收集器收集相当于 Lua 分配这些多（K 字节）内存的工作。 如果收集器结束一个循环将返回 true 。
- collectgarbage("stop")：停止垃圾收集器的运行。在调用重启前，收集器只会因显式的调用运行。

#### 面向对象

面向对象编程（Object Oriented Programming，OOP）是一种非常流行的计算机编程架构。

对象由属性和方法组成。LUA中最基本的结构是table，所以需要用table来描述对象的属性。lua 中的 function 可以用来表示方法。那么LUA中的类可以通过 table + function 模拟出来。至于继承，可以通过 metetable 模拟出来（不推荐用，只模拟最基本的对象大部分实现够用了）。

Lua 中的表不仅在某种意义上是一种对象。像对象一样，表也有状态（成员变量）；也有与对象的值独立的本性，特别是拥有两个不同值的对象（table）代表两个不同的对象；一个对象在不同的时候也可以有不同的值，但他始终是一个对象；与对象类似，表的生命周期与其由什么创建、在哪创建没有关系。对象有他们的成员函数，表也有。

```lua
-- Meta class
Shape = {area = 0}
-- 基础类方法 new
function Shape:new (o,side)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  side = side or 0
  self.area = side*side;
  return o
end
-- 基础类方法 printArea
function Shape:printArea ()
  print("面积为 ",self.area)
end

-- 创建对象
myshape = Shape:new(nil,10)
myshape:printArea()

Square = Shape:new()

-- 派生类方法 new
function Square:new (o,side)
  o = o or Shape:new(o,side)
  setmetatable(o, self)
  self.__index = self
  return o
end

-- 派生类方法 printArea
function Square:printArea ()
  print("正方形面积为 ",self.area)
end

-- 创建对象
mysquare = Square:new(nil,10)
mysquare:printArea()

Rectangle = Shape:new()
-- 派生类方法 new
function Rectangle:new (o,length,breadth)
  o = o or Shape:new(o)
  setmetatable(o, self)
  self.__index = self
  self.area = length * breadth
  return o
end

-- 派生类方法 printArea
function Rectangle:printArea ()
  print("矩形面积为 ",self.area)
end

-- 创建对象
myrectangle = Rectangle:new(nil,10,20)
myrectangle:printArea()
```

#### 数据库访问

Lua 数据库的操作库：LuaSQL。它是开源的，支持的数据库有：ODBC, ADO, Oracle, MySQL, SQLite 和 PostgreSQL。

LuaSQL 可以使用 LuaRocks 来安装可以根据需要安装你需要的数据库驱动。

```shell
wget http://luarocks.org/releases/luarocks-2.2.1.tar.gz
tar zxpf luarocks-2.2.1.tar.gz
cd luarocks-2.2.1
./configure; sudo make bootstrap
sudo luarocks install luasocket

-- Window 下安装 LuaRocks：https://github.com/keplerproject/luarocks/wiki/Installation-instructions-for-Windows
-- 源码安装方式，Lua Github 源码地址：https://github.com/keplerproject/luasql

-- 安装不同数据库驱动：
luarocks install luasql-sqlite3
luarocks install luasql-postgres
luarocks install luasql-mysql
luarocks install luasql-sqlite
luarocks install luasql-odbc
```

```lua
require "luasql.mysql"

--创建环境对象
env = luasql.mysql()

--连接数据库
conn = env:connect("数据库名","用户名","密码","IP地址",端口)

--设置数据库的编码格式
conn:execute"SET NAMES UTF8"

--执行数据库操作
cur = conn:execute("select * from role")

row = cur:fetch({},"a")

--文件对象的创建
file = io.open("role.txt","w+");

while row do
    var = string.format("%d %s\n", row.id, row.name)

    print(var)

    file:write(var)

    row = cur:fetch(row,"a")
end

file:close()  --关闭文件对象
conn:close()  --关闭数据库连接
env:close()   --关闭数据库环境
```

### 最佳实践

```lua
-- 5.2 版本之后，require 不再定义全局变量，需要保存其返回值。
-- require "luasql.mysql"
luasql = require "luasql.mysql"
```