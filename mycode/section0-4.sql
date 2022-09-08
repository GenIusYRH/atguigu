USE atguigudb;

SELECT *
FROM employees;

SELECT employee_id, last_name AS NAME,email, salary * 12 AS "man money"
FROM employees;

SELECT DISTINCT department_id
FROM employees;

#NULL参与运算，结果都为NULL
SELECT employee_id,salary * (1 + IFNULL(commission_pct,0)) * 12 "年工资",commission_pct
FROM employees;

#着重号,为了避免与关键字冲突
SELECT * 
FROM `order`;


#常数查询
SELECT 123,employee_id,salary
FROM employees;

#显示表结构,显示了表中字段的详细信息 describe
DESCRIBE employees;

#过滤条件
SELECT *
FROM employees
WHERE department_id = 80;

#字符串用''单引号
SELECT * 
FROM employees
WHERE last_name = 'King';

# 1.查询员工12个月的工资总和，并起别名为ANNUAL SALARY 
SELECT salary * 12 * (1 + IFNULL(commission_pct,0)) "ANNUAL SALARY"
FROM employees;

# 2.查询employees表中去除重复的job_id以后的数据 
SELECT DISTINCT job_id
FROM employees;

# 3.查询工资大于12000的员工姓名和工资
SELECT first_name,last_name,salary
FROM employees
WHERE salary > 12000;

# 4.查询员工号为176的员工的姓名和部门号
SELECT first_name,last_name,department_id
FROM employees
WHERE employee_id = 176;

# 5.显示表 departments 的结构，并查询其中的全部数据
DESCRIBE departments;
SELECT *
FROM departments;

SELECT 1 <=> 'a', 1 = '1','a' = 0,0 = 'b'
FROM DUAL;

SELECT 1 != NULL
FROM DUAL;

SELECT *
FROM employees
WHERE NOT commission_pct <=> NULL;

SELECT *
FROM employees
WHERE salary BETWEEN 10000 AND 12000;

SELECT *
FROM employees
WHERE salary < 10000 || salary > 12000;

SELECT last_name
FROM employees
WHERE last_name LIKE '%a%' && last_name LIKE '%e%';


SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

# 1.选择工资不在5000到12000的员工的姓名和工资 
SELECT * 
FROM employees
WHERE NOT salary BETWEEN 5000 AND 12000;

# 2.选择在20或50号部门工作的员工姓名和部门号 
SELECT department_id
FROM employees
WHERE department_id = 20 || department_id = 50;

# 3.选择公司中没有管理者的员工姓名及job_id 
SELECT first_name,last_name,job_id
FROM employees
WHERE manager_id IS NULL;

# 4.选择公司中有奖金的员工姓名，工资和奖金级别
SELECT last_name,salary,commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;
 
# 5.选择员工姓名的第三个字母是a的员工姓名
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';
 
# 6.选择姓名中有字母a和k的员工姓名
SELECT last_name
FROM employees
WHERE last_name LIKE '%a%' && last_name LIKE '%k%';
 
# 7.显示出表 employees 表中 first_name 以 'e'结尾的员工信息
SELECT first_name
FROM employees
WHERE first_name LIKE '%e';
 
# 8.显示出表 employees 部门编号在 80-100 之间的姓名、工种
SELECT first_name,last_name,job_id
FROM employees
WHERE department_id BETWEEN 80 AND 100;
 
# 9.显示出表 employees 的 manager_id 是 100,101,110 的员工姓名、工资、管理者id 
SELECT first_name,last_name,salary,manager_id
FROM employees
WHERE manager_id IN (100,101,110);

DESCRIBE employees;








