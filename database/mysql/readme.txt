



mysql查看当前用户有哪些数据库：
show databases;
打开数据库：
use ksmsq

查看当前数据库中有哪些表：
show tables;       // 相当于oracle (select * from tab)

create table user(
	id int primary key,
	name varchar(50) not null,
	gender varchar(3) check gender in ('男','女'),
	age int not null
)

insert into user(id,name,gender,age) values(10,'tom','男',20);

limit 5,5






