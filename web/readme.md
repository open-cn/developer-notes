## Web

Web标准（网页标准）

HTML 网页的基本结构
CSS 网页的表现效果
JavaScript 网页的交互效果


W3C( World Wide Web Consortium )万维网联盟，创建于1994年是Web技术领域最具权威和影响力的国际中立性技术标准机构；是专门负责网络标准制定的非赢利组织。制定了结构标准和样式标准；
https://www.w3.org/TR/?status=rec

ECMA：欧洲电脑网商联合会（厂商协会），制定了行为标准；


一、网页结构
结构化标准语言主要包括 XML、HTML、XHTML。
1) XML（EXtensible Markup Language）
W3C 于 1998 年 2 月 10 日发布的 XML 1.0（https://www.w3.org/TR/1998/REC-xml-19980210）。
W3C 于 2000 年 10 月 6 日发布的 XML 1.0(SE)（https://www.w3.org/TR/2000/REC-XML-20001006）。
For the latest version, please look at https://www.w3.org/TR/REC-xml/

2) HTML（Hypertext Markup Language）
https://www.w3.org/TR/REC-html40-971218/
https://www.w3.org/TR/1998/REC-html40-19980424/
https://www.w3.org/TR/html4/

https://www.w3.org/TR/1999/REC-html401-19991224/
https://www.w3.org/TR/html401/

W3C 于 2008 年 1 月 22 日发布 HTML 5 工作草案。
http://www.w3.org/TR/html5/

For the latest version, please look at https://www.w3.org/TR/html/

3) XHTML
W3C 于 2000 年 1 月 26 日发布的 XHTML 1.0（https://www.w3.org/TR/2000/REC-xhtml1-20000126/）。
W3C 于 2002 年 8 月 1 日发布的 XHTML 1.0(SE)（https://www.w3.org/TR/2002/REC-xhtml1-20020801/）。
For the latest version, please look at https://www.w3.org/TR/xhtml1/

二、网页样式
1) CSS（Cascading Style Sheets）
1996 年 12 月，CSS 的第一个版本正式出版（https://www.w3.org/TR/REC-CSS1-961217）。
For the latest version, please look at https://www.w3.org/TR/CSS1/

1998 年 5 月，CSS2 版本正式出版（https://www.w3.org/TR/1998/REC-CSS2-19980512/）。
For the latest version, please look at https://www.w3.org/TR/CSS2/

For the latest version, please look at https://www.w3.org/TR/CSS/

三、网页行为
1) DOM（Document Object Model）
W3C DOM 规范（https://www.w3.org/DOM/）
2) BOM（Browser Object Model）

3) ECMAScript
目前使用最广泛的是 ECMAScript 262，也即 JavaScript 5.0 版本，参考地址为：http://www.ecma-international.org/publications/standards/Ecma-262.htm。


JavaScript 是由 ECMAScript，DOM 和 BOM 三者组成的。

ECMASCRIPT 定义了javascript的语法规范,描述了语言的基本语法和数据类型；
DOM 和 BOM 是由浏览器实现的。

一个 HTML 标签对应 DOM 中的 Element。
当浏览器解析网页时，将 HTML 特性映射为了 DOM 属性。[HTML attribute 和 DOM property · Issue #15](https://github.com/justjavac/the-front-end-knowledge-you-may-not-know/issues/15)














【浏览器兼容性问题】

HTML兼容
CSS兼容
JavaScript兼容

1. HTML兼容
低版本浏览器不能识别一些高版本浏览器使用的标签。比如HTML5新增的标签。

2. CSS兼容

浏览器引擎前缀(vendor-prefix)
Gecko: -moz-
Webkit: -webkit-
Trident: -ms-
KHTML: -khtml-
Presto: -o-

问题一：不同浏览器的标签默认的外补丁(margin)和内补丁(padding)不同
问题二：IE6下margin值双倍边距问题
问题三：height值设置过小问题
问题四：标签min-height属性不兼容问题
问题五：图片元素img下默认有间距
问题六：opacity多浏览器透明度兼容问题
问题七：Firefox和Chrome不兼容cursor:hand
问题八：IE6的3px Bug

3. JavaScript兼容




IE6、7、8不支持HTML5、CSS3、SVG标准，可被判定为“极难兼容”
IE9不支持Flex、Web Socket、WebGL，可被判定为“较难兼容”
IE10部分支持Flex（-ms-flexbox）、Web Socket，可被判定为“较易兼容”
IE11部分支持Flex、WebGL，可被判定为“较易兼容”

IE6、7、8、9可视为“老式浏览器”

IE10、11可视为“准现代浏览器”

Chrome、Firefox、Safari、Opera 、Edge可视为“现代浏览器”



【前端里程碑框架】
这些框架代表了前端应用当时先进、成熟、主流的开发方式与发展方向，兼容性问题也在这些框架的基础之上不断得到解决，大致也分为三个阶段：

一、DOM操作框架，代表框架：jQuery

jQuery是DOM操作时代前端框架最优秀，也几乎是唯一代表；但是在以React为代表的新式前端框架崛起之后，迅速没落。

JQuery 1.x兼容IE6+浏览器
JQuery 2.x兼容IE9+浏览器
JQuery 3.x兼容IE9+浏览器

二、响应式框架，代表框架：Bootstrap

Bootstrap是最经典的响应式CSS框架，其核心是16列布局栅格系统，使用媒体查询设定阈值为超小屏幕，小屏幕，中等屏幕，大屏幕，超大屏幕创建不同的样式。

Bootstrap 2兼容IE7+浏览器
Bootstrap 3兼容IE8+浏览器
Bootstrap 4兼容IE10+浏览器
Bootstrap 5不兼容IE浏览器

三、前端MVC框架，代表框架：React、Angular、Vue





【框架】
HTML5 Boilerplate
单纯的十分完善的移动终端友好的HTML模版，完善到所有的页面似乎都应该遵守这个规则。
normalize，一个支持HTML5的css reset
jQuery
Modernizr，一个强大的浏览器特性监测工具
一组 Apache 配置参数，帮你提高网站的性能
还提供了一些文件，比如apache的配置htaccess、 404页面、flash跨域需要的文件crossdomain.xml、爬虫过滤文件robots.txt等，可以按需使用。








【Web APIs】
Document Object Model
DOM是一种API，它允许访问和修改当前文档。 它允许操纵文档Node和Element。 HTML，XML和SVG对其进行了扩展以操纵其特定元素。


Device APIs
这组API允许访问网页和应用程序可用的各种硬件功能。 例如 环境光传感器 Ambient Light Sensor API，地理位置 Geolocation API，指针锁定 Pointer Lock API，接近度 Proximity API，设备方向 Device Orientation API，屏幕方向 Screen Orientation API，振动 Vibration API。


Communication APIs
这些API使网页和应用程序可以与其他页面或设备进行通信。 例如 Network Information API，Web Notifications API，Simple Push API。


Data management APIs
可以使用这组API来存储和管理用户数据。 例如。 FileHandle API，IndexedDB。



【SVG APIs】
可伸缩矢量图形（Scalable Vector Graphics）是一种基于XML的标记语言，用于描述基于二维的矢量图形。
因此，这是一个基于文本的开放式Web标准，用于描述可以清晰地呈现任意大小的图像，并且专门设计用于与其他Web标准（包括CSS，DOM，JavaScript和SMIL）良好地配合使用。
SVG本质上是图形，而HTML是文本。


【MathML APIs】
数学标记语言（MathML）是XML的一种方言，用于描述数学符号并捕获其结构和内容。

