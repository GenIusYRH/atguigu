#第16章-变量、流程控制与游标

SHOW GLOBAL VARIABLES;

SHOW SESSION VARIABLES;

SHOW GLOBAL VARIABLES LIKE 'admin_%';

SET @name = 'yrh';

SELECT @name;


#0.准备工作 
CREATE DATABASE test16_var_cur; 
USE test16_var_cur; 
CREATE TABLE employees 
AS
SELECT * FROM atguigudb.`employees`; 
CREATE TABLE departments 
AS
SELECT * FROM atguigudb.`departments`; 
#无参有返回 
#1. 创建函数get_count(),返回公司的员工个数
DELIMITER !
CREATE FUNCTION get_count()
RETURNS INT
BEGIN
	DECLARE `sum` INT;
	SELECT COUNT(1) INTO `sum`
	FROM employees;
	RETURN `sum`;
END !
DELIMITER ;

SELECT get_count();

DROP FUNCTION get_count;
#有参有返回 
#2. 创建函数ename_salary(),根据员工姓名，返回它的工资 
DESC employees;

DELIMITER !
CREATE FUNCTION 
	ename_salary(`name` VARCHAR(20))
	RETURNS DOUBLE(8,2)
BEGIN
	DECLARE ret_salary DOUBLE(8,2);

	SELECT salary INTO ret_salary
	FROM employees
	WHERE last_name = `name`;
	
	RETURN ret_salary;
END !
DELIMITER ;

SELECT *
FROM employees;

SELECT ename_salary('Abel');

DROP FUNCTION ename_salary;
#3. 创建函数dept_sal() ,根据部门名，返回该部门的平均工资 
DELIMITER !
CREATE FUNCTION
	dept_sal(dept_name VARCHAR(20))
	RETURNS DOUBLE 
BEGIN
	DECLARE dept_id INT;
	DECLARE dept_avg_sal DOUBLE;
	
	SELECT department_id INTO dept_id
	FROM departments
	WHERE department_name = dept_name;
	
	SELECT AVG(salary) INTO dept_avg_sal
	FROM employees
	WHERE department_id = dept_id;
	
	RETURN dept_avg_sal;
	
END !
DELIMITER ;

SELECT *
FROM departments;

SELECT dept_sal('Marketing');


#4. 创建函数add_float()，实现传入两个float，返回二者之和 

DELIMITER !
CREATE FUNCTION 
	add_float(val1 FLOAT,val2 FLOAT)
	RETURNS FLOAT
BEGIN
	DECLARE `sum` FLOAT;
		
	SET `sum` = (val1 + val2);
	
	RETURN `sum`;
END !
DELIMITER ;

SELECT add_float(1.1,1.5);


#1. 创建函数test_if_case()，实现传入成绩，如果成绩>90,返回A，如果成绩>80,返回B，
#	如果成绩>60,返回C，否则返回D 
#	要求：分别使用if结构和case结构实现 
#方式一:
DELIMITER !
CREATE FUNCTION
	test_if_case(grade INT)
	RETURNS CHAR(1)
BEGIN
	DECLARE grade_level CHAR(1);
	IF grade > 90 THEN
		SET grade_level = 'A';
	ELSEIF grade > 80 THEN
		SET grade_level = 'B';
	ELSEIF grade > 60 THEN
		SET grade_level = 'C';
	END IF;
	RETURN grade_level;
END !
DELIMITER ;

SELECT test_if_case(85);

#方式二:
DELIMITER !
CREATE FUNCTION 
	test_if_case2(grade INT)
	RETURNS CHAR
BEGIN
	DECLARE grade_level CHAR;
	CASE WHEN grade > 60 
		THEN SET grade_level = 'C';
	WHEN grade > 80
		THEN SET grade_level = 'B';
	WHEN grade > 90
		THEN SET grade_level = 'A';
	END CASE;
	RETURN grade_level;
END ! 
DELIMITER ;

SELECT test_if_case2(76);




#2. 创建存储过程test_if_pro()，传入工资值，如果工资值<3000,则删除工资为此值的员工，
#如果3000 <= 工资值 <= 5000,则修改此工资值的员工薪资涨1000，否则涨工资500 

DELIMITER !
CREATE PROCEDURE
	test_if_pro(IN sal INT)
BEGIN
	DECLARE add_salary INT;
	IF sal < 3000
		THEN 
			DELETE FROM employees
			WHERE salary = sal;
	ELSEIF sal < 5000
		THEN SET add_salary = 1000;
	ELSE
		SET add_salary = 500;
	END IF;
	UPDATE employees
	SET salary = salary + add_salary
	WHERE salary = sal;
END !
DELIMITER ;


#3. 创建存储过程insert_data(),传入参数为 IN 的 INT 类型变量 insert_count,实现向admin表中批量插 
#入insert_count条记录 
CREATE TABLE admin( 
id INT PRIMARY KEY AUTO_INCREMENT, 
user_name VARCHAR(25) NOT NULL, 
user_pwd VARCHAR(35) NOT NULL 
);
SELECT * FROM admin; 

DELIMITER !
CREATE PROCEDURE
	insert_date(IN insert_count INT)
BEGIN
	DECLARE i INT;
	WHILE i < insert_count DO
		INSERT INTO admin(user_name,user_pwd)
		VALUES('a','123');
		SET i = i + 1;
	END WHILE;
	
END!
DELIMITER ;


#游标
DELIMITER !
CREATE PROCEDURE
	update_salary(IN dept_id INT,IN change_sal_count INT)
BEGIN
	DECLARE id INT;
	DECLARE hdate DATE;
	DECLARE i INT DEFAULT 0;
	DECLARE add_sal FLOAT;

	DECLARE emp_cursor CURSOR FOR 
	SELECT employee_id,hire_date
	FROM employees
	WHERE department_id = dept_id
	ORDER BY salary ASC;
		
	OPEN emp_cursor;
	
	WHILE i < change_sal_count DO
		FETCH emp_cursor INTO id,hdate;
		IF (YEAR(hdate) < 1995)
			THEN SET add_sal = 1.2;
		ELSEIF (YEAR(hdate) <= 1998)
			THEN SET add_sal = 1.15;
		ELSEIF (YEAR(hdate) <= 2001)
			THEN SET add_sal = 1.10;
		ELSEIF(YEAR(hdate) > 2001)
			THEN SET add_sal = 1.05;
		END IF;
			
		UPDATE employees
		SET salary = salary * add_sal
		WHERE employee_id = id;
		
		SET i = i + 1;
	END WHILE;
		
	CLOSE emp_cursor;
	
END !
DELIMITER ;




















































