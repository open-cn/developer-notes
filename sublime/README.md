## Sublime Text

http://www.sublimetext.com/download

### 安装 package control

https://packagecontrol.io/installation

View => Show Console

'6f4c264a24d933ce70df5dedcf1dcaee ebe013ee18cced0ef93d5f746d80ef60'
'817937144c34c84c88cd43b85318b26 56f9c3fac02f8f72cbc18360b2c26d139'

SUBLIME TEXT 3
```python
import urllib.request,os,hashlib; h = '817937144c34c84c88cd43b85318b26' + '56f9c3fac02f8f72cbc18360b2c26d139'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
```

SUBLIME TEXT 2
```python
import urllib2,os,hashlib; h = '6f4c264a24d933ce70df5dedcf1dcaee' + 'ebe013ee18cced0ef93d5f746d80ef60'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); os.makedirs( ipp ) if not os.path.exists(ipp) else None; urllib2.install_opener( urllib2.build_opener( urllib2.ProxyHandler()) ); by = urllib2.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); open( os.path.join( ipp, pf), 'wb' ).write(by) if dh == h else None; print('Error validating download (got %s instead of %s), please try manual install' % (dh, h) if dh != h else 'Please restart Sublime Text to finish installation')
```

### 安装插件

1. Preferences => Package Control -> install package
2. 组合键 Ctrl+Shift+P 调出命令面板

#### 主题皮肤

在设置一个新的主题时，需要设置theme和color_scheme两个方面，前者决定了打开不同类型文件的配色，后者决定了Tab栏，SideBar大小和图标，以及相应字体的大小设置。

- Preferences => Color Scheme...
- Preferences => Theme...

##### Spacegray

3种不同深度的颜色，可以定义Tab的大小，SideBar字体大小，文件之间的间隔大小。

##### Material Theme

##### Predawn

一款为Sublime和Atom打造的暗色主题，可以定义Tab的大小，SideBar大小，Find栏大小，为Markdown高亮着色，并提供主题同款的ICON。

#### gbk 编码支持
CovertToUTF8 + Codecs33
或者
gbk support


convert 好像不能转换gbk 或者 utf-8

#### SideBarEnhancements

扩展文件右键菜单，侧边栏显示已打开的文件列表

#### Bracket Highlighter

匹配各种左括号和右括号，例如：[], (), {}, "", '', <tag></tag>，以及自定义括号和标签。

#### markdown
sublime自带的markdown语法高亮并不是很友好，推荐安装Markdown Editing

安装完成后点击右下角或者在视图 => 语法=>MarkdownEditing->三种风格，分别是Standard Markdown，GitHub flavored Markdown，MultiMarkdown。

Markdown Editing并不只是一个markdown的主题插件，它自定义许多markdown的快捷键。

##### markdown GFM 配置
```json
{
    "extensions":
    [
        "md",
        "mdown"
    ],
    "color_scheme": "Packages/MarkdownEditing/MarkdownEditor-Dark.tmTheme",

    // Layout
    "draw_centered": false,
    "word_wrap": true,
    "wrap_width": 120,
    "rulers": [],

    // Line
    "line_numbers": true,
    "highlight_line": true,

    "mde.keep_centered": true,  // 可以保持你正在编辑的行始终处于屏幕的中间
}
```

#### markdown 预览
可以选择Markdown Preview或MarkdownLivePreview。

Markdown Preview不能实时预览，但你可以设置快捷键让它在浏览器中预览，在首选项=> 快捷键设置里添加
{ "keys": ["alt+m"], "command": "markdown_preview", "args": {"target": "browser", "parser":"markdown"} },


MarkdownLivePreview可以实现实时预览，在首选项->Package Setting里修改MarkdownLivePreview的user配置文件，设置在打开时同步预览
"markdown_live_preview_on_open": true

但是，这个插件的预览效果并不理想，很丑，而且不能横向滚动，也就是说如果一行显示不过来那你就看不到了。而且装上它后虽然可以实时预览，但不知道因为什么原因输入的时候会有些卡。

#### 图片粘贴
imagepaste

该插件存在一些问题，比如生成的图片质量不如直接保持的图片文件

#### SublimeREPL

SublimeREPL 可以直接在编辑器中运行一个解释器，支持很多语言：
Clojure, CoffeeScript, F#, Groovy, Haskell, Lua, MozRepl, NodeJS, Python, R, Ruby, Scala, shell

#### 文件对比

##### sublimerge

需要激活sublime

##### Compare Side-By-Side



### 安装FAQ

#### Unable to download XXX
Preferences =>Package Settings => Package Control => Settings - User

```json
{
    "bootstrapped": true,
    "debug": true,
    "installed_packages":
    [
        "Codecs33",
        "ConvertToUTF8",
        "GBK Support",
        "MarkdownEditing",
        "Material Theme",
        "Package Control",
        "Predawn",
        "SideBarEnhancements",
        "Theme - Spacegray"
    ],
    "downloader_precedence": {
        "windows": ["wininet"],
        "osx": ["curl", "urllib"],
        "linux": ["curl", "urllib", "wget"]
    },
}
```
清空 in_process_packages，还是 downloader_precedence + curl


### Sublime 配置
在Sublime Text3中，所有Default代码都不能直接更改，而是要在User里面把要更改的代码复制过来再进行更改，这是与之前版本不同的地方。

```json Packages/User/Preferences.sublime-settings
{
      "theme": "predawn-DEV.sublime-theme",
      "color_scheme": "Packages/Predawn/predawn.tmTheme",
       "ignored_packages":
       [
               "Markdown",
               "Vintage"
       ],
       "show_encoding": true,  // 显示编码
       "show_git_status": false, // 显示 git 状态

       "soda_classic_tabs": true,

       "highlight_line": true, // 高亮正在编辑的行
       "line_numbers": true,   // 显示行号

       "tab_size": 4,          // tab宽度
       "translate_tabs_to_spaces": true,   // tab转换为空格
       "trim_trailing_white_space_on_save": true,  // 保存时去掉行尾空格

       "word_wrap": true,      // 自动换行
       "wrap_width": "auto",    // 换行的宽度，默认80会造成左侧大量留白
}
```

Settings Syntax Specific  

```json Packages/User/Markdown.sublime-settings
{
       // "color_scheme": "Packages/Predawn/predawn-markdown.tmTheme",
       "extensions":
       [
               "md",
               "mdown"
       ],
       "mde.keep_centered": false,
       "rulers":
       [
       ],
       "highlight_line": true, // 高亮正在编辑的行
       "translate_tabs_to_spaces": true,   // tab转换为空格
       "trim_trailing_white_space_on_save": true,  // 保存时去掉行尾空格
}
```

Settings Distraction Free Mode

```json Packages/User/Distraction Free.sublime-settings
{
       "line_numbers": false,　　// 是否显示行
       "gutter": false,　　　　 　// 是否显示行高亮光标
       "draw_centered": true,　　// 是否在中央绘制，为false的话
       "wrap_width": 80,　　　　  // 自动换行宽度
       "word_wrap": true,　　　　 // 是否自动换行
       "scroll_past_end": true,  // 是否滚动到超出文本范围的区域。
}
```

### Sublime 快捷键

#### 多行编辑
鼠标选中多行，按下 Ctrl Shift L (Command Shift L) 即可同时编辑这些行；

鼠标选中文本，反复按 CTRL D (Command D) 即可继续向下同时选中下一个相同的文本进行同时编辑；

鼠标选中文本，按下 Alt F3 (Win) 或 Ctrl Command G(Mac) 即可一次性选择全部的相同文本进行同时编辑；

Shift 鼠标右键 (Win) 或 Option 鼠标左键 (Mac) 或使用鼠标中键可以用鼠标进行竖向多行选择；

Ctrl 鼠标左键(Win) 或 Command 鼠标左键(Mac) 可以手动选择同时要编辑的多处文本



