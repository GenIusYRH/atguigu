#第08章-聚合函数
SELECT AVG(salary),SUM(salary),MAX(salary),MIN(salary)
FROM employees;

SELECT * , 1
FROM employees;

SELECT AVG(IFNULL(commission_pct,0))
FROM employees;

SELECT department_id,salary,AVG(salary)
FROM employees
GROUP BY department_id WITH ROLLUP;

SELECT department_id AS "id",MAX(salary) "max" 
FROM employees
GROUP BY department_id
HAVING `max` > 10000;


#1.where子句可否使用组函数进行过滤? 不可

#2.查询公司员工工资的最大值，最小值，平均值，总和
SELECT MAX(salary),MIN(salary),AVG(salary),SUM(salary)
FROM employees; 

#3.查询各job_id的员工工资的最大值，最小值，平均值，总和
SELECT job_id,MAX(salary),MIN(salary),AVG(salary),SUM(salary)
FROM employees
group by job_id; 
 
#4.选择具有各个job_id的员工人数
select job_id,count(1)
from employees
group by job_id; 


# 5.查询员工最高工资和最低工资的差距（DIFFERENCE）
select max(salary) - min(salary) as "DIFFERENCE"
from employees;

# 6.查询各个管理者手下员工的最低工资，其中最低工资不能低于6000，没有管理者的员工不计算在内
select manager_id,min(salary) as "minSalary"
from employees
where manager_id is no null
group by manager_id
having minSalary >= 6000;
 
# 7.查询所有部门的名字，location_id，员工数量和平均工资，并按平均工资降序 
select departments.`department_name`,departments.`location_id`,count(employee_id),avg(salary) as "avgSalary"
from employees right join departments
on employees.`department_id` = departments.`department_id`
group by departments.`department_id`,departments.`location_id`
order by avgSalary desc;

# 8.查询每个工种、每个部门的部门名、工种名和最低工资 












