## JSP

注释
显示注释（客户端看得到）<!--xxx-->Html注释
隐式注释（客户端看不到）单行//xxx	多行/*xxx*/	JSP注释<%--xxx--%>

Scriptlet(脚本小程序)
<%	%>	定义局部变量、编写语句等---输出变量、对象，调用方法
<%!	%>	定义全局变量、方法、类等---尽量不在jsp中定义类或者方法---通过JavaBean的形式调用
<%=	%>	输出一个变量或者具体的常量---表达式输出---替代out.println()

Scriptlet标签	同<%	%>
<jsp:scriptlet>java scriptlet代码</jsp:scriptlet>必须完结标签


Page指令	常用的4个	contentType	pageEncoding	errorPage/isErrorPage	import
<%@ page 属性="内容"%>
.jsp通过pageEncoding指定的编码生成utf-8的.java-->..内部统一是utf-8-->>>Tomcat容器根据contentType的charset
执行生成html
pageEncoding是jsp文件本身的编码 

contentType的charset是指服务器发送给客户端时的内容编码

在JSP标准的语法中，如果pageEncoding属性存在，那么JSP页面的字符编码方式就由pageEncoding决定，否则就由contentType属性中的charset决定，如果charset也不存在，JSP页面的字符编码方式就采用默认的ISO-8859-1。


包含指令
静态包含<%@ include file="路径"%>	完整页面 有些标签只能出现一次<html>/<head>/<title>/<body>/
动态包含
	传参<jsp:include page="路径"% flush="true"/>
	不传参<jsp:include page="路径" flush="true"%>...</jsp:include>

跳转指令 同动态包含forward替换include 


JSP内置对象
-->9个内置对象
	request		服务器获得客户端相关信息
	response	
	cookie
	session		完成用户登录注销
	application	this.getServletContext()代替
	exception
	config		getInitParameter()获得初始化配置参数
	out
	pageContext

-->4种属性范围	支持操作:void setAttribute("name", Object o);Object getAttribute("name");void removeAttribute("name")
	page(pageContext)	本页面保存属性、跳转后无效
	request			只在一次请求中保存属性,服务器跳转后依然有效
	session			一次会话中保存属性，跳转无影响，但新开浏览器无法使用
	application		整个服务器上保存，所有用户使用 服务器重启则设置的属性消失



Expression Language(EL)表达式语言	${属性名称}	取不到值自动为""
4种属性范围	page(pageContext)-->request---->session----->application
多个内置对象	pageScope	requestScope	sessionScope applicationScope	...

request接受参数
输出集合用下标

运算符5算术6关系3逻辑




JSP标准标签库(JSTL)//至于项目lib文件夹下使用
NO	JSTL		标记名称	标签配置文件	描述
1	核心标签库	c		c.tld		定义了属性管理、迭代、判断、输出
2	SQL标签库	sql		sql.tld		定义了查询数据库操作
3	XML标签库	xml		x.tld		用于操作xml数据
4	函数标签库	fn		fn.tld		函数
5	I18N格式标签库	fmt		fmt.tld		格式化数据


style="cursor:pointer"

JSP 
${pageContext.request.contextPath}项目名称
request.getContextPath()