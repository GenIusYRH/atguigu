#第09章-子查询
SELECT last_name,salary
FROM employees
WHERE salary > (
	SELECT salary
	FROM employees
	WHERE last_name = 'Abel'
);

SELECT employee_id,salary
FROM employees
WHERE salary > (
	SELECT salary
	FROM employees
	WHERE employee_id = 149
);

SELECT last_name,job_id,salary
FROM employees
WHERE job_id = (
	SELECT job_id
	FROM employees
	WHERE employee_id = 141
) AND salary > (
	SELECT salary
	FROM employees
	WHERE employee_id = 143
);

SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
);

SELECT employee_id, manager_id, department_id
FROM employees
WHERE employee_id != 141
AND manager_id = (
	SELECT manager_id
	FROM employees
	WHERE employee_id = 141
) 
AND department_id = (
	SELECT department_id
	FROM employees
	WHERE employee_id = 141
) 
OR employee_id != 174 
AND manager_id = (
	SELECT manager_id
	FROM employees
	WHERE employee_id = 174
) 
AND department_id = (
	SELECT department_id
	FROM employees
	WHERE employee_id = 174
);

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary)
	FROM employees
	WHERE department_id = 50
	GROUP BY department_id
);

SELECT 	employee_id,last_name, CASE department_id 
									WHEN (
										SELECT department_id
										FROM departments
										WHERE location_id = 1800	
									) THEN 
										"Canada"
									ELSE 
										"USA"
								END AS "location"
FROM employees;


SELECT last_name,e1.salary,e1.department_id
FROM employees e1,
	(
		SELECT employees.department_id,AVG(salary) AS `salary`
		FROM employees
		GROUP BY department_id
	) e2
WHERE e1.`department_id` = e2.department_id
AND e1.`salary` > e2.salary ;

select employee_id,last_name,job_id
from employees
where employee_id in (
		select employee_id
		from job_history
		group by employee_id
		having count(1) >= 2
	);

select e2.employee_id, e2.last_name, e2.job_id, e2.department_id
from employees e1,employees e2
where e1.`manager_id` = e2.`employee_id`
group by e2.employee_id, e2.last_name, e2.job_id, e2.department_id;

select departments.department_id, departments.department_name
from departments left join employees
on employees.`department_id` = departments.`department_id`
where employees.`department_id` is null;
	
select d.`department_id`, d.`department_name`
from departments d
where not exists (
		select * 
		from employees e
		where d.`department_id` = e.`department_id`
	);


#1.查询和Zlotkey相同部门的员工姓名和工资 
select last_name, salary
from employees
where department_id = (
		select department_id
		from employees
		where last_name = 'Zlotkey'
	);

#2.查询工资比公司平均工资高的员工的员工号，姓名和工资。 
select employee_id, last_name, salary
from employees
where salary > (
		select avg(salary)
		from employees
	);

#3.选择工资大于所有JOB_ID = 'SA_MAN'的员工的工资的员工的last_name, job_id, salary 
select last_name, job_id, salary
from employees
where salary > (
		select max(salary)
		from employees
		WHERE job_id = 'SA_MAN'
			);

#4.查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名 
select employee_id, last_name
from employees
where department_id in (
		select distinct department_id
		from employees
		where last_name like '%u%'
	);
	
#5.查询在部门的location_id为1700的部门工作的员工的员工号 
select employees.`employee_id`
from employees,departments
where employees.`department_id` = departments.`department_id`
and departments.`location_id` = 1700;

#6.查询管理者是King的员工姓名和工资 
select last_name, salary
from employees
where manager_id in (
		select employee_id
		from employees
		where last_name = 'King'
	)
and last_name != 'King';

#7.查询工资最低的员工信息: last_name, salary 
select last_name, salary
from employees
where salary <= all (
		select salary
		from employees
	);

#8.查询平均工资最低的部门信息 
select departments.*
from departments,employees
where employees.`department_id` = departments.`department_id`
group by employees.`department_id`
having avg(employees.salary) <= all (
		select avg(employees.`salary`)
		from employees
		group by department_id
	);


#9.查询平均工资最低的部门信息和该部门的平均工资（相关子查询） 
SELECT departments.*,AVG(employees.salary) as "AVG_salary"
FROM departments,employees
WHERE employees.`department_id` = departments.`department_id`
GROUP BY employees.`department_id`
HAVING AVG(employees.salary) <= ALL (
		SELECT AVG(employees.`salary`)
		FROM employees
		GROUP BY department_id
	);



#10.查询平均工资最高的 job 信息 
select job_id, AVG(salary) as "maxSalary"
from employees
group by job_id
having avg(salary) >= all (
		select avg(salary)
		from employees
		group by job_id
	);


#11.查询平均工资高于公司平均工资的部门有哪些? 
select department_id
from employees
WHERE department_id IS NOT NULL
group by department_id
having avg(salary) >= all (
		select avg(salary)
		from employees
	);

#12.查询出公司中所有 manager 的详细信息 
select e2.*
from employees e1,employees e2
where e1.`manager_id` = e2.`employee_id`
group by e2.employee_id;


#13.各个部门中 最高工资中最低的那个部门的 最低工资是多少? 
select min(salary)
from employees
group by department_id
having max(salary) <= all (
		select max(salary)
		from employees
		group by department_id
	);



#14.查询平均工资最高的部门的 manager 的详细信息:
# last_name, department_id, email, salary
select e.*
from employees e ,departments d
where e.`department_id` = d.`department_id`
and e.`employee_id` = d.`manager_id`
group by e.`department_id`
having avg(salary) >= all (
		select avg(salary)
		from employees
		group by department_id
	);

SELECT employee_id,last_name, department_id, email, salary 
FROM employees 
WHERE employee_id IN (
SELECT DISTINCT manager_id 
FROM employees 
WHERE department_id = ( 
SELECT department_id 
FROM employees e 
GROUP BY department_id 
HAVING AVG(salary)>=ALL( 
SELECT AVG(salary) 
FROM employees 
GROUP BY department_id 
) 
) 
); 


#15. 查询部门的部门号，其中不包括job_id是"ST_CLERK"的部门号 
select d.department_id
from employees e1 right join departments d
on e1.`department_id` = d.`department_id`
group by d.`department_id`;

SELECT department_id 
FROM departments d 
WHERE department_id NOT IN ( 
SELECT DISTINCT department_id 
FROM employees 
WHERE job_id = 'ST_CLERK' 
);

#16. 选择所有没有管理者的员工的last_name 
select last_name
from employees
where manager_id is null;

SELECT last_name 
FROM employees e1 
WHERE NOT EXISTS ( 
SELECT * 
FROM employees e2 
WHERE e1.manager_id = e2.employee_id 
); 


#17．查询员工号、姓名、雇用时间、工资，其中员工的管理者为 'De Haan' 
select e2.*
from employees e1,employees e2
where e1.`employee_id` = e2.`manager_id`
and e1.`last_name` = 'De Haan';

SELECT employee_id, last_name, hire_date, salary 
FROM employees 
WHERE manager_id = ( 
SELECT employee_id 
FROM employees 
WHERE last_name = 'De Haan' 
);


#18.查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资（相关子查询）
select e1.employee_id,e1.last_name,e1.salary
from employees e1
where salary > all (
		select department_id,avg(salary)
		from employees
		#where e1.`department_id` = department_id
		group by department_id
	)
order by employee_id
limit 30,10;

SELECT employee_id,last_name,salary 
FROM employees e1 
WHERE salary > all ( 
# 查询某员工所在部门的平均 
SELECT AVG(salary) 
FROM employees e2 
WHERE e2.department_id = e1.`department_id` 
)
ORDER BY employee_id
LIMIT 30,10;

select * 
from employees
where employee_id;

	
	

#19.查询每个部门下的部门人数大于 5 的部门名称（相关子查询） 
select departments.`department_name`
from departments, employees
where departments.`department_id` = employees.`department_id`
group by employees.`department_id`
having count(1) > 5;

SELECT department_name,department_id 
FROM departments d 
WHERE 5 < ( 
SELECT COUNT(*) 
FROM employees e 
WHERE d.`department_id` = e.`department_id` 
);

#20.查询每个国家下的部门个数大于 2 的国家编号（相关子查询）
select locations.`country_id`
from locations, departments
where departments.`location_id` = locations.`location_id`
group by departments.`location_id`
having count(1) > 2;

SELECT country_id 
FROM locations l 
WHERE 2 < ( 
SELECT COUNT(*) 
FROM departments d 
WHERE l.`location_id` = d.`location_id` 
);







