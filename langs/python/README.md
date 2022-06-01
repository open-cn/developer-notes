## python

Python有两个版本，一个是2.x版，一个是3.x版，这两个版本是不兼容的，因为现在Python正在朝着3.x版本进化，在进化过程中，大量的针对2.x版本的代码要修改后才能运行，所以，目前有许多第三方库还暂时无法在3.x上使用。

Python解释器有CPython、IPython、PyPy、Jython和IronPython等。

### 概述

由于整个Python语言从规范到解释器都是开源的，所以理论上，只要水平够高，任何人都可以编写Python解释器来执行Python代码（当然难度很大）。

```
python -V
python 进入shell，exit()退出shell
>>> 100+200
300
>>> print 'hello, world'
hello, world
>>> print 'hello,','world'
hello, world
输入 raw_input('please enter your name: ')
输出 print
```

### 语法

```py
# 注释
```
大小写敏感

整数和浮点数

字符串

1. u'123' 表示Unicode字符串
2. '"均可
3. 多行内容'''...'''
4. 模板格式化：占位符 %2d 数值不足二位的话前面补空格，超出的话全部输出 %02d 数值位数不够的话前面补0
    > 'Hi, %s, you have $%d.' % ('Michael', 1000000)# "()" can be leave out when there is one param
    + %d 整数
    + %f 浮点数
    + %s 字符串
    + %x 十六进制整数

布尔值和布尔运算 and、or和not

空值None

变量

赋值语句 a=1

常量  通常用全部大写的变量名表示常量：PI = 3.14159265359

#### list 可变数组

list是一种有序的集合，可以随时添加和删除其中的元素。长度可变，元素类型无限制
```py
>>> classmates = ['Michael', 'Bob', 'Tracy']
>>> classmates[0] IndexError index<0 order desc
>>> classmates.append('Adam')
>>> classmates.insert(1,'Adam')
>>> classmates.remove('Adam')
>>> classmates.pop()
>>> classmates.pop(i)
>>> classmates[i]=2
```
len(list)函数可以获得list元素的个数

#### tuple 不可变数组

tuple是一种有序的集合。
- 长度和元素均不可变，但元素是对象的话，其属性可变。
- 小括号包围 当只有一个数时，作为小括号而不是tuple，使用(1,)明确为tuple

#### 切片

切片（Slice）操作符。因为索引从0开始，所以不包含终值。

```py
list[0:3]    # or list[:3]
list[-2:-1]  # list 的倒数第一第二
list[-10:]   # list 的倒数十个元素
list[:10:2]  # list 前10个，步长为2
list[:]      # list 全部元素
```
tuple也是一种list，区别是操作的结果仍是tuple。

字符串也可以看成是一种list，区别是操作的结果仍是字符串。

#### 条件判断

条件判断，只要判断条件x是非零数值、非空字符串、非空list等，就判断为True，否则为False。

```py
if a>0:
    print 1
elif a=0:
    print 0
else:
    print -1
```

#### 循环

```py
for name in names:# names list
    print name

while x:
    print 1
```

#### 集合 Set

set是元素不能重复的list add remove $交集 |并集

#### 字典 Dict

dict全称dictionary，在其他语言中也称为map，使用键-值（key-value）存储，具有极快的查找速度。

key必须是不可变对象。

> d = {'Michael': 95, 'Bob': 75, 'Tracy': 85}
如果key不存在，dict就会报错。可用判断'Thomas' in d 或者d.get(key,default)
> d.pop(key) # delete key and value

#### 函数

抽象

help(函数名)

函数名其实就是指向一个函数对象的引用，完全可以把函数名赋给一个变量，相当于给这个函数起了一个“别名”：所以也可以通过变量 a()调用函数。

```py
# y默认参数，如果默认值是引用对象，有坑，这个值的变化是会影响下一次调用。
# z可变参数，实质是tuple。
# kw关键字参数 函数内自动组装成一个dict。
# 注意，参数定义的顺序必须是：必选参数、默认参数、可变参数和关键字参数。
def my_abs(x, y=2, *z, **kw):
    ...        # 函数体如果为空 则用pass代替，否则报语法错误
    return a,b # 多个返回值 x,y=my_abs(1)
    # 实质上返回了一个tuple，返回一个tuple可以省略括号，而多个变量可用同时接收一个tuple再按位置赋给对应的值
```

最神奇的是通过一个tuple和dict，你也可以调用该函数：
>>> args = (1, 2, 3, 4)
>>> kw = {'x': 99}
>>> func(*args, **kw)
x = 1 y = 2 c = z args = (4,) kw = {'x': 99}
所以，对于任意函数，都可以通过类似func(*args, **kw)的形式调用它，无论它的参数是如何定义的。


#### 递归函数

函数调用是通过栈（stack）这种数据结构实现的，每当进入一个函数调用，栈就会加一层栈帧，每当函数返回，栈就会减一层栈帧。由于栈的大小不是无限的，所以，递归调用的次数过多，会导致栈溢出。

```py
def fact(n):
    if n==1:
        return 1
    return n * fact(n - 1)
```

尾递归优化 只传递递归函数本身 Python、Java等大部分语言都未实现

```py
def fact(n):
    return fact_iter(n, 1)
def fact_iter(num, product):
    if num == 1:
        return product
    return fact_iter(num - 1, num * product) # 只传递递归函数本身
```

#### 异常处理

抛异常

raise TypeError('bad operand type')


#### 迭代

for ... in

判断一个对象是可迭代对象
```py
from collections import Iterable
isinstance(a, Iterable) # 变量a是否可迭代
isinstance(a, str) # 是不是字符串

for name in names:# names list
    print name

d = {'a': 1, 'b': 2, 'c': 3}  #d dict
for key in d:
    print key
for value in d.itervalues():
    print value
for k, v in d.iteritems():
    print k,v

for ch in 'ABCD':
    print ch

for i, value in enumerate(list):     # enumerate函数可以把一个list变成索引-元素对
    print i,value

for x, y in [(1,1),(2,3),(3,4)]:
    print k,v
```


整数序列 range函数 因为索引从0开始，所以不包含终值
```py
>>> range(5)
[0,1,2,3,4]
>>> range(5,11)
[5, 6, 7, 8, 9, 10]
列表生产式
>>> [x * x for x in range(1, 11)]
[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
>>> [x * x for x in range(1, 11) if x%2==0]    # 循环后加if判断
[4, 16, 36, 64, 100]
>>> [x + y for x in 'ABC' for y in 'XYZ']      # 两层循环，生成全排列
['AX', 'AY', 'AZ', 'BX', 'BY', 'BZ', 'CX', 'CY', 'CZ']
```

#### 生成器

```py
>>> g=(x * x for x in range(1, 11))
<generator object <genexpr> at 0x1082a43c0>
>>> g.next()
for n in g:
    print n
```

如果一个函数定义中包含yield关键字，那么这个函数就不再是一个普通函数，而是一个generator。在每次调用next()的时候执行，遇到yield语句返回，再次执行时从上次返回的yield语句处继续执行。


#### 函数式编程
Python对函数式编程提供部分支持。由于Python允许使用变量，因此，Python不是纯函数式编程语言。



#### 高阶函数

就是让函数的参数能够接收别的函数。与javascript类似。

##### 返回函数

函数作为返回值，内部函数可以引用外部函数的参数和局部变量，返回内部函数时，相关参数和变量都保存在返回的函数中，这种称为“闭包（Closure）”的程序结构拥有极大的威力。
- 当我们调用外部函数时，每次调用都会返回一个新的函数，即使传入相同的参数。（因为闭包的存在？）
- 内部函数使用外部函数中局部循环等后续会变化的变量时，务必再创建一个新函数，此处同javascript

##### 匿名函数
`lambda x: x * x`关键字lambda表示匿名函数，冒号前面的x表示函数参数。

- 匿名函数有个限制，就是只能有一个表达式，不用写return，返回值就是该表达式的结果。

##### 装饰器 decorator
OOP中的装饰模式使用继承和组合，而在Python是语法层次支持decorator。

```py
import functools
def log(text):        ''' 函数Log装饰器 '''
    def decorator(func):         ''' 装饰器 '''
        @functools.wraps(func)
        def wrapper(*args, **kw):   ''' 执行装饰器参数函数 '''
            print '%s %s():' % (text, func.__name__)
            return func(*args, **kw)
        return wrapper
    return decorator
```

##### 偏函数（Partial function）

Python的functools模块提供。增加或改变原函数部分参数的默认值，以便使用。

要注意，这里的偏函数和数学意义上的偏函数不一样。

```py
int2 = functools.partial(int, base=2)
max2 = functools.partial(max, 10) 10作为默认传入的参数，位置应该是第一个
```

Python内建了map()和reduce()函数。

1. map()函数接收两个参数，一个是函数，一个是序列，map将传入的函数依次作用到序列的每个元素，并把结果作为新的list返回。
```py
>>> def f(x): return x*x
>>> map(f, [1, 2, 3, 4, 5, 6, 7, 8, 9])
[1, 4, 9, 16, 25, 36, 49, 64, 81]
>>> map(str, [1, 2, 3, 4, 5, 6, 7, 8, 9])      # 把这个list所有数字转为字符串
['1', '2', '3', '4', '5', '6', '7', '8', '9']
```
2. reduce把一个函数g作用在一个序列[x1, x2, x3...]上，这个函数g必须接收两个参数，reduce把结果继续和序列的下一个元素做累积计算.
```py
>>> def g(x,y): return x+y
>>> reduce(g, [1, 3, 5, 7, 9])
25
```

3. map与reduce整合
    1) str转换为int的函数
    ```py
    def str2int(s):
        def fn(x, y):
            return x * 10 + y
        def char2num(ch):
            return {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9}[ch]
        return reduce(fn, map(char2num, s))
    ```
    还可以用lambda函数进一步简化成：
    ```py
    def str2int(s):
        return reduce(lambda x,y: x*10+y, map(char2num, s))
    ```
    2) 首字母转大写
    ```py
    def parser(s): return s[0].upper() + s[1:].lower()
    list=input('输入一个数组：')
    map(parser,list)
    ```

4. Python内建的filter()过滤函数。和map类似，filter也接收一个函数和一个序列。和map不同的是，filter把传入的函数依次作用于每个元素，然后根据返回值是True还是False决定保留还是丢弃该元素。
    1) 用filter()删除1~100的素数。
    ```py
    def not_prime(x):
        if not isinstance(x, int):
            raise TypeError('input is not integer')
        if (x<1):
            raise TypeError('input out of range')
        if (x==1) return True;
        for i in range(1,x):
            if (x%i==0):
                return True
        return False
    filter(not_prime,range(1,101))
    ```
5. Python内建的sorted()排序函数

```py
>>> sorted([36, 5, 12, 9, 21])
>>> def f(x,y): return -x+y
>>> sorted([36, 5, 12, 9, 21],f)
```

#### 模块和包

在Python中，一个.py文件就称之为一个模块（Module）。

使用模块还可以避免函数名和变量名冲突。相同名字的函数和变量完全可以分别存在不同的模块中，为了避免模块名冲突，Python又引入了按目录来组织模块的方法，称为包（Package）。

请注意，每一个包目录下面都会有一个__init__.py的文件，这个文件是必须存在的，否则，Python就把这个目录当成普通目录，而不是一个包。__init__.py可以是空文件，也可以有Python代码，因为__init__.py本身就是一个模块，而它的模块名就是包名。

```py hello.py
#!/usr/bin/env python      #标准注释，可以让这个hello.py文件直接在Unix/Linux/Mac上运行
# -*- coding: utf-8 -*-    #标准注释，表示.py文件本身使用标准UTF-8编码

' a test module '          #表示模块的文档注释，任何模块代码的第一个字符串都被视为模块的文档注释

__author__ = 'Michael Liao'
# -------------以上是标准文件模板，当然也可以全部删掉不写-----------------------
import sys                 #导入模块

def test():
    args = sys.argv        #sys模块有一个argv变量，用list存储了命令行的所有参数。argv至少有一个元素，因为第一个参数永远是该.py文件的名称
    if len(args)==1:
        print 'Hello, world!'
    elif len(args)==2:
        print 'Hello, %s!' % args[1]
    else:
        print 'Too many arguments!'

if __name__=='__main__':
    test()
```

导入模块时，还可以使用别名 import cStringIO as StringIO

作用域
    `_、__`前缀的函数和变量 我们希望仅仅在模块内部使用
    类似`__xxx__`这样的变量是特殊变量，可以被直接引用，但是有特殊用途


安装第三方模块

默认情况下，Python解释器会搜索当前目录、所有已安装的内置模块和第三方模块，搜索路径存放在sys模块的path变量中，以及环境变量PYTHONPATH

##### anaconda
```shell

conda install -n rrrr pyqt4
PackagesNotFoundError: The following packages are not available from current channels:

conda install -n rrrr pyqt=4
```


Python提供了__future__模块，把下一个新版本的特性导入到当前版本
`from __future__ import unicode_literals`

#### 内置模块

os  和操作系统相关 os.path — Common pathname manipulations
sys 和系统相关   sys — System-specific parameters and functions
urllib，urllib2  和网络相关   urllib — Open arbitrary resources by URL 
urllib2 — extensible library for opening URLs
re  正则表达式   re — Regular expression operations
json    处理JSON字符串   json — JSON encoder and decoder

##### Datetime
Datetime类是Python内建的一个关于时间的类，包含有两种数据类型，datetime类型和timestamp类型，前者是本地时间类，与自己所在时区有关；
Datetime中包含5个类： 
1. datetime.date：表示日期的类。常用的属性有year, month, day； 
2. datetime.time：表示时间的类。常用的属性有hour, minute, second, microsecond； 
3. datetime.datetime：表示日期时间。 
4. datetime.timedelta：表示时间间隔，即两个时间点之间的长度。 
5. datetime.tzinfo：与时区有关的相关信息。


##### date
date类表示一个日期。日期由年、月、日组成（地球人都知道~~）。date类的构造函数如下： 
class datetime.date(year, month, day)：参数的意义就不多作解释了，只是有几点要注意一下： 
1. year的范围是[MINYEAR, MAXYEAR]，即[1, 9999]； 
2. month的范围是[1, 12]。（月份是从1开始的，不是从0开始的）； 
3. day的最大值根据给定的year, month参数来决定。例如闰年2月份有29天；

date类定义了一些常用的类方法与类属性，方便我们操作： 
1. date.max、date.min：date对象所能表示的最大、最小日期； 
2. date.resolution：date对象表示日期的最小单位。这里是天。 
3. date.today()：返回一个表示当前本地日期的date对象； 
4. date.fromtimestamp(timestamp)：根据给定的时间戮，返回一个date对象； 
5. datetime.fromordinal(ordinal)：将Gregorian日历时间转换为date对象；（Gregorian Calendar ：一种日历表示方法，类似于我国的农历，西方国家使用比较多。）

Date中的其他属性和方法：
1. date.year、date.month、date.day：年、月、日；
2. date.replace(year, month, day)：生成一个新的日期对象，用参数指定的年，月，日代替原有对象中的属性。（原有对象仍保持不变）
3. date.timetuple()：返回日期对应的time.struct_time对象；
4. date.toordinal()：返回日期对应的Gregorian Calendar日期；
5. date.weekday()：返回weekday，如果是星期一，返回0；如果是星期2，返回1，以此类推；
6. data.isoweekday()：返回weekday，如果是星期一，返回1；如果是星期2，返回2，以此类推；
7. date.isocalendar()：返回格式如(year，month，day)的元组；
8. date.isoformat()：返回格式如’YYYY-MM-DD’的字符串；
9. date.strftime(fmt)：自定义格式化字符串。


#### Time
time类表示时间，由时、分、秒以及微秒组成。time类的构造函数如下： 
class datetime.time(hour[ , minute[ , second[ , microsecond[ , tzinfo] ] ] ] )
留意一下参数tzinfo，它表示时区信息。注意一下各参数的取值范围：hour的范围为[0, 24)，minute的范围为[0, 60)，second的范围为[0, 60)，microsecond的范围为[0, 1000000)。 
time类定义的类属性： 
1. time.min、time.max：time类所能表示的最小、最大时间。其中，time.min = time(0, 0, 0, 0)， time.max = time(23, 59, 59, 999999)； 
2. time.resolution：时间的最小单位，这里是1微秒；

time类提供的实例方法和属性： 
1. time.hour、time.minute、time.second、time.microsecond：时、分、秒、微秒； 
2. time.tzinfo：时区信息； 
3. time.replace([ hour[ , minute[ , second[ , microsecond[ , tzinfo] ] ] ] ] )：创建一个新的时间对象，用参数指定的时、分、秒、微秒代替原有对象中的属性（原有对象仍保持不变）； 
4. time.isoformat()：返回型如”HH:MM:SS”格式的字符串表示； 
5. time.strftime(fmt)：返回自定义格式化字符串。


datetime类
datetime是date与time的结合体，包括date与time的所有信息。
它的构造函数如下：datetime.datetime (year, month, day[ , hour[ , minute[ , second[ , microsecond[ , tzinfo] ] ] ] ] )，
各参数的含义与date、time的构造函数中的一样，要注意参数值的范围。 
datetime类定义的类属性与方法： 
1. datetime.min、datetime.max：datetime所能表示的最小值与最大值； 
2. datetime.resolution：datetime最小单位； 
3. datetime.today()：返回一个表示当前本地时间的datetime对象； 
4. datetime.now([tz])：返回一个表示当前本地时间的datetime对象，如果提供了参数tz，则获取tz参数所指时区的本地时间； 
5. datetime.utcnow()：返回一个当前utc时间的datetime对象； 
6. datetime.fromtimestamp(timestamp[, tz])：根据时间戮创建一个datetime对象，参数tz指定时区信息； 
7. datetime.utcfromtimestamp(timestamp)：根据时间戮创建一个datetime对象； 
8. datetime.combine(date, time)：根据date和time，创建一个datetime对象； 
9. datetime.strptime(date_string, format)：将格式字符串转换为datetime对象；


#### 面向对象OOP
封装 继承 多态
```py
class Student(object):                            #() 表示继承

    def __init__(self, name, score):              #第一个参数永远是self，表示创建的实例本身 实例化时不需要传
        self.name = name
        self.score = score

    def print_score(self):                        #第一个参数永远是self，调用时不需要传
        print '%s: %s' % (self.name, self.score)

bart = Student('Bart Simpson', 59)                #创建实例
bart.print_score()
```
属性的名称前加上两个下划线__，就变成了一个私有变量（private），只有内部可以访问，外部不能访问。

其实也不是。不能直接访问__name是因为Python解释器对外把__name变量改成了_Student__name，所以，仍然可以通过_Student__name来访问__name变量

单下划线变量_name 是可以被访问，但请把我视为私有变量，不要随意访问

特殊变量__xxx__，外部可以直接访问


使用type\isinstance函数判断对象类型
```py
>>> type(f)
<type 'builtin_function_or_method'>
>>> type(myClass)
<class '__main__.MyClass'>
>>> type(123)
<type 'int'>
>>> type('str')
<type 'str'>
>>> type(None)
<type 'NoneType'>
import types
types.StringType types.UnicodeType types.ListType types.TypeType（所有类型的基类）
```

使用dir()获得一个对象的所有属性和方法，它返回一个包含字符串的list

len()获得一个对象的长度 len(myClass)其实是调用myClass的__len__方法，自定义类增加此方法也能用len()

getattr()、setattr()以及hasattr()

我们可以给对象绑定任何属性和方法，这就是动态语言的灵活性

为了给所有实例都绑定方法，可以给具体的类绑定方法：

使用__slots__=tuple限定类的属性，仅对当前类作用，子类和超类都不影响，

但反之在子类中也定义__slots__，这样，子类允许定义的属性就是自身的__slots__加上父类的__slots__。

使用@property
```py
class Student(object):

    @property                       #@property装饰器就是负责把一个方法变成属性调用的
    def score(self):
        return self._score

    @score.setter                   #@property本身又创建了另一个装饰器@score.setter
    def score(self, value):
        if not isinstance(value, int):
            raise ValueError('score must be an integer!')
        if value < 0 or value > 100:
            raise ValueError('score must between 0 ~ 100!')
        self._score = value
```
可以定义只读属性，只定义getter方法，不定义setter方法就是一个只读属性


多重继承 主线的单一继承组合多个Mixin
```py
__slots__ __len__()

__str__()  # 类似于Java中对象的toString方法
__repr__()
__iter__()   #  如果一个类想被用于for ... in循环，类似list或tuple那样，就必须实现一个__iter__()方法
__getitem__() # 像list那样按照下标取出元素
__setitem__()
__call__()   #  一个对象实例可以有自己的属性和方法 实例变量+()   通过callable()函数，我们就可以判断一个对象是否是“可调用”对象。
```
通过type()函数创建的类和直接写class是完全一样的，因为Python解释器遇到class定义时，仅仅是扫描一下class定义的语法，然后调用type()函数创建出class。

metaclass

#### IO编程
StringIO和BytesIO是在内存中操作str和bytes的方法，使得和读写文件具有一致的接口。
```py
f = open('/Users/michael/test.txt', 'r' ,encoding='gbk')
    #标示符'r'表示读 标识符'w'表示写
    #用'rb'模式打开二进制文件，'wb'模式写二进制文件
    #encoding 默认utf-8
f.read()                                     #一次读取文件的全部内容，到内存，用一个str对象表示
    readline()可以每次读取一行内容
    readlines()一次读取所有内容并按行返回list
f.close()
```
文件读写时都有可能产生IOError,可以使用try ... finally来实现,也可以用with语句来自动帮我们调用close()方法
```py
with open('/path/to/file', 'r') as f:
    print(f.read())
```
os模块提供操作系统、文件系统的操作



#### 序列化
在Python中叫pickling，在其他语言中也被称之为serialization，marshalling，flattening等等，都是一个意思。

Python提供了pickle模块来实现序列化。
```py
>>> import pickle
>>> d = dict(name='Bob', age=20, score=88)
>>> byte_string=pickle.dumps(d)                 #序列化
>>> pickle.loads(byte_string)                   #反序列化
```
pickle.dump(d, f)直接序列化并写入文件
```py
>>> f = open('dump.txt', 'wb')
>>> pickle.dump(d, f)
>>> f.close()
>>> f = open('dump.txt', 'rb')
>>> d = pickle.load(f)
>>> f.close()
```
Python对象与JSON对象可用序列化和反序列化方便地互转 json模块的dumps()和loads()
```py
>>> import json
>>> d = dict(name='Bob', age=20, score=88)
>>> json_str = json.dumps(d)
'{"age": 20, "score": 88, "name": "Bob"}'
>>> json.loads(json_str)
{'age': 20, 'score': 88, 'name': 'Bob'}
```

#### SQL
SQLAlchemy太庞大，过度地面向对象设计导致API太复杂。

所以我们决定自己设计一个封装基本的SELECT、INSERT、UPDATE和DELETE操作的db模块：transwarp.db。
```py
from transwarp import db
db.create_engine(user='root', password='password', database='test', host='127.0.0.1', port=3306)
users = db.select('select * from user')
n = db.update('insert into user(id, name) values(?, ?)', 4, 'Jack')
```
`update(sql, *args)`统一用?作为占位符，并传入可变参数来绑定，从根本上避免SQL注入攻击

每个select()或update()调用，都隐含地自动打开并关闭了数据库连接

一个数据库连接里执行多个SQL语句
```py
with db.connection():
    db.select('...')
    db.update('...')
    db.update('...')
```
一个数据库事务中执行多个SQL语句
```py
with db.transaction():
    db.select('...')
    db.update('...')
    db.update('...')
```


#### 开发Web App
需要的第三方库：
```shell
easy_install jinja2
easy_install mysql-connector-python
```
项目结构
```
awesome-python-webapp/   <-- 根目录
|
+- backup/               <-- 备份目录
|
+- conf/                 <-- 配置文件
|
+- dist/                 <-- 打包目录
|
+- www/                  <-- Web目录，存放.py文件
|  |
|  +- static/            <-- 存放静态文件
|  |
|  +- templates/         <-- 存放模板文件
|
+- LICENSE               <-- 代码LICENSE
```

##### Web框架
- Django：一站式开发框架，但不利于定制化；
- web.py：使用类而不是更简单的函数来处理URL，并且URL映射是单独配置的；
- Flask：使用@decorator的URL路由不错，但框架对应用程序的代码入侵太强；
- bottle：缺少根据URL模式进行拦截的功能，不利于做权限检查。


### NumPy (Numeric Python)

http://docs.scipy.org/doc/numpy

Python使用NumPy包完成了对N-维数组的快速便捷操作。使用这个包，需要导入numpy。SciPy包以NumPy包为基础，大大的扩展了numpy的能力。
```py
import numpy as np

np.version.full_version
```

1. 数组和数组运算
```python
a1=np.array([1,2,3],dtype=int)   # 数据类型是int。也可以不指定数据类型，使用默认。几乎所有的数组建立函数都可以指定数据类型，即dtype的取值。
a1=np.linspace(start, stop, num=50, endpoint=True, retstep=False)  # 等差数列 num 指定元素数量；默认包含start,包含end，若要不包含end 修改endpoint
a1=np.logspace(start, stop, num=50, endpoint=True, base=10.0)  # 等比数列 num 指定元素数量；默认包含start,包含end，若要不包含end 修改endpoint
a1=np.arange([start,] stop[, step,], dtype=None) # step 指定步长；包含start,不包含end
a1=np.zeros(3)                   # 生成一个大小为3的全0数组。注意，参数是一个tuple：(3)。相同的结构，有ones()建立全1数组。empty()建立一个空数组，使用内存中的随机值来填充这个矩阵。
a1=np.random.rand(3)             # 生成一个大小为3的随机数组，数值区间[0，1] 注意，参数不是一个tuple，参数个数决定数组维数
a1=np.random.randn(3)            # 生成一个大小为3的服从正态分布的随机数组，其它同np.random.rand()
```
fromfunction fromfile

有些操作符像 += 和 *= 被用来更改已存在数组而不创建一个新的数组。注意原数组元素类型

数组的算术/逻辑运算是按元素的。新的数组被创建并且被结果填充。

数组与数值运算支持+-*／  **（乘方）%（取余） 每个元素与数值进行计算

数组间运算支持+-*／(点乘、点除)  **（乘方）%（取余）对应元素间进行计算

```py
np.add(a,b)                         # 相加 +
np.subtract(a,b)                    # 相减 -
np.multiply(a,b)                    # 点乘 *
np.divide(a,b)                      # 点除 ／
np.floor_divide(a,b)                # 圆整除法（丢弃余数）
np.power(a,b)                       # 乘方 **
10*np.sin(a1)                       # 参与函数运算

np.mod(a,b)                         # 求模
np.dot(a,b)                         # 计算数组的点积
np.inner(a,b)                       # 计算内积
np.outer(a,b)                       # 计算外积

np.mean(a, axis=0 )	                # 求平均值
np.sum(a, axis= 0)	                # 求和
np.cumsum(a, axis=0)                # 累加
np.cumprod(a, axis=0)               # 累乘
np.std(a)                           # 方差
np.var(a)                           # 标准差
np.max(a)                           # 最大值
np.min(a)                           # 最小值
np.argmax(a)                        # 最大值索引
np.argmin(a)                        # 最小值索引

np.any(a)                           # 是否至少有一个True
np.all(a)                           # 是否全部为True
np.isnan(a)                         # 判断是否是nan，np.isinf 判断是否无穷，np.isfinite 判断是否有穷（非inf，非NaN）
np.nan_to_num(a)                    # nan_to_num可用来将nan替换成0
```

2. 建立矩阵和运算
np.zeros、np.random.rand、np.random.randn 同 一维数组类似
```py
a2=np.array([[1,2,3],[2,3,4]])      # 建立一个二维数组。此处和MATLAB的二维数组（矩阵）的建立有很大差别。
b2=np.identity(n)                   # 建立n*n的单位阵，主对角线上元素均为1,这只能是一个方阵。
b3=np.eye(N, M=None, k=0)           # 建立一个对角线是1其余值为0的矩阵，用k指定对角线的位置。
```
矩阵的算术/逻辑运算与数组类似
```py
np.dot(a,b)                         # 矩阵间的乘法 N-维数组的点积
np.trace(a)                         # 计算对角线元素的和
np.diag(a)                          # 返回矩阵的对角线元素，或将一维数组转换成矩阵

sp.linalg.det(a)   	                # 计算矩阵列式
np.linalg.eig(a)   	                # 计算方阵的本征值和本征向量
np.linalg.inv(a)                    # 计算方阵的逆
np.linalg.pinv(a)                   # 计算方阵的Moore-Penrose伪逆
np.linalg.qr(a)	                    # 计算qr分解
np.linalg.svd(a)   	                # 计算奇异值分解svd
np.linalg.solve(a)                  # 解线性方程组Ax = b，其中A为方阵
np.linalg.lstsq(a)                  # 计算Ax=b的最小二乘解
```

3. 操作矩阵及N-维数组
```py
a[m,n]                              # 第m+1行第n+1列的元素
a[:,n]                              # 第n+1列的所有元素 一个数组
a[:, slice]                         # slice指定的部分列的所有元素 一个矩阵
a[[m1,m2],[n1,n2]]                  # 第m1+1行第n1+1列、m2+1行第n2+1列的元素 一个数组
a[np.ix_[m1,m2],[n1,n2]]            # 第m1+1、m2+1行,第n1+1、n2+1列的元素 一个矩阵
__len__()                           # N-维数组第一维的长度
#__delitem__(x)                     # or del a[x]  这个方法会报错
a.ndim                              # 矩阵的秩 N-维数组的维度
a.size                              # 元素个数 or np.prod(a.shape)
(m,n) = a.shape                     # 求行列个数 每个维度上的元素个数
a.shape =  (m,n)                    # 改变数组本身，支持负数自动计算
a.reshape(4, -1, order='F')         # 返回副本，把原矩阵改为4行的新矩阵,order行列元素的顺序 支持负数自动计算
a.resize(4, 5, refcheck=True)       # 不支持负数自动计算
a.transpose()                       # 同a.T，矩阵的转置 但在ndim<2时,返回自身,transpose可以传入维度索引
a[:, np.newaxis]                    # 一维数组转成列矩阵
row_one_max = np.max(a[:,0])        # 行列极值
col_one_max = np.max(a[0,:])
np.sum(a[:,2]==1, dtype=np.int32)   # sum依照dtype进行求和
np.sum(a[:,2]==1, axis=1)           # sum 每一行求和   axis=0为每一列求和      axis=(0,1)为行列一起求值
np.prod(a[:,2]==1, dtype=np.int32)  # sum 每一行求积   axis=0为每一列求积      axis=(0,1)为行列一起求值

np,r_                               #
np,c_                               #
np.vstack((a,b))                    # 增加行来组合，要求a，b列数一致；N-维数组 合并某一维 要求其他维长度一致
np.hstack((a,b))                    # 增加列来组合，要求a，b行数一致
np.column_stack((a,b,c,...))        # 合并列，如果是一维数组 那么作为一列来合并；如果是1行矩阵那么不能作为一列...
np.row_stack((a,b,c,...))           # 合并行，...第n个数组转换成第n行，对应列元素按数组索引排列

np.append(a, values, axis=None)     # 在数组a的基础上增加一组值values（值、数组），返回新的数组
a = np.append(a[np.where(a > 0)])   # 在数组a的基础上增加一个slice切片，返回新的数组
np.delete(a, slice, axis=None)      # 删除a的slice切片，返回新的数组
                                    # axis=None 只删除切片指定元素，返回一维数组；
                                    # axis=0 删除切片元素所在的那些行，返回多维数组；
                                    # axis=1 删除切片元素所在的那些列，返回多维数组；
a = np.delete(np.where(a > 0))      # 按条件删除数组a的某些元素

np.sort(a,axis=-1)                  # 对各行或列排序 数组为行 矩阵-1为行 0为列
```

4. 矩阵运算
专门处理矩阵的数学函数在numpy的子包linalg中定义。处理和MATLAB是类似的，使用一个m后缀表示是矩阵的运算。

np.linalg.logm(A)计算矩阵A的对数。

cosm()/sinm()/signm()/sqrtm()等。

其中常规exp()对应有三种矩阵形式：expm()使用Pade近似算法、expm2()使用特征值分析算法、expm3()使用泰勒级数算法。

在numpy中，也有一个计算矩阵的函数：funm(A,func)。

```py
b, residuals, rank, s = np.linalg.lstsq(x, y, rcond=-1)
# b 回归系数估计值向量，b(0)常数项
# residuals 残差平方和
# rank x矩阵的秩
# s x矩阵奇异值

slope, intercept, r-value, p-value, stderr = scipy.stats.linregress(x, y)
# x, y  两个一维数组 要求长度一致，如果y=None，那么x是一个二维数组，会被自动分割成两个一维数组
# slope, 斜率
# intercept, 截距 回归系数常数项
# r-value, 相关系数r
# p-value, slope==0?
# stderr  估计的标准差
# 注：同scipy.stats.mstats.linregress(x, y)区别不详

reg = linear_model.LinearRegression(False)
reg.fit(x, y)
```

### SciPy
SciPy基于NumPy提供了更为丰富和高级的功能扩展，在统计、优化、插值、数值积分、时频转换等方面提供了大量的可用函数，基本覆盖了基础科学计算相关的问题。
```py
import numpy as np
import scipy.stats as stats
import scipy.optimize as opt
```

SciPy.stats支持定义出某个具体的分布的对象
```py
# 连续型的随机分布，如均匀分布（uniform）、正态分布（norm）、贝塔分布（beta）等
rv_unif = stats.uniform.rvs(size=10)
norm_list = stats.norm(loc=0.5, scale=2)
rv_norm = norm_list.rvs(size=200)
beta_list = stats.beta(a=4, b=2)
rv_beta = beta_list.rvs(size=10)
# 离散型的随机分布，如伯努利分布（bernoulli）、几何分布（geom）、泊松分布（poisson）等
```

为让结果具有可比性，可以指定了随机数的生成种子，`np.random.seed(seed=2015)`。

#### 假设检验

单样本假设检验问题，最为常见的解决方案是采用K-S检验（ Kolmogorov-Smirnov test）。单样本K-S检验的原假设是给定的数据来自和原假设分布相同的分布，在SciPy中提供了kstest函数，参数分别是数据、拟检验的分布名称和对应的参数。

```py
# 检验一组数据是否服从假设的分布，如正态分布。
norm_dist = stats.norm(loc=0.5, scale=2)
data = norm_dist.rvs(size=200)
mu = np.mean(data)
sigma = np.std(data)
stat_val, p_val = stats.kstest(data, 'norm', (mu, sigma))
print 'KS-statistic D = %6.3f p-value = %6.4f' % (stat_val, p_val)

# 在正态性的前提下，可进一步检验这组数据的均值是不是0。典型的方法是t检验（t-test），其中单样本的t检验函数为ttest_1samp
stat_val, p_val = stats.ttest_1samp(dat, 0)
print 'One-sample t-statistic D = %6.3f, p-value = %6.4f' % (stat_val, p_val)
```

双样本的t检验（ttest_ind）
```py
norm_dist2 = stats.norm(loc=-0.2, scale=1.2)
data2 = norm_dist2.rvs(size=n/2)
stat_val, p_val = stats.ttest_ind(data, data2, equal_var=False)
print 'Two-sample t-statistic D = %6.3f, p-value = %6.4f' % (stat_val, p_val)
```

```py
# cdf和ppf查看某数值在一个分布中的分位，或者给定了一个分布，求某分位上的数值。
stats.norm.moment(6, loc=0, scale=1) # 对于一个给定的分布，可以用moment很方便的查看分布的矩信息

norm_dist = stats.norm(loc=0, scale=1.8)
dat = norm_dist.rvs(size=100)
info = stats.describe(dat) # describe函数提供对数据集的统计描述分析，包括数据样本大小，极值，均值，方差，偏度和峰度：

norm_dist = stats.norm(loc=0, scale=1.8)
dat = norm_dist.rvs(size=100)
mu, sigma = stats.norm.fit(dat) # fit函数来得到对应分布参数的极大似然估计（MLE, maximum-likelihood estimation）

# pearsonr和spearmanr可以计算Pearson和Spearman相关系数，这两个相关系数度量了两组数据的相互线性关联程度：
norm_dist = stats.norm()
dat1 = norm_dist.rvs(size=100)
exp_dist = stats.expon()
dat2 = exp_dist.rvs(size=100)
cor, pval = stats.pearsonr(dat1, dat2)
print "Pearson correlation coefficient: " + str(cor)
cor, pval = stats.spearmanr(dat1, dat2)
print "Spearman's rank correlation coefficient: " + str(cor)
```

#### 最优化问题
SciPy中的优化模块还有一些特殊定制的函数，专门处理能够转化为优化求解的一些问题，如方程求根、最小方差拟合等

##### 无约束优化问题
无约束优化问题指的是一个优化问题的寻优可行集合是目标函数自变量的定义域，即没有外部的限制条件。例如，求解优化问题。

##### 约束优化问题

### Pandas

pandas包含了高级的数据结构 Series 和 DataFrame，使得在Python中处理数据变得非常方便、快速和简单。

pandas不同的版本之间存在一些不兼容性

```py
import numpy as np
from pandas import Series, DataFrame
```
#### Series

Series可以简单地被认为是一维的数组。Series和一维数组最主要的区别在于Series类型具有索引（index），可以和另一个编程中常见的数据结构哈希（Hash）联系起来。

```py
# 创建Series，index，name可选
d1 = np.random.randn(5)
s = Series(d1, index=['a', 'b', 'c', 'd', 'e'], name='my_series') # 从数组创建Series
d2 = {'a': 0., 'b': 1, 'c': 2}
s = Series(d2, index=['a', 'b', 'c', 'd']) # 从字典创建Series
# 访问Series数据可以和数组一样使用下标，也可以像字典一样使用索引，还可以使用一些条件过滤
s[0]
s[:2]
s[[2,0,4]]
s[s > 0.5]
s[['e', 'i']]
print 'e' in s
```

#### DataFrame
DataFrame是将数个Series按列合并而成的二维数据结构，每一列单独取出来是一个Series。所以，按列对一个DataFrame进行处理更为方便。

DataFrame的优势在于可以方便地处理不同类型的列，因此，就不要考虑如何对一个全是浮点数的DataFrame求逆之类的问题了，处理这种问题还是把数据存成NumPy的matrix类型比较便利一些。

```py
# 创建DataFrame
df = DataFrame() # 创建空的DataFrame
d = {'one': Series([1., 2., 3.], index=['a', 'b', 'c']), 'two': Series([1., 2., 3., 4.], index=['a', 'b', 'c', 'd'])}
df = DataFrame(d) # 从字典创建DataFrame
df = DataFrame(d, index=['r', 'd', 'a'], columns=['two', 'three']) # 指定所需的行和列，若字典中不含有对应的元素，则置为NaN

print df.index # 查看DataFrame的行
print df.columns # 查看DataFrame的列
print df.values # 查看DataFrame的元素，数组

# 从值是数组的字典创建DataFrame，但是各个数组的长度需要相同
d = {'one': [1., 2., 3., 4.], 'two': [4., 3., 2., 1.]}
df = DataFrame(d, index=['a', 'b', 'c', 'd'])

# 使用concat函数基于Series创建一个DataFrame
a = Series(range(5))
b = Series(np.linspace(4, 20, 5))
df = pd.concat([a, b], axis=1) # axis=1表示按列进行合并，axis=0表示按行合并

# 使用concat函数基于DataFrame创建一个DataFrame
df = DataFrame()
index = ['alpha', 'beta', 'gamma', 'delta', 'eta']
for i in range(5):
    a = DataFrame([np.linspace(i, 5*i, 5)], index=[index[i]])
    df = pd.concat([df, a], axis=0)
print df

print df[1]
print type(df[1])
df.columns = ['a', 'b', 'c', 'd', 'e']
print df['b']
print type(df['b'])
print df.b
print type(df.b)
print df[['a', 'd']]
print type(df[['a', 'd']])

print df['b'][2]
print df['b']['gamma']
print df.iat[2, 3] # 按下标访问某一元素
print df.at['gamma', 'd'] # 按索引访问某一元素

# 混合使用索引和下标进行访问，但行列内部需要一致
print df.ix['gamma', 4]
print df.ix[['delta', 'gamma'], [1, 4]]
print df.ix[[1, 2], ['b', 'e']]

print df.iloc[1] # 按下标访问某一行
print df.loc['beta'] # 按索引访问某一行

print df[1:3] # 切片访问n行

print df[['b', 'd']].iloc[[1, 3]]
print df.iloc[[1, 3]][['b', 'd']]
print df[['b', 'd']].loc[['beta', 'delta']]
print df.loc[['beta', 'delta']][['b', 'd']]

dates = pd.date_range('20150101', periods=5) # 创建一个以日期为元素的Series
df = pd.DataFrame(np.random.randn(5, 4),index=dates,columns=list('ABCD'))

# 只要是能转换成Series的对象，都可以用于创建DataFrame
df2 = pd.DataFrame({ 'A' : 1., 'B': pd.Timestamp('20150214'), 'C': pd.Series(1.6,index=list(range(4)),dtype='float64'), 'D' : np.array([4] * 4, dtype='int64'), 'E' : 'hello pandas!' })

print df.shape # 几条记录，每条记录有几个字段

df.head()
df.tail() # 查看数据的头几行和尾几行数据，默认5，可传入其它数值

print df.describe() # 提供了DataFrame中纯数值数据的统计信息

print df.sort_index(axis=1, ascending=False).head() # axis=0 按索引（行名）排序，axis=1 按列名排序，可指定升序或者降序

print df.sort(columns='tradeDate').head() # 按值排序，可指定列名和排序方式，默认的是升序排序
print df.sort(columns=['tradeDate', 'secID'], ascending=[False, True]).head()

print df.iloc[1:4][:]

print df[df.closePrice > df.closePrice.mean()].head()

# isin()函数可方便地过滤DataFrame中的数据
print df[df['secID'].isin(['601628.XSHG', '000001.XSHE', '600030.XSHG'])].head()

print df.dropna().head() # 按行丢弃带有nan的数据
print df.dropna(how='all').head() # 若指定how='all'（默认是'any'），则只在整行全部是nan时丢弃数据；
print df.dropna(thresh=6).head() # 若指定thresh，则表示当某行数据非缺失列数超过指定数值时才保留；
print df.dropna(subset=['closePrice']).head() # 要指定根据某列丢弃可以通过subset完成。

# 指定0按列进行，指定1按行进行
print df.mean(0)
print df.sum(0)

print df['closePrice'].value_counts().head() # 统计频数

# Series可以调用map函数来对每个元素应用一个函数
# DataFrame可以调用apply函数对每一列（行）应用一个函数，applymap对每个元素应用一个函数。
# 这里面的函数可以是用户自定义的一个lambda函数，也可以是已有的其他函数。
print df[['closePrice']].apply(lambda x: (x - x.min()) / (x.max() - x.min())).head()

# 使用append可以在Series后添加元素，以及在DataFrame尾部添加一行

print dat1.merge(dat2, on=['secID', 'tradeDate']).head() # sql join

# 数据分组
f_grp = df.groupby('secID')
grp_mean = df_grp.mean()

# 数据可视化
dat = df[df['secID'] == '600028.XSHG'].set_index('tradeDate')['closePrice']
dat.plot(title="Close Price of SINOPEC (600028) during Jan, 2015")
```

### matplotlib

Python用来绘图的工具包是matplotlib。

初级用户建议使用pylab模式，pylab中包括了matplotlib.pyplot的所有绘图命令，以及numpy和matplotlib.mlab中的函数，在这个模式下，和MATLAB的绘图命令和套路几乎是完全一样的；

高级用户建议使用matplotlib，可以进行更多的细节控制。

方式一：
```py
from pylab import *    #引入兼容MATLAB包：pylab

t1=arange(0.0,4.0,0.1)
t2=arange(0.0,4.0,0.05)    #准备一些数据，注意和MATLAB的不同

figure()
subplot(211)
plot(t1,sin(2*pi*t1),'--g*')
title('sine function demo')
xlabel('time(s)')
ylabel('votage(mV)')
xlim([0.0,5.0])
ylim([-1.2,1.2])
grid('on')    #控制网格显示和grid(True)效果一样。不带参数的grid()起到toggle的作用。

subplot(212)
plot(t2,exp(-t2),':r')
hold('on')    #前一条线保持。用法和grid类似。
plot(t2,cos(2*pi*t2),'--b')
xlabel('time')
ylabel('amplitude')
show()    #这是和MATLAB很大的不同，这个命令用完，图形才会出来。
```
方式二:
```py
import matplotlib.pyplot as plt
import numpy as np    #导入包

t1=np.arange(0.0,4.0,0.1)
t2=np.arange(0.0,4.0,0.05)     #准备一些数据

fig = plt.figure()    #准备好这张纸，并把句柄传给fig
ax1 = fig.add_subplot(211)    #使用句柄fig添加一个子图
line1, = plt.plot(t1,np.sin(2*np.pi*t1),'--*')   #绘图，将句柄返给line1
plt.title('sine function demo')
plt.xlabel('time(s)')           # x轴说明
plt.ylabel('votage(mV)')        # y轴说明
plt.xlim([0.0,5.0])
plt.ylim([-1.2,1.2])
plt.grid('on')

##这种方式的优势和不同在以下语句体现。因为句柄的引入，让我们更加的面向对象，思路也更加清晰。代码的
##可读性也更高了。
plt.setp(line1,lw=2,c='g')    #通过setp函数，设置句柄为line1的线的属性，c是color的简写
line1.set_antialiased(False)    #通过line1句柄的set_*属性设置line1的属性
plt.text(4,0,'$\mu=100,\\sigma=15$')    #添加text，注意，它能接受LaTeX哟！

ax2=fig.add_subplot(212)
plt.plot(t2,np.exp(-t2),':r')
plt.hold('on')
plt.plot(t2,np.cos(2*np.pi*t2),'--b')
plt.xlabel('time')
plt.ylabel('amplitude')
plt.show()
```














