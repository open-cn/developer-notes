## Sublime Text

### 安装 package control
https://packagecontrol.io/installation  
View => Show Console

'6f4c264a24d933ce70df5dedcf1dcaee ebe013ee18cced0ef93d5f746d80ef60'
'817937144c34c84c88cd43b85318b26
56f9c3fac02f8f72cbc18360b2c26d139'

SUBLIME TEXT 3
import urllib.request,os,hashlib; h = '817937144c34c84c88cd43b85318b26' + '56f9c3fac02f8f72cbc18360b2c26d139'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)


SUBLIME TEXT 2
import urllib2,os,hashlib; h = '6f4c264a24d933ce70df5dedcf1dcaee' + 'ebe013ee18cced0ef93d5f746d80ef60'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); os.makedirs( ipp ) if not os.path.exists(ipp) else None; urllib2.install_opener( urllib2.build_opener( urllib2.ProxyHandler()) ); by = urllib2.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); open( os.path.join( ipp, pf), 'wb' ).write(by) if dh == h else None; print('Error validating download (got %s instead of %s), please try manual install' % (dh, h) if dh != h else 'Please restart Sublime Text to finish installation')


### 安装插件
1. Preferences => Package Control -> install package
2. 组合键 Ctrl+Shift+P 调出命令面板

#### 设置 Sublime Text 3 主题皮肤
输入Spacegray.安装完成后在Preferrences->Color Scheme选择主题

#### gbk 编码支持
CovertToUTF8 + Codecs33
或者
gbk support


convert 好像不能转换gbk 或者 utf-8

#### markdown 支持
sublime自带的markdown语法高亮并不是很友好,推荐安装Markdown Editing

安装完成后点击右下角或者在视图 => 语法=>MarkdownEditing->三种风格,分别是Standard Markdown, GitHub flavored Markdown, MultiMarkdown.

Markdown Editing并不只是一个markdown的主题插件,它自定义许多markdown的快捷键


#### markdown 预览支持
可以选择Markdown Preview或MarkdownLivePreview.

Markdown Preview不能实时预览,但你可以设置快捷键让它在浏览器中预览,在首选项=> 快捷键设置里添加
{ "keys": ["alt+m"], "command": "markdown_preview", "args": {"target": "browser", "parser":"markdown"} },


MarkdownLivePreview可以实现实时预览,在首选项->Package Setting里修改MarkdownLivePreview的user配置文件,设置在打开时同步预览
"markdown_live_preview_on_open": true

但是,这个插件的预览效果并不理想,很丑,而且不能横向滚动,也就是说如果一行显示不过来那你就看不到了.而且装上它后虽然可以实时预览,但不知道因为什么原因输入的时候会有些卡.

#### 图片粘贴支持
imagepaste

该插件存在一些问题，比如生成的图片质量不如直接保持的图片文件

### Unable to download XXX
Preferences =>Package Settings => Package Control => Settings - User
{
	"bootstrapped": true,
	"debug": true,
	"installed_packages":
	[
		"Codecs33",
		"ConvertToUTF8",
		"GBK Support",
		"Package Control"
	],
	"downloader_precedence": {
		"windows": ["wininet"],
		"osx": ["curl", "urllib"],
		"linux": ["curl", "urllib", "wget"]
	},
}
清空 in_process_packages，还是 downloader_precedence + curl


### Sublime 配置
在Sublime Text3中,所有Default代码都不能直接更改，而是要在User里面把要更改的代码复制过来再进行更改,这是与之前版本不同的地方.

{
	"color_scheme": "Packages/MarkdownEditing/MarkdownEditor-Dark.tmTheme",
	"highlight_line": true,
	"ignored_packages":
	[
		"Markdown",
		"Vintage"
	],
	"show_encoding": true,
	"show_git_status": false,
	"soda_classic_tabs": true,
	"theme": "Soda Dark 3.sublime-theme"
}



