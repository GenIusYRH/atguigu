#第05章_排序与分页
#1.排序
SELECT *
FROM employees;

#按salary从高到低显示员工信息
#升序ASC(ascend) 降序DESC(descend)
SELECT *
FROM employees
ORDER BY salary DESC;

#二级排序
SELECT employee_id,email,salary,department_id
FROM employees
ORDER BY department_id DESC,salary DESC;


#2. 分页
#mysql使用limit实现分页显示
SELECT * 
FROM employees
LIMIT 10,10;


#查询工资最高的员工信息
SELECT * 
FROM employees
ORDER BY salary DESC
LIMIT 0,1;

#1. 查询员工的姓名和部门号和年薪，按年薪降序,按姓名升序显示 
SELECT first_name,last_name,department_id,salary * IFNULL( 1 + commission_pct,1) * 12 "年薪"
FROM employees
ORDER BY 年薪 DESC,first_name ASC;

#2. 选择工资不在 8000 到 17000 的员工的姓名和工资，按工资降序，显示第21到40位置的数据 
SELECT last_name,salary
FROM employees
WHERE salary NOT BETWEEN 8000 AND 17000
ORDER BY salary DESC
LIMIT 20,20;

#3. 查询邮箱中包含 e 的员工信息，并先按邮箱的字节数降序，再按部门号升序 
SELECT *
FROM employees
WHERE email LIKE '%e%'
ORDER BY LENGTH(email) DESC,department_id ASC;



