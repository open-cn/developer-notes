Node.js 是一个基于 Chrome V8 引擎的 JavaScript 运行环境。
Node.js 使用了一个事件驱动、非阻塞式 I/O 的模型，使其轻量又高效。

优点：
高性能、速度快、效率高 适合做高并发的项目(I/O密集型的应用)
缺点：
不适合做大量的运算应用(CPU密集的应用)

Node.js 中没有 DOM 和 BOM 的概念，无法使用 window/document 等对象的API。
同时 Node.js 中也有一些属性浏览器无法使用 例如：process global 等对象的API。


【基础知识】

一、非阻塞/回调/异步

Node.js 代码运行在单个线程上。 每次只处理一件事。

Node.js 引入了非阻塞的 I/O 环境，以将该概念扩展到文件访问、网络调用等。

被阻塞是个异常，这就是 JavaScript 如此之多基于回调（最近越来越多基于 promise 和 async/await）的原因。
一些API也提供相应的同步方法，但是不建议使用。

回调是一个简单的函数，会作为值被传给另一个函数，并且仅在事件发生时才被执行。 之所以这样做，是因为 JavaScript 具有顶级的函数，这些函数可以被分配给变量并传给其他函数（称为高阶函数）。

回调适用于简单的场景！但是，每个回调都可以添加嵌套的层级，并且当有很多回调时，代码就会很快变得非常复杂。
从 ES6 开始，JavaScript 引入了一些特性，可以帮助处理异步代码而不涉及使用回调：Promise（ES6）和 Async/Await（ES2017）。

异步编程:
异步编程与回调
定时器
Promise
Async 与 Await
闭包
事件循环


二、模块和包

Node.js 使用 CommonJS 模块系统

1 module对象
根据CommonJS规范，每一个文件就是一个模块，在每个模块中，都会有一个module对象，这个对象就指向当前的模块。

module对象具有以下属性：
id：当前模块的bi
exports：表示当前模块暴露给外部的值
parent： 是一个对象，表示调用当前模块的模块
children：是一个对象，表示当前模块调用的模块
filename：模块的绝对路径
paths：从当前文件目录开始查找node_modules目录；然后依次进入父目录，查找父目录下的node_modules目录；依次迭代，直到根目录下的node_modules目录
loaded：一个布尔值，表示当前模块是否已经被完全加载


module对象具有一个exports属性，该属性就是用来对外暴露变量、方法或整个模块的。当其他的文件require进来该模块的时候，实际上就是读取了该模块module对象的exports属性

2 exports对象
exports和module.exports都是引用类型的变量，而且这两个对象默认指向同一块内存地址
exports = module.exports = {};


3 require
模块首次加载时初始化，并且被缓存起来，后面每次reauire('xxx')都会确切地返回同一模块，也不会再进行初始化

Node.js中引入模块的机制步骤
// 计算绝对路径
// 第一步：如果有缓存，取出缓存
// 第二步：是否为内置模块
// 第三步：生成模块实例，存入缓存
// 第四步：加载模块
// 第五步：输出模块的module.exports属性

require(): 加载外部模块
require.resolve()：将模块名解析到一个绝对路径
require.main：指向主模块
require.cache：指向所有缓存的模块
require.extensions：根据文件的后缀名，调用不同的执行函数

//删除指定模块的缓存
delete require.cache[require.resolve('/*被缓存的模块名称*/')]
// 删除所有模块的缓存
Object.keys(require.cache).forEach(function(key) {
     delete require.cache[key];
})

require、module.exports 和 exports 是属于CommonJS模块规范

import、export 和 export default 是属于ES6语法


三、事件循环 EventLoop

Event Loop 是一个程序结构，用于等待和发送消息和事件。

它阐明了 Node.js 如何做到异步且具有非阻塞的 I/O。

Node.js JavaScript 代码运行在单个线程上。 每次只处理一件事。
这个限制实际上非常有用，因为它大大简化了编程方式，而不必担心并发问题。
只需要注意如何编写代码，并避免任何可能阻塞线程的事情，例如同步的网络调用或无限的循环。
主要需要关心代码会在单个事件循环上运行，并且在编写代码时牢记这一点，以避免阻塞它。

1、Node.js中的宏任务分类
Timers 类型的宏任务队列 setTimeout、setInterval

Check 类型的宏任务队列 setImmediate

Close callback 类型的宏任务队列 socket.on(‘close’, () => {})

Poll 类型的宏任务队列 除了上面几种的其他所有回调

2、Node.js 里面的微任务队列
process.nextTick()、Promise.then()
process.nextTick()的优先级高于所有的微任务,每一次清空微任务列表的时候，都是先执行process.nextTick()

3、setTimeout && setImmediate 执行顺序

Node.js 并不能保证 timers 在预设时间到了就会立即执行，因为 Node 对 timers 的过期检查不一定靠谱，它会受机器上其它运行程序影响，或者那个时间点主线程不空闲
虽然 setTimeout 延时为 0，但是一般情况 Node 把 0 会设置为 1ms，所以，当 Node 准备 event loop 的时间大于 1ms 时，进入 timers 阶段时，setTimeout 已经到期，则会先执行 setTimeout；反之，若进入 timers 阶段用时小于 1ms，setTimeout 尚未到期，则会错过 timers 阶段，先进入 check 阶段，而先执行 setImmediate


四、事件模块

EventEmitter对象
创建    var event = new EventEmitter();
注册监听  event.on('some_event',function(){...});
注册一次性的监听  event.once('some_event',function(){...});
发送事件  event.emit('some_event');
移除监听  event.removeListener('some_event',function(){...});
移除所有监听  event.removeAllListeners('some_event');


五、Node.js 各版本对 ES 语法的支持情况 https://node.green

Node.js 目前仍不支持 ES6 的import/export 语法，但 9+ 提供了 .mjs 的方式来使用 ES6 import 和 export。

现在，可以通过 Babel 工具使用全部的 ES 语法了。







附录：
Node.js 自带模块

不需要require
  Buffer (缓冲)
  console (控制台)
  Error (错误)
  module (模块)
  process (进程)
  timer (定时器)

需要require
  assert - 断言
  child_process (子进程)
  cluster (集群)
  crypto (加密)
  dgram (数据报)
  dns (域名服务器)
  events (事件)
  fs (文件系统)
  http
  https
  net (网络)
  os (操作系统)
  path (路径)
  querystring - 查询字符串
  readline (逐行读取)
  repl (交互式解释器)
  stream (流)
  string_decoder - 字符串解码器
  tls (安全传输层)
  tty - 终端
  url
  util (实用工具)
  V8
  vm (虚拟机)
  Zlib(压缩)


Event Listener Breakpoints

Animation
  Request Animation Frame
  Cancel Animation Frame
  Animation Frame Fired
Canvas
  Create canvas context
  WebGL Error Fired
  WebGL Warning Fired
Clipboard
  copy
  cut
  paste
  beforecopy
  beforecut
  beforepaste
Control
  resize
  scroll
  zoom
  focus
  blur
  select
  change
  submit
  reset
Dom Mutation
  DOMActivate
  DOMFocusIn
  DOMFocusOut
  DOMAttrModified
  DOMCharacterDataModified
  DOMNodeInserted
  DOMNodeInsertedIntoDocument
  DOMNodeRemoved
  DOMNodeRemovedFromDocument
  DOMSubtreeModified
  DOMContentLoaded
Device
  deviceorientation
  devicemotion
Drag/drop
  drag
  dragstart
  dragend
  dragenter
  dragover
  dragleave
  drop
Geolocation
  getCurrentPosition
  watchPosition
Keyboard
  keydown
  keyup
  keypress
  input
Load
  load
  beforeunload
  unload
  abort
  error
  hashchange
  popstate
Media
  play
  pause
  playing
  canplay
  canplaythrough
  seeking
  seeked
  timeupdate
  ended
  ratechange
  durationchange
  volumechange
  loadstart
  progress
  suspend
  abort
  error
  emptied
  stalled
  loadedmetadata
  loadeddata
  waiting
Mouse
  auxclick
  click
  dblclick
  mousedown
  mouseup
  mouseover
  mousemove
  mouseout
  mouseenter
  mouseleave
  mousewheel
  wheel
  contextmenu
Notification
  requestPermission
Parse
  Set innerHTML
  document.write
Pointer
  pointerover
  pointerout
  pointerenter
  pointerleave
  pointerdown
  pointerup
  pointermove
  pointercancel
  gotpointercapture
  lostpointercapture
Script
  Script First Statement
  Script Blocked by Content Security Policy
Timer
  setTimeout
  clearTimeout
  setInterval
  clearInterval
  setTimeout fired
  setInterval fired
Touch
  touchstart
  touchmove
  touchend
  touchcancel
Window
  close
Worker
  message
  messageerror
XHR
  readystatechange
  load
  loadstart
  loadend
  abort
  error
  progress
  timeout





