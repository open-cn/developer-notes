## database
数据库

当您想收听自己喜欢的歌曲时，可以通过智能手机打开播放列表。在这种情况下，播放列表是数据库。

当您拍摄照片并将其上传到微博等社交网络上的帐户时，您的照片库就是一个数据库。

当您浏览电子商务网站购买鞋子，衣服等时，您使用购物车数据库。

数据库无处不在。什么是数据库？根据定义，数据库仅仅是结构化的数据集合。

数据本质上彼此相关，例如，属于产品类别并且与多个标签相关联的产品。因此，我们使用术语关系数据库。

在关系数据库中，我们使用表格对产品，类别，标签等数据进行建模。表包含列和行。它就像一个电子表格。

表可以涉及使用关系的另一个表，例如，一对一和一对多关系。

因为我们处理大量数据，所以我们需要一种方法来定义数据库，表格等，并更有效地处理数据。此外，我们希望将数据转化为信息。

这就是SQL发挥作用的地方。

### SQL

SQL - 数据库的语言

- SQL代表结构化查询语言。SQL是用于访问数据库的标准化语言。SQL是用于在数据库中存储，操作和检索数据的标准语言。
- SQL允许您访问和操作数据库。
- SQL于1986年成为美国国家标准化组织（American National Standards Institute, ANSI）的标准，并于1987年成为国际标准化组织（ISO）的标准。

SQL (Structured Query Language:结构化查询语言) 是用于管理关系型数据库管理系统（Relational Database Management System, RDBMS）。 SQL 的范围包括数据插入、查询、更新和删除，数据库模式创建和修改，以及数据访问控制。

自 1999 年以来，SQL 不再局限于关系模型。

适应于数据库有：MySQL，SQL Server，MS Access，Oracle，Sybase，Informix，Postgres和其他数据库系统。

虽然SQL是ANSI / ISO标准，但SQL语言有不同的版本。但是，为了符合ANSI标准，它们都以类似的方式支持主要命令（例如SELECT，UPDATE，DELETE，INSERT，WHERE）。

SQL 有两个主要的标准，分别是 SQL-92 和 SQL-99。92和99代表了标准提出的时间。除此以外，还存在 SQL-86、SQL-89、SQL:2003、SQL:2008、SQL:2011 和 SQL:2016等标准。

一般来说 SQL-92 的形式更简单，但是写的 SQL 语句会比较长，可读性较差。而 SQL-99相比于 SQL-92 来说，语法更加复杂，但可读性更强。SQL-92 的标准有 500页，而 SQL-99 标准超过了 1000 页。

2016年12月14日，ISO/IEC发布了最新版本的数据库语言SQL标准（ISO/IEC 9075:2016）。从此，它替代了之前的ISO/IEC 9075:2011版本。

SQL：2016标准分为9个部分：

ISO/IEC 9075-1 信息技术 – 数据库语言 – SQL – 第1部分：框架（SQL/框架）
ISO/IEC 9075-2 信息技术 – 数据库语言 – SQL – 第2部分：基本原则（SQL/基本原则）
ISO/IEC 9075-3 信息技术 – 数据库语言 – SQL – 第3部分：调用级接口（SQL/CLI）
ISO/IEC 9075-4 信息技术 – 数据库语言 – SQL – 第4部分：持久存储模块（SQL/PSM）
ISO/IEC 9075-9 信息技术 – 数据库语言 – SQL – 第9部分：外部数据管理（SQL/MED）
ISO/IEC 9075-10 信息技术 – 数据库语言 – SQL – 第10部分：对象语言绑定（SQL/OLB）
ISO/IEC 9075-11 信息技术 – 数据库语言 – SQL – 第11部分：信息与定义概要（SQL/Schemata）
ISO/IEC 9075-13 信息技术 – 数据库语言 – SQL – 第13部分：使用Java编程语言的SQL程序与类型（SQL/JRT）
ISO/IEC 9075-14 信息技术 – 数据库语言 – SQL – 第14部分：XML相关规范（SQL/XML）

SQL:2016中主要的新特性包括：

- 行模式识别（row pattern recognition）：使用MATCH_RECOGNIZE子句指定一个匹配多行的模式（正则表达式），可以对这些匹配的行组进行过滤、分组和聚合操作。MATCH_RECOGNIZE支持两种形式：ONE ROW PER MATCH和ALL ROWS PER MATCH。ONE ROW PER MATCH对于每次匹配返回单行摘要，而ALL ROWS PER MATCH对于每次匹配中的每一行数据返回一行输出。行模式匹配可以用于分析时间序列数据，例如股票行情收录器日志或事件日志。
- 支持JSON对象：
    1. JSON对象的存储与检索
    2. 将JSON对象表示成SQL数据
    3. 将SQL数据表示成JSON对象
- 多态表函数（Polymorphic Table Functions, PTF）：一种用户定义的函数，可以在FROM子句中使用。它们可以处理在定义时没有声明行的类型的表，也可以生成一个在定义时声明了或者没有声明行的类型的结果表。
- 额外的分析功能：包括三角函数和对数函数。增加的三角函数包括`sin`、`cos`、`tan`、`sinh`、`cosh`、`tanh`、`asin`、`acos`以及`atan`。对数函数包括一般对数函数`log(<base>, <value>)`、常用对数函数`log10(<value>)`和自然对数函数`ln(<value>)`。

#### SQL 主机

如果您希望您的网站能够存储和检索数据库中的数据，您的Web服务器应该可以访问使用SQL语言的数据库系统。

如果您的Web服务器由Internet服务提供商（ISP）托管，则必须查找SQL主机方案。

最常见的SQL托管数据库是MS SQL Server，Oracle，MySQL和MS Access。

##### MS SQL Server
Microsoft的SQL Server是一种流行的数据库软件，适用于流量较大的数据库驱动的网站。

##### Oracle
Oracle也是一种流行的数据库软件，适用于流量较大的数据库驱动的网站。

##### MySQL
MySQL也是一种流行的网站数据库软件。MySQL是昂贵的Microsoft和Oracle解决方案的廉价替代品。

MySQL服务器最初是为小型计算机系统上中等规模的数据库设计的（100万-1亿行，或每个表的大小为100MB）。目前，MySQL服务器能处理TB级别的数据库，也能在针对便携式设备或嵌入式设备的精简版本中使用。MySQL服务器的精简设计使得双向开发成为可能，不会在源码树中产生任何冲突。

MySQL遵从的标准是什么？

我们致力于支持全套ANSI/ISO SQL标准，但不会以牺牲代码的速度和质量为代价。ODBC级别0-3.51。

##### Access
当网站只需要一个简单的数据库时，Microsoft Access可以是一个解决方案。访问不适合非常高的流量，也不像MySQL，SQL Server或Oracle那样强大。

#### 数据类型

##### MySQL数据类型（8.0版）
在MySQL中有三种主要的数据类型：字符串，数字，日期和时间。

**字符串类型**

CHAR(size)	一个固定长度字符串（可以包含字母，数字和特殊字符）。 size参数以字符为单位指定列长度 - 可以是0到255.默认值为1
VARCHAR(size)	保存可变长度的字符串（可以包含字母，数字和特殊字符）。 size参数指定字符的最大列长度 - 可以是0到65535
BINARY(size)	等于CHAR()，但存储二进制字节字符串。 size参数指定列长度（以字节为单位）。 默认值为1
VARBINARY(size)	等于VARCHAR（），但存储二进制字节字符串。 size参数指定最大列长度（以字节为单位）。
TINYBLOB	对于BLOB（二进制大对象）。 最大长度：255个字节
TINYTEXT	包含最大长度为255个字符的字符串
TEXT(size)	保存最大长度为65,535字节的字符串
BLOB(size)	对于BLOB（二进制大对象）。 最多可容纳65,535个字节的数据
MEDIUMTEXT	保存最大长度为16,777,215个字符的字符串
MEDIUMBLOB	对于BLOB（二进制大对象）。 最多可容纳16,777,215字节的数据
LONGTEXT	保存最大长度为4,294,967,295个字符的字符串
LONGBLOB	对于BLOB（二进制大对象）。 最多可容纳4,294,967,295字节的数据
ENUM(val1, val2, val3, ...)	一个字符串对象，只能有一个值，从可能值列表中选择。 您可以在ENUM列表中列出最多65535个值。 如果插入的值不在列表中，则将插入空值。 值按您输入的顺序排序
SET(val1, val2, val3, ...)	一个字符串对象，可以包含0个或更多值，从可能值列表中选择。 您可以在SET列表中列出最多64个值数字数据类型：

**数字类型**

BIT(size)	位值类型。 每个值的位数以大小指定。 size参数可以包含1到64之间的值.size的默认值为1。
TINYINT(size)	一个非常小的整数。 有符号范围是-128到127.无符号范围是0到255. size参数指定最大显示宽度（255）
BOOL	零被视为假，非零值被视为真。
BOOLEAN	等同 BOOL
SMALLINT(size)	一个小整数。 有符号范围是-32768到32767.无符号范围是0到65535. size参数指定最大显示宽度（255）
MEDIUMINT(size)	中等整数。 有符号范围是-8388608到8388607.无符号范围是0到16777215. size参数指定最大显示宽度（255）
INT(size)	中等整数。 有符号范围从-2147483648到2147483647.无符号范围是0到4294967295. size参数指定最大显示宽度（255）
INTEGER(size)	等同 INT(size)
BIGINT(size)	一个大整数。 符号范围为-9223372036854775808至9223372036854775807.无符号范围为0至18446744073709551615.Thesize参数指定最大显示宽度（255）
FLOAT(size, d)	浮点数。 总数位数以大小指定。 小数点后的位数在d参数中指定。 MySQL 8.0.17中不推荐使用此语法，将来的MySQL版本将删除它
FLOAT(p)	浮点数。 MySQL使用p值来确定是否对结果数据类型使用FLOAT或DOUBLE。 如果p为0到24，则数据类型变为FLOAT（）。 如果p是25到53，则数据类型变为DOUBLE（）
DOUBLE(size, d)	正常大小的浮点数。 总数位数以大小指定。 小数点后的位数在d参数中指定
DOUBLE PRECISION(size, d)	
DECIMAL(size, d)	一个确切的定点数。 总数位数以大小指定。 小数点后的位数在d参数中指定。 大小的最大数量为65. d的最大数量为30. size的默认值为10.d的默认值为0。
DEC(size, d)	等同 DECIMAL(size,d)
注意：所有数字数据类型都可能有一个额外选项：UNSIGNED或ZEROFILL。如果添加UNSIGNED选项，MySQL将禁止该列的负值。如果添加ZEROFILL选项，MySQL会自动将UNSIGNED属性添加到列中。

8bit 表示-128到127 0-255
hex 2位 16x16=256
0x00000000 8位 32bit 10进制最大为 2147483647\*2 10位数字 正负21亿或42亿
0x00000000000000000 16位 64bit 10进制最大为 9223372036854775807\*2 19位数字 九百亿亿；无符号20位数字一千八百亿亿。


**日期和时间数据类型**

DATE	日期。格式：YYYY-MM-DD。支持的范围从'1000-01-01'到'9999-12-31'
DATETIME（fsp）	日期和时间组合。格式：YYYY-MM-DD hh：mm：ss。支持的范围是从“1000-01-01 00:00:00”到“9999-12-31 23:59:59”。在列定义中添加DEFAULT和ON UPDATE以自动初始化并更新到当前日期和时间
TIMESTAMP（fsp）	时间戳。TIMESTAMP值存储为自Unix纪元（'1970-01-01 00:00:00'UTC）以来的秒数。格式：YYYY-MM-DD hh:mm:ss。支持的范围是从'1970-01-01 00:00:01'UTC到'2038-01-09 03:14:07'UTC。可以使用列定义中的DEFAULT CURRENT_TIMESTAMP和ON UPDATE CURRENT_TIMESTAMP来指定自动初始化和更新到当前日期和时间
TIME（fsp）	时间。格式：hh:mm:ss。支持范围从'-838:59:59'到'838:59:59'
YEAR	一年四位数格式。范围是：1901到2155和0000.
8.0不支持两位数格式的年份。


##### SQL Server数据类型

**字符串类型**

| 数据类型       | 描述                      | 最大值             | 存储                      |
| -------------- | ------------------------- | ------------------ | ------------------------- |
| char(n)        | 固定字符                  | 8,000 字符         | Defined width             |
| varchar(n)     | 可变字符串                | 8,000 字符         | 2 bytes + number of chars |
| varchar(max)   | 可变字符串                | 1,073,741,824 字符 | 2 bytes + number of chars |
| text           | 可变字符串                | 2GB 文本数据       | 4 bytes + number of chars |
| nchar          | 固定长度的 Unicode 字符串 | 4,000 字符         | Defined width x 2         |
| nvarchar       | 可变长度的 Unicode 字符串 | 4,000 字符         |                           |
| nvarchar(max)  | 可变长度的 Unicode 字符串 | 536,870,912 字符   |                           |
| ntext          | 可变长度的 Unicode 字符串 | 2GB 文本数据       |                           |
| binary(n)      | 固定长度的二进制字符串。  | 8,000 字节         |                           |
| varbinary      | 可变长度的二进制字符串    | 8,000 字节         |                           |
| varbinary(max) | 可变长度的二进制字符串    | 2GB                |                           |
| image          | 可变长度的二进制字符串    | 2GB                |                           |

**数字类型**

bit          允许 0、1 或 NULL          
tinyint      允许从 0 到 255 的所有数字。存储 1 字节      
smallint     允许介于 -32,768 与 32,767 的所有数字。存储 2 字节      
int          允许介于 -2,147,483,648 与 2,147,483,647 的所有数字。存储 4 字节      
bigint       允许介于 -9,223,372,036,854,775,808 与 9,223,372,036,854,775,807 之间的所有数字。存储 8 字节      
decimal(p,s) 固定精度和比例的数字。允许从 -10^38 +1 到 10^38 -1 之间的数字。

p 参数指示可以存储的最大位数（小数点左侧和右侧）。p 必须是 1 到 38 之间的值。默认是 18。
s 参数指示小数点右侧存储的最大位数。s 必须是 0 到 p 之间的值。默认是 0。
存储 5-17 字节   

numeric(p,s) 固定精度和比例的数字。允许从 -10^38 +1 到 10^38 -1 之间的数字。

p 参数指示可以存储的最大位数（小数点左侧和右侧）。p 必须是 1 到 38 之间的值。默认是 18。
s 参数指示小数点右侧存储的最大位数。s 必须是 0 到 p 之间的值。默认是 0。
存储 5-17 字节   

smallmoney   介于 -214,748.3648 与 214,748.3647 之间的货币数据。存储 4 字节      
money        介于 -922,337,203,685,477.5808 与 922,337,203,685,477.5807 之间的货币数据。存储 8 字节      
float(n)     从 -1.79E + 308 到 1.79E + 308 的浮动精度数字数据。

n 参数指示该字段保存 4 字节还是 8 字节。float(24) 保存 4 字节，而 float(53) 保存 8 字节。n 的默认值是 53。
存储 4 or 8 字节 

real         从 -3.40E + 38 到 3.40E + 38 的浮动精度数字数据。存储 4 字节      

**日期和时间数据类型**

datetime	从 1753 年 1 月 1 日 到 9999 年 12 月 31 日，精度为 3.33 毫秒。	存储 8 字节
datetime2	从 1753 年 1 月 1 日 到 9999 年 12 月 31 日，精度为 100 纳秒。存储 6-8 字节
smalldatetime	从 1900 年 1 月 1 日 到 2079 年 6 月 6 日，精度为 1 分钟。存储 4 字节
date	仅存储日期。从 0001 年 1 月 1 日 到 9999 年 12 月 31 日。存储 3 字节
time	仅存储时间。精度为 100 纳秒。存储 3-5 字节
datetimeoffset	与 datetime2 相同，外加时区偏移。存储 8-10 字节
timestamp	存储唯一的数字，每当创建或修改某行时，该数字会更新。timestamp 值基于内部时钟，不对应真实时间。每个表只能有一个 timestamp 变量。	

**其他数据类型**

SQL_VARIANT	存储多达8,000个字节的各种数据类型的数据，text，ntext和timestamp除外
uniqueidentifier	存储全局唯一标识符（GUID）
XML	存储XML格式的数据。最大2GB
cursor	存储对用于数据库操作的游标的引用
table	存储结果集以供以后处理

**Microsoft Access数据类型**

Text	用于文本或文本和数字的组合。 最多255个字符	
Memo	备忘录用于大量文本。 最多可存储65,536个字符。 注意：您无法对备注字段进行排序。 但是，它们是可搜索的	
Byte	允许从0到255的整数 存储 1 字
Integer	允许-32,768到32,767之间的整数	存储 2 字节
Long	允许-2,147,483,648和2,147,483,647之间的整数 存储 4 字节
Single	单精度浮点。 将处理大多数小数 存储 4 字节
Double	双精度浮点。 将处理大多数小数 存储 8 字节
Currency	用于货币。 最多可容纳15位数的全数，加上4位小数。 提示：您可以选择要使用的国家的货币 存储 8 字节
AutoNumber	自动编号字段自动为每个记录提供自己的编号，通常从1开始 存储 4 字节
Date/Time	用于日期和时间 存储 8 字节
Yes/No	逻辑字段可以显示为是/否，真/假或开/关。 在代码中，使用常量True和False（相当于-1和0）。 注意：不允许空值 存储 1 字节
Ole Object	可以存储图片，音频，视频或其他BLOB（二进制大对象） 存储最大 1GB
Hyperlink	包含指向其他文件的链接，包括网页
Lookup Wizard	让您键入一个选项列表，然后可以从下拉列表中选择 存储 4 字节

#### SQL 语法

- SQL 可以对数据库执行查询
- SQL 可以从数据库中检索数据
- SQL 可以在数据库中插入记录
- SQL 可以更新数据库中的记录
- SQL 可以从数据库中删除记录
- SQL 可以创建新数据库
- SQL 可以在数据库中创建新表
- SQL 可以在数据库中创建存储过程
- SQL 可以在数据库中创建视图
- SQL 可以设置表、存储过程和视图的权限

一些最重要的 SQL 命令：

- SELECT - 从数据库中提取数据
- UPDATE - 更新数据库中的数据
- DELETE - 从数据库中删除数据
- INSERT INTO - 向数据库中插入新数据
- CREATE DATABASE - 创建新数据库
- ALTER DATABASE - 修改数据库
- CREATE TABLE - 创建新表
- ALTER TABLE - 变更（改变）数据库表
- DROP TABLE - 删除表
- CREATE INDEX - 创建索引（搜索键）
- DROP INDEX - 删除索引

某些数据库系统在每个SQL语句的末尾都需要一个分号。

分号是分隔数据库系统中每个SQL语句的标准方法，它允许在对服务器的同一调用中执行多个SQL语句。

```sql
# SELECT 语法
SELECT column1, column2, ...
FROM table_name; 

SELECT * FROM table_name; 

# SELECT DISTINCT 语法
SELECT DISTINCT column1, column2, ...
FROM table_name; 

SELECT COUNT(DISTINCT column1) FROM table_name; 

SELECT Count(*) 
FROM (SELECT DISTINCT column1 FROM table_name); 

# WHERE 语法
SELECT column1, column2, ...
FROM table_name
WHERE condition; 

# AND 语法
SELECT column1, column2, ...
FROM table_name
WHERE condition1 AND condition2 AND condition3 ...; 

# OR 语法
SELECT column1, column2, ...
FROM table_name
WHERE condition1 OR condition2 OR condition3 ...; 

# NOT 语法
SELECT column1, column2, ...
FROM table_name
WHERE NOT condition; 

# IS NULL语法
SELECT column_names
FROM table_name
WHERE column_name IS NULL; 

# IS NOT NULL语法
SELECT column_names
FROM table_name
WHERE column_name IS NOT NULL; 

# 排序语法
SELECT column1, column2, ...
FROM table_name
ORDER BY column1, column2, ... ASC|DESC; 

# 插入语法
# 如果要为表的所有列添加值，则无需在SQL查询中指定列名。但是，请确保值的顺序与表中的列的顺序相同。
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...); 

INSERT INTO table_name
VALUES (value1, value2, value3, ...); 

# 更新语法
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition; 

# 删除语法
DELETE FROM table_name WHERE condition; 

# SELECT TOP 语法
# SQL Server / MS Access：
SELECT TOP number|percent column_name(s)
FROM table_name
WHERE condition;

# MySQL：
SELECT column_name(s)
FROM table_name
WHERE condition
LIMIT number; 

# Oracle：
SELECT column_name(s)
FROM table_name
WHERE ROWNUM <= number; 

# TOP PERCENT 语法
SELECT TOP 50 PERCENT * FROM table_name; 

# MIN()语法
SELECT MIN(column_name)
FROM table_name
WHERE condition; 

# MAX()语法
SELECT MAX(column_name)
FROM table_name
WHERE condition; 

# COUNT()语法
SELECT COUNT(column_name)
FROM table_name
WHERE condition; 

# AVG()语法
SELECT AVG(column_name)
FROM table_name
WHERE condition; 

# SUM()语法
SELECT SUM(column_name)
FROM table_name
WHERE condition; 

# LIKE语法
SELECT column1, column2, ...
FROM table_name
WHERE columnN LIKE pattern; 

# IN语法
SELECT column_name(s)
FROM table_name
WHERE column_name IN (value1, value2, ...); 

SELECT column_name(s)
FROM table_name
WHERE column_name IN (SELECT STATEMENT); 

# BETWEEN语法
SELECT column_name(s)
FROM table_name
WHERE column_name BETWEEN value1 AND value2; 

# 别名列语法
SELECT column_name AS alias_name
FROM table_name; 

# 别名表语法
SELECT column_name(s)
FROM table_name AS alias_name; 

# JOINS 语法
# （INNER）JOIN：返回两个表中具有匹配值的记录
# LEFT（OUTER）JOIN：返回左表中的所有记录，以及右表中的匹配记录
# RIGHT（OUTER）JOIN：返回右表中的所有记录，以及左表中匹配的记录
# FULL（OUTER）JOIN：当左表或右表中匹配时返回所有记录
# INNER JOIN语法
SELECT column_name(s)
FROM table1
INNER JOIN table2 ON table1.column_name = table2.column_name; 

# LEFT JOIN 语法
SELECT column_name(s)
FROM table1
LEFT JOIN table2 ON table1.column_name = table2.column_name;

# RIGHT JOIN语法
SELECT column_name(s)
FROM table1
RIGHT JOIN table2 ON table1.column_name = table2.column_name; 

# FULL OUTER JOIN语法
SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2 ON table1.column_name = table2.column_name
WHERE condition; 

# Self JOIN 语法
SELECT column_name(s)
FROM table1 T1, table1 T2
WHERE condition; 

# UNION语法
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2; 

# UNION ALL语法
# UNION运算符默认情况下仅选择不同的值。要允许重复值，请使用UNION ALL：
SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2; 

# GROUP BY语法
# GROUP BY语句通常与聚合函数（COUNT，MAX，MIN，SUM，AVG）一起使用，将结果集分组为一列或多列
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s); 

# HAVING 语法
# 使用HAVING子句是因为WHERE关键字不能与聚合函数一起使用。
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);

# EXISTS 语法
SELECT column_name(s)
FROM table_name
WHERE EXISTS
(SELECT column_name FROM table_name WHERE condition);

# ANY 语法
SELECT column_name(s)
FROM table_name
WHERE column_name operator ANY
(SELECT column_name FROM table_name WHERE condition); 

# ALL 语法
SELECT column_name(s)
FROM table_name
WHERE column_name operator ALL
(SELECT column_name FROM table_name WHERE condition); 

# SELECT INTO语法
# 将所有列复制到新表中：
SELECT *
INTO newtable [IN externaldb]
FROM oldtable
WHERE condition; 

# 指定列复制到新表中：
SELECT column1, column2, column3, ...
INTO newtable [IN externaldb]
 FROM oldtable
WHERE condition; 

# INSERT INTO SELECT 语法
# 将所有列从一个表复制到另一个表：
INSERT INTO table2
SELECT * FROM table1
WHERE condition; 

# 仅将一个表中的某些列复制到另一个表中：
INSERT INTO table2 (column1, column2, column3, ...)
SELECT column1, column2, column3, ...
 FROM table1
WHERE condition; 

# CASE 语法
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;

# IFNULL()，ISNULL()，COALESCE()和NVL()函数
# MySQL IFNULL()函数允许您在表达式为NULL时返回备用值：
SELECT IFNULL(column1, 0) FROM table1;
# 或者使用COALESCE()函数
SELECT COALESCE(column1, 0) FROM table1;

# SQL Server ISNULL()函数允许您在表达式为NULL时返回备用值：
SELECT ISNULL(column1, 0) FROM table1;

# 如果表达式为空值，则MS Access IsNull()函数返回TRUE（-1），否则返回FALSE（0）：
SELECT IIF(ISNULL(column1), 0, column1) FROM table1;

# Oracle NVL()函数实现了相同的结果：
SELECT NVL(column1, 0) FROM table1; 

# 存储过程语法
CREATE PROCEDURE procedure_name
AS
sql_statement
GO; 

# 执行存储过程
EXEC procedure_name;

# SQL 注释
# 注释用于解释SQL语​​句的各个部分，或用于防止执行SQL语句。
# 单行注释以 - 开头。
# - 和 - 行之间的任何文本都将被忽略（不会被执行）。
--Select all:
ELECT * FROM table1 -- WHERE column1>0; 

# 多行注释以/*开头，以*/结尾。/*和*/之间的任何文本都将被忽略。
/*
xxx
 */

CREATE DATABASE databasename; 
DROP DATABASE databasename;

# 创建现有SQL数据库的完整备份。
BACKUP DATABASE databasename
TO DISK = 'filepath'; 

# 差异备份仅备份自上次完全数据库备份以来已更改的数据库部分。
BACKUP DATABASE databasename
TO DISK = 'filepath'
WITH DIFFERENTIAL; 

CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    column3 datatype,
  ....
); 
CREATE TABLE new_table_name AS
    SELECT column1, column2,...
    FROM existing_table_name
    WHERE ....; 
DROP TABLE table_name; 
TRUNCATE TABLE table_name;

ALTER TABLE table_name
ADD column_name datatype;

ALTER TABLE table_name
DROP COLUMN column_name; 

# ALTER TABLE - ALTER / MODIFY COLUMN
# 若要更改表中列的数据类型，请使用以下语法：
# SQL Server / MS Access：
ALTER TABLE table_name
ALTER COLUMN column_name datatype; 

# MySQL / Oracle（早期版本10G）：
ALTER TABLE table_name
MODIFY COLUMN column_name datatype; 

# Oracle 10G及更高版本：
ALTER TABLE table_name
MODIFY column_name datatype; 

# 约束
# SQL中通常使用以下约束：
# NOT NULL - 确保列不能为NULL值
# UNIQUE - 确保列中的所有值都不同（唯一值）
# PRIMARY KEY - NOT NULL和UNIQUE的组合。唯一标识表中的每一行
# FOREIGN KEY - 唯一标识另一个表中的行或记录
# CHECK - 确保列中的所有值都满足指定条件
# DEFAULT - 在未指定值时为列设置默认值
# INDEX - 用于非常快速地从数据库创建和检索数据
CREATE TABLE table_name (
    column1 datatype NOT NULL,
    column2 datatype DEFAULT 0,
    column3 datatype constraint,
    column4 datatype constraint,
    -- 要命名UNIQUE约束，并在多个列上定义UNIQUE约束，请使用以下SQL语法：
    CONSTRAINT constname UNIQUE (column1,column2),
    CONSTRAINT pkname PRIMARY KEY (column1,column2),
    CONSTRAINT fkname FOREIGN KEY (column3) REFERENCES table2(column1),
    CONSTRAINT chkname CHECK (column4>=18)
); 
# MySQL的：
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    column3 datatype,
    column4 datatype,
    PRIMARY KEY (column1),
    UNIQUE(column2),
    FOREIGN KEY (column3) REFERENCES table2(column1)
    CHECK (column4>=18)
);
# SQL Server / Oracle / MS Access：
CREATE TABLE table_name (
    column1 datatype PRIMARY KEY,
    column2 datatype UNIQUE,
    column3 datatype FOREIGN KEY REFERENCES table2(column1),
    column4 datatype CHECK (column4>=18 AND column1>1)
);

ALTER TABLE table_name MODIFY column1 datatype NOT NULL; 
ALTER TABLE table_name ADD UNIQUE (column2); 
ALTER TABLE table_name ADD PRIMARY KEY (column1); 
ALTER TABLE table_name ADD FOREIGN KEY (column3) REFERENCES table2(column1); 
ALTER TABLE table_name ADD CHECK (column4>=18); 
ALTER TABLE table_name ADD CONSTRAINT constname UNIQUE (column1,column2); 
ALTER TABLE table_name ADD CONSTRAINT pkname PRIMARY KEY (column1,column2); 
ALTER TABLE table_name ADD CONSTRAINT fkname FOREIGN KEY (column3) REFERENCES table2(column1); 
ALTER TABLE table_name ADD CONSTRAINT chkname CHECK (column4>=18 AND column1>1); 

# 创建DEFAULT约束
# MySQL的：
ALTER TABLE table_name ALTER column1 SET DEFAULT ''; 
# SQL Server：
ALTER TABLE table_name ADD CONSTRAINT dfname DEFAULT '' FOR column1; 
# MS Access：
ALTER TABLE table_name ALTER COLUMN column1 SET DEFAULT ''; 
# Oracle：
ALTER TABLE table_name MODIFY column1 DEFAULT ''; 

# DROP DEFAULT 约束
# MySQL的：
ALTER TABLE table_name ALTER column1 DROP DEFAULT; 
# SQL Server / Oracle / MS Access：
ALTER TABLE table_name ALTER COLUMN column1 DROP DEFAULT; 

# DROP 约束
# MySQL的：
ALTER TABLE table_name DROP INDEX constname; -- UNIQUE
ALTER TABLE table_name DROP PRIMARY KEY; 
ALTER TABLE table_name DROP FOREIGN KEY; 
ALTER TABLE table_name DROP CHECK chkname; 

# SQL Server / Oracle / MS Access：
ALTER TABLE table_name DROP CONSTRAINT constname; -- UNIQUE
ALTER TABLE table_name DROP CONSTRAINT pkname; 
ALTER TABLE table_name DROP CONSTRAINT fkname; 
ALTER TABLE table_name DROP CONSTRAINT chkname; 

# CREATE INDEX语法
# 在表上创建索引，允许重复的值：
CREATE INDEX index_name
ON table_name (column1, column2, ...); 

# 创建独特的索引语法
# 在表上创建唯一索引，不允许重复值：
CREATE UNIQUE INDEX index_name
ON table_name (column1, column2, ...); 

# DROP INDEX 语句
# DROP INDEX 语句用于删除表中的索引。
# MS Access：
DROP INDEX index_name ON table_name; 

# SQL Server：
DROP INDEX table_name.index_name; 

# DB2 / Oracle数据库：
DROP INDEX index_name; 

# MySQL的：
ALTER TABLE table_name
DROP INDEX index_name;

# AUTO INCREMENT
# MySQL的语法
CREATE TABLE table_name(
   column1 int NOT NULL AUTO_INCREMENT,
   PRIMARY KEY (column1)
); 
ALTER TABLE table_name AUTO_INCREMENT=100;

# SQL Server的语法
CREATE TABLE table_name(
   column1 int IDENTITY(1,1) PRIMARY KEY
);  
# MS Access 语法
CREATE TABLE table_name(
   column1 AUTOINCREMENT PRIMARY KEY
);
# Oracle语法
# 您必须使用序列对象创建自动增量字段（此对象生成数字序列）。
# 使用以下CREATE SEQUENCE语法：
CREATE SEQUENCE seqname
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10; 
INSERT INTO table_name (column1,column2)
VALUES (seqname.nextval,''); 


# 创建视图语法
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition; 
```

#### SQL 关键字

ADD	在现有表中添加列
ADD CONSTRAINT	在已创建表之后添加约束
ALTER	添加，删除或修改表中的列，或更改表中列的数据类型
ALTER COLUMN	更改表中列的数据类型
ALTER TABLE	添加，删除或修改表中的列
ALL	如果所有子查询值满足条件，则返回true
AND	仅包括两个条件都为真的行
ANY	如果任何子查询值满足条件，则返回true
AS	使用别名重命名列或表
ASC	按升序对结果集进行排序
BACKUP DATABASE	创建现有数据库的备份
BETWEEN	选择给定范围内的值
CASE	根据条件创建不同的输出
CHECK	限制可以放置在列中的值的约束
COLUMN	更改列的数据类型或删除表中的列
CONSTRAINT	添加或删除约束
CREATE	创建数据库，索引，视图，表或过程
CREATE DATABASE	创建一个新的SQL数据库
CREATE INDEX	在表上创建索引（允许重复值）
CREATE OR REPLACE VIEW	更新视图
CREATE TABLE	在数据库中创建一个新表
CREATE PROCEDURE	创建存储过程
CREATE UNIQUE INDEX	在表上创建唯一索引（无重复值）
CREATE VIEW	根据SELECT语句的结果集创建视图
DATABASE	创建或删除SQL数据库
DEFAULT	为列提供默认值的约束
DELETE	从表中删除行
DESC	按降序对结果集进行排序
DISTINCT	仅选择不同（不同）的值
DROP	删除列，约束，数据库，索引，表或视图
DROP COLUMN	删除表中的列
DROP CONSTRAINT	删除UNIQUE，PRIMARY KEY，FOREIGN KEY或CHECK约束
DROP DATABASE	删除现有SQL数据库
DROP DEFAULT	删除DEFAULT约束
DROP INDEX	删除表中的索引
DROP TABLE	删除数据库中的现有表
DROP VIEW	删除视图
EXEC	执行存储过程
EXISTS	测试子查询中是否存在任何记录
FOREIGN KEY	约束，是用于将两个表链接在一起的键
FROM	指定要从中选择或删除数据的表
FULL OUTER JOIN	当左表或右表中存在匹配时，返回所有行
GROUP BY	对结果集进行分组（与聚合函数一起使用：COUNT，MAX，MIN，SUM，AVG）
HAVING	使用聚合函数代替WHERE
IN	允许您在WHERE子句中指定多个值
INDEX	创建或删除表中的索引
INNER JOIN	返回两个表中具有匹配值的行
INSERT INTO	在表中插入新行
INSERT INTO SELECT	将数据从一个表复制到另一个表中
IS NULL	测试空值
IS NOT NULL	测试非空值
JOIN	关联表
LEFT JOIN	返回左表中的所有行，以及右表中的匹配行
LIKE	在列中搜索指定的模式
LIMIT	指定要在结果集中返回的记录数
NOT	仅包括条件不为真的行
NOT NULL	强制列不接受NULL值的约束
OR	包括条件为真的行
ORDER BY	按升序或降序对结果集进行排序
OUTER JOIN	当左表或右表中存在匹配时，返回所有行
PRIMARY KEY	唯一标识数据库表中每条记录的约束
PROCEDURE	存储过程
RIGHT JOIN	返回右表中的所有行以及左表中的匹配行
ROWNUM	指定要在结果集中返回的记录数
SELECT	从数据库中选择数据
SELECT DISTINCT	仅选择不同（不同）的值
SELECT INTO	将数据从一个表复制到新表中
SELECT TOP	指定要在结果集中返回的记录数
SET	指定应在表中更新的列和值
TABLE	创建表，或添加，删除或修改表中的列，或删除表中的表或数据
TOP	指定要在结果集中返回的记录数
TRUNCATE TABLE	删除表中的数据，但不删除表本身
UNION	合并两个或多个SELECT语句的结果集（仅限不同的值）
UNION ALL	合并两个或多个SELECT语句的结果集（允许重复值）
UNIQUE	一种约束，用于确保列中的所有值都是唯一的
UPDATE	更新表中的现有行
VALUES	指定INSERT INTO语句的值
VIEW	创建，更新或删除视图
WHERE	筛选结果集以仅包括满足指定条件的记录

#### SQL 函数

##### MySQL字符串函数

ASCII	返回特定字符的ASCII值
CHAR_LENGTH	返回字符串的长度（以字符为单位）
CHARACTER_LENGTH	返回字符串的长度（以字符为单位）
CONCAT	一起添加两个或多个表达式
CONCAT_WS	将两个或多个表达式与分隔符一起添加
FIELD	返回值列表中值的索引位置
FIND_IN_SET	返回字符串列表中字符串的位置
FORMAT	将数字格式化为“＃，###，###。##”等格式，舍入到指定的小数位数
INSERT	在指定位置的字符串中插入一个字符串，并插入一定数量的字符
INSTR	返回第一次出现在另一个字符串中的字符串的位置
LCASE	将字符串转换为小写
LEFT	从字符串中提取多个字符（从左开始）
LENGTH	返回字符串的长度（以字节为单位）
LOCATE	返回字符串中第一次出现子字符串的位置
LOWER	将字符串转换为小写
LPAD	左边用另一个字符串填充一个字符串到一定长度
LTRIM	从字符串中删除前导空格
MID	从字符串中提取子字符串（从任何位置开始）
POSITION	返回字符串中第一次出现子字符串的位置
REPEAT	按指定的次数重复一次字符串
REPLACE	使用新的子字符串替换字符串中所有出现的子字符串
REVERSE	反转字符串并返回结果
RIGHT	从字符串中提取多个字符（从右侧开始）
RPAD	右边用另一个字符串填充一个字符串到一定长度
RTRIM	从字符串中删除尾随空格
SPACE	返回指定数量的空格字符的字符串
STRCMP	比较两个字符串
SUBSTR	从字符串中提取子字符串（从任何位置开始）
SUBSTRING	从字符串中提取子字符串（从任何位置开始）
SUBSTRING_INDEX	在指定数量的分隔符出现之前返回字符串的子字符串
TRIM	从字符串中删除前导和尾随空格
UCASE	将字符串转换为大写
UPPER	将字符串转换为大写

##### MySQL数字函数

ABS	返回数字的绝对值
ACOS	返回数字的反余弦值
ASIN	返回数字的反正弦值
ATAN	返回一个或两个数字的反正切
ATAN2	返回两个数字的反正切
AVG	返回表达式的平均值
CEIL	返回> =到数字的最小整数值
CEILING	返回> =到数字的最小整数值
COS	返回数字的余弦值
COT	返回数字的余切
COUNT	返回select查询返回的记录数
DEGREES	将弧度值转换为度数
DIV	用于整数除法
EXP	返回e提升到指定数字的幂
FLOOR	返回<=到数字的最大整数值
GREATEST	返回参数列表的最大值
LEAST	返回参数列表的最小值
LN	返回数字的自然对数
LOG	返回数字的自然对数，或数字的对数到指定的基数
LOG10	返回数字的自然对数到10
LOG2	返回数字2的自然对数
MAX	返回一组值中的最大值
MIN	返回一组值中的最小值
MOD	返回数字的余数除以另一个数字
PI	返回PI的值
POW	返回被提升到另一个数的幂的数字的值
POWER	返回被提升到另一个数的幂的数字的值
RADIANS	将度数值转换为弧度
RAND	返回一个随机数
ROUND	将数字舍入到指定的小数位数
SIGN	返回数字的符号
SIN	返回数字的正弦值
SQRT	返回数字的平方根
SUM	计算一组值的总和
TAN	返回数字的正切值
TRUNCATE	将数字截断为指定的小数位数

##### MySQL日期函数

ADDDATE	将时间/日期间隔添加到日期，然后返回日期
ADDTIME	将时间间隔添加到时间/日期时间，然后返回时间/日期时间
CURDATE	返回当前日期
CURRENT_DATE	返回当前日期
CURRENT_TIME	返回当前时间
CURRENT_TIMESTAMP	返回当前日期和时间
CURTIME	返回当前时间
DATE	从日期时间表达式中提取日期部分
DATEDIFF	返回两个日期值之间的天数
DATE_ADD	将时间/日期间隔添加到日期，然后返回日期
DATE_FORMAT	格式化日期
DATE_SUB	从日期中减去时间/日期间隔，然后返回日期
DAY	返回给定日期的月中的某天
DAYNAME	返回给定日期的工作日名称
DAYOFMONTH	返回给定日期的月中的某天
DAYOFWEEK	返回给定日期的工作日索引
DAYOFYEAR	返回给定日期的一年中的某一天
EXTRACT	从给定日期提取部分
FROM_DAYS	从数字日期值返回日期
HOUR	返回给定日期的小时部分
LAST_DAY	提取指定日期的月份的最后一天
LOCALTIME	返回当前日期和时间
LOCALTIMESTAMP	返回当前日期和时间
MAKEDATE	根据年份和天数值创建并返回日期
MAKETIME	根据小时，分钟和秒值创建并返回时间
MICROSECOND	返回时间/日期时间的微秒部分
MINUTE	返回时间/日期时间的分钟部分
MONTH	返回给定日期的月份部分
MONTHNAME	返回给定日期的月份名称
NOW	返回当前日期和时间
PERIOD_ADD	在一段时间内添加指定的月数
PERIOD_DIFF	返回两个句点之间的差异
QUARTER	返回给定日期值的一年中的季度
SECOND	返回时间/日期时间的秒部分
SEC_TO_TIME	返回基于指定秒数的时间值
STR_TO_DATE	返回基于字符串和格式的日期
SUBDATE	从日期中减去时间/日期间隔，然后返回日期
SUBTIME	从日期时间中减去时间间隔，然后返回时间/日期时间
SYSDATE	返回当前日期和时间
TIME	从给定的时间/日期时间中提取时间部分
TIME_FORMAT	按指定格式格式化时间
TIME_TO_SEC	将时间值转换为秒
TIMEDIFF	返回两个时间/日期时间表达式之间的差异
TIMESTAMP	返回基于日期或日期时间值的日期时间值
TO_DAYS	返回日期和日期“0000-00-00”之间的天数
WEEK	返回给定日期的周数
WEEKDAY	返回给定日期的工作日编号
WEEKOFYEAR	返回给定日期的周数
YEAR	返回给定日期的年份部分
YEARWEEK	返回给定日期的年和周数

##### MySQL高级功能

BIN	返回数字的二进制表示形式
BINARY	将值转换为二进制字符串
CASE	通过条件并在满足第一个条件时返回值
CAST	将值（任何类型）转换为指定的数据类型
COALESCE	返回列表中的第一个非null值
CONNECTION_ID	返回当前连接的唯一连接ID
CONV	将数字从一个数字基本系统转换为另一个
CONVERT	将值转换为指定的数据类型或字符集
CURRENT_USER	返回服务器用于验证当前客户端的MySQL帐户的用户名和主机名
DATABASE	返回当前数据库的名称
IF	如果条件为TRUE则返回值，如果条件为FALSE则返回另一个值
IFNULL	如果表达式为NULL，则返回指定的值，否则返回表达式
ISNULL	返回1或0，具体取决于表达式是否为NULL
LAST_INSERT_ID	返回已在表中插入或更新的最后一行的AUTO_INCREMENT标识
NULLIF	比较两个表达式，如果它们相等则返回NULL。否则，返回第一个表达式
SESSION_USER	返回当前的MySQL用户名和主机名
SYSTEM_USER	返回当前的MySQL用户名和主机名
USER	返回当前的MySQL用户名和主机名
VERSION	返回MySQL数据库的当前版本

### RDBMS

RDBMS代表关系数据库管理系统。

RDBMS是SQL的基础，适用于所有现代数据库系统，如MS SQL Server，IBM DB2，Oracle，MySQL和Microsoft Access。

RDBMS中的数据存储在称为表的数据库对象中。表是相关数据条目的集合，它由列和行组成。




