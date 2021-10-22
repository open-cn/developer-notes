CSS

【CSS 浏览器兼容】

一、浏览器CSS样式初始化
由于每个浏览器的css默认样式不尽相同，所以最简单有效的方式就是对其进行重新初始化。

推荐一个库，Normalize.css，github star数量接近4万，https://github.com/necolas/normalize.css/


二、浏览器私有属性    浏览器引擎前缀(vendor-prefix)
让用户体验 CSS3 的新特性。例如，
Webkit 类型浏览器（如 Safari、Chrome）的私有属性是以-webkit-前缀开始，
Gecko 类型的浏览器（如 Firefox）的私有属性是以-moz-前缀开始，
Konqueror 类型的浏览器的私有属性是以-khtml-前缀开始，
Opera 浏览器的私有属性是以-o-前缀开始，
而 Internet Explorer 浏览器的私有属性是以-ms-前缀开始（目前只有 IE 8+ 支持-ms-前缀）。


最好是把带有各种前缀的写法放在前面，然后把不带前缀的标准的写法放到最后。
-moz-     /* 火狐等使用Mozilla浏览器引擎的浏览器 */
-webkit-  /* Safari, 谷歌浏览器等使用Webkit引擎的浏览器 */
-o-       /* Opera浏览器(早期) */
-ms-      /* Internet Explorer (不一定) */


Internet Explorer 9 开始支持很多(但并不是全部)CSS3里的新属性。
IE6到IE8都不支持CSS3。所以，确保你的网站设计在不支持CSS3的情况下也能正常显示。对于一些属性：border-radius , linear-gradient, 和 box-shadow, 你可以使用CSS3Pie，它是一个很小的文件，把它放到你的网站的根目录下，就能让你的页面中IE6，IE8中也支持这些属性。


三、CSS hack

条件hack
属性级hack
选择符级hack


四、自动化插件
Autoprefixer是一款自动管理浏览器前缀的插件，它可以解析CSS文件并且添加浏览器前缀到CSS内容里，使用Can I Use（caniuse网站）的数据来决定哪些前缀是需要的。








html5shiv.js

IE6~IE8识别HTML5标签，并且可以添加CSS样式。

respond.js

使IE6~IE8浏览器支持媒体查询。








