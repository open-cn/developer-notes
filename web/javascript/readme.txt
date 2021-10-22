JavaScript


类型
5 种不同的数据类型：string、number、boolean、object、function
3 种对象类型：Object、Date、Array
2 个不包含任何值的数据类型：null、undefined


类型转换
Number() 转换为数字， String() 转换为字符串， Boolean() 转化为布尔值。


类型判断

typeof 不能正确判断类型
因为由于历史原因，在判断原始类型时，typeof null会等于object。而且对于对象来说，除了函数，都会转换成object。
"string"      "" '' ' '
"undefined"   undefined
"boolean"     false true
"number"      0 1.0 0.1 NaN
"object"      [] {} null Date
"function"    fn

instanceof 不能正确判断类型
虽然instanceof是通过原型链来判断的，但是对于对象来说，Array也会被转换成Object，而且也不能区分基本类型string和boolean。

Object.prototype.toString.call(obj) 能正确判断类型
"undefined"     Undefined
"string"        String
"number"        Number
"boolean"       Boolean
"object"        Null, Object, Array, Generator
"function"      Function, GeneratorFunction


constructor.name  属性     toString()的字符串 indexOf 也是可行的
"String"        "John"
"Number"        (3.14)
"Boolean"       false
"Array"         [1,2,3,4]
"Object"        {name:'John'}
"Date"          new Date()
"Function"      function() {}



isNaN  判断是否非数字
Number.isNaN  判断是否是NaN Not a Number


parseInt parseFloat 对1.23.33这样的数字会去尾转换


正则表达式 语法
/正则表达式主体/修饰符(可选)

修饰符
i  搜索不区分大小写
g   执行全局匹配（查找所有匹配而非在找到第一个匹配后停止）
m   执行多行匹配
/\w+/ 与 new RegExp("\\w+") 等价




switch 语句会使用恒等计算符(===)进行比较




每个函数都包含两个非继承而来的方法：call()方法和apply()方法。这两个方法的作用是一样的。
都是在特定的作用域中调用函数，等于设置函数体内this对象的值，以扩充函数赖以运行的作用域。





JavaScript 中，函数及变量的声明都将被提升到函数的最顶部。变量和函数可以在使用后声明。但是初始化的变量不会被提升。





for (变量 in 对象或数组) {} // “变量”可以是数组元素的索引，也可以是对象的属性名称。
for (变量 of 数组) {} // “变量”是数组元素值。
for...of 循环是ES6引入的新的语法。遍历Object会报错（不是一个迭代器）






es 5

ECMA-262 定义了ECMAScript支持的一套关键字，一套保留字，都不能用作变量名或函数名。
下面是ECMAScript关键字的完整列表：
break default switch case if else while do
try catch finally
for in
void return throw
new var typeof instanceof delete

ECMA-262第3版中保留字的完整列表如下：
abstract enum int short
boolean export interface static
byte extends long super char final
native synchronized class float package
throws const goto private transient debugger
implements protected volatile double
import public


es 6
Symbol()函数会返回symbol类型的值。每个从Symbol()返回的symbol值都是唯一的。一个symbol值能作为对象属性的标识符；这是该数据类型仅有的目的。




es 5 新增关键字 export、import、enum、class、extends、super。
es 6 新增关键字 let、const。
continue ???







EventLoop 事件循环

通常，在大多数浏览器中，每个浏览器选项卡都有一个事件循环，以使每个进程都隔离开，并避免使用无限的循环或繁重的处理来阻止整个浏览器的网页。该环境管理多个并发的事件循环，例如处理 API 调用。 Web 工作进程也运行在自己的事件循环中。

主要需要关心代码会在单个事件循环上运行，并且在编写代码时牢记这一点，以避免阻塞它。

任何花费太长时间才能将控制权返回给事件循环的 JavaScript 代码，都会阻塞页面中任何 JavaScript 代码的执行，甚至阻塞 UI 线程，并且用户无法单击浏览、滚动页面等。

JavaScript 中几乎所有的 I/O 基元都是非阻塞的。 网络请求、文件系统操作等。 被阻塞是个异常，这就是 JavaScript 如此之多基于回调（最近越来越多基于 promise 和 async/await）的原因。

1. 消息队列

当调用 setTimeout() 时，浏览器或 Node.js 会启动定时器。 当定时器到期时（在此示例中会立即到期，因为将超时值设为 0），则回调函数会被放入“消息队列”中。

在消息队列中，用户触发的事件（如单击或键盘事件、或获取响应）也会在此排队，然后代码才有机会对其作出反应。 类似 onLoad 这样的 DOM 事件也如此。

事件循环会赋予调用堆栈优先级，它首先处理在调用堆栈中找到的所有东西，一旦其中没有任何东西，便开始处理消息队列中的东西。

我们不必等待诸如 setTimeout、fetch、或其他的函数来完成它们自身的工作，因为它们是由浏览器提供的，并且位于它们自身的线程中。 例如，如果将 setTimeout 的超时设置为 2 秒，但不必等待 2 秒，等待发生在其他地方。

2. 作业队列
ECMAScript 2015 引入了作业队列的概念，Promise 使用了该队列（也在 ES6/ES2015 中引入）。 这种方式会尽快地执行异步函数的结果，而不是放在调用堆栈的末尾。




js的代码运行会形成一个主线程和一个任务队列。主线程会从上到下一步步执行我们的js代码，形成一个执行栈。同步任务就会被放到这个执行栈中依次执行。而异步任务被放入到任务队列中执行，执行完就会在任务队列中打一个标记，形成一个对应的事件。当执行栈中的任务全部运行完毕，js会去提取并执行任务队列中的事件。这个过程是循环进行的

js是单线程的。所谓单线程就是进程中只有一个线程在运行。

宏任务： 需要多次事件循环才能执行完，事件队列中的每一个事件都是一个宏任务。
浏览器为了能够使得js内部宏任务与DOM任务有序的执行，会在一个宏任务执行结束后，在下一个宏执行开始前，对页面进行重新渲染 （task->渲染->task->…）鼠标点击会触发一个事件回调，需要执行一个宏任务，然后解析HTML

微任务： 微任务是一次性执行完的。微任务通常来说是需要在当前task执行结束后立即执行的任务，例如对一些动作做出反馈或者异步执行任务又不需要分配一个新的task，这样便可以提高一些性能




setTimeout()只是将事件插入了"任务队列"，必须等到当前代码（执行栈）执行完，主线程才会去执行它指定的回调函数。要是当前代码耗时很长，有可能要等很久，所以并没有办法保证，回调函数一定会在setTimeout()指定的时间执行。

HTML5 标准规定了setTimeout()的第二个参数的最小值（最短间隔），不得低于4毫秒，如果低于这个值，就会自动增加。在此之前，老版本的浏览器都将最短间隔设为10毫秒。

另外，对于那些DOM的变动（尤其是涉及页面重新渲染的部分），通常不会立即执行，而是每16毫秒执行一次。这时使用requestAnimationFrame()的效果要好于setTimeout()。



EventTarget.addEventListener(type, listener, options?: { capture, once, passive ]);
EventTarget.addEventListener(type, listener [, useCapture, wantsUntrusted  ]);

capture

once

passive

useCapture

EventTarget.removeEventListener()
EventTarget.dispatchEvent()

