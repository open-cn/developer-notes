## mysql


### 概述

#### MySQL基础
包括管理MySQL数据库和使用各种SQL语句（如INSERT，DELETE，UPDATE和SELECT）操作数据。您还将学习高级数据选择技术，包括INNER JOIN，LEFT JOIN，Subquery和UNION。

#### MySQL 事务

InnoDB 引擎支持事务，MyISAM 引擎不支持事务。可重复读是默认的隔离级别。

#### MySQL 存储过程

#### MySQL 触发器
MySQL触发器是存储的程序，它们自动执行以响应与表相关的特定事件，例如插入，更新或删除记录。

#### MySQL 视图

#### MySQL 全文搜索
使用MySQL全文搜索和各种全文搜索技术，如自然语言搜索，布尔语言搜索和查询扩展。

like 模糊匹配在文本比较少时是合适的，但是对于大量的文本数据检索，是不可想象的。全文索引在大量的数据面前，能比 like 模糊匹配快 N 倍，速度不是一个数量级，但是全文索引可能存在精度问题。

- MySQL 5.6 以前的版本，只有 MyISAM 存储引擎支持全文索引；
- MySQL 5.6 及以后的版本，MyISAM 和 InnoDB 存储引擎均支持全文索引;
- 只有字段的数据类型为 char、varchar、text 及其系列才可以建全文索引。

match() 函数中指定的列必须和全文索引中指定的列完全相同，否则就会报错，无法使用全文索引，这是因为全文索引不会记录关键字来自哪一列。如果想要对某一列使用全文索引，请单独为该列创建全文索引。


```sql
# 全文索引，有两个变量，最小搜索长度和最大搜索长度
# 对于长度小于最小搜索长度和大于最大搜索长度的词语，都不会被索引。
show variables like '%ft%';

# MyISAM
ft_min_word_len = 4;
ft_max_word_len = 84;
ft_boolean_syntax = + -><()~*:""&|

# InnoDB
innodb_ft_min_token_size = 3;
innodb_ft_max_token_size = 84;


# 创建联合全文索引列
create table fulltext_test (
    id int(11) NOT NULL AUTO_INCREMENT,
    content text NOT NULL,
    tag varchar(255),
    PRIMARY KEY (id),
    FULLTEXT KEY content_tag_fulltext(content,tag)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
create fulltext index content_tag_fulltext on fulltext_test(content,tag);
alter table fulltext_test add fulltext index content_tag_fulltext(content,tag);


# 删除全文索引列
drop index content_tag_fulltext on fulltext_test;
alter table fulltext_test drop index content_tag_fulltext;


# 使用全文索引
select * from fulltext_test where match(content,tag) against('xxx xxx');
select * from fulltext_test where match(content,tag) against('xxx xxx' in natural language mode);

select * from fulltext_test where match(content,tag) against('x*' in boolean mode);
# + 必须包含该词
# - 必须不包含该词
# > 提高该词的相关性，查询的结果靠前
# < 降低该词的相关性，查询的结果靠后
# (*)星号 通配符，只能接在词后面
```

MySQL 的全文索引最开始仅支持英语，因为英语的词与词之间有空格，使用空格作为分词的分隔符是很方便的。象形文字，比如汉语、日语等，是没有空格的，这就造成了一定的限制。不过 MySQL 5.7.6 开始，引入了一个 ngram 全文分析器来解决这个问题，并且对 MyISAM 和 InnoDB 引擎都有效。

事实上，MyISAM 存储引擎对全文索引的支持有很多的限制，例如表级别锁对性能的影响、数据文件的崩溃、崩溃后的恢复等，这使得 MyISAM 的全文索引对于很多的应用场景并不适合。所以，多数情况下的建议是使用别的解决方案，例如 Sphinx、Lucene 等等第三方的插件，亦或是使用 InnoDB 存储引擎的全文索引。


#### MySQL 函数
最常用的MySQL函数，包括聚合函数，字符串函数，日期和时间函数以及控制流函数。

##### 聚合函数

常见的聚合函数有：sum() count() average() max() min()

##### 开窗函数

窗口函数的引入是为了解决想要既显示聚集前的数据，又要显示聚集后的数据。 开窗函数对一组值进行操作，不需要使用GROUP BY子句对数据进行分组，能够在同一行中同时返回基础行的列和聚合列。

强调：使用 mysql8.0版本方可实现

语法：函数名() over([partition by 列] [order by 列] [rows between xxx and xxx]) 

默认统计范围是从当前行之前的数据到当前行。

unbounded 无限制的

preceding 分区的当前记录的向前偏移量

current 当前

following 分区的当前记录的向后偏移量

unbounded preceding 当前行之前的所有行

current row 当前行

unbounded following 当前行及其之后的所有行

- 聚合开窗

语法：聚合函数(列) over(partition by 列 order by 列)

- lag(col,n)

用于统计窗口内往上第n行值

- lead(col,n)

用于统计窗口内往下第n行值

- first_value(column)

取分组内排序后，截止到当前行，第一个值

- last_value(column)

取分组内排序后，截止到当前行，最后一个值

- 排序开窗

语法：排序函数() over(partition by 列 order by 列)

row_number() 序号，连续，不可并列排名。如：1、2、3、4...

dense_rank() 可并列排名，连续。如：1、1、2、3、4...

rank() 可并列排名，不连续。如：1、1、3、4...

ntile(n) 分桶排名，先分桶，再排序各个桶，桶内排名序号一致。

```mysql
row_number() over(partition by ... order by ...)
rank() over(partition by ... order by ...)
dense_rank() over(partition by ... order by ...)
count() over(partition by ... order by ...)
max() over(partition by ... order by ...)
min() over(partition by ... order by ...)
sum() over(partition by ... order by ...)
avg() over(partition by ... order by ...)
first_value() over(partition by ... order by ...)
last_value() over(partition by ... order by ...)
lag() over(partition by ... order by ...)
lead() over(partition by ... order by ...）
```

#### MySQL数据库的管理
包括MySQL服务器启动和关闭，MySQL服务器安全性，MySQL数据库维护，备份和复制。

#### 规范设计

##### 配置规范

（1）MySQL数据库默认使用InnoDB存储引擎。

（2）保证字符集设置统一，MySQL数据库相关系统、数据库、表的字符集使都用UTF8，应用程序连接、展示等可以设置字符集的地方也都统一设置为UTF8字符集。

注：UTF8格式是存储不了表情类数据，需要使用UTF8MB4，可在MySQL字符集里面设置。在8.0中已经默认为UTF8MB4，可以根据公司的业务情况进行统一或者定制化设置。

（3）MySQL数据库的事务隔离级别默认为RR（Repeatable-Read），建议初始化时统一设置为RC（Read-Committed），对于OLTP业务更适合。

（4）数据库中的表要合理规划，控制单表数据量，对于MySQL数据库来说，建议单表记录数控制在2000W以内。

（5）MySQL实例下，数据库、表数量尽可能少；数据库一般不超过50个，每个数据库下，数据表数量一般不超过500个（包括分区表）。



##### 建表规范

（1）InnoDB禁止使用外键约束，可以通过程序层面保证。

（2）存储精确浮点数必须使用DECIMAL替代FLOAT和DOUBLE。

（3）整型定义中无需定义显示宽度，比如：使用INT，而不是INT(4)。

（4）不建议使用ENUM类型，可使用TINYINT来代替。

（5）尽可能不使用TEXT、BLOB类型，如果必须使用，建议将过大字段或是不常用的描述型较大字段拆分到其他表中；另外，禁止用数据库存储图片或文件。

（6）存储年时使用YEAR(4)，不使用YEAR(2)。

（7）建议字段定义为NOT NULL。

（8）建议DBA提供SQL审核工具，建表规范性需要通过审核工具审核后




##### 命名规范

（1）库、表、字段全部采用小写。

（2）库名、表名、字段名、索引名称均使用小写字母，并以“\_”分割。

（3）库名、表名、字段名建议不超过12个字符。（库名、表名、字段名支持最多64个字符，但为了统一规范、易于辨识以及减少传输量，统一不超过12字符）

（4）库名、表名、字段名见名知意，不需要添加注释。

|对象类型|英文全称|对象前缀|
|---|---|---|
|视图|view|view_|
|函数|function|func_|
|存储过程|procedure|proc_|
|触发器|trigger|trig_|
|普通索引|index|idx_|
|唯一索引|unique index|uniq_|
|主键索引|primary key|pk_|


##### 索引规范

（1）索引建议命名规则：idx_col1_col2[_colN]、uniq_col1_col2[_colN]（如果字段过长建议采用缩写）。

（2）索引中的字段数建议不超过5个。

（3）单张表的索引个数控制在5个以内。

（4）InnoDB表一般都建议有主键列，尤其在高可用集群方案中是作为必须项的。

（5）建立复合索引时，优先将选择性高的字段放在前面。

（6）UPDATE、DELETE语句需要根据WHERE条件添加索引。

（7）不建议使用%前缀模糊查询，例如LIKE “%weibo”，无法用到索引，会导致全表扫描。

（8）合理利用覆盖索引，例如：

（9）SELECT email,uid FROM user_email WHERE uid=xx，如果uid不是主键，可以创建覆盖索引idx_uid_email(uid,email)来提高查询效率。

（10）避免在索引字段上使用函数，否则会导致查询时索引失效。

（11）确认索引是否需要变更时要联系DBA。



##### 应用规范

（1）避免使用存储过程、触发器、自定义函数等，容易将业务逻辑和DB耦合在一起，后期做分布式方案时会成为瓶颈。

（2）考虑使用UNION ALL，减少使用UNION，因为UNION ALL不去重，而少了排序操作，速度相对比UNION要快，如果没有去重的需求，优先使用UNION ALL。

（3）考虑使用limit N，少用limit M，N，特别是大表或M比较大的时候。

（4）减少或避免排序，如：group by语句中如果不需要排序，可以增加order by null。

（5）统计表中记录数时使用COUNT(\*)，而不是COUNT(primary_key)和COUNT(1)；InnoDB表避免使用COUNT(\*)操作，计数统计实时要求较强可以使用Memcache或者Redis，非实时统计可以使用单独统计表，定时更新。

（6）做字段变更操作（modify column/change column）的时候必须加上原有的注释属性，否则修改后，注释会丢失。

（7）使用prepared statement可以提高性能并且避免SQL注入。

（8）SQL语句中IN包含的值不应过多。

（9）UPDATE、DELETE语句一定要有明确的WHERE条件。

（10）WHERE条件中的字段值需要符合该字段的数据类型，避免MySQL进行隐式类型转化。

（11）SELECT、INSERT语句必须显式的指明字段名称，禁止使用SELECT * 或是INSERT INTO table_name values()。

（12）INSERT语句使用batch提交（INSERT INTO table_name VALUES(),(),()……），values的个数不应过多。


#### 业务层优化

主要有业务拆分，数据拆分和两类常见的优化场景（读多写少，读少写多）

##### 业务拆分

1. 将混合业务拆分为独立业务
2. 将状态和历史数据分离

##### 数据拆分

1. 按照时间拆分。按照日、周、月、季度、年为维度。
2. 采用分区模式。采用hash,range等方式会多一些。不大建议使用分区表的使用方式，因为随着存储容量的增长，数据虽然做了垂直拆分，但是归根结底，数据其实难以实现水平扩展，有更好的扩展方式。
3. 读多写少优化场景。采用缓存，采用Redis技术，将读请求打在缓存层面，这样可以大大降低MySQL层面的热点数据查询压力。
4. 读少写多优化场景，可以采用三步走：

1) 采用异步提交模式，异步对于应用层来说最直观的就是性能的提升，产生最少的同步等待。
2) 使用队列技术，大量的写请求可以通过队列的方式来进行扩展，实现批量的数据写入。
3) 降低写入频率，比如从原来的每分钟写入调整为10分钟写入一次。

#### 架构层优化

##### 系统水平扩展场景
1. 采用中间件技术，可以实现数据路由，水平扩展，常见的中间件有MyCAT，ShardingSphere,ProxySQL等
2. 采用读写分离技术，这是针对读需求的扩展，更侧重于状态表，在允许一定延迟的情况下，可以采用多副本的模式实现读需求的水平扩展，也可以采用中间件来实现，如MyCAT,ProxySQL,MaxScale,MySQL Router等
3. 采用负载均衡技术，常见的有LVS技术或者基于域名服务的Consul技术等

##### 兼顾OLTP+OLAP的业务场景
可以采用NewSQL，优先兼容MySQL协议的HTAP技术栈，如TiDB

##### 离线统计的业务场景
1. 采用NoSQL体系，主要有两类，一类是适合兼容MySQL协议的数据仓库体系，常见的有Infobright或者ColumnStore，另外一类是基于列式存储，属于异构方向，如HBase技术
2. 采用数仓体系，基于MPP架构,如使用Greenplum统计，如T+1统计


#### 数据库优化

##### 事务优化

根据业务场景选择事务模型，是否是强事务依赖。

1. 降维策略1：存储过程调用转换为透明的SQL调用

对于新业务而言，使用存储过程显然不是一个好主意，MySQL的存储过程和其他商业数据库相比，功能和性能都有待验证，而且在目前轻量化的业务处理中，存储过程的处理方式太“重”了。

有些应用架构看起来是按照分布式部署的，但在数据库层的调用方式是基于存储过程，因为存储过程封装了大量的逻辑，难以调试，而且移植性不高，这样业务逻辑和性能压力都在数据库层面了，使得数据库层很容易成为瓶颈，而且难以实现真正的分布式。

所以有一个明确的改进方向就是对于存储过程的改造，把它改造为SQL调用的方式，可以极大地提高业务的处理效率，在数据库的接口调用上足够简单而且清晰可控。

2. 降维策略2：DDL操作转换为DML操作

有些业务经常会有一种紧急需求，总是需要给一个表添加字段，搞得DBA和业务同学都挺累，可以想象一个表有上百个字段，而且基本都是name1，name2……name100，这种设计本身就是有问题的，更不用考虑性能了。究其原因，是因为业务的需求动态变化，比如一个游戏装备有20个属性，可能过了一个月之后就增加到了40个属性，这样一来，所有的装备都有40个属性，不管用没用到，而且这种方式也存在诸多的冗余。

我们在设计规范里面也提到了一些设计的基本要素，在这些基础上需要补充的是，保持有限的字段，如果要实现这些功能的扩展，其实完全可以通过配置化的方式来实现，比如把一些动态添加的字段转换为一些配置信息。配置信息可以通过DML的方式进行修改和补充，对于数据入口也可以更加动态、易扩展。

3. 降维策略3：Delete操作转换为高效操作

有些业务需要定期来清理一些周期性数据，比如表里的数据只保留一个月，那么超出时间范围的数据就要清理掉了，而如果表的量级比较大的情况下，这种Delete操作的代价实在太高，我们可以有两类解决方案来把Delete操作转换为更为高效的方式。

第一种是根据业务建立周期表，比如按照月表、周表、日表等维度来设计，这样数据的清理就是一个相对可控而且高效的方式了。

第二种方案是使用MySQL rename的操作方式，比如一张2千万的大表要清理99%的数据，那么需要保留的1%的数据我们可以很快根据条件过滤补录，实现“移形换位”。

##### SQL优化
1. SQL语句简化，简化是SQL优化的一大利器，因为简单，所以优越。
2. 尽可能避免或者杜绝多表复杂关联，大表关联是大表处理的噩梦，一旦打开了这个口子，越来越多的需求需要关联，性能优化就没有回头路了，更何况大表关联是MySQL的弱项，尽管Hash Join才推出，不要像掌握了绝对大杀器一样，在商业数据库中早就存在，问题照样层出不穷。
3. SQL中尽可能避免反连接，避免半连接，这是优化器做得薄弱的一方面，什么是反连接，半连接？其实比较好理解，举个例子，not in ,not exists就是反连接，in,exists就是半连接，在千万级大表中出现这种问题，性能是几个数量级的差异。

##### 索引优化
1. 首先必须有主键。
2. 其次，SQL查询基于索引或者唯一性索引，使得查询模型尽可能简单。
3. 最后，尽可能杜绝范围数据的查询，范围扫描在千万级大表情况下还是尽可能减少。

#### 管理优化

千万级大表的数据清理一般来说是比较耗时的，在此建议在设计中需要完善冷热数据分离的策略，可能听起来比较拗口，我来举一个例子，把大表的Drop 操作转换为可逆的DDL操作。

Drop操作是默认提交的，而且是不可逆的，在数据库操作中都是跑路的代名词，MySQL层面目前没有相应的Drop操作恢复功能，除非通过备份来恢复，但是我们可以考虑将Drop操作转换为一种可逆的DDL操作。

MySQL中默认每个表有一个对应的ibd文件，其实可以把Drop操作转换为一个rename操作，即把文件从testdb迁移到testdb_arch下面；从权限上来说，testdb_arch是业务不可见的，rename操作可以平滑的实现这个删除功能，如果在一定时间后确认可以清理，则数据清理对于已有的业务流程是不可见的。

此外，还有两个额外建议，一个是对于大表变更，尽可能考虑低峰时段的在线变更，比如使用pt-osc工具或者是维护时段的变更。


### MySQL 扩展

#### Extensions for Spatial Data

Open Geospatial Consortium (OGC) 是一个由超过两百五十个公司，机构，大学组成的致力于发展管理空间数据的解决方案的组织。

该 OGC 发布了 OpenGIS® Implementation Standard for Geographic information - Simple feature access - Part 2: SQL option ， 这个文档建议了几种方法扩展RDBMS来支持空间数据。文档查看： http://www.opengeospatial.org/standards/sfs.

数据类型和方法在 MyISAM,  InnoDB, NDB, and ARCHIVE中可用。至于空间索引， MyISAM and InnoDB支持空间和非空间索引，其他引擎支持非空间索引。

geographic feature（地理特性）  是指世界上的所有东西都有一个location（位置）。

Mysql 没有实现以下GIS特性：

- 额外的Metadata Views
- OpenGIS中 LineString  and MultiLineString的方法length() 应该使用ST_Length()

##### Spatial Data Types

GEOMETRY可以存储任意几何类型。

单一几何值：

- GEOMETRY 几何体
- POINT 点
- LINESTRING 线
- POLYGON 多边形

GEOMETRYCOLLECTION可以存放任意类型的集合。其他类型需要特定几何类型：
     
- MULTIPOINT 多点
- MULTILINESTRING 多线
- MULTIPOLYGON 多个多边形
- GEOMETRYCOLLECTION 几何集合

##### The Geometry Class Hierarchy

- Geometry (noninstantiable)几何
	+ Point (instantiable)点
	+ Curve (noninstantiable)曲线
		* LineString (instantiable)线串
			- Line线
			- LinearRing线圈
	+ Surface (noninstantiable) 面
		* Polygon (instantiable)多边形
	+ GeometryCollection (instantiable)几何集合
		* MultiPoint (instantiable)多点
		* MultiCurve (noninstantiable)多曲线
			- MultiLineString (instantiable)多线串
		* MultiSurface (noninstantiable)多面
			- MultiPolygon (instantiable) 多个多边形

##### Supported Spatial Data Formats

有两个标准的空间数据格式被用来表示集合对象：

- Well-Known Text (WKT) format
- Well-Known Binary (WKB) format

在内部，MySQL存储几何值到一个既不是WKT也不是WKB的格式。

```sql
CREATE TABLE geom (g Geometry);
ALTER TABLE geom ADD pt Point;
ALTER TABLE geom DROP pt;

-- The Well-Known Text (WKT) 
-- 多个点用逗号分割
-- v5.7.9及以后 每个点可以用小括号包裹
SELECT ST_GeomFromText('POINT(15 20)');
SELECT ST_GeomFromText('LINESTRING(0 0, 10 10, 20 25, 50 60)');
SELECT ST_GeomFromText('POLYGON((0 0, 10 0, 10 10, 0 10, 0 0),(5 5, 7 5, 7 7, 5 7, 5 5))');
SELECT ST_GeomFromText('MULTIPOINT(0 0, 20 20, 60 60)');

SELECT ST_PointFromText('POINT(15 20)');
SELECT ST_AsText(Point(15, 20)); 

-- Well-Known Binary (WKB)
-- 1-byte 无符号整数（Byte order），4-byte 无符号整数（WKB type），8-byte 双精度数字。一个byte是8bit。
-- The Byte order 表明低位高位存储。
-- The WKB type 表明几何体类型. 值从1到7分别表示 Point, LineString, Polygon, MultiPoint, MultiLineString, MultiPolygon, and GeometryCollection.
SELECT ST_PointFromWKB(0x0101000000000000000000F03F000000000000F03F);

SELECT ST_AsBinary(Point(1, 1)); 

```

##### Spatial Indexes

MySQL使用 R-Trees with quadratic splitting（二次分割）来创建空间索引到空间列上。一个空间索引是使用minimum bounding rectangle (最小外包矩形MBR)建立的。对于大多数几何体来说，the MBR 是一个最小的可以包含这个几何体的矩形。对于一个水平或者垂直的linestring，the MBR是一个变化的linestring内部的矩形。对于一个point，the MBR是一个变化的点内的矩形。

MyISAM and InnoDB 都支持 SPATIAL and non-SPATIAL indexes.

```sql
CREATE TABLE geom (fid INT auto_increment Primary, g GEOMETRY NOT NULL, SPATIAL INDEX(g));
ALTER TABLE geom ADD SPATIAL INDEX(g);
ALTER TABLE geom DROP INDEX g;
CREATE SPATIAL INDEX sp_index ON geom (g);
DROP INDEX sp_index ON geom;

SET @poly = 'Polygon((30000 15000,
                  31000 15000,
                  31000 16000,
                  30000 16000,
                  30000 15000))';
SELECT fid,ST_AsText(g) FROM geom WHERE MBRContains(ST_GeomFromText(@poly),g);
SELECT fid,ST_AsText(g) FROM geom IGNORE INDEX (g) WHERE MBRContains(ST_GeomFromText(@poly),g);

EXPLAIN SELECT fid,ST_AsText(g) FROM geom WHERE MBRContains(ST_GeomFromText(@poly),g);
EXPLAIN SELECT fid,ST_AsText(g) FROM geom IGNORE INDEX (g) WHERE MBRContains(ST_GeomFromText(@poly),g);

-- Point 搜索：搜索包含一个给定的点的所有对象

-- 地区搜索：搜索与给定区域重叠的所有对象

```

##### Spatial Function Reference

ST_Area()	返回 Polygon or MultiPolygon 范围
ST_AsBinary(), ST_AsWKB()	将内部格式转换成WKB
ST_AsGeoJSON()	从几何体中生成GeoJSON
ST_AsText(), ST_AsWKT()	将内部格式转换成WKT
ST_Buffer()	返回给定几何体给定距离内的几何体的点
ST_Buffer_Strategy()	ST_Buffer()生成策略选项
ST_Centroid()	返回几何中心点
ST_Contains()	是否一个几何体包含另外一个
ST_ConvexHull()	Return convex hull of geometry
ST_Crosses()	是否一个几何体和其他的交叉
ST_Difference()	返回两个几何体不同的点集合
ST_Dimension()	几何体维度
ST_Disjoint()	一个几何体是否和另一个分离
ST_Distance()	两个几何体的距离
ST_Distance_Sphere()	两个几何体在地球上的最小距离
ST_EndPoint()	返回LineString的结束点
ST_Envelope()	返回几何体MBR
ST_Equals()	两个几何体是否相等
ST_ExteriorRing()	返回Polygon的外部圈
ST_GeoHash()	生成geohash值
ST_GeomCollFromText(), ST_GeometryCollectionFromText(), ST_GeomCollFromTxt()	返回从 WKT生成的几何体集合
ST_GeomCollFromWKB(), ST_GeometryCollectionFromWKB()	返回从 WKB生成的几何体集合
ST_GeometryN()	返回集合中第N个几何体
ST_GeometryType()	返回几何体类型
ST_GeomFromGeoJSON()	从GeoJSON对象生成几何体
ST_GeomFromText(), ST_GeometryFromText()	从 WKT返回几何体
ST_GeomFromWKB(), ST_GeometryFromWKB()	从WKB返回几何体
ST_InteriorRingN()	返回Polygon的第N个内部环
ST_Intersection()	返回两个几何体的交叉点集合
ST_Intersects()	一个几何体是否和另一个交叉
ST_IsClosed()	一个几何体是否是simple且closed
ST_IsEmpty()	Placeholder function
ST_IsSimple()	Whether a geometry is simple
ST_IsValid()	Whether a geometry is valid
ST_LatFromGeoHash()	从geohash返回纬度
ST_Length()	Return length of LineString
ST_LineFromText(), ST_LineStringFromText()	Construct LineString from WKT
ST_LineFromWKB(), ST_LineStringFromWKB()	Construct LineString from WKB
ST_LongFromGeoHash()	从geohash返回经度
ST_MakeEnvelope()	两点之间的矩形
ST_MLineFromText(), ST_MultiLineStringFromText()	Construct MultiLineString from WKT
ST_MLineFromWKB(), ST_MultiLineStringFromWKB()	Construct MultiLineString from WKB
ST_MPointFromText(), ST_MultiPointFromText()	Construct MultiPoint from WKT
ST_MPointFromWKB(), ST_MultiPointFromWKB()	Construct MultiPoint from WKB
ST_MPolyFromText(), ST_MultiPolygonFromText()	Construct MultiPolygon from WKT
ST_MPolyFromWKB(), ST_MultiPolygonFromWKB()	Construct MultiPolygon from WKB
ST_NumGeometries()	返回集合中的几何体个数
ST_NumInteriorRing(), ST_NumInteriorRings()	 返回Polygon内部环的个数
ST_NumPoints()	返回LineString中点的个数
ST_Overlaps()	是否一个几何体和另一个重叠
ST_PointFromGeoHash()	从geohash转换成POINT值
ST_PointFromText()	从WKT生成POINT
ST_PointFromWKB()	从WKB生成POINT
ST_PointN()	返回LineString的第N点
ST_PolyFromText(), ST_PolygonFromText()	Construct Polygon from WKT
ST_PolyFromWKB(), ST_PolygonFromWKB()	Construct Polygon from WKB
ST_Simplify()	返回简化的几何体
ST_SRID()	返回几何体的空间关系系统ID
ST_StartPoint()	LineString的开始点
ST_SymDifference()	Return point set symmetric difference of two geometries
ST_Touches()	一个几何体是否触碰到另一个
ST_Union()	返回两个几何体所有点的联合集合
ST_Validate()	Return validated geometry
ST_Within()	一个几何体是否在另一个中
ST_X()	返回点的X坐标
ST_Y()	返回点的Y坐标

MBRContains()	一个几何的MBR包含了另一个的MBR
MBRCoveredBy()	一个MBR是否被另一个覆盖
MBRCovers()	一个MBR是否覆盖了另一个
MBRDisjoint()	两个几何体的MBR是否分离
MBREqual() (deprecated 5.7.6)	Whether MBRs of two geometries are equal
MBREquals()	两个几何体的MBR是否相同
MBRIntersects()	两个几何体的MBR是否相交
MBROverlaps()	两个几何体的MBR是否重叠
MBRTouches()	两个几何体的MBR是否触碰
MBRWithin()	一个几何体的MBR是否在另一个的MBR里面

Area() (deprecated 5.7.6)	Return Polygon or MultiPolygon area
AsBinary(), AsWKB() (deprecated 5.7.6)	Convert from internal geometry format to WKB
AsText(), AsWKT() (deprecated 5.7.6)	Convert from internal geometry format to WKT
Buffer() (deprecated 5.7.6)	Return geometry of points within given distance from geometry
Centroid() (deprecated 5.7.6)	Return centroid as a point
Contains() (deprecated 5.7.6)	Whether MBR of one geometry contains MBR of another
ConvexHull() (deprecated 5.7.6)	Return convex hull of geometry
Crosses() (deprecated 5.7.6)	Whether one geometry crosses another
Dimension() (deprecated 5.7.6)	Dimension of geometry
Disjoint() (deprecated 5.7.6)	Whether MBRs of two geometries are disjoint
Distance() (deprecated 5.7.6)	The distance of one geometry from another
EndPoint() (deprecated 5.7.6)	End Point of LineString
Envelope() (deprecated 5.7.6)	Return MBR of geometry
Equals() (deprecated 5.7.6)	Whether MBRs of two geometries are equal
ExteriorRing() (deprecated 5.7.6)	Return exterior ring of Polygon
GeomCollFromText(), GeometryCollectionFromText() (deprecated 5.7.6)	Return geometry collection from WKT
GeomCollFromWKB(), GeometryCollectionFromWKB() (deprecated 5.7.6)	Return geometry collection from WKB
GeometryCollection() 从几何图形构造几何图形集合
GeometryN() (deprecated 5.7.6)	Return N-th geometry from geometry collection
GeometryType() (deprecated 5.7.6)	Return name of geometry type
GeomFromText(), GeometryFromText() (deprecated 5.7.6)	Return geometry from WKT
GeomFromWKB(), GeometryFromWKB() (deprecated 5.7.6)	Return geometry from WKB
GLength() (deprecated 5.7.6)	Return length of LineString
InteriorRingN() (deprecated 5.7.6)	Return N-th interior ring of Polygon
Intersects() (deprecated 5.7.6)	Whether MBRs of two geometries intersect
IsClosed() (deprecated 5.7.6)	Whether a geometry is closed and simple
IsEmpty() (deprecated 5.7.6)	Placeholder function
IsSimple() (deprecated 5.7.6)	Whether a geometry is simple
LineFromText(), LineStringFromText() (deprecated 5.7.6)	Construct LineString from WKT
LineFromWKB(), LineStringFromWKB() (deprecated 5.7.6)	Construct LineString from WKB
LineString() 构造 LineString from Point values

MLineFromText(), MultiLineStringFromText() (deprecated 5.7.6)	Construct MultiLineString from WKT
MLineFromWKB(), MultiLineStringFromWKB() (deprecated 5.7.6)	Construct MultiLineString from WKB
MPointFromText(), MultiPointFromText() (deprecated 5.7.6)	Construct MultiPoint from WKT
MPointFromWKB(), MultiPointFromWKB() (deprecated 5.7.6)	Construct MultiPoint from WKB
MPolyFromText(), MultiPolygonFromText() (deprecated 5.7.6)	Construct MultiPolygon from WKT
MPolyFromWKB(), MultiPolygonFromWKB() (deprecated 5.7.6)	Construct MultiPolygon from WKB
MultiLineString()	Contruct MultiLineString from LineString values
MultiPoint()	Construct MultiPoint from Point values
MultiPolygon()	Construct MultiPolygon from Polygon values
NumGeometries() (deprecated 5.7.6)	Return number of geometries in geometry collection
NumInteriorRings() (deprecated 5.7.6)	Return number of interior rings in Polygon
NumPoints() (deprecated 5.7.6)	Return number of points in LineString
Overlaps() (deprecated 5.7.6)	Whether MBRs of two geometries overlap

Point()	Construct Point from coordinates
PointFromText() (deprecated 5.7.6)	Construct Point from WKT
PointFromWKB() (deprecated 5.7.6)	Construct Point from WKB
PointN() (deprecated 5.7.6)	Return N-th point from LineString
PolyFromText(), PolygonFromText() (deprecated 5.7.6)	Construct Polygon from WKT
PolyFromWKB(), PolygonFromWKB() (deprecated 5.7.6)	Construct Polygon from WKB
Polygon()	Construct Polygon from LineString arguments
SRID() (deprecated 5.7.6)	Return spatial reference system ID for geometry

StartPoint() (deprecated 5.7.6)	Start Point of LineString
Touches() (deprecated 5.7.6)	Whether one geometry touches another
Within() (deprecated 5.7.6)	Whether MBR of one geometry is within MBR of another
X() (deprecated 5.7.6)	Return X coordinate of Point
Y() (deprecated 5.7.6)	Return Y coordinate of Point 

### 使用

```sql
-- mysql查看当前用户有哪些数据库：
show databases;
-- 打开数据库：
use ksmsq;

-- 查看当前数据库中有哪些表：
show tables;       # 相当于oracle (select * from tab)

create table user(
	id int primary key,
	name varchar(50) not null,
	gender varchar(3) check gender in ('男','女'),
	age int not null
)

insert into user(id,name,gender,age) values(10,'tom','男',20);

limit 5,5
```


#### 优化


mysql 启动、配置文件、编码


mysql 底层原理

逻辑分层
存储引擎

sql解析过程
B树和索引

sql优化和索引的关系

单表优化

多表优化


避免索引失效

常规优化方法

慢查询sql排查
慢查询阀值和mysqldumpslow工具
模拟并通过profiles分析海量数据

全局查询日志

锁机制

查询行锁

主从同步
原理
示例



