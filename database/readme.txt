

实现业务功能，要懂基本的SQL语句；

性能优化，索引、引擎就要摸透；

想分库分表，主从同步机制、读写分离必须得了解；

安全方面，你得知道权限、备份、日志等等；

涉及到云数据库，就得懂源码及瓶颈。


SQL 左外连接，右外连接，全连接，内连接


内连接。（典型的连接运算，使用像   =   或   <>   之类的比较运算符）。包括相等连接和自然连接。

隐式的内连接，没有INNER JOIN，形成的中间表为两个表的笛卡尔积。
SELECT student.name,score.code FROM student,score WHERE score.code=student.code;

显式的内连接，一般称为内连接，有INNER JOIN，形成的中间表为两个表经过ON条件过滤后的笛卡尔积。
SELECT student.name,score.codeFROM student INNER JOIN score ON score.code=student.code;


等值连接
1.必须要有等值的条件 表1.列1 = 表2.列2
2.当条件不同时连接的结果也不相同
3.两个关系可以没有相同的属性列

将两个表中符合条件的每一对行记录拼接成一条行记录，


自然连接 natural join
1.必须要有相同的属性列才能进行 表1.列1 = 表2.列1 AND 表1.列2 = 表2.列2
2.不用指定连接列，也不能使用ON语句，它默认比较两张表里所有相同的列  `SELECT * FROM student NATURAL JOIN score;`
3.等值连接之后要去除相同的属性列

将两个表中符合条件的每一对行记录拼接成一条行记录，去除所有相同的属性列




外连接。外连接可以是左向外连接、右向外连接或完整外部连接。 

左外连接 left [outer] join
返回指定左表的全部行+右表对应的行，如果左表中数据在右表中没有与其相匹配的行，则在查询结果集中显示为空值。 

右外连接 right [outer] join
是左外连接的反向连接

全外连接 full [outer] join
把左右两表进行自然连接，左表在右表没有的显示NULL，右表在左表没有的显示NULL。（MYSQL不支持全外连接，适用于Oracle和DB2。）


交叉连接 cross join 
交叉连接返回左表中的所有行，左表中的每一行与右表中的所有行组合。没有任何限制条件的连接。交叉连接也称作笛卡尔积。

SELECT student.name,score.code FROM student CROSS JOIN score; 
SELECT student.name,score.code FROM student, score; 







联合查询 union 与 union all







数据类型         存储  范围
tinyint        1 字节 0-255
smallint       2 字节 -2^15 (-32,768) 到 2^15-1 (32,767)
int            4 字节 -2^31 (-2,147,483,648) 到 2^31-1 (2,147,483,647)
bigint         8 字节 -2^63 (-9,223,372,036,854,775,808) 到 2^63-1 (9,223,372,036,854,775,807)



int(M) 在 integer 数据类型中，M 表示最大显示宽度。





































































