#第13章-约束

CREATE DATABASE IF NOT EXISTS dbtest;

USE dbtest;

CREATE TABLE IF NOT EXISTS test1 (
	id INT NOT NULL UNIQUE,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(50) UNIQUE,
	salary DECIMAL(10,2)
);

DESC test1;

CREATE DATABASE test04_emp; 

USE test04_emp; 

CREATE TABLE emp2( 
id INT, 
emp_name VARCHAR(15) 
);

CREATE TABLE dept2( 
id INT, 
dept_name VARCHAR(15) 
);

#1.向表emp2的id列中添加PRIMARY KEY约束 
alter table emp2
modify id int primary key;

desc emp2;

#2. 向表dept2的id列中添加PRIMARY KEY约束 
alter table dept2
modify id int primary key;

desc dept2;

#3. 向表emp2中添加列dept_id，
#	并在其中定义FOREIGN KEY约束，与之相关联的列是dept2表中的id列。 
alter table emp2
add dept_id int;

alter table emp2
add constraint fk foreign key(dept_id) references dept2(id);

#练习二
# 1、创建数据库test01_library 
drop database test02_library;

use test01_library;

# 2、创建表 books，表结构如下： 



# 3、使用ALTER语句给books按如下要求增加相应的约束 

alter table books
modify id int primary key auto_increment;

alter table books
modify `name` varchar(50) not null;

desc books;

#练习三
#1. 创建数据库test04_company 
create database if not exists test04_company;

#2. 按照下表给出的表结构在test04_company数据库中创建两个数据表offices和employees 
create table if not exists offices (
	officeCode int(10) primary key,
	city varchar(50) not null,
	address varchar(50),
	country varchar(50) not null,
	postalCode varchar(15) unique
);

create table if not exists employees (
	employeeNumber int(11) primary key auto_increment,
	lastName varchar(50) not null,
	firstName varchar(50) not null,
	mobile varchar(25) unique,
	officeCode int(10) not null,
	jobTitle varchar(50) not null,
	birth datetime not null,
	note varchar(255),
	sex varchar(5),
	constraint fk_employees_offices FOREIGN KEY(officeCode) REFERENCES offices(officeCode)
);

#3. 将表employees的mobile字段修改到officeCode字段后面 
select *
from employees;
desc employees;

alter table employees
modify mobile varchar(25) after officeCode;

#4. 将表employees的birth字段改名为employee_birth 
alter table employees
change birth employee_birth datetime;

alter table employees
modify employee_birth datetime not null;

#5. 修改sex字段，数据类型为CHAR(1)，非空约束 
alter table employees
modify sex char(1) not null;

desc employees;

#6. 删除字段note 
alter table employees
drop note;

#7. 增加字段名favoriate_activity，数据类型为VARCHAR(100) 
alter table employees
add favoriate_acticity varchar(100);

#8. 将表employees名称修改为employees_info
rename table employees to employees_info;











