#第06章——多表查询
DESC employees;
DESC departments;
DESC locations;

#查询员工名为'Abel'的人再哪个城市工作
SELECT *
FROM employees
WHERE last_name = 'Abel';

SELECT *
FROM departments
WHERE department_id = 80;

SELECT *
FROM locations
WHERE location_id = 2500;

#多表查询的实现

#错误的方式
SELECT employee_id,department_name
FROM employees,departments;

#正确方式
SELECT employee_id,department_name
FROM employees,departments
WHERE employees.`department_id` = departments.`department_id`;

SELECT employee_id,department_name,employees.`department_id`
FROM employees,departments
WHERE employees.`department_id` = departments.`department_id`;


#可以给表起别名，如果给表起了别名，则必须使用别名
SELECT emp.employee_id,dept.department_name,emp.`department_id`
FROM employees emp,departments dept
WHERE emp.`department_id` = dept.`department_id`;


#查找员工employee_id,last_name,department_id,city
SELECT emp.`employee_id`,emp.`last_name`,dpm.`department_id`,lct.`city`
FROM employees emp,departments dpm,locations lct
WHERE 	emp.`department_id` = dpm.`department_id` AND 
	dpm.`location_id` = lct.`location_id`;

#多表查询的分类
/*
角度1：等值连接 vs 非等值连接

角度2：自连接 vs 非自连接

角度3：内连接 vs 外连接
*/

#非等值连接的例子
SELECT e.last_name,e.`salary`,j.`grade_level`
FROM employees e,job_grades j
WHERE e.`salary` BETWEEN j.`lowest_sal` AND j.`highest_sal`
ORDER BY salary DESC
LIMIT 0,20;

#自连接
SELECT emp.`employee_id`,emp.`last_name`,mgr.`employee_id`,mgr.`last_name`
FROM employees emp,employees mgr
WHERE emp.`manager_id` = mgr.`employee_id`;

#内连接 vs 外连接
SELECT	employee_id,department_name
FROM employees,departments
WHERE employees.`department_id` = departments.`department_id`;

#sql92语法实现外连接 ：使用 +  （mysql不支持）
SELECT employee_id,department_name
FROM employees,departments
WHERE employees.`department_id` = departments.`department_id`(+);

#sql99语法使用join ...on的方式实现多表查询。（mysql支持）

#sql99语法实现内连接
SELECT employee_id,department_name,city
FROM employees JOIN departments
ON employees.`department_id` = departments.`department_id`
JOIN locations
ON departments.`location_id` = locations.`location_id`;

#sql99语法实现外连接

#左外连接
SELECT employee_id,department_name
FROM employees LEFT JOIN departments
ON employees.`department_id` = departments.`department_id`;

#右外连接
SELECT employee_id,department_name
FROM employees RIGHT JOIN departments
ON employees.`department_id` = departments.`department_id`;

#满外连接(mysql不支持)
SELECT employee_id,department_name
FROM employees FULL OUTER JOIN departments
ON employees.`department_id` = departments.`department_id`;

SELECT employee_id,department_name,employees.department_id
FROM employees LEFT JOIN departments
ON employees.`department_id` = departments.`department_id`
WHERE employees.`department_id` IS NULL
UNION ALL
SELECT employee_id,department_name,employees.department_id
FROM employees RIGHT JOIN departments
ON employees.`department_id` = departments.`department_id`;


# 1.显示所有员工的姓名，部门号和部门名称。 
SELECT last_name,employees.`department_id`,departments.`department_name`
FROM employees LEFT JOIN departments
ON employees.`department_id` = departments.`department_id`;

SELECT last_name, e.department_id, department_name 
FROM employees e 
LEFT OUTER JOIN departments d 
ON e.`department_id` = d.`department_id`; 


# 2.查询90号部门员工的job_id和90号部门的location_id
SELECT job_id,departments.`department_id`,departments.`location_id`
FROM employees,departments
WHERE departments.`department_id` = 90 AND employees.`department_id` = 90;
 
SELECT job_id, location_id 
FROM employees e, departments d 
WHERE e.`department_id` = d.`department_id` 
AND e.`department_id` = 90; 
 
 
# 3.选择所有有奖金的员工的 last_name , department_name , location_id , city 
SELECT last_name,commission_pct,department_name,locations.location_id,city
FROM employees LEFT JOIN departments
ON employees.`department_id` = departments.`department_id`
LEFT JOIN locations 
ON departments.`location_id` = locations.`location_id`
WHERE employees.`commission_pct` IS NOT NULL;


SELECT last_name , department_name , d.location_id , city 
FROM employees e 
LEFT OUTER JOIN departments d 
ON e.`department_id` = d.`department_id` 
LEFT OUTER JOIN locations l 
ON d.`location_id` = l.`location_id` 
WHERE commission_pct IS NOT NULL; 


# 4.选择city在Toronto工作的员工的 last_name , job_id , department_id , department_name 
SELECT employees.`last_name`,employees.`job_id`,employees.`department_id`,departments.`department_name`
FROM employees JOIN departments
ON employees.`department_id` = departments.`department_id`
JOIN locations
ON departments.`location_id` = locations.`location_id`
WHERE city = 'Toronto';

SELECT last_name , job_id , e.department_id , department_name 
FROM employees e, departments d, locations l 
WHERE e.`department_id` = d.`department_id` 
AND d.`location_id` = l.`location_id` 
AND city = 'Toronto'; 


# 5.查询员工所在的部门名称、部门地址、姓名、工作、工资，其中员工所在部门的部门名称为’Executive’
SELECT	departments.`department_name`,locations.`city`,employees.`last_name`,
	employees.`job_id`,employees.`salary`
FROM employees,departments,locations
WHERE employees.`department_id` = departments.`department_id` 
AND departments.`department_name` = 'Executive'
AND departments.`location_id` = locations.`location_id`;

SELECT department_name, street_address, last_name, job_id, salary 
FROM employees e JOIN departments d 
ON e.department_id = d.department_id 
JOIN locations l 
ON d.`location_id` = l.`location_id` 
WHERE department_name = 'Executive' ;


 
# 6.选择指定员工的姓名，员工号，以及他的管理者的姓名和员工号，结果类似于下面的格式 
#employees Emp# manager Mgr# 
#kochhar 101 king 100 

SELECT employees.`last_name` "employees",
employees.`employee_id` "Emp#",
mgr.`last_name`"manager",
employees.`manager_id` "Mgr#"
FROM employees LEFT JOIN employees mgr 
ON employees.`manager_id` = mgr.`employee_id`;

SELECT emp.last_name employees, emp.employee_id "Emp#", mgr.last_name manager, 
mgr.employee_id "Mgr#" 
FROM employees emp 
LEFT OUTER JOIN employees mgr 
ON emp.manager_id = mgr.employee_id;



# 7.查询哪些部门没有员工 
select departments.`department_name`
from employees right join departments
on employees.`department_id` = departments.`department_id`
where employees.`employee_id` is null;

SELECT d.department_id 
FROM departments d LEFT JOIN employees e 
ON e.department_id = d.`department_id` 
WHERE e.department_id IS NULL ;


# 8. 查询哪个城市没有部门 
select departments.`department_id`,city
from departments right join locations
on departments.`location_id` = locations.`location_id`
where departments.`location_id` is null;

SELECT l.location_id,l.city 
FROM locations l LEFT JOIN departments d 
ON l.`location_id` = d.`location_id` 
WHERE d.`location_id` IS NULL ;


# 9. 查询部门名为 Sales 或 IT 的员工信息 
select employee_id,last_name,employees.`department_id`,departments.`department_name`
from employees join departments
on departments.`department_name` in('Sales','IT')
and departments.`department_id` = employees.`department_id`;


SELECT employee_id,last_name,department_name 
FROM employees e,departments d 
WHERE e.department_id = d.`department_id` 
AND d.`department_name` IN ('Sales','IT'); 









