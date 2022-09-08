#第11章-数据处理之增删改

USE atguigudb;
CREATE TABLE IF NOT EXISTS emp1(
	id INT,
	`name` VARCHAR(15),
	hire_date DATE,
	salary DOUBLE(10,2)
);
DESC emp1;

SELECT *
FROM emp1;

INSERT INTO emp1
VALUES(1,'Tom','2000-02-18',8000);

INSERT INTO emp1(id,`name`,salary,hire_date)
VALUE (1,'Han',7000,'2000-09-25');

INSERT INTO emp1(id,`name`,salary)
SELECT employee_id,last_name, salary
FROM employees
LIMIT 0,5;

UPDATE emp1
SET hire_date = CURDATE()
WHERE `name` = 'King';

select *
from emp1;

# 1、创建数据库test01_library 
create database if not exists test01_library;

use test01_library;
# 2、创建表 books，表结构如下： 
create table if not exists books (
	id int,
	`name` varchar(50),
	`authors` varchar(100),
	price float,
	pubdate year,
	note varchar(100),
	num int
);

drop table books;

# 3、向books表中插入记录
	# 1）不指定字段名称，插入第一条记录 
	DESC books;

	INSERT INTO books
	VALUES (1,'Tal of AAA','Dickes',23,'1995','novel',11);

	SELECT *
	FROM books;	
	# 2）指定所有字段名称，插入第二记录 
	insert into books(id,`name`,`authors`,price,pubdate,note,num)
	values(2,'EmmaT','Jane lura',35,1993,'joke',22);
	
	select *
	from books;
	
	
	# 3）同时插入多条记录（剩下的所有记录）
	insert into books(id,`name`,`authors`,price,pubdate,note,num)
	values 
	(3 ,'Story of Jane', 'Jane Tim', 40 ,2001,' novel', 0),
	(4 ,'Lovey Day',' George Byron', 20 ,2005,' novel', 30),
	(5 ,'Old land', 'Honore Blade', 30 ,2010 ,'law', 0),
	(6 ,'The Battle', 'Upton Sara', 30 ,1999, 'medicine', 40),
	(7 ,'Rose Hood', 'Richard haggard', 28 ,2008 ,'cartoon', 28);

# 4、将小说类型(novel)的书的价格都增加5。
select *
from books;

update books
set note = 'novel'
where note = ' novel';


update books
set price = price + 5
where note = 'novel';
 
# 5、将名称为EmmaT的书的价格改为40，并将说明改为drama。 
update books
set price = 40,note = 'drama'
where `name` = 'EmmaT';

select *
from books
where `name` = 'EmmaT';

# 6、删除库存为0的记录。
delete from books
where num = 0;

select *
from books;
 
# 7、统计书名中包含a字母的书 
select *
from books
where `name` like '%a%';

select *
from books;

# 8、统计书名中包含a字母的书的数量和库存总量 
select count(1),sum(num)
from books
where `name` like '%a%';

# 9、找出“novel”类型的书，按照价格降序排列 
select *
from books
where note = 'novel'
order by price desc;

# 10、查询图书信息，按照库存量降序排列，如果库存量相同的按照note升序排列 
select *
from books
order by num desc,note asc;

# 11、按照note分类统计书的数量
select count(*)
from (
select note
from books b
group by note
) bt;

# 12、按照note分类统计书的库存量，显示库存量超过30本的
select note,sum(num)
from books
group by note
having sum(num) >= 30;
 
select *
from books;
# 13、查询所有图书，每页显示5本，显示第二页 
select *
from books
limit 5,5;

# 14、按照note分类统计书的库存量，显示库存量最多的 
select note,sum(num)
from books
group by note
order by sum(num) desc
limit 0,1;


select max(b.max)
from (
	select sum(num) as `max`
	from books
	group by note
)b;

# 15、查询书名达到10个字符的书，不包括里面的空格 
select *
from books
where CHAR_LENGTH(REPLACE(NAME,' ','')) >= 10;

# 16、查询书名和类型，其中note值为novel显示小说，law显示法律
#	  ，medicine显示医药，cartoon显示卡通，joke显示笑话 
select name,case note when 'novel'		then '小说'
					  when 'law' 		then '法律'
					  when 'medicine' 	then '医药'
					  when 'cartoon' 	then '卡通'
					  when 'joke'		then '笑话'
			end as note
from books;

select *
from books;
# 17、查询书名、库存，其中num值超过30本的，
#	显示滞销，大于0并低于10的，显示畅销，为0的显示需要无货
select name,num,case 
				when num > 30 then '滞销'
				when num > 0 && num < 10 then '畅销'
				when num = 0 then '无货'
				else '正常'
				end "情况"
from books;
 
# 18、统计每一种note的库存量，并合计总量
select ifnull(note,'总量'),sum(num)
from books
group by note with rollup;
 
# 19、统计每一种note的数量，并合计总量
select ifnull(note,'总量'),count(*)
from books
group by note with rollup;
 
# 20、统计库存量前三名的图书
select *
from books
order by num desc
limit 0,3; 

# 21、找出最早出版的一本书
select *
from books
order by pubdate 
limit 0,1;
 
# 22、找出novel中价格最高的一本书
select *
from books
where note = 'novel'
order by price desc
limit 0,1;
 
# 23、找出书名中字数最多的一本书，不含空格
select *
from books
order by char_length(replace(name,' ','')) desc
limit 0,1;


#1. 创建数据库dbtest11 
CREATE DATABASE IF NOT EXISTS dbtest11 CHARACTER SET 'utf8'; 
#2. 运行以下脚本创建表my_employees 
USE dbtest11; 
CREATE TABLE my_employees( 
id INT(10), 
first_name VARCHAR(10), 
last_name VARCHAR(10), 
userid VARCHAR(10), 
salary DOUBLE(10,2) 
);
CREATE TABLE users( 
id INT, 
userid VARCHAR(10), 
department_id INT 
);
#3. 显示表my_employees的结构 
desc my_employees;

#4. 向my_employees表中插入下列数据 
insert into my_employees(id,first_name,last_name,userid,salary)
values 
(1,'patel','Ralph','Rpatel',895), 
(2,'Dancs','Betty','Bdancs',860), 
(3,'Biri','Ben','Bbiri',1100), 
(4,'Newman','Chad','Cnewman',750), 
(5,'Ropeburn','Audrey','Aropebur',1550)
;

#5. 向users表中插入数据 
insert into `users`
values
(1,'Rpatel',10), 
(2,'Bdancs',10), 
(3,'Bbiri',20), 
(4,'Cnewman',30), 
(5,'Aropebur',40);

#6. 将3号员工的last_name修改为“drelxer” 
select *
from my_employees;

update my_employees
set last_name = 'drelxer'
where id = 3;

#7. 将所有工资少于900的员工的工资修改为1000 
update my_employees
set salary = 1000
where salary <= 900;

SELECT *
FROM my_employees;

#8. 将userid为Bbiri的user表和my_employees表的记录全部删除 
delete users,my_employees
from users join my_employees
on users.userid = my_employees.userid
where users.userid = 'Bbiri';

#9. 删除my_employees、users表所有数据 
delete from my_employees;
delete from users;

#10. 检查所作的修正

#11. 清空表my_employees


#联系二
# 1. 使用现有数据库dbtest11 
# 2. 创建表格pet
create table if not exists pet (
	`name` varchar(20),
	`owner` varchar(20),
	species varchar(20),
	sex char(1),
	birth year,
	death year
);

# 3. 添加记录 
INSERT INTO pet VALUES('Fluffy','harold','Cat','f','2013','2010'); 
INSERT INTO pet(`name`,`owner`,species,sex,Birth) 
VALUES('Claws','gwen','Cat','m','2014'); 
INSERT INTO pet(`name`,species,sex,Birth) VALUES('Buffy','Dog','f','2009'); 
INSERT INTO pet(`name`,`owner`,species,sex,Birth) 
VALUES('Fang','benny','Dog','m','2000'); 
INSERT INTO pet VALUES('bowser','diane','Dog','m','2003','2009'); 
INSERT INTO pet(`name`,species,sex,birth) VALUES('Chirpy','Bird','f','2008'); 

select *
from pet;

# 4. 添加字段:主人的生日owner_birth DATE类型。 
alter table pet
add owner_birth date;

select *
from pet;

# 5. 将名称为Claws的猫的主人改为kevin 
update  pet
set `owner` = 'kevin'
where `name` = 'Claws';

select *
from pet;

# 6. 将没有死的狗的主人改为duck 
update pet
set `owner` = 'duck'
where death is null;


# 7. 查询没有主人的宠物的名字； 
select `name`
from pet
where `owner` is null;

select *
from pet;

# 8. 查询已经死了的cat的姓名，主人，以及去世时间；
select `name`,`owner`,death
from pet
where death is not null;
 
# 9. 删除已经死亡的狗 
delete from pet
where death is not null;


# 10. 查询所有宠物信息 
select *
from pet;




#练习三
# 1. 使用已有的数据库dbtest11 
# 2. 创建表employee，并添加记录
create table if not exists employee (
	id int,
	`name` varchar(20),
	sex varchar(10),
	tel varchar(20),
	addr varchar(50),
	salary double(10,2)
);

INSERT INTO employee(id,`name`,sex,tel,addr,salary)VALUES 
(10001,'张一一','男','13456789000','山东青岛',1001.58), 
(10002,'刘小红','女','13454319000','河北保定',1201.21), 
(10003,'李四','男','0751-1234567','广东佛山',1004.11), 
(10004,'刘小强','男','0755-5555555','广东深圳',1501.23), 
(10005,'王艳','男','020-1232133','广东广州',1405.16); 

select *
from employee;

# 3. 查询出薪资在1200~1300之间的员工信息。
select *
from employee
where salary between 1200 and 1300;
 
# 4. 查询出姓“刘”的员工的工号，姓名，家庭住址。
select *
from employee
where name like '刘%';
 
# 5. 将“李四”的家庭住址改为“广东韶关” 
update employee
set addr = '广东韶关'
where `name` = '李四';

select *
from employee;
# 6. 查询出名字中带“小”的员工 
select *
from employee
where name like '%小%';












