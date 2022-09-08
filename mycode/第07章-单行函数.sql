#第七章-单行函数
SELECT last_name,salary,CASE WHEN salary >= 15000 THEN '高薪'
							WHEN salary >= 10000 THEN '次高薪'
							WHEN salary >= 6000  THEN '中薪'
							ELSE '低薪' 
							END 
							AS "薪酬等级"
FROM employees
ORDER BY salary DESC;
#练习：查询部门号为 10,20, 30 的员工信息,  
#若部门号为 10,则打印其工资的 1.1 倍, 
#若部门号为 20,则打印其工资的 1.2 倍, 
#若部门号为 30,则打印其工资的 1.3 倍数。 

SELECT last_name,department_id,salary,	CASE 
										WHEN department_id = 10 THEN salary * 1.1
										WHEN department_id = 20 THEN salary * 1.2
										WHEN department_id = 30 THEN salary * 1.3
										END AS "salary"
FROM employees
WHERE department_id IN (10,20,30)
ORDER BY department_id DESC;

# 1.显示系统时间(注：日期+时间) 
SELECT NOW()
FROM DUAL;

# 2.查询员工号，姓名，工资，以及工资提高百分之20%后的结果（new salary）
SELECT last_name,salary,salary * 1.2 AS "new salary"
FROM employees;

# 3.将员工的姓名按首字母排序，并写出姓名的长度（length）
SELECT last_name,ASCII(last_name),LENGTH(last_name)
FROM employees
ORDER BY last_name;
 
# 4.查询员工id,last_name,salary，并作为一个列输出，别名为OUT_PUT 
SELECT CONCAT(employee_id,' ',last_name,' ',salary) AS "out_put"
FROM employees;

# 5.查询公司各员工工作的年数、工作的天数，并按工作年数的降序排序
SELECT TRUNCATE(DATEDIFF(NOW(),hire_date) / 365 , 1) AS "day"
FROM employees
ORDER BY `day`DESC;
 
# 6.查询员工姓名，hire_date , department_id，满足以下条件：
#	雇用时间在1997年之后，department_id 为80 或 90 或110, commission_pct不为空 
SELECT last_name,hire_date,department_id
FROM employees
WHERE 	hire_date >= '1997-01-01' 
		AND department_id IN (80,90,110)
		AND commission_pct IS NOT NULL;


# 7.查询公司中入职超过10000天的员工姓名、入职时间 
SELECT last_name,hire_date,DATEDIFF(NOW(),hire_date)
FROM employees
WHERE DATEDIFF(NOW(),hire_date) >= 10000;

# 8.做一个查询，产生下面的结果 
#<last_name> earns <salary> monthly but wants <salary*3> 
SELECT CONCAT(last_name,' earns ',salary,' monthly but wants ',salary * 3) AS "details"
FROM employees;

# 9.使用case-when，按照下面的条件： 
/*
job grade 
AD_PRES A 
ST_MAN B 
IT_PROG C 
SA_REP D 
ST_CLERK E 
*/
SELECT last_name,job_id,	CASE job_id
				WHEN 'AD_PRES' 	THEN 'A'
				WHEN 'ST_MAN' 	THEN 'B'
				WHEN 'IT_PROG' 	THEN 'C'
				WHEN 'SA_REP' 	THEN 'D'
				WHEN 'ST_CLERK' THEN 'E'
				ELSE 'F'
				END AS "job grade"
FROM employees;


